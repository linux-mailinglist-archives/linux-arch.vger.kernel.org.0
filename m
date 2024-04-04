Return-Path: <linux-arch+bounces-3444-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0421A898E8D
	for <lists+linux-arch@lfdr.de>; Thu,  4 Apr 2024 21:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 977481F22458
	for <lists+linux-arch@lfdr.de>; Thu,  4 Apr 2024 19:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192B7132816;
	Thu,  4 Apr 2024 19:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rrHS/o8F"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E1B1311B0;
	Thu,  4 Apr 2024 19:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712257458; cv=none; b=V2LxWbkict8Xi48D47mbWooFl98nbLBgmufkjVESZhvOABK7rVPp0u6PkuygKZnXZlya49ABUoYJBzg2NutGxQF88gLTamNhod1CJ3KzKOcnl0xX3bTZCfM5QGkZQCh5gCjUuLRIRU3DCuwh/KfvWoxzg723okHh48oIXxucQZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712257458; c=relaxed/simple;
	bh=rNly9F2P9OdTExq18M642lONbtjeAMZI50NvvyYjTA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bXKc0P1wxztr1Fw04U6fVbLmvKOyc4o58qNziug0aUa9L8MmL3DQTXvD+VMOgEUGyaD6uperDOCz4iZCAmhwz/sMZUxzGpd6rC9jsRbxm98ZBXmZlmCpysJ4+oHd55YZ6Vb0oXkNAJpARc0oDJIA9B5oSfA3SvL32f3gdikmvGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rrHS/o8F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B1FC433C7;
	Thu,  4 Apr 2024 19:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712257458;
	bh=rNly9F2P9OdTExq18M642lONbtjeAMZI50NvvyYjTA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rrHS/o8F+rLpX2ZKpX8B9hjkRFhechDLI6DI0vt9JNZg4IFEN2Yk75PF5PL8NnAgv
	 g01Ak48kRGFEk0xR/32kl/QzD5QXbYMXXqwJ/TBW9J/87Gkldb5FVAGhvbNDEcS168
	 v6TURXoHAavMjrBtDBzvm+kddqqpOhtZFzjVnCyS8WIKeCYcgy6j/zdX69zjWqhHTB
	 BsYqDCpZhzhLckh7DHaKuZ/M0jFxzpaq0ukApjVqDN+FpkdEpk7CXa9WD4G7PWNwSG
	 iUNJVR0y4ntzYgDmeidcdI2GYlbiOI4BjQnODSmARl+JY8eOSn64ri2mV0mkayTG1I
	 lPSaQqjXu2OSQ==
Date: Thu, 4 Apr 2024 20:04:00 +0100
From: Mark Brown <broonie@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Deepak Gupta <debug@rivosinc.com>, paul.walmsley@sifive.com,
	rick.p.edgecombe@intel.com, Szabolcs.Nagy@arm.com,
	kito.cheng@sifive.com, keescook@chromium.org,
	ajones@ventanamicro.com, conor.dooley@microchip.com,
	cleger@rivosinc.com, atishp@atishpatra.org, alex@ghiti.fr,
	bjorn@rivosinc.com, alexghiti@rivosinc.com,
	samuel.holland@sifive.com, conor@kernel.org,
	linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-mm@kvack.org, linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org, corbet@lwn.net, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, oleg@redhat.com,
	akpm@linux-foundation.org, arnd@arndb.de, ebiederm@xmission.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, lstoakes@gmail.com,
	shuah@kernel.org, brauner@kernel.org, andy.chiu@sifive.com,
	jerry.shih@sifive.com, hankuan.chen@sifive.com,
	greentime.hu@sifive.com, evan@rivosinc.com, xiao.w.wang@intel.com,
	charlie@rivosinc.com, apatel@ventanamicro.com,
	mchitale@ventanamicro.com, dbarboza@ventanamicro.com,
	sameo@rivosinc.com, shikemeng@huaweicloud.com, willy@infradead.org,
	vincent.chen@sifive.com, guoren@kernel.org, samitolvanen@google.com,
	songshuaishuai@tinylab.org, gerg@kernel.org, heiko@sntech.de,
	bhe@redhat.com, jeeheng.sia@starfivetech.com, cyy@cyyself.name,
	maskray@google.com, ancientmodern4@gmail.com,
	mathis.salmen@matsal.de, cuiyunhui@bytedance.com,
	bgray@linux.ibm.com, mpe@ellerman.id.au, baruch@tkos.co.il,
	alx@kernel.org, catalin.marinas@arm.com, revest@chromium.org,
	josh@joshtriplett.org, shr@devkernel.io, deller@gmx.de,
	omosnace@redhat.com, ojeda@kernel.org, jhubbard@nvidia.com
Subject: Re: [PATCH v3 08/29] mm: Define VM_SHADOW_STACK for RISC-V
Message-ID: <d3689521-58a7-47df-bd6a-0e2e60464491@sirena.org.uk>
References: <20240403234054.2020347-1-debug@rivosinc.com>
 <20240403234054.2020347-9-debug@rivosinc.com>
 <8fb37319-288c-4f77-9cd7-92f17bb567ee@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3H0qyxN/1AXzqBUq"
Content-Disposition: inline
In-Reply-To: <8fb37319-288c-4f77-9cd7-92f17bb567ee@redhat.com>
X-Cookie: Buckle up!


--3H0qyxN/1AXzqBUq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 04, 2024 at 08:58:06PM +0200, David Hildenbrand wrote:

> or even introduce some ARCH_HAS_SHADOW_STACK so we can remove these
> arch-specific thingies here.

It would be convenient if you could pull the ARCH_HAS_USER_SHADOW_STACK
patch out of my clone3 series to do that:

   https://lore.kernel.org/all/20240203-clone3-shadow-stack-v5-3-322c69598e4b@kernel.org/

--3H0qyxN/1AXzqBUq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYO+Z8ACgkQJNaLcl1U
h9DK1Af9H1qYKVWDvox7q04WCtsfCFsMMGVPBMGaRQVduMIls1x5LQmfVpAOPyqf
UZjyR8MbmEsEV+112AF9Fj3j7TK8j82BiGfS7vSX6Ui0DYE1o5X7g+7Dm7n1l5kz
WVTXuxJTDrr5WAIj5i2XVJ7/IcGTG69iu+Dy5lAe8d4xwSZ7sBKWNbjV1TM31VR5
AHXCdjeM9oNGJ6IdSvwjBrruoUwO8TUsLoZGHYEdxBdTYM7gNiJsDhRaFYgk4RdA
mox+wfY+QCl/Q13A0+3194XiBpuCoo9PO6C8+zbQxR2mvFfC4YxE69wC3/U1iR4T
VWxny2roSj6OTfzkesBui3R0qehJZA==
=LTGw
-----END PGP SIGNATURE-----

--3H0qyxN/1AXzqBUq--

