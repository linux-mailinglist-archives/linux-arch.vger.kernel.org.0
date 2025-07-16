Return-Path: <linux-arch+bounces-12809-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2F8B07632
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jul 2025 14:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9C517BC280
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jul 2025 12:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB88B1891AB;
	Wed, 16 Jul 2025 12:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Es7KLKRN"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8216C170826;
	Wed, 16 Jul 2025 12:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752670230; cv=none; b=lqAqUkBhX04uQRpCfSImCTLTWP9dRbHdgA07TTWRS7RTd64o19Kj0Bx41k+DyjJpVIRr3B7pgyIRav7eYMP7lGG400wLtCOsm5P3qqJY4LaXwTsQBawE7xLxR/41FVP91CLvCGHt7gSMtv0fHMX9npbzB5Jzk//QZ8GjYJqLx4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752670230; c=relaxed/simple;
	bh=PbBIYKj8a/DhaiHCqQ0+OmhTdUwsQip8rGJvIcX1TpI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bJ92pM2gbqr9zjh2Cy772WP0Y43hg80AADIZi5p2bjbw5niUMhjPPbQiEk044IpG07ZT3Ixz9c600uEJSWO3aDTF9ljQFaEU0QTi0hKjW9Bn9VF9dvyv0iCxaNfhRxn+YAZvy/4oshkcSBhSXVEcvx2PAt2BTm4a5iogu83J+gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Es7KLKRN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B03F0C4CEF0;
	Wed, 16 Jul 2025 12:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752670230;
	bh=PbBIYKj8a/DhaiHCqQ0+OmhTdUwsQip8rGJvIcX1TpI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Es7KLKRNP2SKOx0Ri4M994NG+tynvzW1d+7SwEfzYzSZoq+V4OAy/+oX15BBNlZ5d
	 yJz/vbVxZLi+w99DAPZUX6NuLfnsvR3x4l8E3zKn2Sa5tYaoHJddimLDs1L03UXfg/
	 7J5HofYlNMtND7M296kuLs/Bze4OKA3ogXD7dqGf/vise6f++any8r5UhGVXsNY53L
	 Y2+RW5vf18zXVlzpogliFFent0DVWcz5MLU8n+vUdE1tyklFDOKGXY74S5TKaPdqRd
	 nic2gUlE2k5dzLq/JQNfMP+SueV0cbfmydFOlQfwl02Dg4Y1DyRr1c3dgAXFy42JV+
	 o8d+4HMT5feTw==
Date: Wed, 16 Jul 2025 13:50:22 +0100
From: Mark Brown <broonie@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
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
Message-ID: <3a9504d1-2c6a-459a-a98e-3010d34b546c@sirena.org.uk>
References: <20250701-vdso-auxclock-v1-0-df7d9f87b9b8@linutronix.de>
 <20250701-vdso-auxclock-v1-6-df7d9f87b9b8@linutronix.de>
 <02bcd954-5323-4663-a766-f53c67c5a18f@samsung.com>
 <CGME20250708154921eucas1p1fd8fa4374610a991ca5c67bd612ca0c2@eucas1p1.samsung.com>
 <e8c6b9a7-eaa6-4947-98e1-9d6fecc958d4@samsung.com>
 <20250709092958-37148883-ed89-40fe-8cd5-ded5dd60957e@linutronix.de>
 <eb5feef3-0a7d-438c-9dbb-00d1d72fad66@samsung.com>
 <6bee5ae0-2a9e-4793-a5bd-9e6c72b03f27@sirena.org.uk>
 <20250716142933-41089f40-0628-4821-83a3-fddbd4c4f9bf@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x0KSMljrFH4DixiE"
Content-Disposition: inline
In-Reply-To: <20250716142933-41089f40-0628-4821-83a3-fddbd4c4f9bf@linutronix.de>
X-Cookie: osteopornosis:


--x0KSMljrFH4DixiE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 02:34:52PM +0200, Thomas Wei=DFschuh wrote:
> On Wed, Jul 16, 2025 at 01:25:06PM +0100, Mark Brown wrote:

> > This issue has been present in -next for a week and is causing a bunch
> > of disruption to tests that end up relying on the vDSO - do we have any
> > news on getting a fix merged?  Perhaps it makes sense for Marek to just
> > send his patch so that it's there if needed?

> That fix has been in -next since next-20250710.
> If you still have issues, I'll take a look.

Ah, sorry - I'd not seen followup mails in the thread and was still
seeing issues that appeared at the same time that had previously
bisected here.  One is:

| INFO: Generating a skipfile based on /lava-4170058/1/tests/6_kselftest-de=
v-errlogs/automated/linux/kselftest/skipfile-lkft.yaml
| fatal error: nanotime returning zero
| goroutine 1 [running, locked to thread]:
| runtime.throw(0x132d83, 0x17)
| 	/usr/lib/golang/src/runtime/panic.go:774 +0x5c fp=3D0x42c7a4 sp=3D0x42c7=
90 pc=3D0x3b740
| runtime.main()
| 	/usr/lib/golang/src/runtime/proc.go:152 +0x350 fp=3D0x42c7e4 sp=3D0x42c7=
a4 pc=3D0x3d308
|A runtime.goexit()
| 	/usr/lib/golang/src/runtime/asm_arm.s:868 +0x4 fp=3D0x42c7e4 sp=3D0x42c7=
e4 pc=3D0x645dc
| ERROR: skipgen failed to generate a skipfile: 2

I'll just kick of a clean bisect for that and see what it comes up with.

Full log:

  https://validation.linaro.org/scheduler/job/4170058#L2215

--x0KSMljrFH4DixiE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmh3oA4ACgkQJNaLcl1U
h9DwZwf9E3TvH0p7biRSX/IC0rBSEc74B1Z8w9/tFm7w3pkwqx9Bi9cbfN7bl95N
XOCtYoDsnXINhVSynYuPURgHY6hKbntS4r4UaS1e3+3Z+TTgjfbvvDp/3s3Aj0tO
bdu/c6Ip8Zy22FmmcZJKm1PoPwDG0OZrl0dgCBy1xCKCj0jkxRsiu+0q+oAxDHl9
8K0V7oUITUtblhOVc4ADk3ESHRXuNBhPqRBGFS4E0CgVunCpOdND1T1jg2AqLDad
3hVOXuoe1FcKXPd9+6Cvq5bQYEZtALZDoWl/Re4gVc0c2N4CVyzPei/29w00gBO8
3TKIiTL2tMB/0gkgpIGv2gqsHILS4A==
=NGo9
-----END PGP SIGNATURE-----

--x0KSMljrFH4DixiE--

