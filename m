Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C53D13B6679
	for <lists+linux-arch@lfdr.de>; Mon, 28 Jun 2021 18:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbhF1QQE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Jun 2021 12:16:04 -0400
Received: from mga06.intel.com ([134.134.136.31]:61396 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231472AbhF1QQD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 28 Jun 2021 12:16:03 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10029"; a="269115685"
X-IronPort-AV: E=Sophos;i="5.83,306,1616482800"; 
   d="scan'208";a="269115685"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2021 09:13:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,306,1616482800"; 
   d="scan'208";a="557620801"
Received: from irsmsx605.ger.corp.intel.com ([163.33.146.138])
  by orsmga004.jf.intel.com with ESMTP; 28 Jun 2021 09:13:35 -0700
Received: from tjmaciei-mobl1.localnet (10.212.206.236) by
 IRSMSX605.ger.corp.intel.com (163.33.146.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 28 Jun 2021 17:13:32 +0100
From:   Thiago Macieira <thiago.macieira@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <fweimer@redhat.com>,
        "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        <hjl.tools@gmail.com>, <libc-alpha@sourceware.org>,
        <linux-api@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <x86@kernel.org>
Subject: Re: x86 CPU features detection for applications (and AMX)
Date:   Mon, 28 Jun 2021 09:13:29 -0700
Message-ID: <2094802.S4rhTtsRBG@tjmaciei-mobl1>
Organization: Intel Corporation
In-Reply-To: <YNnqXCSVUhYhzT6T@hirez.programming.kicks-ass.net>
References: <22261946.eFiGugXE7Z@tjmaciei-mobl1> <2379132.fg5cGID6mU@tjmaciei-mobl1> <YNnqXCSVUhYhzT6T@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [10.212.206.236]
X-ClientProxiedBy: orsmsx603.amr.corp.intel.com (10.22.229.16) To
 IRSMSX605.ger.corp.intel.com (163.33.146.138)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Monday, 28 June 2021 08:27:24 PDT Peter Zijlstra wrote:
> > That's what cpuid is for. With GCC function multi-versioning or equivalent
> > manually-rolled solutions, you can get exactly what you're asking for.
> 
> Right, lots of self-modifying code solutions there, some of which can be
> linker driven, some not. In the kernel we use alternative() to replace
> short code sequences depending on CPUID.
> 
> Userspace *could* do the same, rewriting code before first execution is
> fairly straight forward.

Userspace shouldn't do SMC. It's bad enough that JITs without caching exist, 
but having pure paged code is better. Pure pages are shared as needed by the 
kernel.

All you need is a simple bit test. You can then either branch to different 
code paths or write to a function pointer so it'll go there directly the next 
time. You can also choose to load different plugins depending on what CPU 
features were found.

Consequence: CPU feature checking is done *very* early, often before main().

> Arguably you should be checking XCR0 for any feature there, including
> SSE/AVX/AVX512 and now AMX.
> 
> Ideally we'd do a prctl() for AVX512 too, except it's too late :-(

Right.

But speaking of which, this library would deal with Apple having done the 
allocate-state-on-demand feature for AVX512 without XFD. See
https://github.com/qt/qtbase/blob/dev/src/corelib/global/qsimd.cpp#L346-L369

Anyway, what's the current thinking on what the arch_prctl() should be? Is 
that a per-thread state or will it affect the entire process group? And is it 
a sticky functionality, or are we talking about ref/deref?

Maybe in order to answer that, we need to understand what the worst case 
scenario we need to support is. What are they?

1) alt-stack signal handlers, usually for crashing signals (to catch a stack 
overflow)

2) cooperative user-space task schedulers, e.g. coroutines

3) preemptive user-space task schedulers (I don't know if such software exists 
or even if it is possible)

4) combination of 1 and 3

5) #4, in which each part is comes from a separate library with no knowledge 
of each other, and initialised concurrently in different threads

I'd *assume* that any user-space task scheduler is aware of XSAVE at the very 
least and will know how to allocate context-saving buffers of sufficient size 
for each task. I think this is a safe assumption because AVX is over 10 years 
old now and XSAVE is a required feature for enabling the AVX state. That is, 
any library that knows to save AVX state (the upper 128-bits of the YMM 
registers) is aware of XSAVE and the fact that the state size is dynamic.

Crash handlers are another story. Speaking from experience, my first attempt 
at doing them simply used a global char array of MINSIGSTKSZ and that failed 
to get delivered (note that code will now fail to compile because MINSIGSTKSZ 
is no longer a constant expression). My code was attempting to launch gdb on 
itself, so it wasn't even a SA_SIGINFO signal and therefore the failure was 
baffling. I had to read the kernel source code to figure out that regardless 
of SA_SIGINFO, the state is saved on stack anyway and therefore needs to be 
big enough. So I simply increased the global variable's size until it 
succeeded in delivering on my AVX512 machine. And because it is no longer 
using MINSIGSTKSZ, it will not fail to compile after the glibc upgrade, but it 
will fail to deliver with AMX state enabled.

[I've since learned to check the XSAVE state size in order to create the alt-
stack]

How much do we need to worry about these crash handlers?

-- 
Thiago Macieira - thiago.macieira (AT) intel.com
  Software Architect - Intel DPG Cloud Engineering



