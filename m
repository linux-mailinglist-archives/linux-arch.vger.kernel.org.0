Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31085608AD
	for <lists+linux-arch@lfdr.de>; Wed, 29 Jun 2022 20:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiF2SHJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Jun 2022 14:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbiF2SGy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 Jun 2022 14:06:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C2F13D59;
        Wed, 29 Jun 2022 11:06:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1C036B8263E;
        Wed, 29 Jun 2022 18:06:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B18D3C34114;
        Wed, 29 Jun 2022 18:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656525976;
        bh=/ORbMpAF9g//A1nrnM4wkmRc6v6TBleNFfmCLetRAZ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dqLWCK3hqF/qjXyw3lb1XZBUniogyCFkTUNKziIg8IItEAcFdeRcG5bD8fNbhSPLa
         J8eVLKAK3nmo6Q7RFQM/Y+5/HxDmpylivSYsFm5DmY7cb/M1aLiY6zpMhm5xvPMuFJ
         du7qaP3kj20LHaK70B/k18eIwL4u2BraalzKzaXYJOqnvJbAlWt8xO6qyEQQxaSiF9
         /e5tdUEpfOb2FxRUwxYg57+q4Ssjchs8FoxPu8x4KwuFpnpP2KK6JIkM1UtrKOtpeD
         9qE9fgKfQXt2Hmlif8sy/3+ZFEtvCk8SqEtMGBa91gCzYb0bfBFd8KpWgk6Ougax2W
         355cBDPb5Kn6A==
Date:   Wed, 29 Jun 2022 19:06:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Chen Zhongjin <chenzhongjin@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        live-patching@vger.kernel.org, jpoimboe@kernel.org,
        peterz@infradead.org, catalin.marinas@arm.com, will@kernel.org,
        masahiroy@kernel.org, michal.lkml@markovi.net,
        ndesaulniers@google.com, mark.rutland@arm.com,
        pasha.tatashin@soleen.com, rmk+kernel@armlinux.org.uk,
        madvenka@linux.microsoft.com, christophe.leroy@csgroup.eu,
        daniel.thompson@linaro.org
Subject: Re: [PATCH v6 24/33] arm64: proc: Mark constant as data
Message-ID: <YryUkPktE4y91YT5@sirena.org.uk>
References: <20220623014917.199563-1-chenzhongjin@huawei.com>
 <20220623014917.199563-25-chenzhongjin@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="P6MsKGTe3yXRB9Q9"
Content-Disposition: inline
In-Reply-To: <20220623014917.199563-25-chenzhongjin@huawei.com>
X-Cookie: Booths for two or more.
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--P6MsKGTe3yXRB9Q9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 23, 2022 at 09:49:08AM +0800, Chen Zhongjin wrote:
> Label __idmap_kpti_flag represents the location of a constant.
> Mark it as data symbol.

Reviewed-by: Mark Brown <broonie@kernel.org>

--P6MsKGTe3yXRB9Q9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmK8lI8ACgkQJNaLcl1U
h9B6PAf/aaMswfBfZqCl4lFNJ/9HZ08Oq69YuGWJbJRnkT0Nqg2IUosgF2RrqzyI
MKMvedor+mqwhYIvVGSMMpEYIwrXDGF7sf1DUyuRQpxrcEP6CU3dVufjDULs2EmX
Xo4l+IviwQ6uk7Q38SwgWLrRgd326jyEO/5VBvS3rP/+mR2+1iM57StFfUInhIaK
YCS9f3wYoLbHlzb0dCeJ1Kea1MyJI7CKVnupqu0GN+ympo8zlBXG0CyCDSKasJtA
Z279XpO6D18uveifHJXNM918owwsN3+T3X038R5X7MdLKJuHRivba+GAM0V4cPoX
LZUUWFg36GFY5588P82JROwGuWI5LQ==
=PRq0
-----END PGP SIGNATURE-----

--P6MsKGTe3yXRB9Q9--
