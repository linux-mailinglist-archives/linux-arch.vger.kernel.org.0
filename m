Return-Path: <linux-arch+bounces-9744-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF62A1043C
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jan 2025 11:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FEC6188106E
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jan 2025 10:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A621D63DE;
	Tue, 14 Jan 2025 10:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AxTH1TVO"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D47A1D47B4;
	Tue, 14 Jan 2025 10:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736850845; cv=none; b=TUOb1GXeafX3qljifWGD73m/wdUokJ188rHbMWdcVF8NWW2qWRwOk+XhiyQ30dCSQoadX3Wjhww6Uo58QouZCpsibHUMfp/0IvxdqB+wtwnFhgxrZ6T8SUx0PEe8A1lfC9pGqgh5IOaigXobLR47gkhfXz+ZWkz05ObimLeqULo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736850845; c=relaxed/simple;
	bh=PPBTXcmZ9FTKLOavDTSaaCxS+I83L8XKDLxpo1k4qF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vDITmQRZk0j1ZoL1te8W1k1LUUa/sekHDnbfFE9NDXA8rySc8WaPBlrqOHJ9gO5KH9hs4dUx8MjhdOTZ2LWKMfqrzRwW0A+djVVuHuwo6rzje9QHu354eYH0yKfrAbrKSWfRtkY2DKUo3rdfRnSUUUmOPeoYFMUIHzBHE/Zoyyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AxTH1TVO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 310DFC4CEE0;
	Tue, 14 Jan 2025 10:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736850844;
	bh=PPBTXcmZ9FTKLOavDTSaaCxS+I83L8XKDLxpo1k4qF8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AxTH1TVOByRyemy5vzP15NHxHuJlYlyl1hQLGDalk4R7LH2WyA/2gx/XtNbKHP6IE
	 BdijOVzI31N04UC33BwkWxuWMPpjOqJk4YPBcZWpHmsEzVSlAn6n8H3SvPSKjRt4Km
	 MmpAYcYGmR2n+9td9dyxGX+GBgzUR73o9ZemtBsDbfqnix+wupk/YAt26zv5Z/Nt2Q
	 YW8X2WGphjiIh5L1lDgafPSMz5AIFm6Q1aPh8ln+BKEZNUtlb11WMWugcnXi6M0GO3
	 AVtW7Uph3adO04TefpnPeJyGrUuc2ovvVgVBTVrDhbVONzJzNVIc1qvOPiQR3KVK67
	 Hr4Mh5R5VIq3w==
Date: Tue, 14 Jan 2025 10:33:53 +0000
From: Conor Dooley <conor@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>, Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Russell King <linux@armlinux.org.uk>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
	Guo Ren <guoren@kernel.org>, linux-parisc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, loongarch@lists.linux.dev,
	linux-s390@vger.kernel.org, linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org,
	Nam Cao <namcao@linutronix.de>, linux-csky@vger.kernel.org
Subject: Re: [PATCH v2 09/18] riscv: vdso: Switch to generic storage
 implementation
Message-ID: <20250114-lustily-nuttiness-3bb7646515d5@spud>
References: <20250110-vdso-store-rng-v2-0-350c9179bbf1@linutronix.de>
 <20250110-vdso-store-rng-v2-9-350c9179bbf1@linutronix.de>
 <20250113-kissable-monstrous-aace0cf7182e@spud>
 <20250114093609-6cb25835-f912-4f64-9ba7-54c67d4e2904@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jwGvJ1ZaVXfjr5LT"
Content-Disposition: inline
In-Reply-To: <20250114093609-6cb25835-f912-4f64-9ba7-54c67d4e2904@linutronix.de>


--jwGvJ1ZaVXfjr5LT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 09:40:11AM +0100, Thomas Wei=DFschuh wrote:
> On Mon, Jan 13, 2025 at 07:48:15PM +0000, Conor Dooley wrote:
> > On Fri, Jan 10, 2025 at 04:23:48PM +0100, Thomas Wei=DFschuh wrote:
> > > The generic storage implementation provides the same features as the
> > > custom one. However it can be shared between architectures, making
> > > maintenance easier.
> > >=20
> > > Co-developed-by: Nam Cao <namcao@linutronix.de>
> > > Signed-off-by: Nam Cao <namcao@linutronix.de>
> > > Signed-off-by: Thomas Wei=DFschuh <thomas.weissschuh@linutronix.de>
> >=20
> > For rv64, nommu:
> >   LD      vmlinux
> > ld.lld: error: undefined symbol: vmf_insert_pfn
> > >>> referenced by datastore.c
> > >>>               lib/vdso/datastore.o:(vvar_fault) in archive vmlinux.a
> >=20
> > ld.lld: error: undefined symbol: _install_special_mapping
> > >>> referenced by datastore.c
> > >>>               lib/vdso/datastore.o:(vdso_install_vvar_mapping) in a=
rchive vmlinux.a
> >=20
> > Later patches in the series don't make it build again.
> > rv32 builds now though, so thanks for fixing that.
>=20
> Thanks for the report.
> Can you try to diff below?

Ye, that resolved it. Thanks!

--jwGvJ1ZaVXfjr5LT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ4Y9kQAKCRB4tDGHoIJi
0oHDAP9Da+NrCNJE56DtkPFciL+LH3SKSSwOWQ6oFB2bu8GWRQEA9RJt/Is3QV+w
+n+t05VKvIADKDk9hc4FHnNawF8GUgg=
=tDst
-----END PGP SIGNATURE-----

--jwGvJ1ZaVXfjr5LT--

