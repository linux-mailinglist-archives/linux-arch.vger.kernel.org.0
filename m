Return-Path: <linux-arch+bounces-11188-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A7EA757F3
	for <lists+linux-arch@lfdr.de>; Sat, 29 Mar 2025 23:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 236023AC172
	for <lists+linux-arch@lfdr.de>; Sat, 29 Mar 2025 22:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938081DE4D2;
	Sat, 29 Mar 2025 22:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="LPcheZpm"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A6718BBA8;
	Sat, 29 Mar 2025 22:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743286200; cv=none; b=gugblCd59AV0bJuleKcHbCpsgzRj54UFQ8a1NvZK+TFOYx3Ag5ZbPuqbqB+61MWXbeM17nVmktUOgrLwKKkTJgHE2g0a4FfjDznfVmRnxyp0nV5tKseAIqXhx4Ev8pQ9OAkAj1eFXoLtEjeq17QK4BnOKb3u+/Da4Pi70hZyg7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743286200; c=relaxed/simple;
	bh=sGUeygAZUCaVivsjULZD/E86y2O37vmLM5Cqp7eRfCM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I2rUKWZ8oNJwEbuJzdT2yX6g49NgXi17Shczgbc8Sj110OAI+SJK/9/IdpkPpu3nsjoheiNxv6x60XV4SsfyQGuIG1iXRYWsY4c+BTcr/7+c+V2hWFlRarFmMLSC37dpdsw3LYQgeU3rMIb8dNBVMwbPq6LUsOuVXcQaihyGHp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=LPcheZpm; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=202503; t=1743286193;
	bh=TSrXCN10LxvinHZFJvppglU0ohO08fr4kTSwHDOmZg8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LPcheZpmeUhF/uz3TQCswx3B8fIRGuKJYz4+bqGflUWCl7tqjCfvADH+Ef9cpM1Iq
	 b8MsCKIOjdVkvy188j96AIn3coeq/xKJejv5EXrqAg+rTZowELbVV+UqfjvB8jJVEB
	 eJ+5I4eEcUJCXfw13QLLey25dakM7prh0DYlj+FyM3J9jjZVHqad8YdF1QbR9dYMXd
	 5ok11OYGMq8LrBDVeBHbnq1U240Y4HxWYEC4j1CJOYSecxgni1uxm+MZXp8p6bYI5o
	 E914X3DDOaTZt1FHfWN+aJTs2iORAENixiIdcijngEw8bFJosfRHdfAP+VN4vdUU01
	 eyh4wlMEw6OTw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4ZQBQP2N6vz4wcD;
	Sun, 30 Mar 2025 09:09:49 +1100 (AEDT)
Date: Sun, 30 Mar 2025 09:09:46 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Alessandro Carminati <acarmina@redhat.com>
Cc: linux-kselftest@vger.kernel.org, Dan Carpenter
 <dan.carpenter@linaro.org>, Daniel Diaz <daniel.diaz@linaro.org>, David Gow
 <davidgow@google.com>, Arthur Grillo <arthurgrillo@riseup.net>, Brendan
 Higgins <brendan.higgins@linux.dev>, Naresh Kamboju
 <naresh.kamboju@linaro.org>, Andrew Morton <akpm@linux-foundation.org>,
 Maxime Ripard <mripard@kernel.org>, Ville Syrjala
 <ville.syrjala@linux.intel.com>, Daniel Vetter <daniel@ffwll.ch>, Guenter
 Roeck <linux@roeck-us.net>, Alessandro Carminati
 <alessandro.carminati@gmail.com>, Jani Nikula <jani.nikula@intel.com>,
 Shuah Khan <skhan@linuxfoundation.org>, Mickael Salaun <mic@digikod.net>,
 Kees Cook <kees@kernel.org>, dri-devel@lists.freedesktop.org,
 kunit-dev@googlegroups.com, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-next@vger.kernel.org
Subject: Re: [PATCH] kunit: fixes Compilation error on s390
Message-ID: <20250330090946.3f7d0c00@canb.auug.org.au>
In-Reply-To: <20250329150320.331018-1-acarmina@redhat.com>
References: <20250329150320.331018-1-acarmina@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/WIRnLKoDx7qC7ang90AEz=l";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/WIRnLKoDx7qC7ang90AEz=l
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Alessandro,

On Sat, 29 Mar 2025 15:03:20 +0000 Alessandro Carminati <acarmina@redhat.co=
m> wrote:
>
> The current implementation of suppressing warning backtraces uses __func_=
_,
> which is a compile-time constant only for non -fPIC compilation.
> GCC's support for this situation in position-independent code varies acro=
ss
> versions and architectures.
>=20
> On the s390 architecture, -fPIC is required for compilation, and support
> for this scenario is available in GCC 11 and later.
>=20
> Fixes:  d8b14a2 ("bug/kunit: core support for suppressing warning backtra=
ces")
>=20
> Signed-off-by: Alessandro Carminati <acarmina@redhat.com>

Please keep all the commit message tags together at the end of the
commit message.

--=20
Cheers,
Stephen Rothwell

--Sig_/WIRnLKoDx7qC7ang90AEz=l
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmfob6oACgkQAVBC80lX
0GybxAf9H9ESwyhD70HQ69NJ+Nl9QTfMPqlHp3iI7S5xCMmQYhxEubw9tN0gwuqm
XPhDsYd5E+HWmFto3OHhhb/j1RIISTphA3Q4b3k2wJEfQIhZBxr0c/TKGksx2/4s
Dyi6/ZeLGYdsreC2DI4x+SiUUYKWXawMmKcXolS3uQgLwv/QLPtY7U6RoLbYSXTC
AznTMEPBDyUJqzbITKGSQBQ3YpvfVSj2tbPIxckLHWD7QLQ6HZf3RRSDwtMYoSEs
U3U9jr4uOlSWsfJkMRpaUBS9v1EZtTWxp22eBZCjOdBDzA+kTiP7CcpgJziILKQY
+SGFpT9uoGyFrJOiQMWK8lVoYFRdUg==
=AsrT
-----END PGP SIGNATURE-----

--Sig_/WIRnLKoDx7qC7ang90AEz=l--

