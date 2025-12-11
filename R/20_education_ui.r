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
        h2("What is Lyme Disease?", class = "mb-3"),
        h4(
          class = "text-muted fw-normal mb-0",
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

    # Transmission ------------------------------------------------------------
    bslib::layout_column_wrap(
      bslib::card(
        bslib::card_header(
          class = "bg-primary text-white",
          icon("bug"),
          "How is Lyme Disease Transmitted?"
        ),
        bslib::card_body(
          tags$div(
            style = "margin-bottom: 1em;",
            icon("location-dot", class = "text-success"),
            tags$b("Tick Species:"),
            " In the eastern United States, black-legged ticks (sometimes called deer ticks) are the main species carrying the ",
            tags$em("Borrelia"),
            " bacteria, while along the West Coast of the United States, western black-legged ticks are the dominant species."
          ),
          tags$div(
            style = "margin-bottom: 1em;",
            icon("leaf", class = "text-warning"),
            tags$b("Habitats:"),
            " Both species of ticks are most commonly found in grass (especially taller grass), brushy, and wooded areas. Areas with leaf litter may also harbors ticks."
          ),
          tags$div(
            style = "margin-bottom: 1em;",
            icon("circle-info", class = "text-primary"),
            tags$b("Prevalence:"),
            " Infection rates of the ",
            tags$em("Borrelia"),
            " bacteria in tick populations range from 0% to 50%. Both nymphal and adult ticks may be infected."
          ),
          fluidRow(
            column(
              width = 6,
              tags$div(
                style = "margin-bottom: 1em;",
                icon("triangle-exclamation", class = "text-danger"),
                tags$b("Risk Factors:"),
                tags$ul(
                  tags$li("Spending time in wooded or grassy areas"),
                  tags$li("Not using tick repellent"),
                  tags$li(
                    "Not performing tick checks after outdoor activities"
                  ),
                  tags$li("Living in or visiting endemic areas")
                )
              )
            ),
            column(
              width = 6,
              img(
                src = "tick.png",
                alt = "Black-legged or Deer Tick (Ixodes scapularis) life stages",
                width = "100%"
              )
            )
          ),
          bslib::card(
            class = "bg-light",
            bslib::card_body(
              class = "text-primary fw-bold",
              p(
                icon("clock"),
                "Transmission Time: Ticks must be attached to the host's skin (person or animal) for at least 24 hours to transmit the ",
                tags$em("Borrelia"),
                " bacteria."
              )
            )
          )
        ),
        card_footer(
          "Sources: ",
          popover(
            a("CDC (2024); ALDF (n.d.)", href = "javascript:void(0);"),
            HTML(
              'Centers for Disease Control and Prevention. (2024). <em>Causes of Lyme disease</em>. <a href="https://www.cdc.gov/lyme/causes/index.html">https://www.cdc.gov/lyme/causes/index.html</a><br><br>
            American Lyme Disease Foundation. (n.d.). <em>Tick Identification and Information</em>. <a href="https://aldf.com/tick-identification-and-information/">https://aldf.com/tick-identification-and-information/a>'
            )
          )
        )
      ),

      # Symptoms ---------------------------------------------------------------
      bslib::card(
        bslib::card_header(
          class = "bg-danger text-light",
          icon("stethoscope"),
          "Symptoms of Lyme Disease"
        ),
        bslib::card_body(
          tags$div(
            style = "margin-bottom: 1em;",
            icon("circle-dot", class = "text-warning"),
            tags$b("Classic Sign:"),
            " Up to 80% of cases present with a red Erythema migrans (EM) rash starting at the tick bite and expanding over time. It often develops a 'bulls eye' appearance with a concentric ring of rash around the smaller initial rash. This typically appears between 7 and 30 days after the bite."
          ),
          fluidRow(
            column(
              width = 7,
              tags$div(
                style = "margin-bottom: 1em;",
                icon("bolt", class = "text-primary"),
                tags$b("Early Symptoms (3 – 30 days after bite):"),
                tags$ul(
                  tags$li("Headache"),
                  tags$li("Fatigue"),
                  tags$li("Muscle and joint aches"),
                  tags$li("Fever"),
                  tags$li("Swollen lymph nodes")
                )
              ),
              tags$div(
                style = "margin-bottom: 1em;",
                icon("brain", class = "text-danger"),
                tags$b(
                  "If Left Untreated: Neurological and cardiac symptoms may develop"
                ),
                tags$ul(
                  tags$li("Facial palsy"),
                  tags$li("Arthritis and joint swelling"),
                  tags$li("Irregular heartbeat or heart palpitations"),
                  tags$li("Shortness of breath"),
                  tags$li("Nerve pain"),
                  tags$li("Brain or spinal cord inflammation")
                )
              )
            ),
            column(
              width = 5,
              img(
                src = "tick-bite.png",
                alt = "'Bulls eye' rash from Lyme disease",
                width = "100%"
              )
            )
          )
        ),
        card_footer(
          "Sources: ",
          popover(
            a("CDC (2024)", href = "javascript:void(0);"),
            HTML(
              'Centers for Disease Control and Prevention. (2024). <em>Signs and Symptoms of Untreated Lyme Disease</em>. <a href="https://www.cdc.gov/lyme/signs-symptoms/index.html">https://www.cdc.gov/lyme/signs-symptoms/index.html</a>'
            )
          )
        )
      )
    ),

    # Treatment -------------------------------------------------------------
    bslib::layout_column_wrap(
      bslib::card(
        bslib::card_header(
          class = "bg-success text-white",
          icon("pills"),
          "Treatment"
        ),
        bslib::card_body(
          h5("What to Do If You Find an Attached Tick"),
          h6("After Time Outside"),
          tags$ul(
            tags$li(
              tags$b("Remove the tick promptly:"),
              " Carefully remove the tick with tweezers, grasping the tick as close to the skin as possible and pulling firmly and steadily outward."
            ),
            tags$li(
              tags$b("Exposure less than 24 hours:"),
              " Not all ticks are infected, and transmission of ",
              tags$em("Borrelia"),
              " bacteria is unlikely. Monitor for symptoms over the next 30 days."
            ),
            tags$li(
              tags$b("Exposure more than 24 hours:"),
              " First-line treatment is usually a course of doxycycline (an antibiotic) as prescribed by a healthcare provider. The person may also choose to watch and wait for symptoms and then begin treatment once symptomatic, especially if located in an area where Lyme disease is less common. Antibiotics are generally helpful when started within 10-14 days of the bite."
            ),
            tags$li(
              tags$b("Testing for Lyme disease:"),
              " Certain lab tests can detect antibodies to the ",
              tags$em("Borrelia"),
              " bacteria 4–6 weeks after exposure. Testing too early may result in a false negative because antibodies have not yet built up."
            )
          )
        ),
        card_footer(
          "Sources: ",
          popover(
            a(
              "CDC (2024); Cornell Health (n.d.); Johns Hopkins (n.d.)",
              href = "javascript:void(0);"
            ),
            markdown(
              "Centers for Disease Control and Prevention. (2024). *Testing and Diagnosis for Lyme disease*. [https://www.cdc.gov/lyme/diagnosis-testing/index.html](https://www.cdc.gov/lyme/diagnosis-testing/index.html) <br><br>
              Cornell Health. (n.d.). *Tick Bites & Lyme Disease*. [https://health.cornell.edu/about/news/tick-bites-lyme-disease](https://health.cornell.edu/about/news/tick-bites-lyme-disease) <br><br>
              Johns Hopkins Lyme Disease Research Center. (n.d.). *Lyme Disease Treatment and Prognosis*. [https://www.hopkinslyme.org/lyme-disease/treatment-and-prognosis-of-lyme-disease/](https://www.hopkinslyme.org/lyme-disease/treatment-and-prognosis-of-lyme-disease/)"
            )
          )
        )
      ),

      # Long-term Consequences -------------------------------------------------
      bslib::card(
        bslib::card_header(
          class = "bg-info text-white",
          icon("clock"),
          "Long-term Consequences"
        ),
        bslib::card_body(
          bslib::card(
            class = "bg-light",
            bslib::card_body(
              class = "text-primary fw-bold",
              p(
                icon("exclamation-triangle"),
                " Early diagnosis and treatment are crucial for best outcomes"
              )
            )
          ),
          tags$br(),
          tags$div(
            style = "margin-bottom: 1em;",
            icon("check-circle", class = "text-success"),
            tags$b("Prompt Treatment:"),
            " If Lyme disease is treated promptly with appropriate antibiotics, it usually resolves in a few weeks with no long-term consequences."
          ),
          tags$div(
            style = "margin-bottom: 1em;",
            icon("exclamation-circle", class = "text-warning"),
            tags$b("Delayed or No Treatment:"),
            " Can lead to long-term nervous system and/or joint damage. Persistent symptoms in persons with Lyme disease are now called ",
            tags$b("Post-Treatment Lyme Disease Syndrome"),
            " to better describe ongoing consequences."
          ),
          tags$div(
            style = "margin-bottom: 1em;",
            icon("redo", class = "text-danger"),
            tags$b("No Immunity:"),
            " Another bite by an infected tick can re-transmit Lyme disease, even after recovery."
          )
        ),
        card_footer(
          "Sources: ",
          popover(
            a("CDC (2025)", href = "javascript:void(0);"),
            markdown(
              "Centers for Disease Control and Prevention. (2024). *Chronic Symptoms and Lyme Disease*. [https://www.cdc.gov/lyme/signs-symptoms/chronic-symptoms-and-lyme-disease.html](https://www.cdc.gov/lyme/signs-symptoms/chronic-symptoms-and-lyme-disease.html)"
            )
          )
        )
      )
    )
  )
}
