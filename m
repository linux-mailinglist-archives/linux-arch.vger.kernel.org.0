Return-Path: <linux-arch+bounces-8086-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A5E99CD96
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 16:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F52928131E
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 14:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5231ABEC1;
	Mon, 14 Oct 2024 14:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="LHAn4QAG"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C643D14A614
	for <linux-arch@vger.kernel.org>; Mon, 14 Oct 2024 14:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728916444; cv=none; b=C4twGdYaOSZJoTE4NdWYLCahjNrmtjsPXfll9NHw9terRItZM5vFbW1J6WpiDTTs44GrICJbMhNYUa5CG5r2uUOaC1FRxx5WyjKEvRdzVCDHPLq507ZNPP+aABJ1p9U6ixqiv8Gb4D8BsSqlq+/bfK+AEVG+xVDkwfpEL6sB45M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728916444; c=relaxed/simple;
	bh=3OxyjW6caETvvuftipAto/JP5HGaH56ZmiLo8YxjIgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nafc5ukJGPOcQhd6mXF+BNSy3SWTfxBKdHFFZYM565y52kbaIXgFFapuhDr2S/DFcumRaPcKzLdNDs6gtNGxhHFdxJAcMzo7jwclUUUdaIc8AyN/NOrCpgpbaR+en4QqOFi5X5kwmnWR7Ok/i+amU4qSlOo1q9/VPkaUrP0Byp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=LHAn4QAG; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-8353fd2cb2dso218134439f.2
        for <linux-arch@vger.kernel.org>; Mon, 14 Oct 2024 07:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1728916442; x=1729521242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BZFiFSV2S6ephEEXxaRsM/YTIpGDjHwKVrQbLRq0m74=;
        b=LHAn4QAGSll1eE/HMgAwesfDfZ68OE/RRaEsD53z96UgS329eLqZavLF1uk2z1t8BA
         O4pMhWYXEPf8inAMuGPmlnDm157PkFemJaWjMqRtilnfLSIn/OzLcKZctoHOYlO8PFq/
         5QF/kby6lWI0nyQIlGomPaPX2B4YcQOsyUwgrq6mYrwlRa+p+7At3UpL1iwajhC2Q3I/
         rADy7FvjGp2/+XMC9Exm/izwIMaQYy1c76iLwb1vMDg9A2u5YpNmcI9gW2jfCqsF1wRL
         SkjpYV7rnAdK6r/2lVMlrBB/xVx3Nmex1nOmOwVZN4nbkteh/enZoY1GnftzlyFoTijk
         Gzbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728916442; x=1729521242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BZFiFSV2S6ephEEXxaRsM/YTIpGDjHwKVrQbLRq0m74=;
        b=a0eES7+wdO343ninVzAYJnnkfnMiIgy5VaYQyIt/PQ1rQc5FIZlhisVxEfFLUiJS5F
         1G3rAoZZnONHaG189EYllNeU213BvveBubAJdSNBLbU/mWFW9bI3VsI8NtKjEeido8EU
         nCR/BWTSuYKPOP07SB5hQn93yRNVRVThJ4izxeHG6+A5bh025K2F/sCAISgF4KnuiKK3
         0jcPRti8U1OD2bPC7Ci2ZVtkDMO2be3yFtaRJ+zZ7KOC3U4E+FMARwtLZwmg5vc1900h
         yqK2Jek0MX1T42FoCCH5aZeFdl+nqvW3mK6MzpeSd3WDSVB4fgSdPR1Ra45vYk+cmosb
         BY6A==
X-Forwarded-Encrypted: i=1; AJvYcCUdcG3TjhqyySIl/ym7IIvVs4psHEtW4rRSb3wa1cgsUlXOJhcdtsgxyeUbwBnLbx/GtoQKUM0iSvFQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzP7JjrYyCci/OuUZZN0kZDN3Xu85oRWpHGoeif2/oAmH5X0Dmt
	YR2zF8MKQe0n1yOuUPBi51sFuZCR6k4dztrCftJlnh0A4/e7L0GKbQp9VJTemjhnXhKt4n98MXg
	pA/p2BUgGbLOo3mJZl3bBPivKqLDDpnLf1GI60g==
X-Google-Smtp-Source: AGHT+IFYJowFNk6TiJAeIlJ6VE4pS1HwOZ1J0S0O0mVVAaMh1gyG2y64c+9AiCOVdFTYNqR+gnZqJMfVyAe4szQJ6+M=
X-Received: by 2002:a05:6602:3f91:b0:837:7e21:1677 with SMTP id
 ca18e2360f4ac-837929fd68fmr950720739f.4.1728916441860; Mon, 14 Oct 2024
 07:34:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008-v5_user_cfi_series-v6-0-60d9fe073f37@rivosinc.com>
 <20241008-v5_user_cfi_series-v6-33-60d9fe073f37@rivosinc.com>
 <CANXhq0pXVS2s-hZNusPLoQ4qPkyi1S2BTQ-FyAvcz=cDctKQng@mail.gmail.com>
 <Zwj7aZj36TBGzpZa@finisterre.sirena.org.uk> <CANXhq0q49k6q3ZGYqzczMeFr+_rrfa9mL7FMu62xPHeUKfvhMw@mail.gmail.com>
 <ZwmAdRb5BRkPLbWg@debug.ba.rivosinc.com>
In-Reply-To: <ZwmAdRb5BRkPLbWg@debug.ba.rivosinc.com>
From: Zong Li <zong.li@sifive.com>
Date: Mon, 14 Oct 2024 22:33:50 +0800
Message-ID: <CANXhq0rH_07JRGbBnMTntPxhOQcXzxrcRJ0WAN7T6oQX7DaNoQ@mail.gmail.com>
Subject: Re: [PATCH v6 33/33] kselftest/riscv: kselftest for user mode cfi
To: Deepak Gupta <debug@rivosinc.com>
Cc: Mark Brown <broonie@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Brauner <brauner@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Oleg Nesterov <oleg@redhat.com>, Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, alistair.francis@wdc.com, 
	richard.henderson@linaro.org, jim.shu@sifive.com, andybnac@gmail.com, 
	kito.cheng@sifive.com, charlie@rivosinc.com, atishp@rivosinc.com, 
	evan@rivosinc.com, cleger@rivosinc.com, alexghiti@rivosinc.com, 
	samitolvanen@google.com, rick.p.edgecombe@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 12, 2024 at 3:46=E2=80=AFAM Deepak Gupta <debug@rivosinc.com> w=
rote:
>
> On Fri, Oct 11, 2024 at 07:43:30PM +0800, Zong Li wrote:
> >On Fri, Oct 11, 2024 at 6:18=E2=80=AFPM Mark Brown <broonie@kernel.org> =
wrote:
> >>
> >> On Fri, Oct 11, 2024 at 01:44:55PM +0800, Zong Li wrote:
> >> > On Wed, Oct 9, 2024 at 7:46=E2=80=AFAM Deepak Gupta <debug@rivosinc.=
com> wrote:
> >>
> >> > > +       if (si->si_code =3D=3D SEGV_CPERR) {
> >>
> >> > Hi Deepak,
> >> > I got some errors when building this test, I suppose they should be
> >> > fixed in the next version.
> >>
> >> > riscv_cfi_test.c: In function 'sigsegv_handler':
> >> > riscv_cfi_test.c:17:28: error: 'SEGV_CPERR' undeclared (first use in
> >> > this function); did you mean 'SEGV_ACCERR'?
> >> >    17 |         if (si->si_code =3D=3D SEGV_CPERR) {
> >> >       |                            ^~~~~~~~~~
> >> >       |                            SEGV_ACCERR
> >> >
> >>
> >> Did you run "make headers_install" prior to building kselftest to get
> >> the current kernel's headers available for userspace builds?
> >
> >Yes, I have run "make header" and "make header_install" before
> >building the kselftest. This error happens when I cross compiled it,
> >perhaps I can help to check if it is missing some header files or
> >header search path.
>
> That's wierd.
>
> It doesn't fail for me even if I do not do `make headers_install`. But I =
am
> building kernel and selftests with toolchain which supports shadow stack =
and
> landing pad. It's defined in `siginfo.h`. When I built toolchain, I did p=
oint
> it at the latest kernel headers. May be that's the trick.
>
> """
>
> $ grep -nir SEGV_CPERR /scratch/debug/linux/kbuild/usr/include/*
> /scratch/debug/linux/kbuild/usr/include/asm-generic/siginfo.h:240:#define=
 SEGV_CPERR    10      /* Control protection fault */
>
> $ grep -nir SEGV_CPERR /scratch/debug/open_src/sifive_cfi_toolchain/INSTA=
LL_Sept18/sysroot/usr/*
> /scratch/debug/open_src/sifive_cfi_toolchain/INSTALL_Sept18/sysroot/usr/i=
nclude/asm-generic/siginfo.h:240:#define SEGV_CPERR    10      /* Control p=
rotection fault */
> /scratch/debug/open_src/sifive_cfi_toolchain/INSTALL_Sept18/sysroot/usr/i=
nclude/bits/siginfo-consts.h:139:  SEGV_CPERR                  /* Control p=
rotection fault.  */
> /scratch/debug/open_src/sifive_cfi_toolchain/INSTALL_Sept18/sysroot/usr/i=
nclude/bits/siginfo-consts.h:140:#  define SEGV_CPERR  SEGV_CPERR
>
> """

In my case, because the test files don't explicitly include siginfo.h,
I assume it's expected that siginfo.h will be included through
signal.h. Regarding the header search path, it will eventually locate
signal.h in toolchain_path/sysroot/usr/include/. In my
toolchain_path/sysroot/usr/include/signal.h, it doesn't include any
signal.h; instead, signal.h will be included from
toolchain_path/sysroot/usr/include/linux/signal.h or
kernel_src/usr/include/linux/signal.h rather than
toolchain/sysroot/usr/include/signal.h. I think that is why I lost the
SEGV_CPERR definition. Is there any difference with you?

>

