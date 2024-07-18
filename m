Return-Path: <linux-arch+bounces-5493-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C83CA9349F9
	for <lists+linux-arch@lfdr.de>; Thu, 18 Jul 2024 10:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39C14B23924
	for <lists+linux-arch@lfdr.de>; Thu, 18 Jul 2024 08:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FB57BAFF;
	Thu, 18 Jul 2024 08:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="c4Rnyl9j"
X-Original-To: linux-arch@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E2C74E26;
	Thu, 18 Jul 2024 08:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721291636; cv=none; b=AMQYJJMd+nLH7HUQQxp3R2GJ3trKLZR5Q4TFhsoml1/MaqOZcdAHWkMVw6RYA8YNkCvb8vLoOjLFjrAEbHIz/dkRp31c8J/NqCXWCo4JMDo6x2rNIdhIQAAEHgfdHlDMoRiLkiiouP/IBVkJo3GXVMGw3uoJ8XUBAl258V9ob1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721291636; c=relaxed/simple;
	bh=gNIXVaNizqBLHCwLfM/UtwzkXFHA9hFNWND1AHtlbIM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HSgzoV9ocdGTfZxA5jTi2zPlwSSrYXm3IuhHW/Pn4gdmrYVDfW7isJ2bG04s7K+70dJ6InO5zWwqdzLWlVBHhjA91XLO3wemHO6dN4PqpRB9+OLPHEvw7ORabfsPzOnlzWmvEcm+i2ESU7LjgbOkHBHN3/02vNhT0XAlWXuwsqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=c4Rnyl9j; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1721291635; x=1752827635;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gNIXVaNizqBLHCwLfM/UtwzkXFHA9hFNWND1AHtlbIM=;
  b=c4Rnyl9j5zQKjgdG0Qk9GDaPHvkBSRu7V6qFysehCBkhfhjG16Z5NTSP
   7m1PkB/RHMqqjjA5DZPv2OQiu6A63n5d4gj+ckEF8/3RhQ4eprqEZYS3y
   NoWQXKdPogBwa5YCX9dPZ0Tc6mH7HK0SeVdBjlS0cUjWluVe1HoUVCts6
   spbMD4wpmWVqx0A5A1/y84GWcFkLiKk3fa4v1Dk6W5UCYggIWtQzkUhBu
   +2eskH8+O2dW9vy5KbyjksSwhrHTjgGbK2ZXJdW0vLTQNJq7jM081zENe
   HubP4LZ9lFL5ooyocufJ1aQnxip7y156J8kBITmHTZUNIR7tHmVkkeUe3
   A==;
X-CSE-ConnectionGUID: X6g/KyPBTa2lRsaYzZqfLg==
X-CSE-MsgGUID: rYjAUFt2TkiUexP5qeRCzg==
X-IronPort-AV: E=Sophos;i="6.09,217,1716274800"; 
   d="asc'?scan'208";a="29395240"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Jul 2024 01:33:53 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Jul 2024 01:33:44 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Thu, 18 Jul 2024 01:33:40 -0700
Date: Thu, 18 Jul 2024 09:33:17 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
CC: Andrew Jones <ajones@ventanamicro.com>, Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
	<palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley
	<conor@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Andrea Parri <parri.andrea@gmail.com>, Nathan
 Chancellor <nathan@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo
 Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long
	<longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, Arnd Bergmann
	<arnd@arndb.de>, Leonardo Bras <leobras@redhat.com>, Guo Ren
	<guoren@kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-arch@vger.kernel.org>
Subject: Re: [PATCH v3 05/11] riscv: Implement arch_cmpxchg128() using Zacas
Message-ID: <20240718-stammer-envy-f77637a8d039@wendy>
References: <20240717061957.140712-1-alexghiti@rivosinc.com>
 <20240717061957.140712-6-alexghiti@rivosinc.com>
 <20240717-94b49fbac3c6bf97a0f96281@orel>
 <CAHVXubi33T-5y9g1cqa+meM7q7b=0M54o+wrBeYmwfYpWAgAmQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MBWKTf+6psjxKZC0"
Content-Disposition: inline
In-Reply-To: <CAHVXubi33T-5y9g1cqa+meM7q7b=0M54o+wrBeYmwfYpWAgAmQ@mail.gmail.com>

--MBWKTf+6psjxKZC0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 09:48:42AM +0200, Alexandre Ghiti wrote:
> On Wed, Jul 17, 2024 at 10:34=E2=80=AFPM Andrew Jones <ajones@ventanamicr=
o.com> wrote:
> > On Wed, Jul 17, 2024 at 08:19:51AM GMT, Alexandre Ghiti wrote:
> > > +
> > > +union __u128_halves {
> > > +     u128 full;
> > > +     struct {
> > > +             u64 low, high;
> >
> > Should we consider big endian too?
>=20
> Should we care about big endian? We don't deal with big endian
> anywhere in our kernel right now.

There's one or two places I think that we do actually have some
conditional stuff for BE. The Zbb string routines I believe is one such
place, and maybe there are one or two others. In general I'm not of the
opinion that it is worth adding complexity for BE until there's
linux-capable hardware that supports it (so not QEMU or people's toy
implementations), unless it's something that userspace is able to see.


--MBWKTf+6psjxKZC0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZpjTTQAKCRB4tDGHoIJi
0rIEAQCcKgEg+YAkD5rI1kB21pebJiN0tYXyWkBOBx4nlblfvQEA9BuEuGmfgArr
DZeMwbib+Suf9yhP4wp95mVBoRW2GAM=
=Lsk5
-----END PGP SIGNATURE-----

--MBWKTf+6psjxKZC0--

