Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49BBA22157F
	for <lists+linux-arch@lfdr.de>; Wed, 15 Jul 2020 21:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgGOTtd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Jul 2020 15:49:33 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:58545 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727096AbgGOTtc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 Jul 2020 15:49:32 -0400
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.93)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1jvnPF-000TRX-H1; Wed, 15 Jul 2020 21:49:29 +0200
Received: from p57bd93f9.dip0.t-ipconnect.de ([87.189.147.249] helo=[192.168.178.139])
          by inpost2.zedat.fu-berlin.de (Exim 4.93)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1jvnPF-0034x1-9Z; Wed, 15 Jul 2020 21:49:29 +0200
Subject: Re: [PATCH v6 10/18] sh/tlb: Convert SH to generic mmu_gather
To:     Rob Landley <rob@landley.net>,
        Peter Zijlstra <peterz@infradead.org>,
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
 <e2cf6780-ba7e-d6f6-9d15-92e182f98e84@landley.net>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Autocrypt: addr=glaubitz@physik.fu-berlin.de; keydata=
 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
 scOkTAZQGVpD/8AaLH4v1w==
Message-ID: <d42ed14e-fbe7-5731-a229-476560995a97@physik.fu-berlin.de>
Date:   Wed, 15 Jul 2020 21:49:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e2cf6780-ba7e-d6f6-9d15-92e182f98e84@landley.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.147.249
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Rob!

On 12/5/19 8:24 PM, Rob Landley wrote:
> No, but most people running this kind of hardware tend not to upgrade to current
> kernels on a regular basis.
> 
> The j-core guys tested the 5.3 release. I can't find an email about 5.4 so I
> dunno if that's been tested yet?
> 
> I just tested yesterday's git and it works fine with
> http://lkml.iu.edu/hypermail/linux/kernel/1912.0/01554.html installed, modulo it
> _still_ has the suprious stack dump shortly before calling init, which I've
> complained about on linux-sh and off for a year now?
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 1 at mm/slub.c:2451 kmem_cache_free_bulk+0x2c2/0x37c
> 
> CPU: 0 PID: 1 Comm: swapper Not tainted 5.4.0 #1
> PC is at kmem_cache_free_bulk+0x2c2/0x37c
> PR is at kmem_cache_alloc_bulk+0x36/0x1a0
> PC  : 8c0a6fae SP  : 8f829e9c SR  : 400080f0
> TEA : c0001240
> R0  : 8c0a6de4 R1  : 00000100 R2  : 00000100 R3  : 00000000
> R4  : 8f8020a0 R5  : 00000dc0 R6  : 8c01d66c R7  : 8fff5180
> R8  : 8c011a00 R9  : 8fff5180 R10 : 8c01d66c R11 : 80000000
> R12 : 00007fff R13 : 00000dc0 R14 : 8f8020a0
> MACH: 0000017a MACL: 0ae4849d GBR : 00000000 PR  : 8c0a709e
> 
> Call trace:
>  [<(ptrval)>] copy_process+0x218/0x1094
>  [<(ptrval)>] copy_process+0x7ba/0x1094
>  [<(ptrval)>] kmem_cache_alloc_bulk+0x36/0x1a0
>  [<(ptrval)>] restore_sigcontext+0x94/0x1b0
>  [<(ptrval)>] restore_sigcontext+0x70/0x1b0
>  [<(ptrval)>] copy_process+0x218/0x1094
>  [<(ptrval)>] sysfs_slab_add+0x106/0x354
>  [<(ptrval)>] restore_sigcontext+0x70/0x1b0
>  [<(ptrval)>] copy_process+0x218/0x1094
>  [<(ptrval)>] copy_process+0x218/0x1094
>  [<(ptrval)>] fprop_fraction_single+0x38/0xa4
>  [<(ptrval)>] pipe_read+0x7a/0x23c
>  [<(ptrval)>] restore_sigcontext+0x70/0x1b0
>  [<(ptrval)>] restore_sigcontext+0x94/0x1b0
>  [<(ptrval)>] alloc_pipe_info+0x162/0x1c8
>  [<(ptrval)>] restore_sigcontext+0x94/0x1b0
>  [<(ptrval)>] restore_sigcontext+0x70/0x1b0
>  [<(ptrval)>] handle_bad_irq+0x154/0x188
>  [<(ptrval)>] raw6_exit_net+0x0/0x14
>  [<(ptrval)>] prepare_stack+0xe4/0x2fc
>  [<(ptrval)>] sys_sched_get_priority_min+0x18/0x28
>  [<(ptrval)>] ndisc_net_exit+0x4/0x24
> 
> ---[ end trace 6ce4eefeb577b078 ]---
> 
> But it's cosmetic...

This is fixed by the following patch [1]:

sh: Fix unneeded constructor in page table allocation

The pgd kmem_cache allocation both specified __GFP_ZERO and had a
constructor which makes no sense.  Remove __GFP_ZERO and zero the user
parts of the pgd explicitly.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Rich Felker <dalias@libc.org>

Adrian

> [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=73c348f31b63d28d176ed290eb1aa2a648f3e51e

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
