Return-Path: <linux-arch+bounces-10603-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7946A58A41
	for <lists+linux-arch@lfdr.de>; Mon, 10 Mar 2025 03:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2E571682FF
	for <lists+linux-arch@lfdr.de>; Mon, 10 Mar 2025 02:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE8B18A6AE;
	Mon, 10 Mar 2025 02:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HR3HVoEJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411C42C9A;
	Mon, 10 Mar 2025 02:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741572818; cv=none; b=lNTj7JZTICaKdQjl+zWjnPdZ9xfxq2m3YA/m79ITK/fUzZuyzomTL7FvHKCrCf+R2LHfz1fRE/XEOyfeadG/24rOtYVoJCnmEA4imy5ntNnfttx+f8lihPmKbTI2jtIINjnRX+ca24QUbyEs/AAZrDRWLXJbILtGoDTDhVz0Hug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741572818; c=relaxed/simple;
	bh=z9mLsHw9Q3v422/Yt1W+ofnnkznofgPzm/tT/dzXn38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LEsZghhSgnhWFmkV/b0uYgKtKJsNnZtnp8MEspnQ9DyXfXhW96yNcL8hjedqcIIV1AhxbBZWZfLrpAsiLZ+gbkiCpnTGkOnO/IyRn6LnXI9cIEAWlJUBjZYYE0cBJINcMzXClmST/I+oUHHnoyG6s3S4Wbe/wrDYTtRPawmu9Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HR3HVoEJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEBEEC4CEE5;
	Mon, 10 Mar 2025 02:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741572817;
	bh=z9mLsHw9Q3v422/Yt1W+ofnnkznofgPzm/tT/dzXn38=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HR3HVoEJs8Dj3SJUQJl/9yOkY3qzYNH49NJSed8dRp+v8BKG7DmZN4jkt97KyJc0b
	 r5kJKlTVYyJPJBrKUJXCa+eJt0MrjnGYClR9q2KAzOQgc9Ixw+TUTAD8tHdCTm8INh
	 TjfexCnSzVOWUHewX3eeZTMyY6U4YkR6yRaJPRelwGTDeWt4gQxZNbDP7QntiPZnyS
	 EjZodPom+DIfeozpq4+YApfldJjutgQTSIgU9BY94Qm/1L2c6oI3wJoJC0p6IqKa2t
	 xhqNc1/CG/p1coU/y2Ckk+KrUR5B9n1JH+6a7KFXAp2X2fTaGrHg44mpj2TaUh2CrL
	 1ZnerZ2TWwT0w==
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cf58eea0fso2684815e9.0;
        Sun, 09 Mar 2025 19:13:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVROONEp0hMlSe3i0NE40E5HLbzZg3OHtIqqq27HSUz95XyBdZpt6LO3qRXfO0IPP4/GRIo1eg5smfq@vger.kernel.org, AJvYcCVcxjFJL3LNutwf9F8+zGmzpmw9KiRjrbBSUAMOSdc8CvBKJif7eV5SvTUmDWnn+j97FpiF4fNULFc5tg==@vger.kernel.org, AJvYcCXsIZJG1H3IqLFXsCKYDrOrBpFmKLirDWMLOIL7Rw2u3IeJ3bhIiSeGIr40jmMzCj7pBvuNl3npSrGGNugR@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/acw+ec21L5hkB3VVdQ+Nte2Vv9ilcdlYCltL4S1kUHZhHO5V
	3A0JOvmH7gBuR66M+zRn2ns3j91KEK4G4yvpuaaMDYoRvtB6LE2pG4z+r47sNQvXW6j+kgXr2zD
	Wtjyjnf5VVxEQi3grdUnWOBErG3U=
X-Google-Smtp-Source: AGHT+IFKsAup9e8Gc1v8ulkbmHr98edm6s87EvlcdJ5Cvko4at1GaCbqwTsdJwbMKXfm/BQUgl53lstuyy4HISvzJV0=
X-Received: by 2002:a05:600c:1d1a:b0:43c:e6d1:efe7 with SMTP id
 5b1f17b1804b1-43ce6d1f1e6mr28755625e9.26.1741572816273; Sun, 09 Mar 2025
 19:13:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224112042.60282-1-xry111@xry111.site> <91797ac4bbe27d7d60b89053050e429bcd630db3.camel@xry111.site>
In-Reply-To: <91797ac4bbe27d7d60b89053050e429bcd630db3.camel@xry111.site>
From: Guo Ren <guoren@kernel.org>
Date: Mon, 10 Mar 2025 10:13:24 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRXyMX+9C_aEDbxAsxWDD2rbnDWO775YDZ3EmrQ=QinfQ@mail.gmail.com>
X-Gm-Features: AQ5f1JpxPLjcz__aP8mbaWjnVB43tgqVJ36D7ViX6jxsCAtJ6NThRTlt4NTpaRI
Message-ID: <CAJF2gTRXyMX+9C_aEDbxAsxWDD2rbnDWO775YDZ3EmrQ=QinfQ@mail.gmail.com>
Subject: Re: Ping: [PATCH 0/3] Drop explicit --hash-style= setting for new
To: Xi Ruoyao <xry111@xry111.site>
Cc: Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Fangrui Song <i@maskray.me>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	linux-csky@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 9:27=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wrote=
:
>
> Ping.
>
> On Mon, 2025-02-24 at 19:20 +0800, Xi Ruoyao wrote:
> > For riscv, csky, and LoongArch, GNU hash had already become the de-
> > facto
> > standard when they borned, so there's no Glibc/Musl releases for them
> > without GNU hash support, and the traditional SysV hash is just
> > wasting
> > space for them.
> >
> > Remove those settings and follow the distro toolchain default, which
> > is
> > likely --hash-style=3Dgnu.  In the past it could break vDSO self tests,
> > but now the issue has been addressed by commit
> > e0746bde6f82 ("selftests/vDSO: support DT_GNU_HASH").
> >
> > Xi Ruoyao (3):
> >   riscv: vDSO: Remove --hash-style=3Dboth
The patch's comment is incorrect; when I removed --hash-style=3Dboth,
the output still contained the HASH, and no space was saved.

--hash-style=3Dboth and after the patch are the same:
Section Headers:
  [Nr] Name              Type             Address           Offset
       Size              EntSize          Flags  Link  Info  Align
  [ 0]                   NULL             0000000000000000  00000000
       0000000000000000  0000000000000000           0     0     0
  [ 1] .hash             HASH             0000000000000120  00000120
       000000000000003c  0000000000000004   A       3     0     8
  [ 2] .gnu.hash         GNU_HASH         0000000000000160  00000160
       0000000000000044  0000000000000000   A       3     0     8

But, --hash-style=3Dgnu could save space:
Section Headers:
  [Nr] Name              Type             Address           Offset
       Size              EntSize          Flags  Link  Info  Align
  [ 0]                   NULL             0000000000000000  00000000
       0000000000000000  0000000000000000           0     0     0
  [ 1] .gnu.hash         GNU_HASH         0000000000000120  00000120
       0000000000000044  0000000000000000   A       2     0     8


Here is my GCC VERSION:
Using built-in specs.
COLLECT_GCC=3D/rvhome/ren.guo/source/toolchain/rv64lp64/bin/riscv64-unknown=
-linux-gnu-gcc
COLLECT_LTO_WRAPPER=3D/rvhome/ren.guo/source/toolchain/rv64lp64/bin/../libe=
xec/gcc/riscv64-unknown-linux-gnu/13.2.0/lto-wrapper
Target: riscv64-unknown-linux-gnu
Configured with:
/home/runner/work/riscv-gnu-toolchain/riscv-gnu-toolchain/gcc/configure
--target=3Driscv64-unknown-linux-gnu --prefix=3D/opt/riscv
--with-sysroot=3D/opt/riscv/sysroot --with-pkgversion=3D
--with-system-zlib --enable-shared --enable-tls
--enable-languages=3Dc,c++,fortran --disable-libmudflap --disable-libssp
--disable-libquadmath --disable-libsanitizer --disable-nls
--disable-bootstrap --src=3D.././gcc --disable-default-pie
--disable-multilib --with-abi=3Dlp64d --with-arch=3Drv64gc
--with-tune=3Drocket --with-isa-spec=3D20191213 'CFLAGS_FOR_TARGET=3D-O2
-mcmodel=3Dmedlow' 'CXXFLAGS_FOR_TARGET=3D-O2    -mcmodel=3Dmedlow'
Thread model: posix
Supported LTO compression algorithms: zlib
gcc version 13.2.0 ()

So, do you mean "--hash-style=3Dgnu"?

> >   csky: vDSO: Remove --hash-style=3Dboth
> >   LoongArch: vDSO: Remove --hash-style=3Dsysv
> >
> >  arch/csky/kernel/vdso/Makefile  | 2 +-
> >  arch/loongarch/vdso/Makefile    | 2 +-
> >  arch/riscv/kernel/vdso/Makefile | 2 +-
> >  3 files changed, 3 insertions(+), 3 deletions(-)
> >
>
> --
> Xi Ruoyao <xry111@xry111.site>
> School of Aerospace Science and Technology, Xidian University



--=20
Best Regards
 Guo Ren

