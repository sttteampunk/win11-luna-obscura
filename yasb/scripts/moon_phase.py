import math
import datetime
import json
import sys

if sys.platform == "win32":
    sys.stdout.reconfigure(encoding="utf-8")  # type: ignore


def get_accurate_moon_phase():
    # 1. Get current time in UTC
    now = datetime.datetime.now(datetime.timezone.utc)

    # 2. Convert to Julian Date (Epoch 1970-01-01 is JD 2440587.5)
    timestamp = now.timestamp()
    jd = 2440587.5 + (timestamp / 86400.0)

    # 3. Keplerian & Astronomical Constants (John Walker's Moontool)
    epoch = 2444238.5  # 1980 January 0.0
    elonge = 278.833540  # Sun ecliptic longitude at epoch
    elongp = 282.596403  # Sun ecliptic longitude at perigee
    eccent = 0.016718  # Eccentricity of Earth's orbit
    mmlong = 64.975464  # Moon mean longitude at epoch
    mmlongp = 349.383063  # Moon mean longitude at perigee
    mlnode = 151.950429  # Moon ascending node longitude at epoch  # noqa: F841

    def fixangle(a):
        return a - 360.0 * math.floor(a / 360.0)

    day = jd - epoch

    # 4. Calculate Sun's Position
    N = fixangle((360.0 / 365.242191) * day)
    M = fixangle(N + elonge - elongp)

    # Solve Kepler's equation for the Sun
    E = M
    while True:
        delta = E - (eccent * 180.0 / math.pi) * math.sin(math.radians(E)) - M
        if abs(delta) < 1e-6:
            break
        E -= delta / (1.0 - eccent * math.cos(math.radians(E)))

    Ec = 2.0 * math.degrees(
        math.atan(
            math.sqrt((1.0 + eccent) / (1.0 - eccent)) * math.tan(math.radians(E) / 2.0)
        )
    )
    lambdasun = fixangle(Ec + elongp)

    # 5. Calculate Moon's Position & Apply Solar Perturbations
    ml = fixangle(13.17639648 * day + mmlong)
    MM = fixangle(ml - 0.11140353 * day - mmlongp)

    # Eviction correction
    Ev = 1.2739 * math.sin(math.radians(2.0 * (ml - lambdasun) - MM))
    # Annual equation
    Ae = 0.1858 * math.sin(math.radians(M))
    # Correction term
    A3 = 0.37 * math.sin(math.radians(M))

    MmP = MM + Ev - Ae - A3
    # Equation of center correction
    mEc = 6.2886 * math.sin(math.radians(MmP))
    # Fourth correction term
    A4 = 0.214 * math.sin(math.radians(2.0 * MmP))

    lP = ml + Ev + mEc - Ae + A4
    # Variation correction
    V = 0.6583 * math.sin(math.radians(2.0 * (lP - lambdasun)))
    lPP = lP + V

    # 6. Compute Phase Angle (Elongation) and Precise Illumination
    age_deg = fixangle(lPP - lambdasun)
    illum_fraction = (1.0 - math.cos(math.radians(age_deg))) / 2.0
    illum_percent = f"{round(illum_fraction * 100)}%"

    # ==========================================================================
    # 7. High-Granularity 28-Stage Phase Mapping (Weather Icons Set)
    # ==========================================================================
    # Shift by 6.428 degrees to perfectly center the main quadrant phases
    phase_index = int(((age_deg + 6.42857) % 360) / 12.85714)

    # Complete 28-stage Nerd Font weather icon sequence (\ue393 to \ue3ae)
    moon_icons = [
        "\ue38d",  # 0: New Moon
        "\ue38e",
        "\ue38f",
        "\ue390",
        "\ue391",
        "\ue392",
        "\ue393",  # 1-6: Waxing Crescent
        "\ue394",  # 7: First Quarter
        "\ue395",
        "\ue396",
        "\ue397",
        "\ue398",
        "\ue399",
        "\ue39a",  # 8-13: Waxing Gibbous
        "\ue39b",  # 14: Full Moon
        "\ue39c",
        "\ue39d",
        "\ue39e",
        "\ue39f",
        "\ue3a0",
        "\ue3a1",  # 15-20: Waning Gibbous
        "\ue3a2",  # 21: Last Quarter
        "\ue3a3",
        "\ue3a4",
        "\ue3a5",
        "\ue3a6",
        "\ue3a7",
        "\ue3a8",  # 22-27: Waning Crescent
    ]

    # Map the generated index directly to readable descriptive strings
    if phase_index == 0:
        phase_name = "New Moon"
    elif 1 <= phase_index <= 6:
        phase_name = f"Waxing Crescent (Stage {phase_index})"
    elif phase_index == 7:
        phase_name = "First Quarter"
    elif 8 <= phase_index <= 13:
        phase_name = f"Waxing Gibbous (Stage {phase_index - 7})"
    elif phase_index == 14:
        phase_name = "Full Moon"
    elif 15 <= phase_index <= 20:
        phase_name = f"Waning Gibbous (Stage {phase_index - 14})"
    elif phase_index == 21:
        phase_name = "Last Quarter"
    else:
        phase_name = f"Waning Crescent (Stage {phase_index - 21})"

    phase_data = {
        "name": phase_name,
        "icon": moon_icons[phase_index],
        "illumination": illum_percent,
    }

    return phase_data


if __name__ == "__main__":
    print(json.dumps(get_accurate_moon_phase()))
