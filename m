Return-Path: <linux-arch+bounces-9177-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 146FF9DB813
	for <lists+linux-arch@lfdr.de>; Thu, 28 Nov 2024 13:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C0B9B21BA2
	for <lists+linux-arch@lfdr.de>; Thu, 28 Nov 2024 12:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4087E19F127;
	Thu, 28 Nov 2024 12:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="g7Llz4Vb"
X-Original-To: linux-arch@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC0B154BEC;
	Thu, 28 Nov 2024 12:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732798685; cv=none; b=JP4Z1RkoabjfPsOn1mJF+VerKeRMbCm0XISU4OPOVndAwMBqB0ehLdUiG8frdZjx1c0woc4praKWYPTr3TyY7S2HDVKy+l2XAS1WBDHwYb3Ouu1Xc/sLTlhGYVtg5yNsC3qHAC/knFzBjfqUzbJNvAHd880l0WGkHGrAuCmj3Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732798685; c=relaxed/simple;
	bh=QMSrXLPmS8/rI15I1H6zoqnyGh2Mcn9fOeS/kWycmGc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FSaw/Qvx2yu3bkZDuGQ7pbEW2VWezFPYH/A6NGV1fbQOfJm6H/oUe9yfiqZPTSL6reOrSn5svIWaZ4LR00Nphb5dOdtLCMsjjD7YbYes7yCFrbtyHFZJigN3sppHSmPfzAaOqOoDgUjRE4JGFxy0naq9UdECysH1j//VwFxvpMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=g7Llz4Vb; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1732798684; x=1764334684;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QMSrXLPmS8/rI15I1H6zoqnyGh2Mcn9fOeS/kWycmGc=;
  b=g7Llz4VbRm2ddrqnK7sSGp/RnkrIkxmraeRXskcQQ89ZjziS1AfTSXez
   +0FXi1hfelzshLvweRIeA4LjlQwoOeq5Zo5gV0RGSdbqfWdyerkIJuegJ
   Rf2XTJVOFakBbU2xVgVlX3b5DN/6EqwsOrpWXI7LCSRB1fuFD2Ous7fWH
   A+Avu4mO6igxNzT6Ut2JFAzFsPOI2uGc0CJNTaOnhwSShFE+dd838OEJF
   erqcZSUj70n0yEcK7rOwJ1E96EXDpJSm+7gb8s4/UPRzArrY687smdUuO
   dgVGTBz7MDnc3H1PffNz//Atf81Cr9fNTyHKejeAJiT/+wA/vdaata0nJ
   Q==;
X-CSE-ConnectionGUID: /UvZogjDQyWxjx7e3ftesA==
X-CSE-MsgGUID: Z3VVt8QuQ6eGvsYfIj+DcA==
X-IronPort-AV: E=Sophos;i="6.12,192,1728975600"; 
   d="asc'?scan'208";a="266085200"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Nov 2024 05:57:57 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Nov 2024 05:57:26 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Thu, 28 Nov 2024 05:57:22 -0700
Date: Thu, 28 Nov 2024 12:56:55 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
CC: Jonathan Corbet <corbet@lwn.net>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Andrea Parri
	<parri.andrea@gmail.com>, Nathan Chancellor <nathan@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon
	<will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng
	<boqun.feng@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Leonardo Bras
	<leobras@redhat.com>, Guo Ren <guoren@kernel.org>,
	<linux-doc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-arch@vger.kernel.org>
Subject: Re: [PATCH v6 13/13] riscv: Add qspinlock support
Message-ID: <20241128-whoever-wildfire-2a3110c5fd46@wendy>
References: <20241103145153.105097-1-alexghiti@rivosinc.com>
 <20241103145153.105097-14-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qajfT6S+474YA1dH"
Content-Disposition: inline
In-Reply-To: <20241103145153.105097-14-alexghiti@rivosinc.com>

--qajfT6S+474YA1dH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 03, 2024 at 03:51:53PM +0100, Alexandre Ghiti wrote:
> In order to produce a generic kernel, a user can select
> CONFIG_COMBO_SPINLOCKS which will fallback at runtime to the ticket
> spinlock implementation if Zabha or Ziccrse are not present.
>=20
> Note that we can't use alternatives here because the discovery of
> extensions is done too late and we need to start with the qspinlock
> implementation because the ticket spinlock implementation would pollute
> the spinlock value, so let's use static keys.
>=20
> This is largely based on Guo's work and Leonardo reviews at [1].
>=20
> Link: https://lore.kernel.org/linux-riscv/20231225125847.2778638-1-guoren=
@kernel.org/ [1]
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>

This patch (now commit ab83647fadae2 ("riscv: Add qspinlock support"))
breaks boot on polarfire soc. It dies before outputting anything to the
console. My .config has:

# CONFIG_RISCV_TICKET_SPINLOCKS is not set
# CONFIG_RISCV_QUEUED_SPINLOCKS is not set
CONFIG_RISCV_COMBO_SPINLOCKS=3Dy

--qajfT6S+474YA1dH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ0holwAKCRB4tDGHoIJi
0oxHAQDvlh0ZpqCtx7NHMgqYni9qnQMfa+yBnfL0GReiPZOY6gEAuG43y1PeVjrz
9u1w7lL364g1nfGmc7VfESDSWYuheQA=
=ZDec
-----END PGP SIGNATURE-----

--qajfT6S+474YA1dH--

