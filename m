Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D60728329
	for <lists+linux-arch@lfdr.de>; Thu,  8 Jun 2023 17:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234784AbjFHO77 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Jun 2023 10:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjFHO76 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Jun 2023 10:59:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8066B1FFE;
        Thu,  8 Jun 2023 07:59:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FCC364E55;
        Thu,  8 Jun 2023 14:59:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20991C433D2;
        Thu,  8 Jun 2023 14:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686236396;
        bh=npXZHP2sYrfKUUSmgdBI17W6Y8KMUW+iXQJzYemr/sM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PnSovXLHnq0FQZ0+f2s7UCMm8F60Q/tznF5Y6vEOBDjzBsZBhOrWQyJ7W8VELPr4u
         tcIH99ooOs1sBuGJ8vo+FFR4WyBC4N8hT4VNlTFBZ825ZISKI0h0v2zhFW2XNXwotM
         NFewS9BeNpBhgBRf/0jPNyyLTthBwI0Lrcqxrjeof2TEXq9j0dFrl3BUun+xtIbaik
         APQ5c/05/J42g2lijgo4yPk3RpKNxCs+CdOXsrHxFmUW+HZd3TPsUlJfG6qrnGKRT3
         3sMFR0cxVEp0xMzoaysczZeh+QHECxcSrK1RAYVmRQ2PFpliY7eP45QYlr6wvVaBxW
         cT0OddUIJ4xng==
Date:   Thu, 8 Jun 2023 10:59:51 -0400
From:   William Breathitt Gray <wbg@kernel.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        William Breathitt Gray <william.gray@linaro.org>,
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
Subject: Re: [PATCH v5 07/44] counter: add HAS_IOPORT_MAP dependency
Message-ID: <ZIHs55tweGZTIiYk@ishi>
References: <20230522105049.1467313-1-schnelle@linux.ibm.com>
 <20230522105049.1467313-8-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cGR4pLWjypQyqqUs"
Content-Disposition: inline
In-Reply-To: <20230522105049.1467313-8-schnelle@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--cGR4pLWjypQyqqUs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 22, 2023 at 12:50:12PM +0200, Niklas Schnelle wrote:
> The 104_QUAD_8 counter driver uses devm_ioport_map() without depending
> on HAS_IOPORT_MAP. This means the driver is not usable on platforms such
> as s390 which do not support I/O port mapping. Add the missing
> HAS_IOPORT_MAP dependency to make this explicit.
>=20
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  drivers/counter/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
> index 4228be917038..e65a2bf178b8 100644
> --- a/drivers/counter/Kconfig
> +++ b/drivers/counter/Kconfig
> @@ -15,6 +15,7 @@ if COUNTER
>  config 104_QUAD_8
>  	tristate "ACCES 104-QUAD-8 driver"
>  	depends on (PC104 && X86) || COMPILE_TEST
> +	depends on HAS_IOPORT_MAP
>  	select ISA_BUS_API
>  	help
>  	  Say yes here to build support for the ACCES 104-QUAD-8 quadrature
> --=20
> 2.39.2
>=20

This has a minor merge conflict with the current Kconfig in the Counter
tree. Would you rebase on the counter-next branch and resubmit?

Thanks,

William Breathitt Gray

--cGR4pLWjypQyqqUs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZIHs5wAKCRC1SFbKvhIj
K5nRAQDVMtos7KxK5Q5YSC9rIAeFyGlHLWt+AnEzFe3Bnz9F1gEAnEIsBxKC5rYh
bixQtUpYrwia7GtvW7KAuXAxyfv57Q8=
=pUOf
-----END PGP SIGNATURE-----

--cGR4pLWjypQyqqUs--
