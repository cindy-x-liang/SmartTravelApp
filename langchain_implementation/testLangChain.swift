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
    
    func run(userInput: String) async -> String {
        let template = """
        

        %@
        Human: %@
        Assistant:
        """
        
        let prompt = PromptTemplate(input_variables: ["history", "human_input"], template: template)


        let chatgpt_chain = LLMChain(
            llm: OpenAI(),
            prompt: prompt,
            parser: Nothing(),
            memory: ConversationBufferWindowMemory()
        )
        
        
    
            input = ["human_input": userInput]
            var output = await chatgpt_chain.predict(args: input)
            print(input["human_input"]!)
            print(output["Answer"]!)
            
        
        
            //TO DOs for CINDY
            //when ready to finish, click button
            //while (button is not clicked) got thru this back and forth ^^ i feel like the above code will suffice
            //maybe add embeddings https://fauna.com/blog/building-ai-applications-with-openai-pinecone-langchain-fauna
            
            //need to prompt it in a way that it outputs the final data in a consistent way
            
            // a l
            //when the user prompts a certain way it terminates
            //ask wanna book flights -- or just directly give
            //ask wanna look at hotel info
            //find apis for the hotel info
            
        
            //work on memory for the chat bot
            //work on prompt output
        
        return output["Answer"]!
    }
    

    
}

