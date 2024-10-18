Return-Path: <linux-arch+bounces-8280-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B69939A4658
	for <lists+linux-arch@lfdr.de>; Fri, 18 Oct 2024 20:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F73DB20FF3
	for <lists+linux-arch@lfdr.de>; Fri, 18 Oct 2024 18:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932DB204091;
	Fri, 18 Oct 2024 18:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLMksYF2"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409121865F3;
	Fri, 18 Oct 2024 18:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729277902; cv=none; b=Dhv3a85JWQHWHzwetQFcFCAPH43a9wNZSwnpo4EtJ5dCnXlOE+m1znveL7bBxCVZf5yFojkGkxNez2c8NQw1+Sf8Gt/H+jFPPZPXgG2hDfd7rxR9rQRrqZA/PGfWlnk2gJJg5TKG4q0iGVW+5hcgaTuK9zdKuGYF1D0JIFDiJS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729277902; c=relaxed/simple;
	bh=uNlY1sb7BVVXCcsMVu8Ynjn1FGT7oBovqYRNZBeSUEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GsBrc4mTr3xJ2uTLyvctdCdAENE6yoQt4xogmbp79/fhnxQNHfqVjvrM96B2ce73l9y0TdV9fzX02eaCzFCykVkgSDp6KSS8K/ID03h1MfQuTKgirOVFDwsxWMjaZhs5tHe+qwfPgKDlCaoQEYJQ6SYaPok2Y+1hX3Rk2yylx74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLMksYF2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 212B1C4CEC3;
	Fri, 18 Oct 2024 18:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729277901;
	bh=uNlY1sb7BVVXCcsMVu8Ynjn1FGT7oBovqYRNZBeSUEk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eLMksYF2A44sAVvXMLLc1QTO05aMjS+OBbVmUBAl+DMijULjAXZurx2DG/2ulaJIR
	 JoRrmGIMHs433yhhly72II6CWLzqRAVpX7aKU1mtpg6T0fpj7F2CGdBFMTHC73KR0M
	 8F7jBP38fFa63M2huQVX1hUtG6EE6PmoyBn8r99Au5V51HZQG1wKGt+XBJra9oGAv2
	 SEVoy+pa4Wl38FEIXcpvG6eG7DIbtbR/zHF0Hi6hn5WADwn4Sigjjt6iAGl732xv2+
	 HCewKfZmlZHMdZYDLFUn/NN8FFYPEobIhZ6ZTRSLzI73wByX7vcPT488drJ+4JFOBO
	 GIYxXYQDKHcTw==
Date: Fri, 18 Oct 2024 19:58:12 +0100
From: Mark Brown <broonie@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
	Len Brown <len.brown@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>, Miguel Ojeda <ojeda@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev,
	linux-mm@kvack.org, SeongJae Park <sj@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	netdev@vger.kernel.org, linux-sound@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nathan Lynch <nathanl@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: (subset) [PATCH v3 00/16] timers: Cleanup delay/sleep related
 mess
Message-ID: <8e079f25-658e-4671-9b3e-c3e46f36405b@sirena.org.uk>
References: <172892295715.1548.770734377772758528.b4-ty@kernel.org>
 <877ca5al86.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="P8JRaMzcXswSHEtS"
Content-Disposition: inline
In-Reply-To: <877ca5al86.fsf@somnus>
X-Cookie: What is the sound of one hand clapping?


--P8JRaMzcXswSHEtS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 18, 2024 at 10:06:33AM +0200, Anna-Maria Behnsen wrote:

> Would it be ok for you, if the patch is routed through tip tree? kernel
> test robot triggers a warning for htmldoc that there is a reference to
> the no longer existing file 'timer-howto.rst':

>   https://lore.kernel.org/r/202410161059.a0f6IBwj-lkp@intel.com

Oh, and for that:

Reviewed-by: Mark Brown <broonie@kernel.org>

--P8JRaMzcXswSHEtS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcSr8MACgkQJNaLcl1U
h9DpWgf/c8OCSZtN0/AmetsDqa/zvYT//zsqcY10Jl3YSsQgCEAIwkc0GWEdl0Bv
mAY3s/r8vi5dSXK1YARWoSlvYA0h0R7ysi9oKy/2HyZ4fo6uVT/S95tSH90rL8UD
IUtMu6N43Pak52+2hhGl4glVX5yDjXT4+8rMZjL8G9F07fXblzftyGP2G/HfkuJS
FJ36afHCl/AMmoe1TkGpHHOaOXVbPlukUtX6ZQFepWJjUiv/4YgoFxH8SVoyqP8W
ROEq86SWvagekQ5nzr8Jgn2DaWiFSN/e520uN6Qz8kELdR+fV/NquTsUmszeaZ+z
tnB/CGQgVUWV17Pn7WAs3w+eDCRuVQ==
=RPH6
-----END PGP SIGNATURE-----

--P8JRaMzcXswSHEtS--

