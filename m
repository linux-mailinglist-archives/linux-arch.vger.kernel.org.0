Return-Path: <linux-arch+bounces-7613-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E471D98CA08
	for <lists+linux-arch@lfdr.de>; Wed,  2 Oct 2024 02:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17D9B1F23B05
	for <lists+linux-arch@lfdr.de>; Wed,  2 Oct 2024 00:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBA01103;
	Wed,  2 Oct 2024 00:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PE6jT2YQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DA1391;
	Wed,  2 Oct 2024 00:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727829061; cv=none; b=n7YY40wNmZNo1qzRTfXP3fAUTUwcIkSv4d2Q6uroihhvuqNYuWwdi3e6V54DfTSb8wFT53gO8w+pHIjrboAZFBBXgVEZJk+crc99sQYL0L9EKemr0h5GZjUzAeT0gSSGPV22DFPAMtsgOFWzabAApzVFpEoNK4zPPKSD10Kdx/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727829061; c=relaxed/simple;
	bh=BxPeAVwstxQ1ZJ84CwLHPEPKo/cBlSdPvkP8DRN5uK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yu5GXPSQXvvWsoLSuCM/fjE6OMhFNxxZMd3IeedFAwJCX39oQ/+fh4I4E3dVzSXfngCIm135yPuq4dpnVabLUo7PddlycVc/IEHcvJS8rOURp8iPYaHsu3UM+R53+HpFA4GhAOO9rGQ1J2VT90gqq+6uKW7579Wlb+0/6aP5QWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PE6jT2YQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3AB9C4CEC6;
	Wed,  2 Oct 2024 00:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727829060;
	bh=BxPeAVwstxQ1ZJ84CwLHPEPKo/cBlSdPvkP8DRN5uK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PE6jT2YQaZdkUbaGKw4pSJAdOvVjTXy11QHLRyTlXG4ovw5/38hAr9SuULf/Azdjs
	 ZEZMC3d+UiHzdxC2HmPtaIrnp/QmtwnnkNe4vUlGZX173WkU2AJk7EapZo7InyliDQ
	 /5JPC66Ocx4TgM4XcCPqSgwb1+Z2qoIdeymJW06Asr+tIjrYdu7tkJptccj/enfRfm
	 adirRpJlVWytzCyl7F8egM9yzEJtv48Wjb0GJgHXPcsnn+adbjjRy6yOG4xHnuYlAG
	 WCz2Y3nS6k6LeucH3EFARyU/b42JUEazEIqo0852TpuoZ/xPLmzrFD/E2smR7rprbK
	 sYYXQrqnS86jA==
Date: Tue, 1 Oct 2024 17:30:56 -0700
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
Subject: Re: [PATCH v2 1/4] llvm-cov: add Clang's Source-based Code Coverage
 support
Message-ID: <20241002003056.GA555609@thelio-3990X>
References: <20240824230641.385839-1-wentaoz5@illinois.edu>
 <20240905043245.1389509-1-wentaoz5@illinois.edu>
 <20240905043245.1389509-2-wentaoz5@illinois.edu>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905043245.1389509-2-wentaoz5@illinois.edu>

Hi Wentao,

On Wed, Sep 04, 2024 at 11:32:42PM -0500, Wentao Zhang wrote:
> Add infrastructure to support Clang's source-based code coverage [1]. This
> includes debugfs entries for serializing profiles and resetting
> counters/bitmaps.  Also adds coverage flags and kconfig options.

Some superficial comments below. My general understanding of
implementing a standalone compiler-rt interface is not super deep, so I
won't really comment on that code, but it seems generally fine to me.
From a coding style perspective, everything seems reasonable, assuming
it passes checkpatch.pl (I didn't check). The Kbuild bits look good as
well, they match the gcov implementation.

As most of my comments are more nits than anything else, feel free to
carry this over:

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> diff --git a/kernel/llvm-cov/Kconfig b/kernel/llvm-cov/Kconfig
> new file mode 100644
> index 000000000..9241fdfb0
> --- /dev/null
> +++ b/kernel/llvm-cov/Kconfig
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +menu "Clang's source-based kernel coverage measurement (EXPERIMENTAL)"
> +
> +config ARCH_HAS_LLVM_COV
> +	bool
> +
> +config ARCH_HAS_LLVM_COV_PROFILE_ALL
> +	bool

It might be worth mentioning somewhere in here what architectures need
to do to implement this in their architectures. I can surmise from the
x86 patches that it appears to just be excluding files from
instrumentation that need to be free from it and adding the sections to
their linker file but if there are any gotchas, documentation would help
other architectures impelement this, since it seems pretty useful for
development.

> +config LLVM_COV_KERNEL
> +	bool "Enable Clang's source-based kernel coverage measurement"
> +	depends on DEBUG_FS
> +	depends on ARCH_HAS_LLVM_COV
> +	depends on CC_IS_CLANG && CLANG_VERSION >= 180000
> +	default n

Drop this, it is the default.

> +	help
> +	  This option enables Clang's Source-based Code Coverage.
> +
> +	  If unsure, say N.
> +
> +	  On a kernel compiled with this option, run your test suites, and
> +	  download the raw profile from /sys/kernel/debug/llvm-cov/profraw.
> +	  This file can then be converted into the indexed format with
> +	  llvm-profdata and used to generate coverage reports with llvm-cov.
> +
> +	  Additionally specify CONFIG_LLVM_COV_PROFILE_ALL=y to get profiling
> +	  data for the entire kernel. To enable profiling for specific files or
> +	  directories, add a line similar to the following to the respective
> +	  Makefile:
> +
> +	  For a single file (e.g. main.o):
> +	          LLVM_COV_PROFILE_main.o := y
> +
> +	  For all files in one directory:
> +	          LLVM_COV_PROFILE := y
> +
> +	  To exclude files from being profiled even when
> +	  CONFIG_LLVM_COV_PROFILE_ALL is specified, use:
> +
> +	          LLVM_COV_PROFILE_main.o := n
> +	  and:
> +	          LLVM_COV_PROFILE := n
> +
> +	  Note that a kernel compiled with coverage flags will be significantly
> +	  larger and run slower.
> +
> +	  Note that the debugfs filesystem has to be mounted to access the raw
> +	  profile.
> +
> +config LLVM_COV_PROFILE_ALL
> +	bool "Profile entire Kernel"
> +	depends on !COMPILE_TEST
> +	depends on LLVM_COV_KERNEL
> +	depends on ARCH_HAS_LLVM_COV_PROFILE_ALL
> +	default n

Ditto as above.

> +	help
> +	  This options activates profiling for the entire kernel.
> +
> +	  If unsure, say N.
> +
> +	  Note that a kernel compiled with profiling flags will be significantly
> +	  larger and run slower.
> +
> +endmenu
> diff --git a/kernel/llvm-cov/Makefile b/kernel/llvm-cov/Makefile
> new file mode 100644
> index 000000000..f6a236562
> --- /dev/null
> +++ b/kernel/llvm-cov/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0
> +GCOV_PROFILE		:= n

Adding this seems to imply that GCOV and llvm-cov can be active at the
same time and work together? Does that make sense? Are there things that
GCOV can track that llvm-cov cannot? If any of the answers to those
questions are no, would it make sense to make these mutually exclusive
via Kconfig?

> +LLVM_COV_PROFILE	:= n
> +
> +obj-y	+= fs.o
...
> diff --git a/kernel/llvm-cov/llvm-cov.h b/kernel/llvm-cov/llvm-cov.h
> new file mode 100644
> index 000000000..d9551a685
> --- /dev/null
> +++ b/kernel/llvm-cov/llvm-cov.h
> @@ -0,0 +1,156 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2019	Sami Tolvanen <samitolvanen@google.com>, Google, Inc.
> + * Copyright (C) 2024	Jinghao Jia   <jinghao7@illinois.edu>,   UIUC
> + * Copyright (C) 2024	Wentao Zhang  <wentaoz5@illinois.edu>,   UIUC
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.

FWIW, I think you can drop this boilerplate text when you include the
SPDX indentifier:

"An alternative to boilerplate text is the use of Software Package Data
Exchange (SPDX) license identifiers in each source file."

https://www.kernel.org/doc/html/latest/process/license-rules.html

> +#if defined(CONFIG_CC_IS_CLANG) && CONFIG_CLANG_VERSION >= 190000
> +#define INSTR_PROF_RAW_VERSION		10
> +#define INSTR_PROF_DATA_ALIGNMENT	8
> +#define IPVK_LAST			2
> +#elif defined(CONFIG_CC_IS_CLANG) && CONFIG_CLANG_VERSION >= 180000
> +#define INSTR_PROF_RAW_VERSION		9
> +#define INSTR_PROF_DATA_ALIGNMENT	8
> +#define IPVK_LAST			1
> +#endif

It might be interesting to note the commit from LLVM 19 that introduced
the need for this change and what happens when it is not updated so that
any future breakage can be quickly addressed by people other than
yourself.

Cheers,
Nathan

