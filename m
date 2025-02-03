Return-Path: <linux-arch+bounces-9971-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDEFA25A80
	for <lists+linux-arch@lfdr.de>; Mon,  3 Feb 2025 14:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2B9118873D7
	for <lists+linux-arch@lfdr.de>; Mon,  3 Feb 2025 13:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDB8204F63;
	Mon,  3 Feb 2025 13:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="LppzQA80"
X-Original-To: linux-arch@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5287204C39;
	Mon,  3 Feb 2025 13:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738588503; cv=none; b=gcn4OO6sIbpsKOTt2VTtv4MAImfpD/w4yMv1mofsxpS0HrbgKu088j2iXXotnrKcMRq8dGsmaZJU4rfdB3WNBDACYsFEUyMDQ78T7lfa5lXl1v82p+Ayhh+uashB3XnYeWKCO7umJD3+zRgA6rgsokAM/EwhexbpkdFUyQc0xJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738588503; c=relaxed/simple;
	bh=AE1GNI4dCnKiSpYJEGzMAZPeqcrJkHOL3Nw8EWbZIW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uzeeovLWMT1Q1vmRLxVJUx9JPbauZjnZO6/q3oZ3Lu0LuInVIzn7cMSzCBNUeQDQqVTUk0OiOf1BYriWPY59r2hJyf+MxR8zVRdt7R+2Tm72VA9ft9zNZOi9f9F8TlrgtoCS/3BRYwFx3l6kird0jqec0ipQEnGAHcVc4F+0aCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=LppzQA80; arc=none smtp.client-ip=217.72.192.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1738588486; x=1739193286; i=christian@heusel.eu;
	bh=HW/nhA7rOLlZN/zmthKgpqOHoSWN2U6+fDDzCTddEJw=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=LppzQA802y5aZz9FYytlu7pwxMQDYgmSpzfYXSp51a9i15cF39uXd1v0O3d+I2DF
	 nDwb9houPen/p1zCAppZUIq5wdDnRI8MDQkmqjyNDprMgPjpPbmcQfUOzDQRmYTNM
	 u8/5d4AD3YjYdCoki8N8fnWlxycPSqJAkED9OSn7W21HCRlaffMU27VtDPYU853NV
	 O/jIHS8LUaEVo65lTmw7gMpOnxUVdcCgaHyXsBE6ZFN3aPptUQT7bAPUZMlN2swtO
	 vUpssc+kN+K2jpM84TJvY81pXJWb6P6HkDxUJfvFxt8Fd6kXEYLe/0043bZhHdakt
	 uO4/1MFw4Z76E/hiiA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([80.187.122.235]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MoNu2-1t3St32XHc-00gLz3; Mon, 03 Feb 2025 14:14:45 +0100
Date: Mon, 3 Feb 2025 14:14:41 +0100
From: Christian Heusel <christian@heusel.eu>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Daniel Gomez <da.gomez@samsung.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Jonathan Corbet <corbet@lwn.net>, Fabian =?utf-8?Q?Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>, 
	Arnout Engelen <arnout@bzzt.net>, Mattia Rizzolo <mattia@mapreri.org>, 
	kpcyrd <kpcyrd@archlinux.org>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2 0/6] module: Introduce hash-based integrity checking
Message-ID: <62c93d58-2e27-4304-a6ad-36aa932f18ac@heusel.eu>
References: <20250120-module-hashes-v2-0-ba1184e27b7f@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4hw4xsdogt6jxe7z"
Content-Disposition: inline
In-Reply-To: <20250120-module-hashes-v2-0-ba1184e27b7f@weissschuh.net>
X-Provags-ID: V03:K1:pi4w6UvELjOYlWx7bJXU+/MmGORjxYJ29ngsxP99C0aV5nQ3ul1
 50dRrVBGRzy382VjDqjmmj8CaowbFOxH6DRu/k4gDMUunGQRyvqTJFVqMabGxL8+TSojaD+
 D5zgrN7RkpgcTuwaqWPZsmZPmtWRMPC+TynSjMjsU57e9Ve1YGGzesZTL0TA1sY8pQaJDPj
 +LnrtY5KXjyOSqIHK3xUQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MXtMipq4Kd4=;s7t6p8NLj9eAy9+INYP4yrDREcn
 mAWRrWEOBfYn4sK814eCwCN7T5urJ+ejs/Oy+IxU60xC1bLGsM3kFHQcWBiJz7gUkz7JGrKbw
 Z91+1BGDEYrOY/tQYmYBOLNB+2+BPO5ImG8WtGBknV7Ag+NHIs788e6PzchIEEXJozfUE/dzX
 0WfbkO0FibPwXv0YqjVZ0EvgkgeBbcO/WKIq3rIYCITfInXyCl3h6e1gKfH55fBpVwzs5tI4/
 C55A+NhSqKAeoTJB3+ts3DAzjMX7bP7v/PhcigUQ2EuDdeqIkKhO4xC/A4eMw75K8otX06HmD
 0Wsq+kBc4SNRgXH0cMHxCFC7AzrH4VqGgTuOdvazW69g50x7qtMxQZrtlhqf8yasQ9UpwAwCL
 8fuUCcuPnVfKN7rfnEt5l8CEqVDSpgsGxlQXzK0KTX1xFmgdJ+bE8ueFZHrue9PeeYqsmPsPL
 BB8dv28sMSsUxN9P/Uos9YfSfw6Je7AY/uFHHkRDjV5BFsyOcp0auJB7fk+L9nk83LFFSlEFh
 DjwutzRJiIT0XbRCo1fcwe2JSiNoKNi4s/iDqhRwa0KjpLIKeFn8wNmhnipTsWW4PGnFtfoVI
 Lm3JVfMRZXyyCX4HxGpyDxSQqwm4yFGxCTLUAPRtIrmSjv3pZcL53MsEFoCeDZBnsC9VyDuFS
 hFt0+GvzASuQdrLEYuoMaGrgwBGHthR32jRN9HMEvbtV/XIN39q6IIlRZ3TRVnoBnoqh6u1Fj
 viIvrVLt/SiNzqiYfVrMNaQoKooh2YrCMXG5Iu4q7zb4Pmjgf54bnUumMeSbqioNLqCstZG9o
 200sSd6RHny+UC9RkBl4Jm5990Ea/Wq1EaOFMJ1t7mT7bgEAiJSk++Lng1r+7UamgVXlV3XYu
 6pC4eOPSR272a99fpgvxznwhETRs5/fl//8Pp/ysx7caqC/keVlsH8dEkh1aqUrMglRIGgvSl
 RqTD7dfBkEr864/2UvpSrTNybyGRTPTUzI+Fjpclb3Wo0kUMKHdglQAsFhWtmhVmkB7eEtTxA
 LkuUlOcWisrg3vtBlcMxnb632UOl6IGIpHrjarOG1t5swqONa21oEcLXtnMP8qhVknssH0/fw
 sYrQZ2lW50PdTi8547UqqAxc6mVVTv5zBYxt+5fWYNOdYgTl1pltlClsLSMbkTHMmMhQnA/Q6
 3beOMFy52JOYX43X5O6qFcc5ZM+PenSI4LL9T4Oosc7Z0pfiMjqtfhyJhcg0KDSMPPtElZ+Z5
 3bMNKvZCQh2IsVih3WS3VTHkXN+Hh3sykuyCJOvbdH/wehCqCReBDxI=


--4hw4xsdogt6jxe7z
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 0/6] module: Introduce hash-based integrity checking
MIME-Version: 1.0

Hey Thomas,

On 25/01/20 06:44PM, Thomas Wei=DFschuh wrote:
> Thomas Wei=DFschuh (6):
>       kbuild: add stamp file for vmlinux BTF data
>       module: Make module loading policy usable without MODULE_SIG
>       module: Move integrity checks into dedicated function
>       module: Move lockdown check into generic module loader
>       lockdown: Make the relationship to MODULE_SIG a dependency
>       module: Introduce hash-based integrity checking

thanks for working on this!

I had a look at this patch series together with kpcyrd over the weekend
and we were able to verify that this indeed allows one to get a
reproducible kernel image with the toolchain on Arch Linux (if the patch
you mentioned in your cover letter is also applied), which is of course
great news! :)

We also found a major issues with it, as adding it on top of the v6.13
kernel and setting the needed config options while removing modules
signatures made the kernel unable to load any module while also not
printing any error for the failure, therefore resulting in an early boot
failure on my machine.

Do you have any clue what could be going wrong here or what we could
investigate? I have pushed my build config into [this repository][0] and
also uploaded a prebuilt version (signed with my packager key)
[here][1] (you can therefore just install it via "sudo pacman -U
<link>").

Happy to test more stuff, feel free to CC me on any further revision /
thread on this!

Cheers,
Christian

[0]: https://gitlab.archlinux.org/gromit/linux-mainline-repro-test
[1]: https://pkgbuild.com/~gromit/linux-bisection-kernels/linux-mainline-6.=
13-1.2-x86_64.pkg.tar.zst

--4hw4xsdogt6jxe7z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmegwUEACgkQwEfU8yi1
JYWeYg//T393bfbxswhXCUthBFnjA93W811Td6FcAaSuQVYHkaShTzHhGFhM0/42
bPKOeU9FsEBfcAaqQ2hSBfJK951EGxmXPcVuwGD8P3cSLR8076bcH4QJq6YbbO1m
nGhXArgtsQ/4JeDwP2Od5UQwKJP0eJKL2rrkU+EK/EACyOIQCH4SUJf+AaNN2wab
3t7GXOIOihirIEeubhD5OpUcsAoWJLG2GiPTwhKWr/P3ia7LStbK335jQl0E2nAu
sL6T7AopwkFFZ94p2Fd4w9bLd2k4DvzjHsQaI2On3Ybam0qBL/mei6V6jcgjDAvr
zo5s8O3Pcy3YbFPZYdttjaD1Jp+KNn7JA0G1HBd/Qbz55JevkufdW0c2Fq8/V56m
LIFAX1wgJMNWT/6BG29OuGJ9yx+qO7EXfz1LjTce+oOTls2tsu3OhuNcyJeQeADN
W6ThiLff+NFU7YQpEb+rfFgVM2krN7ib+DUrge0oe4Nj/gBivnC8o44BCK9k5zoG
qvfNGV5ARMqJj/n8e0CtyNZ3d8L+n+3TVPy4o8fvAJRndCHNIVvnY/Tkx9DQn73g
Mo/jqtT08gUoptL9pYAjr686IXQalRmPDFYcV74Xq43xvUToVApgtKjARphPxXSA
cnM3z3x5zLdin5otTL1sVwQzUjvt/HcnOR7gVAyqwooTJ6STENA=
=2M+y
-----END PGP SIGNATURE-----

--4hw4xsdogt6jxe7z--

