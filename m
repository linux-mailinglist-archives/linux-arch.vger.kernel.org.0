Return-Path: <linux-arch+bounces-8299-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F98E9A54D2
	for <lists+linux-arch@lfdr.de>; Sun, 20 Oct 2024 17:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8660A1F21E6A
	for <lists+linux-arch@lfdr.de>; Sun, 20 Oct 2024 15:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115E3194085;
	Sun, 20 Oct 2024 15:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N6++6gGR"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE19D79F6;
	Sun, 20 Oct 2024 15:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729439180; cv=none; b=trKUMTswItE6W+k7JMGOxJoIKaPEwY6tKgdjsXIvTc/T6u8kh4BvSrC3r6lojRus7KtYlBntgX+Hf/OkM9rjFnp7pgk8jhf2ssYodRQSgboFfu55ZO/pEp20GpeYCkCJOy+7NUyQ8UXgyQFIJL1KTKtJy3cI0XBs1ShLsa5iJMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729439180; c=relaxed/simple;
	bh=dybJvTIwydrLBvn1LcH/lZMry79zGiff5879XyIL0zg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KBYHnYFZQ/Bl2Ap7H+NuHFvLNDwccswBBdmoTRdjKxJGopIpM7CYSr8sPT/l+UjE4Dry5zkJR68G/w05aVpTutvsOLotaWhHlMqPha45RtmfxM4yY6oEuXkXsNF+WZXze2zZ3M+Vyq7v+XVTukghjwILFLy5qUO7AjbNPl4kV8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N6++6gGR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FA70C4CEED;
	Sun, 20 Oct 2024 15:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729439179;
	bh=dybJvTIwydrLBvn1LcH/lZMry79zGiff5879XyIL0zg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=N6++6gGRhYbOmKLkI0kMy8uxf1eJcK4QpzjTYHkL31hos9eglTtkadQEkZ/MKD9dr
	 ODlp6brmU1BX7rahC8gGEnmNg+jtDeRSCKCdP8dPebFk5KdKlGZwNjW1ZYaJeKawvv
	 dF3os4hhX8qDXh7kWjUaSVAE1tb9Frd/A3tjy4/H/eeHmhimSXVYCkMjgpLTkoooOz
	 ZA3oYHjAEQeeUNiW2Ebyo0Sd0U0V3dALSCYWKi3K4KRTt9S0MWh+NlfZP+S9IE2k+D
	 +RSFLyDtX8+SHqh6ElD5KtbS/b3eSO0EFV7XavmYBCAQrUyfvItQn4Cca1G4JqbmFG
	 qdwFQn4fVrI7g==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539e5c15fd3so3196283e87.3;
        Sun, 20 Oct 2024 08:46:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUGqjOS0ZBono+H6G90YZ8lfFT0rfaOD4hKJS1dInh2Y3K/cfuMQ4pbktHkRaCQLWwrVvYC/4s7BMAL@vger.kernel.org, AJvYcCUfNeWToORR91pyjPvKlTBjxXuLZO9wC9YZLD4sbe3WQRfNJx5guZ2mkPnBR9j3JvX29W1P/rvUs77A@vger.kernel.org, AJvYcCWRIhObuqR5VCoDaAzXWXFbUbU+XI/1sGYqOy3w8NCxo72mxdYJNMtL9CuShM92HXBxrPwsgHcvlNxg@vger.kernel.org, AJvYcCXeXflE1soAtFmC4VSENPnCscf4Zfqdkh1JY9rkunotMvAKPtfPLxw76jQDROFzNYJ8omDoobUJ4moGwIgd@vger.kernel.org, AJvYcCXrsEES+YuvMDJnJqr+YdHB5suz9UvgBKHGL0X617M8QaJkJdIZ2L3kdzZe0/8kgqVyj2TMmEMwCFbLE8hc@vger.kernel.org
X-Gm-Message-State: AOJu0Yws/O1VzMEbCyzlFG4/VB1RO3z4+mBlGOnjtdKFGvGi+qpBTCmT
	4Wv+LFDMiLpH+DPK6Av+W8rbvczASBnFUkRLFFGbh/EL3i2IVMgf5ISPSvh5fFfEyREhRRqFXWs
	NZZm8WW0y7b6tzURCKnF529YZhdM=
X-Google-Smtp-Source: AGHT+IHVNEBd41mpXJ65nn09YsbsLIWj9/J956BaHSIAk6ZWD5G3zkZ2X2eav8p4dtbyv45AK6HMs6lPUuxyTCIJaXo=
X-Received: by 2002:a05:6512:104a:b0:539:e0fa:6ee8 with SMTP id
 2adb3069b0e04-53a1520b6a6mr4932543e87.6.1729439177507; Sun, 20 Oct 2024
 08:46:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014213342.1480681-1-xur@google.com> <20241020033116.GA3653827@thelio-3990X>
In-Reply-To: <20241020033116.GA3653827@thelio-3990X>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Mon, 21 Oct 2024 00:45:40 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQD7_iLo9SnQW0_KYx2vBoNSpi98yrgmn_Z0Yh8500tsg@mail.gmail.com>
Message-ID: <CAK7LNAQD7_iLo9SnQW0_KYx2vBoNSpi98yrgmn_Z0Yh8500tsg@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] Add AutoFDO and Propeller support for Clang build
To: Nathan Chancellor <nathan@kernel.org>
Cc: Rong Xu <xur@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Alice Ryhl <aliceryhl@google.com>, Arnd Bergmann <arnd@arndb.de>, Bill Wendling <morbo@google.com>, 
	Borislav Petkov <bp@alien8.de>, Breno Leitao <leitao@debian.org>, Brian Gerst <brgerst@gmail.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, David Li <davidxl@google.com>, 
	Han Shen <shenhan@google.com>, Heiko Carstens <hca@linux.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Juergen Gross <jgross@suse.com>, 
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>, 
	"Mike Rapoport (IBM)" <rppt@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Nicolas Schier <nicolas@fjasle.eu>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Wei Yang <richard.weiyang@gmail.com>, 
	workflows@vger.kernel.org, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	Maksim Panchenko <max4bolt@gmail.com>, x86@kernel.org, linux-arch@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 20, 2024 at 12:31=E2=80=AFPM Nathan Chancellor <nathan@kernel.o=
rg> wrote:
>
> Hi Masahiro and Andrew,
>
> Top posting only for visibility. Would it make more sense to have this
> land via the Kbuild tree or -mm? The core of the series really touches
> Kbuild and I think the x86 stuff can just land with Acks, unless the
> -tip folks feel differently. I would like Rong to have a relatively
> clear path forward to mainline once the requisite review and testing has
> accomplished, which requires a shepherd :)


I think I can pick it up if 2/6 gains Ack from an objtool maintainer.






> Cheers,
> Nathan
>
> On Mon, Oct 14, 2024 at 02:33:34PM -0700, Rong Xu wrote:
> > Hi,
> >
> > This patch series is to integrate AutoFDO and Propeller support into
> > the Linux kernel. AutoFDO is a profile-guided optimization technique
> > that leverages hardware sampling to enhance binary performance.
> > Unlike Instrumentation-based FDO (iFDO), AutoFDO offers a user-friendly
> > and straightforward application process. While iFDO generally yields
> > superior profile quality and performance, our findings reveal that
> > AutoFDO achieves remarkable effectiveness, bringing performance close
> > to iFDO for benchmark applications.
> >
> > Propeller is a profile-guided, post-link optimizer that improves
> > the performance of large-scale applications compiled with LLVM. It
> > operates by relinking the binary based on an additional round of runtim=
e
> > profiles, enabling precise optimizations that are not possible at
> > compile time.  Similar to AutoFDO, Propeller too utilizes hardware
> > sampling to collect profiles and apply post-link optimizations to impro=
ve
> > the benchmark=E2=80=99s performance over and above AutoFDO.
> >
> > Our empirical data demonstrates significant performance improvements
> > with AutoFDO and Propeller, up to 10% on microbenchmarks and up to 5%
> > on large warehouse-scale benchmarks. This makes a strong case for their
> > inclusion as supported features in the upstream kernel.
> >
> > Background
> >
> > A significant fraction of fleet processing cycles (excluding idle time)
> > from data center workloads are attributable to the kernel. Ware-house
> > scale workloads maximize performance by optimizing the production kerne=
l
> > using iFDO (a.k.a instrumented PGO, Profile Guided Optimization).
> >
> > iFDO can significantly enhance application performance but its use
> > within the kernel has raised concerns. AutoFDO is a variant of FDO that
> > uses the hardware=E2=80=99s Performance Monitoring Unit (PMU) to collec=
t
> > profiling data. While AutoFDO typically yields smaller performance
> > gains than iFDO, it presents unique benefits for optimizing kernels.
> >
> > AutoFDO eliminates the need for instrumented kernels, allowing a single
> > optimized kernel to serve both execution and profile collection. It als=
o
> > minimizes slowdown during profile collection, potentially yielding
> > higher-fidelity profiling, especially for time-sensitive code, compared
> > to iFDO. Additionally, AutoFDO profiles can be obtained from production
> > environments via the hardware=E2=80=99s PMU whereas iFDO profiles requi=
re
> > carefully curated load tests that are representative of real-world
> > traffic.
> >
> > AutoFDO facilitates profile collection across diverse targets.
> > Preliminary studies indicate significant variation in kernel hot spots
> > within Google=E2=80=99s infrastructure, suggesting potential performanc=
e gains
> > through target-specific kernel customization.
> >
> > Furthermore, other advanced compiler optimization techniques, including
> > ThinLTO and Propeller can be stacked on top of AutoFDO, similar to iFDO=
.
> > ThinLTO achieves better runtime performance through whole-program
> > analysis and cross module optimizations. The main difference between
> > traditional LTO and ThinLTO is that the latter is scalable in time and
> > memory.
> >
> > This patch series adds AutoFDO and Propeller support to the kernel. The
> > actual solution comes in six parts:
> >
> > [P 1] Add the build support for using AutoFDO in Clang
> >
> >       Add the basic support for AutoFDO build and provide the
> >       instructions for using AutoFDO.
> >
> > [P 2] Fix objtool for bogus warnings when -ffunction-sections is enable=
d
> >
> > [P 3] Change the subsection ordering when -ffunction-sections is enable=
d
> >
> > [P 4] Enable =E2=80=93ffunction-sections for the AutoFDO build
> >
> > [P 5] Enable Machine Function Split (MFS) optimization for AutoFDO
> >
> > [P 6] Add Propeller configuration to the kernel build
> >
> > Patch 1 provides basic AutoFDO build support. Patches 2 to 5 further
> > enhance the performance of AutoFDO builds and are functionally dependen=
t
> > on Patch 1. Patch 6 enables support for Propeller and is dependent on
> > patch 2 and patch 3.
> >
> > Caveats
> >
> > AutoFDO is compatible with both GCC and Clang, but the patches in this
> > series are exclusively applicable to LLVM 17 or newer for AutoFDO and
> > LLVM 19 or newer for Propeller. For profile conversion, two different
> > tools could be used, llvm_profgen or create_llvm_prof. llvm_profgen
> > needs to be the LLVM 19 or newer, or just the LLVM trunk. Alternatively=
,
> > create_llvm_prof v0.30.1 or newer can be used instead of llvm-profgen.
> >
> > Additionally, the build is only supported on x86 platforms equipped
> > with PMU capabilities, such as LBR on Intel machines. More
> > specifically:
> >  * Intel platforms: works on every platform that supports LBR;
> >    we have tested on Skylake.
> >  * AMD platforms: tested on AMD Zen3 with the BRS feature. The kernel
> >    needs to be configured with =E2=80=9CCONFIG_PERF_EVENTS_AMD_BRS=3Dy"=
, To
> >    check, use
> >    $ cat /proc/cpuinfo | grep =E2=80=9C brs=E2=80=9D
> >    For the AMD Zen4, AMD LBRV2 is supported, but we suspect a bug with
> >    AMD LBRv2 implementation in Genoa which blocks the usage.
> >
> > Experiments and Results
> >
> > Experiments were conducted to compare the performance of AutoFDO-optimi=
zed
> > kernel images (version 6.9.x) against default builds.. The evaluation
> > encompassed both open source microbenchmarks and real-world production
> > services from Google and Meta. The selected microbenchmarks included Ne=
per,
> > a network subsystem benchmark, and UnixBench which is a comprehensive s=
uite
> > for assessing various kernel operations.
> >
> > For Neper, AutoFDO optimization resulted in a 6.1% increase in throughp=
ut
> > and a 10.6% reduction in latency. Unixbench saw a 2.2% improvement in i=
ts
> > index score under low system load and a 2.6% improvement under high sys=
tem
> > load.
> >
> > For further details on the improvements observed in Google and Meta's
> > production services, please refer to the LLVM discourse post:
> > https://discourse.llvm.org/t/optimizing-the-linux-kernel-with-autofdo-i=
ncluding-thinlto-and-propeller/79108
> ...
> > Rong Xu (6):
> >   Add AutoFDO support for Clang build
> >   objtool: Fix unreachable instruction warnings for weak funcitons
> >   Change the symbols order when --ffuntion-sections is enabled
> >   AutoFDO: Enable -ffunction-sections for the AutoFDO build
> >   AutoFDO: Enable machine function split optimization for AutoFDO
> >   Add Propeller configuration for kernel build.
> >
> >  Documentation/dev-tools/autofdo.rst   | 165 ++++++++++++++++++++++++++
> >  Documentation/dev-tools/index.rst     |   2 +
> >  Documentation/dev-tools/propeller.rst | 161 +++++++++++++++++++++++++
> >  MAINTAINERS                           |  14 +++
> >  Makefile                              |   2 +
> >  arch/Kconfig                          |  42 +++++++
> >  arch/x86/Kconfig                      |   2 +
> >  arch/x86/kernel/vmlinux.lds.S         |   4 +
> >  include/asm-generic/vmlinux.lds.h     |  54 +++++++--
> >  scripts/Makefile.autofdo              |  25 ++++
> >  scripts/Makefile.lib                  |  20 ++++
> >  scripts/Makefile.propeller            |  28 +++++
> >  tools/objtool/check.c                 |   2 +
> >  tools/objtool/elf.c                   |  15 ++-
> >  14 files changed, 524 insertions(+), 12 deletions(-)
> >  create mode 100644 Documentation/dev-tools/autofdo.rst
> >  create mode 100644 Documentation/dev-tools/propeller.rst
> >  create mode 100644 scripts/Makefile.autofdo
> >  create mode 100644 scripts/Makefile.propeller
> >
> >
> > base-commit: eb952c47d154ba2aac794b99c66c3c45eb4cc4ec
> > --
> > 2.47.0.rc1.288.g06298d1525-goog
> >



--
Best Regards
Masahiro Yamada

