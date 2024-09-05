Return-Path: <linux-arch+bounces-7060-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C9E96D768
	for <lists+linux-arch@lfdr.de>; Thu,  5 Sep 2024 13:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC0B4B25864
	for <lists+linux-arch@lfdr.de>; Thu,  5 Sep 2024 11:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF93199E95;
	Thu,  5 Sep 2024 11:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IuLd52ZW"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8801991A8;
	Thu,  5 Sep 2024 11:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725536534; cv=none; b=WqIWBMmQ1QotQ8/JFYoI4BI1Xt8PAIHyOUPzuzN7pXpD8gRMawbOlNwJXyFoW+G+S4ADNWVJzt/i0JSqHIFYA7dyuVRLjS9zKCJ5ftEdaeimJMZKHJ2682XY50nAVk8Xy8n2d6u04Bqn5XjIdUumEKam873fi8/t3G9HgYhZR20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725536534; c=relaxed/simple;
	bh=T2t8jNi+8sLHrzmPCd6tBUk3yIPyo75n2oHQ90J0smA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZR6dngAVWie3Np51h5DtjRtlSfGcO9ctS50yH1ZuL5TUw4kJJMViv0ehn6QFPcjccZtI/FLYVRFE+oED4u6SkC9Glx0gX9ieb8lhGF2vgtcel6R9Jyek4N7TVch0gugkBTCeclOh1NIp4+zxPJ1LWTZVO4I+K8VoqSX3DK8yr7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IuLd52ZW; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JpEbd8fA8WeQjycJ3JHHB1dLu4AmBZQUJJ0p5zUhBXQ=; b=IuLd52ZWKCTv5OWFW5IPewnBSQ
	w65QXej7zDLHdXC1XA6q3xdcVd5EXfLI50mvw/UlURbLNXsFL7D2a6aXHozDE2rtZyYVTsoe383TK
	1G3GWxbgKGC4932Ye1DYW+hJNIlGJZWVL9ExS1xUfLJuJc77TD7zcQo+qPidDN7l5koqGb1X+sHy4
	krJsQ4+wuQtOMnBrh5x/AAnP7xUvwDHsFgl82aEY8/mYKGf14z7+YN4iTF0INVP4IqO/xzTPvRXdF
	WYCca0aqU+3DhjDPLgArdc2cujUClb7h4+a7Zh75Kgn6h5zzIEgSAX1VNSnq0I8MitYeROBZ2LUey
	oUTvSjVA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1smArr-00000002LN6-2rKY;
	Thu, 05 Sep 2024 11:41:41 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 28197300599; Thu,  5 Sep 2024 13:41:40 +0200 (CEST)
Date: Thu, 5 Sep 2024 13:41:40 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Wentao Zhang <wentaoz5@illinois.edu>
Cc: Matt.Kelly2@boeing.com, akpm@linux-foundation.org,
	andrew.j.oppelt@boeing.com, anton.ivanov@cambridgegreys.com,
	ardb@kernel.org, arnd@arndb.de, bhelgaas@google.com, bp@alien8.de,
	chuck.wolber@boeing.com, dave.hansen@linux.intel.com,
	dvyukov@google.com, hpa@zytor.com, jinghao7@illinois.edu,
	johannes@sipsolutions.net, jpoimboe@kernel.org,
	justinstitt@google.com, kees@kernel.org, kent.overstreet@linux.dev,
	linux-arch@vger.kernel.org, linux-efi@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-um@lists.infradead.org,
	llvm@lists.linux.dev, luto@kernel.org, marinov@illinois.edu,
	masahiroy@kernel.org, maskray@google.com,
	mathieu.desnoyers@efficios.com, matthew.l.weber3@boeing.com,
	mhiramat@kernel.org, mingo@redhat.com, morbo@google.com,
	nathan@kernel.org, ndesaulniers@google.com, oberpar@linux.ibm.com,
	paulmck@kernel.org, richard@nod.at, rostedt@goodmis.org,
	samitolvanen@google.com, samuel.sarkisian@boeing.com,
	steven.h.vanderleest@boeing.com, tglx@linutronix.de,
	tingxur@illinois.edu, tyxu@illinois.edu, x86@kernel.org
Subject: Re: [PATCH v2 0/4] Enable measuring the kernel's Source-based Code
 Coverage and MC/DC with Clang
Message-ID: <20240905114140.GN4723@noisy.programming.kicks-ass.net>
References: <20240824230641.385839-1-wentaoz5@illinois.edu>
 <20240905043245.1389509-1-wentaoz5@illinois.edu>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905043245.1389509-1-wentaoz5@illinois.edu>

On Wed, Sep 04, 2024 at 11:32:41PM -0500, Wentao Zhang wrote:
> From: Wentao Zhang <zhangwt1997@gmail.com>
> 
> This series adds support for building x86-64 kernels with Clang's Source-
> based Code Coverage[1] in order to facilitate Modified Condition/Decision
> Coverage (MC/DC)[2] that provably correlates to source code for all levels
> of compiler optimization.
> 
> The newly added kernel/llvm-cov/ directory complements the existing gcov
> implementation. Gcov works at the object code level which may better
> reflect actual execution. However, Gcov lacks the necessary information to
> correlate coverage measurement with source code location when compiler
> optimization level is non-zero (which is the default when building the
> kernel). In addition, gcov reports are occasionally ambiguous when
> attempting to compare with source code level developer intent.
> 
> In the following gcov example from drivers/firmware/dmi_scan.c, an
> expression with four conditions is reported to have six branch outcomes,
> which is not ideally informative in many safety related use cases, such as
> automotive, medical, and aerospace.
> 
>         5: 1068:	if (s == e || *e != '/' || !month || month > 12) {
> branch  0 taken 5 (fallthrough)
> branch  1 taken 0
> branch  2 taken 5 (fallthrough)
> branch  3 taken 0
> branch  4 taken 0 (fallthrough)
> branch  5 taken 5
> 
> On the other hand, Clang's Source-based Code Coverage instruments at the
> compiler frontend which maintains an accurate mapping from coverage
> measurement to source code location. Coverage reports reflect exactly how
> the code is written regardless of optimization and can present advanced
> metrics like branch coverage and MC/DC in a clearer way. Coverage report
> for the same snippet by llvm-cov would look as follows:
> 
>  1068|      5|	if (s == e || *e != '/' || !month || month > 12) {
>   ------------------
>   |  Branch (1068:6): [True: 0, False: 5]
>   |  Branch (1068:16): [True: 0, False: 5]
>   |  Branch (1068:29): [True: 0, False: 5]
>   |  Branch (1068:39): [True: 0, False: 5]
>   ------------------
> 
> Clang has added MC/DC support as of its 18.1.0 release. MC/DC is a fine-
> grained coverage metric required by many automotive and aviation industrial
> standards for certifying mission-critical software [3].
> 
> In the following example from arch/x86/events/probe.c, llvm-cov gives the
> MC/DC measurement for the compound logic decision at line 43.
> 
>    43|     12|			if (msr[bit].test && !msr[bit].test(bit, data))
>   ------------------
>   |---> MC/DC Decision Region (43:8) to (43:50)
>   |
>   |  Number of Conditions: 2
>   |     Condition C1 --> (43:8)
>   |     Condition C2 --> (43:25)
>   |
>   |  Executed MC/DC Test Vectors:
>   |
>   |     C1, C2    Result
>   |  1 { T,  F  = F      }
>   |  2 { T,  T  = T      }
>   |
>   |  C1-Pair: not covered
>   |  C2-Pair: covered: (1,2)
>   |  MC/DC Coverage for Decision: 50.00%
>   |
>   ------------------
>    44|      5|				continue;
> 
> As the results suggest, during the span of measurement, only condition C2
> (!msr[bit].test(bit, data)) is covered. That means C2 was evaluated to both
> true and false, and in those test vectors C2 affected the decision outcome
> independently. Therefore MC/DC for this decision is 1 out of 2 (50.00%).
> 
> To do a full kernel measurement, instrument the kernel with
> LLVM_COV_KERNEL_MCDC enabled, and optionally set a
> LLVM_COV_KERNEL_MCDC_MAX_CONDITIONS value (the default is six). Run the
> testsuites, and collect the raw profile data under
> /sys/kernel/debug/llvm-cov/profraw. Such raw profile data can be merged and
> indexed, and used for generating coverage reports in various formats.
> 
>   $ cp /sys/kernel/debug/llvm-cov/profraw vmlinux.profraw
>   $ llvm-profdata merge vmlinux.profraw -o vmlinux.profdata
>   $ llvm-cov show --show-mcdc --show-mcdc-summary                         \
>              --format=text --use-color=false -output-dir=coverage_reports \
>              -instr-profile vmlinux.profdata vmlinux
> 
> The first two patches enable the llvm-cov infrastructure, where the first
> enables source based code coverage and the second adds MC/DC support. The
> next patch disables instrumentation for curve25519-x86_64.c for the same
> reason as gcov. The final patch enables coverage for x86-64.
> 
> The choice to use a new Makefile variable LLVM_COV_PROFILE, instead of
> reusing GCOV_PROFILE, was deliberate. More work needs to be done to
> determine if it is appropriate to reuse the same flag. In addition, given
> the fundamentally different approaches to instrumentation and the resulting
> variation in coverage reports, there is a strong likelihood that coverage
> type will need to be managed separately.
> 
> This work reuses code from a previous effort by Sami Tolvanen et al. [4].
> Our aim is for source-based *code coverage* required for high assurance
> (MC/DC) while [4] focused more on performance optimization.
> 
> This initial submission is restricted to x86-64. Support for other
> architectures would need a bit more Makefile & linker script modification.
> Informally we've confirmed that arm64 works and more are being tested.
> 
> Note that Source-based Code Coverage is Clang-specific and isn't compatible
> with Clang's gcov support in kernel/gcov/. Currently, kernel/gcov/ is not
> able to measure MC/DC without modifying CFLAGS_GCOV and it would face the
> same issues in terms of source correlation as gcov in general does.
> 
> Some demo and results can be found in [5]. We will talk about this patch
> series in the Refereed Track at LPC 2024 [6].
> 
> Known Limitations:
> 
> Kernel code with logical expressions exceeding
> LVM_COV_KERNEL_MCDC_MAX_CONDITIONS will produce a compiler warning.
> Expressions with up to 47 conditions are found in the Linux kernel source
> tree (as of v6.11), but 46 seems to be the max value before the build fails
> due to kernel size. As of LLVM 19 the max number of conditions possible is
> 32767.
> 
> As of LLVM 19, certain expressions are still not covered, and will produce
> build warnings when they are encountered:
> 
> "[...] if a boolean expression is embedded in the nest of another boolean
>  expression but separated by a non-logical operator, this is also not
>  supported. For example, in x = (a && b && c && func(d && f)), the d && f
>  case starts a new boolean expression that is separated from the other
>  conditions by the operator func(). When this is encountered, a warning
>  will be generated and the boolean expression will not be
>  instrumented." [7]
> 

What does this actually look like in the generated code?

Where is the modification to noinstr ?

What is the impact on certification of not covering the noinstr code.



