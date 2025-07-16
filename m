Return-Path: <linux-arch+bounces-12805-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 913ABB07587
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jul 2025 14:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B25BF1C24056
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jul 2025 12:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5892F4A0E;
	Wed, 16 Jul 2025 12:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QgJX3G9s"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB4428C00D;
	Wed, 16 Jul 2025 12:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752668714; cv=none; b=O+241b7cU1w/cd/L8BCCk13KYjfITSO/9MjPfEadDmLrMWA+83fCDYY7LgPOSdam9Plt5q5iAY34bZj55C8eplQV3zVLNNNTWOj9z3NdUcbqNf8ynMpCY7crYpGhHZVxpoNzhkyxQbr+oI6hrmijUVnJ35jux3EyIotiDVdRgZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752668714; c=relaxed/simple;
	bh=HnQuLJNDufQH+NJlbQVdqNkKpgfX14m2aqApSayEub4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RPRZcXpqRcTTtVDsb8TfLfHD6vLeKygCf342fs6mbXdufu2Th1V99+GeEVFe5/ttVUyQF67aUYLmy/M8z+x8O2n8cN96yYNQ/DpKfFndR5QZq5tp0A1tKeoz+0CHV2lNrBONdC/U2ja+nWmQBlB+MVlx/vddQsS+tKb+BUEjxDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QgJX3G9s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5AE5C4CEF0;
	Wed, 16 Jul 2025 12:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752668714;
	bh=HnQuLJNDufQH+NJlbQVdqNkKpgfX14m2aqApSayEub4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QgJX3G9spBWVSY9bG71ob2ZdWIzMqINBff/MyCdEsAXrwOch57QR2aWxrKym9gciS
	 CBHU2pYV6dwDYQZnptW+cK//5/KsuSwlgF3tKa/v2XAM9N0qdzYDRt7Q71aLzbPMIX
	 BTtX6PMwdPaepW5PYcwf+OIVjqHEfw5jxIUUcE8w9M/7cAGgJ1OmAylteTWXr8JGbl
	 JwdslBkcElxlRgDIbn0Mf29UYeI4cMfr6O3RqFJU1YIiNsc702r+jss9RXIrj9ZnIe
	 NV5wqTm2rAZkyyGX6BTctfD5e3pdKHBTAvvNj8Bz0EzjrG9iS7bD8YLSj5l49e/fCX
	 IsmbUVLNbBsZw==
Date: Wed, 16 Jul 2025 13:25:06 +0100
From: Mark Brown <broonie@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andy Lutomirski <luto@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Shuah Khan <shuah@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
	Richard Cochran <richardcochran@gmail.com>,
	Christopher Hall <christopher.s.hall@intel.com>,
	Miroslav Lichvar <mlichvar@redhat.com>,
	Werner Abt <werner.abt@meinberg-usa.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Nam Cao <namcao@linutronix.de>, Antoine Tenart <atenart@kernel.org>
Subject: Re: [PATCH 06/14] vdso/gettimeofday: Return bool from
 clock_gettime() helpers
Message-ID: <6bee5ae0-2a9e-4793-a5bd-9e6c72b03f27@sirena.org.uk>
References: <20250701-vdso-auxclock-v1-0-df7d9f87b9b8@linutronix.de>
 <20250701-vdso-auxclock-v1-6-df7d9f87b9b8@linutronix.de>
 <02bcd954-5323-4663-a766-f53c67c5a18f@samsung.com>
 <CGME20250708154921eucas1p1fd8fa4374610a991ca5c67bd612ca0c2@eucas1p1.samsung.com>
 <e8c6b9a7-eaa6-4947-98e1-9d6fecc958d4@samsung.com>
 <20250709092958-37148883-ed89-40fe-8cd5-ded5dd60957e@linutronix.de>
 <eb5feef3-0a7d-438c-9dbb-00d1d72fad66@samsung.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rZ9x4sZFElGFq5dB"
Content-Disposition: inline
In-Reply-To: <eb5feef3-0a7d-438c-9dbb-00d1d72fad66@samsung.com>
X-Cookie: Trouble always comes at the wrong time.


--rZ9x4sZFElGFq5dB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 09, 2025 at 10:04:21AM +0200, Marek Szyprowski wrote:
> On 09.07.2025 09:34, Thomas Wei=DFschuh wrote:
> > On Tue, Jul 08, 2025 at 05:49:18PM +0200, Marek Szyprowski wrote:

> > This fix looks correct to me.

> > tglx:

> > Are you going to fold the fix into the commit or do you want a proper p=
atch?

> > Marek:

> > If a new patch is required, do you want to send it? You found and fixed=
 the
> > issue after all. If not, I'll take care of it.

> If it is possible to fold it into original patch then go ahead, it would=
=20
> make less noise imho. If you need a formal patch, I can send it in a few=
=20
> minutes.

This issue has been present in -next for a week and is causing a bunch
of disruption to tests that end up relying on the vDSO - do we have any
news on getting a fix merged?  Perhaps it makes sense for Marek to just
send his patch so that it's there if needed?

--rZ9x4sZFElGFq5dB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmh3miIACgkQJNaLcl1U
h9AwsQf8Dh4Am3MMQ0T4kXwpbSzQlrBQ4irGhUtIF5FnACyGfWqHDPzRIY90+ktY
swfIUjZlYKOGsj4YFd0rx2Bvz7iqtVIaBWbDvwSLZHn9QSwBrWV/+p4tb+z7BZCv
CHvdRfuI4lshyLOAV/kRok5EZIIJo7NjT7DmNTlB6ihRNhPPyEL2SNnSYuUBf7z0
0zixH/gSQcD/7J13PVFQywUxWp3c3h6mhQF+ulqEMBI7H4y/EqrvgVkFFx+Od0kt
LVx2o34PMyloMfc63TnCSYJPGZTpYfmAl/aXeoZ2uPekpvhwG2KlIIlEz0cVUKQl
/dVL2JSUa+QaMUyxqvPtOobl6/XukQ==
=5BAm
-----END PGP SIGNATURE-----

--rZ9x4sZFElGFq5dB--

