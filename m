Return-Path: <linux-arch+bounces-7615-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2C298CA67
	for <lists+linux-arch@lfdr.de>; Wed,  2 Oct 2024 03:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A9F5280788
	for <lists+linux-arch@lfdr.de>; Wed,  2 Oct 2024 01:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE2D1C2E;
	Wed,  2 Oct 2024 01:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sho8SlHD"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3758F54;
	Wed,  2 Oct 2024 01:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727831434; cv=none; b=lUbyL6Dqe5HEZR9+h5sZ4IaDhkIbfiVlxsgjNKTTYFJdgL3n71CbTUeN/ZjEN3mm7gJjdlFVMGNO5LRJwFMe5d7+JDcNYz5YsN5KaP6LDcBBYl27q3fZiiVExiho64+uIMOHn4WZJTfywG5dgayJlJyH+vrvMyVGu0NDuqCEgYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727831434; c=relaxed/simple;
	bh=Q+WLhUfeuPYe+YwBIu9cv5kqenpZRo6iBvTiMFaMBnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+8CFj8UDpdEQR3isgxLcFd/KKiZM0UooEYoaddD97Zm0lE38QZiInh1mVZcA1+k9NHeSpvx2XoLVRuT8a+i6kb16YQ4oovOm51jVJd0QGIy7EEQUuEl1lSjoqGB6D43luUEFy8UKhZBQgGwSvjVqYn9Wi3UhSSMz2vQXCFaYC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sho8SlHD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBB71C4CED1;
	Wed,  2 Oct 2024 01:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727831434;
	bh=Q+WLhUfeuPYe+YwBIu9cv5kqenpZRo6iBvTiMFaMBnE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sho8SlHDgM9QtRx5x92MvTCntChyTYm4prV/iGFeeUhXypMRVp9ao4YLyziO/OZek
	 BIk206znNNHzWafswtzL6KqNW+XKS31+lFmOqCA7TADRTloPec1aciIpBKE11gtLgX
	 COfBMh3OW0gqIa8De5P3yoetb5enTe3owVTlmzOdlfqGk1SS8T4rvWjSm3QfaNM++N
	 KClrmJJZDsR6b+WImVdynHaPKe8JuKd/f6twjLWXQS2UIVS9ydavPXiWFmQf8ebvjM
	 KWMcHGZDcGjPuAxbHas6sN/9OHDhMIgy6q5tuJ6oLyO3/6KTuHAQ8v6kZx5kB3lgHZ
	 wku2m6/5Top5g==
Date: Tue, 1 Oct 2024 18:10:30 -0700
From: Nathan Chancellor <nathan@kernel.org>
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
	ndesaulniers@google.com, oberpar@linux.ibm.com, paulmck@kernel.org,
	peterz@infradead.org, richard@nod.at, rostedt@goodmis.org,
	samitolvanen@google.com, samuel.sarkisian@boeing.com,
	steven.h.vanderleest@boeing.com, tglx@linutronix.de,
	tingxur@illinois.edu, tyxu@illinois.edu, x86@kernel.org
Subject: Re: [PATCH v2 2/4] llvm-cov: add Clang's MC/DC support
Message-ID: <20241002011030.GB555609@thelio-3990X>
References: <20240824230641.385839-1-wentaoz5@illinois.edu>
 <20240905043245.1389509-1-wentaoz5@illinois.edu>
 <20240905043245.1389509-3-wentaoz5@illinois.edu>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905043245.1389509-3-wentaoz5@illinois.edu>

Hi Wentao,

On Wed, Sep 04, 2024 at 11:32:43PM -0500, Wentao Zhang wrote:
> Add infrastructure to enable Clang's Modified Condition/Decision Coverage
> (MC/DC) [1].
> 
> Clang has added MC/DC support as of its 18.1.0 release. MC/DC is a fine-
> grained coverage metric required by many automotive and aviation industrial
> standards for certifying mission-critical software [2].
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

Thanks a lot for the detail in the commit message. Your first talk at
LPC in the Refereed Track was excellent as well. If the video for that
talk becomes available soon, it would be helpful to link that in the
commit message as well.

> As of Clang 19, users can determine the max number of conditions in a
> decision to measure via option LLVM_COV_KERNEL_MCDC_MAX_CONDITIONS, which
> controls -fmcdc-max-conditions flag of Clang cc1 [3]. Since MC/DC
> implementation utilizes bitmaps to track the execution of test vectors,
> more memory is consumed if larger decisions are getting counted. The

Some of this could potentially be in the Kconfig text below as it seems
relevant for users to make a decision on modifying its value.

> maximum value supported by Clang is 32767. According to local experiments,
> the working maximum for Linux kernel is 46, with the largest decisions in
> kernel codebase (with 47 conditions, as of v6.11) excluded, otherwise the
> kernel image size limit will be exceeded. The largest decisions in kernel
> are contributed for example by macros checking CPUID.
> 
> Code exceeding LLVM_COV_KERNEL_MCDC_MAX_CONDITIONS will produce compiler
> warnings.
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
>  instrumented." [4]

These two sets of warnings appear to be pretty noisy in my build
testing... Is there any way to shut them up? Perhaps it is good for
users to see these limitations but it basically makes the build output
useless. If there were switches, then they could be disabled in the
default case with a Kconfig option to turn them on if the user is
concerned with seeing which parts of their code are not instrumented. I
could see developers wanting to run this for writing tests and they
might not care about this as much as someone else might.

I did leave LLVM_COV_KERNEL_MCDC_MAX_CONDITIONS at its default value.
Perhaps there is a more reasonable default that would result in less
noisy build output but not run afoul of potential memory usage concerns?
I assume that mention means that memory usage may be a concern for the
type of deployments this technology would commonly be used with?

> Link: https://en.wikipedia.org/wiki/Modified_condition%2Fdecision_coverage [1]
> Link: https://digital-library.theiet.org/content/journals/10.1049/sej.1994.0025 [2]
> Link: https://discourse.llvm.org/t/rfc-coverage-new-algorithm-and-file-format-for-mc-dc/76798 [3]
> Link: https://clang.llvm.org/docs/SourceBasedCodeCoverage.html#mc-dc-instrumentation [4]

Thank you for using this link format :)

> Signed-off-by: Wentao Zhang <wentaoz5@illinois.edu>
> Reviewed-by: Chuck Wolber <chuck.wolber@boeing.com>
> Tested-by: Chuck Wolber <chuck.wolber@boeing.com>

From an actual code perspective, this looks good to me.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> diff --git a/Makefile b/Makefile
> index 51498134c..1185b38d6 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -740,6 +740,12 @@ all: vmlinux
>  CFLAGS_LLVM_COV := -fprofile-instr-generate -fcoverage-mapping
>  export CFLAGS_LLVM_COV
>  
> +CFLAGS_LLVM_COV_MCDC := -fcoverage-mcdc
> +ifdef CONFIG_LLVM_COV_KERNEL_MCDC_MAX_CONDITIONS
> +CFLAGS_LLVM_COV_MCDC += -Xclang -fmcdc-max-conditions=$(CONFIG_LLVM_COV_KERNEL_MCDC_MAX_CONDITIONS)

Why is -Xclang needed here? Is this not a full frontend flag?

> +endif
> +export CFLAGS_LLVM_COV_MCDC
> +
>  CFLAGS_GCOV	:= -fprofile-arcs -ftest-coverage
>  ifdef CONFIG_CC_IS_GCC
>  CFLAGS_GCOV	+= -fno-tree-loop-im

