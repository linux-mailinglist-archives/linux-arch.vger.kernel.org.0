Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46610715DF8
	for <lists+linux-arch@lfdr.de>; Tue, 30 May 2023 13:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbjE3LzS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 May 2023 07:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbjE3LzR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 May 2023 07:55:17 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD3D1A2;
        Tue, 30 May 2023 04:54:39 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 00BF85C0095;
        Tue, 30 May 2023 07:54:13 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 30 May 2023 07:54:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1685447652; x=1685534052; bh=P+
        2rgMj4xQlfafj7GcrGEIKSMhcZ1qGdM9UbAgiRc6I=; b=KpZug7XlPd6I1x7Wff
        6Ic267AhM0pU+D26WvjCTNFBtR5jNha0vLw0Sybpz69ElQGgG/O0nrMaKWa+/vuL
        6M9VXXTLnngiS2Bbv1ZVDDEAWUtzXFukJ8dgBV7A8HM+RXiUqdAYspomQGRwwwTw
        HyhOlZoWYHo1e3IqmlP6dAk7YU359IFgQPxT86FAaKuG95trapBtiZnIZSpZ2wzE
        owCUYHf2Th8BujcrTPFuDhiNT3+sh77vC1OBB71hL5QLxerZgwb8lAYb6ASp8VjZ
        7pDITToH5UCRIhbVCm9fD4ynEGi/0triFLIHyjpUMp2PUEIUOTpCie3SNXiY4V/x
        O1vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1685447652; x=1685534052; bh=P+2rgMj4xQlfa
        fj7GcrGEIKSMhcZ1qGdM9UbAgiRc6I=; b=NLT3WQ2MbghARrWk4NbyL1DxwXO50
        Gotlj0w/VK/ciTqdYrcxqCy9MXNlXeczFqODZwJYCLwtATP/4KE4kl8xwkqPxH/z
        Rm+kQOr1MSG97y11F+QzD3pIuOYLU1GiL0h70ee+fmWPxUvfXin8kNVOtQP9qAAE
        1pRlkv+xGA066avXbTFi6gOTZ+NV7zbg7XchPCDogmVpc5tYk6Jdft9qjM2ivD+x
        wfkzPQyxboBvnGt2TyOB/oMY2q2Q+Jqy09zZBP79bnYF0fjC5vZYUwTLM9fg0BDJ
        5KYTL+mDdrpF10uw9EojQzlYWDBSEYZaozaDiMsaUdiGm8gvPNnJA2XeQ==
X-ME-Sender: <xms:4-N1ZHDhYwy2kAER34t5oBMC6QTzaExrHrEu1Cs7uUIn_PVNOxF6NA>
    <xme:4-N1ZNi4Rz7W56hfOfb21yEr6cEV1dn8c85d7fXudY53oU5pXhstSth_4y1jpoCXg
    zrly5P4S3I14hdbrpM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekjedggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:5ON1ZCkcHKNbXQkDsNVzJTcFg4gOdRYhZszSrkzYXvz3-PM8-L-jdg>
    <xmx:5ON1ZJw_9Hwas13sRVC4BIkyhesyohFKwGpi21LC28iXt1ZDpdzXsA>
    <xmx:5ON1ZMQBOc1HE7tFs6TTm0ftNSBwewtof97h66F_bu9tnWnHB0qL5A>
    <xmx:5ON1ZIqvkC7HuChiBDOnhAwP3yKfnmSDfYTF_NG-fbgP-rEaoUopEw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D80C0B60086; Tue, 30 May 2023 07:54:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-441-ga3ab13cd6d-fm-20230517.001-ga3ab13cd
Mime-Version: 1.0
Message-Id: <891e6ac4-30ae-4b86-b692-3b6b7b8b4e57@app.fastmail.com>
In-Reply-To: <2023053059-self-mangle-30b6@gregkh>
References: <20230516110038.2413224-1-schnelle@linux.ibm.com>
 <20230516110038.2413224-34-schnelle@linux.ibm.com>
 <2023053059-self-mangle-30b6@gregkh>
Date:   Tue, 30 May 2023 13:53:50 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Niklas Schnelle" <schnelle@linux.ibm.com>
Cc:     "Jiri Slaby" <jirislaby@kernel.org>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        "Alan Stern" <stern@rowland.harvard.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Albert Ou" <aou@eecs.berkeley.edu>, linux-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-pci@vger.kernel.org, "Arnd Bergmann" <arnd@kernel.org>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v4 33/41] tty: serial: handle HAS_IOPORT dependencies
Content-Type: text/plain
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 30, 2023, at 12:48, Greg Kroah-Hartman wrote:
> On Tue, May 16, 2023 at 01:00:29PM +0200, Niklas Schnelle wrote:
>> In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
>> not being declared. We thus need to add HAS_IOPORT as dependency for
>> those drivers using them unconditionally. For 8250 based drivers some
>> support MMIO only use so fence only the parts requiring I/O ports.
>
> Why can't you have dummy inb()/outb() so we don't need these #ifdefs all
> over the place in .c files?  Was that documented somewhere?  We do that
> for other driver/hardware apis, why are these so special they don't
> deserve that?

That was what our original approach did years ago, and Linus rightfully
rejected it. Almost every driver either requires inb()/outb() to do
anything, or it doesn't use them at all. The 8250 uart is one of the
few exceptions to this, as it has many variants.
It would be possible to separate this out more in the 8250 driver
as well and split it out into separate modules and indirect function
pointers, but that would be a larger rework and have a higher
risk of regressions.

Also, the 8250 driver is already full of #ifdef in .c files, 

    Arnd
