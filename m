Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 025213AE1D7
	for <lists+linux-arch@lfdr.de>; Mon, 21 Jun 2021 05:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhFUDVE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 20 Jun 2021 23:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbhFUDVE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 20 Jun 2021 23:21:04 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D968C061756;
        Sun, 20 Jun 2021 20:18:50 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id a127so2006751pfa.10;
        Sun, 20 Jun 2021 20:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=bEMA3Fn9G78MJjOLATMzSr4FKpTvjeDpYpynuiBu+GA=;
        b=PS/fyHWzLBT1/zodXO4xLg84QbHysEnQVTc3dv5WCMuUobaxp6DjQ540et46Alwz6U
         u5YqcrE7lDRnJDFFQPDZk7+B8Vp6hDXnRyrXGUEzQCp1goLnuT+ys9Sh1vxhaWDW+82z
         330ohDW3yPJiBQ11QXqp5A6seYVO0rSKK2CDCvGenxUPtIXmmEMTAZ4NX+F2BqEiMXl+
         3wlBvZuws+TG9TSYLdoxGBWWzLchUp7NE0mel+oO0ADhlz8jwZaLOdJR2f/f+y9lFwKI
         4HlFdk/pYc2z70DywQwdpOj9mhF0lCT0S7Wk1VCVmTf9MJ2RruOrFzv6tR46qq4HxZ8f
         I9hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=bEMA3Fn9G78MJjOLATMzSr4FKpTvjeDpYpynuiBu+GA=;
        b=PH/neJql68A/7ZJ0Bdrc8erSkxKgUXVa8kP6d3RqJXRQtdx1WpB0v7E6lsZ8KaTHBB
         WURGn2G44I1oW5CfcCjdKsrinSz6BFN0/sMizWI6KC7XuH76SXQ6MQIWjlBzQrVMfchJ
         hBLvZfAq6c5TXyZVKdBow43yqVZDWRreuIkjULlerLF5bQcTfac0XuLv74iqBbeLwiwa
         M0o1UNR7QkT/fZ2BsukYvy6BeqgOA1s3ajDtSYOhhJcgmYKK0s5Q3EIYsKz06Ld4ftp7
         g/M6VeEwicxx3TLoJaaSn1jLahV8CJ/rOwl5E9mBNaxZsSMtgisE2R7x8FGK4CGve/lP
         MtRA==
X-Gm-Message-State: AOAM532ah2fzN3pwjJK1jI8U/pHJCRMREZP2801DGUly8PfxPr3eH2NS
        IfB+Y+mJWUGgmrZnwV+rsjQ=
X-Google-Smtp-Source: ABdhPJyUfWEv5BoYwOgWVygbT6EiyTPosdGk4TH3uOWQjG4bExdI4KdIy6JNOvUBApYgYKKgt24h6w==
X-Received: by 2002:a62:1e82:0:b029:2f9:aad3:b368 with SMTP id e124-20020a621e820000b02902f9aad3b368mr17509192pfe.79.1624245529816;
        Sun, 20 Jun 2021 20:18:49 -0700 (PDT)
Received: from [10.1.1.25] (222-152-189-137-fibre.sparkbb.co.nz. [222.152.189.137])
        by smtp.gmail.com with ESMTPSA id x13sm13379004pjh.30.2021.06.20.20.18.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Jun 2021 20:18:49 -0700 (PDT)
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
Message-ID: <60c0fe00-b966-6385-d348-f6dd45277113@gmail.com>
Date:   Mon, 21 Jun 2021 15:18:35 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wip8KgrNUcU68wsLZqbWV+3NWg9kqqQwygHGAA8-xOwMA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Linus,

Am 21.06.2021 um 14:17 schrieb Linus Torvalds:
> On Sun, Jun 20, 2021 at 7:01 PM Michael Schmitz <schmitzmic@gmail.com> wrote:
>>
>> instrumenting get_reg on m68k and using a similar patch to yours to warn
>> when unsaved registers are accessed on the switch stack, I get a hit
>> from getegid and getegid32, just by running a simple ptrace on ls.
>>
>> Going to wack those two moles now ...
>
> I don't see what's going on. Those system calls don't use the register
> state, afaik. What's the call chain, exactly?

This is what I get from WARN_ONCE:

------------[ cut here ]------------
WARNING: CPU: 0 PID: 1177 at arch/m68k/kernel/ptrace.c:91 get_reg+0x90/0xb8
Modules linked in:
CPU: 0 PID: 1177 Comm: strace Not tainted 
5.13.0-rc1-atari-fpuemu-exitfix+ #1146
Stack from 014b7f04:
         014b7f04 00336401 00336401 000278f0 0032c015 0000005b 00000005 
0002795a
         0032c015 0000005b 0000338c 00000009 00000000 00000000 ffffffe4 
00000005
         00000003 00000014 00000003 00000014 efc2b90c 0000338c 0032c015 
0000005b
         00000009 00000000 efc2b908 00912540 efc2b908 000034cc 00912540 
00000005
         00000000 efc2b908 00000003 00912540 8000110c c010b0a4 efc2b90c 
0002d1d8
         00912540 00000003 00000014 efc2b908 0000049a 00000014 efc2b908 
800acaa8
Call Trace: [<000278f0>] __warn+0x9e/0xb4
  [<0002795a>] warn_slowpath_fmt+0x54/0x62
  [<0000338c>] get_reg+0x90/0xb8
  [<0000338c>] get_reg+0x90/0xb8
  [<000034cc>] arch_ptrace+0x7e/0x250
  [<0002d1d8>] sys_ptrace+0x232/0x2f8
  [<00002ab6>] syscall+0x8/0xc
  [<0000c00b>] lower+0x7/0x20

---[ end trace ee4be53b94695793 ]---

Syscall numbers are actually 90 and 192 - sys_old_mmap and sys_mmap2 on 
m68k. Used the calculator on my Ubuntu desktop, that appears to be a 
little confused about hex to decimal conversions.

I hope that makes more sense?

Cheers,

	Michael

>
>            Linus
>
