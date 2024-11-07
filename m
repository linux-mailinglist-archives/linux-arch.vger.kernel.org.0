Return-Path: <linux-arch+bounces-8891-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B3C9C0E02
	for <lists+linux-arch@lfdr.de>; Thu,  7 Nov 2024 19:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 330C628270D
	for <lists+linux-arch@lfdr.de>; Thu,  7 Nov 2024 18:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C491421732F;
	Thu,  7 Nov 2024 18:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i0yziqJR"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEBC2170D3
	for <linux-arch@vger.kernel.org>; Thu,  7 Nov 2024 18:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731005076; cv=none; b=VTC/7Pp4cF6W4KsVDD2eeTAKP+IZ9q0dQ9g+/5Bc9Rn2g2NGo8gfniW1b/TPP5HcwrVsgG1M7JKfmulvcNLGZ4/vPwMY6hncGF41zCV7pfuyoWEWMcwa3/9hQ97XeyPk9K3BUYUw07rzyhguQC3sDVZvI9w0nZ30o0yxHxf4KMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731005076; c=relaxed/simple;
	bh=Tam3C3FSWBIBa879uPr6lOw08wkgu4jeV8XEi7er5NA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u8tejYDj4Y1bepTFNftsv5e/Jo2P85h7vIPKf/4JwaiSyV+7LyV0D7dkhWnQF4QlTk8ykaR9UA24r93K9Es1naYXwHFv/2aWisLfFDdEaqZN0TMiPGBV/o07Nzqf3Nh3/rxhQlitZOaflR8GMzC4uuJyyQHmgOL7IGABlsyeXpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i0yziqJR; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-460a8d1a9b7so21171cf.1
        for <linux-arch@vger.kernel.org>; Thu, 07 Nov 2024 10:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731005073; x=1731609873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J4nPpYXP0vVd6qbOkqNtUFVqt4H36QKYv9JFjcka9R4=;
        b=i0yziqJRI0ILnBAjYvAjt4vLzPR+UFA6Ww7FdJYeIE3gPS0Vtn+dT3CmfvFdlnaAC+
         2fNSDAkA9MwKUYhyh6CTqP1zDvl2DQq44OdVRpm+pmayYzTrJTztaO5fZ30Jgfw0qg1B
         fSLEkaeZuLLCLyUUCgpdFzSj196jVKWEzMvFfEfviYnc2RnxBMaD6JenbvwqMAzGE7Y6
         1tGMldevX4HH0VAspk48woA+B7QI59I7OeewGTsJcEqrM1sGv61VEkTIgYZWcOCLv2gN
         v4VSh53JVXdPiKb/W9BOfBZgBO/ZF2cGg0DtvEo1TaYTe6EoRFsSwJlxLEeKPsV7VOEf
         Ec9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731005073; x=1731609873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J4nPpYXP0vVd6qbOkqNtUFVqt4H36QKYv9JFjcka9R4=;
        b=QYRCubAaki/0dbmKmOaFm7XGA16FdKib7JCSeUVfROB9hc5lAVFdPSdyLEnwBNT6O0
         q48x2WFGIwKHzXFYq0y2H9YNsLFXi4tV4Tiw48i3rgY3KrHJI/xTeYkr8BrTvwOurqEu
         82qKJoN6wv6tfrXk3Mn69B8lRbeis92ZrlrDZJFQMo1+jmw7PDXoGmy0NVMfh8ABEkKF
         t2aA0yAmRyCTHqPdqPLyvcIbqKzVsGfqcPwlxj4wvF2S3dzhgowa2q/AosQ+SxX63dzq
         /IRgQ4S5sq/yJGg0tE/dWJEjqAMXULpYfIiFCM1kuVBYgSDV7XlECPyl6ArVqVnw8l5f
         8H3w==
X-Forwarded-Encrypted: i=1; AJvYcCXyFm6IT1h9Mtpd5TnDQL4QXcQjwM+1agEbxR2pONi7vYXStzy9NhbqB0JwqO4DtSW22XSf+PA/9cG6@vger.kernel.org
X-Gm-Message-State: AOJu0YyonpYktaHGUjvl93UEdAbEF2wkxYxFDzHu0kpuWaaNrrQh+xBn
	cuEiHOFBhp8Mc2e1ve31fMBLHrx5uNnywog8GUTx7vduZ9XtaHTs+ynDv/sDHKtPdYg1dOa+xYr
	gHuHgQhHcyrdWWp6ndVFKqvaldVoM9dURG8UH
X-Gm-Gg: ASbGncui5lHzUS9ujbnYui7pxGzZOJC4OrjbIKTf7vNEtCVH3MzU7ub0K5t6ve3c8wM
	mTUFnOXO6EjN0QUfCczmsa+D/VnsIyopg1Y3sI3MlK5FkhjUgFc0HOJgxZjXv
X-Google-Smtp-Source: AGHT+IHrq73eKO0bY8+FfuWfYvfEG6yvw63fkpfi5hna41D9nyt3oGP9CfN+ewePinNTBwT8SH0tAPXgnDQz/bQ4nhs=
X-Received: by 2002:a05:622a:4b0a:b0:462:c158:9f5b with SMTP id
 d75a77b69052e-462fa610ffbmr4822701cf.19.1731005073310; Thu, 07 Nov 2024
 10:44:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241102175115.1769468-1-xur@google.com> <CAK7LNASdBPtq4vaK0XZQvxicOY15qJFsnqkO2_us4AU4ppHw6A@mail.gmail.com>
 <CAF1bQ=R-7z9+57fji4Mn=ZVUgwSniGQ-8H4=42tFunxyp69Wzw@mail.gmail.com> <CAK7LNARpXOm1R_BVsH-fSC4ZzQqstHj0amzX8fu6=USwTD91Tw@mail.gmail.com>
In-Reply-To: <CAK7LNARpXOm1R_BVsH-fSC4ZzQqstHj0amzX8fu6=USwTD91Tw@mail.gmail.com>
From: Rong Xu <xur@google.com>
Date: Thu, 7 Nov 2024 10:44:21 -0800
Message-ID: <CAF1bQ=SRnSP9mgnyRw+Hg=0-CX-uOwKmsiwHf6b2bFXKnWxPHw@mail.gmail.com>
Subject: Re: [PATCH v7 0/7] Add AutoFDO and Propeller support for Clang build
To: Masahiro Yamada <masahiroy@kernel.org>
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

Thanks for the explanation.

On Thu, Nov 7, 2024 at 6:58=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.or=
g> wrote:
>
> On Thu, Nov 7, 2024 at 4:00=E2=80=AFAM Rong Xu <xur@google.com> wrote:
> >
> > On Wed, Nov 6, 2024 at 8:09=E2=80=AFAM Masahiro Yamada <masahiroy@kerne=
l.org> wrote:
> > >
> > > On Sun, Nov 3, 2024 at 2:51=E2=80=AFAM Rong Xu <xur@google.com> wrote=
:
> > > >
> > > > Hi,
> > > >
> > > > This patch series is to integrate AutoFDO and Propeller support int=
o
> > > > the Linux kernel. AutoFDO is a profile-guided optimization techniqu=
e
> > > > that leverages hardware sampling to enhance binary performance.
> > > > Unlike Instrumentation-based FDO (iFDO), AutoFDO offers a user-frie=
ndly
> > > > and straightforward application process. While iFDO generally yield=
s
> > > > superior profile quality and performance, our findings reveal that
> > > > AutoFDO achieves remarkable effectiveness, bringing performance clo=
se
> > > > to iFDO for benchmark applications.
> > > >
> > > > Propeller is a profile-guided, post-link optimizer that improves
> > > > the performance of large-scale applications compiled with LLVM. It
> > > > operates by relinking the binary based on an additional round of ru=
ntime
> > > > profiles, enabling precise optimizations that are not possible at
> > > > compile time.  Similar to AutoFDO, Propeller too utilizes hardware
> > > > sampling to collect profiles and apply post-link optimizations to i=
mprove
> > > > the benchmark=E2=80=99s performance over and above AutoFDO.
> > > >
> > > > Our empirical data demonstrates significant performance improvement=
s
> > > > with AutoFDO and Propeller, up to 10% on microbenchmarks and up to =
5%
> > > > on large warehouse-scale benchmarks. This makes a strong case for t=
heir
> > > > inclusion as supported features in the upstream kernel.
> > > >
> > > > Background
> > > >
> > > > A significant fraction of fleet processing cycles (excluding idle t=
ime)
> > > > from data center workloads are attributable to the kernel. Ware-hou=
se
> > > > scale workloads maximize performance by optimizing the production k=
ernel
> > > > using iFDO (a.k.a instrumented PGO, Profile Guided Optimization).
> > > >
> > > > iFDO can significantly enhance application performance but its use
> > > > within the kernel has raised concerns. AutoFDO is a variant of FDO =
that
> > > > uses the hardware=E2=80=99s Performance Monitoring Unit (PMU) to co=
llect
> > > > profiling data. While AutoFDO typically yields smaller performance
> > > > gains than iFDO, it presents unique benefits for optimizing kernels=
.
> > > >
> > > > AutoFDO eliminates the need for instrumented kernels, allowing a si=
ngle
> > > > optimized kernel to serve both execution and profile collection. It=
 also
> > > > minimizes slowdown during profile collection, potentially yielding
> > > > higher-fidelity profiling, especially for time-sensitive code, comp=
ared
> > > > to iFDO. Additionally, AutoFDO profiles can be obtained from produc=
tion
> > > > environments via the hardware=E2=80=99s PMU whereas iFDO profiles r=
equire
> > > > carefully curated load tests that are representative of real-world
> > > > traffic.
> > > >
> > > > AutoFDO facilitates profile collection across diverse targets.
> > > > Preliminary studies indicate significant variation in kernel hot sp=
ots
> > > > within Google=E2=80=99s infrastructure, suggesting potential perfor=
mance gains
> > > > through target-specific kernel customization.
> > > >
> > > > Furthermore, other advanced compiler optimization techniques, inclu=
ding
> > > > ThinLTO and Propeller can be stacked on top of AutoFDO, similar to =
iFDO.
> > > > ThinLTO achieves better runtime performance through whole-program
> > > > analysis and cross module optimizations. The main difference betwee=
n
> > > > traditional LTO and ThinLTO is that the latter is scalable in time =
and
> > > > memory.
> > > >
> > > > This patch series adds AutoFDO and Propeller support to the kernel.=
 The
> > > > actual solution comes in six parts:
> > > >
> > > > [P 1] Add the build support for using AutoFDO in Clang
> > > >
> > > >       Add the basic support for AutoFDO build and provide the
> > > >       instructions for using AutoFDO.
> > > >
> > > > [P 2] Fix objtool for bogus warnings when -ffunction-sections is en=
abled
> > > >
> > > > [P 3] Adjust symbol ordering in text output sections
> > > >
> > > > [P 4] Add markers for text_unlikely and text_hot sections
> > > >
> > > > [P 5] Enable =E2=80=93ffunction-sections for the AutoFDO build
> > > >
> > > > [P 6] Enable Machine Function Split (MFS) optimization for AutoFDO
> > > >
> > > > [P 7] Add Propeller configuration to the kernel build
> > > >
> > > > Patch 1 provides basic AutoFDO build support. Patches 2 to 6 furthe=
r
> > > > enhance the performance of AutoFDO builds and are functionally depe=
ndent
> > > > on Patch 1. Patch 7 enables support for Propeller and is dependent =
on
> > > > patch 2 to patch 4.
> > > >
> > > > Caveats
> > > >
> > > > AutoFDO is compatible with both GCC and Clang, but the patches in t=
his
> > > > series are exclusively applicable to LLVM 17 or newer for AutoFDO a=
nd
> > > > LLVM 19 or newer for Propeller. For profile conversion, two differe=
nt
> > > > tools could be used, llvm_profgen or create_llvm_prof. llvm_profgen
> > > > needs to be the LLVM 19 or newer, or just the LLVM trunk. Alternati=
vely,
> > > > create_llvm_prof v0.30.1 or newer can be used instead of llvm-profg=
en.
> > > >
> > > > Additionally, the build is only supported on x86 platforms equipped
> > > > with PMU capabilities, such as LBR on Intel machines. More
> > > > specifically:
> > > >  * Intel platforms: works on every platform that supports LBR;
> > > >    we have tested on Skylake.
> > > >  * AMD platforms: tested on AMD Zen3 with the BRS feature. The kern=
el
> > > >    needs to be configured with =E2=80=9CCONFIG_PERF_EVENTS_AMD_BRS=
=3Dy", To
> > > >    check, use
> > > >    $ cat /proc/cpuinfo | grep =E2=80=9C brs=E2=80=9D
> > > >    For the AMD Zen4, AMD LBRV2 is supported, but we suspect a bug w=
ith
> > > >    AMD LBRv2 implementation in Genoa which blocks the usage.
> > > >
> > > > For ARM, we plan to send patches for SPE-based Propeller when
> > > > AutoFDO for Arm is ready.
> > > >
> > > > Experiments and Results
> > > >
> > > > Experiments were conducted to compare the performance of AutoFDO-op=
timized
> > > > kernel images (version 6.9.x) against default builds.. The evaluati=
on
> > > > encompassed both open source microbenchmarks and real-world product=
ion
> > > > services from Google and Meta. The selected microbenchmarks include=
d Neper,
> > > > a network subsystem benchmark, and UnixBench which is a comprehensi=
ve suite
> > > > for assessing various kernel operations.
> > > >
> > > > For Neper, AutoFDO optimization resulted in a 6.1% increase in thro=
ughput
> > > > and a 10.6% reduction in latency. UnixBench saw a 2.2% improvement =
in its
> > > > index score under low system load and a 2.6% improvement under high=
 system
> > > > load.
> > > >
> > > > For further details on the improvements observed in Google and Meta=
's
> > > > production services, please refer to the LLVM discourse post:
> > > > https://discourse.llvm.org/t/optimizing-the-linux-kernel-with-autof=
do-including-thinlto-and-propeller/79108
> > > >
> > > > Thanks,
> > > >
> > > > Rong Xu and Han Shen
> > >
> > >
> > > I applied this series to linux-kbuild.
> > >
> >
> > Thanks for taking the patch!
> >
> > > As I mentioned before, I do not like #ifdef because
> > > it hides (not fixes) issues only for default cases.
> >
> > We followed the suggestion and removed most of the #if (or #ifdef) in
> > the linker script.
> > I just checked: there are two #ifdef remaining:
> > (1) in the propeller patch for .llvm_bb_addr_map
> > (2) in linker script patch for arch/sparc/kernel/vmlinux.lds.S.
> >
> > I think it's likely safe to remove the checks for head_64.o in
> > non-SPARC64 builds and .llvm_bb_addr_map symbols in non-propeller build=
s.
> >
> > SPARC64 builds should always produce head_64.o, and non-SPARC64
> > builds shouldn't.
> >
> > Propeller builds always generate .llvm_bb_addr_map symbols, and the
> > linker will omit the section if it's empty in non-propeller builds.
> >
> > Keeping the checks is harmless and might slightly reduce linker
> > workload for matching.
> > But If you'd prefer to remove them, I'm happy to provide a patch.
>
>
> I am talking about the #ifdef in include/asm-generic/vmlinux.lds.h
>
>
> Yeah, it is me who (reluctantly) accepted cb87481ee89d.
>
> Now, the #ifdef has become a little more complicated.
> The default case is safe, but there are hidden issues.
>
> Some issues are easy to fix, so I sent some patches.
> https://lore.kernel.org/linux-kbuild/20241106161445.189399-1-masahiroy@ke=
rnel.org/T/#t
> https://lore.kernel.org/linux-kbuild/20241106161445.189399-1-masahiroy@ke=
rnel.org/T/#m4e4fa70386696e903b68d3fe1d7277e9a63fbefe
> https://lore.kernel.org/linux-kbuild/20241107111519.GA15424@willie-the-tr=
uck/T/#mccf6d49ddd11c90dcc583d7a68934bb3311da880

I did notice the issues for .data.* -- that is one of the reasons we
separated text from data in our patch.

>
> For example, see e41f501d3912.
>
> When CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=3Dy or
> CONFIG_LTO_CLANG=3Dy or CONFIG_AUTOFDO_CLANG=3Dy or
> CONFIG_PROPELLER_CLANG=3Dy, the .text.startup sections
> will go to TEXT_MAIN instead of INIT_TEXT.
> This is not a fatal issue, but we cannot reuse memory for .text.startup
> sections.
>
> Removing the #ifdef (i.e. reverting cb87481ee89d) is more difficult
> because we need to take a closer look at potential impacts for all
> architectures.

I'm not sure if there is a naming convention for section names in the kerne=
l.
For special sections, we should avoid using .text.* or .data.*,
instead, using "..', or use
other prefixes.

The compiler can generate sections names like .text.hot.*", ".text.unknown.=
*",
  ".text.unlikely.*", ".text.split.*", ".text.startup." or
".text.exit. It seems we've
addressed most of them except .text.startup and .text.exit.

For text.startup and .text.exit, have you considered renaming the
sections within
the linker script -- they are fixed strings and should be able to be rename=
d.

>
> I understood you did not want to take a risk to break random architecture=
s,
> so I decided to postpone the #ifdef issue and accept your patch set.

Thanks for the understanding!

>
> --
> Best Regards
> Masahiro Yamada

