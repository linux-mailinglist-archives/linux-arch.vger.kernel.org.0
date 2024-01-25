Return-Path: <linux-arch+bounces-1581-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA6683C3B4
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 14:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A72D1F26763
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 13:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08DB58AAE;
	Thu, 25 Jan 2024 13:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7EkuQn+"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F31855C1C;
	Thu, 25 Jan 2024 13:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706189560; cv=none; b=T4XcTmgmrWNyY/TMU/nXVAoKDQGPutFcYUpRqDwOEb+deA2ggk/GOCcjBDIl6x33O32MWd8egkL6TWqyr3kv7BMGxJq+Oy2ZMMiOETkAu7L5O7A9AT7NC99ffAgL6FnEP1Ge8X7vPvRCpIsitWAQevKpefDGDIxzZwtIPeofRmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706189560; c=relaxed/simple;
	bh=3R96qRyxPzgSVyuUboSnmRBbw7haewPcnwgYQUsDe7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F1/IuCw/fnH3+o5jAvxOfcy7P3jn099dP2ij86x7hIbkxs35sLcrbvXIkAyttnZgwC6NSYJ8VrZ8yJRhHY4khVklBxLyl3HUMbvs+O/E1PtrlHYOkdSx+UydbNTp+UNTbb2v4yUDG8jMrnPp7cR9BtJSBMVZyrF6OTNID00n+lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7EkuQn+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67A24C433B1;
	Thu, 25 Jan 2024 13:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706189560;
	bh=3R96qRyxPzgSVyuUboSnmRBbw7haewPcnwgYQUsDe7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l7EkuQn+M//U1ijcIFY+C6rD+IUNDKS/nZakN1huMCwakIIrNrc+7TRlXehoOznyP
	 aLAKgpjKik/C8fb7DjdBAwRuasqkbj8zAf9vDhWm3WYamjng533SSLi1etA7trOjKG
	 eEeZQA5D994kZuE8pSpNUU55K/nLwpgI+EACOFRmhUPAN6gXnDi63k9mIOP+MgR/Y1
	 tRVfjxttAjicOaFEOsIl+fneIUWf2qMtrzTMYX9S8h9Q1U6nPNZtg2jdAxzdbXZmF5
	 6pExpAXAIU/ZCMfOH45ZiPRlQGnCBnSKGP21Lgg/vxXItbm7VHW2PpzIIIdkchU6iy
	 cev+DT0Dmm5DA==
Date: Thu, 25 Jan 2024 13:32:33 +0000
From: Mark Brown <broonie@kernel.org>
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, andi.shyti@kernel.org,
	arnd@arndb.de, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	alim.akhtar@samsung.com, linux-spi@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org, andre.draszik@linaro.org,
	peter.griffin@linaro.org, kernel-team@android.com,
	willmcvicker@google.com
Subject: Re: [PATCH 19/21] spi: s3c64xx: add support for google,gs101-spi
Message-ID: <35ba5720-5629-49f1-b00c-af9620941136@sirena.org.uk>
References: <20240123153421.715951-1-tudor.ambarus@linaro.org>
 <20240123153421.715951-20-tudor.ambarus@linaro.org>
 <CAPLW+4=5ra6rBRwYYckzutawJoGw_kJahLaYmDzct2Dyuw0qQg@mail.gmail.com>
 <ab53dbc6-dad5-4278-a1d2-9f963d08eedc@linaro.org>
 <CAPLW+4njDgYO6bxVAL6hc-b_bVxjKcJnYpNGcNGpFsFg1LMc-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AcxqL1s+K3PbRcVC"
Content-Disposition: inline
In-Reply-To: <CAPLW+4njDgYO6bxVAL6hc-b_bVxjKcJnYpNGcNGpFsFg1LMc-Q@mail.gmail.com>
X-Cookie: Entropy isn't what it used to be.


--AcxqL1s+K3PbRcVC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 01:43:55PM -0600, Sam Protsenko wrote:
> On Wed, Jan 24, 2024 at 4:40=E2=80=AFAM Tudor Ambarus <tudor.ambarus@lina=
ro.org> wrote:

> > Using fifo_lvl_mask works but is wrong on multiple levels.
> > As the code is now, the device tree spi alias is used as an index in the
> > fifo_lvl_mask to determine the FIFO depth. I find it unacceptable to
> > have a dependency on an alias in a driver. Not specifying an alias will
> > make the probe fail, which is even worse. Also, the fifo_lvl_mask value

> Ok, I think that's a valid point. I probably missed the alias part
> when reading the patch description. I also understand we can't just
> remove .fifo_lvl_mask right now, as we have to keep the compatibility
> with older/existing out-of-tree device trees, so that the user can
> update the kernel image separately.

I don't really agree here, for a given compatible the FIFO depth is
known so it's redundant to specify and it's much simpler to correct
issues if we're not overspecifying things in the DT.

--AcxqL1s+K3PbRcVC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWyYvAACgkQJNaLcl1U
h9BlgQf/Xdw28Bk0fuzTPm7i+VBHJsXK9DXdWVOFi8ljHWjtPGlXeC4cZW2qkurt
Fe/famGMO9Iqn8cYs4yhUSxzSHyw89fa8LvDQ0CMc/cTknazpwVkhYTnLk/nfzfL
WnkW9ckkW5iYVRZllulIqEt/k//15OspS8RdqHjffQ7QliWo8LdbUVvOMwco7rf2
bngAQX/PZ6Q5RohNBaPxQa1sVfGf8HZ+ESdqYNS/cAr2Ogjv19cli3pDE3YtIXU9
bmImCIB4NttsvLu2gtrGb8zLLRzCN7ECwKxW+QBsBbCasi8uxgq0s7ytxhb4r93R
SN/VwfnJQJRWIDRrggTwPJErBlxbSw==
=+29v
-----END PGP SIGNATURE-----

--AcxqL1s+K3PbRcVC--

