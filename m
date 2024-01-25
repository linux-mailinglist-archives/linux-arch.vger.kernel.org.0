Return-Path: <linux-arch+bounces-1674-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB75F83CB7D
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 19:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D251B25C99
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 18:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B941339B2;
	Thu, 25 Jan 2024 18:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qu1G0Hi7"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC45131723;
	Thu, 25 Jan 2024 18:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706208376; cv=none; b=JQ4UaRQrWHHusqmej2hQ74D9Kp0j1hVyndIT7oET060YPrhKC/Wwc4jvL9t9y67LhSasSChGfKQufpOE8WaklF14lXmDH+Pt34bwNAvJQobDlOj4bDWy7t9prCEgv0fcf/RqtQInMCjkonuiTqYRIlgNJTTCaUvKFAVN5ubq5vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706208376; c=relaxed/simple;
	bh=BiLkqVgI1Un5YIaI3ap285wntHUZokIzCeY02xoir/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DOXAGP12lmIuKfsxYdSREa896a+CH8N1/BoYGOoSE7Tm4BkWVW6UQ50bLVaUa7mwbNHkCcstp45jYkKvmZ5hDeHuSIQBSTaVAkg0oEKp2uCppi4yyWbFgOdMcco952Gu95iDFvbeGRSyT+kCjqsyoo0szYtVZcUnU7euK8H/aYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qu1G0Hi7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01409C433C7;
	Thu, 25 Jan 2024 18:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706208376;
	bh=BiLkqVgI1Un5YIaI3ap285wntHUZokIzCeY02xoir/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qu1G0Hi7rmFnF+2ZLbGGHHrSoG0BLvlZZP/xRzg1RH8ly9Rik3Su3lLqWik9BRe9d
	 c8QQDzcNXgWo+xKG+XVOWFviek68G9nTzBz5zol8I+bU6vlBWsypD93BcIYPYY5+ot
	 bij6bGl2icUbFUNTN966sOVcgZ5Ts9d36t3yXFTYV+OFkSdP5izT8mvowTKb97rlq2
	 C/QxWqQtvyIF1hZzL0kCrOdXKD7S2IB9af0ylNwFJZ20ghHmI/G5/zCILhMjJvvCkQ
	 J2DfEijCKdn86fx55+lMnY1k9qowdjr14vOrLCQJJqmdk9nxOJ7mj4zaxwjNxiOKHp
	 NajAyPjJIqGlw==
Date: Thu, 25 Jan 2024 18:46:01 +0000
From: Conor Dooley <conor@kernel.org>
To: Deepak Gupta <debug@rivosinc.com>
Cc: rick.p.edgecombe@intel.com, broonie@kernel.org, Szabolcs.Nagy@arm.com,
	kito.cheng@sifive.com, keescook@chromium.org,
	ajones@ventanamicro.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, conor.dooley@microchip.com, cleger@rivosinc.com,
	atishp@atishpatra.org, alex@ghiti.fr, bjorn@rivosinc.com,
	alexghiti@rivosinc.com, corbet@lwn.net, aou@eecs.berkeley.edu,
	oleg@redhat.com, akpm@linux-foundation.org, arnd@arndb.de,
	ebiederm@xmission.com, shuah@kernel.org, brauner@kernel.org,
	guoren@kernel.org, samitolvanen@google.com, evan@rivosinc.com,
	xiao.w.wang@intel.com, apatel@ventanamicro.com,
	mchitale@ventanamicro.com, waylingii@gmail.com,
	greentime.hu@sifive.com, heiko@sntech.de, jszhang@kernel.org,
	shikemeng@huaweicloud.com, david@redhat.com, charlie@rivosinc.com,
	panqinglin2020@iscas.ac.cn, willy@infradead.org,
	vincent.chen@sifive.com, andy.chiu@sifive.com, gerg@kernel.org,
	jeeheng.sia@starfivetech.com, mason.huo@starfivetech.com,
	ancientmodern4@gmail.com, mathis.salmen@matsal.de,
	cuiyunhui@bytedance.com, bhe@redhat.com, ruscur@russell.cc,
	bgray@linux.ibm.com, alx@kernel.org, baruch@tkos.co.il,
	zhangqing@loongson.cn, catalin.marinas@arm.com, revest@chromium.org,
	josh@joshtriplett.org, joey.gouly@arm.com, shr@devkernel.io,
	omosnace@redhat.com, ojeda@kernel.org, jhubbard@nvidia.com,
	linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH v1 05/28] riscv: zicfiss/zicfilp enumeration
Message-ID: <20240125-ambulance-tingle-d72bf0e744d9@spud>
References: <20240125062739.1339782-1-debug@rivosinc.com>
 <20240125062739.1339782-6-debug@rivosinc.com>
 <20240125-unscathed-coeditor-31f04e811489@spud>
 <ZbKny7ZAG5FWHwwF@debug.ba.rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dL0t2IReIcmPOkC/"
Content-Disposition: inline
In-Reply-To: <ZbKny7ZAG5FWHwwF@debug.ba.rivosinc.com>


--dL0t2IReIcmPOkC/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 10:26:19AM -0800, Deepak Gupta wrote:

> > Anything you add to this array, you need to document in a dt-binding.
>=20
> You mean Documentation/devicetree/bindings/riscv/extensions.yaml
> (or possibly any other yaml if needed?)

That one alone should be okay.

> > Also, you added these in the wrong place. There's a massive comment
> > before the array describing the order entries must be in, please take a
> > look.
>=20
> I see the comment.
> In my defense, looks like I missed it when I was rebasing.

No worries.

--dL0t2IReIcmPOkC/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbKsaQAKCRB4tDGHoIJi
0ikfAP98dLdRxWlp+Lhv6tFH9mw3Wm2hF//67S6BSZcJA+SbXQD/ZkpLxUZiV2vE
Hp0XM2ITtrvVej0ZmzRxbvJUoyE6cw8=
=roj8
-----END PGP SIGNATURE-----

--dL0t2IReIcmPOkC/--

