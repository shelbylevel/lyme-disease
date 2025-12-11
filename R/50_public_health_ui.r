# ==============================================================================
# PUBLIC HEALTH IMPACT MODULE - UI
# ==============================================================================

#' Public Health Impact Module UI
#'
#' @param id Module namespace ID
#'
#' @return A Shiny UI element
public_health_ui <- function(id) {
  ns <- NS(id)

  bslib::layout_column_wrap(
    width = 1,

    # Page header
    bslib::card(
      bslib::card_body(
        class = "p-4 text-center bg-light",
        h2("Public Health Implications", class = "mb-3"),
        h5(
          "Understanding the public health implications of a wider geographic distribution of Lyme disease",
          class = "text-muted fw-normal mb-0"
        )
      )
    ),

    # Economic burden
    bslib::card(
      full_screen = TRUE,
      bslib::card_header(
        class = "bg-primary text-white",
        icon("dollar-sign"),
        " Healthcare & Economic Burden"
      ),
      bslib::card_body(
        fluidRow(
          column(
            width = 8,
            p(
              "With larger numbers of people being exposed to ticks potentially carrying the bacteria, Lyme disease rates are likely to continue increasing. The cost to society is potentially quite large: in 2016 US dollars, the mean treatment cost was $1,200 for a case (median $240). For cases that become chronic, costs increase substantially. The estimated range of costs due to Lyme disease is $345–968 million USD (2016 US dollars)."
            ),
            tags$hr(),
            h4("Prevention & Early Action", class = "mt-3 text-primary"),
            tags$ul(
              tags$li(
                "Clear public health messaging on how to prevent tick bites"
              ),
              tags$li(
                "Guidance on how to handle a tick if a bite does occur"
              ),
              tags$li(
                "Education on the signs of Lyme disease to support early treatment"
              )
            )
          ),
          column(
            width = 4,
            bslib::value_box(
              title = "Mean Treatment Cost",
              value = "$1,200",
              showcase = icon("hand-holding-dollar"),
              theme = "danger",
              p("Per case (2016 USD)", class = "fs-7 mb-1")
            ),
            bslib::value_box(
              title = "Median Treatment Cost",
              value = "$240",
              showcase = icon("stethoscope"),
              theme = "warning",
              p("Per case (2016 USD)", class = "fs-7 mb-1")
            ),
            bslib::value_box(
              title = "Annual US Cost",
              value = "$345–968M",
              showcase = icon("sack-dollar"),
              theme = "info",
              p("Estimated total cost (2016 USD)", class = "fs-7 mb-1")
            )
          )
        )
      ),
      card_footer(
        "Source: ",
        popover(
          a("Hook (2022)", href = "javascript:void(0);"),
          markdown(
            "Hook, S. A., Jeon, S., Niesobecki, S. A., Hansen, A. P., Meek, J. I., Bjork, J. Hinckley, A. F. (2022). Economic Burden of Reported Lyme Disease in High-Incidence Areas, United States, 2014–2016. Emerging Infectious Diseases, 28(6), 1170-1179. [https://doi.org/10.3201/eid2806.211335](https://doi.org/10.3201/eid2806.211335"
          )
        )
      )
    )
  )
  # bslib::card(
  #   bslib::card_header(
  #     class = "bg-danger text-white",
  #     icon("dollar-sign"),
  #     " Healthcare & Economic Burden"
  #   ),
  #   bslib::card_body(
  #     fluidRow(
  #       column(
  #         width = 8,
  #         h5("Direct Medical Costs:"),
  #         tags$ul(
  #           tags$li(
  #             tags$b("Annual healthcare spending:"),
  #             " Estimated $1.3 billion in
  #                   direct medical costs"
  #           ),
  #           tags$li(
  #             tags$b("Per-case treatment:"),
  #             " $3,000 - $6,000 for early-stage
  #                   diagnosis and treatment"
  #           ),
  #           tags$li(
  #             tags$b("Chronic cases:"),
  #             " Up to $63,000 over 6 months for patients
  #                   with post-treatment symptoms"
  #           ),
  #           tags$li(
  #             tags$b("Emergency visits:"),
  #             " Increasing burden on emergency departments
  #                   in endemic areas"
  #           )
  #         ),
  #         tags$hr(),
  #         h5("Indirect Economic Impact:"),
  #         tags$ul(
  #           tags$li("Lost productivity from illness"),
  #           tags$li("Long-term disability claims"),
  #           tags$li("Reduced quality of life"),
  #           tags$li("Prevention and education program costs")
  #         )
  #       ),
  #       column(
  #         width = 4,
  #         bslib::value_box(
  #           title = "Annual Economic Burden",
  #           value = "$1.3B",
  #           showcase = icon("hand-holding-dollar"),
  #           theme = "danger",
  #           p("Direct medical costs annually", class = "fs-6")
  #         ),
  #         bslib::value_box(
  #           title = "Per-Case Average",
  #           value = "$3,000+",
  #           showcase = icon("notes-medical"),
  #           theme = "warning",
  #           p("Early-stage treatment cost", class = "fs-6")
  #         ),
  #         bslib::value_box(
  #           title = "Lost Work Days",
  #           value = "5-10 days",
  #           showcase = icon("briefcase"),
  #           theme = "info",
  #           p("Per acute infection", class = "fs-6")
  #         )
  #       )
  #     )
  #   )
  # ),

  # Healthcare system challenges
  # bslib::layout_column_wrap(
  #   width = 1 / 2,

  #   bslib::card(
  #     bslib::card_header("Healthcare System Challenges"),
  #     bslib::card_body(
  #       h5("Provider Preparedness:"),
  #       bslib::card(
  #         class = "border-start border-warning border-4 mb-3",
  #         bslib::card_body(
  #           class = "py-2",
  #           h6("Diagnosis in Non-Endemic Areas", class = "mb-1 text-warning"),
  #           p(
  #             "Physicians in newly affected regions may lack experience recognizing
  #             early symptoms, leading to delayed diagnosis and treatment.",
  #             class = "small mb-0"
  #           )
  #         )
  #       ),
  #       bslib::card(
  #         class = "border-start border-warning border-4 mb-3",
  #         bslib::card_body(
  #           class = "py-2",
  #           h6("Testing Capacity", class = "mb-1 text-warning"),
  #           p(
  #             "Laboratory infrastructure may be inadequate in emerging endemic areas,
  #             affecting diagnostic accuracy.",
  #             class = "small mb-0"
  #           )
  #         )
  #       ),
  #       bslib::card(
  #         class = "border-start border-warning border-4 mb-3",
  #         bslib::card_body(
  #           class = "py-2",
  #           h6("Patient Education", class = "mb-1 text-warning"),
  #           p(
  #             "Populations in newly affected areas may be unaware of prevention
  #             strategies and early warning signs.",
  #             class = "small mb-0"
  #           )
  #         )
  #       )
  #     )
  #   ),

  #   bslib::card(
  #     bslib::card_header("Required Healthcare Responses"),
  #     bslib::card_body(
  #       h5("Action Items:"),
  #       tags$ol(
  #         tags$li(
  #           tags$b("Enhanced Surveillance:"),
  #           tags$ul(
  #             tags$li("Real-time disease monitoring systems"),
  #             tags$li("Improved case reporting mechanisms"),
  #   full_screen = TRUE,
  #   bslib::card_header("Healthcare Burden by Region"),
  #   bslib::card_body(
  #     echarts4r::echarts4rOutput(ns("burden_chart"), height = "400px")
  #   )
  # ),

  # Vulnerable populations
  # bslib::card(
  #   bslib::card_header(
  #     class = "bg-primary text-white",
  #     icon("users"),
  #     " Disproportionately Affected Populations"
  #   ),
  #   bslib::card_body(
  #     fluidRow(
  #       column(
  #         width = 4,
  #         bslib::card(
  #           class = "h-100",
  #           bslib::card_body(
  #             h6("Rural Communities", class = "text-primary fw-bold"),
  #             tags$ul(
  #               class = "small",
  #               tags$li("Limited access to specialized care"),
  #               tags$li("Greater exposure to tick habitats"),
  #               tags$li("Delayed diagnosis due to distance"),
  #               tags$li("Economic vulnerability")
  #             )
  #           )
  #         )
  #       ),
  #       column(
  #         width = 4,
  #         bslib::card(
  #           class = "h-100",
  #           bslib::card_body(
  #             h6("Outdoor Workers", class = "text-primary fw-bold"),
  #             tags$ul(
  #               class = "small",
  #               tags$li("Occupational exposure risk"),
  #               tags$li("Limited workplace protections"),
  #               tags$li("Income loss during illness"),
  #               tags$li("Repeat exposure potential")
  #             )
  #           )
  #         )
  #       ),
  #       column(
  #         width = 4,
  #         bslib::card(
  #           class = "h-100",
  #           bslib::card_body(
  #             h6("Uninsured/Underinsured", class = "text-primary fw-bold"),
  #             tags$ul(
  #               class = "small",
  #               tags$li("Delayed care seeking"),
  #               tags$li("Treatment cost barriers"),
  #               tags$li("Higher chronic disease rates"),
  #               tags$li("Limited prevention resources")
  #             )
  #           )
  #         )
  #       )
  #     )
  #   )
  # ),

  # Call to action
  # bslib::card(
  #   class = "bg-success text-white",
  #   bslib::card_body(
  #     class = "p-4",
  #     h4("Moving Forward: A Public Health Response", class = "mb-3"),
  #     p(
  #       "Addressing the expanding threat of Lyme disease requires coordinated action
  #       across multiple sectors:",
  #       class = "lead"
  #     ),
  #     fluidRow(
  #       column(
  #         width = 6,
  #         h6("Policy & Funding:"),
  #         tags$ul(
  #           tags$li("Increased research funding"),
  #           tags$li("Enhanced surveillance programs"),
  #           tags$li("Insurance coverage improvements"),
  #           tags$li("Vector control initiatives")
  #         )
  #       ),
  #       column(
  #         width = 6,
  #         h6("Community Action:"),
  #         tags$ul(
  #           tags$li("Public education campaigns"),
  #           tags$li("Workplace safety protocols"),
  #           tags$li("Outdoor recreation guidelines"),
  #           tags$li("Citizen science programs")
  #         )
  #       )
  #     )
  #   )
  # )
}
