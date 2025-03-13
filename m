Return-Path: <linux-arch+bounces-10746-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4324A5FDB1
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 18:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D18519C4213
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 17:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE21B172767;
	Thu, 13 Mar 2025 17:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LvyGRkVE"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8E01624CC;
	Thu, 13 Mar 2025 17:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741886668; cv=none; b=WNc+IoCdOzosNRJayJMsc9XdNeCgF2T86fZjMMz6S09/WYA+mec5CJxV/V5FiY+gmRr9hXKLsR052zCRTVhu1EcT8JGAj1KWSLKZBMD7BSjRSeQW/jawNZBJsFdWRpcdDhROR2SuuDG9G+iCJKbcsQQGrVw/WZ8spOZRFY+saCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741886668; c=relaxed/simple;
	bh=9/zmAAvs9NnopuZELdGFf5m30SQkrIgaibjOTSU2/4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oF1MsDHDAL/hhXmpVhA3tZ1FD19XShI3STC8Qg7JFRNLi4tQzkfXHtHcqmtxku/05GNebJwR/0owXclIHMMaELLn5AlcOl74H9is2vR9WFrsDK7FIdgtR8Y22uHyBmiHWK/+LNUfQ0VRKiTsL5N+nuBZLbHHHNQXd8/6TbmiLFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LvyGRkVE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87C81C4CEDD;
	Thu, 13 Mar 2025 17:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741886668;
	bh=9/zmAAvs9NnopuZELdGFf5m30SQkrIgaibjOTSU2/4g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LvyGRkVE67SzBgb1QxytGP4oCaiDm1tJxrYa6S762f1uCVELy9kUizXLZYLA53dFI
	 LKB6AnaccFkz/obvqyj95f4NBc0qIbgjsCSr6injy9nOKRnZ631Nz5jY6vtJhqfK9W
	 lfOaWqXafcfENzy2fADO6wmw4xv83Pcbrnp64dabwgF4V67YDxdHN3robsRH2ge3my
	 yyXxef+KA/0d2CifdqcRiTFlknqGJdXOg+TWR6xgA6Yw9w3MkQfmaKGP78AmYUgaDq
	 AxdUBErN29IHX2+C/CRP8J164+HWq5+oXjim9xRBBRx3EWs4UmnF9OTuMnKZeD2CHi
	 43mLTvGtWzx2g==
Date: Thu, 13 Mar 2025 18:24:25 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Alessandro Carminati <acarmina@redhat.com>, 
	linux-kselftest@vger.kernel.org, David Airlie <airlied@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
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
Message-ID: <20250313-abiding-vivid-robin-159dfa@houat>
References: <20250313114329.284104-1-acarmina@redhat.com>
 <202503131016.5DCEAEC945@keescook>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="te6o3coodwf7546n"
Content-Disposition: inline
In-Reply-To: <202503131016.5DCEAEC945@keescook>


--te6o3coodwf7546n
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 00/14] Add support for suppressing warning backtraces
MIME-Version: 1.0

Hi,

On Thu, Mar 13, 2025 at 10:17:49AM -0700, Kees Cook wrote:
> On Thu, Mar 13, 2025 at 11:43:15AM +0000, Alessandro Carminati wrote:
> > Some unit tests intentionally trigger warning backtraces by passing bad
> > parameters to kernel API functions. Such unit tests typically check the
> > return value from such calls, not the existence of the warning backtrac=
e.
>=20
> Thanks for picking this series back up! I honestly thought this had
> already landed. :)
>=20
> > With CONFIG_KUNIT enabled, image size increase with this series applied=
 is
> > approximately 1%. The image size increase (and with it the functionality
> > introduced by this series) can be avoided by disabling
> > CONFIG_KUNIT_SUPPRESS_BACKTRACE.
>=20
> Yeah, as with my prior review, I'm a fan of this. It makes a bunch of my
> very noisy tests much easier to deal with.

And for the record, we're also affected by this in DRM and would very
much like to get it merged in one shape or another.

Maxime

--te6o3coodwf7546n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZ9MUyAAKCRDj7w1vZxhR
xdXjAQCCwQNRXUI4bvpTeTrsH0SDbsLYjlm1aQi9V/DpasrOoQD/cFET4LceVGmh
WT9gLea6FEbCN1GQ2T9KOoLGuMrzTAw=
=uGit
-----END PGP SIGNATURE-----

--te6o3coodwf7546n--

