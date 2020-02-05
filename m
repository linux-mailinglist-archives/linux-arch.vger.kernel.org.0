Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3F9A1529C2
	for <lists+linux-arch@lfdr.de>; Wed,  5 Feb 2020 12:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbgBELUs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Feb 2020 06:20:48 -0500
Received: from ivanoab7.miniserver.com ([37.128.132.42]:57820 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbgBELUs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Feb 2020 06:20:48 -0500
Received: from tun252.jain.kot-begemot.co.uk ([192.168.18.6] helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <anton.ivanov@kot-begemot.co.uk>)
        id 1izIFX-0000r7-Mo; Wed, 05 Feb 2020 10:49:40 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
        by jain.kot-begemot.co.uk with esmtp (Exim 4.92)
        (envelope-from <anton.ivanov@kot-begemot.co.uk>)
        id 1izIFV-000809-Ai; Wed, 05 Feb 2020 10:49:39 +0000
Subject: Re: [RFC v2 07/37] lkl: interrupt support
To:     Hajime Tazaki <thehajime@gmail.com>, richard.weinberger@gmail.com
Cc:     linux-arch@vger.kernel.org, tavi.purdila@gmail.com,
        linux-um@lists.infradead.org, retrage01@gmail.com,
        linux-kernel-library@freelists.org, sigmaepsilon92@gmail.com
References: <cover.1573179553.git.thehajime@gmail.com>
 <567fd4d5c395e2279e86ca0bfca544ad2773a31d.1573179553.git.thehajime@gmail.com>
 <CAFLxGvxytmS4WSFj2ibyJKCuR5TbspdNf6MvHNvzh9dtKx2rJg@mail.gmail.com>
 <m2h805qy99.wl-thehajime@gmail.com>
From:   Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <739ada9a-b88a-5192-fb4b-65132a74b4de@kot-begemot.co.uk>
Date:   Wed, 5 Feb 2020 10:49:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <m2h805qy99.wl-thehajime@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0
X-Spam-Score: -1.0
X-Clacks-Overhead: GNU Terry Pratchett
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 05/02/2020 07:38, Hajime Tazaki wrote:
> 
> On Tue, 26 Nov 2019 07:13:55 +0900,
> Richard Weinberger wrote:
>>
>> On Fri, Nov 8, 2019 at 6:03 AM Hajime Tazaki <thehajime@gmail.com> wrote:
>>>
>>> From: Octavian Purdila <tavi.purdila@gmail.com>
>>>
>>> Add APIs that allows the host to reserve and free and interrupt number
>>> and also to trigger an interrupt.
>>>
>>> The trigger operation will simply store the interrupt data in
>>> queue. The interrupt handler is run later, at the first opportunity it
>>> has to avoid races with any kernel threads.
>>>
>>> Currently, interrupts are run on the first interrupt enable operation
>>> if interrupts are disabled and if we are not already in interrupt
>>> context.
>>>
>>> When triggering an interrupt, it uses GCC's built-in functions for
>>> atomic memory access to synchronize and simple boolean flags.
>>>
>>> Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
>>> Signed-off-by: Michael Zimmermann <sigmaepsilon92@gmail.com>
>>> Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
>>> ---
>>>   arch/um/lkl/include/asm/irq.h             |  13 ++
>>>   arch/um/lkl/include/uapi/asm/irq.h        |  36 ++++
>>>   arch/um/lkl/include/uapi/asm/sigcontext.h |  16 ++
>>>   arch/um/lkl/kernel/irq.c                  | 193 ++++++++++++++++++++++
>>
>> Like I said before, this also something to unify with UML.
>> I'm aware that this is easily said but we cannot have too much duplication.
>>
>> Feel free to ask if UML internals give you headache. :-)
> 
> Same as nommu implementation, I left this part as-is.
> 
> Triggering interrupts with fd events (delivered by epoll&co) is a hard
> part to implement host-independent interrupts of LKL.  OTOH, the v3
> patchset shows that it is doable to use UML drivers with the LKL
> interrupt facility.

Make sure you are testing with the vector network devices, the legacy ones are scheduled to be obsoleted at some point

I know this will cause a headache on non-Linux, I am happy to write wrappers/emulators for recvmms/sendmmsg so these build on the systems which do not support them.

Brgds,


> 
> I may also need more time to evaluate/find a right direction, though.
> Your comments are always welcome.
> 
> -- Hajime
> 
> 
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um
> 

-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/
