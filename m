Return-Path: <linux-arch+bounces-7483-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 174BE9894FA
	for <lists+linux-arch@lfdr.de>; Sun, 29 Sep 2024 13:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80DDFB22D34
	for <lists+linux-arch@lfdr.de>; Sun, 29 Sep 2024 11:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9198015AD90;
	Sun, 29 Sep 2024 11:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R8G/Jpqc"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F44D157465;
	Sun, 29 Sep 2024 11:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727608162; cv=none; b=u9lF0U+SgEc6JizfpvWGfmQOEHuknYaa0ilp/KAsQMYktS7+/idwXxjZ9yLJWFPpSK0b70iEeRIYdI4sC4ZZxGDtrifjDzuJLjm0Kb0wKeatIHAo8hb06ZHlkoT2Y9+aFS/QFbMGZzVL1E6A7mAi+WUuB7VXmwYNANqiFvNgGK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727608162; c=relaxed/simple;
	bh=srwdaNmK8u2bJg6ywpOtDUlEv34NsoQ/aP2RQHtowvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jzZAdph/qZsZNxQFdcrOUdTSb9O77m/qIjG6JlPW72ZLI+fwkfU4jmyvYm74f7/9d6g3iJTu5FF1yHvvvMeN0FH+/b2vsWOMCXtF9bwzjROQ4Es67ydMIypT1zHrBuXxMxF37NlyrFa5YKflofnuxSMqYSEsWKBhoXzNPROiq5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R8G/Jpqc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1523C4CED5;
	Sun, 29 Sep 2024 11:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727608162;
	bh=srwdaNmK8u2bJg6ywpOtDUlEv34NsoQ/aP2RQHtowvo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=R8G/JpqcJcVQ5t45jYU222P4qlac/DozuVI68tmhgAYoW+VNOA49ZEpvmy2pOIvgZ
	 G2Zq5km1N/AhcHPO5C8pw9I9SpxpUALwM4ZpB+JZw4rC7zXK9lC5BgL6wcJ7vv3E4s
	 JqpcsHkNSYAFjO5x1DMIlHZR2DsjeO01BKM/WFyTR90xuWhvCMgtyScLA+M1OJUeG3
	 b8BfJuMtrGp68qLeGnDmBiySq64KLReYQCTk3JSRaBnS7LHVlkEiZuN5WDYYvRcaxl
	 or3s4E6aOfIy8N1B67ShauI/1nvjmUDgxOjICzWTuHpMM2NI+21VaOHWgi9o9JFpvs
	 835meCM6cDE4w==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5366fd6fdf1so4157050e87.0;
        Sun, 29 Sep 2024 04:09:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCURXOvzhwZhKwKHL/r/D+TY+NDk+jjy4D1k5tsaGXAklEKdVuLHl8UyhQym2XD+w2lIMtpZfcxQgHjoVeZP@vger.kernel.org, AJvYcCUl8VShWl80uppB4byPmNSI3Rqbg1HlyeEpa8+Kjri2Sil/ns3o+4Xbc5eONgXlHX39UV8LGRoOPls9@vger.kernel.org, AJvYcCWa9zNG33kdFVAuBom6OgAVTKa3SJ+4OwyYwPZdXB/iLHNy5GYcynrJE/mAH7ZyFwYduzyrV/hEueNO@vger.kernel.org, AJvYcCWgInj0wOLR/bVPqrwUWgIpHfLfGBO32aK84O1/+IvV1tBoV1eZohGO8BvkK5kuIYg2q29V6GNxK9oK@vger.kernel.org, AJvYcCWzGgYKqMWi+1VegJ60tVjG/fCfD7KA81xkUpwGfUsPpfeaFa/ZYyvkU9A4zW7DgqtDsMG6QGON8fibMoVl@vger.kernel.org
X-Gm-Message-State: AOJu0YwFMgzyXeTm8LV5xPKv8Pay9KFHfkL50tx24pWXfzfMGy//uw+U
	5Mju3ZHuVAqx1YHyAuHIF1km6rG2VWvX2WagtmnOZ+cp5FRrWjiykbZ/j8ERUt+HwZQVOAA9xlh
	aJmdXysdkvIg8K7wUzPURkLAKk0c=
X-Google-Smtp-Source: AGHT+IEsBxQobNp7YOwhlu12U4LHK6MZ7qbVwvDOh9lalkDk33YZH+hUz+o835ZL3w50z+1yplsg5PQvJbebLBR4ngE=
X-Received: by 2002:ac2:4e12:0:b0:52e:9f6b:64 with SMTP id 2adb3069b0e04-5389fc49f41mr3634136e87.34.1727608160167;
 Sun, 29 Sep 2024 04:09:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240728203001.2551083-1-xur@google.com> <20240728203001.2551083-7-xur@google.com>
In-Reply-To: <20240728203001.2551083-7-xur@google.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sun, 29 Sep 2024 20:08:43 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ0Z38a1Nt=_XKT3i-UpauiO9RaZAye6LXGCFzvg2R8Bg@mail.gmail.com>
Message-ID: <CAK7LNAQ0Z38a1Nt=_XKT3i-UpauiO9RaZAye6LXGCFzvg2R8Bg@mail.gmail.com>
Subject: Re: [PATCH 6/6] Add Propeller configuration for kernel build.
To: Rong Xu <xur@google.com>
Cc: Han Shen <shenhan@google.com>, Sriraman Tallam <tmsriram@google.com>, 
	David Li <davidxl@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Vegard Nossum <vegard.nossum@oracle.com>, 
	John Moon <john@jmoon.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Samuel Holland <samuel.holland@sifive.com>, Mike Rapoport <rppt@kernel.org>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Rafael Aquini <aquini@redhat.com>, Petr Pavlu <petr.pavlu@suse.com>, 
	Eric DeVolder <eric.devolder@oracle.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Benjamin Segall <bsegall@google.com>, 
	Breno Leitao <leitao@debian.org>, Wei Yang <richard.weiyang@gmail.com>, 
	Brian Gerst <brgerst@gmail.com>, Juergen Gross <jgross@suse.com>, 
	Palmer Dabbelt <palmer@rivosinc.com>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Kees Cook <kees@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Xiao Wang <xiao.w.wang@intel.com>, Jan Kiszka <jan.kiszka@siemens.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-arch@vger.kernel.org, llvm@lists.linux.dev, 
	Krzysztof Pszeniczny <kpszeniczny@google.com>, Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 5:31=E2=80=AFAM Rong Xu <xur@google.com> wrote:
>
> Add the build support for using Clang's Propeller optimizer. Like
> AutoFDO, Propeller uses hardware sampling to gather information
> about the frequency of execution of different code paths within a
> binary. This information is then used to guide the compiler's
> optimization decisions, resulting in a more efficient binary.
>
> The support requires a Clang compiler LLVM 19 or later, and the
> create_llvm_prof tool
> (https://github.com/google/autofdo/releases/tag/v0.30.1). This
> submission is limited to x86 platforms that support PMU features
> like LBR on Intel machines and AMD Zen3 BRS.
>
> For Arm, we plan to send patches for SPE-based Propeller when
> AutoFDO for Arm is ready.
>
> Here is an example workflow for building an AutoFDO+Propeller
> optimized kernel:
>
> 1) Build the kernel on the HOST machine, with AutoFDO and Propeller
>    build config
>       CONFIG_AUTOFDO_CLANG=3Dy
>       CONFIG_PROPELLER_CLANG=3Dy
>    then
>       $ make LLVM=3D1 CLANG_AUTOFDO_PROFILE=3D<autofdo_profile>
>
> =E2=80=9C<autofdo_profile>=E2=80=9D is the profile collected when doing a=
 non-Propeller
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
> 4) (Optional) Download the raw perf file to the HOST machine.
>
> 5) Generate Propeller profile:
>    $ create_llvm_prof --binary=3D<vmlinux> --profile=3D<perf_file> \
>      --format=3Dpropeller --propeller_output_module_name \
>      --out=3D<propeller_profile_prefix>_cc_profile.txt \
>      --propeller_symorder=3D<propeller_profile_prefix>_ld_profile.txt
>
>    =E2=80=9Ccreate_llvm_prof=E2=80=9D is the profile conversion tool, and=
 a prebuilt
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
>       CONFIG_AUTOFDO_CLANG=3Dy
>       CONFIG_PROPELLER_CLANG=3Dy
>    and
>       $ make LLVM=3D1 CLANG_AUTOFDO_PROFILE=3D<autofdo_profile> \
>         CLANG_PROPELLER_PROFILE_PREFIX=3D<propeller_profile_prefix>
>
> Co-developed-by: Han Shen <shenhan@google.com>
> Signed-off-by: Han Shen <shenhan@google.com>
> Signed-off-by: Rong Xu <xur@google.com>
> Suggested-by: Sriraman Tallam <tmsriram@google.com>
> Suggested-by: Krzysztof Pszeniczny <kpszeniczny@google.com>
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Suggested-by: Stephane Eranian <eranian@google.com>
> ---





> diff --git a/Makefile b/Makefile
> index 5ae30cc94a26..85a96d973f20 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1025,6 +1025,7 @@ include-$(CONFIG_KCOV)            +=3D scripts/Make=
file.kcov
>  include-$(CONFIG_RANDSTRUCT)   +=3D scripts/Makefile.randstruct
>  include-$(CONFIG_GCC_PLUGINS)  +=3D scripts/Makefile.gcc-plugins
>  include-$(CONFIG_AUTOFDO_CLANG)        +=3D scripts/Makefile.autofdo
> +include-$(CONFIG_PROPELLER_CLANG)      +=3D scripts/Makefile.propeller



Please do not ignore this comment:

https://github.com/torvalds/linux/blob/v6.11/Makefile#L1016







> +ifdef CONFIG_LTO_CLANG
> +ifdef CONFIG_LTO_CLANG_THIN
> +ifdef CLANG_PROPELLER_PROFILE_PREFIX
> +KBUILD_LDFLAGS +=3D --lto-basic-block-sections=3D$(CLANG_PROPELLER_PROFI=
LE_PREFIX)_cc_profile.txt
> +else
> +KBUILD_LDFLAGS +=3D --lto-basic-block-sections=3Dlabels
> +endif
> +endif
> +else
> +endif


Unreadable and redundant.


ifdef CONFIG_LTO_CLANG_THIN
  ifdef CLANG_PROPELLER_PROFILE_PREFIX
    KBUILD_LDFLAGS +=3D
--lto-basic-block-sections=3D$(CLANG_PROPELLER_PROFILE_PREFIX)_cc_profile.t=
xt
  else
    KBUILD_LDFLAGS +=3D --lto-basic-block-sections=3Dlabels
  endif
endif










--=20
Best Regards
Masahiro Yamada

