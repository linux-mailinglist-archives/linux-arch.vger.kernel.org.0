Return-Path: <linux-arch+bounces-8889-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A29B9C0976
	for <lists+linux-arch@lfdr.de>; Thu,  7 Nov 2024 15:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A358284F42
	for <lists+linux-arch@lfdr.de>; Thu,  7 Nov 2024 14:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEA9212F11;
	Thu,  7 Nov 2024 14:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LvMP+NNH"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91098DDBE;
	Thu,  7 Nov 2024 14:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730991479; cv=none; b=reECl4+P6mg+sOY86GwmwvgMFCdCaRdV7Z7g3FWsrHfN7RfhJgGbnbsPXQL0tT4+Zih/s2BD/TcgzTFg6Kj/ogsI3+mez2zA7+QkCh4WsaIPFo8XEfO1+DzTrhBXOORwVLHGJHu0ev4Cm2y93ZGdAPpr4DasFHUF/HuCCMQWVQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730991479; c=relaxed/simple;
	bh=M4S98JDjsFROzC5PxUC6VGIl3bST1BESEp9JZA+bpvw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DlMGavCvIAHpm3CrDtUbQb+wy0EALbyhB6FTzT30NcPwX/Qx5RO7REYEKJcTiN/Dm9i6Wt1l3zpJz4aI5T18+l2QDwnXt5jegFqyH+Am6sdfet92qM19U36RpjAB6s1ydZ71yZH2+/eXcFA/6MMZOMG+Z1FZsUjmVHoNa9l4Yj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LvMP+NNH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12DAEC4CEDF;
	Thu,  7 Nov 2024 14:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730991479;
	bh=M4S98JDjsFROzC5PxUC6VGIl3bST1BESEp9JZA+bpvw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LvMP+NNHkqr1qpYAoXqBNXM/Lofit7EsnKl2oDdqAZC7DRL+4LW3jvGbUSCh1SAVS
	 xBEdmSGze2t6WwKjz2VKJWFgq1mRpOQwhku9hz/mcWHNOdWim/ON4rVZnf7ThBRPWU
	 4iVum+b89UhlJsUyZErxHONiF13v3WPHBh9gYdf8d3l5TYkJxakGXhZmSAZB14UCq+
	 ruCOUz5FaqqIzUYSDYZsuFlE/U2G9xSAI6UxFlx0jTTzBMFVRlix1QoCWR6L88wuOO
	 EYOWK56R0j/8u0KJaH50PErWf5wiYSvhaTylEz3BdM47NPPoTnLy6mTvm4x9xWYSuU
	 RqjG1N0npclxg==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fb4fa17044so12164811fa.3;
        Thu, 07 Nov 2024 06:57:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU08G87vO/FTjovw7wyWseq6QKri2vkP7XnvYeXBPIpwaXrHyMplUtd4qei0YP/IZ7PCezwqiMGxlfwtatX@vger.kernel.org, AJvYcCVIbMRV8HSs9PTKxOMbgqt1Im9o6VkN39aLsa4JtrjxJHPc1nY1nrh9hkstVPU1IF2cacrRUyEOvoJJ@vger.kernel.org, AJvYcCVjLrU6f0fbPUuzpAys0ywuIgBjX/Cr9BkH2ztaU8a2+Ej+ILnbcV2x4hoUtVoXuXQEkMt6E9tuvWyH@vger.kernel.org, AJvYcCW1Q7/1Ra3rPkPJscC4JNJTTYMGIb2RMKIywfBlB4mDSmy2url0Pbj4LJ2u4zWejM4HMeiCY5p07s+cD66C@vger.kernel.org, AJvYcCX/6nOELzkaR5NgixkYzv0bNNMPuuZS2Lpsy+njPakq27qynmUjA3vKqmd92UMDABXK1iNyx+UF1ct3gQ==@vger.kernel.org, AJvYcCXVxm1MfIPDqfpULQEuFsgQQ0Q1MmGiPwqAy49ZigAq17WZNjYVDDOCRwnxtkrXZVjs8HnTIyuS13Iv@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7yoLKFLSO7jgcRK9KKasFosF/ko7qVwE712NV0R+BHvzL8pQR
	Q4PzB6NPwg9h6rU1LO7CMMpJAhaGH5E8eYXy9y5Zg4M0A1d7tB5eH5Rw0hn/NvgFvdnEXfb6ET9
	CFpKgnoQkY+FeMAjavB+QpldOaF4=
X-Google-Smtp-Source: AGHT+IFmA951ptQc8QsAZHvAxoThsua6J9myv4Rqxp385MmoQlKPZK+102ZqWTI42l02aJur+dP9PjfQJFka7w66Msc=
X-Received: by 2002:a05:651c:2210:b0:2fb:5035:7e4 with SMTP id
 38308e7fff4ca-2fedb75775fmr136721401fa.5.1730991477370; Thu, 07 Nov 2024
 06:57:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241102175115.1769468-1-xur@google.com> <CAK7LNASdBPtq4vaK0XZQvxicOY15qJFsnqkO2_us4AU4ppHw6A@mail.gmail.com>
 <CAF1bQ=R-7z9+57fji4Mn=ZVUgwSniGQ-8H4=42tFunxyp69Wzw@mail.gmail.com>
In-Reply-To: <CAF1bQ=R-7z9+57fji4Mn=ZVUgwSniGQ-8H4=42tFunxyp69Wzw@mail.gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Thu, 7 Nov 2024 23:57:20 +0900
X-Gmail-Original-Message-ID: <CAK7LNARpXOm1R_BVsH-fSC4ZzQqstHj0amzX8fu6=USwTD91Tw@mail.gmail.com>
Message-ID: <CAK7LNARpXOm1R_BVsH-fSC4ZzQqstHj0amzX8fu6=USwTD91Tw@mail.gmail.com>
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

On Thu, Nov 7, 2024 at 4:00=E2=80=AFAM Rong Xu <xur@google.com> wrote:
>
> On Wed, Nov 6, 2024 at 8:09=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.=
org> wrote:
> >
> > On Sun, Nov 3, 2024 at 2:51=E2=80=AFAM Rong Xu <xur@google.com> wrote:
> > >
> > > Hi,
> > >
> > > This patch series is to integrate AutoFDO and Propeller support into
> > > the Linux kernel. AutoFDO is a profile-guided optimization technique
> > > that leverages hardware sampling to enhance binary performance.
> > > Unlike Instrumentation-based FDO (iFDO), AutoFDO offers a user-friend=
ly
> > > and straightforward application process. While iFDO generally yields
> > > superior profile quality and performance, our findings reveal that
> > > AutoFDO achieves remarkable effectiveness, bringing performance close
> > > to iFDO for benchmark applications.
> > >
> > > Propeller is a profile-guided, post-link optimizer that improves
> > > the performance of large-scale applications compiled with LLVM. It
> > > operates by relinking the binary based on an additional round of runt=
ime
> > > profiles, enabling precise optimizations that are not possible at
> > > compile time.  Similar to AutoFDO, Propeller too utilizes hardware
> > > sampling to collect profiles and apply post-link optimizations to imp=
rove
> > > the benchmark=E2=80=99s performance over and above AutoFDO.
> > >
> > > Our empirical data demonstrates significant performance improvements
> > > with AutoFDO and Propeller, up to 10% on microbenchmarks and up to 5%
> > > on large warehouse-scale benchmarks. This makes a strong case for the=
ir
> > > inclusion as supported features in the upstream kernel.
> > >
> > > Background
> > >
> > > A significant fraction of fleet processing cycles (excluding idle tim=
e)
> > > from data center workloads are attributable to the kernel. Ware-house
> > > scale workloads maximize performance by optimizing the production ker=
nel
> > > using iFDO (a.k.a instrumented PGO, Profile Guided Optimization).
> > >
> > > iFDO can significantly enhance application performance but its use
> > > within the kernel has raised concerns. AutoFDO is a variant of FDO th=
at
> > > uses the hardware=E2=80=99s Performance Monitoring Unit (PMU) to coll=
ect
> > > profiling data. While AutoFDO typically yields smaller performance
> > > gains than iFDO, it presents unique benefits for optimizing kernels.
> > >
> > > AutoFDO eliminates the need for instrumented kernels, allowing a sing=
le
> > > optimized kernel to serve both execution and profile collection. It a=
lso
> > > minimizes slowdown during profile collection, potentially yielding
> > > higher-fidelity profiling, especially for time-sensitive code, compar=
ed
> > > to iFDO. Additionally, AutoFDO profiles can be obtained from producti=
on
> > > environments via the hardware=E2=80=99s PMU whereas iFDO profiles req=
uire
> > > carefully curated load tests that are representative of real-world
> > > traffic.
> > >
> > > AutoFDO facilitates profile collection across diverse targets.
> > > Preliminary studies indicate significant variation in kernel hot spot=
s
> > > within Google=E2=80=99s infrastructure, suggesting potential performa=
nce gains
> > > through target-specific kernel customization.
> > >
> > > Furthermore, other advanced compiler optimization techniques, includi=
ng
> > > ThinLTO and Propeller can be stacked on top of AutoFDO, similar to iF=
DO.
> > > ThinLTO achieves better runtime performance through whole-program
> > > analysis and cross module optimizations. The main difference between
> > > traditional LTO and ThinLTO is that the latter is scalable in time an=
d
> > > memory.
> > >
> > > This patch series adds AutoFDO and Propeller support to the kernel. T=
he
> > > actual solution comes in six parts:
> > >
> > > [P 1] Add the build support for using AutoFDO in Clang
> > >
> > >       Add the basic support for AutoFDO build and provide the
> > >       instructions for using AutoFDO.
> > >
> > > [P 2] Fix objtool for bogus warnings when -ffunction-sections is enab=
led
> > >
> > > [P 3] Adjust symbol ordering in text output sections
> > >
> > > [P 4] Add markers for text_unlikely and text_hot sections
> > >
> > > [P 5] Enable =E2=80=93ffunction-sections for the AutoFDO build
> > >
> > > [P 6] Enable Machine Function Split (MFS) optimization for AutoFDO
> > >
> > > [P 7] Add Propeller configuration to the kernel build
> > >
> > > Patch 1 provides basic AutoFDO build support. Patches 2 to 6 further
> > > enhance the performance of AutoFDO builds and are functionally depend=
ent
> > > on Patch 1. Patch 7 enables support for Propeller and is dependent on
> > > patch 2 to patch 4.
> > >
> > > Caveats
> > >
> > > AutoFDO is compatible with both GCC and Clang, but the patches in thi=
s
> > > series are exclusively applicable to LLVM 17 or newer for AutoFDO and
> > > LLVM 19 or newer for Propeller. For profile conversion, two different
> > > tools could be used, llvm_profgen or create_llvm_prof. llvm_profgen
> > > needs to be the LLVM 19 or newer, or just the LLVM trunk. Alternative=
ly,
> > > create_llvm_prof v0.30.1 or newer can be used instead of llvm-profgen=
.
> > >
> > > Additionally, the build is only supported on x86 platforms equipped
> > > with PMU capabilities, such as LBR on Intel machines. More
> > > specifically:
> > >  * Intel platforms: works on every platform that supports LBR;
> > >    we have tested on Skylake.
> > >  * AMD platforms: tested on AMD Zen3 with the BRS feature. The kernel
> > >    needs to be configured with =E2=80=9CCONFIG_PERF_EVENTS_AMD_BRS=3D=
y", To
> > >    check, use
> > >    $ cat /proc/cpuinfo | grep =E2=80=9C brs=E2=80=9D
> > >    For the AMD Zen4, AMD LBRV2 is supported, but we suspect a bug wit=
h
> > >    AMD LBRv2 implementation in Genoa which blocks the usage.
> > >
> > > For ARM, we plan to send patches for SPE-based Propeller when
> > > AutoFDO for Arm is ready.
> > >
> > > Experiments and Results
> > >
> > > Experiments were conducted to compare the performance of AutoFDO-opti=
mized
> > > kernel images (version 6.9.x) against default builds.. The evaluation
> > > encompassed both open source microbenchmarks and real-world productio=
n
> > > services from Google and Meta. The selected microbenchmarks included =
Neper,
> > > a network subsystem benchmark, and UnixBench which is a comprehensive=
 suite
> > > for assessing various kernel operations.
> > >
> > > For Neper, AutoFDO optimization resulted in a 6.1% increase in throug=
hput
> > > and a 10.6% reduction in latency. UnixBench saw a 2.2% improvement in=
 its
> > > index score under low system load and a 2.6% improvement under high s=
ystem
> > > load.
> > >
> > > For further details on the improvements observed in Google and Meta's
> > > production services, please refer to the LLVM discourse post:
> > > https://discourse.llvm.org/t/optimizing-the-linux-kernel-with-autofdo=
-including-thinlto-and-propeller/79108
> > >
> > > Thanks,
> > >
> > > Rong Xu and Han Shen
> >
> >
> > I applied this series to linux-kbuild.
> >
>
> Thanks for taking the patch!
>
> > As I mentioned before, I do not like #ifdef because
> > it hides (not fixes) issues only for default cases.
>
> We followed the suggestion and removed most of the #if (or #ifdef) in
> the linker script.
> I just checked: there are two #ifdef remaining:
> (1) in the propeller patch for .llvm_bb_addr_map
> (2) in linker script patch for arch/sparc/kernel/vmlinux.lds.S.
>
> I think it's likely safe to remove the checks for head_64.o in
> non-SPARC64 builds and .llvm_bb_addr_map symbols in non-propeller builds.
>
> SPARC64 builds should always produce head_64.o, and non-SPARC64
> builds shouldn't.
>
> Propeller builds always generate .llvm_bb_addr_map symbols, and the
> linker will omit the section if it's empty in non-propeller builds.
>
> Keeping the checks is harmless and might slightly reduce linker
> workload for matching.
> But If you'd prefer to remove them, I'm happy to provide a patch.


I am talking about the #ifdef in include/asm-generic/vmlinux.lds.h


Yeah, it is me who (reluctantly) accepted cb87481ee89d.

Now, the #ifdef has become a little more complicated.
The default case is safe, but there are hidden issues.

Some issues are easy to fix, so I sent some patches.
https://lore.kernel.org/linux-kbuild/20241106161445.189399-1-masahiroy@kern=
el.org/T/#t
https://lore.kernel.org/linux-kbuild/20241106161445.189399-1-masahiroy@kern=
el.org/T/#m4e4fa70386696e903b68d3fe1d7277e9a63fbefe
https://lore.kernel.org/linux-kbuild/20241107111519.GA15424@willie-the-truc=
k/T/#mccf6d49ddd11c90dcc583d7a68934bb3311da880

For example, see e41f501d3912.

When CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=3Dy or
CONFIG_LTO_CLANG=3Dy or CONFIG_AUTOFDO_CLANG=3Dy or
CONFIG_PROPELLER_CLANG=3Dy, the .text.startup sections
will go to TEXT_MAIN instead of INIT_TEXT.
This is not a fatal issue, but we cannot reuse memory for .text.startup
sections.

Removing the #ifdef (i.e. reverting cb87481ee89d) is more difficult
because we need to take a closer look at potential impacts for all
architectures.

I understood you did not want to take a risk to break random architectures,
so I decided to postpone the #ifdef issue and accept your patch set.

--=20
Best Regards
Masahiro Yamada

