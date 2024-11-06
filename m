Return-Path: <linux-arch+bounces-8878-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 114D29BF2DC
	for <lists+linux-arch@lfdr.de>; Wed,  6 Nov 2024 17:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49525B25FF8
	for <lists+linux-arch@lfdr.de>; Wed,  6 Nov 2024 16:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1082038DF;
	Wed,  6 Nov 2024 16:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JuQqFPlp"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D301DE8BA;
	Wed,  6 Nov 2024 16:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730909360; cv=none; b=nLbNslz1fu0ijBQ2KS7GuzTWsBcpLoZ18BUl18wPAC04H4nJQJdqOCthVA6w1qhlMrtuq91bHCl9x10NCaMstkDvGusdhPmwG7E6sTbydeXhwoubydAWR5Pjf8mnPv2RvL+zgzzEkkEhRY3ErrNyelAJjHlgm3/zlPAWM6YyHAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730909360; c=relaxed/simple;
	bh=VOUAaO8tbrP/wOcy0Hm9JSPbINDxNuLU/AYW8Ip0Zd4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oKKWfdqOmTWt8Movls78gWN3d5s/5DhsgghLU08uypOt6MhtyRPcPfAxnz7QdvSy8pT7trpiVk5/rBWVLOgUN8VhTzoFICtDVDNcM1u5Rrlo6V+i3zqerOyuQU6v+cGh+ZIAXT2TJAQB6qpy0FRkJWii2gn9P4AT7d0J5rorkTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JuQqFPlp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B361C4CEDA;
	Wed,  6 Nov 2024 16:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730909358;
	bh=VOUAaO8tbrP/wOcy0Hm9JSPbINDxNuLU/AYW8Ip0Zd4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JuQqFPlpGiZAw7TILRMopCknbSMhoSbKx2jz2KR/Z4136chHTIJzi6bsn3gL0+hTS
	 e2biPgPhKCa3qDTsZK3oGU9ag6yFsmSdHsyCuRlh6zqidBZaOF+DTVoqAZfMX++Uhv
	 PSkA3uMU8U3BudOhRigGRcWHfPrAIWwmjbH+UwbaDidkQNTNe1X6FpdHr87lQu6nJF
	 6F4qszR0GXujuSL0Hx1jvOjHS+69UHa30u7ijx0wDL2pGIVmwGiwsXm+6V/I/57AnB
	 jSruAnH3iySsmiY0+fL2x/BG6YQI65Ewzv8CjSgnBAtbJSqhdPyawhvOWKnlvy+KFf
	 YpFJa2r1JhqOA==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539e5c15fd3so6742744e87.3;
        Wed, 06 Nov 2024 08:09:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUzjS5C2DmQinBTuGovT/ELyDAhpKA8Nq/xAsTgy3JJqaJ3JMbBhHLkLeGA6n5qXlgU/nmZsyJtu2+YQUT3@vger.kernel.org, AJvYcCVSeVafwucFK+nDjqW5Xe7r4xdrg1q4FjvyoFhbx5E85n8QhsLK3L5IY3cJgSGi1u1fCnG+h5xOFjfbH8Vo@vger.kernel.org, AJvYcCWFFEHQbbUcML/CGWhF9usw/ZSIXZRTa+XeAKa8GfKQEfkEC3GUd3LnAj80e6j4i2NePc7GSe0IwZSG@vger.kernel.org, AJvYcCWJ40qd+jfgSryCLd0KdEerEkp7FGyR/qdHZD5ZwMQe+D5qiUIcSidXToIcJKLq0oUT5U6U9OfFHxxg@vger.kernel.org, AJvYcCWLMcuZndJtEa7Gicvc83B+BtimMw4tWsWc3e5oUytgnDaM30V650VvrhEJkmjiv9nwe6aIMbrsn80/@vger.kernel.org, AJvYcCXWi4AYx9ocvpN1dIfBN2PcmtkruccbLd84+RYWsdwFnSpwCPBQ7xAjcPd8e3/XXC++IbDkeMKd/AN2Lg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzX6Q4XJmxYzh7/4uNSxHziSpjXx23K/H1UmrlMXi89IMOpLLhj
	JSy6/V15L+ujJKUTEpXUWXpGt3zcBnwRxe9LsE8elnetsApxsUbK1qK+gU2tYLlzaLBLMEDKCkn
	G0/nwAy1L0e69+o02h/Vw3Fp+7i8=
X-Google-Smtp-Source: AGHT+IFe3LtQOU5rlt2uGICpXWpl9dXGIsyeiu98XXxTi7W/MgXwXeHBmA5AmnRcRDJ/VkMxQJyWrHuX629kG1Abv5I=
X-Received: by 2002:a05:6512:398d:b0:533:711:35be with SMTP id
 2adb3069b0e04-53b348e154fmr20852753e87.26.1730909356944; Wed, 06 Nov 2024
 08:09:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241102175115.1769468-1-xur@google.com>
In-Reply-To: <20241102175115.1769468-1-xur@google.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Thu, 7 Nov 2024 01:08:40 +0900
X-Gmail-Original-Message-ID: <CAK7LNASdBPtq4vaK0XZQvxicOY15qJFsnqkO2_us4AU4ppHw6A@mail.gmail.com>
Message-ID: <CAK7LNASdBPtq4vaK0XZQvxicOY15qJFsnqkO2_us4AU4ppHw6A@mail.gmail.com>
Subject: Re: [PATCH v7 0/7] Add AutoFDO and Propeller support for Clang build
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
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Yabin Cui <yabinc@google.com>, 
	Krzysztof Pszeniczny <kpszeniczny@google.com>, Sriraman Tallam <tmsriram@google.com>, 
	Stephane Eranian <eranian@google.com>, x86@kernel.org, linux-arch@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 3, 2024 at 2:51=E2=80=AFAM Rong Xu <xur@google.com> wrote:
>
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
> the benchmark=E2=80=99s performance over and above AutoFDO.
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
> uses the hardware=E2=80=99s Performance Monitoring Unit (PMU) to collect
> profiling data. While AutoFDO typically yields smaller performance
> gains than iFDO, it presents unique benefits for optimizing kernels.
>
> AutoFDO eliminates the need for instrumented kernels, allowing a single
> optimized kernel to serve both execution and profile collection. It also
> minimizes slowdown during profile collection, potentially yielding
> higher-fidelity profiling, especially for time-sensitive code, compared
> to iFDO. Additionally, AutoFDO profiles can be obtained from production
> environments via the hardware=E2=80=99s PMU whereas iFDO profiles require
> carefully curated load tests that are representative of real-world
> traffic.
>
> AutoFDO facilitates profile collection across diverse targets.
> Preliminary studies indicate significant variation in kernel hot spots
> within Google=E2=80=99s infrastructure, suggesting potential performance =
gains
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
> [P 3] Adjust symbol ordering in text output sections
>
> [P 4] Add markers for text_unlikely and text_hot sections
>
> [P 5] Enable =E2=80=93ffunction-sections for the AutoFDO build
>
> [P 6] Enable Machine Function Split (MFS) optimization for AutoFDO
>
> [P 7] Add Propeller configuration to the kernel build
>
> Patch 1 provides basic AutoFDO build support. Patches 2 to 6 further
> enhance the performance of AutoFDO builds and are functionally dependent
> on Patch 1. Patch 7 enables support for Propeller and is dependent on
> patch 2 to patch 4.
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
>    needs to be configured with =E2=80=9CCONFIG_PERF_EVENTS_AMD_BRS=3Dy", =
To
>    check, use
>    $ cat /proc/cpuinfo | grep =E2=80=9C brs=E2=80=9D
>    For the AMD Zen4, AMD LBRV2 is supported, but we suspect a bug with
>    AMD LBRv2 implementation in Genoa which blocks the usage.
>
> For ARM, we plan to send patches for SPE-based Propeller when
> AutoFDO for Arm is ready.
>
> Experiments and Results
>
> Experiments were conducted to compare the performance of AutoFDO-optimize=
d
> kernel images (version 6.9.x) against default builds.. The evaluation
> encompassed both open source microbenchmarks and real-world production
> services from Google and Meta. The selected microbenchmarks included Nepe=
r,
> a network subsystem benchmark, and UnixBench which is a comprehensive sui=
te
> for assessing various kernel operations.
>
> For Neper, AutoFDO optimization resulted in a 6.1% increase in throughput
> and a 10.6% reduction in latency. UnixBench saw a 2.2% improvement in its
> index score under low system load and a 2.6% improvement under high syste=
m
> load.
>
> For further details on the improvements observed in Google and Meta's
> production services, please refer to the LLVM discourse post:
> https://discourse.llvm.org/t/optimizing-the-linux-kernel-with-autofdo-inc=
luding-thinlto-and-propeller/79108
>
> Thanks,
>
> Rong Xu and Han Shen


I applied this series to linux-kbuild.

As I mentioned before, I do not like #ifdef because
it hides (not fixes) issues only for default cases.


--=20
Best Regards
Masahiro Yamada

