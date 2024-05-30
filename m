Return-Path: <linux-arch+bounces-4611-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2B18D4E34
	for <lists+linux-arch@lfdr.de>; Thu, 30 May 2024 16:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AF902853C1
	for <lists+linux-arch@lfdr.de>; Thu, 30 May 2024 14:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDFC17C202;
	Thu, 30 May 2024 14:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rMqCm59j"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8B9186E41;
	Thu, 30 May 2024 14:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717080198; cv=none; b=doygKFInDFA6VDRWJi0EO1nF6VlzdvT5HDTkxMSERUTZfbulUCq0TerToNFWgLPDozZh0EY1nD61EJTSX4RtB2k7Aqod86jor2n8lj9Ze+vskCwGxgOIBIO35nFKjaRM5+ZdRe0d+pyA8QCAJICO3eYgMT/5Ioz4QmYDwT7ERx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717080198; c=relaxed/simple;
	bh=e1+5dT8+B+5U3e3Q8tyccbJPxgYrjn+AJggCEUN5eR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pofB/bvF0PQcMnu7+MYUYGB2bb1dxHc8P8bsojgAJp9Sz2oiqfr9oG4J4EoyfC2ISPtHGjE/ZDctrak0yXmWkwL6LkFUslcyDvfPphHXcEOP5WufBcZXTHHP1vfDKHk56hnLVxyDhGxFLlQzoet9qUQFVN/wbE326/ZY8OX/Bc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rMqCm59j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BCAFC2BBFC;
	Thu, 30 May 2024 14:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717080197;
	bh=e1+5dT8+B+5U3e3Q8tyccbJPxgYrjn+AJggCEUN5eR4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rMqCm59jdJJs3oe/iUw0G8iGrR/MRYfg69+6CWrnvOzeO0sSmDV/qSTn4JOsREbqt
	 ioiNo2ilbyZh2ide5ehezgb6vZaOkWF82CKYvPEk5i6M55/5BCCZMuPRdlIyrVyrRX
	 YnJv3AAYzvK4+bMCdvVwWHIg/iNW94vqH0BBKJ/MoiHh/DtXB65jEuzVvptnjsD/q8
	 7OFIehwtJih9AEKdH/Tv/6a6wQGuaoKogH2S6gikRrqW1sELiWG43d5N+1ANytAD7M
	 L1PRhAtMU3r7ZJg78e95yOCCDzx5IK+r970c2em+lQesDcVAMygRm2c0R1U+GFTzJZ
	 RW2gQ1yTRFwZw==
Date: Thu, 30 May 2024 15:43:12 +0100
From: Conor Dooley <conor@kernel.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, Leonardo Bras <leobras@redhat.com>,
	Guo Ren <guoren@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/7] riscv: Implement cmpxchg32/64() using Zacas
Message-ID: <20240530-swear-espresso-563e3a19d7e7@spud>
References: <20240528151052.313031-1-alexghiti@rivosinc.com>
 <20240528151052.313031-2-alexghiti@rivosinc.com>
 <20240528-repaint-graffiti-ec4f0e038e5a@spud>
 <CAHVXubjk-2EAJ0U08p7uATkJM1_La94SVcVNLO5yieGbfqUGYw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="z9kbXMXV8iYZ4uhg"
Content-Disposition: inline
In-Reply-To: <CAHVXubjk-2EAJ0U08p7uATkJM1_La94SVcVNLO5yieGbfqUGYw@mail.gmail.com>


--z9kbXMXV8iYZ4uhg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 02:20:33PM +0200, Alexandre Ghiti wrote:
> On Tue, May 28, 2024 at 5:34=E2=80=AFPM Conor Dooley <conor@kernel.org> w=
rote:
> > On Tue, May 28, 2024 at 05:10:46PM +0200, Alexandre Ghiti wrote:

> > >  config TOOLCHAIN_HAS_ZBB
> > >       bool
> > >       default y
> > > diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> > > index 5b3115a19852..d5b60b87998c 100644
> > > --- a/arch/riscv/Makefile
> > > +++ b/arch/riscv/Makefile
> > > @@ -78,6 +78,17 @@ endif
> > >  # Check if the toolchain supports Zihintpause extension
> > >  riscv-march-$(CONFIG_TOOLCHAIN_HAS_ZIHINTPAUSE) :=3D $(riscv-march-y=
)_zihintpause
> > >
> > > +# Check if the toolchain supports Zacas
> > > +ifdef CONFIG_AS_IS_LLVM
> > > +# Support for experimental Zacas was merged in LLVM 17, but the remo=
val of
> > > +# the "experimental" was merged in LLVM 19.
> > > +KBUILD_CFLAGS +=3D -menable-experimental-extensions
> > > +KBUILD_AFLAGS +=3D -menable-experimental-extensions
> > > +riscv-march-y :=3D $(riscv-march-y)_zacas1p0
> > > +else
> > > +riscv-march-$(CONFIG_TOOLCHAIN_HAS_ZACAS) :=3D $(riscv-march-y)_zacas
> > > +endif
> >
> > I'm almost certain that we discussed this before for vector and it was
> > decided to not enable experimental extensions (particularly as it is a
> > global option), and instead require the non-experimental versions.
> > This isn't even consistent with your TOOLCHAIN_HAS_ZACAS checks, that
> > will only enable the option for the ratified version.
>=20
> Zacas was ratified, hence the removal of "experimental" in LLVM 19.
> But unfortunately Zabha lacks such changes in LLVM, so that will make
> this inconsistent (ratified extension but still experimental).
>=20
> I'll remove the enablement of the experimental extensions then so that
> will fail for LLVM < 19. And for Zabha, I'll try to push the removal
> of experimental from LLVM.

Ye, as Nathan mentioned there may yet be some time. It'd be great if you
could.

> > I think we should
> > continue to avoid enabling experimental extensions, even if that imposes
> > a requirement of having a bleeding edge toolchain to actually use the
> > extension.
>=20
> Would it make sense to have a
> CONFIG_RISCV_LLVM_ENABLE_EXPERIMENTAL_EXTENSIONS or similar? So that
> people who want to play with those extensions will still be able to do
> so without patching the kernel?

Maybe, but I think something like that should depend on BROKEN and only
be done when the extension hasn't had its experimental status removed by
a released version of LLVM and is not supported by a release of GCC.
Given we only allow frozen extensions into the kernel, actually having to
do this would be rather rare.

I think we should also reserve the right to drop support for the
experimental version as soon as it does get its status changed, and
depending on BROKEN would let us do that without any regressions in terms
of toolchain version support.

Yes, making the option depend on BROKEN would require patching a Kconfig
file but this would be a facility for kernel developers to test prior to
the release of a toolchain that actually supports the extension, and the
"hard" part in the Makefile to hook it up would already be done. I think
if you're capable of messing about with experimental extensions in the
kernel you're capable of also modifying a Kconfig file locally ;)

Cheers,
Conor.

--z9kbXMXV8iYZ4uhg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZliQgAAKCRB4tDGHoIJi
0meaAP4hpp+ON/+4CUCouNiEU6Wr4S461QKuus3DdOd3JDRNQwEAr3sv/LmPdRsa
sUgsKALjJuli5YHzz/dQq7PlVqqiyw4=
=WxZU
-----END PGP SIGNATURE-----

--z9kbXMXV8iYZ4uhg--

