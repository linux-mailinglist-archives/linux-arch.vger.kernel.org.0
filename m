Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02A803B826D
	for <lists+linux-arch@lfdr.de>; Wed, 30 Jun 2021 14:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234622AbhF3MxR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 30 Jun 2021 08:53:17 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:36361 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234481AbhF3MxR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 30 Jun 2021 08:53:17 -0400
Received: from [192.168.1.155] ([95.114.41.241]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MYtoe-1llI192cam-00UojT; Wed, 30 Jun 2021 14:50:31 +0200
Subject: Re: x86 CPU features detection for applications (and AMX)
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thiago Macieira <thiago.macieira@intel.com>, fweimer@redhat.com,
        hjl.tools@gmail.com, libc-alpha@sourceware.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        x86@kernel.org
References: <22261946.eFiGugXE7Z@tjmaciei-mobl1>
 <3c5c29e2-1b52-3576-eda2-018fb1e58ff9@metux.net>
 <YNnMsJJzI83cpnAQ@hirez.programming.kicks-ass.net>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <534d0171-2cc5-cd0a-904f-cd3c499b55af@metux.net>
Date:   Wed, 30 Jun 2021 14:50:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YNnMsJJzI83cpnAQ@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:f8wD1L5OnG5ZOsE+tGbUEtQNOAfBnMFdUohoZ6kW/kxSGkfL+Te
 /GhbzcOAkyCqhN+6Q12lAdLx0dMHoClZJOIKOtfJu2BuIH23NUZOq22OFybpQnc1mGGwPZ1
 ZJgsiwzeL8GBKsP0nIpL5Y8AisWANpQUHgYngvFA8rhB80DGCyqhDMo87kCFgeQhCWzwZHo
 nU26D+SS/elEl7WIemcxQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:C8iwSlPCzpw=:lEoyWAgaSI5BgD6fxu/Yl3
 eTnnDUemKypufZE7hCMa/u1thpekjxN5ryEywwcbMLVhp9MPHtB5+so7dMU0ncz0Z3I0O/zce
 SdRX2YevS/BXqTrxsXsdl1uhdKBueTDIA9OuzYjj9g0U2GaZAYrOWHnwLveY8UCD5OAimJJsN
 GzrzCiKdfQLOjge29p9bYLh+nPlBNpTVx1YYo9UzdcdhS3BeGEDhYMFYiF9N78qMhIHAVTmx7
 Sd0wyE9DXkYNVVLhWxY+K9e++zYxwqOCxLm6x6UNoH2qtSDAzwaVWv8kgXNClt2efthR1Co+C
 qGJ/HSiPGeAVd9ROGxJvAXxsYwF7V+JFeMgcp12NZvMoO2yKl8RnY7qlPX4rdVHeU+o6JnGNr
 iRca/gOy9NmdQ2ukT6vsUT9eYgr+XGzQYoAF9SoCNJLGUUF3r6tXxFyx58kMtuvJ5rKrJlMRt
 7/q3KpFzOtnJiHsdPr7+3f6/fD77Rm/XlEAakOw0QqMVekjLk5xscflCWvRY7yWdUV2MF3yD2
 fTx6ro8o1J6GZrHo2ahCZUv6I+1nLljsPUvOa7LmNmZcriwHchPyXkUpCOE9aYvTGHI4WTiCG
 odiWx66s21E3cg3mvrSQAqyDR+vScyiS/1uY7xkfWTIneOl/7f22uGt0URtUdSdpvUhHz2ddJ
 7OsgXzC9NNo42/Wyrrq8ifu4qFC3i62XSTmj6RUD0Oig0R7kbF9JDEfPgrjnlyHv4LGCgtR0Y
 6+QWcJt58F/P/cGbyvHC3bedJiMNTuZu1+EPAQk2EHhAS21iRPLDxcsWwBE79JbUL6I021uni
 EeSxsZLC0rBtaDPdYbYXW+BambhiSdk4+FQYZujL7hLJBj3u1Hu/NNP0xtpdx34PxC9TbtX
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 28.06.21 15:20, Peter Zijlstra wrote:

>> And one point that immediately jumps into my mind (w/o looking deeper
>> into it): it introduces completely new registers - do we now need extra
>> code for tasks switching etc ?
> 
> No, but because it's register state and part of XSAVE, it has immediate
> impact in ABI. In particular, the signal stack layout includes XSAVE (as
> does ptrace()).

OMGs, I've already suspected such sickness. I don't even dare thinking
about consequences for compilers and library ABIs.

Does anyone here know why they designed this as inline operations ? This
thing seems to be pretty much what typical TPUs are doing (or a subset
of it). Why not just adding a TPU next to the CPU on the same chip ?

We already have the same w/ GPUs, and I guess nobody seriously wants to
put GPU functionality directly into CPU.

> At the same time, 'legacy' applications (up until _very_ recently) had a
> minimum signal stack size of 2K, which is already violated by the
> addition of AVX512 (there's actual breakage due to that).

grmpf!

> Adding the insane AMX state (8k+) into that is a complete trainwreck
> waiting to happen. Not to mention that having !INIT AMX state has direct
> consequences for P-state selection and thus performance.

Uh, are those new registers retained in certain sleep states or do they
need to be saved somewhere ?

> For these reasons, us OS folks, will mandate you get to do a prctl() to
> request/release AMX (and we get to say: no). If you use AMX without
> this, the instruction will fault (because not set in XCR0) and we'll
> SIGBUS or something.
> 
> Userspace will have to do something like:
> 
>   - check CPUID, if !AMX -> fail
>   - issue prctl(), if error -> fail
>   - issue XGETBV and check the AMX bit it set, if not -> fail

Can't we to this just by prctl() call ?
IOW: ask the kernel, who gonna say yes or no.

Are there any situations where kernel says yes, but process still can't
use it ? Why so ?

>   - request the signal stack size / spawn threads

Signal stack is separate from the usual stack, right ?
Why can't this all be done in one shot ?

>   - use AMX
> 
> Spawning threads prior to enabling AMX will result in using the wrong
> signal stack size and result in malfunction, you get to keep the pieces.

No way of adjusting this once the threads are running ?
Or could we even do that on per-thread basis ?

A thread here always has a corresponding kernel task, correct ?

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
