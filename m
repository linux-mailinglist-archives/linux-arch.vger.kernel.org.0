Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4E15332FF9
	for <lists+linux-arch@lfdr.de>; Tue,  9 Mar 2021 21:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbhCIU25 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 9 Mar 2021 15:28:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbhCIU2Z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 9 Mar 2021 15:28:25 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1028DC06174A;
        Tue,  9 Mar 2021 12:28:25 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 314363FA6A;
        Tue,  9 Mar 2021 20:28:15 +0000 (UTC)
Subject: Re: [RFT PATCH v3 06/27] dt-bindings: timer: arm,arch_timer: Add
 interrupt-names support
To:     Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Tony Lindgren <tony@atomide.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Alexander Graf <graf@amazon.com>,
        Will Deacon <will@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210304213902.83903-1-marcan@marcan.st>
 <20210304213902.83903-7-marcan@marcan.st>
 <20210308203841.GA2906683@robh.at.kernel.org> <87zgzdqnbs.wl-maz@kernel.org>
 <CAL_JsqJVmr+23HDN-7Wjbrkh5jt=4dbU9y1iUqDu1nPOV2+38Q@mail.gmail.com>
From:   Hector Martin <marcan@marcan.st>
Message-ID: <bb8502b2-000c-3653-04f4-a04ad629cb9b@marcan.st>
Date:   Wed, 10 Mar 2021 05:28:14 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJVmr+23HDN-7Wjbrkh5jt=4dbU9y1iUqDu1nPOV2+38Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/03/2021 01.11, Rob Herring wrote:
> On Mon, Mar 8, 2021 at 3:42 PM Marc Zyngier <maz@kernel.org> wrote:
>>
>> On Mon, 08 Mar 2021 20:38:41 +0000,
>> Rob Herring <robh@kernel.org> wrote:
>>>
>>> On Fri, Mar 05, 2021 at 06:38:41AM +0900, Hector Martin wrote:
>>>> Not all platforms provide the same set of timers/interrupts, and Linux
>>>> only needs one (plus kvm/guest ones); some platforms are working around
>>>> this by using dummy fake interrupts. Implementing interrupt-names allows
>>>> the devicetree to specify an arbitrary set of available interrupts, so
>>>> the timer code can pick the right one.
>>>>
>>>> This also adds the hyp-virt timer/interrupt, which was previously not
>>>> expressed in the fixed 4-interrupt form.
>>>>
>>>> Signed-off-by: Hector Martin <marcan@marcan.st>
>>>> ---
>>>>   .../devicetree/bindings/timer/arm,arch_timer.yaml  | 14 ++++++++++++++
>>>>   1 file changed, 14 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/timer/arm,arch_timer.yaml b/Documentation/devicetree/bindings/timer/arm,arch_timer.yaml
>>>> index 2c75105c1398..ebe9b0bebe41 100644
>>>> --- a/Documentation/devicetree/bindings/timer/arm,arch_timer.yaml
>>>> +++ b/Documentation/devicetree/bindings/timer/arm,arch_timer.yaml
>>>> @@ -34,11 +34,25 @@ properties:
>>>>                 - arm,armv8-timer
>>>>
>>>>     interrupts:
>>>> +    minItems: 1
>>>> +    maxItems: 5
>>>>       items:
>>>>         - description: secure timer irq
>>>>         - description: non-secure timer irq
>>>>         - description: virtual timer irq
>>>>         - description: hypervisor timer irq
>>>> +      - description: hypervisor virtual timer irq
>>>> +
>>>> +  interrupt-names:
>>>> +    minItems: 1
>>>> +    maxItems: 5
>>>> +    items:
>>>> +      enum:
>>>> +        - phys-secure
>>>> +        - phys
>>>> +        - virt
>>>> +        - hyp-phys
>>>> +        - hyp-virt
>>>
>>> phys-secure and hyp-phys is not very consistent. secure-phys or sec-phys
>>> instead?
>>>
>>> This allows any order which is not ideal (unfortunately json-schema
>>> doesn't have a way to define order with optional entries in the middle).
>>> How many possible combinations are there which make sense? If that's a
>>> reasonable number, I'd rather see them listed out.
>>
>> The available of interrupts are a function of the number of security
>> states, privileged exception levels and architecture revisions, as
>> described in D11.1.1:
>>
>> <quote>
>> - An EL1 physical timer.
>> - A Non-secure EL2 physical timer.
>> - An EL3 physical timer.
>> - An EL1 virtual timer.
>> - A Non-secure EL2 virtual timer.
>> - A Secure EL2 virtual timer.
>> - A Secure EL2 physical timer.
>> </quote>
>>
>> * Single security state, EL1 only, ARMv7 & ARMv8.0+ (assumed NS):
>>    - physical, virtual
>>
>> * Single security state, EL1 + EL2, ARMv7 & ARMv8.0 (assumed NS)
>>    - physical, virtual, hyp physical
>>
>> * Single security state, EL1 + EL2, ARMv8.1+ (assumed NS)
>>    - physical, virtual, hyp physical, hyp virtual
>>
>> * Two security states, EL1 + EL3, ARMv7 & ARMv8.0+:
>>    - secure physical, physical, virtual
>>
>> * Two security states, EL1 + EL2 + EL3, ARMv7 & ARMv8.0
>>    - secure physical, physical, virtual, hyp physical
>>
>> * Two security states, EL1 + EL2 + EL3, ARMv8.1+
>>    - secure physical, physical, virtual, hyp physical, hyp virtual
>>
>> * Two security states, EL1 + EL2 + S-EL2 + EL3, ARMv8.4+
>>    - secure physical, physical, virtual, hyp physical, hyp virtual,
>>      secure hyp physical, secure hyp virtual
>>
>> Nobody has seen the last combination in the wild (that is, outside of
>> a SW model).
>>
>> I'm really not convinced we want to express this kind of complexity in
>> the binding (each of the 7 cases), specially given that we don't
>> encode the underlying HW architecture level or number of exception
>> levels anywhere, and have ho way to validate such information.
> 
> Actually, we can simplify this down to 2 cases:
> 
> oneOf:
>    - minItems: 2
>      items:
>        - const: phys
>        - const: virt
>        - const: hyp-phys
>        - const: hyp-virt
>    - minItems: 3
>      items:
>        - const: sec-phys
>        - const: phys
>        - const: virt
>        - const: hyp-phys
>        - const: hyp-virt
>        - const: sec-hyp-phy
>        - const: sec-hyp-virt
> 
> And that's below my threshold for not worth the complexity.

This makes sense. Since we aren't using the sec-hyp stuff here, and 
those go at the end of the list, we can omit them from this patch for 
now and add them whenever they're needed for a platform. Does that sound OK?

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
