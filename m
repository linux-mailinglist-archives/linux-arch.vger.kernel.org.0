Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92925B016D
	for <lists+linux-arch@lfdr.de>; Wed,  7 Sep 2022 12:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbiIGKPS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Sep 2022 06:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbiIGKPI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Sep 2022 06:15:08 -0400
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDEC25588;
        Wed,  7 Sep 2022 03:15:02 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id CF3012B059F7;
        Wed,  7 Sep 2022 06:14:59 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Wed, 07 Sep 2022 06:15:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1662545699; x=1662549299; bh=UmErXfxWmw
        fotEsmsDPTW3AU+XHqokuOWaVIqSNnJFU=; b=e67eu/2Sau6rqKLtSjHFTtHnaQ
        sYFIdetsex7+OyjkVCLZ9beeQM0Mj/IeHdY5qLHK5/qa9DCDvlLfEE0vXVsM++FW
        DmI/pO1hL9RP2EFDsAEE3ZnAqtF6BaG2jIBVsYacgmki9ZiMgYsXxo4j1ZXSX9am
        YWAAb2igRgEssKmR+azw8g+pGFpKueubV/O/pNMRsjRI65T0mBNq1diDNtzgyRRi
        BgsjNAl0Lz/1ivUtK2a7FQjQi0ubIrbxh0shz6nEs/S2OgZa23RbnQvx6QX/6NnK
        4qfC1NcLXSP+byXBtZ5fMkEPxzPtxh4drQDP4xaivqxX8mhLS+T3qZooLzIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1662545699; x=1662549299; bh=UmErXfxWmwfotEsmsDPTW3AU+XHq
        okuOWaVIqSNnJFU=; b=gTKIwCiZt86E5s5vG5fI33tYaugRTJZhOxCAbdnOKqVO
        koCeLg26AixgJHv7xcEnAVxt2f+uq1Qe9Ly/XZ9AZxNADVEoNEuSTGAaJ1MVz9Xv
        vEs4uekKsxYNrk27iiUJQKpMO5V9w1ithQ8yq6Sl4fwmsTAW1q1KnTVjnJ8fY9iP
        Pk1BQNuHauJpW3b8oe5l248mJVUiGc/KcaSWHIQV88MILHRtmTjY2juOAMF16fZw
        9TFpjATLujFr5ARlnpjrbY4FALuKVkxhNB5Jt7IUi/vL1AUfPtj+Yah3oQmyM+jX
        hEXnmkP2LMNTlZ6Qq+wjqmzBuITrYXXD+pOTprwL+g==
X-ME-Sender: <xms:Im8YY4-zB8jizsFZUbdhZ7cQgbYb9bCeUnh0Z3zsNHcXxM9vVxqGqw>
    <xme:Im8YYwsKZOjKJ7WWo353mzbZGW2tQzA0JuhJaglRtfijovoc5gsezEZ-yuGQrdEII
    1Y3hM4PsLWPNmM17-8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedttddgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:Im8YY-CAIpeIMrSA33XANi56_-wSyqmDx83zlMGLBrCNm1JDzeKnaA>
    <xmx:Im8YY4eL3awRkF6q0khiLQ5sSOmH-E4e4PH_DDBP1MlQ94HXlXLtZw>
    <xmx:Im8YY9N2Z5S1YfDKXcAZptJ2D7xwO8QSkiH1M6PEbQFOARfWIzdRHQ>
    <xmx:I28YY4GQNGTdhuWe697LLmw2mSLNz7DZ60kD9zrtOAKd-nrNQXqNz3_17_M>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3CDB4B60083; Wed,  7 Sep 2022 06:14:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-927-gf4c98c8499-fm-20220826.002-gf4c98c84
Mime-Version: 1.0
Message-Id: <b348a306-3043-4ccc-9067-81759ab29143@www.fastmail.com>
In-Reply-To: <CAMRc=MehcpT84-ucLbYmdVTAjT86bNb9NEfV6npCmPZHqbsArw@mail.gmail.com>
References: <cover.1662116601.git.christophe.leroy@csgroup.eu>
 <CAMRc=MehcpT84-ucLbYmdVTAjT86bNb9NEfV6npCmPZHqbsArw@mail.gmail.com>
Date:   Wed, 07 Sep 2022 12:14:38 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Bartosz Golaszewski" <brgl@bgdev.pl>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>
Cc:     "Linus Walleij" <linus.walleij@linaro.org>,
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
        "Davide Ciminaghi" <ciminaghi@gnudd.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "Linux ARM" <linux-arm-kernel@lists.infradead.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-doc <linux-doc@vger.kernel.org>, x86@kernel.org
Subject: Re: [PATCH v2 0/9] gpio: Get rid of ARCH_NR_GPIOS (v2)
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

On Wed, Sep 7, 2022, at 11:58 AM, Bartosz Golaszewski wrote:
> On Fri, Sep 2, 2022 at 2:42 PM Christophe Leroy <christophe.leroy@csgroup.eu> wrote:
>>
>>  Documentation/driver-api/gpio/legacy.rst |   5 -
>>  arch/arm/Kconfig                         |  21 --
>>  arch/arm/include/asm/gpio.h              |   1 -
>>  arch/arm64/Kconfig                       |  12 -
>>  arch/x86/Kconfig                         |   5 -
>>  drivers/gpio/Kconfig                     |   8 -
>>  drivers/gpio/Makefile                    |   1 -
>>  drivers/gpio/gpio-aggregator.c           |   7 +-
>>  drivers/gpio/gpio-davinci.c              |   3 -
>>  drivers/gpio/gpio-sta2x11.c              | 411 -----------------------
>>  drivers/gpio/gpiolib.c                   |  13 +-
>>  include/asm-generic/gpio.h               |  55 ++-
>>  12 files changed, 33 insertions(+), 509 deletions(-)
>>  delete mode 100644 drivers/gpio/gpio-sta2x11.c

For the arch/arm*/Kconfig and include/asm-generic changes:

Acked-by: Arnd Bergmann <arnd@arndb.de>

sta2x11 is an x86 driver, so not my area, but I think it would be
best to kill off the entire platform rather than just its gpio
driver, since everything needs to work together and it's clearly
not functional at the moment.

$ git grep -l STA2X11
Documentation/admin-guide/media/pci-cardlist.rst
arch/x86/Kconfig
arch/x86/include/asm/sta2x11.h
arch/x86/pci/Makefile
arch/x86/pci/sta2x11-fixup.c
drivers/ata/ahci.c
drivers/gpio/Kconfig
drivers/gpio/Makefile
drivers/gpio/gpio-sta2x11.c
drivers/i2c/busses/Kconfig
drivers/media/pci/Makefile
drivers/media/pci/sta2x11/Kconfig
drivers/media/pci/sta2x11/Makefile
drivers/media/pci/sta2x11/sta2x11_vip.c
drivers/media/pci/sta2x11/sta2x11_vip.h
drivers/mfd/Kconfig
drivers/mfd/Makefile
drivers/mfd/sta2x11-mfd.c
include/linux/mfd/sta2x11-mfd.h

Removing the other sta2x11 bits (mfd, media, x86) should
probably be done through the respective tree, but it would
be good not to forget those.

      Arnd
