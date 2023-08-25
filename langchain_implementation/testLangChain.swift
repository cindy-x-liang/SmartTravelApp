//
//  testLangChain.swift
//  langchain_implementation
//
//  Created by Cindy Liang on 7/15/23.
//

import Foundation
import LangChain


public class chatBot {

    var input = ["human_input": ""]
    //var output = ["Answer":""]
//    let template = """
//
//
//    %@
//    Human: %@
//    Assistant:
//    """
    
//    let prompt = PromptTemplate(input_variables: ["history", "human_input"], template: """
//
//
//    %@
//    Human: %@
//    Assistant:
//    """)


    

    let chatgpt_chain = LLMChain(
        llm: OpenAI(),
        prompt: PromptTemplate(input_variables: ["history", "human_input"], template: """
    
    
    %@
    Human: %@
    Assistant:
    """),
        parser: Nothing(),
        memory: ConversationBufferWindowMemory()
    )
    
    func run(userInput: String) async -> String {
    
            input["human_input"] =  userInput
            var output = await chatgpt_chain.predict(args: input)
            print(input["human_input"]!)
            print(output["Answer"]!)
            
        
        
            //TO DOs for CINDY
            //maybe add embeddings https://fauna.com/blog/building-ai-applications-with-openai-pinecone-langchain-fauna
            
            
            //ask wanna book flights -- or just directly give
            //ask wanna look at hotel info
            //find apis for the hotel info
        
        
        //string search or regex comparison
        //fake data for flight
        //seed flight and hotel data stuff and put it into sql lite database
        //read from sql lite dataabase
        //only need flights between dallas and nyc
       
        
        return output["Answer"]!
    }
    

    
}

