Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 603663A2D20
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jun 2021 15:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbhFJNg0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Jun 2021 09:36:26 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56066 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbhFJNgY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Jun 2021 09:36:24 -0400
X-Greylist: delayed 918 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Jun 2021 09:36:23 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=EGuuNBvtOxSepsx8cAIcPQNm7Di5nTQ54VReyLn7gyc=; b=EulokYgt/Nfgp8kSobLspIWJpd
        Bp3VYsa4/gqXPeRl94NVmLkJeRfI0udoR06fEp7YI8M+1HP49R1SKamQY+OGeBILjeP3m+Tgu3Q3p
        98FSCP8v6ng5gILjAvI6oRRZvJirTbUEhxgfofNn9dI+WVsG7JI+pu8MSWZbuW+2wE6U=;
Received: from host86-167-10-84.range86-167.btcentralplus.com ([86.167.10.84] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <broonie@sirena.org.uk>)
        id 1lrKov-00AMQW-7z; Thu, 10 Jun 2021 13:34:05 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id DB095D0E9DF; Thu, 10 Jun 2021 14:34:03 +0100 (BST)
Date:   Thu, 10 Jun 2021 14:34:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        libc-alpha@sourceware.org
Subject: Re: [PATCH v2 3/3] elf: Remove has_interp property from
 arch_adjust_elf_prot()
Message-ID: <YMIUy3oMQNboKoeg@sirena.org.uk>
References: <20210604112450.13344-1-broonie@kernel.org>
 <20210604112450.13344-4-broonie@kernel.org>
 <20210609151724.GM4187@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Cavun4J4NqaiGpjK"
Content-Disposition: inline
In-Reply-To: <20210609151724.GM4187@arm.com>
X-Cookie: A penny saved has not been spent.
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--Cavun4J4NqaiGpjK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 09, 2021 at 04:17:24PM +0100, Dave Martin wrote:
> On Fri, Jun 04, 2021 at 12:24:50PM +0100, Mark Brown wrote:

> > Since we have added an is_interp flag to arch_parse_elf_property() we can
> > drop the has_interp flag from arch_elf_adjust_prot(), the only user was
> > the arm64 code which no longer needs it and any future users will be able
> > to use arch_parse_elf_properties() to determine if an interpreter is in
> > use.

> So far so good, but can we also drop the has_interp argument from
> arch_parse_elf_properties()?

> Cross-check with Yu-Cheng Yu's series, but I don't see this being used
> any more (except for passthrough in binfmt_elf.c).

> Since we are treating the interpreter and main executable orthogonally
> to each other now, I don't think we should need a has_interp argument to
> pass knowledge between the interpreter and executable handling phases
> here.

My thinking was that it might be useful for handling of some
future property in the architecture code to know if there is an
interpreter, providing the information at parse time would let it
set up whatever is needed.  We've been doing this with the arm64
BTI handling and while we're moving away from doing that I could
imagine that there may be some other case where it makes sense,
and it sounds like CET is one.

--Cavun4J4NqaiGpjK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDCFMsACgkQJNaLcl1U
h9BZawf6Ay4UxH5bIDhtXPTAhZm8FN7huxDYlOaIL4TC2UpYorZjStY/QHhzapuP
AtLu2hH2jnNdeJPtMpQWOPQWO+1ImClJTOsXv/UpjA4YPRaLEUFaIzvJcqU1UGgZ
jeBAe56VHRuUaLxheAoXELBYcu3BkMHUad8w/Vep0coUorIy8Zqkoa44LlTa/JFu
KbiToYyI/BTvvjdrBRhft0W3kL6uQZplkCD+2iuvpTetEAu1mLI8E8RE3KjKFy/j
CCOt4Wpnj/q3CtKKd8B1pfMUO4NFct3VXygOvdEeeDqmiHS/Olh03LWfndTdvCCD
k7lFSENNrlbwAWvFjrhbEM8aqjhyxQ==
=hhB/
-----END PGP SIGNATURE-----

--Cavun4J4NqaiGpjK--
