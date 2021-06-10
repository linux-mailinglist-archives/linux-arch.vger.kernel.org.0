Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4F43A2D43
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jun 2021 15:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbhFJNnd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Jun 2021 09:43:33 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56970 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbhFJNnd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Jun 2021 09:43:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/AJxu4sWN6gZZSR7UaXGEsu3FnetXCGhhw4K0sV8RaY=; b=n3jm2xNUqYFswSXsWaqdcFbVnW
        gXw6Z1YmfnlU5QsJs+nxv4hStFB2zHe9u1Mc51LqKlTZ30j5UNC24VLgb92UtdrWDx7aLzstJlWCP
        +4WwJtimtXEAZ+xcF1jMmksF4QJ3RWodYGWZgj+eBIIezKyh/lu+bsInyS+SdXvkRsJw=;
Received: from host86-167-10-84.range86-167.btcentralplus.com ([86.167.10.84] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <broonie@sirena.org.uk>)
        id 1lrKw4-00AMYb-CQ; Thu, 10 Jun 2021 13:41:28 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id AE03ED078F8; Thu, 10 Jun 2021 14:41:27 +0100 (BST)
Date:   Thu, 10 Jun 2021 14:41:27 +0100
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
Subject: Re: [PATCH v2 1/3] elf: Allow architectures to parse properties on
 the main executable
Message-ID: <YMIWh8224uHv/X8U@sirena.org.uk>
References: <20210604112450.13344-1-broonie@kernel.org>
 <20210604112450.13344-2-broonie@kernel.org>
 <20210609151622.GK4187@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2egPhIlEfrr9rAOq"
Content-Disposition: inline
In-Reply-To: <20210609151622.GK4187@arm.com>
X-Cookie: A penny saved has not been spent.
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--2egPhIlEfrr9rAOq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 09, 2021 at 04:16:25PM +0100, Dave Martin wrote:

> It's a little annoying that we add has_interp all over the place only to
> remove it again later, but I guess that may be the simplest way to keep
> things bisectable while moving logic around.  If so, I don't have a
> strong opinion on it.

Yes, it's purely to preserve bisectability.

--2egPhIlEfrr9rAOq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDCFoYACgkQJNaLcl1U
h9Bl1wgAgarNtLmvzpiohOvKicxXFK/EHCmaGPkh3hXqKnRqEwFgt9oWJoyKpPsW
nbssPy9namZG+m7tRpNsOrTsL2RmQfOp3NhRjjgfBzA5Labu/9K0yC27WLeWZgYf
RPkKIY24ZibFU77LsPmL5jAl5FGLvyhWncu42ik8VGQGbr39qNiVovju7mycsNOR
NUMMHtD4YZVSimKCLoSw/9tvJVcFPGfBXiY2FFL3lcb0rbUGJyprWWycOjxlGPN7
MiNdVohTd5ElQ6HFQLyh6tya+xu6HghBnQJSfW+1EVu1f0Fr40JoILYZEQVoFDNc
cv09cppE/MthP01LzApiVr0n8dTVtQ==
=+BSm
-----END PGP SIGNATURE-----

--2egPhIlEfrr9rAOq--
