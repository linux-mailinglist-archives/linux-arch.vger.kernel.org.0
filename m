Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79DE25A87D7
	for <lists+linux-arch@lfdr.de>; Wed, 31 Aug 2022 23:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbiHaVA6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 Aug 2022 17:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbiHaVA5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 Aug 2022 17:00:57 -0400
X-Greylist: delayed 315 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 31 Aug 2022 14:00:55 PDT
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7729DC5DF;
        Wed, 31 Aug 2022 14:00:54 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 01C535801ED;
        Wed, 31 Aug 2022 16:55:39 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Wed, 31 Aug 2022 16:55:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1661979338; x=
        1661982938; bh=LkVDm3Qz7FBWMo01mEWdMxKemZ7sFp7vGUA7k+sq3MA=; b=P
        PSLbF1Bmu6kVZdMCtzufYqAOg5if+vw9BKLPIbGWrIQ4hgPAaeRcgtOu+o/dRoSa
        Pa/fv6PhYKOJYeqRLmIFKLULBubecQrTYf8+VkutxnfDuUnwBLGOspNW72aBXlDJ
        Fs365JoBxA6E7cvYOPc1vaslQfVkb2+Ay4v5/0gjTD/C7GAnLxHKsws1KKdGCkw5
        uyfzVPDXihfSg4gpAQhJXbeQ5ieNsg4DlwHI38Fo6Wcaoqt61OanZcscCLlUWhfF
        6+b+OmafMJyvIwCPl0OnNDsQzwVf/wiyfSEnreEPPJ3b2CnLlDL6GxIdmxr2uPqW
        Xx5OfjUoNGnMeMzmk+/iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=i56a14606.fm1; t=
        1661979338; x=1661982938; bh=LkVDm3Qz7FBWMo01mEWdMxKemZ7sFp7vGUA
        7k+sq3MA=; b=pEqlW916ckglDDJnoXqPnSVwBkCve6yH6Atee1NZ/q+WUtMYCMp
        +rGaey1mod27NkBky23kgsWpqOVIarbyDR4MAgR69iglbC1jti4V1s4zQyxjcZKv
        iALZQ6Rque4LCQug+5KVGLxeUxVW4x47caAdYI/mLRv5Ft8sU9GJe2yUhyiGPcSm
        lLN90133NmKu4xcVXzHOYY434OAShlt42NagBRTaDVNb+IeStJzWqnqDN+itHBys
        RLNFkd6vBokjw/BePosS0n31DrPb2x4+qag6PWDnISlKJag7lDPr8foYPB2RmVaq
        Tg50/C8iLIj+gzCPlTTwD3JfpEm4mhWbCAQ==
X-ME-Sender: <xms:ycoPY2wtgXtaon-5hP-ydhrzwYyGlV4sf_yIR2jd14_tMdv3JuxjbQ>
    <xme:ycoPYyR7VXTa5Il2crzTldHZv0i9MLWgidmon6Jm_6ZptdyMp-PWOAYOe-N8X1DxK
    8KEaIXYKq95lB5c6QY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdekiedguddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    tehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrf
    grthhtvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudek
    tdfgjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:ycoPY4UemAkfIRCGK_a34qGoujRbzC2NjQA09WmBtNbSHYHtvuXr4A>
    <xmx:ycoPY8jor35iih-kLdhrzYDmagv9toppSeUUTTlWV33HK42B-taO_A>
    <xmx:ycoPY4CRrUCcOMnAs50SyIUG7AEs5uZo_svVUhAvGyMdQjxkMuqvuw>
    <xmx:ysoPYw7hc-91nfE4O6zEsdmvbhA2_fLQrSL7Wdlu9I-GM0NTP4T60w>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0C034B60083; Wed, 31 Aug 2022 16:55:36 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-841-g7899e99a45-fm-20220811.002-g7899e99a
Mime-Version: 1.0
Message-Id: <1d548a19-feec-42b9-944d-890d6dde2fb8@www.fastmail.com>
In-Reply-To: <18cda49e-84f0-a806-566a-6e77705e98b3@csgroup.eu>
References: <cover.1661789204.git.christophe.leroy@csgroup.eu>
 <abb46a587b76d379ad32d53817d837d8a5fea8bd.1661789204.git.christophe.leroy@csgroup.eu>
 <CAHp75VcngRihpfUkeKs-g+TbPnpOsZ+-Q37zDVoWp8p_2GbSvQ@mail.gmail.com>
 <18cda49e-84f0-a806-566a-6e77705e98b3@csgroup.eu>
Date:   Wed, 31 Aug 2022 22:55:16 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Andy Shevchenko" <andy.shevchenko@gmail.com>
Cc:     "Linus Walleij" <linus.walleij@linaro.org>,
        "Bartosz Golaszewski" <brgl@bgdev.pl>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        Keerthy <j-keerthy@ti.com>,
        "Russell King" <linux@armlinux.org.uk>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-arm Mailing List" <linux-arm-kernel@lists.infradead.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "Linux Documentation List" <linux-doc@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Subject: Re: [PATCH v1 4/8] gpiolib: Get rid of ARCH_NR_GPIOS
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Aug 31, 2022, at 7:49 AM, Christophe Leroy wrote:
> Le 30/08/2022 =C3=A0 22:18, Andy Shevchenko a =C3=A9crit=C2=A0:
>> On Mon, Aug 29, 2022 at 7:19 PM Christophe Leroy
>> <christophe.leroy@csgroup.eu> wrote:
>>>
>>> Since commit 14e85c0e69d5 ("gpio: remove gpio_descs global array")
>>> there is no limitation on the number of GPIOs that can be allocated
>>> in the system since the allocation is fully dynamic.
>>>
>>> ARCH_NR_GPIOS is today only used in order to provide downwards
>>> gpiobase allocation from that value, while static allocation is
>>> performed upwards from 0. However that has the disadvantage of
>>> limiting the number of GPIOs that can be registered in the system.
>>>
>>> To overcome this limitation without requiring each and every
>>> platform to provide its 'best-guess' maximum number, rework the
>>> allocation to allocate upwards, allowing approx 2 millions of
>>> GPIOs.
>>>
>>> In order to still allow static allocation for legacy drivers, define
>>> GPIO_DYNAMIC_BASE with the value 256 as the start for dynamic
>>> allocation.
>>=20
>> Not sure about 256, but I understand that this can only be the best g=
uess.
>>=20
>
> Well, it's already just a precaution. Linus W's expectation is that=20
> static ones are allocated at first, they should already be allocated=20
> when we start doing dynamic allocations so he was even thinking that w=
e=20
> could have started at 0 already.
>
> But I can start higher if you think it is safer, maybe at 512 which is=20
> the default ARCH_NR_GPIOS today.

FWIW, I went through the drivers that set the base to a value other than
zero or -1, to see what they use:

arch/arm/common/scoop.c:		devptr->gpio.base =3D inf->gpio_base; // 204
arch/arm/mach-s3c/gpio-samsung.c:			.base	=3D S3C2410_GPM(0), // 384
arch/arm/mach-s3c/gpio-samsung.c:			.base	=3D S3C64XX_GPQ(0), // 197
arch/arm/mach-s3c/mach-h1940.c:	.base			=3D H1940_LATCH_GPIO(0), // 384 =
+ 22
arch/arm/mach-sa1100/simpad.c:	cs3_gpio.base =3D SIMPAD_CS3_GPIO_BASE; /=
/ 27 + 11
arch/arm/plat-orion/gpio.c:	ochip->chip.base =3D gpio_base; // 64 + 32
arch/mips/alchemy/common/gpiolib.c:		.base			=3D ALCHEMY_GPIO2_BASE, // =
32 + 16
arch/mips/alchemy/common/gpiolib.c:	.base			=3D AU1300_GPIO_BASE, // 0 +=
 75
arch/mips/kernel/gpio_txx9.c:	txx9_gpio_chip.base =3D base; // 0 + 16
arch/mips/txx9/generic/setup.c:	iocled->chip.base =3D basenum; -1
drivers/bcma/driver_gpio.c:		chip->base		=3D bus->num * BCMA_GPIO_MAX_PI=
NS; // probably 0
drivers/gpio/gpio-adp5520.c:	gc->base =3D pdata->gpio_start; // unused
drivers/gpio/gpio-adp5588.c:		gc->base =3D pdata->gpio_start; // unused
drivers/gpio/gpio-arizona.c:		arizona_gpio->gpio_chip.base =3D pdata->gp=
io_base; // 197
drivers/gpio/gpio-brcmstb.c:		gc->base =3D gpio_base; // 2 * 32
drivers/gpio/gpio-bt8xx.c:	c->base =3D modparam_gpiobase; // from modpro=
be
drivers/gpio/gpio-da9052.c:		gpio->gp.base =3D pdata->gpio_base; // unus=
ed
drivers/gpio/gpio-da9055.c:		gpio->gp.base =3D pdata->gpio_base; // unus=
ed
drivers/gpio/gpio-davinci.c:	chips->chip.base =3D pdata->no_auto_base ? =
pdata->base : -1; // 0 + 144
drivers/gpio/gpio-dwapb.c:	port->gc.base =3D pp->gpio_base; // from DT, =
deprecated
drivers/gpio/gpio-f7188x.c:			.base             =3D _base,			\ // 10*10,=
 unused
drivers/gpio/gpio-htc-egpio.c:		chip->base            =3D pdata->chip[i]=
.gpio_base; // 192 + 5 * 8
drivers/gpio/gpio-ich.c:	chip->base =3D modparam_gpiobase; // from modpr=
obe
drivers/gpio/gpio-kempld.c:		chip->base =3D pdata->gpio_base; // 0
drivers/gpio/gpio-lpc32xx.c:			.base			=3D LPC32XX_GPO_P3_GRP, // 104
drivers/gpio/gpio-madera.c:		madera_gpio->gpio_chip.base =3D pdata->gpio=
_base; // -1
drivers/gpio/gpio-max730x.c:		ts->chip.base =3D pdata->base; // 200 + 28=
 (timberdale)
drivers/gpio/gpio-max732x.c:	gc->base =3D gpio_start; // 192
drivers/gpio/gpio-mc33880.c:	mc->chip.base =3D pdata->base; // 100 (timb=
erdale)
drivers/gpio/gpio-merrifield.c:	priv->chip.base =3D gpio_base; // 0 + 213
drivers/gpio/gpio-mmio.c:		gc->base =3D pdata->base; // 197 + 32
drivers/gpio/gpio-mockup.c:	gc->base =3D base; // module parama
drivers/gpio/gpio-mvebu.c:	mvchip->chip.base =3D id * MVEBU_MAX_GPIO_PER=
_BANK; // 4 * 32, from DT
drivers/gpio/gpio-omap.c:		bank->chip.base =3D OMAP_MPUIO(0); // 192
drivers/gpio/gpio-omap.c:		bank->chip.base =3D gpio; // 7 * 32
drivers/gpio/gpio-palmas.c:		palmas_gpio->gpio_chip.base =3D palmas_pdat=
a->gpio_base; // unused
drivers/gpio/gpio-pca953x.c:	gc->base =3D chip->gpio_start; // ???? used=
 a lot
drivers/gpio/gpio-pcf857x.c:	gpio->chip.base			=3D pdata ? pdata->gpio_b=
ase : -1; // 160
drivers/gpio/gpio-rc5t583.c:		rc5t583_gpio->gpio_chip.base =3D pdata->gp=
io_base;  // unused
drivers/gpio/gpio-rockchip.c:	gc->base =3D bank->pin_base; // 8 * 32
drivers/gpio/gpio-sch311x.c:		block->chip.base =3D sch311x_gpio_blocks[i=
].base; // 6 * 10
drivers/gpio/gpio-sta2x11.c:	gpio->base =3D gpio_base; // unused=20
drivers/gpio/gpio-timberdale.c:	gc->base =3D pdata->gpio_base; // 0 + 100
drivers/gpio/gpio-tps6586x.c:		tps6586x_gpio->gpio_chip.base =3D pdata->=
gpio_base; // -1
drivers/gpio/gpio-tps65910.c:		tps65910_gpio->gpio_chip.base =3D pdata->=
gpio_base; // -1
drivers/gpio/gpio-ucb1400.c:	ucb->gc.base =3D ucb->gpio_offset; // 0
drivers/gpio/gpio-wm831x.c:		wm831x_gpio->gpio_chip.base =3D pdata->gpio=
_base; // 197 + 64
drivers/gpio/gpio-wm8350.c:		wm8350_gpio->gpio_chip.base =3D pdata->gpio=
_base; // 0
drivers/gpio/gpio-wm8994.c:		wm8994_gpio->gpio_chip.base =3D pdata->gpio=
_base; 197 + 8
drivers/input/keyboard/adp5588-keys.c:	kpad->gc.base =3D gpio_data->gpio=
_start; // unused
drivers/input/keyboard/adp5589-keys.c:	kpad->gc.base =3D gpio_data->gpio=
_start; // unused
drivers/leds/leds-pca9532.c:		data->gpio.base =3D pdata->gpio_base; // u=
nused
drivers/leds/leds-tca6507.c:	tca->gpio.base =3D pdata->gpio_base; // unu=
sed
drivers/mfd/asic3.c:	asic->gpio.base =3D pdata->gpio_base; // 300 + 100
drivers/mfd/htc-i2cpld.c:	gpio_chip->base            =3D plat_chip_data-=
>gpio_in_base; // 192 + 16 + 8*8
drivers/mfd/sm501.c:	gchip->base   =3D base; // 0
drivers/mfd/tps65010.c:		tps->chip.base =3D board->base; // 204
drivers/mfd/ucb1x00-core.c:		ucb->gpio.base =3D pdata->gpio_base; // 27 =
+ 13
drivers/pinctrl/nomadik/pinctrl-nomadik.c:	chip->base =3D id * NMK_GPIO_=
PER_CHIP; // 9 * 32
drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c:		pctrl->gpio_bank[id].gc.base=
 =3D args.args[1]; // 8*32, from DT
drivers/pinctrl/pinctrl-at91.c:	chip->base =3D alias_idx * MAX_NB_GPIO_P=
ER_BANK; // 5*32
drivers/pinctrl/pinctrl-ingenic.c:	jzgc->gc.base =3D bank * 32; // 6 * 3=
2, from DT
drivers/pinctrl/pinctrl-mcp23s08.c:	mcp->chip.base =3D base; // -1
drivers/pinctrl/pinctrl-oxnas.c:			.base =3D GPIO_BANK_START(_bank),	// =
2*32
drivers/pinctrl/pinctrl-pic32.c:			.base =3D GPIO_BANK_START(_bank), // =
10 * 16
drivers/pinctrl/pinctrl-pistachio.c:			.base =3D _pin_base,	// 9 * 16
drivers/pinctrl/pinctrl-st.c:	bank->gpio_chip.base =3D bank_num * ST_GPI=
O_PINS_PER_BANK; // 26 * 8
drivers/pinctrl/renesas/gpio.c:	gc->base =3D pfc->nr_gpio_pins; // ??? d=
on't understand
drivers/pinctrl/samsung/pinctrl-samsung.c:		gc->base =3D bank->grange.ba=
se;
drivers/pinctrl/stm32/pinctrl-stm32.c:		bank->gpio_chip.base =3D args.ar=
gs[1];
drivers/pinctrl/stm32/pinctrl-stm32.c:		bank->gpio_chip.base =3D bank_nr=
 * STM32_GPIO_PINS_PER_BANK;
drivers/pinctrl/stm32/pinctrl-stm32.c:	bank->gpio_chip.base =3D bank_nr =
* STM32_GPIO_PINS_PER_BANK;
drivers/pinctrl/sunxi/pinctrl-sunxi.c:	pctl->chip->base =3D pctl->desc->=
pin_base;
sound/soc/codecs/wm5100.c:		wm5100->gpio_chip.base =3D wm5100->pdata.gpi=
o_base; // 197 + 8 + 6
sound/soc/codecs/wm8903.c:		wm8903->gpio_chip.base =3D pdata->gpio_base;=
 // 197 + 8
sound/soc/codecs/wm8962.c:		wm8962->gpio_chip.base =3D pdata->gpio_base;=
 // 197 + 8=20
sound/soc/codecs/wm8996.c:		wm8996->gpio_chip.base =3D wm8996->pdata.gpi=
o_base; // 197 + 8=20

     Arnd
