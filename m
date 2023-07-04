Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3EA746FD6
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jul 2023 13:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjGDLZu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Jul 2023 07:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjGDLZt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Jul 2023 07:25:49 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7969D;
        Tue,  4 Jul 2023 04:25:48 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 2BC8A5C0393;
        Tue,  4 Jul 2023 07:25:48 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 04 Jul 2023 07:25:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1688469948; x=1688556348; bh=EqlpD8ctHndfSnkUlREzHKZC65GCu4q4Tsy
        hQ+ThTmI=; b=ggVhmnDy4OR3yU2/Lnq7+qH5v1CDYfosvqFClzK7RAkdyi1PRft
        DjfINRwwEB2g4RqBozaK7iOPx4dX1NinelFLcddjDnfJnuHCpavnPn+RMkpHwPjZ
        vzohlHfsDyAKTCpvkQjA1asVREd9ds+HuudOMl6ISubKTKCLABCecJFXdolfCkBK
        BijdTjlJlCaub41V7gerSzBlwcxIuQh8DIJEtZUushcYbs96t4bRSIfYDS277iQI
        BG2RWYgRxZUFRgNpuFz/XRYB4jpIFyE6lmYOtNj3ddqq5HzZTHtJTXSHege/nX4G
        JpbOLmh7roJuP//VQuzNxo44ltEez7Fklog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1688469948; x=1688556348; bh=EqlpD8ctHndfSnkUlREzHKZC65GCu4q4Tsy
        hQ+ThTmI=; b=VeMVfZIenI9jWN3jHWfyUc1R9e+WfmmsZoD0L0RVkdNlgZuQd/+
        L1l8szSOaRkosMjJvDMaRdL5FWQ1+E5KpJQdNrN/tygAm2X/+d9cqSWk/fiqCj6z
        L8vy7OBYPB5NMvdWODQIxMQhlRm2ZvDIFPk3yNeWT0XEwcNVjVBGzdDmVw4zr6gx
        wL1+YqSMHtHIBcJP8XtRFhpkY0R1TzpZGr87LX1ozrtAbLBtUZCZmvZ69Npgy/+E
        Zr9lQIv/bjDiZSwFgPoWZAgztTCLkpc0LxTFJsUpKjnNhCRGXNe2mdF8O0nGb7zA
        AvhGxoL3bjs1g9jDPlJfRjsGPMeZ8zPqaGw==
X-ME-Sender: <xms:uwGkZGWYXvoVQ5NQxYBJgSSl6DQ7V-Ezq_7r6q9VP-K-N-4znf3C-A>
    <xme:uwGkZCm9Q_LRoRQVfA-Dg-WKuTKznPGs01Qep6h9ko3KVl6ATE9B4GlNsG7iWMmRc
    rM9-DUTO_oS9iAptW0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudeggdegtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudektdfg
    jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:uwGkZKa49un1WKhFFE7BiSjINF75DUy1nPGHxyH0ymtvdW2JHXMEKg>
    <xmx:uwGkZNUu3bn1p58vjtrV-gPYJe0IMXqbDeLdXLjrzY6xFrM9oxOKlQ>
    <xmx:uwGkZAkT4PlLehBP1H9k5VKTBjaMCP8qJG5-7wRaG_cLFmBmEEkwCw>
    <xmx:vAGkZK1ogmP1K0dcsmqQ_8XkGO-O5j3sGwmsxt9qblHj6ibSKaQyMw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 23982B6008D; Tue,  4 Jul 2023 07:25:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-527-gee7b8d90aa-fm-20230629.001-gee7b8d90
Mime-Version: 1.0
Message-Id: <28a513fd-1e7c-4772-a3c1-f312938459ed@app.fastmail.com>
In-Reply-To: <CAMuHMdUAkRB9z2cqq6XBDKi-8zLyKxdw_PaT_TwLj78S5B6J8g@mail.gmail.com>
References: <20230522105049.1467313-1-schnelle@linux.ibm.com>
 <20230522105049.1467313-31-schnelle@linux.ibm.com>
 <CAMuHMdUAkRB9z2cqq6XBDKi-8zLyKxdw_PaT_TwLj78S5B6J8g@mail.gmail.com>
Date:   Tue, 04 Jul 2023 13:25:22 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Niklas Schnelle" <schnelle@linux.ibm.com>
Cc:     "Alessandro Zummo" <a.zummo@towertech.it>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
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
        linux-rtc@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v5 30/44] rtc: add HAS_IOPORT dependencies
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 4, 2023, at 10:06, Geert Uytterhoeven wrote:
> Hi Niklas,
>
> On Mon, May 22, 2023 at 12:51=E2=80=AFPM Niklas Schnelle <schnelle@lin=
ux.ibm.com> wrote:
>> In a future patch HAS_IOPORT=3Dn will result in inb()/outb() and frie=
nds
>> not being declared. We thus need to add HAS_IOPORT as dependency for
>> those drivers using them.
>>
>> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
>> Signed-off-by: Arnd Bergmann <arnd@kernel.org>
>> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
>
> Thanks for your patch, which is now commit 8bb12adb214b2d7c ("rtc:
> add HAS_IOPORT dependencies") upstream.
>
>> --- a/drivers/rtc/Kconfig
>> +++ b/drivers/rtc/Kconfig
>> @@ -1193,7 +1195,7 @@ config RTC_DRV_MSM6242
>>
>>  config RTC_DRV_BQ4802
>>         tristate "TI BQ4802"
>> -       depends on HAS_IOMEM
>> +       depends on HAS_IOMEM && HAS_IOPORT
>>         help
>>           If you say Y here you will get support for the TI
>>           BQ4802 RTC chip.
>
> This driver can use either iomem or ioport.
> By adding a dependency on HAS_IOPORT, it can no longer be used
> on platforms that provide HAS_IOMEM only.

You are correct, we could allow building this driver even
without IOPORT and make it use ioport_map() or an #ifdef.

> Probably the driver should be refactored to make it use only
> the accessors that are available.

Since the driver itself has no DT support, it looks like the
only way it can be used is from the sparc64/ultra45 wrapper,
but that architecture always provides CONFIG_IOPORT, so I
don't think it makes any difference in the end. We can change
this again if another user comes up.

It might be good to know whether the machine uses a memory or
I/O resource in its device tree.

      Arnd
