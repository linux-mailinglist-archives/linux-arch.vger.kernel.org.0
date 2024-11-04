Return-Path: <linux-arch+bounces-8845-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9419BBEC1
	for <lists+linux-arch@lfdr.de>; Mon,  4 Nov 2024 21:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50A861F219B6
	for <lists+linux-arch@lfdr.de>; Mon,  4 Nov 2024 20:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517E11C876D;
	Mon,  4 Nov 2024 20:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L4WxrH0u"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA4D1E47BC
	for <linux-arch@vger.kernel.org>; Mon,  4 Nov 2024 20:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730751889; cv=none; b=C2OMLJefc/08I0bof1N0BkLkXtDGxRpuCWdZO+4wTzFl2r+NQJ7UOwhysiXdGolzn5vYAVDmehL+uZ4tbAhO8sHtj9QA2ESUilz1veSfM0CWT0P0Bip7OoNGhtAXjF3sgKY/yZvZ2x1B3xc2790EJbGJnSlUwI6t0QkFB+m+95o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730751889; c=relaxed/simple;
	bh=67y70xaii5XM8g7k6nlqO2Sz7xsbmRTKi3nk9lApgZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NI5RaEDGoQv2MdpFu0FXdewAM3HBMwO5PtAjUO7Own/3+fmcpgyHDJOOvwHCq/MW8BTdJ359Mr1XLW+SdUB33CGnvL9xC4M7BTcwgK69mAJ/tFgyJ+aReyVib1lwoyCAs7bn2rtKOI3GJc6OjiDbKs/8jZeThICnnQUme3Pi/U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L4WxrH0u; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7b15467f383so339234785a.3
        for <linux-arch@vger.kernel.org>; Mon, 04 Nov 2024 12:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730751885; x=1731356685; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pMAD4dMvrggttxV8M69ZLvHtnrpB33PuIkwveI53NKI=;
        b=L4WxrH0uZhubZfi6BY9kROcKxdJD1fi+NeGQ/lyRT17PpLldrqe59R0aivGfmsyRIk
         YV3vtC4X90oh4sXn5llGV14QH6DyDr3ljEVl0Tuz2+tPnzxFGP4VGetC2EDJg17r2n7P
         O3Ju9grbe06+r2av0tONNsNQGzMSE/2hbQeGddTehw+V8NDuUhaYbIQGfVblUUA8vTIf
         AO8Njcwn9uwMl0i7zSYc2pONYKOQOuOJQ7QI7rup1buJn/TXF/PlZ/dk5qxstKvI6pSr
         yiF7BI/b/ZammF6rtl4mOKeIzQcsrTu68MHP0qKyMmWeS8SGKwYe8V/5/6VPdrzeraXw
         xdoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730751885; x=1731356685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pMAD4dMvrggttxV8M69ZLvHtnrpB33PuIkwveI53NKI=;
        b=si+t/nsRlKeIxK9K1V56UxH3jaZzYs5o6xkr+1hcu3mLnDHFpIpiK8CBBU9UKo82uu
         vng2CLT2hD11A1jmQgLQmtMzsbELEJi9peI7AALO6t9f3GjGUtqOdelyC7/uEs9nMBu4
         ZhN0RCwapZdrZZWjcq4f+epAEoL2emw3IgGXrYTir4F6Sfn4MeQMi2qYvwVZhU0kiQpL
         sWRSKPRG70QAMyUpsWDp2ygHaaK1UpeWQaL+ZQZmxxOermAu3nbsJuuUvcsiX1GyzI+8
         rIJa+mTY1nLI9Z8yrSFJ7CV2Wsx+mmQLluKUBj5XoqCTh5DLJb28Awkdt/4WqiMUUWEn
         e1YA==
X-Forwarded-Encrypted: i=1; AJvYcCVYN9VyP5OGAbV5fPWzYji25YQuGm1PdDH56bJwV3q+HkZgAG23YR+j5EadQf7R5Adz9nmX/nuhuiUP@vger.kernel.org
X-Gm-Message-State: AOJu0YwpTVbiFfq29PF4rAZL3/2GbSoXLfZ1u63uMPMmr20DO0kUSSDC
	KO6j90ef0kMQhvJp3d0UsYOe6ZK9bWAh3zD94aGoScoRGXYN+LNDEqUFihWPE+b0FOi/bVq0ynP
	KupvPou71vuij3bxZg5AOXYS/K+Fake4j7CKL
X-Google-Smtp-Source: AGHT+IHYwEpMyGlK9DOHyJMnwe42enHazr4mglbcxXxObxPF+Ii3w3TsZ72VmrnN6P90z6NOVOpNUA9yHGlz3tNrg7Q=
X-Received: by 2002:a05:6214:390c:b0:6cb:aa7b:b8cc with SMTP id
 6a1803df08f44-6d351aa3f45mr211213366d6.16.1730751884546; Mon, 04 Nov 2024
 12:24:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241102175115.1769468-1-xur@google.com> <20241102175115.1769468-2-xur@google.com>
 <09349180-027a-4b29-a40c-9dc3425e592c@cachyos.org> <3183ab86-8f1f-4624-9175-31e77d773699@cachyos.org>
 <CACkGtrgOw8inYCD96ot_w9VwzoFvvgCReAx0P-=Rxxqj2FT4_A@mail.gmail.com> <67c07d2f-fb1f-4b7d-96e2-fb5ceb8fc692@cachyos.org>
In-Reply-To: <67c07d2f-fb1f-4b7d-96e2-fb5ceb8fc692@cachyos.org>
From: Han Shen <shenhan@google.com>
Date: Mon, 4 Nov 2024 12:24:29 -0800
Message-ID: <CACkGtrgJHtG5pXR1z=6G4XR6ffT5jEi3jZQo=UhYj091naBhsA@mail.gmail.com>
Subject: Re: [PATCH v7 1/7] Add AutoFDO support for Clang build
To: Peter Jung <ptr1337@cachyos.org>
Cc: Rong Xu <xur@google.com>, Alice Ryhl <aliceryhl@google.com>, 
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

Hi Peter,
Thanks for providing the detailed reproduce.
Now I can see the error (after I synced to 6.12.0-rc6, I was using rc5).
I'll look into that and report back.

> I have tested your provided method, but the AutoFDO profile (lld does
not get lto-sample-profile=3D$pathtoprofile passed)

I see. You also turned on ThinLTO, which I didn't, so the profile was
only used during compilation, not passed to lld.

Thanks,
Han

On Mon, Nov 4, 2024 at 9:31=E2=80=AFAM Peter Jung <ptr1337@cachyos.org> wro=
te:
>
> Hi Han,
>
> I have tested your provided method, but the AutoFDO profile (lld does
> not get lto-sample-profile=3D$pathtoprofile passed)  nor Clang as compile=
r
> gets used.
> Please replace following PKGBUILD and config from linux-mainline with
> the provided one in the gist. The patch is also included there.
>
> https://gist.github.com/ptr1337/c92728bb273f7dbc2817db75eedec9ed
>
> The main change I am doing here, is passing following to the build array
> and replacing "make all":
>
> make LLVM=3D1 LLVM_IAS=3D1 CLANG_AUTOFDO_PROFILE=3D${srcdir}/perf.afdo al=
l
>
> When compiling the kernel with makepkg, this results at the packaging to
> following issue and can be reliable reproduced.
>
> Regards,
>
> Peter
>
>
> On 04.11.24 05:50, Han Shen wrote:
> > Hi Peter, thanks for reporting the issue. I am trying to reproduce it
> > in the up-to-date archlinux environment. Below is what I have:
> >    0. pacman -Syu
> >    1. cloned archlinux build files from
> > https://aur.archlinux.org/linux-mainline.git the newest mainline
> > version is 6.12rc5-1.
> >    2. changed the PKGBUILD file to include the patches series
> >    3. changed the "config" to turn on clang autofdo
> >    4. collected afdo profiles
> >    5. MAKEFLAGS=3D"-j48 V=3D1 LLVM=3D1 CLANG_AUTOFDO_PROFILE=3D$(pwd)/p=
erf.afdo" \
> >          makepkg -s --skipinteg --skippgp
> >    6. install and reboot
> > The above steps succeeded.
> > You mentioned the error happens at "module_install", can you instruct
> > me how to execute the "module_install" step?
> >
> > Thanks,
> > Han
> >
> > On Sat, Nov 2, 2024 at 12:53=E2=80=AFPM Peter Jung<ptr1337@cachyos.org>=
 wrote:
> >>
> >>
> >> On 02.11.24 20:46, Peter Jung wrote:
> >>>
> >>> On 02.11.24 18:51, Rong Xu wrote:
> >>>> Add the build support for using Clang's AutoFDO. Building the kernel
> >>>> with AutoFDO does not reduce the optimization level from the
> >>>> compiler. AutoFDO uses hardware sampling to gather information about
> >>>> the frequency of execution of different code paths within a binary.
> >>>> This information is then used to guide the compiler's optimization
> >>>> decisions, resulting in a more efficient binary. Experiments
> >>>> showed that the kernel can improve up to 10% in latency.
> >>>>
> >>>> The support requires a Clang compiler after LLVM 17. This submission
> >>>> is limited to x86 platforms that support PMU features like LBR on
> >>>> Intel machines and AMD Zen3 BRS. Support for SPE on ARM 1,
> >>>>    and BRBE on ARM 1 is part of planned future work.
> >>>>
> >>>> Here is an example workflow for AutoFDO kernel:
> >>>>
> >>>> 1) Build the kernel on the host machine with LLVM enabled, for examp=
le,
> >>>>          $ make menuconfig LLVM=3D1
> >>>>       Turn on AutoFDO build config:
> >>>>         CONFIG_AUTOFDO_CLANG=3Dy
> >>>>       With a configuration that has LLVM enabled, use the following
> >>>>       command:
> >>>>          scripts/config -e AUTOFDO_CLANG
> >>>>       After getting the config, build with
> >>>>         $ make LLVM=3D1
> >>>>
> >>>> 2) Install the kernel on the test machine.
> >>>>
> >>>> 3) Run the load tests. The '-c' option in perf specifies the sample
> >>>>      event period. We suggest     using a suitable prime number,
> >>>>      like 500009, for this purpose.
> >>>>      For Intel platforms:
> >>>>         $ perf record -e BR_INST_RETIRED.NEAR_TAKEN:k -a -N -b -c
> >>>> <count> \
> >>>>           -o <perf_file> -- <loadtest>
> >>>>      For AMD platforms:
> >>>>         The supported system are: Zen3 with BRS, or Zen4 with amd_lb=
r_v2
> >>>>        For Zen3:
> >>>>         $ cat proc/cpuinfo | grep " brs"
> >>>>         For Zen4:
> >>>>         $ cat proc/cpuinfo | grep amd_lbr_v2
> >>>>         $ perf record --pfm-events RETIRED_TAKEN_BRANCH_INSTRUCTIONS=
:k
> >>>> -a \
> >>>>           -N -b -c <count> -o <perf_file> -- <loadtest>
> >>>>
> >>>> 4) (Optional) Download the raw perf file to the host machine.
> >>>>
> >>>> 5) To generate an AutoFDO profile, two offline tools are available:
> >>>>      create_llvm_prof and llvm_profgen. The create_llvm_prof tool is=
 part
> >>>>      of the AutoFDO project and can be found on GitHub
> >>>>      (https://github.com/google/autofdo), version v0.30.1 or later. =
The
> >>>>      llvm_profgen tool is included in the LLVM compiler itself. It's
> >>>>      important to note that the version of llvm_profgen doesn't need=
 to
> >>>>      match the version of Clang. It needs to be the LLVM 19 release =
or
> >>>>      later, or from the LLVM trunk.
> >>>>         $ llvm-profgen --kernel --binary=3D<vmlinux> --
> >>>> perfdata=3D<perf_file> \
> >>>>           -o <profile_file>
> >>>>      or
> >>>>         $ create_llvm_prof --binary=3D<vmlinux> --profile=3D<perf_fi=
le> \
> >>>>           --format=3Dextbinary --out=3D<profile_file>
> >>>>
> >>>>      Note that multiple AutoFDO profile files can be merged into one=
 via:
> >>>>         $ llvm-profdata merge -o <profile_file>  <profile_1> ...
> >>>> <profile_n>
> >>>>
> >>>> 6) Rebuild the kernel using the AutoFDO profile file with the same c=
onfig
> >>>>      as step 1, (Note CONFIG_AUTOFDO_CLANG needs to be enabled):
> >>>>         $ make LLVM=3D1 CLANG_AUTOFDO_PROFILE=3D<profile_file>
> >>>>
> >>>> Co-developed-by: Han Shen<shenhan@google.com>
> >>>> Signed-off-by: Han Shen<shenhan@google.com>
> >>>> Signed-off-by: Rong Xu<xur@google.com>
> >>>> Suggested-by: Sriraman Tallam<tmsriram@google.com>
> >>>> Suggested-by: Krzysztof Pszeniczny<kpszeniczny@google.com>
> >>>> Suggested-by: Nick Desaulniers<ndesaulniers@google.com>
> >>>> Suggested-by: Stephane Eranian<eranian@google.com>
> >>>> Tested-by: Yonghong Song<yonghong.song@linux.dev>
> >>>> Tested-by: Yabin Cui<yabinc@google.com>
> >>>> Tested-by: Nathan Chancellor<nathan@kernel.org>
> >>>> Reviewed-by: Kees Cook<kees@kernel.org>
> >>> Tested-by: Peter Jung<ptr1337@cachyos.org>
> >>>
> >> The compilations and testing with the "make pacman-pkg" function from
> >> the kernel worked fine.
> >>
> >> One problem I do face:
> >> When I apply a AutoFDO profile together with the PKGBUILD [1] from
> >> archlinux im running into issues at "module_install" at the packaging.
> >>
> >> See following log:
> >> ```
> >> make[2]: *** [scripts/Makefile.modinst:125:
> >> /tmp/makepkg/linux-cachyos-rc-autofdo/pkg/linux-cachyos-rc-autofdo/usr=
/lib/modules/6.12.0-rc5-5-cachyos-rc-autofdo/kernel/arch/x86/kvm/kvm.ko]
> >> Error 1
> >> make[2]: *** Deleting file
> >> '/tmp/makepkg/linux-cachyos-rc-autofdo/pkg/linux-cachyos-rc-autofdo/us=
r/lib/modules/6.12.0-rc5-5-cachyos-rc-autofdo/kernel/arch/x86/kvm/kvm.ko'
> >>     INSTALL
> >> /tmp/makepkg/linux-cachyos-rc-autofdo/pkg/linux-cachyos-rc-autofdo/usr=
/lib/modules/6.12.0-rc5-5-cachyos-rc-autofdo/kernel/crypto/cryptd.ko
> >> make[2]: *** Waiting for unfinished jobs....
> >> ```
> >>
> >>
> >> This can be fixed with removed "INSTALL_MOD_STRIP=3D1" to the passed
> >> parameters of module_install.
> >>
> >> This explicitly only happens, if a profile is passed - otherwise the
> >> packaging works without problems.
> >>
> >> Regards,
> >>
> >> Peter Jung
> >>
>

