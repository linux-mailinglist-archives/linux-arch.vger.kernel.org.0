Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80146BA85F
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 07:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbjCOGtr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Mar 2023 02:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjCOGtp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 02:49:45 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4744EE5;
        Tue, 14 Mar 2023 23:49:15 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 5C8DE3200921;
        Wed, 15 Mar 2023 02:47:11 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 15 Mar 2023 02:47:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1678862830; x=1678949230; bh=gr
        HG0CFu8Z1+2/8Mmnr5OQSzmOKguliTez6kFLL3ny8=; b=S0URSN+hXjEgzlVvI9
        X8hY8ZmcE9SuVzuyckho/hqLUzvOIarzf085FQK4I9Wd+osdkMFQIH0BzfHdBSpa
        3lv2cdpwyj5+E/0w20geerd0FxJ4okJRlisn5w7iP/OC+NjcySBjV32tLSbmv3xU
        gNN5wYzurtjnnrgcahUxOcBXlTuXIf+iWgZWRZee8fXbQ6/jDqkKCbIf4fpRo5Gk
        POmvwhkaWasHl8dLIxxzw+1Cyt1EAKlzvmnu50XhXFdgXr4YCZg/B7CIPx4tEwZ0
        sNu4w2oIB9tZxjZP8E4uk/njca2PZzpAKyHauBA+f0wr7EBqCyHvXrT7DkYJQM2c
        Gz0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1678862830; x=1678949230; bh=grHG0CFu8Z1+2
        /8Mmnr5OQSzmOKguliTez6kFLL3ny8=; b=S2CQ3E5kggWVOBBfwGOlI77viGaJg
        GaO5ElvrytTiBEZ1hs0HPyqEsRvfgpNL6A/FSyUPeniqhuZzpLY9sqEjLCtD/Vgf
        o3mvY8DH+SEhH6mToaJBkOI5ug1QrjZqZjUclApJXGV1OH3NIQXS4vgbNmuFrTaY
        +h42Y99aWYLeK7Q5RjRpMITFxRGiASzRuUS+tbM8KiVjWNxRJaCRroSWRLgDnopk
        Xpr9wmIwzIEfK8Z0bbdOrVK/LwpVP7NAjf0YhI9LUn1PBp1Z+zUnNEzKfFyKLO8G
        HLTW5ZKO7rlH7SBBGvFxievXH5Pn1+/cV+eWI1AdySbgpv2H6rVzFiP6g==
X-ME-Sender: <xms:7mkRZPG10vDUXuDIdnhN4KK16a5GBqUxwDDpOJ0uHOu90739fhdWbQ>
    <xme:7mkRZMUZUNktru7V91KLgI3UrqdIYZBM0Bp2WFDPFpT20h24ZI45BauW07v8fD0vY
    HokGueA_6vcwSbAAic>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddvjedgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:7mkRZBJPPg0xgpTfm0YIbJvb6p4qCKL-jf_Z1BQ4o__zYl3aB_jCNg>
    <xmx:7mkRZNFCDWQ9qZaX-gfZY-O0EABdwRbJy7WIJZctkVI0XyVMkMvNeg>
    <xmx:7mkRZFX9nJaTv2hVNvhE1MbBrWmvQb3W-24_IIGN3X6-PSHM4UNUnw>
    <xmx:7mkRZGtdF6FB0bjSerMHgCvHBzS9NqioWar8iO4lC0UB1nTHyg9XoA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3A014B60086; Wed, 15 Mar 2023 02:47:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-221-gec32977366-fm-20230306.001-gec329773
Mime-Version: 1.0
Message-Id: <e31e32f0-86bf-4178-afad-b731ea49e673@app.fastmail.com>
In-Reply-To: <7453aba3-9f2a-4723-3039-a85652883b48@opensource.wdc.com>
References: <20230314121216.413434-1-schnelle@linux.ibm.com>
 <20230314121216.413434-3-schnelle@linux.ibm.com>
 <7453aba3-9f2a-4723-3039-a85652883b48@opensource.wdc.com>
Date:   Wed, 15 Mar 2023 07:46:49 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Damien Le Moal" <damien.lemoal@opensource.wdc.com>,
        "Niklas Schnelle" <schnelle@linux.ibm.com>
Cc:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
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
        linux-ide@vger.kernel.org
Subject: Re: [PATCH v3 02/38] ata: add HAS_IOPORT dependencies
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 15, 2023, at 02:23, Damien Le Moal wrote:
> On 3/14/23 21:11, Niklas Schnelle wrote:
>> In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
>> not being declared. We thus need to add HAS_IOPORT as dependency for
>> those drivers using them.
>
> I do not see HAS_IOPORT=y defined anywhere in 6.3-rc. Is that in linux-next ?
> There is a HAS_IOPORT_MAP, but I guess it is different.

It's defined in patch 1 of the series, so the later patches
can't be applied into subsystem trees without that.

We can either merge patch 1 as a preparation first, or keep it
all together as a series.

      Arnd
