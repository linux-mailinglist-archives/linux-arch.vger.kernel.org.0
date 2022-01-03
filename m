Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFA5482FCA
	for <lists+linux-arch@lfdr.de>; Mon,  3 Jan 2022 11:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbiACKLg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Jan 2022 05:11:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbiACKLf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Jan 2022 05:11:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED6BC061761;
        Mon,  3 Jan 2022 02:11:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3FBBDB80E8A;
        Mon,  3 Jan 2022 10:11:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C030C36AEE;
        Mon,  3 Jan 2022 10:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641204693;
        bh=0CGYyvpbOW/VRV/ian3+DNn3UCORswc82gG+YGYqP3M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A19vH4W12VYWzXuxzehvzYhLNsaJU4A8C1Ba2tXkoyyt9EmBq6mluWclToOhPqUiz
         7wDromuOoL5BDl1Y1Bwy1sPMNXiUjQDdmyv1eb8xmfrFtpQC9ClMXGWhadp7Aj2mH4
         w1ErpTEZzjh3qKlvSVXlY/WcbD9kkHl8vsaKrnZw=
Date:   Mon, 3 Jan 2022 11:11:30 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 0000/2297] [ANNOUNCE, RFC] "Fast Kernel Headers" Tree
 -v1: Eliminate the Linux kernel's "Dependency Hell"
Message-ID: <YdLL0kaFhm6rp9NS@kroah.com>
References: <YdIfz+LMewetSaEB@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdIfz+LMewetSaEB@gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jan 02, 2022 at 10:57:35PM +0100, Ingo Molnar wrote:
> 
> I'm pleased to announce the first public version of my new "Fast Kernel 
> Headers" project that I've been working on since late 2020, which is a 
> comprehensive rework of the Linux kernel's header hierarchy & header 
> dependencies, with the dual goals of:
> 
>  - speeding up the kernel build (both absolute and incremental build times)
> 
>  - decoupling subsystem type & API definitions from each other
> 
> The fast-headers tree consists of over 25 sub-trees internally, spanning 
> over 2,200 commits, which can be found here:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git master
> 
> As most kernel developers know, there's around ~10,000 main .h headers in 
> the Linux kernel, in the include/ and arch/*/include/ hierarchies. Over the 
> last 30+ years they have grown into a complicated & painful set of 
> cross-dependencies we are affectionately calling 'Dependency Hell'.
> 
> Before going into details about how this tree solves 'dependency hell' 
> exactly, here's the current kernel build performance gain with 
> CONFIG_FAST_HEADERS=y enabled, (and with CONFIG_KALLSYMS_FAST=y enabled as 
> well - see below), using a stock x86 Linux distribution's .config with all 
> modules built into the vmlinux:
> 
>   #
>   # Performance counter stats for 'make -j96 vmlinux' (3 runs):
>   #
>   # (Elapsed time in seconds):
>   #
> 
>   v5.16-rc7:            231.34 +- 0.60 secs, 15.5 builds/hour    # [ vanilla baseline ]
>   -fast-headers-v1:     129.97 +- 0.51 secs, 27.7 builds/hour    # +78.0% improvement
> 
> Or in terms of CPU time utilized:
> 
>   v5.16-rc7:            11,474,982.05 msec cpu-clock   # 49.601 CPUs utilized
>   -fast-headers-v1:      7,100,730.37 msec cpu-clock   # 54.635 CPUs utilized   # +61.6% improvement

Speed up is very impressive, nice job!

> Techniques used by the fast-headers tree to reduce header size & dependencies:
> 
>  - Aggressive decoupling of high level headers from each other, starting
>    with <linux/sched.h>. Since 'struct task_struct' is a union of many
>    subsystems, there's a new "per_task" infrastructure modeled after the
>    per_cpu framework, which creates fields in task_struct without having
>    to modify sched.h or the 'struct task_struct' type:
> 
>             DECLARE_PER_TASK(type, name);
>             ...
>             per_task(current, name) = val;
> 
>    The per_task() facility then seamlessly creates an offset into the
>    task_struct->per_task_area[] array, and uses the asm-offsets.h
>    mechanism to create offsets into it early in the build.
> 
>    There's no runtime overhead disadvantage from using per_task() framework,
>    the generated code is functionally equivalent to types embedded in
>    task_struct.

This is "interesting", but how are you going to keep the
kernel/sched/per_task_area_struct_defs.h and struct task_struct_per_task
definition in sync?  It seems that you manually created this (which is
great for testing), but over the long-term, trying to manually determine
what needs to be done here to keep everything lined up properly is going
to be a major pain.

That issue aside, I took a glance at the tree, and overall it looks like
a lot of nice cleanups.  Most of these can probably go through the
various subsystem trees, after you split them out, for the "major" .h
cleanups.  Is that something you are going to be planning on doing?

thanks,

greg k-h
