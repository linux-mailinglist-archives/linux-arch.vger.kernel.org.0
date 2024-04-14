Return-Path: <linux-arch+bounces-3658-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF828A45F7
	for <lists+linux-arch@lfdr.de>; Mon, 15 Apr 2024 00:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1466DB210A3
	for <lists+linux-arch@lfdr.de>; Sun, 14 Apr 2024 22:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85C320B0E;
	Sun, 14 Apr 2024 22:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ooE7y/Qj"
X-Original-To: linux-arch@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF431C6B4;
	Sun, 14 Apr 2024 22:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713134591; cv=none; b=W3HjHmPD2obmPXAZ+qL/x6xUv46sOk4p+XwrrDQ5LsET1dmG+j/Gwh5LGWQfEEmaoOb00NTWy36t7YpvgYTjirYbUoJ+nqarvmsdJg3t9XGN9K/m9j4Lkgn8l7RZblFy0iNs3xFk5GBeyDNVJQJ1PyYZ6xjZTWZjCzgiEb5JIBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713134591; c=relaxed/simple;
	bh=hgknNj1CMqAtlwoHGwSVuod75mSwIWNcQ2rwim3xtrY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HglfIqEOEaJVX+wuUoqRqfa+FEqdHie9KLmKXwvZGtUzuh4a8LSylpNToM204dYI7Fp1jrIlabH6/Tnua/9yFTm/cYxY1s0mZjC8lRynKMz/cCFwceSDtQnG/Q8gogWrYCRs4fOEKjKYLt6qoS9d4qTepTuWdUSWRKn/ae2fTXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=ooE7y/Qj; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1713134583;
	bh=4YxIT04d5iT4t/9CWLf2dJs39GSU2JGwBCGJMwje3e4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ooE7y/QjtRNgxNbD/iBXfW+vLDiRSXCPipXLjAPSVBegCGtlgGWZiackaWHNluCyN
	 5pU/pPht+GdlCVH7KenaDnUCSi76PMEKI8aZZE8n/2H2ge/wdXDEyNqNW3qJw17axm
	 InHjB1XcIctesdyRBXNz4dcMJOI38JH9v0niQ+CbHZ676+tnh2VVRE3/Xbp4NE2xAh
	 J5oYOFjdK5ffaKKQUcRrKJp4V6mjuq+p2ok1cG35PquEzalCDnOREc+hlQxDdjRvho
	 jEuuOnL8CEEPNcpWKqAyZa2z4QjCLcZqZqMGlzBxjZaPB9Y5/Ykw7eucwjdX0shbJ0
	 MlMR8xtLzoDag==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VHlgb16rBz4wcR;
	Mon, 15 Apr 2024 08:42:51 +1000 (AEST)
Date: Mon, 15 Apr 2024 08:42:50 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Sean Christopherson <seanjc@google.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Jonathan Corbet <corbet@lwn.net>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Pawan Gupta
 <pawan.kumar.gupta@linux.intel.com>, Daniel Sneddon
 <daniel.sneddon@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arch@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH 1/3] x86/cpu: Actually turn off mitigations by default
 for SPECULATION_MITIGATIONS=n
Message-ID: <20240415084250.7b00ea63@canb.auug.org.au>
In-Reply-To: <87bk6dd2l4.fsf@mail.lhotse>
References: <20240409175108.1512861-1-seanjc@google.com>
	<20240409175108.1512861-2-seanjc@google.com>
	<20240413115324.53303a68@canb.auug.org.au>
	<87edb9d33r.fsf@mail.lhotse>
	<87bk6dd2l4.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/hV./THoU9xeCGcZYyAV1HiA";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/hV./THoU9xeCGcZYyAV1HiA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Sat, 13 Apr 2024 19:38:47 +1000 Michael Ellerman <mpe@ellerman.id.au> wr=
ote:
>
> Michael Ellerman <mpe@ellerman.id.au> writes:
> > Stephen Rothwell <sfr@canb.auug.org.au> writes: =20
> ...
> >> On Tue,  9 Apr 2024 10:51:05 -0700 Sean Christopherson <seanjc@google.=
com> wrote: =20
> ...
> >>> diff --git a/kernel/cpu.c b/kernel/cpu.c
> >>> index 8f6affd051f7..07ad53b7f119 100644
> >>> --- a/kernel/cpu.c
> >>> +++ b/kernel/cpu.c
> >>> @@ -3207,7 +3207,8 @@ enum cpu_mitigations {
> >>>  };
> >>> =20
> >>>  static enum cpu_mitigations cpu_mitigations __ro_after_init =3D
> >>> -	CPU_MITIGATIONS_AUTO;
> >>> +	IS_ENABLED(CONFIG_SPECULATION_MITIGATIONS) ? CPU_MITIGATIONS_AUTO :
> >>> +						     CPU_MITIGATIONS_OFF;
> >>> =20
> >>>  static int __init mitigations_parse_cmdline(char *arg)
> >>>  { =20
>=20
> I think a minimal workaround/fix would be:
>=20
> diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> index 2b8fd6bb7da0..290be2f9e909 100644
> --- a/drivers/base/Kconfig
> +++ b/drivers/base/Kconfig
> @@ -191,6 +191,10 @@ config GENERIC_CPU_AUTOPROBE
>  config GENERIC_CPU_VULNERABILITIES
>         bool
>=20
> +config SPECULATION_MITIGATIONS
> +       def_bool y
> +       depends on !X86
> +
>  config SOC_BUS
>         bool
>         select GLOB

The original commit is now in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/hV./THoU9xeCGcZYyAV1HiA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYcW+oACgkQAVBC80lX
0GzNlAf8CJkJCFVxONVRLci2DamLPZ4T4ZsMm4OWVge3NTf2ODxR5/6fodpWAuOx
Z4FTB9mMAJeazuf6SM1+K6bxNw3KKkfD9iexpu/bGgFgwJdZnObQp3NzxxGodpLp
sf9Fr8TjVXNjgXvmi0rCfLuBqZ3dfCxWSIWc1YgG1FgGdNu2XzEjYmllpmLqas2n
HG31in38tgVrVuwKMsIKX5Ma/qGGXFSTRWE0NETTzgCXJJQnXfm9VEEVrRzEHnl0
OGT6Y7IrdqT6XA9Lck1W6X97inzLj0GDGCdQjaqYsNwgjY39jQWNyU1mzi8BZQJk
CY2veoa0e7AKDZ7ZR/xMAebrEE7ahg==
=91NG
-----END PGP SIGNATURE-----

--Sig_/hV./THoU9xeCGcZYyAV1HiA--

