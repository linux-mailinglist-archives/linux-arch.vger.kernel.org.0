Return-Path: <linux-arch+bounces-8298-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BFB9A521B
	for <lists+linux-arch@lfdr.de>; Sun, 20 Oct 2024 05:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58C381C2130E
	for <lists+linux-arch@lfdr.de>; Sun, 20 Oct 2024 03:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84D22F2D;
	Sun, 20 Oct 2024 03:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sqomLIyf"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895251372;
	Sun, 20 Oct 2024 03:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729395080; cv=none; b=vGpKEXLa9Rjvy9CIne4MQDPy+4vYUiVoOPp9fkI1CXttFOV7rWhxpxJpON7itbqi35H1jk4EpS/A08/1aaH/Pg1Xl9Rkhv/A3N1ZcRDB8fpm/B8GB+C9Tyb+X8l1n1+NNqG12nl/6GOHGcsFqJPsN5p0CwP+ypTPTi33QG5S5QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729395080; c=relaxed/simple;
	bh=b9FLBWFXiC7ohwQHtFDn51eBpM4P0WMyAPnAjfBfOLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dYYVZztFylveq9MtheOPHcNO0sTD1dcGCiHA8wEXrw1EOyFIpw9lPDIzyXP+GDCqAoGU2cFJXuDlY+Q6T7jwMeFj325Qgk5zzv8uhmt1/0sPftaMLTJ7M0DeqTpbCyq3kRlT8cStU9xoyekLCkn/7IBDlgPFmFAYLMRpesz4xq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sqomLIyf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22EDBC4CEC6;
	Sun, 20 Oct 2024 03:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729395080;
	bh=b9FLBWFXiC7ohwQHtFDn51eBpM4P0WMyAPnAjfBfOLo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sqomLIyfqKrSMAyURt1xh9YUxdtVTjL6ewzHeG2NH370XmLST8l+P3FwkpqnQKIGE
	 Zcaey6Fqpdlo79esRLV6qZk0PK9tkYWyffnTvwBDqXFujrF/hLb31hhhmPLqAEBk9K
	 C7f2EQcB6KOgxUFOxNEtUGg1TD2L61pdq/+zkejiX/CEZ1JJ4JDBC7k5dEoF7oVfjy
	 rseWs0Jvq3GUIPH2uiTBVGAV6disvbXv0hgcGQz3GGlfPEfYSdMKem5GVG+f76TclF
	 kxDE45lH1h+XaciiyemrhrovtdVtFggZAsp+p8AzXfAVkviN1gfuFGivwEJS9La9Bn
	 /fjqRR/Wx9Egg==
Date: Sat, 19 Oct 2024 20:31:16 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Rong Xu <xur@google.com>, Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Arnd Bergmann <arnd@arndb.de>,
	Bill Wendling <morbo@google.com>, Borislav Petkov <bp@alien8.de>,
	Breno Leitao <leitao@debian.org>, Brian Gerst <brgerst@gmail.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Li <davidxl@google.com>, Han Shen <shenhan@google.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wei Yang <richard.weiyang@gmail.com>, workflows@vger.kernel.org,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Maksim Panchenko <max4bolt@gmail.com>, x86@kernel.org,
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v4 0/6] Add AutoFDO and Propeller support for Clang build
Message-ID: <20241020033116.GA3653827@thelio-3990X>
References: <20241014213342.1480681-1-xur@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241014213342.1480681-1-xur@google.com>

Hi Masahiro and Andrew,

Top posting only for visibility. Would it make more sense to have this
land via the Kbuild tree or -mm? The core of the series really touches
Kbuild and I think the x86 stuff can just land with Acks, unless the
-tip folks feel differently. I would like Rong to have a relatively
clear path forward to mainline once the requisite review and testing has
accomplished, which requires a shepherd :)

Cheers,
Nathan

On Mon, Oct 14, 2024 at 02:33:34PM -0700, Rong Xu wrote:
> Hi,
> 
> This patch series is to integrate AutoFDO and Propeller support into
> the Linux kernel. AutoFDO is a profile-guided optimization technique
> that leverages hardware sampling to enhance binary performance.
> Unlike Instrumentation-based FDO (iFDO), AutoFDO offers a user-friendly
> and straightforward application process. While iFDO generally yields
> superior profile quality and performance, our findings reveal that
> AutoFDO achieves remarkable effectiveness, bringing performance close
> to iFDO for benchmark applications.
> 
> Propeller is a profile-guided, post-link optimizer that improves
> the performance of large-scale applications compiled with LLVM. It
> operates by relinking the binary based on an additional round of runtime
> profiles, enabling precise optimizations that are not possible at
> compile time.  Similar to AutoFDO, Propeller too utilizes hardware
> sampling to collect profiles and apply post-link optimizations to improve
> the benchmark’s performance over and above AutoFDO.
> 
> Our empirical data demonstrates significant performance improvements
> with AutoFDO and Propeller, up to 10% on microbenchmarks and up to 5%
> on large warehouse-scale benchmarks. This makes a strong case for their
> inclusion as supported features in the upstream kernel.
> 
> Background
> 
> A significant fraction of fleet processing cycles (excluding idle time)
> from data center workloads are attributable to the kernel. Ware-house
> scale workloads maximize performance by optimizing the production kernel
> using iFDO (a.k.a instrumented PGO, Profile Guided Optimization).
> 
> iFDO can significantly enhance application performance but its use
> within the kernel has raised concerns. AutoFDO is a variant of FDO that
> uses the hardware’s Performance Monitoring Unit (PMU) to collect
> profiling data. While AutoFDO typically yields smaller performance
> gains than iFDO, it presents unique benefits for optimizing kernels.
> 
> AutoFDO eliminates the need for instrumented kernels, allowing a single
> optimized kernel to serve both execution and profile collection. It also
> minimizes slowdown during profile collection, potentially yielding
> higher-fidelity profiling, especially for time-sensitive code, compared
> to iFDO. Additionally, AutoFDO profiles can be obtained from production
> environments via the hardware’s PMU whereas iFDO profiles require
> carefully curated load tests that are representative of real-world
> traffic.
> 
> AutoFDO facilitates profile collection across diverse targets.
> Preliminary studies indicate significant variation in kernel hot spots
> within Google’s infrastructure, suggesting potential performance gains
> through target-specific kernel customization.
> 
> Furthermore, other advanced compiler optimization techniques, including
> ThinLTO and Propeller can be stacked on top of AutoFDO, similar to iFDO.
> ThinLTO achieves better runtime performance through whole-program
> analysis and cross module optimizations. The main difference between
> traditional LTO and ThinLTO is that the latter is scalable in time and
> memory.
> 
> This patch series adds AutoFDO and Propeller support to the kernel. The
> actual solution comes in six parts:
> 
> [P 1] Add the build support for using AutoFDO in Clang
> 
>       Add the basic support for AutoFDO build and provide the
>       instructions for using AutoFDO.
> 
> [P 2] Fix objtool for bogus warnings when -ffunction-sections is enabled
> 
> [P 3] Change the subsection ordering when -ffunction-sections is enabled
> 
> [P 4] Enable –ffunction-sections for the AutoFDO build
> 
> [P 5] Enable Machine Function Split (MFS) optimization for AutoFDO
> 
> [P 6] Add Propeller configuration to the kernel build
> 
> Patch 1 provides basic AutoFDO build support. Patches 2 to 5 further
> enhance the performance of AutoFDO builds and are functionally dependent
> on Patch 1. Patch 6 enables support for Propeller and is dependent on
> patch 2 and patch 3.
> 
> Caveats
> 
> AutoFDO is compatible with both GCC and Clang, but the patches in this
> series are exclusively applicable to LLVM 17 or newer for AutoFDO and
> LLVM 19 or newer for Propeller. For profile conversion, two different
> tools could be used, llvm_profgen or create_llvm_prof. llvm_profgen
> needs to be the LLVM 19 or newer, or just the LLVM trunk. Alternatively,
> create_llvm_prof v0.30.1 or newer can be used instead of llvm-profgen.
> 
> Additionally, the build is only supported on x86 platforms equipped
> with PMU capabilities, such as LBR on Intel machines. More
> specifically:
>  * Intel platforms: works on every platform that supports LBR;
>    we have tested on Skylake.
>  * AMD platforms: tested on AMD Zen3 with the BRS feature. The kernel
>    needs to be configured with “CONFIG_PERF_EVENTS_AMD_BRS=y", To
>    check, use
>    $ cat /proc/cpuinfo | grep “ brs”
>    For the AMD Zen4, AMD LBRV2 is supported, but we suspect a bug with
>    AMD LBRv2 implementation in Genoa which blocks the usage.
> 
> Experiments and Results
> 
> Experiments were conducted to compare the performance of AutoFDO-optimized
> kernel images (version 6.9.x) against default builds.. The evaluation
> encompassed both open source microbenchmarks and real-world production
> services from Google and Meta. The selected microbenchmarks included Neper,
> a network subsystem benchmark, and UnixBench which is a comprehensive suite
> for assessing various kernel operations.
> 
> For Neper, AutoFDO optimization resulted in a 6.1% increase in throughput
> and a 10.6% reduction in latency. Unixbench saw a 2.2% improvement in its
> index score under low system load and a 2.6% improvement under high system
> load.
> 
> For further details on the improvements observed in Google and Meta's
> production services, please refer to the LLVM discourse post:
> https://discourse.llvm.org/t/optimizing-the-linux-kernel-with-autofdo-including-thinlto-and-propeller/79108
...
> Rong Xu (6):
>   Add AutoFDO support for Clang build
>   objtool: Fix unreachable instruction warnings for weak funcitons
>   Change the symbols order when --ffuntion-sections is enabled
>   AutoFDO: Enable -ffunction-sections for the AutoFDO build
>   AutoFDO: Enable machine function split optimization for AutoFDO
>   Add Propeller configuration for kernel build.
> 
>  Documentation/dev-tools/autofdo.rst   | 165 ++++++++++++++++++++++++++
>  Documentation/dev-tools/index.rst     |   2 +
>  Documentation/dev-tools/propeller.rst | 161 +++++++++++++++++++++++++
>  MAINTAINERS                           |  14 +++
>  Makefile                              |   2 +
>  arch/Kconfig                          |  42 +++++++
>  arch/x86/Kconfig                      |   2 +
>  arch/x86/kernel/vmlinux.lds.S         |   4 +
>  include/asm-generic/vmlinux.lds.h     |  54 +++++++--
>  scripts/Makefile.autofdo              |  25 ++++
>  scripts/Makefile.lib                  |  20 ++++
>  scripts/Makefile.propeller            |  28 +++++
>  tools/objtool/check.c                 |   2 +
>  tools/objtool/elf.c                   |  15 ++-
>  14 files changed, 524 insertions(+), 12 deletions(-)
>  create mode 100644 Documentation/dev-tools/autofdo.rst
>  create mode 100644 Documentation/dev-tools/propeller.rst
>  create mode 100644 scripts/Makefile.autofdo
>  create mode 100644 scripts/Makefile.propeller
> 
> 
> base-commit: eb952c47d154ba2aac794b99c66c3c45eb4cc4ec
> -- 
> 2.47.0.rc1.288.g06298d1525-goog
> 

