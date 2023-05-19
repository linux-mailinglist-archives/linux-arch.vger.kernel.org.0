Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED5D709D02
	for <lists+linux-arch@lfdr.de>; Fri, 19 May 2023 18:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbjESQzG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 May 2023 12:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbjESQzF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 May 2023 12:55:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE32C1A7;
        Fri, 19 May 2023 09:54:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 351FD61483;
        Fri, 19 May 2023 16:54:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA099C433EF;
        Fri, 19 May 2023 16:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684515291;
        bh=6JR4O+An8vWeZFVsZA92L+lf5pGLo9S8AJGIiUT2z50=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FQXo+ND3uPH4WFfZj3SfiaO96BEi1/m0KYmELQsvoyCZeKz6ZWO9o+qLzZHL9QFXB
         c+vYTynVk6rXPtT5TfsL1bDM8rQKCT7UGFq3lXQU/oSzy9T2obMFpM3f6t+fY5JD3Z
         qashGxkjMI2pXwYUoeo8GreVpihmwQImqnOZrQyj/thyqpX3SZn/HOC/IBzkyNb73t
         fdV2ecI01iXzpCNANXDeRUqm80J2JM4ttW7QrqwcUHClQkbrTJ4mNU3Bvn+w1C7SOE
         1WgvoHw2UOznWQgPyTygUE6vMGh0MParkaEp7y6Di7pW49ceSIchbA2XELm5OJHT9x
         FLbPf9AQBGexw==
Date:   Fri, 19 May 2023 17:54:47 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 7/7] dt-bindings: Update Documentation/arm references
Message-ID: <20230519-tug-garbage-4fee2efc3f0a@spud>
References: <20230519164607.38845-1-corbet@lwn.net>
 <20230519164607.38845-8-corbet@lwn.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="veVC0fDZZLpzz2eJ"
Content-Disposition: inline
In-Reply-To: <20230519164607.38845-8-corbet@lwn.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--veVC0fDZZLpzz2eJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 19, 2023 at 10:46:07AM -0600, Jonathan Corbet wrote:
> The Arm documentation has moved to Documentation/arch/arm; update
> references under arch/arm64 to match.

This commit message seems a wee bit inaccurate ;)

> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Conor Dooley <conor+dt@kernel.org>

Otherwise,
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--veVC0fDZZLpzz2eJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGep1wAKCRB4tDGHoIJi
0mkOAQDaXlgZ06YOUpyiBi3uPsdf2OETQFwdS/Zt4CGL94/VVgD+KqtZnmBUQkdM
FXJXuxCiWX6Nxr4miK+ltM55W5/xGAc=
=c9Rj
-----END PGP SIGNATURE-----

--veVC0fDZZLpzz2eJ--
