Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 716D93B8E3A
	for <lists+linux-arch@lfdr.de>; Thu,  1 Jul 2021 09:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234833AbhGAHiI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Jul 2021 03:38:08 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:54445 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbhGAHiI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Jul 2021 03:38:08 -0400
Received: from [192.168.1.155] ([95.117.176.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MF3U0-1m10wT43Dc-00FWrO; Thu, 01 Jul 2021 09:35:22 +0200
Subject: Re: x86 CPU features detection for applications (and AMX)
To:     Thiago Macieira <thiago.macieira@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     fweimer@redhat.com, hjl.tools@gmail.com, libc-alpha@sourceware.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        x86@kernel.org
References: <22261946.eFiGugXE7Z@tjmaciei-mobl1>
 <YNnMsJJzI83cpnAQ@hirez.programming.kicks-ass.net>
 <534d0171-2cc5-cd0a-904f-cd3c499b55af@metux.net>
 <4315452.lxGN7TsiT6@tjmaciei-mobl1>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <ccd3680a-72bf-eaa9-20ae-56fccfbca8ad@metux.net>
Date:   Thu, 1 Jul 2021 09:35:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <4315452.lxGN7TsiT6@tjmaciei-mobl1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:6HM7j/CwlUKwb9UuWswosMIR7aZZYdYlyu0d022pWq2jKj+3aNO
 TUavdL2e7yT7/X1B+7Sr+Al25MzRhdhhbFDYu+sJP94gEHdLYSsJV3GSlPhhnsCOeWpdDUY
 ghTalOu+YKxgdDPc7N9M8aoNb0ZeqIttykBzzjczBf6A/nvET2q+weKr8U9p8o6HYdqjvyt
 tBfM873pYpnNBTFIxhY5Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qV74urjaVEI=:11sMX02r1P0Qa1n6uRZ+7l
 EbGI89PFidK00K9Gvk2J+uxK8Hxqyvk3XSMVHIG3G9xZ/+ScIN7B3Nu7QTAg6c5FXjfx38zuA
 Hmjp9HgzGZn0oYYF/gXkfvJ5IxgNA0o/sLDfDHqKsl7gT5eQbSu4cnahA+sa8RMU/m9g43abC
 7uI0CloszxM+Qvzn2wJYq0RpYDIyykHKjvqI4j8PuAhrVdERl6dVw0gqsjDJ/3JtcCn0QZ76m
 lRRrRs+NuAKhp7auT2pVvZQ4lC1PyO9otAsNhEb/12a+HjVlUF/00aVb/YweOEopyu6a6R9vg
 MiqBnmwC3nEfE0cLf7yzDFTl0TCUgRQ69fIuigjYuBJse7YAUxiz/RDTada0ay0fdRPaK4OaJ
 5YuhoQYDkvZ1L2Nq8JDzA94YP1v4K1at42qPwJielkC+fm5B+uNn9hjkS1zKBuCaTwTE2OYOR
 7/OekpFiBPHLG1cntkRznMdbZsvbfDgpu+oppL8VTl1nIcRfCTAl9BLtOM21IK5rVLzUqjAPG
 VM5FIaYCwzdSMyLZCyhLH7F72HZi0vHt//shsoc4qYZsqRVrjNtqB2U1dyuP1nJRiOnPWIcql
 pi9FrTY2YR34ZUuHtzaspeM96NJxFlUH3+KR6m+QXsYyc4K4tTUtTjl1YzoIaWAZL/A3ft3sL
 LJsaLhU1GoLm7N1nxV5rKYXxC5BRJVPRxTKAYEQuZjMXj+AJVCggqVZZfM0PHMV2gHsuRs7DW
 gwGmCq/Q5MaHH6rF9VMWI10fqainzxpbIZs+7vhHte+DbcVEuexKyWY2b0LTNcjhz9ELMg018
 kBk5rXm8nZgB+rWrqU7xrnz3olwzrYQZkgQl23u9y6tQxW9LgcSkEP727kW1HbTGfG4HpEB
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 30.06.21 17:36, Thiago Macieira wrote:

Hi,

>> Does anyone here know why they designed this as inline operations ? This
>> thing seems to be pretty much what typical TPUs are doing (or a subset
>> of it). Why not just adding a TPU next to the CPU on the same chip ?
> 
> To be clear: this is a SW ABI. It has nothing to do the presence or absence of
> other processing units in the system.

Well, if I'm correct, it's needed because there is some additional unit
whose state need to be saved. And that again necessary, because this
unit is controlled directly by the usual CPU instruction stream (in
contrast to separately programmed devices like a gpu, sdma, etc).

> The moment you receive a Unix signal with SA_SIGINFO, the mcontext state needs
> to be saved somewhere. Where would you save it? Please remember that:
> 
> - signal handlers can be called at any point in the execution, including
>    in the middle of malloc()
> - signal handlers can longjmp out of the handler back into non-handler code
> - in a multithreaded application, each thread can be handling a signal
>    simultaneously

Yes, the last part seems to be the most tricky point.

If we were only talking about kernel controlled context switches (task
switches) and sighandler always return to the kernel, then the kernel
could handle that all internally, w/o userland never knowing it. But
unfortunately that's not the case :(

>>> Userspace will have to do something like:
>>>    - check CPUID, if !AMX -> fail
>>>    - issue prctl(), if error -> fail
>>>    - issue XGETBV and check the AMX bit it set, if not -> fail
>>
>> Can't we to this just by prctl() call ?
>> IOW: ask the kernel, who gonna say yes or no.
> 
> That's possible. The kernel can't enable an AMX state on a system without AMX.

Good, that could at least make the API somewhat simpler.

>>>    - request the signal stack size / spawn threads
>>
>> Signal stack is separate from the usual stack, right ?
>> Why can't this all be done in one shot ?
> 
> Yes, we're talking about the sigaltstack() call.
> 
> What is "this all" in the sentence above?

Taking care of big large enough signal stack along with enabling AMX in
one shot. This might not support all kind of uses of sigaltstack(), but
do really need to support that all ?

IMHO, the whole AMX issue is just for *new* software (and I haven't seen
practical use of alternative sighandler stack for aeons), so it's not
about compatibility to existing software. Theoretically we could declare
the combination AMX and sigaltstack() just isn't supported. (Of course,
some combinations of using old libraries might break - but even if old
library code is reused, it's still new software).

Maybe not a completely satisfying idea, but perhaps something that's
much easier to achieve and gets the actual problem solved.


--mtx

-- 
---
Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schlüssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
