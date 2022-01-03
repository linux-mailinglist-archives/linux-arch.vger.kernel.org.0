Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28E1448318C
	for <lists+linux-arch@lfdr.de>; Mon,  3 Jan 2022 14:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiACNqP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Jan 2022 08:46:15 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:38622 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233129AbiACNqP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Jan 2022 08:46:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3627610A7;
        Mon,  3 Jan 2022 13:46:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90EAFC36AED;
        Mon,  3 Jan 2022 13:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641217574;
        bh=oiRlwsZovsG5Dwipu+HSmPqPdtDoNJ6osknDJIrYXfY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CkF231Qv0XjgK+KwWFcki+qL6r9gh5JxnLwi0avqr03U2j0vFEHpA+Mju/TkWzyuT
         Z9kB9LjHkL1p0yrYoMXZzDWsZ8T5jqU+FGSlx5ESXdU74CJHeiuGw//YEy6nlVjMLb
         +gijw8T+KP35OVXNd0w/Ec3ewaEXkhvufbe2ULWk=
Date:   Mon, 3 Jan 2022 14:46:11 +0100
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
Message-ID: <YdL+IwQGTLFQyVz2@kroah.com>
References: <YdIfz+LMewetSaEB@gmail.com>
 <YdLL0kaFhm6rp9NS@kroah.com>
 <YdLaMvaM9vq4W6f1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdLaMvaM9vq4W6f1@gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jan 03, 2022 at 12:12:50PM +0100, Ingo Molnar wrote:
> * Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > This is "interesting", but how are you going to keep the 
> > kernel/sched/per_task_area_struct_defs.h and struct task_struct_per_task 
> > definition in sync?
> 
> I have plans to clean this up further - see below - but in general I'd 
> *discourage* the embedding of new complex types to task_struct.
> 
> In practice, most new task_struct fields are either simple types or 
> pointers to structs, which can be added to task_struct without having to 
> define a complex type for <linux/sched.h>.
> 
> For example here's the list of the last 5 extensions of task_struct, since 
> November 2020 - I copy & pasted them out of git log -p include/linux/sched.h:
> 
> +       unsigned                        in_eventfd_signal:1;
> 
> +       cpumask_t                       *user_cpus_ptr;
> 
> +       unsigned int                    saved_state;
> 
> +       unsigned long                   saved_state_change;
> 
> +       struct bpf_run_ctx              *bpf_ctx;
> 
> All of those new fields are either simple C types or struct pointers - none 
> of those extensions need per_task() handling per se.
> 
> The overall policy to extend task_struct, going forward, would be to:
> 
>  - Either make simple-type or struct-pointer additions to task_struct, that 
>    don't couple <linux/sched.h> to other subsystems.
> 
>  - Or, if you absolutely must - and we don't want to forbid this - use the 
>    per_task() machinery to create a simple accessor to a complex embedded 
>    type.

I'll leave all of this up to the scheduler developers, but it still
looks odd to me.  The mess we create trying to work around issues in C :)

> > That issue aside, I took a glance at the tree, and overall it looks like 
> > a lot of nice cleanups.  Most of these can probably go through the 
> > various subsystem trees, after you split them out, for the "major" .h 
> > cleanups.  Is that something you are going to be planning on doing?
> 
> Yeah, I absolutely plan on doing that too:
> 
> - About ~70% of the commits can be split up & parallelized through 
>   maintainer trees.
> 
> - With the exception of the untangling of sched.h, per_task and the 
>   "Optimize Headers" series, where a lot of patches are dependent on each 
>   other. These are actually needed to get any measurable benefits from this 
>   tree (!). We can do these through the scheduler tree, or through the 
>   dedicated headers tree I posted.
> 
> The latter monolithic series is pretty much unavoidable, it's the result of 
> 30 years of coupling a lot of kernel subsystems to task_struct via embedded 
> structs & other complex types, that needed quite a bit of effort to 
> untangle, and that untangling needed to happen in-order.
> 
> Do these plans this sound good to you?

Yes, taking the majority through the maintainer trees and then doing the
remaining bits in a single tree seems sane, that one tree will be easier
to review as well.

thanks,

greg k-h
