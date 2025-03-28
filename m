Return-Path: <linux-arch+bounces-11177-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA04DA74C5D
	for <lists+linux-arch@lfdr.de>; Fri, 28 Mar 2025 15:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B1C73AC3D2
	for <lists+linux-arch@lfdr.de>; Fri, 28 Mar 2025 14:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00EC31B0F33;
	Fri, 28 Mar 2025 14:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IaOtsJF9"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45A320DF4;
	Fri, 28 Mar 2025 14:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743171643; cv=none; b=GYznc3a6x/aTo9FEHyVgyIKR9RyJ2do9gOTcgRAXOc7zh6ogZJntX5T+ZOmBuWaHIDucRxVlHAE/iHsuv3VoUNBJOPBOiwdhwP8d7GWlohVx7FnxC8HCi4R817AJCnSHSVXAgTbv3vPJ15nr45TtC+8FrDztD/A+Gg5i4HJYzSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743171643; c=relaxed/simple;
	bh=52BY8RWxqGI39nW50Uzq7mTE1cOGjvlmsJ2EgrcA9Ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IyIZ4ksWzfXecLRpI5w96HRhKym3gE31WGakAx4FqyNw4tRSn+V7yS+Dz0zD+s0Up40zBLqGVgxfv837chs9+RjiaVJNqpUF30f0AfYGM2HTZ8ewlQ1IdRg1J5Dn8vWXQEUYhAXvpWj72TqdPh42uqoexrZLGXMzNpMeYna6ajA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IaOtsJF9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00DECC4CEE4;
	Fri, 28 Mar 2025 14:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743171643;
	bh=52BY8RWxqGI39nW50Uzq7mTE1cOGjvlmsJ2EgrcA9Ec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IaOtsJF9a/s3cBIUbR9Tqvn77dZbDpoeNbSKE+9o5W+xe5prQl6V2XimIGQqSPRYd
	 5VfjWfPhjXQLQfEz78hahUx8cEJL7qeI4fFnehitos4eSBhlzGDfRRklcoYjvM/zc3
	 wbOkObSERHHtODK1mOYAW8F2H76k54tegqVkAAw/dIGbiwRQ5/s/wDw9UA3HpXwpf8
	 0B2Nl82gf//PCjWjulAvtdo/KBcAQt6O9NX5qL98eSrWMUgTqOVgFni+sgSnln2Z/C
	 cQUX/fNo/MyENG5iKFB3pgZGXINNHdL08ZXVTjV4NCT5SQEjBauHzWcBKsahMmFGDS
	 lPH6H7hIUumIA==
Date: Fri, 28 Mar 2025 15:20:40 +0100
From: Maxime Ripard <mripard@kernel.org>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Kees Cook <kees@kernel.org>, 
	Alessandro Carminati <acarmina@redhat.com>, linux-kselftest@vger.kernel.org, 
	David Airlie <airlied@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	=?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Daniel Diaz <daniel.diaz@linaro.org>, David Gow <davidgow@google.com>, 
	Arthur Grillo <arthurgrillo@riseup.net>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Naresh Kamboju <naresh.kamboju@linaro.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Guenter Roeck <linux@roeck-us.net>, Alessandro Carminati <alessandro.carminati@gmail.com>, 
	Jani Nikula <jani.nikula@intel.com>, dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com, 
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	loongarch@lists.linux.dev, x86@kernel.org
Subject: Re: [PATCH v4 00/14] Add support for suppressing warning backtraces
Message-ID: <20250328-visionary-archetypal-caiman-77dedc@houat>
References: <20250313114329.284104-1-acarmina@redhat.com>
 <202503131016.5DCEAEC945@keescook>
 <20250313-abiding-vivid-robin-159dfa@houat>
 <20250328.sah9oog5ahSh@digikod.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="paxtxmnckc7vplgu"
Content-Disposition: inline
In-Reply-To: <20250328.sah9oog5ahSh@digikod.net>


--paxtxmnckc7vplgu
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 00/14] Add support for suppressing warning backtraces
MIME-Version: 1.0

On Fri, Mar 28, 2025 at 11:38:23AM +0100, Micka=EBl Sala=FCn wrote:
> On Thu, Mar 13, 2025 at 06:24:25PM +0100, Maxime Ripard wrote:
> > Hi,
> >=20
> > On Thu, Mar 13, 2025 at 10:17:49AM -0700, Kees Cook wrote:
> > > On Thu, Mar 13, 2025 at 11:43:15AM +0000, Alessandro Carminati wrote:
> > > > Some unit tests intentionally trigger warning backtraces by passing=
 bad
> > > > parameters to kernel API functions. Such unit tests typically check=
 the
> > > > return value from such calls, not the existence of the warning back=
trace.
> > >=20
> > > Thanks for picking this series back up! I honestly thought this had
> > > already landed. :)
> > >=20
> > > > With CONFIG_KUNIT enabled, image size increase with this series app=
lied is
> > > > approximately 1%. The image size increase (and with it the function=
ality
> > > > introduced by this series) can be avoided by disabling
> > > > CONFIG_KUNIT_SUPPRESS_BACKTRACE.
> > >=20
> > > Yeah, as with my prior review, I'm a fan of this. It makes a bunch of=
 my
> > > very noisy tests much easier to deal with.
> >=20
> > And for the record, we're also affected by this in DRM and would very
> > much like to get it merged in one shape or another.
>=20
> Here is another case:
> https://lore.kernel.org/all/20250328.Ahc0thi6CaiJ@digikod.net/
>=20
> It would be very useful to have this feature merged.  Without it, we may
> need to remove useful tests.

AFAIK, it's been merged in next a couple of weeks ago, so it should be
in 6.15.

Maxime

--paxtxmnckc7vplgu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZ+awOAAKCRDj7w1vZxhR
xbs6AP9BZSaotqaSUmBTtc4k3Uj9az+ck0f+76K8QNHFnxjslgD/XFEDSUboHQ6N
QI2urzu11I1VyDIFnSJoU7c57HPzZQ0=
=XSrM
-----END PGP SIGNATURE-----

--paxtxmnckc7vplgu--

