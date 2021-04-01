Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D758B351870
	for <lists+linux-arch@lfdr.de>; Thu,  1 Apr 2021 19:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234596AbhDARpu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Apr 2021 13:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234638AbhDARii (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Apr 2021 13:38:38 -0400
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8AAC035470;
        Thu,  1 Apr 2021 06:16:42 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id D249442715;
        Thu,  1 Apr 2021 13:16:32 +0000 (UTC)
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Tony Lindgren <tony@atomide.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Alexander Graf <graf@amazon.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210304213902.83903-1-marcan@marcan.st>
 <20210304213902.83903-17-marcan@marcan.st>
 <20210324195742.GA13474@willie-the-truck>
 <3564ed98-6ad6-7ddd-01d2-36d7f5af90e0@marcan.st>
 <20210329120442.GA3636@willie-the-truck>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [RFT PATCH v3 16/27] irqchip/apple-aic: Add support for the Apple
 Interrupt Controller
Message-ID: <5ff8eef3-6943-d3c8-cd6f-3dcb44158fab@marcan.st>
Date:   Thu, 1 Apr 2021 22:16:30 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210329120442.GA3636@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Will,

On 29/03/2021 21.04, Will Deacon wrote:
>> One CPU still needs to be able to mutate the flags of another CPU to fire an
>> IPI; AIUI the per-cpu ops are *not* atomic for concurrent access by multiple
>> CPUs, and in fact there is no API for that, only for "this CPU".
> 
> Huh, I really thought we had an API for that, but you're right. Oh well! But
> I'd still suggest a per-cpu atomic_t in that case, rather than the array.

Yeah, after digging into the per-cpu stuff earlier and understanding how 
it works, I agree that a per-cpu atomic makes sense here. Switched it to 
that (which simplified out a bunch of smp_processor_id() calls too). Thanks!

>>> I think a more idiomatic (and portable) way to do this would be to use
>>> the relaxed accessors, but with smp_mb__after_atomic() between them. Do you
>>> have a good reason for _not_ doing it like that?
>>
>> Not particularly, other than symmetry with the case below.
> 
> I think it would be better not to rely on arm64-specific ordering unless
> there's a good reason to.

Sounds reasonable, I'll switch to the barrier version.

>> We do need the return data here, and the release semantics (or another
>> barrier before it). But the read below can be made relaxed and a barrier
>> used instead, and then the same patern above except with a plain
>> atomic_or().
> 
> Yes, I think using atomic_fetch_or() followed by atomic_read() would be
> best (obviously with the relevant comments!)

atomic_fetch_or_release is sufficient here (atomic_fetch_or is stronger; 
atomic_fetch_or_relaxed would not be strong enough as this needs to be 
ordered after any writes prior to sending the IPI; in this case release 
semantics also make logical sense).

>> It is ordered, right? As the comment says, it "needs to be ordered after the
>> aic_ic_write() above". atomic_fetch_andnot() is *supposed* to be fully
>> ordered and that should include against the writel_relaxed() on
>> AIC_IPI_FLAG. On ARM it turns out it's not quite fully ordered, but the
>> acquire semantics of the read half are sufficient for this case, as they
>> guarantee the flags are always read after the FIQ has been ACKed.
> 
> Sorry, I missed that the answer to my question was already written in the
> comment. However, I'm still a bit unsure about whether the memory barriers
> give you what you need here. The barrier in atomic_fetch_andnot() will
> order the previous aic_ic_write(AIC_IPI_ACK) for the purposes of other
> CPUs reading those locations, but it doesn't say anything about when the
> interrupt controller actually changes state after the Ack.
> 
> Given that the AIC is mapped Device-nGnRnE, the Arm ARM offers:
> 
>    | Additionally, for Device-nGnRnE memory, a read or write of a Location
>    | in a Memory-mapped peripheral that exhibits side-effects is complete
>    | only when the read or write both:
>    |
>    | * Can begin to affect the state of the Memory-mapped peripheral.
>    | * Can trigger all associated side-effects, whether they affect other
>    |   peripheral devices, PEs, or memory.
> 
> so without AIC documentation I can't tell whether completion of the Ack write
> just begins the process of an Ack (in which case we might need something like
> a read-back), or whether the write response back from the AIC only occurs once
> the Ack has taken effect. Any ideas?

Ahh, you're talking about latency within AIC itself... I obviously don't 
have an authoritative answer to this, though the hardware designer in me 
wants to say this really ought to be single-cycle type stuff that isn't 
internally pipelined in a way that would create races.

I tried to set up an SMP test case for the atomic-to-AIC sequence in 
m1n1, but unfortunately I couldn't hit the race window in deliberately 
racy code (i.e. ack after clearing flags) without widening it even 
further with at least one dummy load in between, and of course I didn't 
experience any races with the proper code either.

What I can say is that a simple set IPI; ack IPI (in adjacent str 
instructions) sequence always yields a cleared IPI, and the converse 
always yields a set IPI. So if there is latency to the operations it 
seems it would at least be the same for sets and acks and would imply 
readbacks block, which should still yield equivalently correct results. 
But of course this is a single-CPU test, so it is not fully 
representative of what could happen in an SMP scenario.

At this point all I can say is I'm inclined to shrug and say we have no 
evidence of this being something that can happen, and it shouldn't in 
sane hardware, and hope for the best :-)

Thanks,
-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
