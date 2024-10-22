Return-Path: <linux-arch+bounces-8414-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E92B69A946D
	for <lists+linux-arch@lfdr.de>; Tue, 22 Oct 2024 02:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48F5A283173
	for <lists+linux-arch@lfdr.de>; Tue, 22 Oct 2024 00:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888771FF035;
	Tue, 22 Oct 2024 00:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G5m5oXU8"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B04F1D0E1F
	for <linux-arch@vger.kernel.org>; Tue, 22 Oct 2024 00:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729555217; cv=none; b=OarC5O0T3QoDdeWh/X59rp1uqYoPLvwPOYfA+tzJHUqvg1Z9+ISuidQk3sfoCZwbM1kjsCMWGoTHe66hLqsLniHTNOOcZ6amdnr3fDT4pYA5hF7CVzciQ9o7NaUkG9TS6uLPRMQlVcyqbG5OqMefm+YvjW1jZ61UMml79UQCzjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729555217; c=relaxed/simple;
	bh=NUxgsZdfxf2QbroYvAyl0ZCQ2YRblvkBtdS7RITP5Lk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ao+QFVBIE3nbDdMJ+en7os8urwA4xSb8jSvU3FrJluoKJ2mp7K4dIqKVkxuwsdgA+7BS/X3XWujeznkl2BiQv5iH7iRbN8tgCei+hVclAB6XEd7z1EVvf8B9FgTcH9SRpARfan/p5e0GO54nORWZgr3TrUIWyDX1Gk7drxx4B5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G5m5oXU8; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-460a8d1a9b7so86141cf.1
        for <linux-arch@vger.kernel.org>; Mon, 21 Oct 2024 17:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729555213; x=1730160013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H6f1CPfxlJzSA8RgcyxBghPWs/9YPZngb+idGKSn9jI=;
        b=G5m5oXU8I3gj7wmdYsP4KScUrVqd/Fo8xjBmGTJrOdGr23wDkLfSuu7+ZIQsM8Ly+E
         yiiFCCLLWV1guHIwOxMZtkagMXue+jxyw+3CqsxTLy+koLT8F6lZ9Q/CBQ5z7MkSb6KV
         osbUrbpyyxc+g4TfO1UPzi1s3Nwqqu+zEOZXTDCn6atMS3cX8E1eijab9kjiEMhNX5Xm
         AFKUiI/5Qpc3DKulA+cVeSowUAM1yJyA40ydJdjf132ILs4MtCkhh59QmTG+mQAjbBs/
         OixNyBcg/WBp2MlYoZtHHgc85EXRtSeUQe5QVDE5eQo1q8JCdPg8NZ21z7Ko5HQS+2f0
         RCtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729555213; x=1730160013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H6f1CPfxlJzSA8RgcyxBghPWs/9YPZngb+idGKSn9jI=;
        b=KTnvno8YG0mTqOOZY5xQsVzXo6o1jIYPZzPh9EVCmLvUid8XBT+TorYabD90fH1xtf
         x5hZYwuh+RcBac1pjrROy41idY271y2z4zEG+TTXttc9TFTaykMsJaX4YavusY36Wp/o
         hVrpdzrgeR4nh7m4xdnlSqAhG4uCqPwI5FCWguCouUKsBlkoN2l+7N1MAQd0H8DdRily
         Anl0SbM2X570sWuxJy8pH0og5+PXGtp0lIiWAboBotbW4egw2qLIsipn76S/3nrpL8NR
         WpMRrfLeIlT9MVOSfVVxN0IbDViFxYerLsoY6QfLRhnMUYrC4f79Xy980SwYkq1VS5nB
         GEiQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3u4ctH85ELQWFaddaL/rDdrnHgNxeziNiYJxOPBTZc0W/+NAUodBE/7cQPiZIPwgIsisKtLlMOapQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+46pB6OCazOjFtL/9WNj8IPaqV7LBGB7hKjxAkEbFN/FOFjcV
	ip9vKPPVtmUsRL/N8fB6psGWrEyZmFn43lOIk6t2V5VBivgdlhOibUyN3PNKni9dyQj5jKasVoh
	b5JXnxNY5I6N3a/PWl2a55sMfOJL1FJZ4rBZR
X-Google-Smtp-Source: AGHT+IFzFAHsXnZXe3iUnWiSgX+gCvfFIfwNv3M3+h7rbhhg65l+kS1KTAsAS8eg2E+xoYexE4LOOyJuULtSO769rSE=
X-Received: by 2002:ac8:5f92:0:b0:460:48fc:3cd8 with SMTP id
 d75a77b69052e-4610247b7f8mr751621cf.5.1729555212846; Mon, 21 Oct 2024
 17:00:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014213342.1480681-1-xur@google.com> <20241014213342.1480681-7-xur@google.com>
 <CAK7LNARfm7HBx-wLCak1w0sfH7LML1ErWO=2sLj4ovR38RsnTA@mail.gmail.com>
In-Reply-To: <CAK7LNARfm7HBx-wLCak1w0sfH7LML1ErWO=2sLj4ovR38RsnTA@mail.gmail.com>
From: Rong Xu <xur@google.com>
Date: Mon, 21 Oct 2024 17:00:01 -0700
Message-ID: <CAF1bQ=Qi9hyKbc5H3N36W=MukT3321rZMCas0ndpRf0YszAfOA@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] Add Propeller configuration for kernel build.
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
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Maksim Panchenko <max4bolt@gmail.com>, x86@kernel.org, 
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, Sriraman Tallam <tmsriram@google.com>, 
	Krzysztof Pszeniczny <kpszeniczny@google.com>, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 20, 2024 at 10:49=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.=
org> wrote:
>
> Please remove the period at the end of the commit subject.

Will fix this.

>
>
>
> On Tue, Oct 15, 2024 at 6:34=E2=80=AFAM Rong Xu <xur@google.com> wrote:
> >
> > Add the build support for using Clang's Propeller optimizer. Like
> > AutoFDO, Propeller uses hardware sampling to gather information
> > about the frequency of execution of different code paths within a
> > binary. This information is then used to guide the compiler's
> > optimization decisions, resulting in a more efficient binary.
> >
> > The support requires a Clang compiler LLVM 19 or later, and the
> > create_llvm_prof tool
> > (https://github.com/google/autofdo/releases/tag/v0.30.1). This
> > submission is limited to x86 platforms that support PMU features
>
>
> "This submission" -> "This commit"

Will fix this.

>
>
>
> > like LBR on Intel machines and AMD Zen3 BRS.
> >
> > For Arm, we plan to send patches for SPE-based Propeller when
> > AutoFDO for Arm is ready.
>
>
> "we plan to send ..." is not a good description once it is committed.
>
> This sentence should be moved to the cover letter, or reworked.

We will move this sentence to the cover letter.

>
>
>
>
>
>
> >
> > Here is an example workflow for building an AutoFDO+Propeller
> > optimized kernel:
> >
> > 1) Build the kernel on the HOST machine, with AutoFDO and Propeller
>
>
> Why is the "HOST" capitalized?

We will fix this.

>
>
>
> >    build config
> >       CONFIG_AUTOFDO_CLANG=3Dy
> >       CONFIG_PROPELLER_CLANG=3Dy
> >    then
> >       $ make LLVM=3D1 CLANG_AUTOFDO_PROFILE=3D<autofdo_profile>
> >
> > =E2=80=9C<autofdo_profile>=E2=80=9D is the profile collected when doing=
 a non-Propeller
> > AutoFDO build. This step builds a kernel that has the same optimization
> > level as AutoFDO, plus a metadata section that records basic block
> > information. This kernel image runs as fast as an AutoFDO optimized
> > kernel.
> >
> > 2) Install the kernel on test/production machines.
> >
> > 3) Run the load tests. The '-c' option in perf specifies the sample
> >    event period. We suggest using a suitable prime number,
> >    like 500009, for this purpose.
> >    For Intel platforms:
> >       $ perf record -e BR_INST_RETIRED.NEAR_TAKEN:k -a -N -b -c <count>=
 \
> >         -o <perf_file> -- <loadtest>
> >    For AMD platforms:
> >       The supported system are: Zen3 with BRS, or Zen4 with amd_lbr_v2
> >       # To see if Zen3 support LBR:
> >       $ cat proc/cpuinfo | grep " brs"
> >       # To see if Zen4 support LBR:
> >       $ cat proc/cpuinfo | grep amd_lbr_v2
> >       # If the result is yes, then collect the profile using:
> >       $ perf record --pfm-events RETIRED_TAKEN_BRANCH_INSTRUCTIONS:k -a=
 \
> >         -N -b -c <count> -o <perf_file> -- <loadtest>
> >
> > 4) (Optional) Download the raw perf file to the HOST machine.
>
>
> Same question as above.

Will use "host".

>
>
> >
> > 5) Generate Propeller profile:
> >    $ create_llvm_prof --binary=3D<vmlinux> --profile=3D<perf_file> \
> >      --format=3Dpropeller --propeller_output_module_name \
> >      --out=3D<propeller_profile_prefix>_cc_profile.txt \
> >      --propeller_symorder=3D<propeller_profile_prefix>_ld_profile.txt
> >
> >    =E2=80=9Ccreate_llvm_prof=E2=80=9D is the profile conversion tool, a=
nd a prebuilt
> >    binary for linux can be found on
> >    https://github.com/google/autofdo/releases/tag/v0.30.1 (can also bui=
ld
> >    from source).
> >
> >    "<propeller_profile_prefix>" can be something like
> >    "/home/user/dir/any_string".
> >
> >    This command generates a pair of Propeller profiles:
> >    "<propeller_profile_prefix>_cc_profile.txt" and
> >    "<propeller_profile_prefix>_ld_profile.txt".
> >
> > 6) Rebuild the kernel using the AutoFDO and Propeller profile files.
> >       CONFIG_AUTOFDO_CLANG=3Dy
> >       CONFIG_PROPELLER_CLANG=3Dy
> >    and
> >       $ make LLVM=3D1 CLANG_AUTOFDO_PROFILE=3D<autofdo_profile> \
> >         CLANG_PROPELLER_PROFILE_PREFIX=3D<propeller_profile_prefix>
> >
> > Co-developed-by: Han Shen <shenhan@google.com>
> > Signed-off-by: Han Shen <shenhan@google.com>
> > Signed-off-by: Rong Xu <xur@google.com>
> > Suggested-by: Sriraman Tallam <tmsriram@google.com>
> > Suggested-by: Krzysztof Pszeniczny <kpszeniczny@google.com>
> > Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> > Suggested-by: Stephane Eranian <eranian@google.com>
>
>
>
> >
> >  .. only::  subproject and html
> > diff --git a/Documentation/dev-tools/propeller.rst b/Documentation/dev-=
tools/propeller.rst
> > new file mode 100644
> > index 000000000000..a217354e0f95
> > --- /dev/null
> > +++ b/Documentation/dev-tools/propeller.rst
> > @@ -0,0 +1,161 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +Using Propeller with the Linux kernel
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +This enables Propeller build support for the kernel when using Clang
> > +compiler. Propeller is a profile-guided optimization (PGO) method used
> > +to optimize binary executables. Like AutoFDO, it utilizes hardware
> > +sampling to gather information about the frequency of execution of
> > +different code paths within a binary. Unlike AutoFDO, this information
> > +is then used right before linking phase to optimize (among others)
> > +block layout within and across functions.
> > +
> > +A few important notes about adopting Propeller optimization:
> > +
> > +#. Although it can be used as a standalone optimization step, it is
> > +   strongly recommended to apply Propeller on top of AutoFDO,
> > +   AutoFDO+ThinLTO or Instrument FDO. The rest of this document
> > +   assumes this paradigm.
>
> This is a hard requirement instead of a recommendation
> because PROPERLLER_CLANG has "depends on AUTOFDO_CLANG".

Actually PROPELLER_CLANG does not depend on AUTOFDO_CLANG.
We should apply Propeller on top of the vanilla build kernel.

I admit that we did not do a good job to separate these two in this patch.

>
>
>
>
> > +
> > +#. Propeller uses another round of profiling on top of
> > +   AutoFDO/AutoFDO+ThinLTO/iFDO. The whole build process involves
> > +   "build-afdo - train-afdo - build-propeller - train-propeller -
> > +   build-optimized".
> > +
> > +#. Propeller requires LLVM 19 release or later for Clang/Clang++
> > +   and the linker(ld.lld).
> > +
> > +#. In addition to LLVM toolchain, Propeller requires a profiling
> > +   conversion tool: https://github.com/google/autofdo with a release
> > +   after v0.30.1: https://github.com/google/autofdo/releases/tag/v0.30=
.1.
> > +
> > +The Propeller optimization process involves the following steps:
> > +
> > +#. Initial building: Build the AutoFDO or AutoFDO+ThinLTO binary as
> > +   you would normally do, but with a set of compile-time / link-time
> > +   flags, so that a special metadata section is created within the
> > +   kernel binary. The special section is only intend to be used by the
> > +   profiling tool, it is not part of the runtime image, nor does it
> > +   change kernel run time text sections.
> > +
> > +#. Profiling: The above kernel is then run with a representative
> > +   workload to gather execution frequency data. This data is collected
> > +   using hardware sampling, via perf. Propeller is most effective on
> > +   platforms supporting advanced PMU features like LBR on Intel
> > +   machines. This step is the same as profiling the kernel for AutoFDO
> > +   (the exact perf parameters can be different).
> > +
> > +#. Propeller profile generation: Perf output file is converted to a
> > +   pair of Propeller profiles via an offline tool.
> > +
> > +#. Optimized build: Build the AutoFDO or AutoFDO+ThinLTO optimized
> > +   binary as you would normally do, but with a compile-time /
> > +   link-time flag to pick up the Propeller compile time and link time
> > +   profiles. This build step uses 3 profiles - the AutoFDO profile,
> > +   the Propeller compile-time profile and the Propeller link-time
> > +   profile.
> > +
> > +#. Deployment: The optimized kernel binary is deployed and used
> > +   in production environments, providing improved performance
> > +   and reduced latency.
> > +
> > +Preparation
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Configure the kernel with::
> > +
> > +   CONFIG_AUTOFDO_CLANG=3Dy
>
>
> This is automatically met due to "depends on AUTOFDO_CLANG".

Agreed. But we will remove the dependency from PROPELlER_CLANG to AUTOFDO_C=
LANG.
So we will keep the part.

>
>
>
> > +   CONFIG_PROPELLER_CLANG=3Dy
> > +
> > +Customization
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +You can enable or disable Propeller build for individual file and
> > +directories by adding a line similar to the following to the
> > +respective kernel Makefile:
>
> The same comment as in 1/6.

We will fix this similar to the proposed change in 1/6 if you think
the change there is acceptable.

>
>
>
> > +- For enabling a single file (e.g. foo.o)::
> > +
> > +   PROPELLER_PROFILE_foo.o :=3D y
> > +
> > +- For enabling all files in one directory::
> > +
> > +   PROPELLER_PROFILE :=3D y
> > +
> > +- For disabling one file::
> > +
> > +   PROPELLER_PROFILE_foo.o :=3D n
> > +
> > +- For disabling all files in one directory::
> > +
> > +   PROPELLER__PROFILE :=3D n
> > +
> > +
> > +Workflow
> > +=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Here is an example workflow for building an AutoFDO+Propeller kernel:
> > +
> > +1) Assuming an AutoFDO profile is already collected following
> > +   instructions in the AutoFDO document, build the kernel on the HOST
> > +   machine, with AutoFDO and Propeller build configs ::
> > +
> > +      CONFIG_AUTOFDO_CLANG=3Dy
> > +      CONFIG_PROPELLER_CLANG=3Dy
> > +
> > +   and ::
> > +
> > +      $ make LLVM=3D1 CLANG_AUTOFDO_PROFILE=3D<autofdo-profile-name>
> > +
> > +2) Install the kernel on the TEST machine.
>
>
> I am repeatedly encountered with capitalized "HOST" and "TEST".
>
> Does this term have a special meaning instead of a test machine in genera=
l?

No special meaning. This is not intentional. Will fix this.

>
>
>
>
>
>
>
> > +
> > +3) Run the load tests. The '-c' option in perf specifies the sample
> > +   event period. We suggest using a suitable prime number, like 500009=
,
> > +   for this purpose.
> > +
> > +   - For Intel platforms::
> > +
> > +      $ perf record -e BR_INST_RETIRED.NEAR_TAKEN:k -a -N -b -c <count=
> -o <perf_file> -- <loadtest>
> > +
> > +   - For AMD platforms::
> > +
> > +      $ perf record --pfm-event RETIRED_TAKEN_BRANCH_INSTRUCTIONS:k -a=
 -N -b -c <count> -o <perf_file> -- <loadtest>
> > +
> > +   Note you can repeat the above steps to collect multiple <perf_file>=
s.
> > +
> > +4) (Optional) Download the raw perf file(s) to the HOST machine.
> > +
> > +5) Use the create_llvm_prof tool (https://github.com/google/autofdo) t=
o
> > +   generate Propeller profile. ::
> > +
> > +      $ create_llvm_prof --binary=3D<vmlinux> --profile=3D<perf_file>
> > +                         --format=3Dpropeller --propeller_output_modul=
e_name
> > +                         --out=3D<propeller_profile_prefix>_cc_profile=
.txt
> > +                         --propeller_symorder=3D<propeller_profile_pre=
fix>_ld_profile.txt
> > +
> > +   "<propeller_profile_prefix>" can be something like "/home/user/dir/=
any_string".
> > +
> > +   This command generates a pair of Propeller profiles:
> > +   "<propeller_profile_prefix>_cc_profile.txt" and
> > +   "<propeller_profile_prefix>_ld_profile.txt".
> > +
> > +   If there are more than 1 perf_file collected in the previous step,
> > +   you can create a temp list file "<perf_file_list>" with each line
> > +   containing one perf file name and run::
> > +
> > +      $ create_llvm_prof --binary=3D<vmlinux> --profile=3D@<perf_file_=
list>
> > +                         --format=3Dpropeller --propeller_output_modul=
e_name
> > +                         --out=3D<propeller_profile_prefix>_cc_profile=
.txt
> > +                         --propeller_symorder=3D<propeller_profile_pre=
fix>_ld_profile.txt
> > +
> > +6) Rebuild the kernel using the AutoFDO and Propeller
> > +   profiles. ::
>
>
> "." and "::" are an odd combination.

"::" is an rst marker. I will make sure the rendered text looks good.

>
>
>
>
> > +
> > +      CONFIG_AUTOFDO_CLANG=3Dy
> > +      CONFIG_PROPELLER_CLANG=3Dy
> > +
> > +   and ::
> > +
> > +      $ make LLVM=3D1 CLANG_AUTOFDO_PROFILE=3D<profile_file> CLANG_PRO=
PELLER_PROFILE_PREFIX=3D<propeller_profile_prefix>
>
>
>
> > diff --git a/Makefile b/Makefile
> > index bbb6ec68f5dc..2d2f688c21c6 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1019,6 +1019,7 @@ include-$(CONFIG_UBSAN)           +=3D scripts/Ma=
kefile.ubsan
> >  include-$(CONFIG_KCOV)         +=3D scripts/Makefile.kcov
> >  include-$(CONFIG_RANDSTRUCT)   +=3D scripts/Makefile.randstruct
> >  include-$(CONFIG_AUTOFDO_CLANG)        +=3D scripts/Makefile.autofdo
> > +include-$(CONFIG_PROPELLER_CLANG)      +=3D scripts/Makefile.propeller
> >  include-$(CONFIG_GCC_PLUGINS)  +=3D scripts/Makefile.gcc-plugins
> >
> >  include $(addprefix $(srctree)/, $(include-y))
> > diff --git a/arch/Kconfig b/arch/Kconfig
> > index 5e9604960cbb..fdeb5f173a10 100644
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -831,6 +831,28 @@ config AUTOFDO_CLANG
> >
> >           If unsure, say N.
> >
> > +config ARCH_SUPPORTS_PROPELLER_CLANG
> > +       bool
> > +
> > +config PROPELLER_CLANG
> > +       bool "Enable Clang's Propeller build"
> > +       depends on ARCH_SUPPORTS_PROPELLER_CLANG
> > +       depends on AUTOFDO_CLANG
> > +       depends on CC_IS_CLANG && CLANG_VERSION >=3D 190000
>
>
> CC_IS_CLANG is redundant, but I am fine if you want to have it explicitly=
.

Let's keep this just for clarity purposes.

>
>
>
> > +       help
> > +         This option enables Clang=E2=80=99s Propeller build which
> > +         is on top of AutoFDO build. When the Propeller profiles
> > +         is specified in variable CLANG_PROPELLER_PROFILE_PREFIX
> > +         during the build process, Clang uses the profiles to
> > +         optimize the kernel.
> > +
> > +         If no profile is specified, Proepller options are
>
>
> "Proepller" is a typo.

Thanks! Will fix this.

>
>
>
>
> > +         still passed to Clang to facilitate the collection
> > +         of perf data for creating the Propeller profiles in
> > +         subsequent builds.
> > +
> > +         If unsure, say N.
> > +
> >  config ARCH_SUPPORTS_CFI_CLANG
> >         bool
> >         help
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 503a0268155a..da47164bfddc 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -127,6 +127,7 @@ config X86
> >         select ARCH_SUPPORTS_LTO_CLANG_THIN
> >         select ARCH_SUPPORTS_RT
> >         select ARCH_SUPPORTS_AUTOFDO_CLANG
> > +       select ARCH_SUPPORTS_PROPELLER_CLANG    if X86_64
> >         select ARCH_USE_BUILTIN_BSWAP
> >         select ARCH_USE_CMPXCHG_LOCKREF         if X86_CMPXCHG64
> >         select ARCH_USE_MEMTEST
> > diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.ld=
s.S
> > index 6726be89b7a6..7ecc21c569be 100644
> > --- a/arch/x86/kernel/vmlinux.lds.S
> > +++ b/arch/x86/kernel/vmlinux.lds.S
> > @@ -442,6 +442,10 @@ SECTIONS
> >
> >         STABS_DEBUG
> >         DWARF_DEBUG
> > +#ifdef CONFIG_PROPELLER_CLANG
> > +       .llvm_bb_addr_map : { *(.llvm_bb_addr_map) }
> > +#endif
> > +
> >         ELF_DETAILS
> >
> >         DISCARDS
> > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vm=
linux.lds.h
> > index 20e46c0917db..5986dd4cfb14 100644
> > --- a/include/asm-generic/vmlinux.lds.h
> > +++ b/include/asm-generic/vmlinux.lds.h
> > @@ -95,14 +95,14 @@
> >   * With LTO_CLANG, the linker also splits sections by default, so we n=
eed
> >   * these macros to combine the sections during the final link.
> >   *
> > - * With LTO_CLANG, the linker also splits sections by default, so we n=
eed
> > - * these macros to combine the sections during the final link.
> > + * CONFIG_AUTOFD_CLANG and CONFIG_PROPELLER_CLANG will also split text=
 sections
> > + * and cluster them in the linking time.
> >   *
> >   * RODATA_MAIN is not used because existing code already defines .roda=
ta.x
> >   * sections to be brought in with rodata.
> >   */
> >  #if defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) || defined(CONFIG_LT=
O_CLANG) || \
> > -defined(CONFIG_AUTOFDO_CLANG)
> > +defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
>
>
> If you have "depends on PROPELLER_CLANG" in Kconfig,
> you do not need to touch this line.
>
> When CONFIG_PROPELLER_CLANG is enabled, CONFIG_AUTOFDO_CLANG is already d=
efined.

We will remove the dependency from CONFIG_PROPELLER_CLANG to
CONFIG_AUTOFDO_CLANG.
So I guess we will keep this part.

>
>
>
>
> >  #define TEXT_MAIN .text .text.[0-9a-zA-Z_]*
> >  #else
> >  #define TEXT_MAIN .text
> > @@ -556,7 +556,7 @@ defined(CONFIG_AUTOFDO_CLANG)
> >                 __cpuidle_text_end =3D .;                              =
   \
> >                 __noinstr_text_end =3D .;
> >
> > -#ifdef CONFIG_AUTOFDO_CLANG
> > +#if defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
>
>
> Ditto.
>
>
> >  #define TEXT_HOT                                                      =
 \
> >                 __hot_text_start =3D .;                                =
   \
> >                 *(.text.hot .text.hot.*)                               =
 \
> > @@ -584,7 +584,7 @@ defined(CONFIG_AUTOFDO_CLANG)
> >   * first when in these builds.
> >   */
> >  #if defined(CONFIG_LD_DEAD_CODE_DATA_ELIMINATION) || defined(CONFIG_LT=
O_CLANG) || \
> > -defined(CONFIG_AUTOFDO_CLANG)
> > +defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
>
>
> Ditto.
> Make sense only when CONFIG_AUTOFDO_CLANG and CONFIG_PROPELLER_CLANG
> are independent of each other.

We will make CONFIG_AUTOFDO_CLANG and CONFIG_PROPELLER_CLANG
independent of each other.

>
>
>
> >  #define TEXT_TEXT                                                     =
 \
> >                 ALIGN_FUNCTION();                                      =
 \
> >                 *(.text.asan.* .text.tsan.*)                           =
 \
> > diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> > index e85d6ac31bd9..60354c476956 100644
> > --- a/scripts/Makefile.lib
> > +++ b/scripts/Makefile.lib
> > @@ -201,6 +201,16 @@ _c_flags +=3D $(if $(patsubst n%,, \
> >         $(CFLAGS_AUTOFDO_CLANG))
> >  endif
> >
> > +#
> > +# Enable Clang's Propeller build flags for a file or directory dependi=
ng on
> > +# variables AUTOFDO_PROPELLER_obj.o and PROPELLER_PROFILE.
>
> The same comment as in 1/6.

Will fix this.

>
>
>
> > +#
> > +ifeq ($(CONFIG_PROPELLER_CLANG),y)
>
>
>
> ifdef CONFIG_PROPELLER_CLANG
>
> would be simpler, as you used this style in scripts/Makefile.propeller

Will use the suggested code.

>
>
>
>
>
>
> > +_c_flags +=3D $(if $(patsubst n%,, \
> > +       $(AUTOFDO_PROFILE_$(target-stem).o)$(AUTOFDO_PROFILE)$(PROPELLE=
R_PROFILE))$(is-kernel-object), \
> > +       $(CFLAGS_PROPELLER_CLANG))
> > +endif
> > +
> >  # $(src) for including checkin headers from generated source files
> >  # $(obj) for including generated headers from checkin source files
> >  ifeq ($(KBUILD_EXTMOD),)
> > diff --git a/scripts/Makefile.propeller b/scripts/Makefile.propeller
> > new file mode 100644
> > index 000000000000..344190717e47
> > --- /dev/null
> > +++ b/scripts/Makefile.propeller
>
>
> > +# Propeller requires debug information to embed module names in the pr=
ofiles.
> > +# If CONFIG_DEBUG_INFO is not enabled, set -gmlt option. Skip this for=
 AutoFDO,
> > +# as the option should already be set.
> > +ifndef CONFIG_DEBUG_INFO
> > +  ifndef CONFIG_AUTOFDO_CLANG
> > +    CFLAGS_PROPELLER_CLANG +=3D -gmlt
> > +  endif
> > +endif
>
>
> This block is dead code due to "depends on AUTOFDO_CLANG".
>
> "ifndef CONFIG_AUTOFDO_CLANG" is never met here.

Yes. I think we still need to when we remove the dependency to
CONFIG_AUTOFDO_CLANG.

>
>
>
>
>
>
>
> --
> Best Regards
> Masahiro Yamada

