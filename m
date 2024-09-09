Return-Path: <linux-arch+bounces-7158-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E1A971F3B
	for <lists+linux-arch@lfdr.de>; Mon,  9 Sep 2024 18:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDD912860D2
	for <lists+linux-arch@lfdr.de>; Mon,  9 Sep 2024 16:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3E4155307;
	Mon,  9 Sep 2024 16:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iVoKh7Bt"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72002771C;
	Mon,  9 Sep 2024 16:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725899444; cv=none; b=aKwHBHpfUZvXQCLLoj+RePRL0O9QtlIlU740VFXwXPPNzoM53tTRGf47ve5pMkZ+7QJWTJlf8SFbKllrYj2lV75PvCKk9y4FLkiLWyHiv3CVi1wr+fGDtZw0nKTfAWJmgsCAPS68vVIgPGGEjTZAaoL7Dxp9a4mhq/oNzARb4sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725899444; c=relaxed/simple;
	bh=SijMxlPS2d+y1Q8eTo8Td1dmzevGnURxE5EkxDDjDjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bDURaWiYv/xBlzdyTagOp1VkN2aASQ3NHB9D1wj7+fV0jnlaMmfWfauiq3cu4r7q+ZBfyZKkh0UtwPdTVtJGaY+4ujUlkSreGKVWO9ERORYBzjPa+8AaHxYm8+a7OSVxQ/tU7rDoaSel5OzhtHbj+fGZLrRy7xc/dJJp9Ppt7Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iVoKh7Bt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2360C4CEC7;
	Mon,  9 Sep 2024 16:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725899443;
	bh=SijMxlPS2d+y1Q8eTo8Td1dmzevGnURxE5EkxDDjDjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iVoKh7BtDABa4TTEUYl0bfbva4OeD+0ythCEfgZUnHLQqMkxLheT263aYiFhhx678
	 pu7Qc++6CJRxThHZeJHmK1YSf4M9dCGtMiFy5mZKLzk0iuljH+/93rd1CWVtCYnyf2
	 KEwAZ1Ydq11k7sUW7+g/eSqldyAsDw9v62mLylhjU/RiirgNxbYAbyBFsbvNc5HS7s
	 sIweFNbnwxMrStZGYnX/ZrzGT/7hcJtH+gS2H6fHmAo3K5AyXe04K/U3+QTv0bTEMG
	 014JGGm1utlAEcv44sVX7kUX0KRetGBwD+6iOoG3d2H0aQ3GNn3uCBPVQ4eMnNz/CS
	 hJQoWv5iGHvcA==
Date: Mon, 9 Sep 2024 17:30:38 +0100
From: Conor Dooley <conor@kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
	Michal Simek <monstr@monstr.eu>, Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org, Dinh Nguyen <dinguyen@kernel.org>
Subject: Re: [PATCH 06/15] riscv: migrate to the generic rule for built-in DTB
Message-ID: <20240909-trial-composer-83d5f5cc4fc6@spud>
References: <20240904234803.698424-1-masahiroy@kernel.org>
 <20240904234803.698424-7-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1zmht3JeO8heTtkb"
Content-Disposition: inline
In-Reply-To: <20240904234803.698424-7-masahiroy@kernel.org>


--1zmht3JeO8heTtkb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 05, 2024 at 08:47:42AM +0900, Masahiro Yamada wrote:
> Select GENERIC_BUILTIN_DTB when built-in DTB support is enabled.
>=20
> To keep consistency across architectures, this commit also renames
> CONFIG_BUILTIN_DTB_SOURCE to CONFIG_BUILTIN_DTB_NAME.
>=20
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--1zmht3JeO8heTtkb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZt8irgAKCRB4tDGHoIJi
0trhAQDqKRWWntMPCunsAaxopzU2jYVbAtsCUiJEW/z2j58/yAD7BJE6vqDg5O7Y
VqGnVulUhYdkydfA4mgszdVz6GVWzQQ=
=QBvD
-----END PGP SIGNATURE-----

--1zmht3JeO8heTtkb--

