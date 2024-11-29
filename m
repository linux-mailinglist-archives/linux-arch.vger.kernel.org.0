Return-Path: <linux-arch+bounces-9190-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3919DC328
	for <lists+linux-arch@lfdr.de>; Fri, 29 Nov 2024 12:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67502B21C76
	for <lists+linux-arch@lfdr.de>; Fri, 29 Nov 2024 11:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C8A1991D2;
	Fri, 29 Nov 2024 11:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IenEB1RU"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C59133C5;
	Fri, 29 Nov 2024 11:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732881331; cv=none; b=an+FO2b6on0aex2/tEHdCmCpc2NZeiL9kvDYZNS4mjTF1y0TXb1UVYKZwoFRpNnOmBCiT4t9WS5kUptul2SJxCyFpNVkvn5KgeXiY9QkLTAvTtivPzd0588yyPXjnkqqxIC2iPHgIpWUz0aTIlxQyHm1pZgGWYJg1bLhnXwvUVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732881331; c=relaxed/simple;
	bh=PCwTZksW8jw/sIiLZC5grod741cJ0Qggc5kuzZnMjc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=im4j78O5lV2krjb9S7YhWt01mw46sFKa6DwhTf1OCwsX9r8wRfiwjV/hrK3vNjX/VQHiVg0/3fbuC8t94oPMO7UAye7sdmQKmxbxLwLjFPkDiDelQOdv8S+LwLrG9C7YVGN2AaOL/XBLIsgnqLmr698ykA1Gw1cTsBiPY1K0rfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IenEB1RU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3271BC4CECF;
	Fri, 29 Nov 2024 11:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732881331;
	bh=PCwTZksW8jw/sIiLZC5grod741cJ0Qggc5kuzZnMjc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IenEB1RUjTD2vJ2SdbTKEJqOBiPEdSJOudSSe17Uuf887IXYRMO3EYFhPG9pf2wmA
	 xjPPTBEzYLBJvZ9vx7XesuEoyDj9Z0uroTq3sAGGIxa5j38JUy5yrf98bTvklzvGI3
	 I7XH8S0gcprBYOl8xdwWkqDT3TIlN2IFWPzAmlrD1DmS1duYfpuryieGcKf2Bl8JPQ
	 BMkVbXNuT4qdiurJdAnb7ohcDXf9x8WII8Ww4N5z1Eyaw7JadxvrikcXT7k7Qt3kbx
	 leByzmM5MtgFlHrVFv5yJvx7+Ab6oownwSp1z+WF+gnHndKOtXioZWVy7YwOgOpdeN
	 2HZMXs9vgM9Sg==
Date: Fri, 29 Nov 2024 11:55:24 +0000
From: Conor Dooley <conor@kernel.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Guo Ren <guoren@kernel.org>, Alexandre Ghiti <alex@ghiti.fr>,
	Conor Dooley <conor.dooley@microchip.com>,
	Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Andrea Parri <parri.andrea@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
	Leonardo Bras <leobras@redhat.com>, linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v6 13/13] riscv: Add qspinlock support
Message-ID: <20241129-proxy-mantra-f58352723906@spud>
References: <20241128134135.GA3460@willie-the-truck>
 <20241128-uncivil-removed-4e105d1397c9@wendy>
 <90533aa9-186a-4f75-b3c5-d93d6682056b@ghiti.fr>
 <20241128-goggles-laundry-d94c23ab39a4@spud>
 <CAJF2gTST0kduYpuqd4mX0byetWMRJT-AAyH0GGiaysZG64Byhw@mail.gmail.com>
 <CAJF2gTRQg=w3sGN0Sdzf+_adRo44z4H6Zd6=C6qXq+ARR5BjSg@mail.gmail.com>
 <CAJF2gTSX82rGp-9xZHvg1Y3SpO516YCcqSBLKFgWEQ5G-iWR4A@mail.gmail.com>
 <CAHVXubgXiD5Bi6ytyDHXXOONovWHZTSvr4+oADCvuic5ObGXpQ@mail.gmail.com>
 <20241129-encrust-thumping-b6c6a3399b98@spud>
 <20241129-clay-trimester-91a0f281a95d@spud>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="B3rY1u54z6BEJe5L"
Content-Disposition: inline
In-Reply-To: <20241129-clay-trimester-91a0f281a95d@spud>


--B3rY1u54z6BEJe5L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2024 at 11:43:44AM +0000, Conor Dooley wrote:
> On Fri, Nov 29, 2024 at 11:18:24AM +0000, Conor Dooley wrote:
> >=20
> > I tried this diff, and it doesn't actually fix the problem - either in
> > QEMU or in hardware. I'll do some more poking.
>=20
> Looks like it might have been my fault, typo while hand-applying the
> diff pasted above cos it was corrupted :/ Rebuilding..


sans-typo, the diff does make it boot, my bad.


--B3rY1u54z6BEJe5L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ0mrrAAKCRB4tDGHoIJi
0o2cAP9wDMq1AIQu+yNhsWztBDTj6piw+4PfqFq1bQAAh9U/EwEAkLXlNZGUGStI
QBEc03DcU7n3hnf7FTsBRSBls8a6WQE=
=dKan
-----END PGP SIGNATURE-----

--B3rY1u54z6BEJe5L--

