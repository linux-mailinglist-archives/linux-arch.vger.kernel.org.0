Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A717067EC
	for <lists+linux-arch@lfdr.de>; Wed, 17 May 2023 14:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjEQMVO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 May 2023 08:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbjEQMVM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 May 2023 08:21:12 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409955FCC;
        Wed, 17 May 2023 05:20:56 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id A81C0320010B;
        Wed, 17 May 2023 08:20:54 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 17 May 2023 08:20:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1684326054; x=1684412454; bh=io
        DFLJqXuMHAy8ZisCrVAdUFi7mpfdRTggwR7KwpJ/I=; b=n1+OhcBGIbGgmnDFTH
        9Mp8FunJF/Hj/m5OKnDmlfaCkq4bZXBhTlz6GGzoPR2SbbWho71/Err4OXmIevWI
        ESr4wZq2mgan4gHRFlfwv33DmOCGcK2RlqYT/VjkesDxHVj1YW/GlIkbA5gHSsT/
        nl8uJ8XKVxL4G/2NYy4TBe+UGpQzd0CYxjxGG7RV/+3E8mE+sOuKqFME1a/WH8Hf
        jgxuV9328QHf1xMBHntkZMHtWUhoifd7cOxaCv6y5m8Sq8/IrWMM68s6GJvf94K+
        ycPL00bX1KQQ/Zs46Sf0RfaqZzW4vVTBXS7d+isPBUvo2cPq85tka8RGYkNn/y2G
        RkbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684326054; x=1684412454; bh=ioDFLJqXuMHAy
        8ZisCrVAdUFi7mpfdRTggwR7KwpJ/I=; b=i1f9JIu1fAnawdVfNkN7qv45bSE8x
        +ENHwvsHdfUDHBpwpjkL9JDAxcQ9uuoGYWq8g9Zjmn6BkpzR/o5kovp+HGQKoqwy
        yrmHrjxik89+HDUeCMwgfzdayqaRE7HpCMUFZrJaA+Vv2WqbuiLvtkn6/ZKXuzSC
        CFKRCUZzMLNvIda9U0kcdc9EKIZLnbqUxPKJx5uCsAYJAPk/Gy0gDTLUfjIrOKKm
        fN/kVAjB/Qy7ZR4parXhSwHQZTvUzDATofyE7soLA8NOd63Ey0Ad6s1dBdvllxJS
        z4Bjj13auITa7dF2YELLrIbZ1ZfUqs/BWCu8qmlqDs99JC9JZ1hcZM2LQ==
X-ME-Sender: <xms:pcZkZFcu1YK1pDGxm-zCjddI4eueG27Txfy48615KJ9ZCcMmBqaDQg>
    <xme:pcZkZDMBka7qpxkgt1Gj7XBZDWH6AO36Do687ffDYMPFmejsBGUzvAkFVn64tyezu
    Gf-lkaCQuvXGEz4wCM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeiuddgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:pcZkZOisNec3xayVss6IpafKIKHWIjh-pHIYfpYe80MbdsgSE0XFsw>
    <xmx:pcZkZO969oU0bgwiGrTDEgRjbGONCKHOrWvEQYL_WydOcqpgDk3pZw>
    <xmx:pcZkZBvW_E64HmOTtezyw8u5bw8FkEn5QLhMmG4wJeXPxwDaqT99CA>
    <xmx:psZkZCOQ8jQceD-rTypMpzpJ48UNMzRbGAJQ9qyno1x07JpeSqLE4w>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 31633B60086; Wed, 17 May 2023 08:20:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-431-g1d6a3ebb56-fm-20230511.001-g1d6a3ebb
Mime-Version: 1.0
Message-Id: <440855f4-897c-4597-bbe6-7c5f295f616a@app.fastmail.com>
In-Reply-To: <2c03973e-0635-4dbb-a1df-bfda8cbee161@rowland.harvard.edu>
References: <20230516110038.2413224-1-schnelle@linux.ibm.com>
 <20230516110038.2413224-36-schnelle@linux.ibm.com>
 <2023051643-overtime-unbridle-7cdd@gregkh>
 <2c03973e-0635-4dbb-a1df-bfda8cbee161@rowland.harvard.edu>
Date:   Wed, 17 May 2023 14:17:58 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Alan Stern" <stern@rowland.harvard.edu>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     "Niklas Schnelle" <schnelle@linux.ibm.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Albert Ou" <aou@eecs.berkeley.edu>, linux-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-pci@vger.kernel.org, "Arnd Bergmann" <arnd@kernel.org>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v4 35/41] usb: uhci: handle HAS_IOPORT dependencies
Content-Type: text/plain
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 16, 2023, at 22:17, Alan Stern wrote:
> On Tue, May 16, 2023 at 06:29:56PM +0200, Greg Kroah-Hartman wrote:
>> On Tue, May 16, 2023 at 01:00:31PM +0200, Niklas Schnelle wrote:
>
>> I'm confused now.
>> 
>> So if CONFIG_HAS_IOPORT is enabled, wonderful, all is good.
>> 
>> But if it isn't, then these are just no-ops that do nothing?  So then
>> the driver will fail to work?  Why have these stubs at all?
>> 
>> Why not just not build the driver at all if this option is not enabled?
>
> I should add something to my previous email.  This particular section of 
> code is protected by:
>
> #ifndef CONFIG_USB_UHCI_SUPPORT_NON_PCI_HC
> /* Support PCI only */
>
> So it gets used only in cases where the driver supports just a PCI bus 
> -- no other sorts of non-PCI on-chip devices.  But the preceding patch 
> in this series changes the Kconfig file to say:
>
>  config USB_UHCI_HCD
> 	tristate "UHCI HCD (most Intel and VIA) support"
> 	depends on (USB_PCI && HAS_IOPORT) || USB_UHCI_SUPPORT_NON_PCI_HC
>
> As a result, when the configuration includes support only for PCI 
> controllers the driver won't get built unless HAS_IOPORT is set.  Thus 
> the no-op case (in this part of the code) can't arise.

Indeed, that makes sense.

> Which is a long-winded way of saying that you're right; the UHCI_IN() 
> and UHCI_OUT() wrappers aren't needed in this part of the driver.  I 
> guess Niklas put them in either for consistency with the rest of the 
> code or because it didn't occur to him that they could be omitted.  (And 
> I didn't spot it either.)

It's probably less confusing to leave out the PCI-only part of
the patch then and only modify the generic portion.

      Arnd
