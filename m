Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5675607A3
	for <lists+linux-arch@lfdr.de>; Wed, 29 Jun 2022 19:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbiF2Rrz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Jun 2022 13:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiF2Rrz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 Jun 2022 13:47:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9278B3D1EE;
        Wed, 29 Jun 2022 10:47:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DBDB61E95;
        Wed, 29 Jun 2022 17:47:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A09DBC34114;
        Wed, 29 Jun 2022 17:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656524873;
        bh=V3NiNsBcMZHTm4MZ/mGYgmF4F0lBLTpyGX8FhxIQa2Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IMOpHA3y8dcD+7fwzHMEX/O8YiPB7pCyyOsIF82euERziVPngaXWEEmoYWc8EBkIz
         lAY8jAcfNPjU3BQcToZ0A5kdMJhR5sEn0iZNB1D3JT71ZT3HCXR5wzxOCiEaL8mDOU
         Ay52XukcdG7Ohbx+xY1Ex2j1dWJrva7urobJjrrrvuxje/Ufo2itTCkeupso8E/l+0
         W1MiVBgy59CtIHfzs5Y1RZ1r8yJYbblZGaOO1r742V1GlutWT2aUrSeJ0rP/t0Bfma
         ndInlhgtwxkMmUUA1F+Esfreu/3UypT4YPpHCoBNUf4bvWjeHHB5WKMPIlT3zp8LGG
         Dx4YnuN9wZI1w==
Date:   Wed, 29 Jun 2022 18:47:46 +0100
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
Subject: Re: [PATCH v6 18/33] arm64: Change symbol type annotations
Message-ID: <YryQQlQga2wtWqv9@sirena.org.uk>
References: <20220623014917.199563-1-chenzhongjin@huawei.com>
 <20220623014917.199563-19-chenzhongjin@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZpDaJFJQME505rUf"
Content-Disposition: inline
In-Reply-To: <20220623014917.199563-19-chenzhongjin@huawei.com>
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


--ZpDaJFJQME505rUf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 23, 2022 at 09:49:02AM +0800, Chen Zhongjin wrote:
> Code symbols not following the aarch64 procedure call convention should
> be annotated with SYM_CODE_* instead of SYM_FUNC_*
>=20
> Mark relevant symbols as generic code symbols.

> -SYM_CODE_START(tramp_exit_native)
> +SYM_CODE_START_LOCAL(tramp_exit_native)
>  	tramp_exit
>  SYM_CODE_END(tramp_exit_native)
> =20
> -SYM_CODE_START(tramp_exit_compat)
> +SYM_CODE_START_LOCAL(tramp_exit_compat)

The commit log says this is fixing things mistakenly lablelld SYM_FUNC
but this bit of the actual change is making some symbols local.

> -SYM_FUNC_START_LOCAL(__create_page_tables)
> +SYM_CODE_START_LOCAL(__create_page_tables)
>  	mov	x28, lr
> =20
>  	/*
> @@ -389,7 +389,7 @@ SYM_FUNC_START_LOCAL(__create_page_tables)
>  	bl	dcache_inval_poc
> =20
>  	ret	x28
> -SYM_FUNC_END(__create_page_tables)
> +SYM_CODE_END(__create_page_tables)

This is removed by Ard's recent refactoring, the others that are still
present look valid enough (for things that don't use the stack IIRC they
could be seen as conforming but equally this is all running in non
standard environments).

--ZpDaJFJQME505rUf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmK8kEEACgkQJNaLcl1U
h9AGMAf+JHAAJDfJo61ZFJglFeCtkipmbBLs8jW0KplnUBrU3Imx5m43AH8w8mWn
xbpZ5FoAVoIGkkpMrsi3V+FZ0CPLdoTWO+bsq9Un1N3VwjzjSSRjd8iuaMa0dEQ4
sqhM4VH9ZVYIDbt4RVw0z5dcwPNgIEO157D2sGMcPTG0shsbzHXnZtLgZ6Sr/EE1
35Y4kRTYprFpjfc0b7fPQKSaJ7HpqrjOSiaFLlD24EKKueEotB03suT67wVaGYOs
XVkFGA+XYW5l1FN+SDzobyVBQo+li/aLFgKbnjt4TSYmP3fEmqQ0FWaNpNncxqps
PZ7yT8RtfHUN8Qv5eNYa7G+v+O5Wkw==
=mASi
-----END PGP SIGNATURE-----

--ZpDaJFJQME505rUf--
