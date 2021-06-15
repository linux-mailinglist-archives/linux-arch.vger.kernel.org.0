Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E847C3A8A7B
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jun 2021 22:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbhFOU6w (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Jun 2021 16:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbhFOU6v (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Jun 2021 16:58:51 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DBDC061574;
        Tue, 15 Jun 2021 13:56:45 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 22-20020a17090a0c16b0290164a5354ad0so2626095pjs.2;
        Tue, 15 Jun 2021 13:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=sBxLxf4FrcsggEOYTT1dFKc27Ben3JcpMZ+iTHfSh4M=;
        b=qoOPzfCWsyStJrRTj3ypUmLWs9KaVh+ew/9w7Gc5TP4nnZNPghDlsVSApsafxGQD6c
         c7OgbmhU2BGKtsYhZ+6cXCZ0BW1t35QwpzzEVRT2Ad3RlYx/2Yot2XoaH/g1y63nbYPT
         4ewM2wWuQvk81/v/Ykalqh3IJjnuFQ1CLAz2SIjIfFzrL2zxgm2/GEfNu79rIXWaYAyI
         IQKVYw3f+KOLPEAQj/A7RoYydAHO29/vHTCPS/LRQ+TBLs9Ve1aotzmLKJ0fBxkNxlBY
         V0WN6qYalvfZN980nCq5a0KEU7YQcGUNsohKLzvD7Oyek+5fOatozOwOM505e3f7R0GL
         144w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=sBxLxf4FrcsggEOYTT1dFKc27Ben3JcpMZ+iTHfSh4M=;
        b=bCz6GyI+BTMLu+hakLuw0A5EL6mpyZKEXmpsWLuSnc8wlxwvHSRNGo5p3h9wOY/dzi
         txDjZC2Vkbuv1ee9qts+f40RuBY53b7CcfqtRUenb6Tmvrvp4sK2CQMkOcgM/2ECGtvA
         jX5Tz6DogoSyAVSnHwDkLPS3g3b77Yn2uwxJoWDgB4QiJfAMZ+WYCw5DsNnZ8e6aPWTH
         IK5hK9XtRaDtlvnLOwuCEVpnY/txqHVVE2umZi9pWYd4EKu1+kG/VsOcrWbSF3g2IwQt
         TW+71VgXHDzozqyebIjqKF/KZf90QDeAoUrbPiUb27+Mt9EH8D+hhviQdJpWN4DbSxss
         Z73w==
X-Gm-Message-State: AOAM530EMd+AXYees6QfpQwoBJimp25Q8yB/PPDAGxYvELuVf6WM3zcG
        DXOhrCkUB0RGXJhCxViV4Eg=
X-Google-Smtp-Source: ABdhPJwEoBFJCqsJN9Ngtn3AEnJkmhk6VKaEKlb2sY5dc88HZY9v7ucXItvBEjdeef4GIdJu8K9cJw==
X-Received: by 2002:a17:902:b181:b029:fc:c069:865c with SMTP id s1-20020a170902b181b02900fcc069865cmr5981998plr.28.1623790605160;
        Tue, 15 Jun 2021 13:56:45 -0700 (PDT)
Received: from ?IPv6:2001:df0:0:200c:a550:e6ef:8525:d5e0? ([2001:df0:0:200c:a550:e6ef:8525:d5e0])
        by smtp.gmail.com with ESMTPSA id s11sm3369427pjz.42.2021.06.15.13.56.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jun 2021 13:56:44 -0700 (PDT)
Subject: Re: Kernel stack read with PTRACE_EVENT_EXIT and io_uring threads
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
        Tejun Heo <tj@kernel.org>, Kees Cook <keescook@chromium.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
References: <87sg1p30a1.fsf@disp2133>
 <CAHk-=wjiBXCZBxLiCG5hxpd0vMkMjiocenponWygG5SCG6DXNw@mail.gmail.com>
 <87pmwsytb3.fsf@disp2133>
 <CAHk-=wgdO5VwSUFjfF9g=DAQNYmVxzTq73NtdisYErzdZKqDGg@mail.gmail.com>
 <87sg1lwhvm.fsf@disp2133>
 <CAHk-=wgsnMTr0V-0F4FOk30Q1h7CeT8wLvR1MSnjack7EpyWtQ@mail.gmail.com>
 <6e47eff8-d0a4-8390-1222-e975bfbf3a65@gmail.com>
 <924ec53c-2fd9-2e1c-bbb1-3fda49809be4@gmail.com> <87eed4v2dc.fsf@disp2133>
 <5929e116-fa61-b211-342a-c706dcb834ca@gmail.com> <87fsxjorgs.fsf@disp2133>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <7277aa4b-5d3f-6bb3-379a-470df4addd15@gmail.com>
Date:   Wed, 16 Jun 2021 08:56:35 +1200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87fsxjorgs.fsf@disp2133>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Eric,

On 16/06/21 7:30 am, Eric W. Biederman wrote:
>
>>> The io_uring tasks are special in that they are user process
>>> threads that never run in userspace.  So as long as everything
>>> ptrace can read is accessible on that process all is well.
>> OK, I'm testing a patch that would save extra context in sys_io_uring_setup,
>> which ought to ensure that for m68k.
> I had to update ret_from_kernel_thread to pop that state to get Linus's
> change to boot.  Apparently kernel_threads exiting needs to be handled.

Hadn't yet got to that stage, sorry. Still stress testing stage 1 of my 
fix (push complete context). I would have thought that this should be 
sufficient (gives us a complete stack frame for ptrace code to work on)?

But it makes sense that when you push an extra stack frame, you'd need 
to pop that on exit.

>
>>> Having stared a bit longer at the code I think the short term
>>> fix for both of PTRACE_EVENT_EXIT and io_uring is to guard
>>> them both with CONFIG_HAVE_ARCH_TRACEHOOK.
> Which does not work because nios2 which looks susceptible
> sets CONFIG_HAVE_ARCH_TRACEHOOK.
>
> A further look shows that there is also PTRACE_EVENT_EXEC that
> needs to be handled so execve and execveat need to be wrapped
> as well.
>
> Do you happen to know if there is userspace that will run
> in qemu-system-m68k that can be used for testing?

I surmise so. I don't use qemu myself - either ARAnyM, or actual 
hardware. Hardware is limited to 14 MB RAM, which has prevented me from 
using more than simple regression testing. In particular, I can't test 
sys_io_uring_setup there.

Adrian uses qemu a lot, and has supplied disk images to work from on 
occasion. Maybe he's got something recent enough to support 
sys_io_uring_setup ... I've CC:ed him in, as I'd love to do some more 
testing as well.

Cheers,

     Michael

>
> Eric
>
