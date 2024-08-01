Return-Path: <linux-arch+bounces-5890-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD93944E4B
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 16:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DF581C238FD
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 14:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99341A57DF;
	Thu,  1 Aug 2024 14:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pD3Ln2Os"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEDD1A57D9;
	Thu,  1 Aug 2024 14:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722523484; cv=none; b=LXD7i6zVVJ6r47LCpmKVJLByPymGlWHkl4w8zN70ZQseCDkyd2r4h/et4Q6ydD5XIdji4dHSGx5w4UCXgWBxIoi7Hfedn2B8+w6LeQvcm5gpqMJZxPbmlWEkPAqiNJzMLuRUIqTMRCb5AFLh4IdORSAdBGNSVNJMk4ZviTP6MDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722523484; c=relaxed/simple;
	bh=yWRzKkA1fAc3LTDx/IyWXZIrXafQjDv+7BkIxVifL8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cn6UtH1XtCyaiVJiHEG17ELjfevSBysUZYSJmZB4X55vKpqSg4sXv0ewTtv/dOhiohJJJv8NA/Uhd7qioLiV9yIpTOhnx0Q12sBr5T+p1x+eisFllZotc7XTfYqD3XmdcX7MMP2OEsAVre4lah1FnzR002DEdPeJiaegVLdVf9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pD3Ln2Os; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D7FC32786;
	Thu,  1 Aug 2024 14:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722523484;
	bh=yWRzKkA1fAc3LTDx/IyWXZIrXafQjDv+7BkIxVifL8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pD3Ln2OspqdH0jh7sCea6e/o0uZY/OzY9jp78ALJQwbP84f1/NaLa8esqwJWL8lPz
	 p0SpQUSsJnLGtodaKWOMKq4uRkz6cchJWzOfGBqSXeAN6ckRPfDuqDIdROks4VPJmr
	 ysXKdt50ietfHWLnyKypfra6Eui+eDtEd0DrcdSKv0bFhBsT4UfKRYp7mWMB2YiReQ
	 ujD8dBFCvf+SB5+KRaoYtj3sbOAhWdDYj5fubIuh65bUTVRgkHRy9hhb4kK/Sp24yg
	 kT/N00viDth3MmwoqeqhF/83Osa9GWEySwu6v0kPRqMwvRzC8RhUwSLwTOkGKF4cVW
	 BhKqczRi3uOzQ==
Date: Thu, 1 Aug 2024 15:44:38 +0100
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
Subject: Re: [PATCH v4 12/13] dt-bindings: riscv: Add Ziccrse ISA extension
 description
Message-ID: <20240801-unlighted-senator-cc60d021fe28@spud>
References: <20240731072405.197046-1-alexghiti@rivosinc.com>
 <20240731072405.197046-13-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vk7KX8IGXHik2sFq"
Content-Disposition: inline
In-Reply-To: <20240731072405.197046-13-alexghiti@rivosinc.com>


--vk7KX8IGXHik2sFq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 09:24:04AM +0200, Alexandre Ghiti wrote:
> Add description for the Ziccrse ISA extension which was introduced in
> the riscv profiles specification v0.9.2.
>=20
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Reviewed-by: Guo Ren <guoren@kernel.org>
> ---
>  Documentation/devicetree/bindings/riscv/extensions.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Do=
cumentation/devicetree/bindings/riscv/extensions.yaml
> index a63578b95c4a..22824dd30175 100644
> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> @@ -289,6 +289,12 @@ properties:
>              in commit 64074bc ("Update version numbers for Zfh/Zfinx") of
>              riscv-isa-manual.
> =20
> +        - const: ziccrse
> +          description:
> +            The standard Ziccrse extension which provides forward progre=
ss
> +            guarantee on LR/SC sequences, as introduced in the riscv pro=
files
> +            specification v0.9.2.

Do we have a commit hash for this? Also v0.9.2? The profiles spec is a
crock and the version depends on the specific profile - for example
there's new tags as of last week with 0.5 in them... The original profiles
are ratified, so if this definition is in there, please cite that
instead of a "random" version.

Cheers,
Conor.

> +
>          - const: zk
>            description:
>              The standard Zk Standard Scalar cryptography extension as ra=
tified
> --=20
> 2.39.2
>=20

--vk7KX8IGXHik2sFq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZqufVgAKCRB4tDGHoIJi
0jq/AQDKme9i0ZnDLmCj43Cb8IW/tVrItu1FVtB7WbJMTpoGBwEA+TebmkDz/Bu9
wFToOnjAf5wH7WupVoZ1Lv3Qh6WEHgs=
=bzCq
-----END PGP SIGNATURE-----

--vk7KX8IGXHik2sFq--

