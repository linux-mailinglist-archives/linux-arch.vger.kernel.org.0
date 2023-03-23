Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82BF6C698B
	for <lists+linux-arch@lfdr.de>; Thu, 23 Mar 2023 14:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbjCWNdB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Mar 2023 09:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbjCWNc6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Mar 2023 09:32:58 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8007C26C21;
        Thu, 23 Mar 2023 06:32:54 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 1E8545C019C;
        Thu, 23 Mar 2023 09:32:51 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 23 Mar 2023 09:32:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1679578371; x=1679664771; bh=lS
        jp5ItBmhWT9xUkDsgQrEKtWC/JiZkjQJaqsouqKsY=; b=WKd5BdXaz0bjKNcnYo
        2t29u4D6AxPNZvlBgEegmaxPmZZ+lERvx5OpEa1XFKcgkE5moCpPo1pbPRa4LGsF
        Xsrn3NG0cZ9tuUqhugPUGk7gPrdk3HNG+JBWmMhvjdNGZ+PyaBkJjvBK2ROVkZb+
        0zgivhpMaYm8TJOlR4mCnP0vsKOOFRUgVVt00qmL2jKli+cKoF9Oi/eGi/7HQama
        XTqbv/yCO+s8YV5v287KxMgvR9Z5XZdTC9hTWNTp76LJyapOAVZ9fewBdxxXrGUE
        8c786DVMYyNYsJ0/1IsAoczLM7V2iSF0xHUKOX7a/n7oYE88Umv47lLF9zee32XU
        Sybg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679578371; x=1679664771; bh=lSjp5ItBmhWT9
        xUkDsgQrEKtWC/JiZkjQJaqsouqKsY=; b=eBANsLqlNwqef/I23uYLMELTWFE3R
        mec1E4E5f6fKV/7l1gjMWp6cs0YZ7N1rf0rOVaokKeo3/85BkuoqmUwgsUdIW6JN
        p/5L2OBWczZ/NxXtnIjV2joult6ACUWzh4+dFwSCd+QEgO1NbSzVCCQgr5yZMBTj
        P7NMw3QHKrxa309gBSb6jnGHgKJu3HDcmT7hwyvPVaJOxC6m6Ul0NMauHqL3o4d/
        EggF0o8t19/dNfWEz0CKITqUuay3XYc7Z6g0jvPkAftDS/RcXQgFoknJkU0KHTZF
        8BZeQAHZ3T6ZBg7xA+5zdtGh1HM1BK30D/CqTBLV0hjrnXbbz+vy41j8g==
X-ME-Sender: <xms:AlUcZDL30vVch_WqY5mIkcVkYZ8NSm3h4a0jXK6psU-0U3WE-n9pYA>
    <xme:AlUcZHJI-LpQtyfpHr7JTG5VleHDiH2lcm4MKyf-mxqjW2hRJbDuYarJKQMx-ivrR
    IMIov0rxxN4Wa2Rtlg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeggedghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:AlUcZLucRUlqDVzQKvewhxJyh3joyiDiIb5jNV7JOR7aIRFykzhzIw>
    <xmx:AlUcZMYpu6h09cWvJMxCVIfgLjDbiu-wp0TJ7XzW_QbtagZJtBKWgA>
    <xmx:AlUcZKZxBHJlde-1lKaOJwSQa12UZE5XZjyiDJzmf599Ai8i7bqi1g>
    <xmx:A1UcZPLW9FtN6gyQMNVThN-NzF7j6YHNiwh8xg6Vht1V4-Df43c3YA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 699E6B60086; Thu, 23 Mar 2023 09:32:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-236-g06c0f70e43-fm-20230313.001-g06c0f70e
Mime-Version: 1.0
Message-Id: <97b5a5c3-d20f-4201-8deb-1d34e7edee6c@app.fastmail.com>
In-Reply-To: <607a80040fc7e0c8c7474926088133be1e245127.camel@linux.ibm.com>
References: <20230314121216.413434-1-schnelle@linux.ibm.com>
 <20230314121216.413434-16-schnelle@linux.ibm.com>
 <20230316161442.GV9667@google.com>
 <607a80040fc7e0c8c7474926088133be1e245127.camel@linux.ibm.com>
Date:   Thu, 23 Mar 2023 14:32:30 +0100
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
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Mar 23, 2023, at 13:42, Niklas Schnelle wrote:
> On Thu, 2023-03-16 at 16:14 +0000, Lee Jones wrote:
>> On Tue, 14 Mar 2023, Niklas Schnelle wrote:
>> 
>> > In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
>> > not being declared. We thus need to add HAS_IOPORT as dependency for
>> > those drivers using them.
>> > 
>> > Acked-by: Pavel Machek <pavel@ucw.cz>
>> > Co-developed-by: Arnd Bergmann <arnd@kernel.org>
>> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
>> > ---
>> >  drivers/leds/Kconfig | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> Applied, thanks
>
> Sorry should have maybe been more clear, without patch 1 of this series
> this won't work as the HAS_IOPORT config option is new and will be
> missing otherwise. There's currently two options of merging this,
> either all at once or first only patch 1 and then the additional
> patches per subsystem until finally the last patch can remove
> inb()/outb() and friends when HAS_IOPORT is unset.

It's probably too late now to squeeze patch 1 into linux-6.3
as a late preparation patch for the rest of the series in 6.4.

It would be good if you could respin that patch separately
anyway, so I can add it to the asm-generic tree and make
sure we get it ready for the next merge window.

     Arnd
