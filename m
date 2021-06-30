Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03B323B8653
	for <lists+linux-arch@lfdr.de>; Wed, 30 Jun 2021 17:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235743AbhF3PjR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 30 Jun 2021 11:39:17 -0400
Received: from mga02.intel.com ([134.134.136.20]:5435 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235565AbhF3PjP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 30 Jun 2021 11:39:15 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10031"; a="195524782"
X-IronPort-AV: E=Sophos;i="5.83,312,1616482800"; 
   d="scan'208";a="195524782"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2021 08:36:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,312,1616482800"; 
   d="scan'208";a="558333537"
Received: from irsmsx605.ger.corp.intel.com ([163.33.146.138])
  by orsmga004.jf.intel.com with ESMTP; 30 Jun 2021 08:36:41 -0700
Received: from tjmaciei-mobl1.localnet (10.209.13.190) by
 IRSMSX605.ger.corp.intel.com (163.33.146.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Wed, 30 Jun 2021 16:36:39 +0100
From:   Thiago Macieira <thiago.macieira@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        "Enrico Weigelt, metux IT consult" <lkml@metux.net>
CC:     <fweimer@redhat.com>, <hjl.tools@gmail.com>,
        <libc-alpha@sourceware.org>, <linux-api@vger.kernel.org>,
        <linux-arch@vger.kernel.org>, <x86@kernel.org>
Subject: Re: x86 CPU features detection for applications (and AMX)
Date:   Wed, 30 Jun 2021 08:36:36 -0700
Message-ID: <4315452.lxGN7TsiT6@tjmaciei-mobl1>
Organization: Intel Corporation
In-Reply-To: <534d0171-2cc5-cd0a-904f-cd3c499b55af@metux.net>
References: <22261946.eFiGugXE7Z@tjmaciei-mobl1> <YNnMsJJzI83cpnAQ@hirez.programming.kicks-ass.net> <534d0171-2cc5-cd0a-904f-cd3c499b55af@metux.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [10.209.13.190]
X-ClientProxiedBy: orsmsx603.amr.corp.intel.com (10.22.229.16) To
 IRSMSX605.ger.corp.intel.com (163.33.146.138)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wednesday, 30 June 2021 05:50:30 PDT Enrico Weigelt, metux IT consult 
wrote:
> > No, but because it's register state and part of XSAVE, it has immediate
> > impact in ABI. In particular, the signal stack layout includes XSAVE (as
> > does ptrace()).
> 
> OMGs, I've already suspected such sickness. I don't even dare thinking
> about consequences for compilers and library ABIs.
> 
> Does anyone here know why they designed this as inline operations ? This
> thing seems to be pretty much what typical TPUs are doing (or a subset
> of it). Why not just adding a TPU next to the CPU on the same chip ?

To be clear: this is a SW ABI. It has nothing to do the presence or absence of 
other processing units in the system.

The moment you receive a Unix signal with SA_SIGINFO, the mcontext state needs 
to be saved somewhere. Where would you save it? Please remember that:

- signal handlers can be called at any point in the execution, including
  in the middle of malloc()
- signal handlers can longjmp out of the handler back into non-handler code
- in a multithreaded application, each thread can be handling a signal 
  simultaneously

We could have the kernel hold on to that and have a system call to extract 
them, but that's an ABI change and I think won't work for the longjmp case.

> > Userspace will have to do something like:
> >   - check CPUID, if !AMX -> fail
> >   - issue prctl(), if error -> fail
> >   - issue XGETBV and check the AMX bit it set, if not -> fail
> 
> Can't we to this just by prctl() call ?
> IOW: ask the kernel, who gonna say yes or no.

That's possible. The kernel can't enable an AMX state on a system without AMX.

> Are there any situations where kernel says yes, but process still can't
> use it ? Why so ?

Today there is no such case that I can think of.

> >   - request the signal stack size / spawn threads
> 
> Signal stack is separate from the usual stack, right ?
> Why can't this all be done in one shot ?

Yes, we're talking about the sigaltstack() call.

What is "this all" in the sentence above?

-- 
Thiago Macieira - thiago.macieira (AT) intel.com
  Software Architect - Intel DPG Cloud Engineering



