Return-Path: <linux-arch+bounces-8864-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DEF59BD3C8
	for <lists+linux-arch@lfdr.de>; Tue,  5 Nov 2024 18:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9E36B228BE
	for <lists+linux-arch@lfdr.de>; Tue,  5 Nov 2024 17:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A5B1E47D8;
	Tue,  5 Nov 2024 17:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZN7o5Oqm"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D3B84D02
	for <linux-arch@vger.kernel.org>; Tue,  5 Nov 2024 17:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730829130; cv=none; b=AmB5exzdH+3MHE59cE6pItMtU5cTfhOLvhbWxfnSXQQZaHruCmVEWdHmh+rliqFoKpLHRvwmSQNUXYCE3/FBpHP1EwBhfIi5PMqXkcRxGKQ0/ywhlRN06B3wciSGLbftMyrBtwd23fkFPsSeowB4RfE8n5OE6KMlg2B5QFmAc6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730829130; c=relaxed/simple;
	bh=+7QG5+NJbKj00cNkZtLscXQvF3IjZiYR4AanUDs5sPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rxnw+NgqrBDlptkSCGiopsOf7BDirKi3/C6nS+v+CD96Q1G8m8q1PXdjWInA/zRkJPrCmRbinDsj7q+inOq6IvNzoBHrKHHO29vj8ytvJVrHCnlKZC+G1fFGkmoFlkPpp4GhNm41hyD81LV4guRe3i5bD9GrT/BzUsuydfReUyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZN7o5Oqm; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-460b295b9eeso3861cf.1
        for <linux-arch@vger.kernel.org>; Tue, 05 Nov 2024 09:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730829127; x=1731433927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BfUA3/rDNyi3HTYVcuuUTBZRfkh4ulVjf/kXG8SdzRY=;
        b=ZN7o5OqmyJbTrqlhyXEATLXm1+UyZwVBBu8i/Vg6IZQnWXYWcbG+I2aANvEW5/aAQQ
         RAd8lBuZmf3i0we0K5/oXE+CMSmtkYP7NpKsNpcWbhcquMFWkV23FPbS5bue9S0lOzIu
         4WG+jiSPH2lHA4M0okGyipiDqWZHnjpWAIdw3QjcH/0T4TtniRWZzRjMZ4Mx93HmIRjS
         FMU+goalAb5aCGRPFrdzuIiXdm7LBKWmJorOSOx6qAzXJK0UpirpWxhfJhyFu/ZCxjL+
         Bau6vS7MI/bXFaUT6pyelOttP+0zhtJEykZzAUlEsc5RPxbAhmGDbHZoObEkQLxruzru
         gTDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730829127; x=1731433927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BfUA3/rDNyi3HTYVcuuUTBZRfkh4ulVjf/kXG8SdzRY=;
        b=oM8DKU3dvZKGKaiOKCWK4ey5nbAu+4uHKtQr/ZiPZKTQE0V4SdNp2+9j9zoRZz+N2d
         mD7lVEkm1Q/kCaPTJ+AlYLg5dMOpi8RkMZsmd5JOYZdwtdvagHZbGz3+Bgq+vZlLIBB5
         504a3KxFOIzr1dDhWn+9XXH7UH9AXcmc3Ao+E8Zsd37psTMNGsmVOnsnULJTmeEeYzXv
         VadNFa3IFyWJbyJfuzRzTueiIlnE0jQOWP1AH3WXJgAVfKq7Mqk2OfwMArZmge7wVrVT
         08nv+ys/qSACskcLckTA0Emh2CIH+Fa9vFbOwmQdwDo8A26yI4UwqoXhdw4pwhEoWY5d
         dYBA==
X-Forwarded-Encrypted: i=1; AJvYcCVUKcHahOMoIORg1QLsDfUlScEmrdb/BiavRnbNdO6yEi/dlLbTZQPVlYq8g8j4rJt1FDk8a4Kk98ji@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7K2UlWaOxZzttIIbpo+mM//UdD1xV75kI173IF2p+Ox2G9+b0
	+j5IBQ7kysGsYC1miXXhdGsz0Bzbtb1ZEM2v5sEc380SXIkq5UmvivBnKz2qhNK4ollE8FY0/NJ
	C8McyULRIdGKyojL8AWOBLqG7gG4mbUb6m32P
X-Gm-Gg: ASbGncv/toz6UcmDztwFpH9Z+zzzjd8pdmHbt4vy1O7GybScOrkYHtd16q2PEurmBbB
	UzI+yUThfTgOjMgC2RC/Iw4Jf6pPiUMlXHUj4R6Zxmm8p5Rvj7UW9qIMFXkoQ7A==
X-Google-Smtp-Source: AGHT+IGONnoDoxOE1c2aZlxWJ/Cx1ZVvDUz6sU9V9ccTIGEg2o+Kn0N18L0g84R6qxxrsMsZ+Tlpk13NrTZuLEVSMiA=
X-Received: by 2002:ac8:5d0a:0:b0:462:ad94:3555 with SMTP id
 d75a77b69052e-462e6183889mr3434541cf.25.1730829126973; Tue, 05 Nov 2024
 09:52:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241102175115.1769468-1-xur@google.com> <20241102175115.1769468-2-xur@google.com>
 <09349180-027a-4b29-a40c-9dc3425e592c@cachyos.org> <3183ab86-8f1f-4624-9175-31e77d773699@cachyos.org>
 <CACkGtrgOw8inYCD96ot_w9VwzoFvvgCReAx0P-=Rxxqj2FT4_A@mail.gmail.com>
 <67c07d2f-fb1f-4b7d-96e2-fb5ceb8fc692@cachyos.org> <CACkGtrgJHtG5pXR1z=6G4XR6ffT5jEi3jZQo=UhYj091naBhsA@mail.gmail.com>
 <CAF1bQ=SbeR3XhFc7JYGOh69JZfAwQV8nupAQM+ZxpzNEFUFxJw@mail.gmail.com>
 <449fddd2-342f-48cc-9a11-8a34814f1284@cachyos.org> <e4dad58c-e329-4e9a-aa6f-8b08bdf8f350@cachyos.org>
 <e9889ff1-053a-4acf-bb45-ee31d255da2a@cachyos.org>
In-Reply-To: <e9889ff1-053a-4acf-bb45-ee31d255da2a@cachyos.org>
From: Rong Xu <xur@google.com>
Date: Tue, 5 Nov 2024 09:51:55 -0800
Message-ID: <CAF1bQ=QzZvMY2v4vzb74CuuiS-MbRP0=G5oobAGAFRd5qyF8PQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/7] Add AutoFDO support for Clang build
To: Peter Jung <ptr1337@cachyos.org>
Cc: Han Shen <shenhan@google.com>, Alice Ryhl <aliceryhl@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Bill Wendling <morbo@google.com>, Borislav Petkov <bp@alien8.de>, Breno Leitao <leitao@debian.org>, 
	Brian Gerst <brgerst@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	David Li <davidxl@google.com>, Heiko Carstens <hca@linux.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Juergen Gross <jgross@suse.com>, 
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, "Mike Rapoport (IBM)" <rppt@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Nicolas Schier <nicolas@fjasle.eu>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Wei Yang <richard.weiyang@gmail.com>, 
	workflows@vger.kernel.org, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	Maksim Panchenko <max4bolt@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Yabin Cui <yabinc@google.com>, Krzysztof Pszeniczny <kpszeniczny@google.com>, 
	Sriraman Tallam <tmsriram@google.com>, Stephane Eranian <eranian@google.com>, x86@kernel.org, 
	linux-arch@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Peter, thanks for verifying and filing the bug report!

-Rong

On Tue, Nov 5, 2024 at 9:19=E2=80=AFAM Peter Jung <ptr1337@cachyos.org> wro=
te:
>
> Here the bugreport, in case someone wants to track it:
>
> https://sourceware.org/bugzilla/show_bug.cgi?id=3D32340
>
> On 05.11.24 15:56, Peter Jung wrote:
> > You were right - reverting commit:
> > https://github.com/bminor/binutils-gdb/commit/
> > b20ab53f81db7eefa0db00d14f06c04527ac324c from the 2.43 branch does fix
> > the packaging.
> >
> > I will forward this to an issue at their bugzilla.
> >
> > On 05.11.24 15:33, Peter Jung wrote:
> >> Hi Rong,
> >>
> >> Glad that you were able to reproduce the issue!
> >> Thanks for finding the root cause as well as the part of the code.
> >> This really helps.
> >>
> >> I was able to do a successful packaging with binutils 2.42.
> >> Lets forward this to the binutils tracker and hope this will be soon
> >> solved. =F0=9F=99=82
> >>
> >> I have tested this also on the latest commit
> >> (e1e4078ac59740a79cd709d61872abe15aba0087) and the issue is also
> >> reproducible there.
> >>
> >> Thanks for your time! I dont see this as blocker. =F0=9F=99=82
> >> It gets time to get this series merged :P
> >>
> >> Best regards,
> >>
> >> Peter
> >>
> >>
> >>
> >> On 05.11.24 08:25, Rong Xu wrote:
> >>> We debugged this issue and we found the failure seems to only happen
> >>> with strip (version 2.43) in binutil.
> >>>
> >>> For a profile-use compilation, either with -fprofile-use (PGO or
> >>> iFDO), or -fprofile-sample-use (AutoFDO),
> >>> an ELF section of .llvm.call-graph-profile is created for the object.
> >>> For some reasons (like to save space?),
> >>> the relocations in this section are of type "rel', rather the more
> >>> common "rela" type.
> >>>
> >>> In this case,
> >>> $ readelf -r kvm.ko |grep llvm.call-graph-profile
> >>> Relocation section '.rel.llvm.call-graph-profile' at offset 0xf62a00
> >>> contains 4 entries:
> >>>
> >>> strip (v2.43.0) has difficulty handling the relocations in
> >>> .rel.llvm.call-graph-profile -- it silently failed with --strip-debug=
.
> >>> But strip (v.2.42) has no issue with kvm.ko. The strip in llvm (i.e.
> >>> llvm-strip) also passes with kvm.ko
> >>>
> >>> I compared binutil/strip source code for version v2.43.0 and v2.42.
> >>> The different is around here:
> >>> In v2.42 of bfd/elfcode.h
> >>>     1618       if ((entsize =3D=3D sizeof (Elf_External_Rela)
> >>>     1619            && ebd->elf_info_to_howto !=3D NULL)
> >>>     1620           || ebd->elf_info_to_howto_rel =3D=3D NULL)
> >>>     1621         res =3D ebd->elf_info_to_howto (abfd, relent, &rela)=
;
> >>>     1622       else
> >>>     1623         res =3D ebd->elf_info_to_howto_rel (abfd, relent, &r=
ela);
> >>>
> >>> In v2.43.0 of bfd/elfcode.h
> >>>     1618       if (entsize =3D=3D sizeof (Elf_External_Rela)
> >>>     1619           && ebd->elf_info_to_howto !=3D NULL)
> >>>     1620         res =3D ebd->elf_info_to_howto (abfd, relent, &rela)=
;
> >>>     1621       else if (ebd->elf_info_to_howto_rel !=3D NULL)
> >>>     1622         res =3D ebd->elf_info_to_howto_rel (abfd, relent, &r=
ela);
> >>>
> >>> In the 2.43 strip, line 1618 is false and line 1621 is also false.
> >>> "res" is returned as false and the program exits with -1.
> >>>
> >>> While in 2.42, line 1620 is true and we get "res" from line 1621 and
> >>> program functions correctly.
> >>>
> >>> I'm not familiar with binutil code base and don't know the reason for
> >>> removing line 1620.
> >>> I can file a bug for binutil for people to further investigate this.
> >>>
> >>> It seems to me that this issue should not be a blocker for our patch.
> >>>
> >>> Regards,
> >>>
> >>> -Rong
> >>>
> >>>
> >>>
> >>>
> >>>
> >>> On Mon, Nov 4, 2024 at 12:24=E2=80=AFPM Han Shen<shenhan@google.com> =
wrote:
> >>>> Hi Peter,
> >>>> Thanks for providing the detailed reproduce.
> >>>> Now I can see the error (after I synced to 6.12.0-rc6, I was using
> >>>> rc5).
> >>>> I'll look into that and report back.
> >>>>
> >>>>> I have tested your provided method, but the AutoFDO profile (lld do=
es
> >>>> not get lto-sample-profile=3D$pathtoprofile passed)
> >>>>
> >>>> I see. You also turned on ThinLTO, which I didn't, so the profile wa=
s
> >>>> only used during compilation, not passed to lld.
> >>>>
> >>>> Thanks,
> >>>> Han
> >>>>
> >>>> On Mon, Nov 4, 2024 at 9:31=E2=80=AFAM Peter Jung<ptr1337@cachyos.or=
g> wrote:
> >>>>> Hi Han,
> >>>>>
> >>>>> I have tested your provided method, but the AutoFDO profile (lld do=
es
> >>>>> not get lto-sample-profile=3D$pathtoprofile passed)  nor Clang as
> >>>>> compiler
> >>>>> gets used.
> >>>>> Please replace following PKGBUILD and config from linux-mainline wi=
th
> >>>>> the provided one in the gist. The patch is also included there.
> >>>>>
> >>>>> https://gist.github.com/ptr1337/c92728bb273f7dbc2817db75eedec9ed
> >>>>>
> >>>>> The main change I am doing here, is passing following to the build
> >>>>> array
> >>>>> and replacing "make all":
> >>>>>
> >>>>> make LLVM=3D1 LLVM_IAS=3D1 CLANG_AUTOFDO_PROFILE=3D${srcdir}/perf.a=
fdo all
> >>>>>
> >>>>> When compiling the kernel with makepkg, this results at the
> >>>>> packaging to
> >>>>> following issue and can be reliable reproduced.
> >>>>>
> >>>>> Regards,
> >>>>>
> >>>>> Peter
> >>>>>
> >>>>>
> >>>>> On 04.11.24 05:50, Han Shen wrote:
> >>>>>> Hi Peter, thanks for reporting the issue. I am trying to reproduce=
 it
> >>>>>> in the up-to-date archlinux environment. Below is what I have:
> >>>>>>     0. pacman -Syu
> >>>>>>     1. cloned archlinux build files from
> >>>>>> https://aur.archlinux.org/linux-mainline.git the newest mainline
> >>>>>> version is 6.12rc5-1.
> >>>>>>     2. changed the PKGBUILD file to include the patches series
> >>>>>>     3. changed the "config" to turn on clang autofdo
> >>>>>>     4. collected afdo profiles
> >>>>>>     5. MAKEFLAGS=3D"-j48 V=3D1 LLVM=3D1 CLANG_AUTOFDO_PROFILE=3D$(=
pwd)/
> >>>>>> perf.afdo" \
> >>>>>>           makepkg -s --skipinteg --skippgp
> >>>>>>     6. install and reboot
> >>>>>> The above steps succeeded.
> >>>>>> You mentioned the error happens at "module_install", can you instr=
uct
> >>>>>> me how to execute the "module_install" step?
> >>>>>>
> >>>>>> Thanks,
> >>>>>> Han
> >>>>>>
> >>>>>> On Sat, Nov 2, 2024 at 12:53=E2=80=AFPM Peter Jung<ptr1337@cachyos=
.org>
> >>>>>> wrote:
> >>>>>>>
> >>>>>>> On 02.11.24 20:46, Peter Jung wrote:
> >>>>>>>> On 02.11.24 18:51, Rong Xu wrote:
> >>>>>>>>> Add the build support for using Clang's AutoFDO. Building the
> >>>>>>>>> kernel
> >>>>>>>>> with AutoFDO does not reduce the optimization level from the
> >>>>>>>>> compiler. AutoFDO uses hardware sampling to gather information
> >>>>>>>>> about
> >>>>>>>>> the frequency of execution of different code paths within a
> >>>>>>>>> binary.
> >>>>>>>>> This information is then used to guide the compiler's optimizat=
ion
> >>>>>>>>> decisions, resulting in a more efficient binary. Experiments
> >>>>>>>>> showed that the kernel can improve up to 10% in latency.
> >>>>>>>>>
> >>>>>>>>> The support requires a Clang compiler after LLVM 17. This
> >>>>>>>>> submission
> >>>>>>>>> is limited to x86 platforms that support PMU features like LBR =
on
> >>>>>>>>> Intel machines and AMD Zen3 BRS. Support for SPE on ARM 1,
> >>>>>>>>>     and BRBE on ARM 1 is part of planned future work.
> >>>>>>>>>
> >>>>>>>>> Here is an example workflow for AutoFDO kernel:
> >>>>>>>>>
> >>>>>>>>> 1) Build the kernel on the host machine with LLVM enabled, for
> >>>>>>>>> example,
> >>>>>>>>>           $ make menuconfig LLVM=3D1
> >>>>>>>>>        Turn on AutoFDO build config:
> >>>>>>>>>          CONFIG_AUTOFDO_CLANG=3Dy
> >>>>>>>>>        With a configuration that has LLVM enabled, use the
> >>>>>>>>> following
> >>>>>>>>>        command:
> >>>>>>>>>           scripts/config -e AUTOFDO_CLANG
> >>>>>>>>>        After getting the config, build with
> >>>>>>>>>          $ make LLVM=3D1
> >>>>>>>>>
> >>>>>>>>> 2) Install the kernel on the test machine.
> >>>>>>>>>
> >>>>>>>>> 3) Run the load tests. The '-c' option in perf specifies the
> >>>>>>>>> sample
> >>>>>>>>>       event period. We suggest     using a suitable prime numbe=
r,
> >>>>>>>>>       like 500009, for this purpose.
> >>>>>>>>>       For Intel platforms:
> >>>>>>>>>          $ perf record -e BR_INST_RETIRED.NEAR_TAKEN:k -a -N -b=
 -c
> >>>>>>>>> <count> \
> >>>>>>>>>            -o <perf_file> -- <loadtest>
> >>>>>>>>>       For AMD platforms:
> >>>>>>>>>          The supported system are: Zen3 with BRS, or Zen4 with
> >>>>>>>>> amd_lbr_v2
> >>>>>>>>>         For Zen3:
> >>>>>>>>>          $ cat proc/cpuinfo | grep " brs"
> >>>>>>>>>          For Zen4:
> >>>>>>>>>          $ cat proc/cpuinfo | grep amd_lbr_v2
> >>>>>>>>>          $ perf record --pfm-events
> >>>>>>>>> RETIRED_TAKEN_BRANCH_INSTRUCTIONS:k
> >>>>>>>>> -a \
> >>>>>>>>>            -N -b -c <count> -o <perf_file> -- <loadtest>
> >>>>>>>>>
> >>>>>>>>> 4) (Optional) Download the raw perf file to the host machine.
> >>>>>>>>>
> >>>>>>>>> 5) To generate an AutoFDO profile, two offline tools are
> >>>>>>>>> available:
> >>>>>>>>>       create_llvm_prof and llvm_profgen. The create_llvm_prof
> >>>>>>>>> tool is part
> >>>>>>>>>       of the AutoFDO project and can be found on GitHub
> >>>>>>>>>       (https://github.com/google/autofdo), version v0.30.1 or
> >>>>>>>>> later. The
> >>>>>>>>>       llvm_profgen tool is included in the LLVM compiler
> >>>>>>>>> itself. It's
> >>>>>>>>>       important to note that the version of llvm_profgen
> >>>>>>>>> doesn't need to
> >>>>>>>>>       match the version of Clang. It needs to be the LLVM 19
> >>>>>>>>> release or
> >>>>>>>>>       later, or from the LLVM trunk.
> >>>>>>>>>          $ llvm-profgen --kernel --binary=3D<vmlinux> --
> >>>>>>>>> perfdata=3D<perf_file> \
> >>>>>>>>>            -o <profile_file>
> >>>>>>>>>       or
> >>>>>>>>>          $ create_llvm_prof --binary=3D<vmlinux> --
> >>>>>>>>> profile=3D<perf_file> \
> >>>>>>>>>            --format=3Dextbinary --out=3D<profile_file>
> >>>>>>>>>
> >>>>>>>>>       Note that multiple AutoFDO profile files can be merged
> >>>>>>>>> into one via:
> >>>>>>>>>          $ llvm-profdata merge -o <profile_file>  <profile_1> .=
..
> >>>>>>>>> <profile_n>
> >>>>>>>>>
> >>>>>>>>> 6) Rebuild the kernel using the AutoFDO profile file with the
> >>>>>>>>> same config
> >>>>>>>>>       as step 1, (Note CONFIG_AUTOFDO_CLANG needs to be enabled=
):
> >>>>>>>>>          $ make LLVM=3D1 CLANG_AUTOFDO_PROFILE=3D<profile_file>
> >>>>>>>>>
> >>>>>>>>> Co-developed-by: Han Shen<shenhan@google.com>
> >>>>>>>>> Signed-off-by: Han Shen<shenhan@google.com>
> >>>>>>>>> Signed-off-by: Rong Xu<xur@google.com>
> >>>>>>>>> Suggested-by: Sriraman Tallam<tmsriram@google.com>
> >>>>>>>>> Suggested-by: Krzysztof Pszeniczny<kpszeniczny@google.com>
> >>>>>>>>> Suggested-by: Nick Desaulniers<ndesaulniers@google.com>
> >>>>>>>>> Suggested-by: Stephane Eranian<eranian@google.com>
> >>>>>>>>> Tested-by: Yonghong Song<yonghong.song@linux.dev>
> >>>>>>>>> Tested-by: Yabin Cui<yabinc@google.com>
> >>>>>>>>> Tested-by: Nathan Chancellor<nathan@kernel.org>
> >>>>>>>>> Reviewed-by: Kees Cook<kees@kernel.org>
> >>>>>>>> Tested-by: Peter Jung<ptr1337@cachyos.org>
> >>>>>>>>
> >>>>>>> The compilations and testing with the "make pacman-pkg" function
> >>>>>>> from
> >>>>>>> the kernel worked fine.
> >>>>>>>
> >>>>>>> One problem I do face:
> >>>>>>> When I apply a AutoFDO profile together with the PKGBUILD [1] fro=
m
> >>>>>>> archlinux im running into issues at "module_install" at the
> >>>>>>> packaging.
> >>>>>>>
> >>>>>>> See following log:
> >>>>>>> ```
> >>>>>>> make[2]: *** [scripts/Makefile.modinst:125:
> >>>>>>> /tmp/makepkg/linux-cachyos-rc-autofdo/pkg/linux-cachyos-rc-
> >>>>>>> autofdo/usr/lib/modules/6.12.0-rc5-5-cachyos-rc-autofdo/kernel/
> >>>>>>> arch/x86/kvm/kvm.ko]
> >>>>>>> Error 1
> >>>>>>> make[2]: *** Deleting file
> >>>>>>> '/tmp/makepkg/linux-cachyos-rc-autofdo/pkg/linux-cachyos-rc-
> >>>>>>> autofdo/usr/lib/modules/6.12.0-rc5-5-cachyos-rc-autofdo/kernel/
> >>>>>>> arch/x86/kvm/kvm.ko'
> >>>>>>>      INSTALL
> >>>>>>> /tmp/makepkg/linux-cachyos-rc-autofdo/pkg/linux-cachyos-rc-
> >>>>>>> autofdo/usr/lib/modules/6.12.0-rc5-5-cachyos-rc-autofdo/kernel/
> >>>>>>> crypto/cryptd.ko
> >>>>>>> make[2]: *** Waiting for unfinished jobs....
> >>>>>>> ```
> >>>>>>>
> >>>>>>>
> >>>>>>> This can be fixed with removed "INSTALL_MOD_STRIP=3D1" to the pas=
sed
> >>>>>>> parameters of module_install.
> >>>>>>>
> >>>>>>> This explicitly only happens, if a profile is passed - otherwise =
the
> >>>>>>> packaging works without problems.
> >>>>>>>
> >>>>>>> Regards,
> >>>>>>>
> >>>>>>> Peter Jung
> >>>>>>>
> >>
> >
>

