Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 227AE3B68D1
	for <lists+linux-arch@lfdr.de>; Mon, 28 Jun 2021 21:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233799AbhF1THs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Jun 2021 15:07:48 -0400
Received: from mga05.intel.com ([192.55.52.43]:39628 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234052AbhF1THq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 28 Jun 2021 15:07:46 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10029"; a="293654287"
X-IronPort-AV: E=Sophos;i="5.83,306,1616482800"; 
   d="scan'208";a="293654287"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2021 12:05:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,306,1616482800"; 
   d="scan'208";a="407856144"
Received: from irsmsx605.ger.corp.intel.com ([163.33.146.138])
  by orsmga006.jf.intel.com with ESMTP; 28 Jun 2021 12:05:18 -0700
Received: from tjmaciei-mobl1.localnet (10.212.206.236) by
 IRSMSX605.ger.corp.intel.com (163.33.146.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 28 Jun 2021 20:05:15 +0100
From:   Thiago Macieira <thiago.macieira@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <fweimer@redhat.com>,
        "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        <hjl.tools@gmail.com>, <libc-alpha@sourceware.org>,
        <linux-api@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <x86@kernel.org>
Subject: Re: x86 CPU features detection for applications (and AMX)
Date:   Mon, 28 Jun 2021 12:05:12 -0700
Message-ID: <1908490.RGF5xs8fMo@tjmaciei-mobl1>
Organization: Intel Corporation
In-Reply-To: <20210628174347.GB13401@worktop.programming.kicks-ass.net>
References: <22261946.eFiGugXE7Z@tjmaciei-mobl1> <2094802.S4rhTtsRBG@tjmaciei-mobl1> <20210628174347.GB13401@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [10.212.206.236]
X-ClientProxiedBy: orsmsx603.amr.corp.intel.com (10.22.229.16) To
 IRSMSX605.ger.corp.intel.com (163.33.146.138)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Monday, 28 June 2021 10:43:47 PDT Peter Zijlstra wrote:
> None of those I think. The worst case is old executables using
> MINSIGSTKSZ and not using the magic signal context at all, just regular
> old signals. If you run them on an AVX512 enabled machine, they overflow
> their stack and cause memory corruption.

Indeed, they are already broken today. Retroactively fixing them 5 years later 
can be an additional goal, but it shouldn't stop us from having an AMX 
solution.

BTW, exactly MINSIGSTKSZ on an SKX overflows inside the kernel, so there's no 
memory corruption in userspace. The signal handler is not even invoked and the 
process is killed by a second signal delivery. But somewhere between 
MINSIGSTKSZ and SIGSTKSZ, it will invoke the signal handler and will overflow 
inside the user code. If that alt-stack wasn't designed with guard pages, it 
will corrupt memory, as you said.

> AFAICT the only feasible way forward with that is some sysctl which
> default disables AVX512 and add the prctl() and have some unsafe wrapper
> that enables AVX512 for select 'legacy' programs for as long as they
> exist :/
> 
> That is, binaries/libraries compiled against a static (and small)
> MINSIGSTKSZ are the enemy. Which brings us to:

> > 5) #4, in which each part is comes from a separate library with no
> > knowledge of each other, and initialised concurrently in different
> > threads
> 
> That's terrible... library init should *NEVER* spawn threads (I know,
> don't start).

Indeed, but that wasn't even what I was suggesting. I was thinking that the 
application would have started threads and the library init was run on 
separate threads. This may happen with lazy initialisation on first use.

But threads aren't required for the problem to happen. If the crash-handling 
case runs first, before AMX state is enabled, it might decide that it doesn't 
need to allocate sufficient alt-stack space for AMX. I think the 
recommendation here for userspace is clear: allocate the maximum that XSAVE 
tells you that you'll need, regardless of what the ambient enabled feature set 
is.

[And pretty please set up guard pages. Given that the XSAVE state area for SPR 
appears to be too close to 12 kB (see below), I'd say they should mmap() 20 kB 
and then mprotect() the lowest page to PROT_NONE.]

> Anything that does this is basically unfixable, because we can't
> guarantee the AMX prctl() gets done before the first thread.
> 
> So yes, worst case I suppose...

To wit: the worst case is a static, small alt-stack *without* guard pages 
(e.g., a malloc()ed or even static buffer) of sufficient size to let the 
kernel transition back to userspace but not for the userspace routine to run.

Any code using the old MINSIGSTKSZ (2048) will fail to run for AVX512 in the 
first place. There will be no data corruption, the crash handler will not run 
and the application will simply crash. An out-of-process core dump handler (if 
any, like systemd-coredump) will still get run.

Code using SIGSTKSZ (8192) will run for AVX512 and there'll be about 5 kB left 
to the user routine. So if it doesn't have too deep a call stack, will not 
corrupt memory. And this code will not run for AMX state, because it's smaller 
than the XSAVE state (see below), making that the same case as the MINSIGSTKSZ 
for AVX512 above.

It's possible someone would use something between those two values, but why? I 
expect that alt-stack handlers that use a constant value use either of the two 
constants or maybe some multiple of SIGSTKSZ, but nothing in-between them.

$ /opt/intel/sde-external-8.63.0-2021-01-18-lin/sde64 -spr -- cpuid -1 -l 0xd        
CPU:
   XSAVE features (0xd/0):
      XCR0 lower 32 bits valid bit field mask = 0x000600ff
      XCR0 upper 32 bits valid bit field mask = 0x00000000
         XCR0 supported: x87 state            = true
         XCR0 supported: SSE state            = true
         XCR0 supported: AVX state            = true
         XCR0 supported: MPX BNDREGS          = true
         XCR0 supported: MPX BNDCSR           = true
         XCR0 supported: AVX-512 opmask       = true
         XCR0 supported: AVX-512 ZMM_Hi256    = true
         XCR0 supported: AVX-512 Hi16_ZMM     = true
         IA32_XSS supported: PT state         = false
         XCR0 supported: PKRU state           = false
         XCR0 supported: CET_U state          = false
         XCR0 supported: CET_S state          = false
         IA32_XSS supported: HDC state        = false
         IA32_XSS supported: UINTR state      = false
         LBR supported                        = false
         IA32_XSS supported: HWP state        = false
         XTILECFG supported                   = true
         XTILEDATA supported                  = true
      bytes required by fields in XCR0        = 0x00002b00 (11008)
      bytes required by XSAVE/XRSTOR area     = 0x00002b00 (11008)

-- 
Thiago Macieira - thiago.macieira (AT) intel.com
  Software Architect - Intel DPG Cloud Engineering



