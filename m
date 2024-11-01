Return-Path: <linux-arch+bounces-8762-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DFB9B9705
	for <lists+linux-arch@lfdr.de>; Fri,  1 Nov 2024 19:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CA9B1F21FB4
	for <lists+linux-arch@lfdr.de>; Fri,  1 Nov 2024 18:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D61A1CDA3C;
	Fri,  1 Nov 2024 18:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMj0K0Td"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAED51C9DFE;
	Fri,  1 Nov 2024 18:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730484131; cv=none; b=kGZKBUrJFHftr5Z4u0JpOuDrZIq6+1ipvq5fgmV9J9iHwIlX+iGiKFpryh2QZ20mBDBxzg14H0N5GT4Pbh9Pd2xatehvf+2Q51Q0LKKYBXWJRkkwigiIt+wIYW6CydCTRTnz9b496iFaAOiJIH8vd3v+1vCZD1bfJqEnf3yPdo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730484131; c=relaxed/simple;
	bh=yf+VbjccGDPjouoiu4RTs2jbGv/eZpG+kY8QMxVP930=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=go5kz2BXPgMj9vU1RHOehcheALm/Xjx1WVUhheTck4E4lJlog28TX3kiWRdA/mbNAZlJevkqFXckvy9DFTTvg4fJ1+KDJk+wk2hLPM1kYcNQbegJqY7W988tw2h5wkxWUKoRYAAFOnEKJyolW5O8SNGeRLeJUWIa4bxdVLhDxmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMj0K0Td; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AEC9C4CECF;
	Fri,  1 Nov 2024 18:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730484130;
	bh=yf+VbjccGDPjouoiu4RTs2jbGv/eZpG+kY8QMxVP930=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DMj0K0TdyGo4awmjWyX9rvFoQpJiSEV9RezEzy7DcnFKiI9FwLqmnwSUgv9SN1qDP
	 /XsvDGvVwy2LAzXdD2bnBWh7OBqYw2uhH1Lxc5jCDo+wOib5W3lUOc3BDQvZEvOUWE
	 4RsgJ3mJ1SKgdRJiE9RYBWSnC7UeJUyIiKxww4+ZukU45d+v1VrEjY2ZacNlPmMieG
	 8CCLPodSBt9yzdW+L/BiXv8qvkfidCGdqwX2xa8CMII76cGjEKhB96Ym5rfqhNC7B5
	 1hdcGqnIM5P7RjR4vOMpyVZ87aFPRxQQx7rSk9m3smSalHkBQyG9+R3pNdANqvePhQ
	 wxg3FboZwNVCg==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2fb470a8b27so29507831fa.1;
        Fri, 01 Nov 2024 11:02:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUKnaR49F5e/4uAlffTxX1QnHDcjsmJBqFt85X/SdFqODJkbaoaLOsKmfP3lOEJJY+6kv+aMp+wW+nyzrtW@vger.kernel.org, AJvYcCUTv6AlMIUmUVbwcvVDnYgLKl5Z55GNudnsy9bEJudQS6hrCAqln9/+up/LH9mYP5Y13Ug6xdn4dztk@vger.kernel.org, AJvYcCUg5IPVXcM0kMF1d/CeYzEptr2YX/Jzc0DWVIeoR04j3BskntNioLAKJFVP23fdveNGQrD7dwxoiYYy1eBk@vger.kernel.org, AJvYcCUxkJLXR+NNBwP2jHoyqv+wTUWK8xcjpx0IF1drJnnrORd5+/Ll3eTe+V22Dm/nJLVC3RjFFIxRUFNr@vger.kernel.org, AJvYcCXdMolJoOjjW7u8JfCpl0yVmzVm8d6t00jj0vlAye8fq030Y0nZOEhB1SwO3kM1rnaZOGQriMjEBbeX@vger.kernel.org
X-Gm-Message-State: AOJu0YxsxJ7KJsVgwcg3GHFLjIMLS7gyhf6fJYk5zJ5Ui+2pxdVRkzfJ
	2RN5/IlDTvn4n4e8EHPnWZURu74xHL/Wo4TPDZtjYOxK5Nee29pqvtILeaFq1G5ma20zPEv50eR
	zmwQJ7HdqLNtTCLNfmIvOadcA/8E=
X-Google-Smtp-Source: AGHT+IGXpzOp+TOI/Z+oB8P3DJaQk4b55pWJ1exOoCI7V9N4vLzVvJvZUnzzo+0mc6rOxssSfsUznlZix7baiPYy58Y=
X-Received: by 2002:a2e:bd05:0:b0:2fa:ce87:b7da with SMTP id
 38308e7fff4ca-2fdef2a7c0bmr21784721fa.18.1730484128447; Fri, 01 Nov 2024
 11:02:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023224409.201771-1-xur@google.com> <20241023224409.201771-2-xur@google.com>
In-Reply-To: <20241023224409.201771-2-xur@google.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sat, 2 Nov 2024 03:01:31 +0900
X-Gmail-Original-Message-ID: <CAK7LNARiEhNBPikEv--YpdKTPt5B5tFF_J0T8+xbi1CS6WJBFQ@mail.gmail.com>
Message-ID: <CAK7LNARiEhNBPikEv--YpdKTPt5B5tFF_J0T8+xbi1CS6WJBFQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/7] Add AutoFDO support for Clang build
To: Rong Xu <xur@google.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Bill Wendling <morbo@google.com>, Borislav Petkov <bp@alien8.de>, 
	Breno Leitao <leitao@debian.org>, Brian Gerst <brgerst@gmail.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, David Li <davidxl@google.com>, 
	Han Shen <shenhan@google.com>, Heiko Carstens <hca@linux.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Juergen Gross <jgross@suse.com>, 
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>, 
	"Mike Rapoport (IBM)" <rppt@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Nicolas Schier <nicolas@fjasle.eu>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Wei Yang <richard.weiyang@gmail.com>, workflows@vger.kernel.org, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Maksim Panchenko <max4bolt@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Yabin Cui <yabinc@google.com>, 
	Krzysztof Pszeniczny <kpszeniczny@google.com>, Sriraman Tallam <tmsriram@google.com>, 
	Stephane Eranian <eranian@google.com>, x86@kernel.org, linux-arch@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 7:44=E2=80=AFAM Rong Xu <xur@google.com> wrote:
>
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
>        $ make menuconfig LLVM=3D1
>     Turn on AutoFDO build config:
>       CONFIG_AUTOFDO_CLANG=3Dy
>     With a configuration that has LLVM enabled, use the following
>     command:
>        scripts/config -e AUTOFDO_CLANG
>     After getting the config, build with
>       $ make LLVM=3D1
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
>       $ llvm-profgen --kernel --binary=3D<vmlinux> --perfdata=3D<perf_fil=
e> \
>         -o <profile_file>
>    or
>       $ create_llvm_prof --binary=3D<vmlinux> --profile=3D<perf_file> \
>         --format=3Dextbinary --out=3D<profile_file>
>
>    Note that multiple AutoFDO profile files can be merged into one via:
>       $ llvm-profdata merge -o <profile_file>  <profile_1> ... <profile_n=
>
>
> 6) Rebuild the kernel using the AutoFDO profile file with the same config
>    as step 1, (Note CONFIG_AUTOFDO_CLANG needs to be enabled):
>       $ make LLVM=3D1 CLANG_AUTOFDO_PROFILE=3D<profile_file>
>
> Co-developed-by: Han Shen <shenhan@google.com>
> Signed-off-by: Han Shen <shenhan@google.com>
> Signed-off-by: Rong Xu <xur@google.com>
> Suggested-by: Sriraman Tallam <tmsriram@google.com>
> Suggested-by: Krzysztof Pszeniczny <kpszeniczny@google.com>
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Suggested-by: Stephane Eranian <eranian@google.com>
> Tested-by: Yonghong Song <yonghong.song@linux.dev>




> +Workflow
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Here is an example workflow for AutoFDO kernel:
> +
> +1)  Build the kernel on the host machine with LLVM enabled,
> +    for example, ::
> +
> +      $ make menuconfig LLVM=3D1
> +
> +    Turn on AutoFDO build config::
> +
> +      CONFIG_AUTOFDO_CLANG=3Dy
> +
> +    With a configuration that with LLVM enabled, use the following comma=
nd::
> +
> +      $ scripts/config -e AUTOFDO_CLANG
> +
> +    After getting the config, build with ::
> +
> +      $ make LLVM=3D1
> +
> +2) Install the kernel on the test machine.
> +
> +3) Run the load tests. The '-c' option in perf specifies the sample
> +   event period. We suggest using a suitable prime number, like 500009,
> +   for this purpose.
> +
> +   - For Intel platforms::
> +
> +      $ perf record -e BR_INST_RETIRED.NEAR_TAKEN:k -a -N -b -c <count> =
-o <perf_file> -- <loadtest>
> +
> +   - For AMD platforms::

I am not sure if this double-colon is needed
when the next line is not code.



> +     The supported systems are: Zen3 with BRS, or Zen4 with amd_lbr_v2. =
To check,
> +     For Zen3::
> +
> +      $ cat proc/cpuinfo | grep " brs"
> +
> +     For Zen4::
> +
> +      $ cat proc/cpuinfo | grep amd_lbr_v2
> +
> +     The following command generated the perf data file::
> +
> +      $ perf record --pfm-events RETIRED_TAKEN_BRANCH_INSTRUCTIONS:k -a =
-N -b -c <count> -o <perf_file> -- <loadtest>
> +
> +4) (Optional) Download the raw perf file to the host machine.
> +
> +5) To generate an AutoFDO profile, two offline tools are available:
> +   create_llvm_prof and llvm_profgen. The create_llvm_prof tool is part
> +   of the AutoFDO project and can be found on GitHub
> +   (https://github.com/google/autofdo), version v0.30.1 or later.
> +   The llvm_profgen tool is included in the LLVM compiler itself. It's
> +   important to note that the version of llvm_profgen doesn't need to ma=
tch
> +   the version of Clang. It needs to be the LLVM 19 release of Clang
> +   or later, or just from the LLVM trunk. ::
> +
> +      $ llvm-profgen --kernel --binary=3D<vmlinux> --perfdata=3D<perf_fi=
le> -o <profile_file>
> +
> +   or ::
> +
> +      $ create_llvm_prof --binary=3D<vmlinux> --profile=3D<perf_file> --=
format=3Dextbinary --out=3D<profile_file>
> +
> +   Note that multiple AutoFDO profile files can be merged into one via::
> +
> +      $ llvm-profdata merge -o <profile_file> <profile_1> <profile_2> ..=
. <profile_n>
> +
> +6) Rebuild the kernel using the AutoFDO profile file with the same confi=
g as step 1,
> +   (Note CONFIG_AUTOFDO_CLANG needs to be enabled)::
> +
> +      $ make LLVM=3D1 CLANG_AUTOFDO_PROFILE=3D<profile_file>
> +

Trailing blank line.

.git/rebase-apply/patch:187: new blank line at EOF.





--
Best Regards
Masahiro Yamada

