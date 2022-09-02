Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25465AAE0A
	for <lists+linux-arch@lfdr.de>; Fri,  2 Sep 2022 14:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235584AbiIBMA5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Sep 2022 08:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235614AbiIBMAw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Sep 2022 08:00:52 -0400
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBF932EE9;
        Fri,  2 Sep 2022 05:00:48 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 05520580E63;
        Fri,  2 Sep 2022 08:00:45 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Fri, 02 Sep 2022 08:00:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1662120045; x=1662123645; bh=ZOo52ojNLD
        +QQW1owuGlJGIJHO9inLm8ClF8VUiGMYc=; b=Q5LypI9JctwwOK78feEceNVi9z
        mxfNcLR/Jr4MB9NTHeYJiHLefznX6HqRh6CiZvo1s/eRDzJ670NSZN2e2i+Fc7t/
        ZdFzJtd0Ct06j6/lCrkdTQuc7BEdm0b726E16z+A38p/+rOnXKPeMSAnC7pozGyS
        6LHwx11Ik1NmqfJlvPhWnbaw5ebEDvsbNdMkZN8g4WOrGEsqQWCRtu6Nc+KKLiho
        MkqZpq7U0aQ2IjWx4UFJNZkc169bO+S4kLlj7u9QlxTpC3Q48s5HY7A4wJHVAWsN
        uviiLlU190bmFHfBqdbNuWPA9Bl/oorH0qcnJRzDoDZTEOzV99ax1d6g+CXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        i56a14606.fm1; t=1662120045; x=1662123645; bh=ZOo52ojNLD+QQW1owu
        GlJGIJHO9inLm8ClF8VUiGMYc=; b=RiVPKGcUZp5HCdJHIyJkhIwH94i5ibwBiY
        oIFBEtvkT5pEFqhCw8suvvo7zv+tFQylSuIgMGfzqvRjfMsr09J8LJ25TAG4A1Og
        ZvgL5Yawofqm5gp1rqdKtCSfr5Y6feD3oZ+Xcs2wJcvV9YKY7FblBQlDZYdj18F+
        ieBUJRAGKot6vy/iMUWaAxvCiXfr7dD2j3nweX3d+fo89N6tfjQufBXjRjzYiNr0
        0swaOd8oblHwLSMK5LzNxEFrmHggOx0jKAYA/QZ0/nnsRPklrgz1CDkNYwUqhZ6h
        D8bKPP++xX+JoFHh4uBKaHJJsbmr46Yeuoj//lmBLDDq0srXLCQQ==
X-ME-Sender: <xms:avARY_2heRUfPqzyIL4IWlfH7Os1mu-7k3xmipOo1apEBOFrm-xOow>
    <xme:avARY-FihW90435Acqlsl7wZZKrtjU8wiT0q7xaxcnUAkZrAyt6HpLLPkSJC6ooLC
    mqW6FTXNKxnVPxQyG4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeltddggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:avARY_6XbY9hs3wScqe1qqj7Xf1BthXQwtKpnCrpx_-P-A-QUs9BXA>
    <xmx:avARY01XQy-i_4phqIgYyyKTukNtLkEINc--1WuLQR9mcTJtQQDpKA>
    <xmx:avARYyEeWx3R73AJIrsgUSWMqyoneyLQ7lQOaM1kr4Pu7SL78CqP4g>
    <xmx:bPARYyKt9OEaSeHAoGO_VplbOvjcsP71GId8kxYOMELNnqTZReQByw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 83F4AB60083; Fri,  2 Sep 2022 08:00:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-841-g7899e99a45-fm-20220811.002-g7899e99a
Mime-Version: 1.0
Message-Id: <254b7b9d-72b7-4b3a-821a-51a2745ebac5@www.fastmail.com>
In-Reply-To: <CAHp75VfF78rWpC6+i2Hu6-PMULFeFMbqXhBVRkx5aFGFTU3U4A@mail.gmail.com>
References: <cover.1661789204.git.christophe.leroy@csgroup.eu>
 <abb46a587b76d379ad32d53817d837d8a5fea8bd.1661789204.git.christophe.leroy@csgroup.eu>
 <CAHp75VcngRihpfUkeKs-g+TbPnpOsZ+-Q37zDVoWp8p_2GbSvQ@mail.gmail.com>
 <18cda49e-84f0-a806-566a-6e77705e98b3@csgroup.eu>
 <1d548a19-feec-42b9-944d-890d6dde2fb8@www.fastmail.com>
 <CAHp75VfF78rWpC6+i2Hu6-PMULFeFMbqXhBVRkx5aFGFTU3U4A@mail.gmail.com>
Date:   Fri, 02 Sep 2022 14:00:21 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Andy Shevchenko" <andy.shevchenko@gmail.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc:     "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Linus Walleij" <linus.walleij@linaro.org>,
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
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 2, 2022, at 12:52 PM, Andy Shevchenko wrote:
> On Wed, Aug 31, 2022 at 11:55 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> ...
>
>> drivers/gpio/gpio-adp5520.c:    gc->base = pdata->gpio_start; // unused
>> drivers/gpio/gpio-adp5588.c:            gc->base = pdata->gpio_start; // unused
>> drivers/input/keyboard/adp5588-keys.c:  kpad->gc.base = gpio_data->gpio_start; // unused
>> drivers/input/keyboard/adp5589-keys.c:  kpad->gc.base = gpio_data->gpio_start; // unused
>
> I believe we should convert them to -1.

This is probably something we should do separately, but a lot of the
drivers currently don't have support for probing from DT or any other
firmware interface but rely on platform_data definitions from a
board file that was never part of the upstream kernel.

We are going to remove a lot more board files early next year,
and I was hoping to follow up with a treewide cleanup of such
drivers and remove a lot of them entirely.

>> drivers/gpio/gpio-dwapb.c:      port->gc.base = pp->gpio_base; // from DT, deprecated
>
> From board files, since some platforms expect a fixed number for it.

>> drivers/gpio/gpio-pca953x.c:    gc->base = chip->gpio_start; // ???? used a lot
>
> To answer this one needs to go via all board files (most of them ARM
> 32-bit based) and look, but it means almost the same case as per Intel
> above: 512-ngpios.

Right, I went through all the board files the other drivers,
this one just happens to be used more than the others:

arch/arm/mach-davinci/board-da850-evm.c:#include <linux/platform_data/pca953x.h>
arch/arm/mach-ep93xx/vision_ep9307.c:#include <linux/platform_data/pca953x.h>
arch/arm/mach-mmp/ttc_dkb.c:#include <linux/platform_data/pca953x.h>
arch/arm/mach-pxa/cm-x300.c:#include <linux/platform_data/pca953x.h>
arch/arm/mach-pxa/spitz.c:#include <linux/platform_data/pca953x.h>
arch/arm/mach-pxa/zeus.c:#include <linux/platform_data/pca953x.h>
arch/arm/mach-pxa/zylonite_pxa300.c:#include <linux/platform_data/pca953x.h>
arch/arm/mach-s3c/mach-crag6410.c:#include <linux/platform_data/pca953x.h>

The only ones that have known users though are crag6410
and vision_ep9307, the other ones will be removed.

Vision-ep9307 has 128 GPIOs total, crag6410 is complicated because it
many different GPIO controllers in various combinations.

>> drivers/pinctrl/renesas/gpio.c: gc->base = pfc->nr_gpio_pins; // ??? don't understand
>
> I think, w/o looking into the code, that this just guarantees the
> continuous numbering for all banks (chips) on the platform.

Yes, that seems to be the idea most of the pinctrl drivers.

      Arnd
