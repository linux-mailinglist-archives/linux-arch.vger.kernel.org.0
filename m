Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34D563A840C
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jun 2021 17:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbhFOPgE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Jun 2021 11:36:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:40492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230076AbhFOPgE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 15 Jun 2021 11:36:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5A27F61628;
        Tue, 15 Jun 2021 15:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623771239;
        bh=q8BZ1n+o1weaYiyieYWAIsKfcyyZyn64y14iR2bzbn8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m8fY8vjOO0Kr6eZs42TZeSsIidyQQ/MWtBuSus8HpUDznidfxpFvYW0zrrWnugIlj
         jVaXwWmjApZRfyat/yPjBFA0XEtiSLFBhTiRsyh4AX18gkTDkKNm+T3yQXYBFbQaD0
         4FIUEzF0dFeGEqQIBWmTvvp1aIVFn66vk3MxH0VwcpeattZeGV2gX6ny8vplcNwuJK
         tvBeSAsYBQl2jfc4Yzjm/JfEylX/S7lh2WZzfOIhr3QJz/73n8TiWP47kihjXvps7Q
         gMm/6DUUGntast53CjQwRnu97GeXHWbO0/AVBkxVybpC1A3J+Yr5YPcr4T4L/QGegV
         b+1YtPTW2a9tA==
Date:   Tue, 15 Jun 2021 16:33:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Jeremy Linton <jeremy.linton@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org,
        Yu-cheng Yu <yu-cheng.yu@intel.com>, libc-alpha@sourceware.org,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/3] arm64: Enable BTI for the executable as well as
 the interpreter
Message-ID: <20210615153341.GI5149@sirena.org.uk>
References: <20210604112450.13344-1-broonie@kernel.org>
 <43e67d7b-aab9-db1f-f74b-a87ba7442d47@arm.com>
 <20210615152203.GR4187@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rCb8EA+9TsBVtA92"
Content-Disposition: inline
In-Reply-To: <20210615152203.GR4187@arm.com>
X-Cookie: See store for details.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--rCb8EA+9TsBVtA92
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 15, 2021 at 04:22:06PM +0100, Dave Martin wrote:
> On Thu, Jun 10, 2021 at 11:28:12AM -0500, Jeremy Linton via Libc-alpha wrote:

> > Thus, I expect that with his patch applied to 5.13 the service will fail to
> > start regardless of the state of MDWE, but it seems to continue starting
> > when I set MDWE=yes. Same behavior with v1 FWTW.

> If the failure we're trying to detect is that BTI is undesirably left
> off for the main executable, surely replacing BTIs with NOPs will make
> no differenece?  The behaviour with PROT_BTI clear is strictly more
> permissive than with PROT_BTI set, so I'm not sure we can test the
> behaviour this way.

> Maybe I'm missing sometihng / confused myself somewhere.

The issue this patch series is intended to address is that BTI gets
left off since the dynamic linker is unable to enable PROT_BTI on the
main executable.  We're looking to see that we end up with the stricter
permissions checking of BTI, with the issue present landing pads
replaced by NOPs will not fault but once the issue is addressed they
should start faulting.

> Looking at /proc/<pid>/maps after the process starts up may be a more
> reliable approach, so see what the actual prot value is on the main
> executable's text pages.

smaps rather than maps but yes, executable pages show up as "ex" and BTI
adds a "bt" tag in VmFlags.

--rCb8EA+9TsBVtA92
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDIyFQACgkQJNaLcl1U
h9Ch1wf/Uux07QpS16OkwvekpnneqAZWCv9/h9QzbYGAeINqO/tnpqDOts/LmiC+
DqG/hs3yJt+XitSG9I6FNIZ0aKi0Kde0INaI0J5DJpnT80f2CMSmRKBFIFlsfObL
ay9wNsVxyWnKWYHX85TLmZorbsWLk9LyD1yxgxyhtf07kvIdU+uRlIBCAHm9eEKW
htVj0GSsWI1AbwQhtaxXUy3dMe7QAx8BgCGmETogsvaTca2I4duUN4e8zT6y4FN4
Y8sbxIG9vQJ0DH3nkkEMbHdVelJoa9uwQBBHXY7tbPf38N8U4MeNuY6busAYWNxp
3lgeDigJd90wHBR9IkHIAWlisTJHmw==
=8dZi
-----END PGP SIGNATURE-----

--rCb8EA+9TsBVtA92--
