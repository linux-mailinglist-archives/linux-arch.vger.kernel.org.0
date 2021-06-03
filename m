Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0BAE39A63E
	for <lists+linux-arch@lfdr.de>; Thu,  3 Jun 2021 18:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbhFCQxb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Jun 2021 12:53:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:36926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229692AbhFCQxb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 3 Jun 2021 12:53:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D4E79613B1;
        Thu,  3 Jun 2021 16:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622739106;
        bh=3NGvQGORedPqt0D77r3OkoXFokp1EM61eRGVBn3bSCc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MbMjzA8fXlXzBrK0gmvbC6/nM9Seje/7G35bZKhUfRaYOpyT3V5IpIUa9OQJSE3/J
         hrxG4dCsz8Qp97UMRoROs06zRg4pQd4NuxuZlGEK0Cpz6fwC2zHbWnrgchbmWHDrwA
         7MAuSyaDL3fnoq/uuNBxGavYbxaqkxytOoOmOovXOKo3+jwey3+gmi2Ms+qWcpDMNY
         K+4DrP9/Lidn1HjARnqRL7OkF835C7azrrWBAuoNDlcMcYtQqlw9bFu569rS0CNNti
         tPiaX6bhmvr7cplGA7rNGkrNoY8SL756MN5SX2lo87VwA9QFtAEI1T3NcQUy7CyeNK
         wzlrj+9+5+dDQ==
Date:   Thu, 3 Jun 2021 17:51:34 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, libc-alpha@sourceware.org
Subject: Re: [PATCH v1 2/2] arm64: Enable BTI for main executable as well as
 the interpreter
Message-ID: <20210603165134.GF4257@sirena.org.uk>
References: <20210521144621.9306-1-broonie@kernel.org>
 <20210521144621.9306-3-broonie@kernel.org>
 <20210603154034.GH4187@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iBwuxWUsK/REspAd"
Content-Disposition: inline
In-Reply-To: <20210603154034.GH4187@arm.com>
X-Cookie: Where am I?  Who am I?  Am I?  I
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--iBwuxWUsK/REspAd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 03, 2021 at 04:40:35PM +0100, Dave Martin wrote:

> Do we know how libcs will detect that they don't need to do the
> mprotect() calls?  Do we need a detection mechanism at all?

> Ignoring certain errors from mprotect() when ld.so is trying to set
> PROT_BTI on the main executable's code pages is probably a reasonable,
> backwards-compatible compromise here, but it seems a bit wasteful.

I think the theory was that they would just do the mprotect() calls and
ignore any errors as they currently do, or declare that they depend on a
new enough kernel version I guess (not an option for glibc but might be
for others which didn't do BTI yet).

> > flexibility userspace has to disable BTI but it is expected that for cases
> > where there are problems which require BTI to be disabled it is more likely
> > that it will need to be disabled on a system level.

> There's no flexibility impact unless MemoryDenyWriteExecute is in force,
> right?

Right, or some other mechanism that has the same effect.

--iBwuxWUsK/REspAd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmC5CJUACgkQJNaLcl1U
h9BYcAf+KtLJ0uuW2MkjJ3lNd+ujeqmWUcPw6tQy5T5zSUGtYsNGx2ZrFP01drnw
+9dNYITs6f/GQ1XNJ/lnLXh7OR0hXCEg3NVohS1hhQfX8iIQnpStmvdBEoc8/5Cc
PdVbHmfFmckyjglzxv5gKuj1O0tPvtjA8L5hAij7+7mQ8J/2tgQVlpTGoGGpj2SJ
c/i4iZKYhzbzNtDn4ag+rkJrdRpa4zPSear3D7ZuY9j1UrJZfa8cr/rS7lu2/O2U
65/eaGX+yYjnxgW3frUS03uyfMvpWvDdLNeki+E3LuaY6Hq6otqWdP1TrwLxn9O3
gFJfF0ehKIzSySvFCtLvU9eg2r0FKQ==
=kiXe
-----END PGP SIGNATURE-----

--iBwuxWUsK/REspAd--
