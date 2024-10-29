Return-Path: <linux-arch+bounces-8676-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 191E29B3EDC
	for <lists+linux-arch@lfdr.de>; Tue, 29 Oct 2024 01:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51A621C22423
	for <lists+linux-arch@lfdr.de>; Tue, 29 Oct 2024 00:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84B03207;
	Tue, 29 Oct 2024 00:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mde/PyOW"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE682F56;
	Tue, 29 Oct 2024 00:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730160527; cv=none; b=TtQ5RSpcF0fnpP0JIel/yUmXiP2uSWVijqldpUJnddfJzSP3QRK3W/PoBWOO6QCOYOpEDYdJyjme7Lx9nVKQOuzu36yMwWpHqbxwwtd+uKA3p/+SoKAtmnU0DiZjiVqYvWknvRxBaoVmD7Tw+Rhbbc2RrJ28sVYhYU1ga4qcH70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730160527; c=relaxed/simple;
	bh=Z9kYOx9QnUfURSK1MXGxCRMihyc/NCGFbBjvOnQS5Ak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UZ2hEIvLWa7raFHkWSgLQcyqoVqUr6JKiyKRjeKfx/roog0eT8bZ5EZz/Ft4dcDVmMPcFH7yhsMwBzVOjpQrLIXdb4LsuFFtLfKOeY2UPccgiyC5yJQtk7l/qawK4e0a0O0DW0nCvDUF9K5iVypZtPiax9U2xZlP1LdG8Dz8EyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mde/PyOW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F74DC4CEC3;
	Tue, 29 Oct 2024 00:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730160527;
	bh=Z9kYOx9QnUfURSK1MXGxCRMihyc/NCGFbBjvOnQS5Ak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mde/PyOWw84L/lIa5qt7MfY0O//i8GHeEiFKdrAWz9TwI+crY9yjuOc+3nAYEOX0Y
	 5kgPSzFPey3nnMmE2fj6l0VfR4kuwXv3kxArQ25tg2hJr5gaaeN57tUuuWD6gcuWeM
	 Hc6zSw8QI4qIdsFv2FeTRTDXHPNI+Jx5/JP5gTwXSFzx2RBoDVffwiWDAO3hX7v+6K
	 oLoaTi/uHQDDJ5NXNyAyrY00ayAzKBUeC9N6z01oOhBnRBgf08jeemx/wfnGqLPpGy
	 sbivf++RkfHeURmNx/EvWYm2pGHhXkBUgtMeJQ8xdBQhaTkPJYrgOtLhw6GVjnTwN6
	 uy/HtlQljqEtQ==
Date: Mon, 28 Oct 2024 17:08:44 -0700
From: Kees Cook <kees@kernel.org>
To: Rong Xu <xur@google.com>
Cc: Alice Ryhl <aliceryhl@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, Bill Wendling <morbo@google.com>,
	Borislav Petkov <bp@alien8.de>, Breno Leitao <leitao@debian.org>,
	Brian Gerst <brgerst@gmail.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Li <davidxl@google.com>, Han Shen <shenhan@google.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Justin Stitt <justinstitt@google.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wei Yang <richard.weiyang@gmail.com>, workflows@vger.kernel.org,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Maksim Panchenko <max4bolt@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Yabin Cui <yabinc@google.com>,
	Krzysztof Pszeniczny <kpszeniczny@google.com>,
	Sriraman Tallam <tmsriram@google.com>,
	Stephane Eranian <eranian@google.com>, x86@kernel.org,
	linux-arch@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v6 1/7] Add AutoFDO support for Clang build
Message-ID: <202410281708.83F316FF@keescook>
References: <20241026051410.2819338-1-xur@google.com>
 <20241026051410.2819338-2-xur@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241026051410.2819338-2-xur@google.com>

On Fri, Oct 25, 2024 at 10:14:03PM -0700, Rong Xu wrote:
> Add the build support for using Clang's AutoFDO. Building the kernel
> with AutoFDO does not reduce the optimization level from the
> compiler. AutoFDO uses hardware sampling to gather information about
> the frequency of execution of different code paths within a binary.
> This information is then used to guide the compiler's optimization
> decisions, resulting in a more efficient binary. Experiments
> showed that the kernel can improve up to 10% in latency.
> 
> The support requires a Clang compiler after LLVM 17. This submission
> is limited to x86 platforms that support PMU features like LBR on
> Intel machines and AMD Zen3 BRS. Support for SPE on ARM 1,
>  and BRBE on ARM 1 is part of planned future work.
> 
> Here is an example workflow for AutoFDO kernel:
> 
> 1) Build the kernel on the host machine with LLVM enabled, for example,
>        $ make menuconfig LLVM=1
>     Turn on AutoFDO build config:
>       CONFIG_AUTOFDO_CLANG=y
>     With a configuration that has LLVM enabled, use the following
>     command:
>        scripts/config -e AUTOFDO_CLANG
>     After getting the config, build with
>       $ make LLVM=1
> 
> 2) Install the kernel on the test machine.
> 
> 3) Run the load tests. The '-c' option in perf specifies the sample
>    event period. We suggest     using a suitable prime number,
>    like 500009, for this purpose.
>    For Intel platforms:
>       $ perf record -e BR_INST_RETIRED.NEAR_TAKEN:k -a -N -b -c <count> \
>         -o <perf_file> -- <loadtest>
>    For AMD platforms:
>       The supported system are: Zen3 with BRS, or Zen4 with amd_lbr_v2
>      For Zen3:
>       $ cat proc/cpuinfo | grep " brs"
>       For Zen4:
>       $ cat proc/cpuinfo | grep amd_lbr_v2
>       $ perf record --pfm-events RETIRED_TAKEN_BRANCH_INSTRUCTIONS:k -a \
>         -N -b -c <count> -o <perf_file> -- <loadtest>
> 
> 4) (Optional) Download the raw perf file to the host machine.
> 
> 5) To generate an AutoFDO profile, two offline tools are available:
>    create_llvm_prof and llvm_profgen. The create_llvm_prof tool is part
>    of the AutoFDO project and can be found on GitHub
>    (https://github.com/google/autofdo), version v0.30.1 or later. The
>    llvm_profgen tool is included in the LLVM compiler itself. It's
>    important to note that the version of llvm_profgen doesn't need to
>    match the version of Clang. It needs to be the LLVM 19 release or
>    later, or from the LLVM trunk.
>       $ llvm-profgen --kernel --binary=<vmlinux> --perfdata=<perf_file> \
>         -o <profile_file>
>    or
>       $ create_llvm_prof --binary=<vmlinux> --profile=<perf_file> \
>         --format=extbinary --out=<profile_file>
> 
>    Note that multiple AutoFDO profile files can be merged into one via:
>       $ llvm-profdata merge -o <profile_file>  <profile_1> ... <profile_n>
> 
> 6) Rebuild the kernel using the AutoFDO profile file with the same config
>    as step 1, (Note CONFIG_AUTOFDO_CLANG needs to be enabled):
>       $ make LLVM=1 CLANG_AUTOFDO_PROFILE=<profile_file>
> 
> Co-developed-by: Han Shen <shenhan@google.com>
> Signed-off-by: Han Shen <shenhan@google.com>

This looks good. Fairly well isolated.

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

