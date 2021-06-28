Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36F393B690A
	for <lists+linux-arch@lfdr.de>; Mon, 28 Jun 2021 21:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236504AbhF1T2x (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Jun 2021 15:28:53 -0400
Received: from mga17.intel.com ([192.55.52.151]:65365 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233366AbhF1T2v (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 28 Jun 2021 15:28:51 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10029"; a="188399188"
X-IronPort-AV: E=Sophos;i="5.83,306,1616482800"; 
   d="scan'208";a="188399188"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2021 12:26:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,306,1616482800"; 
   d="scan'208";a="407861781"
Received: from irsmsx605.ger.corp.intel.com ([163.33.146.138])
  by orsmga006.jf.intel.com with ESMTP; 28 Jun 2021 12:26:15 -0700
Received: from tjmaciei-mobl1.localnet (10.212.206.236) by
 IRSMSX605.ger.corp.intel.com (163.33.146.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 28 Jun 2021 20:26:12 +0100
From:   Thiago Macieira <thiago.macieira@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     <fweimer@redhat.com>,
        "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        <hjl.tools@gmail.com>, <libc-alpha@sourceware.org>,
        <linux-api@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <x86@kernel.org>
Subject: Re: x86 CPU features detection for applications (and AMX)
Date:   Mon, 28 Jun 2021 12:26:09 -0700
Message-ID: <4740900.uQJRkLF2SI@tjmaciei-mobl1>
Organization: Intel Corporation
In-Reply-To: <20210628190816.GC13401@worktop.programming.kicks-ass.net>
References: <22261946.eFiGugXE7Z@tjmaciei-mobl1> <7968759.t5oPhm3B3B@tjmaciei-mobl1> <20210628190816.GC13401@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [10.212.206.236]
X-ClientProxiedBy: orsmsx603.amr.corp.intel.com (10.22.229.16) To
 IRSMSX605.ger.corp.intel.com (163.33.146.138)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Monday, 28 June 2021 12:08:16 PDT Peter Zijlstra wrote:
> > Anyway, if the AMX state is a sticky "set once per process", it's likely
> > going to get set early for every process that *may* use AMX. And this is
> > assuming we do the library right and only set it if has AMX code at all,
> > instead of all the time.
> 
> This, AFAIU. If the ifunc() resolver finds we haz AMX it can do the
> prctl() and on success pick the AMX routine.
> 
> Assuming of course, that if a program links with a library that supports
> AMX, it will actually end up using it.

That's what I meant and I agree. If it has an AMX function for *anything*, it 
will do the arch_prctl() and enable the state, even if said function is never 
called.

This is the good case. The bad case is that it does the arch_prctl() before it 
sees whether there is any AMX function.

Do we expect that the dynamic loader will have this code? It currently 
searches the multiple ABI levels (up to x86-64-v4 to include AVX512) and HW 
capabilities. I can readily see AMX being one of the capabilities, if not an 
ABI level. Though it should be trivial for it to call the arch_prctl() if and 
only if it is about to load an ELF module that declares use of AMX and also 
*not* load it if the syscall fails.

$ LD_DEBUG=libs /lib64/ld-linux-x86-64.so.2 --inhibit-cache /bin/ls 
      1620:     find library=librt.so.1 [0]; searching
      1620:      search path=.....
      1620:       trying file=/usr/lib64/glibc-hwcaps/x86-64-v4/librt.so.1
      1620:       trying file=/usr/lib64/glibc-hwcaps/x86-64-v3/librt.so.1
      1620:       trying file=/usr/lib64/glibc-hwcaps/x86-64-v2/librt.so.1
      1620:       trying file=/usr/lib64/tls/haswell/avx512_1/x86_64/librt.so.
1
      1620:       trying file=/usr/lib64/tls/haswell/avx512_1/librt.so.1
      1620:       trying file=/usr/lib64/tls/haswell/x86_64/librt.so.1
      1620:       trying file=/usr/lib64/tls/haswell/librt.so.1
      1620:       trying file=/usr/lib64/tls/avx512_1/x86_64/librt.so.1
      1620:       trying file=/usr/lib64/tls/avx512_1/librt.so.1
      1620:       trying file=/usr/lib64/tls/x86_64/librt.so.1
      1620:       trying file=/usr/lib64/tls/librt.so.1
      1620:       trying file=/usr/lib64/haswell/avx512_1/x86_64/librt.so.1
      1620:       trying file=/usr/lib64/haswell/avx512_1/librt.so.1
      1620:       trying file=/usr/lib64/haswell/x86_64/librt.so.1
      1620:       trying file=/usr/lib64/haswell/librt.so.1
      1620:       trying file=/usr/lib64/avx512_1/x86_64/librt.so.1
      1620:       trying file=/usr/lib64/avx512_1/librt.so.1
      1620:       trying file=/usr/lib64/x86_64/librt.so.1
      1620:       trying file=/usr/lib64/librt.so.1

-- 
Thiago Macieira - thiago.macieira (AT) intel.com
  Software Architect - Intel DPG Cloud Engineering



