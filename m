Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7875608F4
	for <lists+linux-arch@lfdr.de>; Wed, 29 Jun 2022 20:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbiF2SUp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Jun 2022 14:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiF2SUo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 Jun 2022 14:20:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3430518346;
        Wed, 29 Jun 2022 11:20:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E2C2BB825D5;
        Wed, 29 Jun 2022 18:20:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CF68C341C8;
        Wed, 29 Jun 2022 18:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656526840;
        bh=nqSjfUA+dAlFCv0ZmKlAaLfQaMfV+8ezW1LJols1QmI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lzO9y7zH2weaXPqzPTfVxv9v/dgk8YFAbETnafA7dcsvYugkUndxTfWbimV4oJ9Q4
         IVs3Hei0d9svIuhhcp5Y4StutrXxYbqWPC4Dz35Fu4miJxY+W3rvdMumwhjRtdEZiY
         IQlAIPz7x+aoJodUIY1hGLKJ7WpCPq6jnNY1J5gM+4cmKrhRQphxbId50N3EpCMpOi
         Zx3etyFzG2e3dOQZhaPFO1FID9+jzKMdpUJIUQE7VJMrNUoCbjJOlNU65xkLsGsFs2
         iUpzvtZMX7PRST2eHbNwM8E0mnOqoBVH7/DM7a3CdEzME4DD/2W00igPsPBDS5ZViJ
         rJzII8ANN6wGw==
Date:   Wed, 29 Jun 2022 19:20:33 +0100
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
Subject: Re: [PATCH v6 25/33] arm64: crypto: Mark constant as data
Message-ID: <YryX8YuklTNOxHLQ@sirena.org.uk>
References: <20220623014917.199563-1-chenzhongjin@huawei.com>
 <20220623014917.199563-26-chenzhongjin@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u/A/Sno6bNlTKyUB"
Content-Disposition: inline
In-Reply-To: <20220623014917.199563-26-chenzhongjin@huawei.com>
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


--u/A/Sno6bNlTKyUB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 23, 2022 at 09:49:09AM +0800, Chen Zhongjin wrote:
> Use SYM_DATA_* macros to annotate data bytes in the middle of .text
> sections.
>=20
> For local symbols, ".L" prefix needs to be dropped as the assembler
> exclude the symbols from the .o symbol table, making objtool unable
> to see them.

Reviewed-by: Mark Brown <broonie@kernel.org>

--u/A/Sno6bNlTKyUB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmK8l/AACgkQJNaLcl1U
h9D5Pgf7B/qfGxLr9uSqDv8qyhbmyiDLJ2+YriTI2XDfxjIfIzQQ4Lt2OJ9Dl5G7
pVJbkoLdC55nSb6tJLEfo6tYc5I0G2w0td71/S6QdS/wzF5YnV1ozxIlGKtfYrCp
TPIJdmEKMS4pRfQ7y7sZ8avQutX0FqBek8SmXq/3/3mEmIFugCksFJ9hcrEwEyfS
1TN9uG3QFIsLzGbBPk79XVgaZtXJYKpzaI+TfVDhed+JDLH+dgrZ5OcTZALUGkE3
Ce+IRnLuLOAem14V32LufZG4/Hoaiguxtq2UoY2dAb1fUff9kaGZmSFmTjyQPakJ
6C5y+X+n2vyUP503CA6vUVnKgIV52Q==
=BxDC
-----END PGP SIGNATURE-----

--u/A/Sno6bNlTKyUB--
