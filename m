Return-Path: <linux-arch+bounces-5348-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DF292D255
	for <lists+linux-arch@lfdr.de>; Wed, 10 Jul 2024 15:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF0891F222D5
	for <lists+linux-arch@lfdr.de>; Wed, 10 Jul 2024 13:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937F019247D;
	Wed, 10 Jul 2024 13:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9hM2atZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5591619246A;
	Wed, 10 Jul 2024 13:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720616905; cv=none; b=eWCSlnyMa0SurAsX9MECYuiZBj8c971ZlxUT90K0AGJGfZD8RHGiobKLoze2GLZ2mjlbmVikCC9nPNdd+GTHDHq0QRp0SIlDno69SxmtKDeCigDYskWOHrxMHbAEVJbmtlfpBFyL5eQFOm3jIGn8ebIbpUcTCUs99JSMk80gT7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720616905; c=relaxed/simple;
	bh=20hAmUQJ5H0dqXfMYq7iNS/LgEwVNBfRSwX6Fbv7Rx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dF/l9j3q0AMiFLIr1MaYby7PsDj7jYFOk2tNhvDQPb8Kg6YBvJr9XrXsBlNYqARIDyJA5rv7RyfZ6+VIYrUQVMgAchHO2cejXS0Kdycm4CdwQ5dL5DvGXk57urfYEiMRUj6in7PIJ6lYGYL23nImY/ItBlzlag624bYDStWRwJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S9hM2atZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6311EC32782;
	Wed, 10 Jul 2024 13:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720616905;
	bh=20hAmUQJ5H0dqXfMYq7iNS/LgEwVNBfRSwX6Fbv7Rx0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S9hM2atZ5ZFhaUOVjx6PR2HXOtRcW2QNjebxTAoB2FvvbNZ4PvOIsIwpDlPboosKj
	 aUtUzXLMfzd0O5DHyr4sCCAr1JRNez2zaVxXGyiPdJVbKNb37V2ly+VVxzpMDXgG/0
	 yLekhO+MGKNgwADbhYOjSo5b4rpMXYgWwoL2bNSCBQKmOvzvqtC3rwJbQrGVvORCEw
	 J4pHDoVTPveEEH9d10qvcPrL+POj3GC5r8YQvSmPXeVF0PMmlfQ/MZUMEctcHXW0qy
	 0yxxDbGN2tLa8mdEVPGQM3LjZRro94QHKN4+ZoTczDbhEko0b/JGYs5RGeGNJyt6+s
	 scOo6mzmOh59Q==
Date: Wed, 10 Jul 2024 14:08:15 +0100
From: Mark Brown <broonie@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>,
	Linux-Arch <linux-arch@vger.kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, guoren <guoren@kernel.org>,
	Brian Cain <bcain@quicinc.com>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>, Dinh Nguyen <dinguyen@kernel.org>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Christian Brauner <brauner@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
	"linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>,
	linux-riscv@lists.infradead.org,
	Aishwarya TCV <Aishwarya.TCV@arm.com>, shuah <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 10/17] arm64: generate 64-bit syscall.tbl
Message-ID: <Zo6Hv18S35K0hH_7@finisterre.sirena.org.uk>
References: <20240704143611.2979589-1-arnd@kernel.org>
 <20240704143611.2979589-11-arnd@kernel.org>
 <c8c882ad-d508-40b7-9af5-b2a2ddf777c1@sirena.org.uk>
 <93c84e97-b307-4486-8dfb-e966c96751a1@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LdSnlI4UojlRSCq3"
Content-Disposition: inline
In-Reply-To: <93c84e97-b307-4486-8dfb-e966c96751a1@app.fastmail.com>
X-Cookie: Your love life will be... interesting.


--LdSnlI4UojlRSCq3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 10, 2024 at 10:57:25AM +0200, Arnd Bergmann wrote:

> Thanks for the report! I just panicked a bit and thought I had
> done something entirely wrong here, but after having a closer
> look it turned out to be a silly typo:

> -#include <unistd_64.h>
> +#include <asm/unistd_64.h>

Doh, I should've spotted that even from the very quick look I gave it!
Thanks for the quick fix.

> I checked that arm64 is the only architecture that has this
> particular bug, and I tried building kselftest now, which seems
> to work better. There are still a few warnings and errors
> I get doing that, but I suspect those are all preexisting
> issues.

Yeah, not everything there builds cleanly (and there's a bunch of
external deps you need for many of the suites).

--LdSnlI4UojlRSCq3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmaOh74ACgkQJNaLcl1U
h9CcQgf+N85DM6dZVHX8s5b4IoK8zBscjfKv6tCiwPcVRTNMH1dJqkR5LYNpb1am
KnuwKdCAcqascCbdmTx6ZzWDw52YDXohUbXSLkof3qyp5Js5aEyrs51UQTogwoi4
kW2K0EYgg4Wk0OF5Fe2Iq2ITXeoZ9O++joUeRHwXE9hSesKKiM+kZoHBaKHFQf8G
KDEhNvrFyrB2F9RDVIHcqt7IlySirRkKj8aWx9Dytd3Z8QtLv8rI6mbWZQ17ym4y
zDuDf4710dlhVUmR8eYF+JeHyJGcKQMF1BZAqwIkxQHuuP8uaNfhIR/rSOL1okjv
4LFBmMQqolC9ttdMprhk/DBLuxJAwA==
=NATo
-----END PGP SIGNATURE-----

--LdSnlI4UojlRSCq3--

