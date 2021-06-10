Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE953A2D80
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jun 2021 15:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbhFJN4W (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Jun 2021 09:56:22 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58258 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbhFJN4W (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Jun 2021 09:56:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=npeI11EH2BuRp3VFaM5gorqsj/juTUtLuKX91wtGigw=; b=V817L4J+jRpY+/hSxV+fBk6cm2
        p8D6Ddz+Ehs8MFx9Z1zF6SJF8MyViRwNNhqSn2MCgsIAgjG57Rm83dYZDVzhtiKQIRbilx/unOXcH
        k1xG1NohySkYA4TtUevbHjXX+gcDaXng8AV2tPb/8j8XrUtgH1A3VGCz7v8i/DVf8hYg=;
Received: from host86-167-10-84.range86-167.btcentralplus.com ([86.167.10.84] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <broonie@sirena.org.uk>)
        id 1lrKa4-00AMCR-B9; Thu, 10 Jun 2021 13:18:44 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 6F928D0E9DF; Thu, 10 Jun 2021 14:19:05 +0100 (BST)
Date:   Thu, 10 Jun 2021 14:19:05 +0100
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
Subject: Re: [PATCH v2 2/3] arm64: Enable BTI for main executable as well as
 the interpreter
Message-ID: <YMIRSSMnP3UMwdRy@sirena.org.uk>
References: <20210604112450.13344-1-broonie@kernel.org>
 <20210604112450.13344-3-broonie@kernel.org>
 <20210609151713.GL4187@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="E21DmkTzCZLD726x"
Content-Disposition: inline
In-Reply-To: <20210609151713.GL4187@arm.com>
X-Cookie: A penny saved has not been spent.
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--E21DmkTzCZLD726x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 09, 2021 at 04:17:13PM +0100, Dave Martin wrote:
> On Fri, Jun 04, 2021 at 12:24:49PM +0100, Mark Brown wrote:

> > -		if (system_supports_bti() && has_interp == is_interp &&
> > -		    (*p & GNU_PROPERTY_AARCH64_FEATURE_1_BTI))
> > -			arch->flags |= ARM64_ELF_BTI;
> > +		if (system_supports_bti() &&
> > +		    (*p & GNU_PROPERTY_AARCH64_FEATURE_1_BTI)) {
> > +			if (is_interp) {
> > +				arch->flags |= ARM64_ELF_INTERP_BTI;
> > +			} else {
> > +				arch->flags |= ARM64_ELF_EXEC_BTI;
> > +			}

> Nit: surplus curlies? (coding-style.rst does actually say to drop them
> when all branches of an if are single-statement one-liners -- I had
> presumed I was just being pedantic...)

I really think this hurts readability with the nested if inside
another if with a multi-line condition.

> > -	if (prot & PROT_EXEC)
> > -		prot |= PROT_BTI;
> > +		if (state->flags & ARM64_ELF_EXEC_BTI && !is_interp)
> > +			prot |= PROT_BTI;
> > +	}

> Is it worth adding () around the bitwise-& expressions?  I'm always a
> little uneasy about the operator precedence of binary &, although
> without looking it up I think you're correct.

Sure.  I'm fairly sure the compiler would've complained about
this case if it were ambiguous, I'm vaguely surprised it didn't
already.

> Feel free to adopt if this appeals to you, otherwise I'm also fine with
> your version.)

I'll see what I think when I get back to looking at this
properly.

--E21DmkTzCZLD726x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDCEUMACgkQJNaLcl1U
h9B3oAf8DRt9uAEt6gqwDA1mGvwN/9TRY6qqVi2u9dKZwDznwg6UO/8RA4d6zpMa
xMS1GemBG2J+9Ew1xy7c4TbNHIXCMfo1ZlHlnZmCmbUyDBm9oCTRZ0TBMxpNd3nC
sG/ENNWllk/kZ4HGL0NI1+N9OlY8IROrSc8eaIre6ivN6aQWa6Q1IMtdJBqBOD0A
P2MtLevPcxASaETGmZIr/mW2HMzCAlE1+NnfeVwS2fZRJWavEoJN3jfRnNgwn/N1
9Ot91bVhERHOHl9lNLSVtgQ/Odw1uph+4NArogEH1YE0IgHH9PmyvaKDRT4vyRR1
pU87HhEyr1AkrAQPeACcfHdN+M6WmA==
=0xVB
-----END PGP SIGNATURE-----

--E21DmkTzCZLD726x--
