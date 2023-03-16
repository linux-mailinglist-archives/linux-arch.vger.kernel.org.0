Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8217E6BD352
	for <lists+linux-arch@lfdr.de>; Thu, 16 Mar 2023 16:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbjCPPWd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Mar 2023 11:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbjCPPWa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Mar 2023 11:22:30 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1299DFB68;
        Thu, 16 Mar 2023 08:22:19 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id D7DEA5C0151;
        Thu, 16 Mar 2023 11:22:18 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 16 Mar 2023 11:22:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1678980138; x=1679066538; bh=Gu
        9CGWBhuU9kfdDCy2f8ZEW/D76K6Q/Tbp9CvfberEs=; b=XQJYvEzxTMhu2lrbR9
        NSUIJaM46GKfLcq/jwORrPj8Wygwv3+T5rcTzfUT8Eu8Ks5i61xHDE7ZZJk4qkbA
        odKA07TScOtGGqs1DhOVjmg628ClLE2WvOe5WkHB1sE78oLmfxE+hpkEb/ibC+wj
        ji2jH0MlXHFoIz+7eZsMz8Tp+ihON8wGY6wu772BW1Wi2lSPzrpg2DU/gXVPrPxA
        r20PqoKytbvK6rJczlHXnz9LeZwF6DgLCP2b0nQNI1wALyKvgd7oxV+8TPJ8YIQO
        4wDrHih1/jbV4PAZLrI+WNUEJiTIJN13w++RXMT4B5uRG2SToUv8ypcSlsKHdCWe
        7L2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1678980138; x=1679066538; bh=Gu9CGWBhuU9kf
        dDCy2f8ZEW/D76K6Q/Tbp9CvfberEs=; b=W7fBa07kX8DNIjvBS2eGvcFZfb9QT
        AgQ0u3hS4z49wQVgOG2DYtx5bHjt6+ETxCXUx0jFcRFuXRHyKJRGIXOTYI3ZzPJI
        LGvdnEjiSP5CsqbPEJZfQNnPxysJKoYUiFldBJebTr57RPrx9bijuPNIhqsjoP5M
        a87ph59TJOB/Y0LSxDz1UtoOh34shb20a4eQIuo4uBIsfrPdCBQkj4oR2Dovp4Bv
        tvxtl+uyRiel5aTaN57ZtyVR2C3vS4Jrm1N53IYqb3Ujf58MSZb0TnVosxv4yjPN
        oKNgJ1diDTr2JkupgBhkSJTRitxE4r2i0YYSp77CjEJ+gswKxgSeiBC+Q==
X-ME-Sender: <xms:KTQTZN5CcGBOrkSGSjmbV2W2L-D6ylziRckElPy35rIpTKRRL0oiRQ>
    <xme:KTQTZK4Iflz6DrqRA68IzpXEPSUMsJgViqHa1XrqTEmYYvBzKWaddxncfYFUeYIq7
    Vs7llqb0CLML0q804Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeftddgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:KjQTZEdePnnd-bLyYdlOrG6oo24ABDT9lHKGS7Kmxi1Z__ii7CyVKw>
    <xmx:KjQTZGJamWj9rcFX3RG3WE_JIcJ-XQj6Rs6fZ6hUbWPD2ua6n3OGRg>
    <xmx:KjQTZBJMG9vi-Xb1NXz7SpwrlDhK6hlwbZDgXrN9OlBD-NGya1NnTg>
    <xmx:KjQTZDg4paiw_2ieGp7OleYbMFuqq18rgEiTNMXgWkF594uAcp65bA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E1276B60083; Thu, 16 Mar 2023 11:22:17 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-221-gec32977366-fm-20230306.001-gec329773
Mime-Version: 1.0
Message-Id: <2f07c421-7f9c-4e53-8bd5-46be07bb5c89@app.fastmail.com>
In-Reply-To: <9a1c49b0-2271-53c7-7f48-039f83d39e82@opensource.wdc.com>
References: <20230314121216.413434-1-schnelle@linux.ibm.com>
 <20230314121216.413434-3-schnelle@linux.ibm.com>
 <CAMuHMdVry2YViJ5oFgo9i+uStWbhy7mXKWdWvCX=qgAu1-_Y1w@mail.gmail.com>
 <c7315ca2-3ebf-7f3b-da64-9a74a995b0ae@opensource.wdc.com>
 <CAMuHMdVajEYsw8HrKw0GwV+09gbtkhjVMuKZ6RSBvq6got=jAg@mail.gmail.com>
 <9a1c49b0-2271-53c7-7f48-039f83d39e82@opensource.wdc.com>
Date:   Thu, 16 Mar 2023 16:21:58 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Damien Le Moal" <damien.lemoal@opensource.wdc.com>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc:     "Niklas Schnelle" <schnelle@linux.ibm.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        "Alan Stern" <stern@rowland.harvard.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Albert Ou" <aou@eecs.berkeley.edu>, linux-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-pci@vger.kernel.org, "Arnd Bergmann" <arnd@kernel.org>,
        linux-ide@vger.kernel.org
Subject: Re: [PATCH v3 02/38] ata: add HAS_IOPORT dependencies
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Mar 16, 2023, at 00:57, Damien Le Moal wrote:
> On 2023/03/15 20:36, Geert Uytterhoeven wrote:

> Ah. OK. I see now. So indeed, applying the dependency on the entire ATA_SFF
> group of drivers is very coarse.


> Can you change this to apply the dependency per driver ?

I think that will fail to build because of this function
on architectures that drop their non-functional
inb/outb helpers:

int ata_pci_bmdma_clear_simplex(struct pci_dev *pdev)
{
        unsigned long bmdma = pci_resource_start(pdev, 4);
        u8 simplex;
 
        if (bmdma == 0)
                return -ENOENT;
 
        simplex = inb(bmdma + 0x02); 
        outb(simplex & 0x60, bmdma + 0x02);
        simplex = inb(bmdma + 0x02);
        if (simplex & 0x80)
                return -EOPNOTSUPP;
        return 0;
}

This is only called from five pata drivers (ali, amd,
cmd64x, netcell, serverworks), so an easy workaround
would be to make sure those depend on HAS_IOPORT
and enclose the function definition in an #ifdef.

        Arnd
