Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216EF6C6A70
	for <lists+linux-arch@lfdr.de>; Thu, 23 Mar 2023 15:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbjCWOIN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Mar 2023 10:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjCWOIM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Mar 2023 10:08:12 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34D23801B;
        Thu, 23 Mar 2023 07:06:53 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 4B4EB5C00C1;
        Thu, 23 Mar 2023 10:06:21 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 23 Mar 2023 10:06:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1679580381; x=1679666781; bh=dY
        48kEVl9pgLxa2CyFA5QtbXG3NJEfHcCiZY//VXuhI=; b=N3CTATQ7q9ZFPQYbjV
        2M3sXLRM2ydNF/4V7sLh4NmkOAzI9HQjCc6cgXlL0VVeZCU+MMnXXyp+z/sy+Vja
        hz+o8yvkfpAY6CcmZfx+nB4/3SiUyZifZ0kioxWvtjd0WrCuk3Rdqwg7P6oj6oZw
        BP00DjLhNvHgy0S0vFIl76edKgf5TYfKRH2O88jk7FJaj68BZJoVLpX691hcsxXB
        HmZTxrTNuaJKQHIZe6DVgSZMU9ZxkBkKxM6cC1mBv5vh1U5LZ6qHUOGetE+5aQgH
        1J35G7Z2vO2KHY/Cqhexk2prWj8+onKH6dOYQ215k9JGqOWuoEesdDzaMQr+GgoQ
        dV1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679580381; x=1679666781; bh=dY48kEVl9pgLx
        a2CyFA5QtbXG3NJEfHcCiZY//VXuhI=; b=MrT5Zv5EfNpKnWV6JOjV1cAVQBsiX
        X69n9fMDOkRG2DaY40xnf5Xp5v5H30Wc3Xr9qL+lmaWpmZa2Wuyd+tdNv125UsbP
        BJvqNR5y/pu57M9ocW6THhNRR5JtPDlnmxrc1CKSGgDYHjPO//KOMd5PMWaHLfyn
        9OjZG1nQnKekdjHEbdkq/UjVimMEMNx/Iil1ZfVlq53WnAwn5RlxAJ8mabhpf5wf
        Axs6dZHlmj7Aufn5J1+a/S3f4OlW6IwLmZ5TKy93kubwd57uWAFPFb8YVlfjbAFv
        sNDuEf9qNuS2Hw5ZIdzqNt2HRbnFfCeESmChliRFB1zR1kIF8SLq/E9bQ==
X-ME-Sender: <xms:3FwcZIMb2z1yB6dpSJjclnQp0c-g-lab80yefJt_urC7W_tgT_ULPQ>
    <xme:3FwcZO-EvG-pyZdpHzyWeIH89xbuD-8PDBV5dbYy0EPs7X6Y5ySw-sXvrWR5U-GXe
    876k-6A86weXyQFOn0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeggedgheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:3FwcZPSrZ7jEVy-WPrRZ5LUBHatN2NLK7f773ycdY-B25mAA0VgZPQ>
    <xmx:3FwcZAvbdApivWiyh4QQ7VI6OANcoDaPBkkoLTzsFyEASiWhklMopA>
    <xmx:3FwcZAfq9CQcGmPgxlBY_2tFfqCwjAviKvXsxQMQxyKYhMNeoGvvuQ>
    <xmx:3VwcZE9Hgf136vtECKcakHIv9C-QVEG_JWMzrPs17JgoSwjI7bqzog>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 21472B60086; Thu, 23 Mar 2023 10:06:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-236-g06c0f70e43-fm-20230313.001-g06c0f70e
Mime-Version: 1.0
Message-Id: <357de40d-e1bd-4e67-9a8c-240ed2ef7809@app.fastmail.com>
In-Reply-To: <14a5fa1cc6edd9a297b20af779b68d1e58f83419.camel@linux.ibm.com>
References: <20230314121216.413434-1-schnelle@linux.ibm.com>
 <20230314121216.413434-16-schnelle@linux.ibm.com>
 <20230316161442.GV9667@google.com>
 <607a80040fc7e0c8c7474926088133be1e245127.camel@linux.ibm.com>
 <97b5a5c3-d20f-4201-8deb-1d34e7edee6c@app.fastmail.com>
 <14a5fa1cc6edd9a297b20af779b68d1e58f83419.camel@linux.ibm.com>
Date:   Thu, 23 Mar 2023 15:05:59 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Niklas Schnelle" <schnelle@linux.ibm.com>,
        "Lee Jones" <lee@kernel.org>
Cc:     "Pavel Machek" <pavel@ucw.cz>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
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
        linux-leds@vger.kernel.org
Subject: Re: [PATCH v3 15/38] leds: add HAS_IOPORT dependencies
Content-Type: text/plain
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Mar 23, 2023, at 15:02, Niklas Schnelle wrote:
> On Thu, 2023-03-23 at 14:32 +0100, Arnd Bergmann wrote:
>> On Thu, Mar 23, 2023, at 13:42, Niklas Schnelle wrote:
>> > On Thu, 2023-03-16 at 16:14 +0000, Lee Jones wrote:
>> > > On Tue, 14 Mar 2023, Niklas Schnelle wrote:

> Yes, sorry I was traveling Thursday to Monday and then spent some time
> catching up and investigating an internal issue. I'm currently going
> through the patches one by one incorporating comments. I fear the split
> of the USB patch as well as the suggestions for video might take a bit
> of time, so if you prefer I could also send just an updated patch 1
> separately. How would I do this cleanly? Send as v4 without(?) a cover
> letter and add a Note after the '---'?

Yes, that sounds good to me. In case you need multiple
versions, I would suggest you continue counting at v4
independently for both the preparation patch and the
rest of the series.

    Arnd
