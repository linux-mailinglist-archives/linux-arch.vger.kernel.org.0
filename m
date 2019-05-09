Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 846B418B37
	for <lists+linux-arch@lfdr.de>; Thu,  9 May 2019 16:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfEIOGP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 May 2019 10:06:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:60536 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726192AbfEIOGP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 9 May 2019 10:06:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9158BAC31;
        Thu,  9 May 2019 14:06:12 +0000 (UTC)
Date:   Thu, 9 May 2019 16:06:09 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Tobin C . Harding" <me@tobin.cc>, Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, Russell Currey <ruscur@russell.cc>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Stephen Rothwell <sfr@ozlabs.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] vsprintf: Do not break early boot with probing addresses
Message-ID: <20190509140609.n44v6kj27wb77jck@pathway.suse.cz>
References: <20190509121923.8339-1-pmladek@suse.com>
 <20190509091357.0af3fcd7@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509091357.0af3fcd7@gandalf.local.home>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu 2019-05-09 09:13:57, Steven Rostedt wrote:
> On Thu,  9 May 2019 14:19:23 +0200
> Petr Mladek <pmladek@suse.com> wrote:
> 
> > The commit 3e5903eb9cff70730 ("vsprintf: Prevent crash when dereferencing
> > invalid pointers") broke boot on several architectures. The common
> > pattern is that probe_kernel_read() is not working during early
> > boot because userspace access framework is not ready.
> > 
> > The check is only the best effort. Let's not rush with it during
> > the early boot.
> > 
> > Details:
> > 
> > 1. Report on Power:
> > 
> > Kernel crashes very early during boot with with CONFIG_PPC_KUAP and
> > CONFIG_JUMP_LABEL_FEATURE_CHECK_DEBUG
> > 
> > The problem is the combination of some new code called via printk(),
> > check_pointer() which calls probe_kernel_read(). That then calls
> > allow_user_access() (PPC_KUAP) and that uses mmu_has_feature() too early
> > (before we've patched features). With the JUMP_LABEL debug enabled that
> > causes us to call printk() & dump_stack() and we end up recursing and
> > overflowing the stack.
> > 
> > Because it happens so early you don't get any output, just an apparently
> > dead system.
> > 
> > The stack trace (which you don't see) is something like:
> > 
> >   ...
> >   dump_stack+0xdc
> >   probe_kernel_read+0x1a4
> >   check_pointer+0x58
> >   string+0x3c
> >   vsnprintf+0x1bc
> >   vscnprintf+0x20
> >   printk_safe_log_store+0x7c
> >   printk+0x40
> >   dump_stack_print_info+0xbc
> >   dump_stack+0x8
> >   probe_kernel_read+0x1a4
> >   probe_kernel_read+0x19c
> >   check_pointer+0x58
> >   string+0x3c
> >   vsnprintf+0x1bc
> >   vscnprintf+0x20
> >   vprintk_store+0x6c
> >   vprintk_emit+0xec
> >   vprintk_func+0xd4
> >   printk+0x40
> >   cpufeatures_process_feature+0xc8
> >   scan_cpufeatures_subnodes+0x380
> >   of_scan_flat_dt_subnodes+0xb4
> >   dt_cpu_ftrs_scan_callback+0x158
> >   of_scan_flat_dt+0xf0
> >   dt_cpu_ftrs_scan+0x3c
> >   early_init_devtree+0x360
> >   early_setup+0x9c
> > 
> > 2. Report on s390:
> > 
> > vsnprintf invocations, are broken on s390. For example, the early boot
> > output now looks like this where the first (efault) should be
> > the linux_banner:
> > 
> > [    0.099985] (efault)
> > [    0.099985] setup: Linux is running as a z/VM guest operating system in 64-bit mode
> > [    0.100066] setup: The maximum memory size is 8192MB
> > [    0.100070] cma: Reserved 4 MiB at (efault)
> > [    0.100100] numa: NUMA mode: (efault)
> > 
> > The reason for this, is that the code assumes that
> > probe_kernel_address() works very early. This however is not true on
> > at least s390. Uaccess on KERNEL_DS works only after page tables have
> > been setup on s390, which happens with setup_arch()->paging_init().
> > 
> > Any probe_kernel_address() invocation before that will return -EFAULT.
> 
> Hmm, this sounds to me that probe_kernel_address() is broken for these
> architectures. Perhaps the system_state check should be in
> probe_kernel_address() for those architectures?

Yeah. Well, these problems are hard to debug. It left a dead power
system with a blank screen. I am not sure if the added check is
worth the pain.

I hope that the check would help to debug problems. But it is yet
another complexity in printk() path. I think that it is fine
to keep it enabled only on the booted system for a while
and get some more feedback.

Best Regards,
Petr
