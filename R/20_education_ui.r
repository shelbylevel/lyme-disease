# ==============================================================================
# LYME DISEASE 101 MODULE - UI
# ==============================================================================

#' Lyme Disease Education Module UI
#'
#' @param id Module namespace ID
#'
#' @return A Shiny UI element
education_ui <- function(id) {
  ns <- NS(id)

  bslib::layout_column_wrap(
    width = 1,

    # Header: What is Lyme Disease --------------------------------------------
    bslib::card(
      bslib::card_body(
        class = "p-4 text-center bg-light",
        h2("What is Lyme Disease?", class = "mb-2"),
        p(
          class = "text-muted mb-1",
          "Understanding America's most common vector-borne disease"
        )
      ),
      bslib::card_body(
        p(
          class = "lead text-center",
          style = "margin-top: 10px;",
          "Lyme disease is a bacterial disease transmitted by the bite of an infected tick. 
          The primary bacterium that causes Lyme disease is ",
          tags$em("Borrelia burgdorferi")
        )
      )
    ),

    # Lyme Disease Over Time --------------------------------------------------
    # bslib::card(
    #   full_screen = TRUE,
    #   bslib::card_body(
    #     highchartOutput(ns("us_map"), height = "550px") %>%
    #       shinycssloaders::withSpinner(type = 7, color = "#254D56")
    #   ),
    #   card_footer(
    #     "Source: ",
    #     popover(
    #       a("CDC (2024)", href = "#"),
    #       markdown(
    #         "Centers for Disease Control and Prevention. (2025). *Lyme Disease Case Maps*. [https://www.cdc.gov/lyme/data-research/facts-stats/lyme-disease-case-map.html](https://www.cdc.gov/lyme/data-research/facts-stats/lyme-disease-case-map.html)"
    #       )
    #     )
    #   )
    # ),

    # Transmission ------------------------------------------------------------
    bslib::card(
      bslib::card_header(
        class = "bg-primary text-white",
        icon("bug"),
        "How is Lyme Disease Transmitted?"
      ),
      bslib::card_body(
        p(
          "In the eastern United States, black-legged ticks (sometimes called deer ticks) are the main species carrying the ",
          tags$em("Borrelia"),
          " bacteria, while along the West Coast of the US, western black-legged ticks are the dominant species. Both species are most commonly found in grass (especially taller grass), brushy, and wooded areas. Areas with leaf litter may also harbor ticks."
        ),
        tags$hr(),
        fluidRow(
          column(
            width = 6,
            h5(tags$em("Borrelia"), "Bacteria"),
            tags$ul(
              tags$li(
                "Prevalence in tick populations ranges from 0 to 50%"
              ),
              tags$li("Both nymphal and adult ticks may be infected")
            )
          ),
          column(
            width = 6,
            bslib::card(
              class = "bg-light",
              bslib::card_body(
                class = "text-primary fw-bold",
                p(
                  "Ticks must be attached to the host (person or animal) for at least 24 hours for the",
                  tags$em("Borrelia"),
                  " bacteria to be transmitted"
                )
              )
            )
          )
        )
      ),
      card_footer(
        "Source: ",
        popover(
          a("CDC (2024)", href = "#"),
          markdown(
            "Centers for Disease Control and Prevention. (2024). *Causes of Lyme disease*. [https://www.cdc.gov/lyme/causes/index.html](https://www.cdc.gov/lyme/causes/index.html)"
          )
        )
      )
    ),

    # Symptoms ---------------------------------------------------------------
    bslib::card(
      bslib::card_header(
        class = "bg-danger text-light",
        icon("stethoscope"),
        "Symptoms"
      ),
      bslib::card_body(
        # fluidRow(
        #   column(
        #     width = 8,
        #     h5("Transmission Process:"),
        #     tags$ol(
        #       tags$li(
        #         tags$b("Tick Attachment:"),
        #         " An infected blacklegged tick bites and
        #               attaches to human skin"
        #       ),
        #       tags$li(
        #         tags$b("Feeding Period:"),
        #         " Tick must be attached for 36-48 hours
        #               to transmit the bacteria"
        #       ),
        #       tags$li(
        #         tags$b("Bacterial Transfer:"),
        #         " ",
        #         tags$em("Borrelia burgdorferi"),
        #         " bacteria enter bloodstream"
        #       ),
        #       tags$li(
        #         tags$b("Infection Spreads:"),
        #         " Bacteria disseminate through the body
        #               if untreated"
        #       )
        #     ),
        #     tags$hr(),
        #     h5("Risk Factors:"),
        #     tags$ul(
        #       tags$li("Spending time in wooded or grassy areas"),
        #       tags$li("Not using tick repellent"),
        #       tags$li("Not performing tick checks after outdoor activities"),
        #       tags$li("Living in or visiting endemic areas")
        #     )
        #   ),
        #   column(
        #     width = 4,
        #     bslib::card(
        #       class = "bg-light",
        #       bslib::card_body(
        #         h6("Prevention Tips:", class = "text-primary fw-bold"),
        #         tags$ul(
        #           class = "small",
        #           tags$li("Use EPA-registered insect repellents"),
        #           tags$li("Wear long sleeves and pants"),
        #           tags$li("Tuck pants into socks"),
        #           tags$li("Walk in center of trails"),
        #           tags$li("Check for ticks daily"),
        #           tags$li("Shower within 2 hours of being outdoors"),
        #           tags$li("Put clothes in dryer on high heat")
        #         )
        #       )
        #     )
        #   )
        # )
      )
    ),

    # Treatment -------------------------------------------------------------
    bslib::layout_column_wrap(
      #width = 1 / 2,

      bslib::card(
        bslib::card_header(
          class = "bg-success text-white",
          icon("pills"),
          "Treatment"
        ),
        bslib::card_body(
          #   h5("Early Localized Stage (3-30 days):"),
          #   tags$ul(
          #     tags$li(
          #       tags$b("Erythema migrans (EM) rash:"),
          #       " 'Bull's-eye' rash in 70-80%
          #             of cases"
          #     ),
          #     tags$li("Fever and chills"),
          #     tags$li("Fatigue"),
          #     tags$li("Headache"),
          #     tags$li("Muscle and joint aches")
          #   ),
          #   tags$hr(),
          #   h5("Early Disseminated Stage (days-weeks):"),
          #   tags$ul(
          #     tags$li("Multiple EM rashes"),
          #     tags$li("Facial palsy"),
          #     tags$li("Severe headaches and neck stiffness"),
          #     tags$li("Heart palpitations (Lyme carditis)"),
          #     tags$li("Nerve pain and shooting pains")
          #   ),
          #   tags$hr(),
          #   h5("Late Disseminated Stage (months-years):"),
          #   tags$ul(
          #     tags$li("Severe arthritis, particularly in knees"),
          #     tags$li("Neurological problems"),
          #     tags$li("Cognitive difficulties"),
          #     tags$li("Numbness in extremities")
        )
      )
    ),

    #   bslib::card(
    #     bslib::card_header(
    #       class = "bg-warning text-dark",
    #       icon("circle-info"),
    #       " Treatment"
    #     ),
    #     bslib::card_body(
    #       h5("Standard Treatment Protocol:"),
    #       bslib::card(
    #         class = "border-success",
    #         bslib::card_body(
    #           h6("Early Stage:"),
    #           tags$ul(
    #             tags$li("Oral antibiotics: Doxycycline (10-21 days)"),
    #             tags$li("Alternative: Amoxicillin or Cefuroxime"),
    #             tags$li(tags$b("Success rate:"), " >90% when caught early")
    #           )
    #         )
    #       ),
    #       bslib::card(
    #         class = "border-warning",
    #         bslib::card_body(
    #           h6("Later Stages:"),
    #           tags$ul(
    #             tags$li("Longer courses of oral antibiotics (28 days)"),
    #             tags$li("IV antibiotics for neurological symptoms"),
    #             tags$li("Treatment of specific complications")
    #           )
    #         )
    #       ),
    #       tags$hr(),
    #       p(
    #         class = "text-muted small mb-0",
    #         icon("exclamation-triangle"),
    #         " Early diagnosis and treatment are crucial for best outcomes. If you suspect
    #         Lyme disease, consult a healthcare provider immediately."
    #       )
    #     )
    #   )
    # ),

    # Long-term Consequences -------------------------------------------------
    bslib::card(
      bslib::card_header(
        class = "bg-info text-white",
        icon("clock"),
        "Long-term Consequences"
      ),
      bslib::card_body(
        # fluidRow(
        #   column(
        #     width = 6,
        #     bslib::card(
        #       class = "border-success border-2",
        #       bslib::card_header("With Prompt Treatment"),
        #       bslib::card_body(
        #         h6("Expected Outcomes:", class = "text-success"),
        #         tags$ul(
        #           tags$li("Complete recovery in most cases"),
        #           tags$li("Symptoms resolve within weeks"),
        #           tags$li("No long-term complications"),
        #           tags$li("Return to normal activities")
        #         ),
        #         p(
        #           class = "small text-muted mb-0",
        #           "~10-20% may experience lingering symptoms (Post-Treatment Lyme Disease
        #           Syndrome) even after appropriate treatment."
        #         )
        #       )
        #     )
        #   ),
        #   column(
        #     width = 6,
        #     bslib::card(
        #       class = "border-danger border-2",
        #       bslib::card_header("Without Treatment"),
        #       bslib::card_body(
        #         h6("Potential Complications:", class = "text-danger"),
        #         tags$ul(
        #           tags$li(
        #             tags$b("Chronic arthritis:"),
        #             " Particularly in large joints"
        #           ),
        #           tags$li(
        #             tags$b("Neurological issues:"),
        #             " Memory problems, difficulty
        #                   concentrating"
        #           ),
        #           tags$li(
        #             tags$b("Cardiac complications:"),
        #             " Heart rhythm irregularities"
        #           ),
        #           tags$li(
        #             tags$b("Chronic pain:"),
        #             " Persistent muscle and joint pain"
        #           ),
        #           tags$li(tags$b("Fatigue:"), " Severe, debilitating tiredness")
        #         ),
        #         p(
        #           class = "small text-muted mb-0",
        #           "Untreated Lyme disease can have serious long-term health impacts affecting
        #           quality of life."
        #         )
        #       )
        #     )
        #   )
        # )
      )
    )
  )
}
