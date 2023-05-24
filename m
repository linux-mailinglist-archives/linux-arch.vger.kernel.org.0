Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76C670EBB8
	for <lists+linux-arch@lfdr.de>; Wed, 24 May 2023 05:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239265AbjEXDNm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 May 2023 23:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239120AbjEXDNe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 May 2023 23:13:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BEBE52;
        Tue, 23 May 2023 20:13:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0ABA7612E8;
        Wed, 24 May 2023 03:13:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D37FEC433EF;
        Wed, 24 May 2023 03:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684898006;
        bh=3H1qeGguqJKKMRIbLHzFc86BBXitdWvieNfjpJfbtpA=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=NECt5kz/EJAgcb0xFaBtRHdfh1BUer4D/itQ4rKZCSImAvRk2CR78gphL24VJDzwh
         NYJX6TnzVcrsX+u1t/i/YulT5/SDmYb1pKsLe3WZn2OtNrSjcpvOAFnzrgABnCTIfb
         zCJ5ZzMxOZoWlMQNW/HR7m50t6tnJH9ARD69s93rDYE4pnV2IT2AOkAMel3Qb7wT3+
         hM11T6vjMX3AYPWbIyMpf8q96FKnNtca8Cq3wEsL30IpEux0N7wLblDQj2LYrYKKEc
         Y2Eq1WVW+PI7V7llp4/nVKzX0eWvqNodozQAJ9BkIRLcVgdcTQU6/ErTLBqQo2V1ug
         4ZOWXOmPUcsGg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 24 May 2023 06:13:21 +0300
Message-Id: <CSU6HS37JN7M.11R5RM34EADW@suppilovahvero>
Subject: Re: [PATCH v5 05/44] char: tpm: handle HAS_IOPORT dependencies
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Niklas Schnelle" <schnelle@linux.ibm.com>,
        "Arnd Bergmann" <arnd@arndb.de>, "Peter Huewe" <peterhuewe@gmx.de>,
        "Jason Gunthorpe" <jgg@ziepe.ca>
Cc:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        "Alan Stern" <stern@rowland.harvard.edu>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Albert Ou" <aou@eecs.berkeley.edu>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, "Arnd Bergmann" <arnd@kernel.org>,
        <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.14.0
References: <20230522105049.1467313-1-schnelle@linux.ibm.com>
 <20230522105049.1467313-6-schnelle@linux.ibm.com>
In-Reply-To: <20230522105049.1467313-6-schnelle@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon May 22, 2023 at 1:50 PM EEST, Niklas Schnelle wrote:
> In a future patch HAS_IOPORT=3Dn will result in inb()/outb() and friends
> not being declared. We thus need to add this dependency and ifdef
> sections of code using inb()/outb() as alternative access methods.
>
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  drivers/char/tpm/Kconfig        |  1 +
>  drivers/char/tpm/tpm_infineon.c | 16 ++++++++++++----
>  drivers/char/tpm/tpm_tis_core.c | 19 ++++++++-----------
>  3 files changed, 21 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> index 927088b2c3d3..418c9ed59ffd 100644
> --- a/drivers/char/tpm/Kconfig
> +++ b/drivers/char/tpm/Kconfig
> @@ -149,6 +149,7 @@ config TCG_NSC
>  config TCG_ATMEL
>  	tristate "Atmel TPM Interface"
>  	depends on PPC64 || HAS_IOPORT_MAP
> +	depends on HAS_IOPORT
>  	help
>  	  If you have a TPM security chip from Atmel say Yes and it=20
>  	  will be accessible from within Linux.  To compile this driver=20
> diff --git a/drivers/char/tpm/tpm_infineon.c b/drivers/char/tpm/tpm_infin=
eon.c
> index 9c924a1440a9..99c6e565ec8d 100644
> --- a/drivers/char/tpm/tpm_infineon.c
> +++ b/drivers/char/tpm/tpm_infineon.c
> @@ -26,7 +26,9 @@
>  #define	TPM_MAX_TRIES		5000
>  #define	TPM_INFINEON_DEV_VEN_VALUE	0x15D1
> =20
> +#ifdef CONFIG_HAS_IOPORT
>  #define TPM_INF_IO_PORT		0x0
> +#endif
>  #define TPM_INF_IO_MEM		0x1
> =20
>  #define TPM_INF_ADDR		0x0
> @@ -51,34 +53,40 @@ static struct tpm_inf_dev tpm_dev;
> =20
>  static inline void tpm_data_out(unsigned char data, unsigned char offset=
)
>  {
> +#ifdef CONFIG_HAS_IOPORT
>  	if (tpm_dev.iotype =3D=3D TPM_INF_IO_PORT)
>  		outb(data, tpm_dev.data_regs + offset);
>  	else
> +#endif
>  		writeb(data, tpm_dev.mem_base + tpm_dev.data_regs + offset);
>  }
> =20
>  static inline unsigned char tpm_data_in(unsigned char offset)
>  {
> +#ifdef CONFIG_HAS_IOPORT
>  	if (tpm_dev.iotype =3D=3D TPM_INF_IO_PORT)
>  		return inb(tpm_dev.data_regs + offset);
> -	else
> -		return readb(tpm_dev.mem_base + tpm_dev.data_regs + offset);
> +#endif
> +	return readb(tpm_dev.mem_base + tpm_dev.data_regs + offset);
>  }
> =20
>  static inline void tpm_config_out(unsigned char data, unsigned char offs=
et)
>  {
> +#ifdef CONFIG_HAS_IOPORT
>  	if (tpm_dev.iotype =3D=3D TPM_INF_IO_PORT)
>  		outb(data, tpm_dev.config_port + offset);
>  	else
> +#endif
>  		writeb(data, tpm_dev.mem_base + tpm_dev.index_off + offset);
>  }
> =20
>  static inline unsigned char tpm_config_in(unsigned char offset)
>  {
> +#ifdef CONFIG_HAS_IOPORT
>  	if (tpm_dev.iotype =3D=3D TPM_INF_IO_PORT)
>  		return inb(tpm_dev.config_port + offset);
> -	else
> -		return readb(tpm_dev.mem_base + tpm_dev.index_off + offset);
> +#endif
> +	return readb(tpm_dev.mem_base + tpm_dev.index_off + offset);
>  }
> =20
>  /* TPM header definitions */
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_c=
ore.c
> index 558144fa707a..0ee5a83e35a8 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -954,11 +954,6 @@ static void tpm_tis_clkrun_enable(struct tpm_chip *c=
hip, bool value)
>  		clkrun_val &=3D ~LPC_CLKRUN_EN;
>  		iowrite32(clkrun_val, data->ilb_base_addr + LPC_CNTRL_OFFSET);
> =20
> -		/*
> -		 * Write any random value on port 0x80 which is on LPC, to make
> -		 * sure LPC clock is running before sending any TPM command.
> -		 */
> -		outb(0xCC, 0x80);
>  	} else {
>  		data->clkrun_enabled--;
>  		if (data->clkrun_enabled)
> @@ -969,13 +964,15 @@ static void tpm_tis_clkrun_enable(struct tpm_chip *=
chip, bool value)
>  		/* Enable LPC CLKRUN# */
>  		clkrun_val |=3D LPC_CLKRUN_EN;
>  		iowrite32(clkrun_val, data->ilb_base_addr + LPC_CNTRL_OFFSET);
> -
> -		/*
> -		 * Write any random value on port 0x80 which is on LPC, to make
> -		 * sure LPC clock is running before sending any TPM command.
> -		 */
> -		outb(0xCC, 0x80);
>  	}
> +
> +#ifdef CONFIG_HAS_IOPORT
> +	/*
> +	 * Write any random value on port 0x80 which is on LPC, to make
> +	 * sure LPC clock is running before sending any TPM command.
> +	 */
> +	outb(0xCC, 0x80);
> +#endif
>  }
> =20
>  static const struct tpm_class_ops tpm_tis =3D {
> --=20
> 2.39.2

Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
