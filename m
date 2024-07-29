Return-Path: <linux-arch+bounces-5671-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC2B93F024
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jul 2024 10:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E2D31F2218B
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jul 2024 08:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A558B13B597;
	Mon, 29 Jul 2024 08:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="leoCy3lX"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5CF328B6;
	Mon, 29 Jul 2024 08:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722243086; cv=none; b=aM+t5kr+avTijml+epLPFp6nOQYqy+i5zmNvQ5ZQ/Fson6iL1v76jdFBhKeAjMQm1TRFIBsCgUWHdfonmPJL7hptIDfAQQGHdihzb0fznKtWCFwrFUp2aZlxMBgZs6/4RB+9lNBX4RehQ7rua7TnWrWSHZTB7Vc43+898lFMPU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722243086; c=relaxed/simple;
	bh=t036mvc+S68XKyD1LE/5fTRSY8CMezFH4ZsbUu+gbu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NUw2H9+mmea/EKHWyEmhAzkZkn1bpD3mYvCGq2+sJfvyijBKg/+S2o4apn3Bj0a/Lveaw4z+WK/8X4xcSWa2L9E6HJwwGSzoullfXq9ikxhHEe3WwZXtPkHM/E6+eoFKlvLqsApiwjB6lqMD+CbETvT0543fNjaEHMxx6Y4Lv14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=leoCy3lX; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=K4Jpsm5DX88VFcPkZAIC2BbJowza/7NzQCGPZM8v4Pg=; b=leoCy3lXxnAROtLduJbi58x+ak
	vI83fhz1KRN0OKOHF9/v9rOWLljOxxQE7kKJxogxjurDjS6RQ7Gsx3t74CsbpZTpaj+k+wK9Z0LNG
	qNga4tYbc/8WfSawf2actItMHYw04fFsFPlDzr+IRYRE1lavh/WGNDmfceEkkWRt+vs3iHiGkfeYa
	9NnvhaB3hJ138b7JRaq92Ko7cxrCNOoneGqQUq2hEFtOwhk7AOnKCrhP4JXFlmHl3lfCb41YrS1MW
	HVfC435p+KCfRPZQ57xdgXwVJxwCktblqaOG4l0iH99dtxLgBeAk1DfWF+YmJdFUxNld25x0vMWnD
	S4k9Ho0g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYM5l-0000000DOBC-20zs;
	Mon, 29 Jul 2024 08:50:53 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4B394300439; Mon, 29 Jul 2024 10:50:52 +0200 (CEST)
Date: Mon, 29 Jul 2024 10:50:52 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Rong Xu <xur@google.com>
Cc: Han Shen <shenhan@google.com>, Sriraman Tallam <tmsriram@google.com>,
	David Li <davidxl@google.com>, Jonathan Corbet <corbet@lwn.net>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	John Moon <john@jmoon.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Mike Rapoport <rppt@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Rafael Aquini <aquini@redhat.com>, Petr Pavlu <petr.pavlu@suse.com>,
	Eric DeVolder <eric.devolder@oracle.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Benjamin Segall <bsegall@google.com>,
	Breno Leitao <leitao@debian.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	Brian Gerst <brgerst@gmail.com>, Juergen Gross <jgross@suse.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Kees Cook <kees@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Xiao Wang <xiao.w.wang@intel.com>,
	Jan Kiszka <jan.kiszka@siemens.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-efi@vger.kernel.org, linux-arch@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH 0/6] Add AutoFDO and Propeller support for Clang build
Message-ID: <20240729085052.GA37996@noisy.programming.kicks-ass.net>
References: <20240728203001.2551083-1-xur@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240728203001.2551083-1-xur@google.com>

On Sun, Jul 28, 2024 at 01:29:53PM -0700, Rong Xu wrote:
> Hi,
> 
> This patch series is to integrate AutoFDO and Propeller support into
> the Linux kernel. AutoFDO is a profile-guided optimization technique
> that leverages hardware sampling to enhance binary performance.
> Unlike Instrumentation-based FDO (iFDO), AutoFDO offers a user-friendly
> and straightforward application process. While iFDO generally yields
> superior profile quality and performance, our findings reveal that
> AutoFDO achieves remarkable effectiveness, bringing performance close
> to iFDO for benchmark applications. Similar to AutoFDO, Propeller too
> utilizes hardware sampling to collect profiles and apply post-link
> optimizations to improve the benchmark’s performance over and above
> AutoFDO.
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

This, 

> Propeller is a profile-guided, post-link optimizer that improves
> the performance of large-scale applications compiled with LLVM. It
> operates by relinking the binary based on an additional round of runtime
> profiles, enabling precise optimizations that are not possible at
> compile time.

should be on top somewhere, not hidden away inside a giant wall of text
somewhere at the end.

