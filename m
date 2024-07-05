Return-Path: <linux-arch+bounces-5285-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0B69288A7
	for <lists+linux-arch@lfdr.de>; Fri,  5 Jul 2024 14:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 540A528694E
	for <lists+linux-arch@lfdr.de>; Fri,  5 Jul 2024 12:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEAA149C7F;
	Fri,  5 Jul 2024 12:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="MbNH/85Z"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A47C13D243;
	Fri,  5 Jul 2024 12:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720182396; cv=none; b=BfZlvJIXYy0nDuySYl7cEKyoDeOFyW/1ox2Xg+d5JoximEHHwBrp2rqLD32J8UytnDBZqatIfu5n/q3UdYxJhyK/Ak4eadJiTcP5Vmhqoc3qFxfwBCPFmvHXcawRVXvZSzvl2oEAJ9gumPLO34ypuBzXKcK4HdFRvBzT1igkpOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720182396; c=relaxed/simple;
	bh=4cGnOhuIoomBwrD24hVQFlP9MtQb5SmqGxpFHWYkwpo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F3A0UsSUijnUXfsbgotUcjLdLSzsg8awn6HvdOKSpXXe/yO6GTdqcT3jsfhTOnqyI7WcZlBxVDBm6UpsNmA/XEqaOV7faxEKKJfVNKBWe03QM04yiY9Bd6LdtGlwUfwLUurzUMFiLTE7GGG/ptj7EYOK4eb9+rm8v5Qof3Jvnqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=MbNH/85Z; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1720182391;
	bh=aZeNuP2pelRkI3CSCXzaDUpVS59Y3c8MYTsNt4sB4jk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MbNH/85ZZAmLzPqUmW/KoPjNcWSQUJa5m1sHj4DwaD/Ggp9suzqFFsesZCl9i0j5X
	 JVbctaMNgLWgMP/bGFHZqDnj1IIW7hvpR/uRbno/OxJjv1QanWSpH6FOaOZijgz61I
	 Zol9kCM1ZW6mji0n8O+R1b+o7ClH1Hw814x1Io/hCwfnpz69tRzqI7rZiXaVALAkYH
	 T3sq1bsZYZYctf/nMILRfaHpInxI0sVxnTAUiuwQNJmPn/d69H+rS8STQtquhj6Rls
	 OlFggb8LXFVlFRXHsXFhyjRXI1cYJKQCr2Kg8lNrw5PZ+p+UV/XRyjr/zyRRxJicY0
	 Im6zX8yemoKDQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WFt6K6cs3z4wbh;
	Fri,  5 Jul 2024 22:26:17 +1000 (AEST)
Date: Fri, 5 Jul 2024 22:26:16 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Masahiro
 Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nicolas@fjasle.eu>, Vineet Gupta <vgupta@kernel.org>,
 Russell King <linux@armlinux.org.uk>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren
 <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, Huacai Chen
 <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Dinh Nguyen
 <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson
 <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Rich Felker
 <dalias@libc.org>, John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>, "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, Christian Brauner
 <brauner@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 loongarch@lists.linux.dev, linux-openrisc@vger.kernel.org,
 linux-riscv@lists.infradead.org
Subject: Re: [PATCH 03/17] um: don't generate asm/bpf_perf_event.h
Message-ID: <20240705222616.017b1593@canb.auug.org.au>
In-Reply-To: <20240704143611.2979589-4-arnd@kernel.org>
References: <20240704143611.2979589-1-arnd@kernel.org>
	<20240704143611.2979589-4-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/IAaJheb.p6.1G=gRNPNGj_e";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/IAaJheb.p6.1G=gRNPNGj_e
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

On Thu,  4 Jul 2024 16:35:57 +0200 Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> If we start validating the existence of the asm-generic side of
> generated headers, this one causes a warning:
>=20
> make[3]: *** No rule to make target 'arch/um/include/generated/asm/bpf_pe=
rf_event.h', needed by 'all'.  Stop.
>=20
> The problem is that the asm-generic header only exists for the uapi
> variant, but arch/um has no uapi headers and instead uses the x86
> userspace API.
>=20
> Add a custom file with an explicit redirect to avoid this.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/um/include/asm/Kbuild           | 1 -
>  arch/um/include/asm/bpf_perf_event.h | 3 +++
>  2 files changed, 3 insertions(+), 1 deletion(-)
>  create mode 100644 arch/um/include/asm/bpf_perf_event.h
>=20
> diff --git a/arch/um/include/asm/Kbuild b/arch/um/include/asm/Kbuild
> index 6fe34779291a..6c583040537c 100644
> --- a/arch/um/include/asm/Kbuild
> +++ b/arch/um/include/asm/Kbuild
> @@ -1,5 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
> -generic-y +=3D bpf_perf_event.h
>  generic-y +=3D bug.h
>  generic-y +=3D compat.h
>  generic-y +=3D current.h
> diff --git a/arch/um/include/asm/bpf_perf_event.h b/arch/um/include/asm/b=
pf_perf_event.h
> new file mode 100644
> index 000000000000..0a30420c83de
> --- /dev/null
> +++ b/arch/um/include/asm/bpf_perf_event.h
> @@ -0,0 +1,3 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#include <asm-generic/bpf_perf_event.h>

Just wondering if that file should have some explanatory comment in it
to prevent it being cleaned up in a few years ... or at least to
explain why it causes the above error when removed.

--=20
Cheers,
Stephen Rothwell

--Sig_/IAaJheb.p6.1G=gRNPNGj_e
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmaH5mgACgkQAVBC80lX
0GxvyAgAnvriHKpdKWTfcYd3ec6OiQntfWfgTjPlWVORKO3a85cAPDy3acHNxKoW
6Bfh4LWjBSmmqSTbP6rIFpInGlZedDil+cHdDALd7D/dBOCwUJkG1oB7aY7A1HkA
hPQhv7pLSbZkhJ3M0TurrRsFbO9QR1RFnxIxPRPy4gEkjPGnLJ0H1gqh11s5irVU
WGCviIF/qU3Xkj6DjtzAS1lY7y0BGec3kvR02WhKHvoh7SJrquU5M1i5qzLpuw82
0xowL25d77AbRzea52VD6Sv2H614Q8hfDtDQB6rTGdz6Bo7Pu6F50S3NfYe0Uu5y
zmTMyLek7tdd4FU+Gs4HcQFuJNsSeQ==
=SXsw
-----END PGP SIGNATURE-----

--Sig_/IAaJheb.p6.1G=gRNPNGj_e--

