Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2CB36FC1AA
	for <lists+linux-arch@lfdr.de>; Tue,  9 May 2023 10:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234976AbjEIIXf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 9 May 2023 04:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233301AbjEIIXT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 9 May 2023 04:23:19 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D80D847;
        Tue,  9 May 2023 01:23:07 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 5847832005CA;
        Tue,  9 May 2023 04:23:04 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 09 May 2023 04:23:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1683620583; x=1683706983; bh=0x0EJZSPnTuOoehTVDyE1xCCMKkbxs59wdf
        2AEDY4tI=; b=BOjEn1/8BYJSo4xslG2X2ZbiGSkb+4CmMxucyiw7qxBOQbs46Rs
        8Vd7ZGX1kwL2VuqmjDMjGuSgHBr+zLIGctN62/KtRelMVgVNrScKBOGjm+z2Vk/I
        GnxZR027+xzVAh1GeEvvtmGHN+X2KnN9/ZQHkwKEhQqOo400zWcrwG/x8X0b1RmU
        8+QrMiZuH/M2lTitSd5WeX8OBXB8fmVzeh1s/s8eBuWzpdsyvDw04phtc4GfHrxL
        qzMf80g9q42cS2M29W2WC0vF/g1AnbEgGxalxAEf2Fe0Vmasf6F1mQfnLW2uuIpN
        FsYnTFzJUn8r4XE+3V8ulf6SBLbmBEVhOjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1683620583; x=1683706983; bh=0x0EJZSPnTuOoehTVDyE1xCCMKkbxs59wdf
        2AEDY4tI=; b=gPRKo0LWc06IEsg7HGxUJ+rK9sQ31IpRbDaE+qFI/D6sC/SI3j6
        73uGhciIhT1vYGkERvWPWEylRGDWlYIFzv2nq/5O82noARrFgwXdONINGnepoeYw
        8oIUrVfrFW8PbDTP90XFaN5N0gmVI8ERrrtl4Da8CnBVISgNprWXucy1TSOH3iVY
        Vt87ajyNSmkhs3W9CBabZod6m6wfHpEX6XXUgFVkcP8O6kOWpjDY2BdT0ng4WS72
        EwVNR0OMKiCy9AC+/Lrrsfsr0Kew0a+zu2M75cSseF/OgUJHoFApNHnWyXXHYZzb
        6tonmBM0PGB2THLzb0o9dlZlF5L5IZjh5vQ==
X-ME-Sender: <xms:5wJaZEaE0s7IhZ1hlHJDtNFFLSxb_RitkKi94VWC8w-qH1Qh3QJo4A>
    <xme:5wJaZPZR9x6nfdBCeTz-tFIZ2RuXVwv-mklsVwxYUbeZd5g9aaurRSPMAX1OqidCY
    SAr4-1U5tI4SlyAIDY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeegtddgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:5wJaZO9BGT1h0Ddc0-GnAdeSWLKSrESAolZ-SBBazeUVtVAbKsBfQg>
    <xmx:5wJaZOo4NQSZeZ8g1cuQf4lhPM-XX7KUWdzEINTQkbfpOKCjasF9dg>
    <xmx:5wJaZPo7xzsubHAp8tsHHHCQqvtlMnhfHdCC-H-nhntBGjEiTweNdg>
    <xmx:5wJaZFaesDuNGZppfXOzcue1S4hJafbpWTQwsn0mgQJ8kBtKuLYyLA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 037CAB60086; Tue,  9 May 2023 04:23:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-415-gf2b17fe6c3-fm-20230503.001-gf2b17fe6
Mime-Version: 1.0
Message-Id: <552c51fb-41b2-430b-b13c-0e578098dbf6@app.fastmail.com>
In-Reply-To: <CAMuHMdXJ=hsB=A_umQnPMVSU+BGqeHt3O-2ygr3p_f7pHHvf=Q@mail.gmail.com>
References: <20230314121216.413434-1-schnelle@linux.ibm.com>
 <20230314121216.413434-29-schnelle@linux.ibm.com>
 <202303141252027ef5511a@mail.local>
 <aa68b4afdca34bf3bfd2439b03e6f9bcfad94903.camel@linux.ibm.com>
 <b7017996-b079-4534-a24a-080003772a66@app.fastmail.com>
 <CAMuHMdXJ=hsB=A_umQnPMVSU+BGqeHt3O-2ygr3p_f7pHHvf=Q@mail.gmail.com>
Date:   Tue, 09 May 2023 10:22:42 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc:     "Niklas Schnelle" <schnelle@linux.ibm.com>,
        "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
        "Alessandro Zummo" <a.zummo@towertech.it>,
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
        linux-rtc@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Subject: Re: [PATCH v3 28/38] rtc: add HAS_IOPORT dependencies
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 9, 2023, at 08:38, Geert Uytterhoeven wrote:
> On Mon, May 8, 2023 at 10:01=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> =
wrote:
>> On Mon, May 8, 2023, at 17:36, Niklas Schnelle wrote:
>>
>> I think the m68k/atari and mips/dec variants don't necessarily
>> qualify as PIO, those are really just pointer dereferences, and
>> they don't use the actual inb/outb functions.
>>
>> On atari, it looks like HAS_IOPORT may be set if ATARI_ROM_ISA
>> is, but on dec it's never enabled.
>
> Atari does not use RTC_DRV_CMOS, but still relies on generic RTC
> instead.

Ah right, I now remember working on that code, so we're good on
m68k then. I think it should work for everyone using

       depends on HAS_IOPORT || ARCH_DECSTATION

in that case, as that is the only exception.

> Last time (in 2013?) I tried converting to RTC_DRV_CMOS by registering
> an "rtc_cmos" platform device, I couldn't get it to work.

If you ever want to revisit this, I suspect the harder part here
is to detach arch/m68k/ from the RTC_DRV_GENERIC code first, pushing
the device registration into the individual machine specific time.c
code. It's probably not even worth trying to share the rtc-cmos
driver, but it might be useful to share the library code like
RTC_DRV_ALPHA does.

   Arnd
