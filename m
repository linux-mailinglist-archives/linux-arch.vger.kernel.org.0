Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9132511478F
	for <lists+linux-arch@lfdr.de>; Thu,  5 Dec 2019 20:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbfLETU4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 Dec 2019 14:20:56 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40244 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfLETUz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 Dec 2019 14:20:55 -0500
Received: by mail-oi1-f196.google.com with SMTP id 6so3808738oix.7
        for <linux-arch@vger.kernel.org>; Thu, 05 Dec 2019 11:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4yV+umxVyxp5Mb2HYWi0wAWxdwihlH+FLOLypRAoavA=;
        b=v4ta/HTVZmDiyfFTTC5LhLhiUOyLOYHST6UYYUNMQtBo54lBue/3JPrhHhZKvGTBD+
         a51vR5HAYXo1cFZHrGTEzo+NPTjGLQDR8kCQwr6oztJIaN8XRf7GYi4TsljEXcw6gGKv
         YGnEcCdlS0+S1RTCgm0ZZt9FAEJBk0tNhbVTfj9JrDIuOQ5ldLArQJO5Wxl5f42XF9nS
         tiePfGKHQxDTHyMxN7Wv6N+OHP/YeUAHOZCIUAptjPI17saPvvPkQYPAor2meRxjPYVy
         Mf5reT22pAhYRF9TXHBAUwsmz5qq1G2PqgJvFWLceQfLBDEiY09YcWayUI7oQQTjQs8l
         COtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4yV+umxVyxp5Mb2HYWi0wAWxdwihlH+FLOLypRAoavA=;
        b=oQksMqNQF274nOg0zrsZeTtwLBN92x8VXfzxJ0AJmju/eWv148Jj9WuAuDJ3UDLqDd
         lxE2mMeTtXz1XG18HIbZCinPVoZOErr+0mnyhcXnp8mNubOCYi8mmOJzbGlAYYapvnD+
         BvX1cCSQUDRjS33Cnds7zq/JeUdpyc6hZFCTuk1EU0uGe+gZLKU4FRuI0AZV/MFOaogl
         ciVolGjwKUf8tslEgMrOqhK8fTvhoX4ipe1tzIK/GLYOLhMPq8EPt1WQS9djMqNh+kDF
         kkSZKEE0uNvXqUnxgL+xfF54lhR6nNxMUx3mT7XqCLUiAdUDXCmkC6sL0w1YKCVP/5bP
         alHQ==
X-Gm-Message-State: APjAAAXlmC9JlbAdI0/BLYvHBEQiNSXW8/CT/SWAMRG9FdH8w9F4E+6i
        Tlc2IdCESKx/4EIOzUr4O43Fcw==
X-Google-Smtp-Source: APXvYqxSAZn7yskgyF4hY2x+zDFHc1x9kx/3qY5XGkP+CwZZSGO3a5P1NSuWeZ//2xVCH3qTV0dGgQ==
X-Received: by 2002:aca:c146:: with SMTP id r67mr8812840oif.61.1575573653971;
        Thu, 05 Dec 2019 11:20:53 -0800 (PST)
Received: from ?IPv6:2607:fb90:d77:c7b2:6680:99ff:fe6f:cb54? ([2607:fb90:d77:c7b2:6680:99ff:fe6f:cb54])
        by smtp.googlemail.com with ESMTPSA id 61sm3696236oti.5.2019.12.05.11.20.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Dec 2019 11:20:53 -0800 (PST)
Subject: Re: [PATCH v6 10/18] sh/tlb: Convert SH to generic mmu_gather
To:     Peter Zijlstra <peterz@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Rik van Riel <riel@surriel.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
References: <20190219103148.192029670@infradead.org>
 <20190219103233.443069009@infradead.org>
 <CAMuHMdW3nwckjA9Bt-_Dmf50B__sZH+9E5s0_ziK1U_y9onN=g@mail.gmail.com>
 <20191204104733.GR2844@hirez.programming.kicks-ass.net>
From:   Rob Landley <rob@landley.net>
Message-ID: <e2cf6780-ba7e-d6f6-9d15-92e182f98e84@landley.net>
Date:   Thu, 5 Dec 2019 13:24:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191204104733.GR2844@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 12/4/19 4:47 AM, Peter Zijlstra wrote:
> On Tue, Dec 03, 2019 at 12:19:00PM +0100, Geert Uytterhoeven wrote:
>> Hoi Peter,
>>
>> On Tue, Feb 19, 2019 at 11:35 AM Peter Zijlstra <peterz@infradead.org> wrote:
>>> Generic mmu_gather provides everything SH needs (range tracking and
>>> cache coherency).
>>>
>>> Cc: Will Deacon <will.deacon@arm.com>
>>> Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: Nick Piggin <npiggin@gmail.com>
>>> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
>>> Cc: Rich Felker <dalias@libc.org>
>>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>>
>> I got remote access to an SH7722-based Migo-R again, which spews a long
>> sequence of BUGs during userspace startup.  I've bisected this to commit
>> c5b27a889da92f4a ("sh/tlb: Convert SH to generic mmu_gather").
> 
> Whoopsy.. also, is this really the first time anybody booted an SH
> kernel in over a year ?!?

No, but most people running this kind of hardware tend not to upgrade to current
kernels on a regular basis.

The j-core guys tested the 5.3 release. I can't find an email about 5.4 so I
dunno if that's been tested yet?

I just tested yesterday's git and it works fine with
http://lkml.iu.edu/hypermail/linux/kernel/1912.0/01554.html installed, modulo it
_still_ has the suprious stack dump shortly before calling init, which I've
complained about on linux-sh and off for a year now?

------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at mm/slub.c:2451 kmem_cache_free_bulk+0x2c2/0x37c

CPU: 0 PID: 1 Comm: swapper Not tainted 5.4.0 #1
PC is at kmem_cache_free_bulk+0x2c2/0x37c
PR is at kmem_cache_alloc_bulk+0x36/0x1a0
PC  : 8c0a6fae SP  : 8f829e9c SR  : 400080f0
TEA : c0001240
R0  : 8c0a6de4 R1  : 00000100 R2  : 00000100 R3  : 00000000
R4  : 8f8020a0 R5  : 00000dc0 R6  : 8c01d66c R7  : 8fff5180
R8  : 8c011a00 R9  : 8fff5180 R10 : 8c01d66c R11 : 80000000
R12 : 00007fff R13 : 00000dc0 R14 : 8f8020a0
MACH: 0000017a MACL: 0ae4849d GBR : 00000000 PR  : 8c0a709e

Call trace:
 [<(ptrval)>] copy_process+0x218/0x1094
 [<(ptrval)>] copy_process+0x7ba/0x1094
 [<(ptrval)>] kmem_cache_alloc_bulk+0x36/0x1a0
 [<(ptrval)>] restore_sigcontext+0x94/0x1b0
 [<(ptrval)>] restore_sigcontext+0x70/0x1b0
 [<(ptrval)>] copy_process+0x218/0x1094
 [<(ptrval)>] sysfs_slab_add+0x106/0x354
 [<(ptrval)>] restore_sigcontext+0x70/0x1b0
 [<(ptrval)>] copy_process+0x218/0x1094
 [<(ptrval)>] copy_process+0x218/0x1094
 [<(ptrval)>] fprop_fraction_single+0x38/0xa4
 [<(ptrval)>] pipe_read+0x7a/0x23c
 [<(ptrval)>] restore_sigcontext+0x70/0x1b0
 [<(ptrval)>] restore_sigcontext+0x94/0x1b0
 [<(ptrval)>] alloc_pipe_info+0x162/0x1c8
 [<(ptrval)>] restore_sigcontext+0x94/0x1b0
 [<(ptrval)>] restore_sigcontext+0x70/0x1b0
 [<(ptrval)>] handle_bad_irq+0x154/0x188
 [<(ptrval)>] raw6_exit_net+0x0/0x14
 [<(ptrval)>] prepare_stack+0xe4/0x2fc
 [<(ptrval)>] sys_sched_get_priority_min+0x18/0x28
 [<(ptrval)>] ndisc_net_exit+0x4/0x24

---[ end trace 6ce4eefeb577b078 ]---

But it's cosmetic...

I haven't got one of the new Turtle boards yet (next time I visit Japan...) and
the USB connector broke off my old one, so I haven't got test hardware in my bag
to boot it on with me at this coffee shop. So just qemu testing at the moment.
The actual j-core deployment environment I'm working on this month is a deeply
embedded thing with 128k sram so isn't running Linux. :)

Rob
