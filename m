Return-Path: <linux-arch+bounces-6301-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4528956002
	for <lists+linux-arch@lfdr.de>; Mon, 19 Aug 2024 00:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D77951C21138
	for <lists+linux-arch@lfdr.de>; Sun, 18 Aug 2024 22:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CF8154C0D;
	Sun, 18 Aug 2024 22:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ezhA/uFs"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE2B610D;
	Sun, 18 Aug 2024 22:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724020828; cv=none; b=kKDcWJBgu9I/bUijIgUwSUEPpyp+a/cvM8zmy8dmUwhSj59Hu531Gp8IRjas4vMyoqXYYmYHkmHe7qnYoUug6AjklahYGKdSSI29sPtyqdTo+x4aTEFax2fTD0HikgnvkjeRggKBg1jEb2H56DZPz7twq+M7xTqnKdlPkWoWJFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724020828; c=relaxed/simple;
	bh=nvPIW8MrNDLXJBVY8SG6ZctzKzWx2f6RqLPxk4qnoUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z6gOouboU0BkJQtkzHdctlzbMFuKawDyO5RsWP08AziGVuCwDFKcmr4PH/Z4P9dxPsAigW4ZoLjjTIWn2NnoG4PBmGZhrxpwjtDU8s/bb5ypRXZpKNAA2eDq/cjpyU86zsDOAXj+xFKDZ7x0faEVv7/awlOWAJj4jgRZV7urv34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ezhA/uFs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22AB6C32786;
	Sun, 18 Aug 2024 22:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724020828;
	bh=nvPIW8MrNDLXJBVY8SG6ZctzKzWx2f6RqLPxk4qnoUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ezhA/uFsNcmRYc1rtMUFEV7Ow3YdA1VbP5uMKK/30TkFlwen1hAZvK9xsDcimmi92
	 8mUkNTOZwST0HGSh4vM4DnbCHm6a++ZaxgVo4RbUvVFM8m9OWTbcvm6YRKek+t6V+b
	 tvMtFKlZWup0UsrsaXKSoVKj5NF5XtXpfcDBydD6D+jJ2t8ih4KJZ9cLzA7S07qGk0
	 vq+sKIxr8X2LKC31TVsBfWO9WSod6mP+qklBNC9MJntvh1ZJ3i0Eg1xUj7sGc6nvuI
	 XvJNhd2SOrp4A0BzyoSOroeJlm60WSx1l8CHZK2GihFb8k+RZovDlStUMU9Oy8F5WZ
	 stjafl0rbJBZQ==
Date: Sun, 18 Aug 2024 23:40:22 +0100
From: Conor Dooley <conor@kernel.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Andrea Parri <parri.andrea@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, Leonardo Bras <leobras@redhat.com>,
	Guo Ren <guoren@kernel.org>, linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v5 12/13] dt-bindings: riscv: Add Ziccrse ISA extension
 description
Message-ID: <20240818-dinner-legume-9c73c5145898@spud>
References: <20240818063538.6651-1-alexghiti@rivosinc.com>
 <20240818063538.6651-13-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MdjlHmg67ept7cTJ"
Content-Disposition: inline
In-Reply-To: <20240818063538.6651-13-alexghiti@rivosinc.com>


--MdjlHmg67ept7cTJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 18, 2024 at 08:35:37AM +0200, Alexandre Ghiti wrote:
> Add description for the Ziccrse ISA extension which was ratified in
> the riscv profiles specification v1.0.
>=20
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Reviewed-by: Guo Ren <guoren@kernel.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--MdjlHmg67ept7cTJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZsJ4VQAKCRB4tDGHoIJi
0q1TAQC/3Y3ikmFCM9JkfyYBjvVDU7doIlqoBTwix2edEFt+cgD/e8U9gPTWeUR9
iKo8EiUwOQ2/3YOG6uwaJ7IPl8oZCQo=
=15P4
-----END PGP SIGNATURE-----

--MdjlHmg67ept7cTJ--

