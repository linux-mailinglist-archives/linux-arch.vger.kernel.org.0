Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C66514D19
	for <lists+linux-arch@lfdr.de>; Fri, 29 Apr 2022 16:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377377AbiD2OgL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Apr 2022 10:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359514AbiD2OgK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Apr 2022 10:36:10 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D609DA6E2D
        for <linux-arch@vger.kernel.org>; Fri, 29 Apr 2022 07:32:50 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id x77so5261106qkb.3
        for <linux-arch@vger.kernel.org>; Fri, 29 Apr 2022 07:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3O9IbsR8egFahs985GCQfMgbbIRRPAH3wloOj+Oxdhg=;
        b=SA4881NwL1mOajreSJkMArXs+IFG++sFNGmbhdo7ZvATrNuMjzEDFYou8WmyAo8NLf
         cxaV03r5I3emLbYofvret1R3HJQQVgeKzXuOMAcgawXIRJW5MhyW+Yna9E91DuONn8sE
         JrhBoaaL2dM/iofKeoXwC0Jpen1ZxaWkzJwXVUX5zhX3Z/zPC4UoL5pc/0Bi+K995Tm2
         3oAtSsZWsmFX82LtcplTYFDVnLBhG7bBjc5r2m/OjMu+D3uh9OsZcUufjmxLRhIRQqTG
         cY2vqyKC5E8ux8ifQOR/wDuefPQpr1l44QOKRFZCU/rIwO/1tDkFH7ORJhSkOerT0cZ2
         K8BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3O9IbsR8egFahs985GCQfMgbbIRRPAH3wloOj+Oxdhg=;
        b=QAWVucXrwLHIKIzB+DmkcpJjH/NiUvpo3a7byjoXEcGjEI759RXouDS9SPXFODWdYF
         eK3cmxklcBcredWmcctG+KO7p8E2t+vXyVHUORQlMflGdZXbziuGiN+kornpAtxajDvB
         pz6rVrd+4LSsqr0eLBWR6MoGWlPnfvrgzIlt4i5R0oB9J0aPRcAXU6zkZ2AtetbliKlB
         cIMK2uz/eAn5idgnYBG5YGzk0cFWURmu95oxQgUE9vFCpO6daitdocpt3NMuYfYJptm0
         g1PwYSei15pgOfbRwWerv2M0ZYhOGiqRdd3QmJvEMlmwivOXnrrTxPODTqqj38HJuppM
         x6MQ==
X-Gm-Message-State: AOAM532XyooJNzKyBdNPQ7uDqqJHCK7w0qKsAckX1XWQQxDh9fsdmk8A
        Hrcu63wHdBm9djUMZKWCGeOiOg==
X-Google-Smtp-Source: ABdhPJyy84R40nLJZl4f5lZSrOwppSdNFvxQ/yq7ZXL7CCmahwab1Thd/2hvhrIE32LX9iOmok1mPQ==
X-Received: by 2002:a37:f516:0:b0:69f:83cd:f557 with SMTP id l22-20020a37f516000000b0069f83cdf557mr10824296qkk.555.1651242768910;
        Fri, 29 Apr 2022 07:32:48 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id p5-20020ae9f305000000b0069e6dcc4188sm1423017qkg.57.2022.04.29.07.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 07:32:48 -0700 (PDT)
Date:   Fri, 29 Apr 2022 10:32:46 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Subject: Re: [RFC v2 10/39] gpio: add HAS_IOPORT dependencies
Message-ID: <Ymv3DnS1vPMY8QIg@fedora>
References: <20220429135108.2781579-1-schnelle@linux.ibm.com>
 <20220429135108.2781579-19-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Cw51uSVYoGjleSw0"
Content-Disposition: inline
In-Reply-To: <20220429135108.2781579-19-schnelle@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--Cw51uSVYoGjleSw0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 29, 2022 at 03:50:16PM +0200, Niklas Schnelle wrote:
> In a future patch HAS_IOPORT=3Dn will result in inb()/outb() and friends
> not being declared. We thus need to add HAS_IOPORT as dependency for
> those drivers using them.
>=20
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  drivers/gpio/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 45764ec3b2eb..14e5998ee95c 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -697,7 +697,7 @@ config GPIO_VR41XX
> =20
>  config GPIO_VX855
>  	tristate "VIA VX855/VX875 GPIO"
> -	depends on (X86 || COMPILE_TEST) && PCI
> +	depends on (X86 || COMPILE_TEST) && PCI && HAS_IOPORT
>  	select MFD_CORE
>  	select MFD_VX855
>  	help
> --=20
> 2.32.0

I noticed a number of other GPIO drivers make use of inb()/outb() -- for
example the PC104 drivers -- should the respective Kconfigs for those
drivers also be adjusted here?

William Breathitt Gray

--Cw51uSVYoGjleSw0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCYmv28AAKCRC1SFbKvhIj
K9u2AP0UA+4zFLE6ibsTpOqIeY862n11cgnRQU0F5BoTpsqG6gD/fLWsB6OMJM2o
mmkhnCExcMN+ipH3bm/pBsjIkmHHaAY=
=/Adj
-----END PGP SIGNATURE-----

--Cw51uSVYoGjleSw0--
