Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32CDC1392F7
	for <lists+linux-arch@lfdr.de>; Mon, 13 Jan 2020 15:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbgAMOBM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Jan 2020 09:01:12 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55380 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728810AbgAMOBM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Jan 2020 09:01:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MBncayY8JFbtWZipBvPDMpyU9p9lUG4BGjNxMb/pcj4=; b=L8AzG+iRGAic/smvC6OcGFDiI
        wf4bKJgdZRGQY0F0T1pYeEmOyUHR0QsUFTyTn4T0MZXTqNHgTXuCpQzeaOl5f3X/oKB55S80PtuWq
        idAwjgI4bRtlFV0S8Usye1ny16RDeXmKz2NFF1Q2sTC9LT74MHp+y+npRu/duB3bba5X4=;
Received: from fw-tnat-cam7.arm.com ([217.140.106.55] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ir0Gy-0002c0-UE; Mon, 13 Jan 2020 14:00:52 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 16F67D01965; Mon, 13 Jan 2020 14:00:52 +0000 (GMT)
Date:   Mon, 13 Jan 2020 14:00:51 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>, Paul Elliott <paul.elliott@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Amit Kachhap <amit.kachhap@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Andrew Jones <drjones@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Florian Weimer <fweimer@redhat.com>,
        Sudakshina Das <sudi.das@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v4 04/12] arm64: Basic Branch Target Identification
 support
Message-ID: <20200113140051.GI3897@sirena.org.uk>
References: <20191211154206.46260-1-broonie@kernel.org>
 <20191211154206.46260-5-broonie@kernel.org>
 <20200110182800.GI8786@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="h22Fi9ANawrtbNPX"
Content-Disposition: inline
In-Reply-To: <20200110182800.GI8786@arrakis.emea.arm.com>
X-Cookie: Programming is an unnatural act.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--h22Fi9ANawrtbNPX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2020 at 06:28:00PM +0000, Catalin Marinas wrote:
> On Wed, Dec 11, 2019 at 03:41:58PM +0000, Mark Brown wrote:

> >  /* Additional SPSR bits not exposed in the UABI */
> > +#define PSR_BTYPE_SHIFT		10
> > +
> >  #define PSR_IL_BIT		(1 << 20)
> > =20
> > +/* Convenience names for the values of PSTATE.BTYPE */
> > +#define PSR_BTYPE_NONE		(0b00 << PSR_BTYPE_SHIFT)
> > +#define PSR_BTYPE_JC		(0b01 << PSR_BTYPE_SHIFT)
> > +#define PSR_BTYPE_C		(0b10 << PSR_BTYPE_SHIFT)
> > +#define PSR_BTYPE_J		(0b11 << PSR_BTYPE_SHIFT)

> Would these be better placed in the uapi/ptrace.h?

Seems reasonable, they might be useful to virt stuff and they're
part of the architecture so it's not like we might change them.

> > +	/*
> > +	 * BTI note:
> > +	 * The architecture does not guarantee that SPSR.BTYPE is zero
> > +	 * on taking an SVC, so we could return to userspace with a
> > +	 * non-zero BTYPE after the syscall.

> On page 2580 of the ARM ARM there is a statement that "any instruction
> other than BR, ..." sets BTYPE to 0. Wouldn't SVC fall into the same
> category?

I think what Dave was referring to there is that (unless I'm
misreading things) that section of the ARM says that BTYPE is set
at the end of the execution of the instruction but since SVC is
specified as generating an exception that means that when we
enter the kernel the instruction won't have ended yet and we
still have the BTYPE from the previous instruction.

> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks.

--h22Fi9ANawrtbNPX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4ceBAACgkQJNaLcl1U
h9DLSQf6Apx/rsxXW/+0SHiXPGDJpdzgdlaKg/WkwvZD5tKjvP5SnU3YQ8L96jEk
YLvo3VX4o6G174B4i7eQvKINZJOQXPzcgYtwV8LjZIxfg7qSygSFOlfxqXPxYoh1
M3UeD4sFYwQcvvuisyxxehY7F2Qpy7r2AGPcEz/lIgJBK/afVqze34aedkAc8USs
RiEH1OneNIi0iiKiqrJTEjTNNH4eXokXteOoWKCQONDeMkBQUyGSJB09LKZibH/+
n1bqPuST5v4Qtag8JcHi9/z/xytJf6oO1QLWnXTqpUR3IUem+LucwksP8+xXIlXC
vchzbBePuEZheDLobl52IOjKdmX2Vg==
=X4rD
-----END PGP SIGNATURE-----

--h22Fi9ANawrtbNPX--
