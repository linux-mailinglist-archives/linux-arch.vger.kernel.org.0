Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E70F6486A51
	for <lists+linux-arch@lfdr.de>; Thu,  6 Jan 2022 20:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbiAFTHx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Jan 2022 14:07:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243176AbiAFTHw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Jan 2022 14:07:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E9AC061245
        for <linux-arch@vger.kernel.org>; Thu,  6 Jan 2022 11:07:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D50961DC2
        for <linux-arch@vger.kernel.org>; Thu,  6 Jan 2022 19:07:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E2E8C36AEB;
        Thu,  6 Jan 2022 19:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641496071;
        bh=R2EJTo2qy+ImjdQAtgw+uzG2kOS8IHG6q1pOq5Wwfc0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OuVNCyX80gCStNPMw0jzAA/lM0BBUv9OhkU/u7WU3a+gB1EjiCiZ34qOl2rn5sZld
         XXf+mn7FXYezXsez8RPXsycjiAwNpdlnQiD6FcQ7hw9A1FdM0KpXI9PMFLDroVRBiv
         aaPrStTtDpF5vp1DnBS1UGZVDPkJHKZFTBlEJTlEpDNqZ2H/qMnyjvYwiF+8XNKW03
         sphg+0l+hLLeFDZw9m0YZDL7HyH8YSlRPDcv/twA7wq8FRyiV409+AfAwMzystXm4C
         gUUiOosQzmYbLF/d7IXnrvm9KRUf/abNQKNP15an4nMKFIu0PYAVOPCKv5VIS0O0pS
         ccBEwvCWHytsQ==
Date:   Thu, 6 Jan 2022 19:07:46 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Jeremy Linton <jeremy.linton@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Will Deacon <will@kernel.org>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        libc-alpha@sourceware.org, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v7 0/4] arm64: Enable BTI for the executable as well as
 the interpreter
Message-ID: <Ydc+AuagOD9GSooP@sirena.org.uk>
References: <20211115152714.3205552-1-broonie@kernel.org>
 <YbD4LKiaxG2R0XxN@arm.com>
 <20211209111048.GM3294453@arm.com>
 <YdSEkt72V1oeVx5E@sirena.org.uk>
 <101d8e84-7429-bbf1-0271-5436eca0eea2@arm.com>
 <YdbL5kIzi0xqVTVd@arm.com>
 <8550afd2-268d-a25f-88fd-0dd0b184ca23@arm.com>
 <YdcxUZ06f60UQMKM@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l2QZb2k3HSz7cwiU"
Content-Disposition: inline
In-Reply-To: <YdcxUZ06f60UQMKM@arm.com>
X-Cookie: I think we're in trouble.
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--l2QZb2k3HSz7cwiU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 06, 2022 at 06:13:37PM +0000, Catalin Marinas wrote:
> On Thu, Jan 06, 2022 at 10:09:35AM -0600, Jeremy Linton wrote:

> > This should only change the behavior for for binaries which conform to the
> > new ABI containing the BTI note. So outside of the tiny window of things
> > built with BTI, but run on !BTI hardware or older kernel+glibc, this
> > shouldn't be a problem. (Unless i'm missing something) Put another way, now
> > is the time to make a change, before there is a legacy BTI ecosystem we have
> > to deal with.

> The concern is that the loader may decide in the future to not enable
> (or turn off) BTI for some reason (e.g. mixed libraries, old glibc on
> BTI hardware). If we force BTI on the main executable, we'd take this
> option away. Note also that it's not only glibc here, there are other
> loaders.

Neither of those examples should be concerns - BTI is per page so you
can mix BTI and non-BTI freely in a process (as will happen now for the
case where the dynamic loader is built for BTI but the main executable
is not, and the dynamic loader should do if there's a mix of BTI and
non-BTI libraries).  The main case where there might be a change would
be the case where there's individual excutables with incorrect BTI
annotations which are run under this seccomp MWDE, then the dynamic
loader might have support for disabling BTI based on some configuration
but wouldn't be able to due to the MWDE.

Note also that we're only taking the option of disabiling BTI away in
the case where there's something like this seccomp filter disabling
permission changes.

--l2QZb2k3HSz7cwiU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHXPgEACgkQJNaLcl1U
h9BnZwf8DjoXbcOhQVC2ociT04WJ+fR7GYQLHGkX92IGTyo2qFUd99hIzIuHiYbp
zFWG/wqqtnuzBEQGK/MMsTNzWqLnpXtlF2NxFEdJTtFl6bYnTkShYr71UHnDlW6H
9vbA46Jb9G+EyO7DYnLlCva5VwZ7GwRrOaD3DdllLpe99BQevwM9g+lHj3wRuOXK
gLO+TdaUxe8kdAMqcDy1xHMF/j2XnYLkwVr4Jq+R5iotZ5LmwtSYcd/MYv2x+o2E
nNAZJJT6yIF9VCVEWVRKK2WgxaI5HVtLPtbi/XGEh942rG8pPC+GAKFV2KDDy4pX
4eg1OMGWz8lJm5TW2ZFmBkiCGT5zYw==
=Lecu
-----END PGP SIGNATURE-----

--l2QZb2k3HSz7cwiU--
