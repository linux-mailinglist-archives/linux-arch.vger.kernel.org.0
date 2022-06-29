Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D11656088B
	for <lists+linux-arch@lfdr.de>; Wed, 29 Jun 2022 20:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbiF2SFc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Jun 2022 14:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbiF2SE5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 Jun 2022 14:04:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF333FBFE;
        Wed, 29 Jun 2022 11:03:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD35F61EF5;
        Wed, 29 Jun 2022 18:03:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25845C341CE;
        Wed, 29 Jun 2022 18:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656525835;
        bh=X0lazoB/Z2MYUFHBDjBytVc24hgG/ZXx4i5otGwBfoA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H4IkTUxrQFu5SHS5PzCTCg6LwFu3XOeHjWU9b6CAk0quliFmv60Qa2ariCBLyRkft
         +QTuSoGhm0ItBd5Y0fLUZxee+gBOS1lYyo2aUlWr3Q8IgDhNLf87WqljhT/otFdqjo
         FvhbI4dxyI7VZnTFhUXc4ygcYdlnjVn1JeVdFbEx4QeBWmysbIGHAZ5QidjGPgbiya
         eS7kqhkaNGFDxG4/wDnBx5fjlPcZfeK3VfL1heosKkJnuUR8ZFl8nlJdX56HAllBgu
         t5P5g70lNCKb4MGGoP1ZxPVRCBLtRg9+utzWDq78odTzxxI/EEVBeef2BLm0IbYHBM
         n4wWkmFlVDDRQ==
Date:   Wed, 29 Jun 2022 19:03:47 +0100
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
Subject: Re: [PATCH v6 22/33] arm64: efi-header: Mark efi header as data
Message-ID: <YryUAwncG4HxYj16@sirena.org.uk>
References: <20220623014917.199563-1-chenzhongjin@huawei.com>
 <20220623014917.199563-23-chenzhongjin@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/+zerKURaNsufg6f"
Content-Disposition: inline
In-Reply-To: <20220623014917.199563-23-chenzhongjin@huawei.com>
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


--/+zerKURaNsufg6f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 23, 2022 at 09:49:06AM +0800, Chen Zhongjin wrote:
> This file only contains a set of constants forming the efi header.
>=20
> Make the constants part of a data symbol.

Reviewed-by: Mark Brown <broonie@kernel.org>

--/+zerKURaNsufg6f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmK8lAIACgkQJNaLcl1U
h9DPEwf9HDG0IEnpXpPCsIe7firj70KJ0V4dHDhlPkEtzQBmCkYZaFZeKRYuwn3M
/BExp1Vfbc7ZEtyJrJ0Eli9tfs7nGbtC5glpAUUfmEq7ON7zPSk1n6PPs96AcVas
baEDSryZwzdp1TCUM5wNAu/SbiYrij1vk/ZKcgFP34DH9/4azPrDe8mDtSlNlgjd
0XQX1wmDnz1vR2LpvRczLNoecUrDcMA5xcC1wKybdVGQfAR7bTob34b3VNisnfJw
mBNKrPsfVtpWDISKvrK1Uqk2WUgUr6y2gPG8kg9Y4+JbOUaoJIsf1kSomQjMcC6T
gloXVcN87nUaYA8CfQcfAvkOb3HeJg==
=MLL2
-----END PGP SIGNATURE-----

--/+zerKURaNsufg6f--
