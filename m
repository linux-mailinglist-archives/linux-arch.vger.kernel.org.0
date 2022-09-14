Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63DC35B88CD
	for <lists+linux-arch@lfdr.de>; Wed, 14 Sep 2022 15:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbiINNEX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Sep 2022 09:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiINNEW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Sep 2022 09:04:22 -0400
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com [64.147.123.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9286C6C76B;
        Wed, 14 Sep 2022 06:04:17 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id B55D82B05D9C;
        Wed, 14 Sep 2022 09:04:12 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Wed, 14 Sep 2022 09:04:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1663160652; x=1663164252; bh=8JfDZhGhDT
        nn1MAP2k2cOZYtoltqkx4/4nhZ1F4oVjI=; b=QDwr9SP7k1+Rj0nzhL5WKBQMDL
        sNTfbUpxIfB3tqtQq12h0/L2PRquqoSfuoYUaaycp/EqwHZvflbQwhxse6kOObuO
        NKc/y7tHADHGfaaRjuMmv0XTMceixzHeQXl7uySZ9cYZcynJeTtuC909Z5E3Trfd
        T8W3owPE4ElN3mV06XJKBBfLqbt8E2z2gp+LEBVQ+ZvSsZxwaSxhCv1KBGb+sXFw
        eUDOVZKV1YQfeKagI74PIBBhr3FAxn8trX9WSwNqLXXCClm/r9U20TNEPiDD2KyC
        GGtA+/nmj4Fsd8Njn8L+Zp5rpWEbGwUU1O0oMQqZPSPoMOUgG59xgv//LmRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1663160652; x=1663164252; bh=8JfDZhGhDTnn1MAP2k2cOZYtoltq
        kx4/4nhZ1F4oVjI=; b=0wnZz1ZSbLPgR4yFtqMTBONUEFWQrj+tHyZmktK7ETNW
        KE7PHz3c/pjFHiFG29UngXbh34qegeLtgUwTlrNweGyouPfxs67G4SWH6x27s7Ff
        geGW5pIKTpVsGC1wacj884HLBb+FtSB9iRyZJp1Z1dSAUYnyH4ZmachyHWiy7NOL
        dov7QhBV7SSzBuE0/NLu+IOJ4JozlOp1HUsp7lit+Pwj/tYAivPUyzZ46atW6vSt
        rcjTWm7sIE0UE/2MaD8b7rwXXNfM1hDAWtBN2jlMfFHCNsMatr/rWSU8d2p79R1g
        k7gOTZQlSD1mTD7XvBKFKUWDFW+IXK5IpN/YzZENfg==
X-ME-Sender: <xms:StEhY52OyGyuiuNnCSm1jWO3pmAfykjEaZQE-i3xFprB1YarT5Tgjg>
    <xme:StEhYwHjN2iFwC36_VY7eYaqkwr7QgGQzq_GWaYQQjVGjPX6gbfxzTjWGi0OMYb-Y
    dFsxzBc5kuGXl5-dMc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeduiedgiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:StEhY57lCrCC5oZmyJsh6s1pof64IlhVvSl5qqj-khKX8lpvg1Gf2Q>
    <xmx:StEhY20ke7UzJk_Ivp6dNoIjESH-zJ7xbcC_Em8VhXG3WX5uEfDT3g>
    <xmx:StEhY8E06D4FGJV6kqK2odCAjQ98DgN7QxlNkYW02lFzMr2QlVt-2Q>
    <xmx:TNEhY0L75ishRnnifktbGHJSW8DfLk-Syoyyy_o3QZWSUcn8_V2dLA-S_fk>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 918E0B60086; Wed, 14 Sep 2022 09:04:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-934-g6274855a4c-fm-20220913.002-g6274855a
Mime-Version: 1.0
Message-Id: <a7cb856c-8a3f-4737-ae9e-b75c306ad88e@www.fastmail.com>
In-Reply-To: <CACRpkdbazHcUassRMqZ2oHmama3nWEZ3U3bB-y-3dmo3jgFPWg@mail.gmail.com>
References: <cover.1662116601.git.christophe.leroy@csgroup.eu>
 <CAMRc=MehcpT84-ucLbYmdVTAjT86bNb9NEfV6npCmPZHqbsArw@mail.gmail.com>
 <b348a306-3043-4ccc-9067-81759ab29143@www.fastmail.com>
 <CACRpkdbazHcUassRMqZ2oHmama3nWEZ3U3bB-y-3dmo3jgFPWg@mail.gmail.com>
Date:   Wed, 14 Sep 2022 15:03:50 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Walleij" <linus.walleij@linaro.org>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Cc:     "Bartosz Golaszewski" <brgl@bgdev.pl>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
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

On Wed, Sep 14, 2022, at 2:38 PM, Linus Walleij wrote:
> On Wed, Sep 7, 2022 at 12:15 PM Arnd Bergmann <arnd@arndb.de> wrote:
>> >>  drivers/gpio/gpio-sta2x11.c              | 411 -----------------------
> (...)
>> sta2x11 is an x86 driver, so not my area, but I think it would be
>> best to kill off the entire platform rather than just its gpio
>> driver, since everything needs to work together and it's clearly
>> not functional at the moment.
>>
>> $ git grep -l STA2X11
>> Documentation/admin-guide/media/pci-cardlist.rst
>> arch/x86/Kconfig
>> arch/x86/include/asm/sta2x11.h
>> arch/x86/pci/Makefile
>> arch/x86/pci/sta2x11-fixup.c
>> drivers/ata/ahci.c
>> drivers/gpio/Kconfig
>> drivers/gpio/Makefile
>> drivers/gpio/gpio-sta2x11.c
>> drivers/i2c/busses/Kconfig
>> drivers/media/pci/Makefile
>> drivers/media/pci/sta2x11/Kconfig
>> drivers/media/pci/sta2x11/Makefile
>> drivers/media/pci/sta2x11/sta2x11_vip.c
>> drivers/media/pci/sta2x11/sta2x11_vip.h
>> drivers/mfd/Kconfig
>> drivers/mfd/Makefile
>> drivers/mfd/sta2x11-mfd.c
>> include/linux/mfd/sta2x11-mfd.h
>>
>> Removing the other sta2x11 bits (mfd, media, x86) should
>> probably be done through the respective tree, but it would
>> be good not to forget those.
>
> Andy is pretty much default x86 platform device maintainer, maybe
> he can ACK or brief us on what he knows about the status of
> STA2x11?

I think the explanation given by Davide and Alessandro
was rather detailed already:

https://lore.kernel.org/lkml/Yw3LQjhZWmZaU2N1@arcana.i.gnudd.com/
https://lore.kernel.org/lkml/Yw3DKCuDoPkCaqxE@arcana.i.gnudd.com/

    Arnd
