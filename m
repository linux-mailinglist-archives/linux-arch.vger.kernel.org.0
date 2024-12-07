Return-Path: <linux-arch+bounces-9298-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F649E8044
	for <lists+linux-arch@lfdr.de>; Sat,  7 Dec 2024 15:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21A5F2820ED
	for <lists+linux-arch@lfdr.de>; Sat,  7 Dec 2024 14:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA8314830A;
	Sat,  7 Dec 2024 14:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W1H77auO"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17B91DFE1;
	Sat,  7 Dec 2024 14:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733581696; cv=none; b=dWRJ5Sox8agqffgWDU4lpq52gpCFvMbM1F8DySFBf7vZ+07hnt00abFH27M3D4+bFJjJk9ZNyIiIkrJvMco24TYCCVoTXiYqcHCVaT63jDLua3U9V0ZEUyixR6ccd9VysI9uxyEJdNVKaX0wjIyX3Q3foPUGmfv+yQEZzGLhhNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733581696; c=relaxed/simple;
	bh=SHolvLga1miCMKIAIZHFsXYxvMMr19xzHvlT2U02eE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sEjZz+3fo9YmGM1UKSUXKHBYK3KzdI256iS1lCk7p0WORrbxCFnon6uMvec/L4IYMXQIz7AsfKq12pV9Ojsuvx/a4Gex6JvuSyAPp+iqhImtORgvPF6qK5fHkewnuCsYKesV3U3OnavXTR5ydB+L41saA+zde9+vTCLL2ByIVUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W1H77auO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C65AC4AF09;
	Sat,  7 Dec 2024 14:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733581695;
	bh=SHolvLga1miCMKIAIZHFsXYxvMMr19xzHvlT2U02eE4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=W1H77auOaWNPO6RzrUr3ClVdCMIX0EsoXDDjNc9oMi8KCmYPFYIGKzYMelKAyVx2Y
	 0LFdbnFj6O4BjjKIo1KpEga10K8g0mvKFCK7kIUjfYP9XKDJU64TqrfZP3Q55S/Wvz
	 0Vwhk+2GlhbC6bkcPLdDBsGk6ZLEHIfgk502TPEOKD5itpU0wcFWtDch1jaTMcmPqP
	 kPxD4PmqGIqQJBNsgzgvDQKU12gt2jpLhWcs8XKXtsAfmYKMfgC5V9iX3R9q4tF4B9
	 maWRRHAio7hsAb4CeRxDazGhwUnu1zsPStzTpAHCwBd1dNPUMTmvpFuCzci+V9HsXV
	 J/AEaQAJXmDcA==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53dd668c5easo3176290e87.1;
        Sat, 07 Dec 2024 06:28:15 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUMIIOsi1uL+MqMCtjO6n95oVIaybNSm6GnoSxtkwtaCJBAdy/fEQ/k3Aeg5WyidgRrY3fY5QEz81nqrcTS@vger.kernel.org, AJvYcCV3ZrmBznU9mR7S3FPLVUlgLek495Cm3zwtaOr3G+wZYX8N2mzjuRtt+UqBuSpX871H4Q4ss4QQxbCgO9re@vger.kernel.org, AJvYcCX6x86HVxyGeHsXgn7wsV2pWd2kD/yyiLw2sPciyvi3a4RITmLJAb0sfZ6qmNkFxN4hAWm6/WxZXl2X@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2NSAZ0P0Hf8ZjWexSe78Y93Ac/qevVri6LVPlcRmJmuAuinlc
	X4k0jkB+SxKllEZcsvdg6jGdW/obhyBczRgXxuZSkYOk/wO83lxImWU0sxFY+UJyIUFXnvnvGSF
	cLLNbAdIUjTcHwYrjtX5E45nmCrs=
X-Google-Smtp-Source: AGHT+IHLRrUNfq+FvHO59Y30yFgCbmvfWRtTwUDqCjstUrNYaLmALf65FS1TjPnd8oG/qwD52zD7U+Vby+0gkmLPb/g=
X-Received: by 2002:a05:6512:10c5:b0:53e:12f2:461c with SMTP id
 2adb3069b0e04-53e2b7328cemr2433889e87.20.1733581694286; Sat, 07 Dec 2024
 06:28:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1733404444.git.geert+renesas@glider.be> <19fb5b49396239d28020015ba2640d77dacdb6c2.1733404444.git.geert+renesas@glider.be>
In-Reply-To: <19fb5b49396239d28020015ba2640d77dacdb6c2.1733404444.git.geert+renesas@glider.be>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sat, 7 Dec 2024 23:27:38 +0900
X-Gmail-Original-Message-ID: <CAK7LNARNa3NPSeRAUgMaEqWiA+C6-s1PxRe1bCUJg6zLyOtDkA@mail.gmail.com>
Message-ID: <CAK7LNARNa3NPSeRAUgMaEqWiA+C6-s1PxRe1bCUJg6zLyOtDkA@mail.gmail.com>
Subject: Re: [PATCH 2/3] kbuild: Drop support for include/asm-<arch> in headers_check.pl
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Yury Norov <yury.norov@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Andy Whitcroft <apw@canonical.com>, 
	Joe Perches <joe@perches.com>, Dwaipayan Ray <dwaipayanray1@gmail.com>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, linux-arch@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 10:20=E2=80=AFPM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> "include/asm-<arch>" was replaced by "arch/<arch>/include/asm" a long
> time ago.  All assembler header files are now included using
> "#include <asm/*>", so there is no longer a need to rewrite paths.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---


After this commit, the second argument $arch is no longer
used.

Please clean up

my ($dir, $arch, @files) =3D @ARGV;







>  usr/include/headers_check.pl | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/usr/include/headers_check.pl b/usr/include/headers_check.pl
> index b6aec5e4365f9bf2..7070c891ea294b4d 100755
> --- a/usr/include/headers_check.pl
> +++ b/usr/include/headers_check.pl
> @@ -54,10 +54,6 @@ sub check_include
>                 my $inc =3D $1;
>                 my $found;
>                 $found =3D stat($dir . "/" . $inc);
> -               if (!$found) {
> -                       $inc =3D~ s#asm/#asm-$arch/#;
> -                       $found =3D stat($dir . "/" . $inc);
> -               }
>                 if (!$found) {
>                         printf STDERR "$filename:$lineno: included file '=
$inc' is not exported\n";
>                         $ret =3D 1;
> --
> 2.34.1
>
>


--=20
Best Regards
Masahiro Yamada

