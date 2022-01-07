Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8881C4877FD
	for <lists+linux-arch@lfdr.de>; Fri,  7 Jan 2022 14:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347460AbiAGNLC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 7 Jan 2022 08:11:02 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43784 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347437AbiAGNLB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Jan 2022 08:11:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1922960F03
        for <linux-arch@vger.kernel.org>; Fri,  7 Jan 2022 13:11:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59FD1C36AE0;
        Fri,  7 Jan 2022 13:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641561060;
        bh=kQ/XQsIVFM09dBWMbcQlqnLVpvy+lmUI1+24//AEJnE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TGZs6nuz1HGPPxLCOQ+RFHfX/VpizrwqFJyPh1vsTteCD+nFuG0BjJTCPQL4pNAg1
         i3+nvEJheHvnZK15tUOjddBiRB55B2EznhItywR9el1E0JPP0brA/Nw37a8TGbdJZa
         D2ULeK538X31iHVN1rFkQ8Ply1aK07KCkAgU/KhnuEmShklqD6T/vrRZwslrgHk3qW
         7+BwBheMg0AAoaHPtnBjFgmw+8nyb1KuvNFxv7UNumS6pk6E87oL/sk2APl7f8vZUI
         wnoKH3aWYDp+16QjpPb0N+3mcyfo226YlpmGWDRTp8FW9hYoAkK4ovmvWKU+b+L7U0
         WnZsw6Q3SUqPQ==
Date:   Fri, 7 Jan 2022 13:10:55 +0000
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
Message-ID: <Ydg733vPQqwhCwtV@sirena.org.uk>
References: <20211115152714.3205552-1-broonie@kernel.org>
 <YbD4LKiaxG2R0XxN@arm.com>
 <20211209111048.GM3294453@arm.com>
 <YdSEkt72V1oeVx5E@sirena.org.uk>
 <101d8e84-7429-bbf1-0271-5436eca0eea2@arm.com>
 <YdbL5kIzi0xqVTVd@arm.com>
 <8550afd2-268d-a25f-88fd-0dd0b184ca23@arm.com>
 <YdcxUZ06f60UQMKM@arm.com>
 <Ydc+AuagOD9GSooP@sirena.org.uk>
 <YdgrjWVxRGRtnf5b@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WUnyaILR2EzduwUB"
Content-Disposition: inline
In-Reply-To: <YdgrjWVxRGRtnf5b@arm.com>
X-Cookie: teamwork, n.:
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--WUnyaILR2EzduwUB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 07, 2022 at 12:01:17PM +0000, Catalin Marinas wrote:

> Regarding (1), I don't remember whether we decided to do it this way
> because it was more complicated to handle it in the kernel (like the 4
> more patches in this series) or because we wanted to leave the option to
> the dynamic loader. It would be good to clarify this and we may have a
> small window, as Jeremy said, where changing the ABI won't cause
> problems (well, hopefully, there's still a risk).

My understanding is that it was basically just a "let's defer everything
to userspace" thing.  It means that userspace is responsible for turning
on BTI and is therefore responsible for any workarounds which are needed
for problematic binaries, it's the absolute minimum the kernel can be
responsible for.  This all predates my involvement though.

--WUnyaILR2EzduwUB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHYO94ACgkQJNaLcl1U
h9Ce4gf9HW2dbZA6hQxBtat8BUQXOT3EeumgfxSkto+pcuzocpfOp/jbtrm0+SPz
2cmGCfZAZP9z4WiAYaMaSmnLysybYOkgOpvxUJeAsn1684BarvRcCaXs0Lt/poAN
EiIeZG+dtIwqZNUbmImQ4cPAwiJ9y7gAE+Wlb4wRFR6UvQsBUbsi6L5pDOYlaFUf
pms4C2qpfxlk4+sFJ9f2AdKL8ik3lSVn3NoFHbgpjzQOeDxaM8lfnYmFTkt48AvP
AL2+akkI4LcefXg/fT/8GQYrdVv4FTIjQA63IsG/kyV2/zcTl2hoAJl83euM1ht6
2opcJwqh5xIZP9YyWtcpTozuZHdpbQ==
=Yp3G
-----END PGP SIGNATURE-----

--WUnyaILR2EzduwUB--
