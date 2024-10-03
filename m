Return-Path: <linux-arch+bounces-7658-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDE798F2DB
	for <lists+linux-arch@lfdr.de>; Thu,  3 Oct 2024 17:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CF611C20A88
	for <lists+linux-arch@lfdr.de>; Thu,  3 Oct 2024 15:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58AAB1A7059;
	Thu,  3 Oct 2024 15:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M2/s63Um"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9498C1A4E98;
	Thu,  3 Oct 2024 15:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727970144; cv=none; b=J4cpxlqr7LOSMLjBHH0upHNboQlUxz0JrCWUGgAJzsgFVW2tNYR/GkUqLDnopiDXIK3rV1QMd/e2McY6RNsBWbHAZtVhLxO57kliQwlxMPOOesioyPsl+8vXfkjhsdlLPdQ/Kt96XhhSfO8jInxC0Q5CV5m3qfcS7vHyJnHptU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727970144; c=relaxed/simple;
	bh=8edyMGdPs1E6rRzMbnUTccODAMVgZWrvnryOERBMBnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RawpJ0U5qbtbNlrgsno7BRAsnHHOYA4l7C3aXdr8LeCfgkkfejdD90NLEAxTBIYugoi4K+bLs7LFrQqeT98k9Q/a7jKTM5oWmkYuD+bS0pn4t5kzGVmqlMskluWso21HvJdMwrc4D7p2wY+Wi2rwIFPa6/N01n12Ktph0sdtsnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=M2/s63Um; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XVfI0BZqU1RL6xxv57u2bqRWM557PiZU05SHsPuMoLg=; b=M2/s63Um06Oso+HcoLBtINfqA3
	t8DUf0LoISRruRFEx+58utbrQMUSOSqWIfT3UroQXyglXG+YKmGaaWuZY56ImH7NoA68UPNgyKFdq
	wge3+osiznkIhuRnml56oluVJPrwzi+7BC+68U/Va2CEn9YWBZ0p1EpQhqLa3clqLBsGDowUr9Sfm
	Ffe+PTE3ZwzDoXV0hkgV/237RrTxpOihTDuzeLWGJjbsymMar3or89VumRUGLlgF+qmjKVL9np1y9
	CQdLTWsisDoLbTsVu9u9Q2Gn1xWViaSlphZ/+4XO9/7wXYf8e5omHbYJxh2geoFh1XOwjbVPmWgSG
	2PDeyFEg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1swNxY-000000089r1-06Bo;
	Thu, 03 Oct 2024 15:41:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 872BE30083E; Thu,  3 Oct 2024 17:41:43 +0200 (CEST)
Date: Thu, 3 Oct 2024 17:41:43 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Rong Xu <xur@google.com>
Cc: Han Shen <shenhan@google.com>, Sriraman Tallam <tmsriram@google.com>,
	David Li <davidxl@google.com>,
	Krzysztof Pszeniczny <kpszeniczny@google.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Bill Wendling <morbo@google.com>,
	Borislav Petkov <bp@alien8.de>, Breno Leitao <leitao@debian.org>,
	Brian Gerst <brgerst@gmail.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>,
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, Masahiro Yamada <masahiroy@kernel.org>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wei Yang <richard.weiyang@gmail.com>, workflows@vger.kernel.org,
	x86@kernel.org, "Xin Li (Intel)" <xin@zytor.com>,
	Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2 1/6] Add AutoFDO support for Clang build
Message-ID: <20241003154143.GW5594@noisy.programming.kicks-ass.net>
References: <20241002233409.2857999-1-xur@google.com>
 <20241002233409.2857999-2-xur@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002233409.2857999-2-xur@google.com>

On Wed, Oct 02, 2024 at 04:34:00PM -0700, Rong Xu wrote:
> +Preparation
> +===========
> +
> +Configure the kernel with:
> +
> +   .. code-block:: make
> +
> +      CONFIG_AUTOFDO_CLANG=y
> +
> +Customization
> +=============
> +
> +You can enable or disable AutoFDO build for individual file and directories by
> +adding a line similar to the following to the respective kernel Makefile:
> +
> +- For enabling a single file (e.g. foo.o)
> +
> +     .. code-block:: make
> +
> +        AUTOFDO_PROFILE_foo.o := y
> +
> +- For enabling all files in one directory
> +
> +     .. code-block:: make
> +
> +        AUTOFDO_PROFILE := y
> +
> +- For disabling one file
> +
> +     .. code-block:: make
> +
> +        AUTOFDO_PROFILE_foo.o := n
> +
> +- For disabling all files in one directory
> +
> +     .. code-block:: make
> +
> +        AUTOFDO_PROFILE := n
> +
> +
> +Workflow
> +========
> +
> +Here is an example workflow for AutoFDO kernel:
> +
> +
> +
> +1)  Build the kernel on the HOST machine with LLVM enabled, for example,
> +
> +      .. code-block:: make
> +
> +         $ make menuconfig LLVM=1
> +
> +
> +    Turn on AutoFDO build config:
> +
> +      .. code-block:: make
> +
> +         CONFIG_AUTOFDO_CLANG=y
> +
> +    With a configuration that with LLVM enabled, use the following command:
> +
> +      .. code-block:: sh
> +
> +         $ scripts/config -e AUTOFDO_CLANG
> +
> +    After getting the config, build with
> +
> +      .. code-block:: make
> +
> +         $ make LLVM=1
> +
> +2) Install the kernel on the TEST machine.
> +
> +3) Run the load tests. The '-c' option in perf specifies the sample
> +   event period. We suggest using a suitable prime number, like 500009,
> +   for this purpose.
> +
> +   - For Intel platforms:
> +
> +      .. code-block:: sh
> +
> +         $ perf record -e BR_INST_RETIRED.NEAR_TAKEN:k -a -N -b -c <count> -o <perf_file> -- <loadtest>
> +
> +   - For AMD platforms: For Intel platforms:
> +     The supported systems are: Zen3 with BRS, or Zen4 with amd_lbr_v2. To check,
> +     For Zen3:
> +
> +      .. code-block:: sh
> +
> +         $ cat proc/cpuinfo | grep " brs"
> +
> +      For Zen4:
> +
> +      .. code-block:: sh
> +
> +         $ cat proc/cpuinfo | grep amd_lbr_v2
> +
> +      The following command generated the perf data file:
> +
> +      .. code-block:: sh
> +
> +         $ perf record --pfm-events RETIRED_TAKEN_BRANCH_INSTRUCTIONS:k -a -N -b \
> +           -c <count> -o <perf_file> -- <loadtest>
> +
> +4) (Optional) Download the raw perf file to the HOST machine.
> +
> +5) To generate an AutoFDO profile, two offline tools are available:
> +   create_llvm_prof and llvm_profgen. The create_llvm_prof tool is part
> +   of the AutoFDO project and can be found on GitHub
> +   (https://github.com/google/autofdo),  version v0.30.1 or later.
> +   The llvm_profgen tool is included in the LLVM compiler itself. It's
> +   important to note that the version of llvm_profgen doesn't need to match
> +   the version of Clang. It needs to be the LLVM 19 release of Clang
> +   or later, or just from the LLVM trunk.
> +
> +      .. code-block:: sh
> +
> +         $ llvm-profgen --kernel --binary=<vmlinux> --perfdata=<perf_file> -o <profile_file>
> +
> +   or
> +      .. code-block:: sh
> +
> +         $ create_llvm_prof --binary=<vmlinux> --profile=<perf_file> --format=extbinary -o <profile_file>
> +
> +   Note that multiple AutoFDO profile files can be merged into one via:
> +
> +      .. code-block:: sh
> +
> +         $ llvm-profdata merge -o <profile_file>  <profile_1> <profile_2> ... <profile_n>
> +
> +
> +6) Rebuild the kernel using the AutoFDO profile file with the same config as step 1,
> +    (Note CONFIG_AUTOFDO_CLANG needs to be enabled):
> +
> +      .. code-block:: sh
> +
> +         $ make LLVM=1 CLANG_AUTOFDO_PROFILE=<profile_file
> +


Can this be done without the endless ... code-block nonsense?

