Return-Path: <linux-arch+bounces-2999-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA9387BF78
	for <lists+linux-arch@lfdr.de>; Thu, 14 Mar 2024 16:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3F851C2154F
	for <lists+linux-arch@lfdr.de>; Thu, 14 Mar 2024 15:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D07471734;
	Thu, 14 Mar 2024 15:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GRtU3Red"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121985D75D;
	Thu, 14 Mar 2024 15:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710428523; cv=none; b=PDus+Tk+YjYt94VplUXPnLdpIgsh1PR00zJB7cJYIkky44IOkhq2eRNOlboeV0eTrBWKbpeHP6KflkHApmxCz3e139rQBB5MOLkWoGYiJXZp40ZAVL3Zlc4wGdOGFWJBw5xQGHPpZXqrUu+2Zk34flzaojJYbcEpmp8KLoLSGL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710428523; c=relaxed/simple;
	bh=M6nhtT/evAJaEm9Lfp2nSLULi/q0+AGWGYq3q98wPSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ExAEgEpP72s5xS3EpKsSRyFXbwaFE2ZgGcBINu6lPlw0SDWTzuOQFxEB4MIk4MgerUuv8/K/CCzaqipQmqD2tFbU+ZlgEI8qWZxjaSFCIjNgDa+/TrLJ7APqYJeoNsVVNws86dFg4JCiFGyUMtfMAVzy+02JTXgSOiM08QAh7d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GRtU3Red; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B709C433C7;
	Thu, 14 Mar 2024 15:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710428522;
	bh=M6nhtT/evAJaEm9Lfp2nSLULi/q0+AGWGYq3q98wPSs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GRtU3RedkF+6bGv6rzD962qdrdCPt5XDgiXEplTNKVxkNx+BIuJnWhNCE1d7fglx6
	 mD3/UhHdcLJkAegeGIp8aMtrgg1f0b/y3UcqWwJZgrDfVLPpuqICk/x/OHh10mfWf9
	 9YsckKa2LEMMFO1+nFohOEHh+n7JxokMvrZ7AY1lPZ93C5+da+53H8uiN9lkIsn/mG
	 PbIjyh8D25M/ryqLm3+qk7RRQZ75o0LR1Q14YeW1VbwFKaB6HUyEob0DHjjeglxh26
	 cOsiuXf/CpzhFvKk1cwkdBdstXFvCjaK7r6v+TsM8RvqXnl/V2kmn1OvsPAOnwiReg
	 I0c47dK/Lzi0A==
Date: Thu, 14 Mar 2024 16:02:00 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-kselftest@vger.kernel.org, David Airlie <airlied@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	=?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Kees Cook <keescook@chromium.org>, Daniel Diaz <daniel.diaz@linaro.org>, 
	David Gow <davidgow@google.com>, Arthur Grillo <arthurgrillo@riseup.net>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Naresh Kamboju <naresh.kamboju@linaro.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com, 
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	loongarch@lists.linux.dev, netdev@lists.linux.dev
Subject: Re: [PATCH 00/14] Add support for suppressing warning backtraces
Message-ID: <20240314-victorious-chupacabra-of-management-baa5c4@houat>
References: <20240312170309.2546362-1-linux@roeck-us.net>
 <CAMuHMdUkvagJVEfnhq=Nx2jnmdS0Ax+zy1CvyN0k7k1EwUpu+g@mail.gmail.com>
 <6d9269c0-bd38-4965-a454-4358e0a182e3@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nbx7v4z25kdu2nok"
Content-Disposition: inline
In-Reply-To: <6d9269c0-bd38-4965-a454-4358e0a182e3@roeck-us.net>


--nbx7v4z25kdu2nok
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 07:37:13AM -0700, Guenter Roeck wrote:
> On 3/14/24 06:36, Geert Uytterhoeven wrote:
> > Hi G=C3=BCnter,
> >=20
> > On Tue, Mar 12, 2024 at 6:03=E2=80=AFPM Guenter Roeck <linux@roeck-us.n=
et> wrote:
> > > Some unit tests intentionally trigger warning backtraces by passing b=
ad
> > > parameters to kernel API functions. Such unit tests typically check t=
he
> > > return value from such calls, not the existence of the warning backtr=
ace.
> > >=20
> > > Such intentionally generated warning backtraces are neither desirable
> > > nor useful for a number of reasons.
> > > - They can result in overlooked real problems.
> > > - A warning that suddenly starts to show up in unit tests needs to be
> > >    investigated and has to be marked to be ignored, for example by
> > >    adjusting filter scripts. Such filters are ad-hoc because there is
> > >    no real standard format for warnings. On top of that, such filter
> > >    scripts would require constant maintenance.
> > >=20
> > > One option to address problem would be to add messages such as "expec=
ted
> > > warning backtraces start / end here" to the kernel log.  However, that
> > > would again require filter scripts, it might result in missing real
> > > problematic warning backtraces triggered while the test is running, a=
nd
> > > the irrelevant backtrace(s) would still clog the kernel log.
> > >=20
> > > Solve the problem by providing a means to identify and suppress speci=
fic
> > > warning backtraces while executing test code. Support suppressing mul=
tiple
> > > backtraces while at the same time limiting changes to generic code to=
 the
> > > absolute minimum. Architecture specific changes are kept at minimum by
> > > retaining function names only if both CONFIG_DEBUG_BUGVERBOSE and
> > > CONFIG_KUNIT are enabled.
> > >=20
> > > The first patch of the series introduces the necessary infrastructure.
> > > The second patch introduces support for counting suppressed backtrace=
s.
> > > This capability is used in patch three to implement unit tests.
> > > Patch four documents the new API.
> > > The next two patches add support for suppressing backtraces in drm_re=
ct
> > > and dev_addr_lists unit tests. These patches are intended to serve as
> > > examples for the use of the functionality introduced with this series.
> > > The remaining patches implement the necessary changes for all
> > > architectures with GENERIC_BUG support.
> >=20
> > Thanks for your series!
> >=20
> > I gave it a try on m68k, just running backtrace-suppression-test,
> > and that seems to work fine.
> >=20
> > > Design note:
> > >    Function pointers are only added to the __bug_table section if both
> > >    CONFIG_KUNIT and CONFIG_DEBUG_BUGVERBOSE are enabled to avoid image
> > >    size increases if CONFIG_KUNIT=3Dn. There would be some benefits to
> > >    adding those pointers all the time (reduced complexity, ability to
> > >    display function names in BUG/WARNING messages). That change, if
> > >    desired, can be made later.
> >=20
> > Unfortunately this also increases kernel size in the CONFIG_KUNIT=3Dm
> > case (ca. 80 KiB for atari_defconfig), making it less attractive to have
> > kunit and all tests enabled as modules in my standard kernel.
> >=20
>=20
> Good point. Indeed, it does. I wanted to avoid adding a configuration opt=
ion,
> but maybe I should add it after all. How about something like this ?
>=20
> +config KUNIT_SUPPRESS_BACKTRACE
> +       bool "KUnit - Enable backtrace suppression"
> +       default y
> +       help
> +         Enable backtrace suppression for KUnit. If enabled, backtraces
> +         generated intentionally by KUnit tests can be suppressed. Disab=
le
> +         to reduce kernel image size if image size is more important than
> +         suppression of backtraces generated by KUnit tests.
> +

How are tests using that API supposed to handle it then?

Select the config option or put an ifdef?

If the former, we end up in the same situation than without the symbol.
If the latter, we end up in a similar situation than disabling KUNIT
entirely, with some tests not being run which is just terrible.

Maxime

--nbx7v4z25kdu2nok
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZfMRZwAKCRDj7w1vZxhR
xZe7AQCF0lwXl8k+ok+x1wLmfAsWf12MJtiFkJfF2M8fieBWywEA7IBXKWN1hKUp
6rSvzAgaLFB/0eisZYO9FXDq5sROGw0=
=qLwX
-----END PGP SIGNATURE-----

--nbx7v4z25kdu2nok--

