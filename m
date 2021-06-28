Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECD753B6527
	for <lists+linux-arch@lfdr.de>; Mon, 28 Jun 2021 17:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234958AbhF1PV7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Jun 2021 11:21:59 -0400
Received: from mga04.intel.com ([192.55.52.120]:59985 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238171AbhF1PUi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 28 Jun 2021 11:20:38 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10029"; a="206147164"
X-IronPort-AV: E=Sophos;i="5.83,306,1616482800"; 
   d="scan'208";a="206147164"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2021 08:08:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,306,1616482800"; 
   d="scan'208";a="475585910"
Received: from irsmsx605.ger.corp.intel.com ([163.33.146.138])
  by fmsmga004.fm.intel.com with ESMTP; 28 Jun 2021 08:08:47 -0700
Received: from tjmaciei-mobl1.localnet (10.212.206.236) by
 IRSMSX605.ger.corp.intel.com (163.33.146.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 28 Jun 2021 16:08:45 +0100
From:   Thiago Macieira <thiago.macieira@intel.com>
To:     <fweimer@redhat.com>,
        "Enrico Weigelt, metux IT consult" <lkml@metux.net>
CC:     <hjl.tools@gmail.com>, <libc-alpha@sourceware.org>,
        <linux-api@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <x86@kernel.org>
Subject: Re: x86 CPU features detection for applications (and AMX)
Date:   Mon, 28 Jun 2021 08:08:41 -0700
Message-ID: <2379132.fg5cGID6mU@tjmaciei-mobl1>
Organization: Intel Corporation
In-Reply-To: <3c5c29e2-1b52-3576-eda2-018fb1e58ff9@metux.net>
References: <22261946.eFiGugXE7Z@tjmaciei-mobl1> <3c5c29e2-1b52-3576-eda2-018fb1e58ff9@metux.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [10.212.206.236]
X-ClientProxiedBy: orsmsx603.amr.corp.intel.com (10.22.229.16) To
 IRSMSX605.ger.corp.intel.com (163.33.146.138)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Monday, 28 June 2021 05:40:32 PDT Enrico Weigelt, metux IT consult wrote:
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
> hmm, maybe some libcpuid ?

Indeed. I'm querying inside Intel to see if I can get buy-in to create such a 
library.

> > The second problem is going to be backwards compatibility. Applications
> > and
> > libraries may want to ship precompiled binaries that make use of the new
> > CPU features, whether they are open source or not.
> 
> Since we're talking about GNU libc here, binary-only stuff is probably
> out of scope here. OTOH, using differnt libc versions in those special
> cases isn't such a big deal.

Shipping a libc is not trivial, either technically or due to licensing 
requirements. Most applications want to link against whatever libc the system 
already provides, if that's possible.

> > It comes as no surprise to anyone that we CPU makers will have made
> > software that use those features and
> > want to have it ready on Day 1 of the HW being available for the market
> > (if
> > we're doing our jobs right). That often involves precompiling because
> > everyone > who installed their compilers more than one year ago will not
> > have the necessary tools to build.
> 
> Actually, you should talk to the compiler folks much more early, at the
> point where you know how those features look like.

We do, but it's not enough.

GCC releases once a year, so it's easy to miss the feature freeze. Then there 
are Linux distros that do LTS every 2 years or so. Worse, those two are 
usually out of phase. For example, if you're using the current Ubuntu LTS 
today (almost July 2021), you're using 20.04, which was released one month 
before the GCC 10 release. So you're using GCC 9, released May 2019, which 
means its features were frozen on December 2018. That's an incredibly long 
lead time.

As a consequence, you will see precompiled binaries.

> For using certain new CPU specific features, the need for a compiler
> upgrade really should be no excuse. And at least for vast majority of
> cases, a proper compiler could do it much better than the average
> programmer.

To compile the software that uses those instructions, undoubtedly. But what if 
I did that for you and you could simply download the binary for the library 
and/or plugins such that you could slot into your existing systems and CI? 
This could make a difference between adoption or not.

> > And by "recently", I mean "anything since the glibc that came with Red Hat
> > Enterprise Linux 7" (2.17).
> 
> Uh, that's really ancient. Nobody can seriously expect modern features
> on such an ancient distro. If people really insist spending so much
> money for running such old code, instead of just doing a dist upgrade,
> then I can only reply with "not our problem".

Yes and no.

Red Hat has been incredibly successful in backporting kernel features to the 
old 3.10 that came with RHEL 7. Whether they will do that for AMX state saving 
and the system call that we're discussing here, I can't say. AFAIU, they did 
backport the AVX512 state-saving to that 3.10, so they may.

Even if they don't, the *software* that people deploy may be the same build 
for RHEL 7 and for a modern distro that will have a 5.14 kernel. That software 
may have non-AVX, AVX2, AVX512 and AMX-specific code paths and would do 
runtime detection of which one is best to use. If a system call is needed, the 
system call needs to be issued even on that 3.10 and if it responds with 
-ENOSYS or -EINVAL, then it will fall back to the next best option.

So my point is: this shouldn't be in glibc because the glibc will not have the 
new system call wrappers or TLS fields.

> What we SW engineers need is an easy and fast method to act depending on
> whether some CPU supports some feature (eg. a new opcode). Things like
> cpuinfo are only a tiny piece of that. What we could really use is a
> conditional jump/call based on whether feature X is supported - without
> any kernel intervention. Then the machine code could be easily layed out
> to support both cases with our without some feature X. Alternatively we
> could have a fast trapping in useland - hw generated call already would
> be a big help.

That's what cpuid is for. With GCC function multi-versioning or equivalent 
manually-rolled solutions, you can get exactly what you're asking for.

Yes, the checking became far more complex with the need to check XCR0 after 
AVX came along, but since the instruction itself is a slow and serialising, 
any library will just cache the results. And as a result, the level of CPU 
features is not expected to change. It never has in the past, so this hasn't 
been an issue.

> If we had something in that direction, we wouldn't have to have this
> kind discussion here anymore - it would be entirely up to compiler and
> library folks, no need for any kernel support at all.

For most features, there isn't. You don't see us discussing 
AVX512VP2INTERSECT, for example. This discussion only exists because AMX 
requires more state to be saved during context switches and signal delivery. 
See Peter's email.

> And one point that immediately jumps into my mind (w/o looking deeper
> into it): it introduces completely new registers - do we now need extra
> code for tasks switching etc ?

Yes, this is the crux of this discussion.

-- 
Thiago Macieira - thiago.macieira (AT) intel.com
  Software Architect - Intel DPG Cloud Engineering



