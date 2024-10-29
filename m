Return-Path: <linux-arch+bounces-8679-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9E59B3EF2
	for <lists+linux-arch@lfdr.de>; Tue, 29 Oct 2024 01:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E9CB1C223F2
	for <lists+linux-arch@lfdr.de>; Tue, 29 Oct 2024 00:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D8D4C76;
	Tue, 29 Oct 2024 00:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iGBVoLgZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C087628FF;
	Tue, 29 Oct 2024 00:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730160902; cv=none; b=m4L3kb2dscsO0ydNt0t331jkc4cY6iiR/ZRNF9rIE702C7NVYer3nBHJAdRsJ4yfSHFrnhQrEo8tMj7DZUhaMQuWhDiMRime1erErQPDehIpEF/lBy5BLMIlkipsAKgRxuNS+Ux98/5qo5FXdGuGPUivjoLXXg306QZwvOKyX/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730160902; c=relaxed/simple;
	bh=pWqN4qoaerNcZqwVzZ3/W+y/IZE3cckdHP0roXePaZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nzPpayKFmUzGNP0o136Mjmxqwa50BZQZ5zQu3s0Xyoaq1HHHrWgjnMAyjrPzW3IRlFkSACrlNb3yZN/FL/Cx8N6myO7xnjT+yOaEjwoMxevwazYdWH3UtkLZvkdWF6RnSC8/zotBEFgVgN4B9Wt4O1d3/OBtPHxSJNBxAI5bluI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iGBVoLgZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E578C4CEC3;
	Tue, 29 Oct 2024 00:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730160902;
	bh=pWqN4qoaerNcZqwVzZ3/W+y/IZE3cckdHP0roXePaZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iGBVoLgZnsC1rYrU4j34a6TD7XzDT9Um67irZz0EkW5Xt9aWtQ8kgPMp9AAOmk/m3
	 vn3Rtlir8WVMAVL1ovPZiZFeqy+IFzqNDtI1kNMX/NBUcFQ/9I2G2H6JV1bt594yab
	 U84T8WH1ElozKE0vhtDinN2YvMN1A0JhSPqiQolkRLPuVSqCFZF2vvIcKfWgX768KD
	 88RB54H8oUGIIR89jIjA8ReH+tSY3SFOjEVqRuIn5xtMO0ptUd16os333Oe71J1OBT
	 eftp6R4P52OdKRlXH2dlWQCNibtdzOaUA7dEOmuQEzrlZ1Kb+OKTDdsf4zTrivNk3y
	 KpM7tLtIzqhEg==
Date: Mon, 28 Oct 2024 17:14:59 -0700
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
Subject: Re: [PATCH v6 7/7] Add Propeller configuration for kernel build
Message-ID: <202410281714.20A7BE8@keescook>
References: <20241026051410.2819338-1-xur@google.com>
 <20241026051410.2819338-8-xur@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241026051410.2819338-8-xur@google.com>

On Fri, Oct 25, 2024 at 10:14:09PM -0700, Rong Xu wrote:
> Add the build support for using Clang's Propeller optimizer. Like
> AutoFDO, Propeller uses hardware sampling to gather information
> about the frequency of execution of different code paths within a
> binary. This information is then used to guide the compiler's
> optimization decisions, resulting in a more efficient binary.
> 
> The support requires a Clang compiler LLVM 19 or later, and the
> create_llvm_prof tool
> (https://github.com/google/autofdo/releases/tag/v0.30.1). This
> commit is limited to x86 platforms that support PMU features
> like LBR on Intel machines and AMD Zen3 BRS.
> 
> Here is an example workflow for building an AutoFDO+Propeller
> optimized kernel:
> 
> 1) Build the kernel on the host machine, with AutoFDO and Propeller
>    build config
>       CONFIG_AUTOFDO_CLANG=y
>       CONFIG_PROPELLER_CLANG=y
>    then
>       $ make LLVM=1 CLANG_AUTOFDO_PROFILE=<autofdo_profile>
> 
> “<autofdo_profile>” is the profile collected when doing a non-Propeller
> AutoFDO build. This step builds a kernel that has the same optimization
> level as AutoFDO, plus a metadata section that records basic block
> information. This kernel image runs as fast as an AutoFDO optimized
> kernel.
> 
> 2) Install the kernel on test/production machines.
> 
> 3) Run the load tests. The '-c' option in perf specifies the sample
>    event period. We suggest using a suitable prime number,
>    like 500009, for this purpose.
>    For Intel platforms:
>       $ perf record -e BR_INST_RETIRED.NEAR_TAKEN:k -a -N -b -c <count> \
>         -o <perf_file> -- <loadtest>
>    For AMD platforms:
>       The supported system are: Zen3 with BRS, or Zen4 with amd_lbr_v2
>       # To see if Zen3 support LBR:
>       $ cat proc/cpuinfo | grep " brs"
>       # To see if Zen4 support LBR:
>       $ cat proc/cpuinfo | grep amd_lbr_v2
>       # If the result is yes, then collect the profile using:
>       $ perf record --pfm-events RETIRED_TAKEN_BRANCH_INSTRUCTIONS:k -a \
>         -N -b -c <count> -o <perf_file> -- <loadtest>
> 
> 4) (Optional) Download the raw perf file to the host machine.
> 
> 5) Generate Propeller profile:
>    $ create_llvm_prof --binary=<vmlinux> --profile=<perf_file> \
>      --format=propeller --propeller_output_module_name \
>      --out=<propeller_profile_prefix>_cc_profile.txt \
>      --propeller_symorder=<propeller_profile_prefix>_ld_profile.txt
> 
>    “create_llvm_prof” is the profile conversion tool, and a prebuilt
>    binary for linux can be found on
>    https://github.com/google/autofdo/releases/tag/v0.30.1 (can also build
>    from source).
> 
>    "<propeller_profile_prefix>" can be something like
>    "/home/user/dir/any_string".
> 
>    This command generates a pair of Propeller profiles:
>    "<propeller_profile_prefix>_cc_profile.txt" and
>    "<propeller_profile_prefix>_ld_profile.txt".
> 
> 6) Rebuild the kernel using the AutoFDO and Propeller profile files.
>       CONFIG_AUTOFDO_CLANG=y
>       CONFIG_PROPELLER_CLANG=y
>    and
>       $ make LLVM=1 CLANG_AUTOFDO_PROFILE=<autofdo_profile> \
>         CLANG_PROPELLER_PROFILE_PREFIX=<propeller_profile_prefix>
> 
> Co-developed-by: Han Shen <shenhan@google.com>
> Signed-off-by: Han Shen <shenhan@google.com>

Looks good. Similarly isolated like FDO. :)

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

