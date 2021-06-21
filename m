Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E02673AE20C
	for <lists+linux-arch@lfdr.de>; Mon, 21 Jun 2021 06:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbhFUELj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Jun 2021 00:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbhFUELi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Jun 2021 00:11:38 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0202AC061760;
        Sun, 20 Jun 2021 21:08:46 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso9476747pjx.1;
        Sun, 20 Jun 2021 21:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=F9odJSZJ3JHPCDq5xWJRw+RMGbd9Q+9zPppzBJyCxj4=;
        b=Eho+Hv3biN4uuSiZMxo0AjUNa9n+ziDPIuyDrm4TVlHFw2x+yxKEQi7R8uZS5S9XNk
         gGgEAY96ZGN7wRhP53985TAMlMuEZfbZLbo2EkhHMls4CW8p7PdmYz1Cai5kkoswAZ9k
         gYBovh0PHzAkx9wudrQVZ0L01Ha8zSx6asccS+ynHXLe519RNSWSkK/OS03dv0NUgSy2
         z3CES8B12c2YuTbQMdxiyKGHKbvEt7uOdZGxNuQi6aD0jEIYM/7NhB/xYLnZHkm//IAI
         T8Wg9Z4swG5YS40bp0Ki/q5lMWliWOe+1KDUR8mH/5KcL0dLqru00c2OduyIF3kp8yXw
         0bog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=F9odJSZJ3JHPCDq5xWJRw+RMGbd9Q+9zPppzBJyCxj4=;
        b=ZO+GtVM8XVvBY0mgc5ZSlK8LrDI9SV0Cl0eHnCj33ggn293elDbvRXp+kTg8NRiujc
         LUddRKZ3aZT8HSJLH/RQ+yxdIJ4lFmhxtBSJfwM4ONgbwasPa00XohTWcJpk59OONyIP
         wkkh8/DjZusUN+pTc6ugVcNeve9CAbIdAgn/6o/mqxDPuyqHnaCB8LGsI6QmVibSmCYI
         r424qJtXM6TBKRdPlfAh2YwmfVcS1Y2i7ght1VqscdQfAfmUyXh37OH9OS3WWMCjF2ds
         tGpFQe0vtjkQGWJKmRCU5pptfyYP1l3mTZbLipqJ2vwpWxwMBb9aeqv+EweiKG4a3rGh
         Kmeg==
X-Gm-Message-State: AOAM533BzMeBjFLZS21MXyAoV9pusSFFTiHIDrZ86OX3ifQI9jprAKFp
        1pgtYr7dpEa1uLTc+g5Z2dQ=
X-Google-Smtp-Source: ABdhPJx8ZSafpEjeeaqZN3ftOU8quVv9gvFZrfb/yQUnBXqIgG7UCE6Zgji4G5+tQELlU15J4Gpl1w==
X-Received: by 2002:a17:90b:3543:: with SMTP id lt3mr20761516pjb.115.1624248525918;
        Sun, 20 Jun 2021 21:08:45 -0700 (PDT)
Received: from [10.1.1.25] (222-152-189-137-fibre.sparkbb.co.nz. [222.152.189.137])
        by smtp.gmail.com with ESMTPSA id z6sm14946663pgs.24.2021.06.20.21.08.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Jun 2021 21:08:45 -0700 (PDT)
Subject: Re: [PATCH 1/2] alpha/ptrace: Record and handle the absence of
 switch_stack
To:     Linus Torvalds <torvalds@linux-foundation.org>
References: <87sg1p30a1.fsf@disp2133>
 <CAHk-=wjiBXCZBxLiCG5hxpd0vMkMjiocenponWygG5SCG6DXNw@mail.gmail.com>
 <87pmwsytb3.fsf@disp2133>
 <CAHk-=wgdO5VwSUFjfF9g=DAQNYmVxzTq73NtdisYErzdZKqDGg@mail.gmail.com>
 <87sg1lwhvm.fsf@disp2133>
 <CAHk-=wgsnMTr0V-0F4FOk30Q1h7CeT8wLvR1MSnjack7EpyWtQ@mail.gmail.com>
 <6e47eff8-d0a4-8390-1222-e975bfbf3a65@gmail.com>
 <924ec53c-2fd9-2e1c-bbb1-3fda49809be4@gmail.com> <87eed4v2dc.fsf@disp2133>
 <5929e116-fa61-b211-342a-c706dcb834ca@gmail.com> <87fsxjorgs.fsf@disp2133>
 <87zgvqor7d.fsf_-_@disp2133>
 <CAHk-=wir2P6h+HKtswPEGDh+GKLMM6_h8aovpMcUHyQv2zJ5Og@mail.gmail.com>
 <87mtrpg47k.fsf@disp2133> <87pmwlek8d.fsf_-_@disp2133>
 <87k0mtek4n.fsf_-_@disp2133> <393c37de-5edf-effc-3d06-d7e63f34a317@gmail.com>
 <CAHk-=wip8KgrNUcU68wsLZqbWV+3NWg9kqqQwygHGAA8-xOwMA@mail.gmail.com>
 <60c0fe00-b966-6385-d348-f6dd45277113@gmail.com>
 <CAHk-=wgTGW0Q0BzpSJcLhseui1fH7Gbasvsz81Z89CMSAHE-Bw@mail.gmail.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        alpha <linux-alpha@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Tejun Heo <tj@kernel.org>, Kees Cook <keescook@chromium.org>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <700d8acd-d3df-a026-8b1d-55eeae836eea@gmail.com>
Date:   Mon, 21 Jun 2021 16:08:35 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgTGW0Q0BzpSJcLhseui1fH7Gbasvsz81Z89CMSAHE-Bw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Linus,

I realized that the patch is still incomplete when answering Al...

Am 21.06.2021 um 15:37 schrieb Linus Torvalds:
> On Sun, Jun 20, 2021 at 8:18 PM Michael Schmitz <schmitzmic@gmail.com> wrote:
>>
>> I hope that makes more sense?
>
> So the problem is in your debug patch: you don't set that
> TIS_SWITCH_STACK in nearly enough places.
>
> In this particular example, I think it's that you don't set it in
> do_trace_exit, so when you strace the process, the system call exit -
> which is where the return value will be picked up - gets that warning.
>
> You did set TIS_SWITCH_STACK on trace_entry, but then it's cleared
> again during the system call, and not set at the trace_exit path.
> Oddly, your debug patch also _clears_ it on the exit path, but it
> doesn't set it when do_trace_exit does the SAVE_SWITCH_STACK.
>
> You oddly also set it for __sys_exit, but not all the other special
> system calls that also do that SAVE_SWITCH_STACK.

That's the one I used to test whether my debug patch had any ill side 
effects (i.e. smashing the stack) late yesterday. Forgot to add that to 
the other cases.

>
> Really, pretty much every single case of SAVE_SWITCH_STACK would need
> to set it. Not just do_trace_enter/exit

Yes - done that now and the warning is gone.

> It's why I didn't like Eric's debug patch either. It's quite expensive
> to do, partly because you look up that curptr thing. All very nasty.

I need to talk to Geert and Andreas to find where register a1 is 
preserved, but if I have to reload a1 all the time, this won't be useful 
except for debugging.

> It would be *much* better to make the flag be part of the stack frame,
> but sadly at least on alpha we had exported the format of that stack
> frame to user space.

Same on m68k, but can we push a flag _after_ the switch stack?

> Anyway, I think these debug patches are not just expensive but the
> m68k one most definitely is also very incomplete.

Yes, I've seen that in the meantime. Need to triple check my work next 
time.

Sorry for the extra noise!

Cheers,

	Michael

>
>              Linus
>
