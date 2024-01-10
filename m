Return-Path: <linux-arch+bounces-1326-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F31829BB1
	for <lists+linux-arch@lfdr.de>; Wed, 10 Jan 2024 14:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09F89B211AB
	for <lists+linux-arch@lfdr.de>; Wed, 10 Jan 2024 13:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EED5495D9;
	Wed, 10 Jan 2024 13:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1jPPPfb"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20F4495CC;
	Wed, 10 Jan 2024 13:48:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14496C433C7;
	Wed, 10 Jan 2024 13:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704894507;
	bh=Mpj9MmpWsZ0QXa3z+JG9y8iO9570kyRUme6G8UyY3ns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V1jPPPfbtZjWicjR/pXvV3fvfEd+WTpUYKesK1ver/unl0yUXsY4TkjQIutQjBRsP
	 rP/Oz0q/0h14UEjOgFaxFG624+eWlJ/AO+ivv3TYC1sZnL+hL4/+Alo/46tP000hXg
	 zplNZ64lLrfkj8J9hOzdzzP2smKm7MeEZ/IYISeNp94tvvX509RdtM1WHeyhjMm5jx
	 6PVp6J9lR2f0adpYnosG4kNDW+C6yKAzSmFoUpH39oONuTUSb402zXo2PYbzqdDyDw
	 8BKfIvBQaR2VfeSzJy9k28uur98lcaUtFQRjhOYk1Xziu9Q+q1jecwOjEuD67FrH9y
	 AnuUlci6GEj1Q==
Date: Wed, 10 Jan 2024 13:48:20 +0000
From: Conor Dooley <conor@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: akpm@linux-foundation.org, llvm@lists.linux.dev,
	patches@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	kvm@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-efi@vger.kernel.org, amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
	linux-arch@vger.kernel.org, kasan-dev@googlegroups.com,
	linux-mm@kvack.org, bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/3] arch and include: Update LLVM Phabricator links
Message-ID: <20240110-apostle-trident-533d4c2c9c97@spud>
References: <20240109-update-llvm-links-v1-0-eb09b59db071@kernel.org>
 <20240109-update-llvm-links-v1-2-eb09b59db071@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="p6SYI+U6gP5vpK1M"
Content-Disposition: inline
In-Reply-To: <20240109-update-llvm-links-v1-2-eb09b59db071@kernel.org>


--p6SYI+U6gP5vpK1M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 09, 2024 at 03:16:30PM -0700, Nathan Chancellor wrote:
> reviews.llvm.org was LLVM's Phabricator instances for code review. It
> has been abandoned in favor of GitHub pull requests. While the majority
> of links in the kernel sources still work because of the work Fangrui
> has done turning the dynamic Phabricator instance into a static archive,
> there are some issues with that work, so preemptively convert all the
> links in the kernel sources to point to the commit on GitHub.
>=20
> Most of the commits have the corresponding differential review link in
> the commit message itself so there should not be any loss of fidelity in
> the relevant information.
>=20
> Link: https://discourse.llvm.org/t/update-on-github-pull-requests/71540/1=
72
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---

>  arch/riscv/Kconfig              | 2 +-
>  arch/riscv/include/asm/ftrace.h | 2 +-

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--p6SYI+U6gP5vpK1M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZZ6gJAAKCRB4tDGHoIJi
0mIlAQCj5ZP6QEhEswWYjX38obn/p3pF8mt+Ve+vlBnVEhAW8QD8ClRvKxDiajR5
Zp8ES/FLDyH/QJ5QjGuYLP5PATLeFAY=
=SqXc
-----END PGP SIGNATURE-----

--p6SYI+U6gP5vpK1M--

