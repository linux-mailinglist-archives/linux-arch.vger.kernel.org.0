Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEF383B6797
	for <lists+linux-arch@lfdr.de>; Mon, 28 Jun 2021 19:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbhF1R0V (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Jun 2021 13:26:21 -0400
Received: from mga03.intel.com ([134.134.136.65]:48821 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232335AbhF1R0V (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 28 Jun 2021 13:26:21 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10029"; a="208039229"
X-IronPort-AV: E=Sophos;i="5.83,306,1616482800"; 
   d="scan'208";a="208039229"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2021 10:23:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,306,1616482800"; 
   d="scan'208";a="456421289"
Received: from irsmsx605.ger.corp.intel.com ([163.33.146.138])
  by fmsmga008.fm.intel.com with ESMTP; 28 Jun 2021 10:23:53 -0700
Received: from tjmaciei-mobl1.localnet (10.212.206.236) by
 IRSMSX605.ger.corp.intel.com (163.33.146.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 28 Jun 2021 18:23:50 +0100
From:   Thiago Macieira <thiago.macieira@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <fweimer@redhat.com>,
        "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        <hjl.tools@gmail.com>, <libc-alpha@sourceware.org>,
        <linux-api@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <x86@kernel.org>
Subject: Re: x86 CPU features detection for applications (and AMX)
Date:   Mon, 28 Jun 2021 10:23:47 -0700
Message-ID: <7968759.t5oPhm3B3B@tjmaciei-mobl1>
Organization: Intel Corporation
In-Reply-To: <20210628171115.GA13401@worktop.programming.kicks-ass.net>
References: <22261946.eFiGugXE7Z@tjmaciei-mobl1> <2094802.S4rhTtsRBG@tjmaciei-mobl1> <20210628171115.GA13401@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [10.212.206.236]
X-ClientProxiedBy: orsmsx603.amr.corp.intel.com (10.22.229.16) To
 IRSMSX605.ger.corp.intel.com (163.33.146.138)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Monday, 28 June 2021 10:11:16 PDT Peter Zijlstra wrote:
> > Consequence: CPU feature checking is done *very* early, often before
> > main().
> For the linker based ones, yes. IIRC the ifunc() attribute is
> particularly useful here.

Exactly. ifunc was designed for this exact purpose. And hence the fact that 
CPUID initialisation will be done very, very early.

Anyway, if the AMX state is a sticky "set once per process", it's likely going 
to get set early for every process that *may* use AMX. And this is assuming we 
do the library right and only set it if has AMX code at all, instead of all 
the time.

On the other hand, if it's not set once and for all, we'll have to contend 
with the size changing. TBH, this is a lot more complicated to deal with. Take 
the hypothetical example of a preemptive user-space task scheduler that 
interrupts an AMX routine (let's say for the sake of the argument that it is 
an on-stack signal; I don't see why a scheduler would need to be alt-stack). 
It will record the state and then transition to another routine. And this 
routine may be resumed in another thread of the same process.

Will the kernel understand that the new routine does not need the AMX state? 
Will it understand that the *other* routine, in the other thread will? If this 
is not done automatically by the kernel, then the task scheduler will need to 
know to ask the kernel what the reference count for the AMX state is and will 
need a syscall to set it (not just increment/decrement, though one could 
implement that with a loop).

This applies differently in the case of cooperative scheduling. The SysV ABI 
will probably say that the AMX state is caller-save, so the function call from 
the AMX-using routine implies all its state has been saved somewhere. But what 
about the kernel-side AMX refcount? Is that part of the ABI?

-- 
Thiago Macieira - thiago.macieira (AT) intel.com
  Software Architect - Intel DPG Cloud Engineering



