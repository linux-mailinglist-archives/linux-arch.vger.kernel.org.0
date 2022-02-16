Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E5C4B8EB9
	for <lists+linux-arch@lfdr.de>; Wed, 16 Feb 2022 18:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235078AbiBPRBh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Feb 2022 12:01:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236457AbiBPRBf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Feb 2022 12:01:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D4C2A5232
        for <linux-arch@vger.kernel.org>; Wed, 16 Feb 2022 09:01:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9A13CB81F91
        for <linux-arch@vger.kernel.org>; Wed, 16 Feb 2022 17:01:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C348C340ED;
        Wed, 16 Feb 2022 17:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645030879;
        bh=ISfq5qFGY5Xiu1jnPEb1x8D0N2MDbc5oRRG1O93yGrU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lvt25QaJBi5CB2AmZAGBx5sHmVK/mcXQQnNvgedTv8gyCV8x/i8ViG7eWR88bN/3p
         Z1PslyFeRPr1oQqaanAwRE+VoS5MV9X2IssAdBYS1dpLTORCdmDyhlpCURHBFUmM0U
         HVOmPqRg2ZKJKtgW8R4+Wc/tEzdIDS6dyDTIwOiTgrvmcrRoATl0XgNnCs33rj9rDe
         5VrnaG0HNdtwrwXGQl25MnEioAXVO9VQrMKitqwtnuo5MlBXn5JC49wpNNeAb81bIh
         OONMZlOQtKgpcIxxg1QrV3069TJ4knCqj20qde/BHjOvAllX6cOQKiKAMWUVqNWdAP
         FjljSOpknEq6Q==
Date:   Wed, 16 Feb 2022 17:01:14 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org,
        Yu-cheng Yu <yu-cheng.yu@intel.com>, libc-alpha@sourceware.org,
        Jeremy Linton <jeremy.linton@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 0/4] arm64: Enable BTI for the executable as well as
 the interpreter
Message-ID: <Yg0t2srflG80zQKF@sirena.org.uk>
References: <20220124150704.2559523-1-broonie@kernel.org>
 <20220215183456.GB9026@willie-the-truck>
 <Ygz9YX3jBY0MpepU@arm.com>
 <20220216164954.GH2692478@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IDIQYRRmJXIEAoCv"
Content-Disposition: inline
In-Reply-To: <20220216164954.GH2692478@arm.com>
X-Cookie: Fremen add life to spice!
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--IDIQYRRmJXIEAoCv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 16, 2022 at 04:49:54PM +0000, Szabolcs Nagy wrote:

> if we ever wanted to map bti marked binaries without PROT_BTI
> and introduced a knob to do that in ld.so, then this change
> would be problematic (we cannot easily remove PROT_BTI from
> the exe), but we don't have such plans.

In general or only in the case where MWDE is enabled (in which case it's
the same problem as exists today trying to enable BTI in the presence of
MWDE)?

--IDIQYRRmJXIEAoCv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmINLdkACgkQJNaLcl1U
h9B3Vgf9Gf4hM0r0r3E8yAJ65goIc2UaT7kWPfaSGqjaIG3+qS8yv9KVfXzhEkgx
vzPb8pmp35UYVRmzy+YwOncM19icLq9YGv4955W2q+e+gmALZkzQ5qfNGVVlmJ5C
SU1pLwRnsNmmCTqiET4vKhjwiRxiHAExirnJWJWk5+sFjF28hdXBOxeQDjyGwVC4
buo3gcZKIkEl/uu+JsMtak/hFyVy8/roRjfEeTlLKN8RqFftSZdjV7jF8EwD4gGc
Wk2YMbMAnYjFXm15gmMYp4cgLbWdvLprGuSRK/2/pXg3NawF3ja7NIpJimr8ZS2u
KlgT0n1ed0+dj3Kyq7hlifTVqZ8vfw==
=+V3F
-----END PGP SIGNATURE-----

--IDIQYRRmJXIEAoCv--
