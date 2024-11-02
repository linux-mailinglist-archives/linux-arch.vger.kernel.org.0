Return-Path: <linux-arch+bounces-8791-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B369BA227
	for <lists+linux-arch@lfdr.de>; Sat,  2 Nov 2024 20:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E521D1C20A4A
	for <lists+linux-arch@lfdr.de>; Sat,  2 Nov 2024 19:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985041A265B;
	Sat,  2 Nov 2024 19:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cachyos.org header.i=@cachyos.org header.b="cUVolbLf"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.ptr1337.dev (mail.ptr1337.dev [202.61.224.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF09715E5B5;
	Sat,  2 Nov 2024 19:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.224.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730576826; cv=none; b=ni0rgK7cMNEbInucPrXUJsjZpbHWqRK1V8CXnuBZ7pe4co0rCmjp5W+pmPG+s0B2rCuqaRR0cQnYeXDuoxFzh3OP5SYLV/WW8x+SLRgakDVTXXA1bWaWd+N9lLdl3jN1RRKvhofRCWcVGz+zgOlgOjZTNn27QoAUH3bi2uZOJwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730576826; c=relaxed/simple;
	bh=MQI3BNtZBxdg6mXqk8yc8wb4V0fZXGUlCkoeCxmMzyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lMSpnEc54rNMF5KWUeRPefvYOJcsyNvKYpEWcdBMxgd+g6t2sd4ruk/ZyQnNtETO1wk/bkDpQsOC6u0yQ3J9ebv55DC5THo/lt4nwgFj7ClnBUNy9ECvF4g9NmAYHDhJg6S0WAX3LvuNbbpmCsDsjBG1g6SEy8/Ll0NO5qTsLL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cachyos.org; spf=pass smtp.mailfrom=cachyos.org; dkim=pass (2048-bit key) header.d=cachyos.org header.i=@cachyos.org header.b=cUVolbLf; arc=none smtp.client-ip=202.61.224.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cachyos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cachyos.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 881682805B9;
	Sat,  2 Nov 2024 20:46:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cachyos.org; s=dkim;
	t=1730576820; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=BGTnDaqtKnLhX/3sR+UXxn46A/x2F6Nip/nY5s5e61A=;
	b=cUVolbLfq/bcxZpLz4bc++OQ6L6azX7WwNkEW08OV5Nahc38rQocTTwPrD0gttmiLds/6m
	0HoYHc+KmEm0pAAxJcWa0jfnBkNi3atxtA2lcSXL7Z9/pMUgesS8Jbzj0FCvczyHgO1Ljl
	6MmEabP+QjC4QUptGltAIIqMHfZML+CpIFOC0NRwJ9ch0IKoVXsSZjCbh/9qesnupWMKkB
	MFC98K+CWLGLyJDzlwQofObmdQNchwwsJjCN5T+2CLw+/ORgWBZvwp6BjqtKwmk0x+VY+A
	2dHCJPRFu41XjMujZIXmK6JKycr73XH5jF8JHmJm1m4RTFgSRUP1/qUMFWTVxw==
Message-ID: <09349180-027a-4b29-a40c-9dc3425e592c@cachyos.org>
Date: Sat, 2 Nov 2024 20:46:50 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/7] Add AutoFDO support for Clang build
To: Rong Xu <xur@google.com>, Alice Ryhl <aliceryhl@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
 Bill Wendling <morbo@google.com>, Borislav Petkov <bp@alien8.de>,
 Breno Leitao <leitao@debian.org>, Brian Gerst <brgerst@gmail.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, David Li <davidxl@google.com>,
 Han Shen <shenhan@google.com>, Heiko Carstens <hca@linux.ibm.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
 Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Juergen Gross <jgross@suse.com>,
 Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>,
 Masahiro Yamada <masahiroy@kernel.org>, "Mike Rapoport (IBM)"
 <rppt@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Nicolas Schier <nicolas@fjasle.eu>, "Paul E. McKenney" <paulmck@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Sami Tolvanen <samitolvanen@google.com>, Thomas Gleixner
 <tglx@linutronix.de>, Wei Yang <richard.weiyang@gmail.com>,
 workflows@vger.kernel.org, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Maksim Panchenko <max4bolt@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>,
 Yonghong Song <yonghong.song@linux.dev>, Yabin Cui <yabinc@google.com>,
 Krzysztof Pszeniczny <kpszeniczny@google.com>,
 Sriraman Tallam <tmsriram@google.com>, Stephane Eranian <eranian@google.com>
Cc: x86@kernel.org, linux-arch@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20241102175115.1769468-1-xur@google.com>
 <20241102175115.1769468-2-xur@google.com>
Content-Language: en-US
From: Peter Jung <ptr1337@cachyos.org>
Organization: CachyOS
In-Reply-To: <20241102175115.1769468-2-xur@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 02.11.24 18:51, Rong Xu wrote:
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
>   and BRBE on ARM 1 is part of planned future work.
> 
> Here is an example workflow for AutoFDO kernel:
> 
> 1) Build the kernel on the host machine with LLVM enabled, for example,
>         $ make menuconfig LLVM=1
>      Turn on AutoFDO build config:
>        CONFIG_AUTOFDO_CLANG=y
>      With a configuration that has LLVM enabled, use the following
>      command:
>         scripts/config -e AUTOFDO_CLANG
>      After getting the config, build with
>        $ make LLVM=1
> 
> 2) Install the kernel on the test machine.
> 
> 3) Run the load tests. The '-c' option in perf specifies the sample
>     event period. We suggest     using a suitable prime number,
>     like 500009, for this purpose.
>     For Intel platforms:
>        $ perf record -e BR_INST_RETIRED.NEAR_TAKEN:k -a -N -b -c <count> \
>          -o <perf_file> -- <loadtest>
>     For AMD platforms:
>        The supported system are: Zen3 with BRS, or Zen4 with amd_lbr_v2
>       For Zen3:
>        $ cat proc/cpuinfo | grep " brs"
>        For Zen4:
>        $ cat proc/cpuinfo | grep amd_lbr_v2
>        $ perf record --pfm-events RETIRED_TAKEN_BRANCH_INSTRUCTIONS:k -a \
>          -N -b -c <count> -o <perf_file> -- <loadtest>
> 
> 4) (Optional) Download the raw perf file to the host machine.
> 
> 5) To generate an AutoFDO profile, two offline tools are available:
>     create_llvm_prof and llvm_profgen. The create_llvm_prof tool is part
>     of the AutoFDO project and can be found on GitHub
>     (https://github.com/google/autofdo), version v0.30.1 or later. The
>     llvm_profgen tool is included in the LLVM compiler itself. It's
>     important to note that the version of llvm_profgen doesn't need to
>     match the version of Clang. It needs to be the LLVM 19 release or
>     later, or from the LLVM trunk.
>        $ llvm-profgen --kernel --binary=<vmlinux> --perfdata=<perf_file> \
>          -o <profile_file>
>     or
>        $ create_llvm_prof --binary=<vmlinux> --profile=<perf_file> \
>          --format=extbinary --out=<profile_file>
> 
>     Note that multiple AutoFDO profile files can be merged into one via:
>        $ llvm-profdata merge -o <profile_file>  <profile_1> ... <profile_n>
> 
> 6) Rebuild the kernel using the AutoFDO profile file with the same config
>     as step 1, (Note CONFIG_AUTOFDO_CLANG needs to be enabled):
>        $ make LLVM=1 CLANG_AUTOFDO_PROFILE=<profile_file>
> 
> Co-developed-by: Han Shen<shenhan@google.com>
> Signed-off-by: Han Shen<shenhan@google.com>
> Signed-off-by: Rong Xu<xur@google.com>
> Suggested-by: Sriraman Tallam<tmsriram@google.com>
> Suggested-by: Krzysztof Pszeniczny<kpszeniczny@google.com>
> Suggested-by: Nick Desaulniers<ndesaulniers@google.com>
> Suggested-by: Stephane Eranian<eranian@google.com>
> Tested-by: Yonghong Song<yonghong.song@linux.dev>
> Tested-by: Yabin Cui<yabinc@google.com>
> Tested-by: Nathan Chancellor<nathan@kernel.org>
> Reviewed-by: Kees Cook<kees@kernel.org>

Tested-by: Peter Jung <ptr1337@cachyos.org>


