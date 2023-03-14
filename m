Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 421246B9429
	for <lists+linux-arch@lfdr.de>; Tue, 14 Mar 2023 13:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbjCNMmz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Mar 2023 08:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbjCNMmi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Mar 2023 08:42:38 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387A434007
        for <linux-arch@vger.kernel.org>; Tue, 14 Mar 2023 05:42:16 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id f1so10524436qvx.13
        for <linux-arch@vger.kernel.org>; Tue, 14 Mar 2023 05:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678797733;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HYpnkGI54FPJWgehk8vQdkx13aLmQ4B3x8mczSXyAME=;
        b=osjmOZDeLraLaarKa9V5mcSCp9hbIycNSD3yHTrjFhUyAYwdI1i7rMQiTrjR8cZ2od
         0DMbmVnXrMNIJoTWaAQrUVapDWE16HpaRHW3cDzBL1on/DXPlAxsO5znqfmOcqHhMtCP
         qAEWrdxd7QOS/ZQt4PvraSz2ldWHbMpFboa33RXOLH0Wtmg+NZ1raVLGDf0O4VB1Apb1
         35AU5D4D2f1unChLmGMBcpHiSDIspARM9gKzXhRUvKOx+Ftk/dt2ALPrtKUoJmaQ5tTf
         GLtXhviZ13qrSPoyNAl9RqfE3pncOkLTwxQSXheV2cpuxYUmw6BRKYbyxezyNgn8iaNU
         8BjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678797733;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HYpnkGI54FPJWgehk8vQdkx13aLmQ4B3x8mczSXyAME=;
        b=s8lHvMQcvHhX7QYR/7VmJOMP3NXamjQFcGuoEcNQ5l/C7hlEoidOAnvwpIs3AgZTTR
         XjXVfxcrOudwJPrHS5TRFR3C1ksmpfQoWk8ySoT6f0nvDt4Hodc6JCaRRyyAcBBK0Lpo
         S0X2kbjbcB82UVWokhE9SwZgwmdnZKMIHE1xrjTuWi7mv9uNoZRGB81cBcYZcrIR7s+x
         SVk40C1O/tJ5ZhOwAjpdcjVFw+FadhqPmW1YYcmFwUS1XxAChzP4QCRt83r66GcuIghl
         2SsoM4LXHrNNE/bOvlkfgNFWFnlYLOLMO053vvlVhRBZMMD128kUDi0LzxG5i5bZEF7x
         g09Q==
X-Gm-Message-State: AO0yUKXe18fTrstEtmN9SQ+S6gwKLuxCKo4zXrRP5d0y7+ropqEWBSeK
        Q6gu5gc8MiposP0nIH+HZKGPFA==
X-Google-Smtp-Source: AK7set9Af5VZ1Oq6MUayK61t3uF8OJyuB9sTGKaVgTfwB7rrZERwp8s4R3FQPjGwsyhnuo2IFnfaaw==
X-Received: by 2002:a05:622a:174c:b0:3d3:d291:61b with SMTP id l12-20020a05622a174c00b003d3d291061bmr444136qtk.53.1678797733394;
        Tue, 14 Mar 2023 05:42:13 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id s3-20020a37a903000000b00743838d9f49sm1708198qke.12.2023.03.14.05.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 05:42:02 -0700 (PDT)
Date:   Tue, 14 Mar 2023 08:41:59 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 05/38] counter: add HAS_IOPORT dependencies
Message-ID: <ZBBrl4v9L8Zw+AsN@fedora>
References: <20230314121216.413434-1-schnelle@linux.ibm.com>
 <20230314121216.413434-6-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QfXKkWYR1v/wDFbl"
Content-Disposition: inline
In-Reply-To: <20230314121216.413434-6-schnelle@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--QfXKkWYR1v/wDFbl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 14, 2023 at 01:11:43PM +0100, Niklas Schnelle wrote:
> In a future patch HAS_IOPORT=3Dn will result in inb()/outb() and friends
> not being declared. We thus need to add HAS_IOPORT as dependency for
> those drivers using them.
>=20
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  drivers/counter/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
> index b5ba8fb02cf7..1cae5097217e 100644
> --- a/drivers/counter/Kconfig
> +++ b/drivers/counter/Kconfig
> @@ -15,6 +15,7 @@ if COUNTER
>  config 104_QUAD_8
>  	tristate "ACCES 104-QUAD-8 driver"
>  	depends on (PC104 && X86) || COMPILE_TEST
> +	depends on HAS_IOPORT
>  	select ISA_BUS_API
>  	help
>  	  Say yes here to build support for the ACCES 104-QUAD-8 quadrature
> --=20
> 2.37.2

Is HAS_IOPORT needed because this driver uses devm_ioport_map()? The
inb()/outb() functions and such are not used in this driver, so would it
suffice to depend on HAS_IOPORT_MAP instead?

William Breathitt Gray

--QfXKkWYR1v/wDFbl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZBBrlwAKCRC1SFbKvhIj
K3ITAQCwcVYfGAF7Mb2JIBQNeuQ8Hzcy2QcEujfYu0xORFfokwD/dkgs7hwz2zMe
11UPcZMJuttibJDA+MhtxUzdy4+OrQQ=
=yKTg
-----END PGP SIGNATURE-----

--QfXKkWYR1v/wDFbl--
