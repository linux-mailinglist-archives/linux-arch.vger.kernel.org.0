Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8773248303C
	for <lists+linux-arch@lfdr.de>; Mon,  3 Jan 2022 12:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbiACLM6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Jan 2022 06:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbiACLM5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Jan 2022 06:12:57 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734DAC061761;
        Mon,  3 Jan 2022 03:12:57 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id j21so134402806edt.9;
        Mon, 03 Jan 2022 03:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sv0FFb+AVNSUt+0NEBQaAbNOgvs2uAKbwzLwFgJVapI=;
        b=Cs+jquebwSEc/nCVzPpod6sOSUu0W5bOckbTVXl/1x2GII2solaXor+QTxcjUYNkBp
         IvzteUQSNeiY0fjo9WpjAjwVHJyedylczE58C8vbeR4AfxmiafczqzyafpFcVhrwJTWn
         +qDVTjeYE8KXI5nN2yiLMlF7Ma8pQdNMCj2nRVDgxy4fSS8LYRPJ3CWJSmM0zdIvUVj6
         IkRUFHlk34oTVc4erMQH98LJdtP4gbdLJanQIzzSkxe9sCxF/I5kJjj/SgUEXY1TrZLK
         GVNqvnA9KrcoLTWgPnKqtiyPekcLetOJ04Dchf8usuSm3pfg8PTw3UqKESpfWePG+tqd
         r/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=sv0FFb+AVNSUt+0NEBQaAbNOgvs2uAKbwzLwFgJVapI=;
        b=wJHwbiivvZussSqrO2CKvJ19ch8efqQFGDJQofVr5zGX9THEsJRE0UKyzfwUVnVf85
         GgI4K4ZJ8ji1MdeO3X1sHdpLQTlapbCxAI8q8CpLetpVx5TSSaPp5CNUiVwQJotRr62x
         HlV9Gj9Hb3pWA7pnzr0e88arfRj4MljeaoKdtPckoMm03uuP9CFzfk5/4ea6DuxAoDIj
         eahhVLeam0wuYiWMVd8mm7qKWqSd04LeJ3ziz4HgVif2tdmLSDYS/4uHZ1mDScUoAsFF
         fyMBnz5SolcGVnnL1Xbh9klf+yWQjiyjk/CHgioT7mqUj2cifjANqrKylCRs9hTDttUC
         VwCw==
X-Gm-Message-State: AOAM531oFGsTm9De7jjHblQaqPjNHPZkqPG/CRXF1s/SjCjCbZflClQD
        BH9lbHplhkF4rlEZifpvjEk=
X-Google-Smtp-Source: ABdhPJyuhWTsVtfHF7R2xFKDCV1x1aL9h1LleR4iKtn4nPFsXSF/T7U4pvj91u8ghZlucSHi392fOA==
X-Received: by 2002:a17:906:1c05:: with SMTP id k5mr25043791ejg.664.1641208375866;
        Mon, 03 Jan 2022 03:12:55 -0800 (PST)
Received: from gmail.com (0526F103.dsl.pool.telekom.hu. [5.38.241.3])
        by smtp.gmail.com with ESMTPSA id zh8sm10476857ejb.21.2022.01.03.03.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 03:12:55 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 3 Jan 2022 12:12:50 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
Message-ID: <YdLaMvaM9vq4W6f1@gmail.com>
References: <YdIfz+LMewetSaEB@gmail.com>
 <YdLL0kaFhm6rp9NS@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdLL0kaFhm6rp9NS@kroah.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


* Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> > Before going into details about how this tree solves 'dependency hell' 
> > exactly, here's the current kernel build performance gain with 
> > CONFIG_FAST_HEADERS=y enabled, (and with CONFIG_KALLSYMS_FAST=y enabled as 
> > well - see below), using a stock x86 Linux distribution's .config with all 
> > modules built into the vmlinux:
> > 
> >   #
> >   # Performance counter stats for 'make -j96 vmlinux' (3 runs):
> >   #
> >   # (Elapsed time in seconds):
> >   #
> > 
> >   v5.16-rc7:            231.34 +- 0.60 secs, 15.5 builds/hour    # [ vanilla baseline ]
> >   -fast-headers-v1:     129.97 +- 0.51 secs, 27.7 builds/hour    # +78.0% improvement
> > 
> > Or in terms of CPU time utilized:
> > 
> >   v5.16-rc7:            11,474,982.05 msec cpu-clock   # 49.601 CPUs utilized
> >   -fast-headers-v1:      7,100,730.37 msec cpu-clock   # 54.635 CPUs utilized   # +61.6% improvement
> 
> Speed up is very impressive, nice job!

Thanks! :-)

> > Techniques used by the fast-headers tree to reduce header size & dependencies:
> > 
> >  - Aggressive decoupling of high level headers from each other, starting
> >    with <linux/sched.h>. Since 'struct task_struct' is a union of many
> >    subsystems, there's a new "per_task" infrastructure modeled after the
> >    per_cpu framework, which creates fields in task_struct without having
> >    to modify sched.h or the 'struct task_struct' type:
> > 
> >             DECLARE_PER_TASK(type, name);
> >             ...
> >             per_task(current, name) = val;
> > 
> >    The per_task() facility then seamlessly creates an offset into the
> >    task_struct->per_task_area[] array, and uses the asm-offsets.h
> >    mechanism to create offsets into it early in the build.
> > 
> >    There's no runtime overhead disadvantage from using per_task() framework,
> >    the generated code is functionally equivalent to types embedded in
> >    task_struct.
> 
> This is "interesting", but how are you going to keep the 
> kernel/sched/per_task_area_struct_defs.h and struct task_struct_per_task 
> definition in sync?

I have plans to clean this up further - see below - but in general I'd 
*discourage* the embedding of new complex types to task_struct.

In practice, most new task_struct fields are either simple types or 
pointers to structs, which can be added to task_struct without having to 
define a complex type for <linux/sched.h>.

For example here's the list of the last 5 extensions of task_struct, since 
November 2020 - I copy & pasted them out of git log -p include/linux/sched.h:

+       unsigned                        in_eventfd_signal:1;

+       cpumask_t                       *user_cpus_ptr;

+       unsigned int                    saved_state;

+       unsigned long                   saved_state_change;

+       struct bpf_run_ctx              *bpf_ctx;

All of those new fields are either simple C types or struct pointers - none 
of those extensions need per_task() handling per se.

The overall policy to extend task_struct, going forward, would be to:

 - Either make simple-type or struct-pointer additions to task_struct, that 
   don't couple <linux/sched.h> to other subsystems.

 - Or, if you absolutely must - and we don't want to forbid this - use the 
   per_task() machinery to create a simple accessor to a complex embedded 
   type.

> [...]  It seems that you manually created this (which is great for 
> testing), but over the long-term, trying to manually determine what needs 
> to be done here to keep everything lined up properly is going to be a 
> major pain.

Note that under the policy above - and even according to the practice of 
the last ~1.5 years - it should be exceedingly rare having to extend the 
per_task() facility.

There's one thing ugly about it, the fixed PER_TASK_BYTES limit, I plan to 
make ->per_task_array[] the last field of task_struct, i.e. change it to:

        u8                              per_task_area[];

This actually became possible through the fixing of the x86 FPU code in the 
following fast-headers commit:

   4ae0f28bc1c8 headers/deps: x86/fpu: Make task_struct::thread constant size

In the last ~1 year existence of the per_task() facility I didn't have any 
maintenance troubles with these fields getting out of sync, but we could 
also auto-generate kernel/sched/per_task_area_struct_defs.h from 
kernel/sched/per_task_area_struct.h via a build-time script, and make 
kernel/sched/per_task_area_struct.h the only method to define such fields.

> That issue aside, I took a glance at the tree, and overall it looks like 
> a lot of nice cleanups.  Most of these can probably go through the 
> various subsystem trees, after you split them out, for the "major" .h 
> cleanups.  Is that something you are going to be planning on doing?

Yeah, I absolutely plan on doing that too:

- About ~70% of the commits can be split up & parallelized through 
  maintainer trees.

- With the exception of the untangling of sched.h, per_task and the 
  "Optimize Headers" series, where a lot of patches are dependent on each 
  other. These are actually needed to get any measurable benefits from this 
  tree (!). We can do these through the scheduler tree, or through the 
  dedicated headers tree I posted.

The latter monolithic series is pretty much unavoidable, it's the result of 
30 years of coupling a lot of kernel subsystems to task_struct via embedded 
structs & other complex types, that needed quite a bit of effort to 
untangle, and that untangling needed to happen in-order.

Do these plans this sound good to you?

Thanks,

	Ingo
