Return-Path: <linux-arch+bounces-9350-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C56AF9EADC7
	for <lists+linux-arch@lfdr.de>; Tue, 10 Dec 2024 11:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1501164B47
	for <lists+linux-arch@lfdr.de>; Tue, 10 Dec 2024 10:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2264513B59E;
	Tue, 10 Dec 2024 10:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VVtjPA6v"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D7423DE8D;
	Tue, 10 Dec 2024 10:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733825799; cv=none; b=syJ9gYZyvuvaaqGpCb4gNpSHBq5uIV1MpOLGIxqGCMTKPVJ2O7ArAsF4MZH+DQGxAYW2O4mTFZZLd+xX7VZQ0teZ1pIuby3ksJhurT5VEECjVqel8udHmShfZnZr2T6aXwuV1WALanhNcmzTl8Y1/nyY9tWf2+FpTMttK/nbjHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733825799; c=relaxed/simple;
	bh=PJBxcwLHWxsBlBqUDqEWt2vmCoyohO0Lx1XwXSatMic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FXDOtiuVuVFV4X++clz+Q7I4AlhfA+dI8mdCsNyKiCFotPylm1CdGe9xGaVZDMYM4Qu0T9P/SVwU48qoq0rVbJn/8AGBFUmOZ0h3DiVsUtMHqqPAWO5WIVNoDNZXnUyAiRybZid5QEbP27uRMBOxPiMY13wwfAibkJd5fScGLio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VVtjPA6v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A9E1C4CEE0;
	Tue, 10 Dec 2024 10:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733825798;
	bh=PJBxcwLHWxsBlBqUDqEWt2vmCoyohO0Lx1XwXSatMic=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VVtjPA6vyeS5xzZDQdkBypJ35Um9yRWQFP/iRd0+iVo5vciPuUa3ZUWS9Mn4AngYy
	 kjG0DjvHo51KPWH3cEKwwtSeNS/IFTJIWr4qPJZdarwiRx5RRx1HDD3BVOOR6VYJaa
	 0EDh5K/iatuqTX4QGG1ZfGlXz4JGPE1trgloPvERGdWqIJ8zx6Jwqb3i0bjP4UuEdc
	 R+lYIXBTEiCH0CDkFIsyuTiFZby+c4vi9wiUbSt/0k9O//DSpkTFYm37ZaJhl4rCe3
	 i/jWlWx7GwkfIkdZnmU9ClhS9v5U+c5CkE+CrJUywM6I3M6VsiQzaGKJuBwtDbsAgX
	 YCZbux4Z9DiaQ==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-300392cc4caso33209311fa.3;
        Tue, 10 Dec 2024 02:16:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV/rb/c/XYy/3mzQLr/PdwUgNMQrQ9QYNm/EKq05eMZOxo55/BxxqSln9L3k1t1rrv8yo1TxvSAyfctbeSb@vger.kernel.org, AJvYcCWKj4ehdPbr498i2otdf06/XMe10b9xSYAnNjFg+mbbXM8wxoeLjoxGHT9b9gUyBNIDmbPsP85h01Aek7rD@vger.kernel.org, AJvYcCXi2dKNz8Qhgb81PeeYlP4fqtHoRPOCb56mHq09NroZJ9B8EpEd/7xKli31gf6hOS3R8XXjrGQmfINY@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnid7P6WncYQ5EfU2VJb6Jz0p03QPPzwIGEbEksXO5PgDxocMt
	jjE9+3cShiRcosYBOGuUu5DMIwy9hGRCBd702B8dWLw3EflRWrJ+WRSbU1hGYRrOigQwFBzPucE
	4qlU0vUCQd5WvryAxh2MNxxaTL0Q=
X-Google-Smtp-Source: AGHT+IHRLmEd87XJmaKK06Eipq9n4X1mcTqwjtfXnT2h8jFaioSw0C+t+qNoFAl6uMLACCYe6hX2wnJF9A8DyKpadsc=
X-Received: by 2002:a05:651c:541:b0:302:1c90:58ec with SMTP id
 38308e7fff4ca-3022fd53cffmr15940631fa.21.1733825797258; Tue, 10 Dec 2024
 02:16:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1733404444.git.geert+renesas@glider.be> <19fb5b49396239d28020015ba2640d77dacdb6c2.1733404444.git.geert+renesas@glider.be>
 <CAK7LNARNa3NPSeRAUgMaEqWiA+C6-s1PxRe1bCUJg6zLyOtDkA@mail.gmail.com>
In-Reply-To: <CAK7LNARNa3NPSeRAUgMaEqWiA+C6-s1PxRe1bCUJg6zLyOtDkA@mail.gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 10 Dec 2024 19:16:01 +0900
X-Gmail-Original-Message-ID: <CAK7LNATmeEFK5J+PUvO4BRCPaPKy5+bsioz9F3LEYetxFSo53w@mail.gmail.com>
Message-ID: <CAK7LNATmeEFK5J+PUvO4BRCPaPKy5+bsioz9F3LEYetxFSo53w@mail.gmail.com>
Subject: Re: [PATCH 2/3] kbuild: Drop support for include/asm-<arch> in headers_check.pl
To: Geert Uytterhoeven <geert+renesas@glider.be>, Andrew Morton <akpm@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Yury Norov <yury.norov@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Andy Whitcroft <apw@canonical.com>, 
	Joe Perches <joe@perches.com>, Dwaipayan Ray <dwaipayanray1@gmail.com>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, linux-arch@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I applied this with the follow-up squashed. Thanks.
(https://lore.kernel.org/all/CAK7LNAR8dy-=3DEcsZFb-tjXSk2sK7sHrV0WSSV4E8dzR=
h5Veceg@mail.gmail.com/T/#t)

This should be dropped from Andrew Morton's tree.




On Sat, Dec 7, 2024 at 11:27=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> On Thu, Dec 5, 2024 at 10:20=E2=80=AFPM Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> >
> > "include/asm-<arch>" was replaced by "arch/<arch>/include/asm" a long
> > time ago.  All assembler header files are now included using
> > "#include <asm/*>", so there is no longer a need to rewrite paths.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
>
>
> After this commit, the second argument $arch is no longer
> used.
>
> Please clean up
>
> my ($dir, $arch, @files) =3D @ARGV;
>
>
>
>
>
>
>
> >  usr/include/headers_check.pl | 4 ----
> >  1 file changed, 4 deletions(-)
> >
> > diff --git a/usr/include/headers_check.pl b/usr/include/headers_check.p=
l
> > index b6aec5e4365f9bf2..7070c891ea294b4d 100755
> > --- a/usr/include/headers_check.pl
> > +++ b/usr/include/headers_check.pl
> > @@ -54,10 +54,6 @@ sub check_include
> >                 my $inc =3D $1;
> >                 my $found;
> >                 $found =3D stat($dir . "/" . $inc);
> > -               if (!$found) {
> > -                       $inc =3D~ s#asm/#asm-$arch/#;
> > -                       $found =3D stat($dir . "/" . $inc);
> > -               }
> >                 if (!$found) {
> >                         printf STDERR "$filename:$lineno: included file=
 '$inc' is not exported\n";
> >                         $ret =3D 1;
> > --
> > 2.34.1
> >
> >
>
>
> --
> Best Regards
> Masahiro Yamada



--
Best Regards
Masahiro Yamada

