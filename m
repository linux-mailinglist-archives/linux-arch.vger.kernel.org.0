Return-Path: <linux-arch+bounces-5891-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 067DB944E83
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 16:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A50BC28686C
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 14:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E7E1A76A1;
	Thu,  1 Aug 2024 14:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tFnl2k4v"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E331A4887;
	Thu,  1 Aug 2024 14:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722524006; cv=none; b=VgoJhpGMEy15FkJNB+VamPOpTiM5zXYhu8IuArgPSLdfI0JcAK22LOOqUpCZdEIaWzekuGL36qzlKgXDcKDRK+5sCycvYHOqXq3X5C8He7S46N5mP1qEFMItGaJmI4KYUyzPmX8hm/I5RnXgZywSgRWnYS8+HWhoOD773PfvcMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722524006; c=relaxed/simple;
	bh=pihbMVCA3QLJMolaC1JlUKs2kdaJDmWc7g29tWCaf1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uceJ62fue1Lil/Tjcbwd7AeK/eNt5zTXxRhqu7lVUC4+GFXs2UG5U4hmIq+l3MPae47qlnJliyJbUBhSKpOutfCsP4MwxFLFsXAOWxfZYbYPUYv0o+HmAhms/VSWmDPQUgEp9+dJaBfv/ALQg0WWv+bbvmf0tEEw5ToOcVGgeNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tFnl2k4v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CA45C32786;
	Thu,  1 Aug 2024 14:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722524003;
	bh=pihbMVCA3QLJMolaC1JlUKs2kdaJDmWc7g29tWCaf1Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tFnl2k4v+sPK5hUTLtjsm02gby1FH7+7nTBXOrq9SFFhvoOy6W31Vm0ulS3N+hwo6
	 0LJmE1boYr7t6A/zDghoKxHoRDEOfOW/JSzPf9sKxJaO0Kvj9g7dbagQVpRgGXUlJb
	 JH4emFWM5qtq38pSNidhjU6gMLpz9/Sb4dI9fC15Gl33qFDAqAxehCOnspqgSZAFJ8
	 M+mc9E9+g4ls4hTrOQ3H9tJBq65Ii/9YfIwjPUMdo3KKjytWSRzY9GuWwVF+bzTCxc
	 YQgZ2QtHDdDa9kqZujkqAeC4OBr/dt4gO1CRqahW1bUlodcIFhRs2XvcYyBYgR1w+g
	 edesfaRakfPvQ==
Date: Thu, 1 Aug 2024 15:53:17 +0100
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
Subject: Re: [PATCH v4 04/13] dt-bindings: riscv: Add Zabha ISA extension
 description
Message-ID: <20240801-outmatch-handwash-8622a4972faa@spud>
References: <20240731072405.197046-1-alexghiti@rivosinc.com>
 <20240731072405.197046-5-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ChwbiayH3N33d2aF"
Content-Disposition: inline
In-Reply-To: <20240731072405.197046-5-alexghiti@rivosinc.com>


--ChwbiayH3N33d2aF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 09:23:56AM +0200, Alexandre Ghiti wrote:
> Add description for the Zabha ISA extension which was ratified in April
> 2024.
>=20
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Reviewed-by: Guo Ren <guoren@kernel.org>
> ---
>  Documentation/devicetree/bindings/riscv/extensions.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Do=
cumentation/devicetree/bindings/riscv/extensions.yaml
> index a06dbc6b4928..a63578b95c4a 100644
> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> @@ -171,6 +171,12 @@ properties:
>              memory types as ratified in the 20191213 version of the priv=
ileged
>              ISA specification.
> =20
> +        - const: zabha
> +          description: |
> +            The Zabha extension for Byte and Halfword Atomic Memory Oper=
ations
> +            as ratified at commit 49f49c842ff9 ("Update to Rafified stat=
e") of
> +            riscv-zabha.

Acked-by: Conor Dooley <conor.dooley@microchip.com>


--ChwbiayH3N33d2aF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZquhXQAKCRB4tDGHoIJi
0q0gAP4w29iDC4m6l/qSPS+MMlI/WiH69/4G+fcBBKIq7aRTCwD/W8P7PX8RBqjX
vFrgiE5bcGwtx7wKqCuveDiYrxM2qAo=
=FU44
-----END PGP SIGNATURE-----

--ChwbiayH3N33d2aF--

