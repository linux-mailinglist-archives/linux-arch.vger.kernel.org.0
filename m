Return-Path: <linux-arch+bounces-8279-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BDF9A4653
	for <lists+linux-arch@lfdr.de>; Fri, 18 Oct 2024 20:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5F2BB215BD
	for <lists+linux-arch@lfdr.de>; Fri, 18 Oct 2024 18:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F95A2040A2;
	Fri, 18 Oct 2024 18:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8p/V7BV"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E10820400F;
	Fri, 18 Oct 2024 18:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729277855; cv=none; b=r6V3/SAcKP0i31sAnUExDMRtuaU0IeT0aXc+/i5kkHsyCejQWcw5iQPbVDyaaUgNkU0NGbXgJhLamPKi5o+9Dl8/+GsSCl7YGdyLvS0KTKRyBEwwh0pOPkIJiNnYh5Z8Of15KcQNBcaFJQO1gFPvH92UUcA/b4x8MNTuMep9Mw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729277855; c=relaxed/simple;
	bh=USwZBd/rmQ4xGvXvT/P1fJ09lLr7kVzbXZdNBQ3+LQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RHqtc6u0dyn0WgwdephNSfPCt8N2YMHDYqfmSF1WCTYuoTRhAOlKyKWCVoUrKRaBHCQV+xL+nxFySHI5ul9hGNLU/bTCIh4S7YrNMr6E9T9Cw02A5VHJUraW9EyJLtWifWecHmzW5LpfJbOGdZWba3vN1x4NJe/+XApvnsPm/6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8p/V7BV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E839C4CED4;
	Fri, 18 Oct 2024 18:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729277854;
	bh=USwZBd/rmQ4xGvXvT/P1fJ09lLr7kVzbXZdNBQ3+LQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d8p/V7BV9R5bv/BfDflLo5c3tZfdN++v+8FDLdPwvRIUNhpVdCKrwfx3ZhzYIBBoL
	 0ysAxmqq6VxKdnMDowczfEE4iLFgRsjBQ2sg7WpucVGrtlDKJF0dDwHAJstYJYOyrU
	 DwG9HYrZlXnxXvd17vXwqMU5sBdF4IuvNJKEFJq2BTtGPe2hPSji38r6iqSmctgecG
	 gekuuMP9GT54JXpLCT/hfZ0YED63bGLsxe+SCoelsauWdYjywYupTIiojk1hK7yABg
	 pvsG3iqbQ42lBLN/swfRU9WaiT3IwJcXkruF3m/hBbMZWz6fGlPM68cvZL0eb7Q52Y
	 exWIiOd0e8KhA==
Date: Fri, 18 Oct 2024 19:57:25 +0100
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
Message-ID: <104a3bf5-97ee-4c48-832f-df6c6e219576@sirena.org.uk>
References: <172892295715.1548.770734377772758528.b4-ty@kernel.org>
 <877ca5al86.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0RRAV7MzKbX8/czK"
Content-Disposition: inline
In-Reply-To: <877ca5al86.fsf@somnus>
X-Cookie: What is the sound of one hand clapping?


--0RRAV7MzKbX8/czK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 18, 2024 at 10:06:33AM +0200, Anna-Maria Behnsen wrote:

> Would it be ok for you, if the patch is routed through tip tree? kernel
> test robot triggers a warning for htmldoc that there is a reference to
> the no longer existing file 'timer-howto.rst':

>   https://lore.kernel.org/r/202410161059.a0f6IBwj-lkp@intel.com

It should be fine, worst case we just get a duplicate patch which
doesn't super matter.

--0RRAV7MzKbX8/czK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcSr5QACgkQJNaLcl1U
h9C6LAf/Qbwvy9NL2Gez+H9VVFae3GlPM9asUcMBaxp+uO7dhCUt0jnpy4Rf+uhV
aRnDHjTLb+zTbBwpy96DsJWJPVsRkJobSsCa/FwibRcFeIheFZBo0REddV9DuMst
/au9J4kG1E1c34bFhrulonNSkF8ebaVYLPfMH69+35eENFwXmFho5dT5usAsr/oP
vDK6Dll8oW1XdvTqbw3CPv8TCPLze4UN799DWoWtS96MCxKR7lNOI0X01GsSUMl5
GrYacHh5QPJICOAGcu7hqSds9wsAGz3zMSAQ9lrX+bZAOiCoDk0KcyIKLF3Pg7de
RcnbwA6aEI+sETc/tSshLKzUVeX5FQ==
=Qqcc
-----END PGP SIGNATURE-----

--0RRAV7MzKbX8/czK--

