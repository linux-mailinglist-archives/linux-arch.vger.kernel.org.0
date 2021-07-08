Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0EA3C18BC
	for <lists+linux-arch@lfdr.de>; Thu,  8 Jul 2021 19:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbhGHSAL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Jul 2021 14:00:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:53746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229469AbhGHSAL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 8 Jul 2021 14:00:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8E52E617ED;
        Thu,  8 Jul 2021 17:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625767049;
        bh=GILCJAp3zw/ucw1JtpTq1F7yp7aHgc2Sdtt5l0resgM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LPT/OEJ2jJpsgU4tCIMtc4yIluW6OaIdSrHAXr4Ka8mVuj9/fscFvB8UrtelEm948
         EcxGUANYkq3K/yM7ByIBr0JM4X8AMX2ejbAHzE8JYF3NGj3cWiTJQBY6Zp5sOggo0K
         kH6L0FuiES0tZTLA16MT18XBVL2VmiKnY6tKMWWbwx/AT25vMvoI2pnk5hw/PXSKXr
         2ov3JkEzfUrvfoGOEKSlJwv/HT3rqxcFtAC8kMm9iE6pSjui8VaSMSdtfsMSEb8urB
         IaoH7an8aWAaicxa6weiFregKyDACpQpulXn/ljL4BncyewTXB2qj+q9oj5rJqrtwA
         a5b4KuPqwVVyg==
Date:   Thu, 8 Jul 2021 18:56:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     libc-alpha@sourceware.org, linux-api@vger.kernel.org,
        x86@kernel.org, linux-arch@vger.kernel.org,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: x86 CPU features detection for applications (and AMX)
Message-ID: <20210708175655.GA33786@sirena.org.uk>
References: <87tulo39ms.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
In-Reply-To: <87tulo39ms.fsf@oldenburg.str.redhat.com>
X-Cookie: "Elvis is my copilot."
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 23, 2021 at 05:04:27PM +0200, Florian Weimer wrote:

Copying in Catalin & Will.

> We have an interface in glibc to query CPU features:

>   X86-specific Facilities
>   <https://www.gnu.org/software/libc/manual/html_node/X86.html>

> CPU_FEATURE_USABLE all preconditions for a feature are met,
> HAS_CPU_FEATURE means it's in silicon but possibly dormant.
> CPU_FEATURE_USABLE is supposed to look at XCR0, AT_HWCAP2 etc. before
> enabling the relevant bit (so it cannot pass through any unknown bits).

...

> When we designed this glibc interface, we assumed that bits would be
> static during the life-time of the process, initialized at process
> start.  That follows the model of previous x86 CPU feature enablement.

...

> This still wouldn't cover the enable/disable side, but at least it would
> work for CPU features which are modal and come and go.  The fact that we
> tell GCC to cache the returned pointer from that internal function, but
> not that the data is immutable works to our advantage here.

> On the other hand, maybe there is a way to give users a better
> interface.  Obviously we want to avoid a syscall for a simple CPU
> feature check.  And we also need something to enable/disable CPU
> features.

This enabling and disabling of CPU features sounds like something that
might also become relevant for arm64, for example I can see a use case
for having something that allows some of the more expensive features
to be masked from some userspace processes for resource management
purposes.  This sounds like a bit of a different use case to x86 AIUI
but I think there's overlap in the actual operations that would be
needed.

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDnPGYACgkQJNaLcl1U
h9CmMAgAgoVAsCnhVpOX+qfExOdJuwLQ3o0KisscXB9Lbg7xX4PiM7hCBDnFpVSP
Ik+oZKueIi66qoFc/ca/UhQFI5wWBGdL2Ih3FfVOx5LJTjMNmkUR+vgJqy/G4qwP
lHbN3J52gSsRoXov3LF85GE2KUCax+r/XyHY7++/VmC9ylEOzSXhItUheL6YUqhn
AYxplSFPHP8Gha2gqN/Hc4Zzi2wpe6TNaHujDzTE6SVPdJi2PupWT+gQj6nAmyOg
czDzchCbkyHxPvvEH4bUFrvwPKJXFx5aoMcUOLR2nQk98MauMUb2D8bhBRxLnmP+
ZW1JhazXCO6p23WXdhGY47vx58/xiQ==
=wOfR
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
