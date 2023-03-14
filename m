Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E20966B98ED
	for <lists+linux-arch@lfdr.de>; Tue, 14 Mar 2023 16:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbjCNPZ5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Mar 2023 11:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbjCNPZ4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Mar 2023 11:25:56 -0400
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 45DB8A9082;
        Tue, 14 Mar 2023 08:25:52 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.west.internal (Postfix) with ESMTP id B5AC02B069D9;
        Tue, 14 Mar 2023 11:08:43 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 14 Mar 2023 11:08:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1678806523; x=1678813723; bh=K4
        tQ8ndVOUfpM0Pr+iYsgl8sdiO//rofLCiHgEHKHaw=; b=Bs89wlqsdZVa4k07Fb
        epoolTHKszWvfBhS2lZVBBRcF2IS0ywxX526WC1eBDNhzycvLK/kat0+XRfJx2W3
        7bMNtqMaeH4ZJIdGU9yRt8ThnhgzDS7LLG23ou/0reQhjVATwpoCDU2V8vqm2W1g
        J+1jlCnkFsdB00fs75PZcsnbMJQ5s0C5KPnLZjhqSn8SwimhhuRyHr4X0dC/PTsg
        runNfLuCg/cSr0AkAoZgfQFS4waYRIDooAHqrMWtZtpzKTnjgRDZ+8reMknQWs0Z
        eoZ852c0rPiprZQoIxvBFd9ZExdObLmVVzDXAkThfBx5XDZj6gfT51hkb+yCSOEK
        qb1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1678806523; x=1678813723; bh=K4tQ8ndVOUfpM
        0Pr+iYsgl8sdiO//rofLCiHgEHKHaw=; b=FcVdEJUEJOBFn8vyntSfSiv6vsKGS
        hxzdTfs9AcxmtwZ5y1sR0yXhzJ99CF9MXTpWC+ABwuF7Rtpv1TkBGNjNpsV6Om5f
        dtPB6w6JUNhXycjYrxPIg/RAWfQny5kcjIIZY4MsTNL5WQMkK9FZ5JVjfkhq6000
        I4KrV9UjqLokn4iBCs+nAu+QFd5+zWcdFsaymVn1JdQjXp5p6OIcBjLpx4QgreLj
        wYQZ3SOWH6tcEuqWKW6Z+BaR70e/RUZ9Fa/F4u+0ul++229JrQKHN7GgAgMbAdAD
        4cns8a5dDWvtxvYx+83RxxNxPzNTvcFgOby7T3TIytlb8ZsA7HgRcFHmw==
X-ME-Sender: <xms:-o0QZK7P_IOpvfkXAJTvZsGq0nxcIFi21rXd_e5XDXLyhDMebh2_nA>
    <xme:-o0QZD7dmPVC77qe5xy7iIFqqccVdVdsSEIY2cJ65en99sOTy5DG8bDWDMZEjjCjK
    kg8yMOB41kCCRQNqFA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddviedgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:-o0QZJc_ZJnv__s_0rxNyhivqegZK7Z_v0h4mlYw68ZNd9X5urONyg>
    <xmx:-o0QZHIp6DY7kGHp39y5XRCh11PF4bviEV4MGoRs_tuGNYI_P-Cn5g>
    <xmx:-o0QZOLVcUPTfqPTZ6w7QlCi-H2uAW7eIfDzED9woacZag2egABCvQ>
    <xmx:-40QZDB8FC5V93wwc2nXAo4BNIGlkdi-SW-0xyTxCo85UPhNMS4EWPMW1F4>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 018F2B60086; Tue, 14 Mar 2023 11:08:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-221-gec32977366-fm-20230306.001-gec329773
Mime-Version: 1.0
Message-Id: <9894438c-dca7-40cf-adb8-4bc7cb7b5c02@app.fastmail.com>
In-Reply-To: <CAMuHMdXXapUNn2-_+WWULq1ELLJEzVgJ7CZ-OJpbTSy-=JjZVA@mail.gmail.com>
References: <20230314121216.413434-1-schnelle@linux.ibm.com>
 <20230314121216.413434-4-schnelle@linux.ibm.com>
 <CAMuHMdXXapUNn2-_+WWULq1ELLJEzVgJ7CZ-OJpbTSy-=JjZVA@mail.gmail.com>
Date:   Tue, 14 Mar 2023 16:08:20 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Niklas Schnelle" <schnelle@linux.ibm.com>
Cc:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Corey Minyard" <minyard@acm.org>,
        "Peter Huewe" <peterhuewe@gmx.de>,
        "Jarkko Sakkinen" <jarkko@kernel.org>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
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
        openipmi-developer@lists.sourceforge.net,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v3 03/38] char: impi, tpm: depend on HAS_IOPORT
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 14, 2023, at 15:17, Geert Uytterhoeven wrote:
>> --- a/drivers/char/Kconfig
>> +++ b/drivers/char/Kconfig
>> @@ -34,6 +34,7 @@ config TTY_PRINTK_LEVEL
>>  config PRINTER
>>         tristate "Parallel printer support"
>>         depends on PARPORT
>> +       depends on HAS_IOPORT
>
> This looks wrong to me.
> drivers/char/lp.c uses the parport API, no direct I/O port access.

It looks like include/linux/parport.h requires I/O port access
when PARPORT_PC is enabled and PARPORT_NOT_PC is disabled.
Maybe this would work:

      depends on PARPORT
      depends on HAS_IOPORT || PARPORT_NOT_PC

       Arnd
