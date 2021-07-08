Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B16B63C15BE
	for <lists+linux-arch@lfdr.de>; Thu,  8 Jul 2021 17:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbhGHPQe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Jul 2021 11:16:34 -0400
Received: from mga12.intel.com ([192.55.52.136]:22808 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229738AbhGHPQe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 8 Jul 2021 11:16:34 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10039"; a="189204135"
X-IronPort-AV: E=Sophos;i="5.84,224,1620716400"; 
   d="scan'208";a="189204135"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2021 08:13:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,224,1620716400"; 
   d="scan'208";a="461805621"
Received: from irsmsx605.ger.corp.intel.com ([163.33.146.138])
  by fmsmga008.fm.intel.com with ESMTP; 08 Jul 2021 08:13:51 -0700
Received: from tjmaciei-mobl1.localnet (10.212.151.102) by
 IRSMSX605.ger.corp.intel.com (163.33.146.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Thu, 8 Jul 2021 16:13:49 +0100
From:   Thiago Macieira <thiago.macieira@intel.com>
To:     Florian Weimer <fweimer@redhat.com>
CC:     <hjl.tools@gmail.com>, <libc-alpha@sourceware.org>,
        <linux-api@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <x86@kernel.org>
Subject: Re: x86 CPU features detection for applications (and AMX)
Date:   Thu, 8 Jul 2021 08:13:45 -0700
Message-ID: <1881978.gRoq7Scb6J@tjmaciei-mobl1>
Organization: Intel Corporation
In-Reply-To: <878s2hxoyn.fsf@oldenburg.str.redhat.com>
References: <22261946.eFiGugXE7Z@tjmaciei-mobl1> <878s2hxoyn.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [10.212.151.102]
X-ClientProxiedBy: orsmsx603.amr.corp.intel.com (10.22.229.16) To
 IRSMSX605.ger.corp.intel.com (163.33.146.138)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thursday, 8 July 2021 00:08:16 PDT Florian Weimer wrote:
> > The first problem is the cross-platformness need. Because we library and
> > application developers need to support other OSes, we'll need to deploy
> > our
> > own CPUID-based detection. It's far better to use common code everywhere,
> > where one developer working on Linux can fix bugs in FreeBSD, macOS or
> > Windows or any of the permutations. Every platform-specific deviation
> > adds to maintenance requirements and is a source of potential latent
> > bugs, now or in the future due to refactoring. That is why doing
> > everything in the form of instructions would be far better and easier,
> > rather than system calls.
> I must say this is a rather application-specific view.  Sure, you get
> consistency within the application across different targets, but for
> those who work on multiple applications (but perhaps on a single
> distribution/OS), things are very inconsistent.

Why would they be inconsistent, if the library is cross-platform?

> And the reason why I started this is that CPUID-based feature detection
> is dead anyway (assuming the kernel developers do not implement lazy
> initialization of the AMX state).  CPUID (and ancillary data such as
> XCR0) will say that AMX support is there, but it will not work unless
> some (yet to decided) steps are executed by the userspace thread.
> 
> While I consider the CPUID-based model a success (and the cross-OS
> consistency may have contributed to that), its days seem to be over.

Well, we need to design the API of this library such that we can accommodate 
the various possibilities. For all CPU possibilities, the library needs to be 
able to tell what the state of support is, among a state of "already enabled", 
"possible but not enabled" and "impossible", along with a call to enable them. 
The latter should be supported at least for AVX512 and AMX states. On Linux, 
only AMX will be tristate, but on macOS we need the tristate for AVX512 too.

This library would then wrap all the necessary checking for OSXSAVE and XCR0, 
so the user doesn't need to worry about them or how the OS enables them, only 
the features they're interested in.

Additionally, I'd like the library to also have constant expression paths that 
evaluate to constant true if the feature was already enabled at compile time 
(e.g., -march=x86-64-v3 sets __AVX2__ and __FMA__, so you can always run AVX2 
and FMA code, without checking). But that's just icing on top.

(it won't come as a surprise that I already have code for most of this)

-- 
Thiago Macieira - thiago.macieira (AT) intel.com
  Software Architect - Intel DPG Cloud Engineering



