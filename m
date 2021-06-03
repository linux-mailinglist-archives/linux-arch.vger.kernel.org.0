Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A42639AA7C
	for <lists+linux-arch@lfdr.de>; Thu,  3 Jun 2021 20:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbhFCSyd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Jun 2021 14:54:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:56052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229629AbhFCSyd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 3 Jun 2021 14:54:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 90066613B1;
        Thu,  3 Jun 2021 18:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622746368;
        bh=Is0k9SqYzzEg6iUoT85CTKPOLjspeKtNSXUjMIgHgTE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VoHrCfHbxU1GRFpWit5W8STrNSkHBPL75hZIqJtpOyvLdOU91B2tvOTDmntPjFi4d
         srQ51j3AnoO8XNNKJrfD1MZR8WBI7bgRtKCNC7CeSZV50KdfsSa3bzGFuYee1EMTh2
         x4YlIdAE/cAB5L1c/a0bg2vTR+Gc+X0COQVgXfm5HtToY/9I8no1XzgG8EX6+thSc1
         wxnaDFosPYX5ysc39hx648GwwOPRYWxxFDX7eNIffMXhnHlmYK1taMx3BRZJybod6z
         DHIdS6Zvk/1iB4SeXWjVnf+yM8D3lbSntJgzsrOFh47pTYBytkncaNFtYeeziGpDVp
         ZaXcJkltjGpGA==
Date:   Thu, 3 Jun 2021 19:52:36 +0100
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
Subject: Re: [PATCH v1 1/2] elf: Allow architectures to parse properties on
 the main executable
Message-ID: <20210603185236.GG4257@sirena.org.uk>
References: <20210521144621.9306-1-broonie@kernel.org>
 <20210521144621.9306-2-broonie@kernel.org>
 <20210603154018.GG4187@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Cp3Cp8fzgozWLBWL"
Content-Disposition: inline
In-Reply-To: <20210603154018.GG4187@arm.com>
X-Cookie: Where am I?  Who am I?  Am I?  I
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--Cp3Cp8fzgozWLBWL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 03, 2021 at 04:40:24PM +0100, Dave Martin wrote:
> On Fri, May 21, 2021 at 03:46:20PM +0100, Mark Brown wrote:

> > -		if (system_supports_bti() &&
> > +		if (system_supports_bti() && is_interp &&

> Won't this cause BTI to be forced off for static binaries?

> Perhaps this should be (has_interp == is_interp), as for
> arch_elf_adjust_prot().  Seems gross though, since has_interp would
> become useless after the next patch.  If there's no sensible way to
> keep this bisectable, perhaps the patches can be merged instead.

Ugh, right.  I only tested the finished result.

--Cp3Cp8fzgozWLBWL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmC5JPMACgkQJNaLcl1U
h9D0mQf/c22l2rS//I8+ODmotld0j7iXm4/LORW1n46I6+RRKyRnWK+V+VhopPGY
TNBJrVSKsr/zuPt8b2+qLAKzkjBVLo+D28g1jbgW8E4SOmAq6GrWLAJWQRRoFg8q
W64peAJLIancE/epQi+pnvp7Hz1/NmO9DrMwsJoiONJBtLyuo7lmvy90nMjgkcZT
s6L3o2SEIqPzWbvD2Nt6covnClVar+pP6G0cxrsvuth8NQ78npSjCPj+yHbwZYu0
KP96wMRW9doehevQxUOBVYwzsLVNDrpj7xnVXeWbz1m+PRlhVD0UbgCb2lqJSBeA
iAkGFBb1lgx0KNYUDEv4y8yyMcQeOQ==
=CHn1
-----END PGP SIGNATURE-----

--Cp3Cp8fzgozWLBWL--
