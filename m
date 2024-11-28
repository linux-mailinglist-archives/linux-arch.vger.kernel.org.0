Return-Path: <linux-arch+bounces-9180-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADF29DB968
	for <lists+linux-arch@lfdr.de>; Thu, 28 Nov 2024 15:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13860163547
	for <lists+linux-arch@lfdr.de>; Thu, 28 Nov 2024 14:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8900193432;
	Thu, 28 Nov 2024 14:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Z+FHwySk"
X-Original-To: linux-arch@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E785817BD5;
	Thu, 28 Nov 2024 14:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732803355; cv=none; b=BP2rhzQeTTr569pUtYgpH1kmy0rVr1s0Sn/fzsfxEzZaqG+x2Ejrh3SE1C3SzsoKAJzNUAPYN2mVgoAJPXq/ekIZpvr9cVY46KJ6wYUVcb1piqlQOWktP37p8SBWFzahv61BREOGRnGrLWDb8gU2hOKq+IXEiuNnmJR2NVtKx30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732803355; c=relaxed/simple;
	bh=VrsB10uMJv4ehZDB+SBDKh62wE2QLBRcfDmdTSQccCo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gfu1oHaSdISqgix8DuypN60mdZjpioJFG9c0Cdr0ZN9FeMcuVDp96isb5F+mJSc8mHwQjkBF3mYSt0r7bLP7LX4XO2mwTurbxXMdGAyqVgOliccL6z+NLhtlo81dTYcxYdVU39zz5jjIuclI7E/I41swEuqSMgSfAMzooQvEq2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Z+FHwySk; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1732803355; x=1764339355;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VrsB10uMJv4ehZDB+SBDKh62wE2QLBRcfDmdTSQccCo=;
  b=Z+FHwySkBAXkVPVCjZW0o6NQMJmpaURrP80l5EoGSftrbzgUbTIl2HRg
   uF2wb4NuOnzYeBd/uMJt4Fd+6RCkTJ6j9rvsiwxhdnPCqBjUIq24k4sXC
   gb50ivvDwVa7ZyIqRkbHNYj04GemwkPPdyvfp8XTZORdJh4OPTn3rZRMv
   qJ/NK2OEJgImBkGLNtJMaf4a7rRDSESpmjm+wpC2U4IwxtsVKHIpBZPpj
   J3DxbEiujuupba4BgamVWSnE+hYHt3abQJm8GZCfc9bhjg7fVyyjisnf3
   gaiE9ppQHJcAFd42wP7QvFo9sZycoTDvzuImb6CN1BpzGV6fXxxi2YtN9
   Q==;
X-CSE-ConnectionGUID: MOggi4BHRLiBwcWJ1t1VRg==
X-CSE-MsgGUID: yQOBikyfSnq+HHysc3PPHg==
X-IronPort-AV: E=Sophos;i="6.12,192,1728975600"; 
   d="asc'?scan'208";a="266088084"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Nov 2024 07:15:53 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Nov 2024 07:15:23 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Thu, 28 Nov 2024 07:15:20 -0700
Date: Thu, 28 Nov 2024 14:14:53 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Will Deacon <will@kernel.org>
CC: Alexandre Ghiti <alexghiti@rivosinc.com>, Jonathan Corbet
	<corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
	<palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley
	<conor@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Andrea Parri <parri.andrea@gmail.com>, Nathan
 Chancellor <nathan@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo
 Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>, Boqun Feng
	<boqun.feng@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Leonardo Bras
	<leobras@redhat.com>, Guo Ren <guoren@kernel.org>,
	<linux-doc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-arch@vger.kernel.org>
Subject: Re: [PATCH v6 13/13] riscv: Add qspinlock support
Message-ID: <20241128-uncivil-removed-4e105d1397c9@wendy>
References: <20241103145153.105097-1-alexghiti@rivosinc.com>
 <20241103145153.105097-14-alexghiti@rivosinc.com>
 <20241128-whoever-wildfire-2a3110c5fd46@wendy>
 <20241128134135.GA3460@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WBb/bzqDVTuERqKU"
Content-Disposition: inline
In-Reply-To: <20241128134135.GA3460@willie-the-truck>

--WBb/bzqDVTuERqKU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2024 at 01:41:36PM +0000, Will Deacon wrote:
> On Thu, Nov 28, 2024 at 12:56:55PM +0000, Conor Dooley wrote:
> > On Sun, Nov 03, 2024 at 03:51:53PM +0100, Alexandre Ghiti wrote:
> > > In order to produce a generic kernel, a user can select
> > > CONFIG_COMBO_SPINLOCKS which will fallback at runtime to the ticket
> > > spinlock implementation if Zabha or Ziccrse are not present.
> > >=20
> > > Note that we can't use alternatives here because the discovery of
> > > extensions is done too late and we need to start with the qspinlock
> > > implementation because the ticket spinlock implementation would pollu=
te
> > > the spinlock value, so let's use static keys.
> > >=20
> > > This is largely based on Guo's work and Leonardo reviews at [1].
> > >=20
> > > Link: https://lore.kernel.org/linux-riscv/20231225125847.2778638-1-gu=
oren@kernel.org/ [1]
> > > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> >=20
> > This patch (now commit ab83647fadae2 ("riscv: Add qspinlock support"))
> > breaks boot on polarfire soc. It dies before outputting anything to the
> > console. My .config has:
> >=20
> > # CONFIG_RISCV_TICKET_SPINLOCKS is not set
> > # CONFIG_RISCV_QUEUED_SPINLOCKS is not set
> > CONFIG_RISCV_COMBO_SPINLOCKS=3Dy
>=20
> I pointed out some of the fragility during review:
>=20
> https://lore.kernel.org/all/20241111164259.GA20042@willie-the-truck/
>=20
> so I'm kinda surprised it got merged tbh :/

Maybe it could be reverted rather than having a broken boot with the
default settings in -rc1.

--WBb/bzqDVTuERqKU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ0h63AAKCRB4tDGHoIJi
0qcjAQD1VYmRXRcmpfuKUiWAY8RvBFgoztaYktfbFy6aNPK3AQD+L2DsgGtQap0l
/O61BvSrFDF+EyAogkoxnnR8R5f2Ag8=
=tGkt
-----END PGP SIGNATURE-----

--WBb/bzqDVTuERqKU--

