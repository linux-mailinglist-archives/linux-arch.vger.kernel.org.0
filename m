Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE7E6F1934
	for <lists+linux-arch@lfdr.de>; Fri, 28 Apr 2023 15:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346219AbjD1NRa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Apr 2023 09:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjD1NRX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Apr 2023 09:17:23 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32541BC5;
        Fri, 28 Apr 2023 06:17:20 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id AB7305C00BE;
        Fri, 28 Apr 2023 09:17:17 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 28 Apr 2023 09:17:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1682687837; x=1682774237; bh=PcHVTECY0DTSklc3ILW7xV/aJ7/Nau9fSJX
        oavdaK3A=; b=eUdK2nJGUj2ojcq/iN8+k9NH/YFehW26tD8EuLHi59mfHw77XBh
        fsxNlrmYAQkqxYxfq6y27vgAktDmUq34FmXwMFdqTfPO9loKN1XNr+UVkGw680qV
        BX4/DYfgCMWrAxE4Wow3ZwgWlN0ZNzHHEAtYzaMI7xLQjVEHla6fM+TZ1yvnzX8P
        E9OEYJ2zcL1QVyo974JDoFI3uCjuLc0KDC60ytqogt91Vrtguy8dOzwcDADe8Q8K
        wwGN7a6AzKt12/FKaJ6yE4xZxx1mfSbCRrBkh1w9kOWf+J/cSrAHTesLpKGIXn3y
        r/ezr2uqH7xDgE1v6IYlgXMzGM/v2wMUp7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1682687837; x=1682774237; bh=PcHVTECY0DTSklc3ILW7xV/aJ7/Nau9fSJX
        oavdaK3A=; b=UHAR/6bgsNPLLEMAvooCE2Mz7rvShUkiKAolMysUv1eAD0G8pRJ
        Axt2cEsFq+HL0Sk84JLCYXyIoo4UY6iWfrU5QyWSoznl6Dl9up0oJPS8fmgZCkKN
        EmUFVujWaEm9kpXEdbpvXC1srFotbipILlqEP+BJC/wZA/MRDDmTDOObpyzAXcfr
        P5fPwPdeW2skiNrFbXI8pS1Fet/chSbd2eiKQ8NJCdOODy4lMW1yCHqd7i+2kw0m
        kkAAHSUBJawkS7oRrDqwSvWgWl0YC4FGX0wEe7mqbkV7MbyF4ZFqT2f9EaWXdta5
        UEG6fShDzo25wuyIzYe0uuavmo6nS5Qe20w==
X-ME-Sender: <xms:W8dLZGx3L9IVhQ2Z-Dm1gEY_dwHGXe32-QXDVpGxL4oZOrgre8krDA>
    <xme:W8dLZCT9BitiC8iWSIbkWjDY3CQ3ktYEHuCqF4lu4DEpLRIH__A8UyQjFfr8K3-Q_
    Hql-wi5bFWVO6i97bQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedukedgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:W8dLZIV4-CWeJ_MAEkYa-T1q9H3_MDecIqHVzquAXQO4y7Xxr-G-sA>
    <xmx:W8dLZMg6khyrtIk2_xVeJ0jwab7q97YJj0EgH88Gpq1BMDBeqvzniA>
    <xmx:W8dLZIB7tmcXPfPCpXuu_s8_Ujf8-kwPj0DVIS5NrKHqzYp1SN7Ggg>
    <xmx:XcdLZPBenYiA6kEk2QhVgO0DBNH2txmCkaSu9NuYz9QpUDkjGGj7IA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A158DB60086; Fri, 28 Apr 2023 09:17:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-374-g72c94f7a42-fm-20230417.001-g72c94f7a
Mime-Version: 1.0
Message-Id: <f612c682-5767-4a58-82f6-f4a4d1b592a1@app.fastmail.com>
In-Reply-To: <CAMuHMdUGjtiAR37L4_e0_p8ee2=gxoUj7+e7rqMLTBK+vpV4yw@mail.gmail.com>
References: <20230428092711.406-1-tzimmermann@suse.de>
 <20230428092711.406-6-tzimmermann@suse.de>
 <430c73f0-45f4-f81e-6506-bc8cc955d936@arm.com>
 <CAMuHMdUGjtiAR37L4_e0_p8ee2=gxoUj7+e7rqMLTBK+vpV4yw@mail.gmail.com>
Date:   Fri, 28 Apr 2023 14:17:24 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Robin Murphy" <robin.murphy@arm.com>
Cc:     "Thomas Zimmermann" <tzimmermann@suse.de>,
        "Helge Deller" <deller@gmx.de>,
        "Javier Martinez Canillas" <javierm@redhat.com>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        "Vineet Gupta" <vgupta@kernel.org>,
        "Huacai Chen" <chenhuacai@kernel.org>,
        "WANG Xuerui" <kernel@xen0n.name>,
        "David S . Miller" <davem@davemloft.net>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        "Sam Ravnborg" <sam@ravnborg.org>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, loongarch@lists.linux.dev,
        linux-m68k@lists.linux-m68k.org, sparclinux@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org
Subject: Re: [PATCH v2 5/5] fbdev: Define framebuffer I/O from Linux' I/O functions
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

On Fri, Apr 28, 2023, at 13:27, Geert Uytterhoeven wrote:
> On Fri, Apr 28, 2023 at 2:18=E2=80=AFPM Robin Murphy <robin.murphy@arm=
.com> wrote:
>> On 2023-04-28 10:27, Thomas Zimmermann wrote:

>> > -
>> > -#elif defined(__i386__) || defined(__alpha__) || defined(__x86_64_=
_) ||      \
>> > -     defined(__hppa__) || defined(__sh__) || defined(__powerpc__) =
|| \
>> > -     defined(__arm__) || defined(__aarch64__) || defined(__mips__)
>> > -
>> > -#define fb_readb __raw_readb
>> > -#define fb_readw __raw_readw
>> > -#define fb_readl __raw_readl
>> > -#define fb_readq __raw_readq
>> > -#define fb_writeb __raw_writeb
>> > -#define fb_writew __raw_writew
>> > -#define fb_writel __raw_writel
>> > -#define fb_writeq __raw_writeq
>>
>> Note that on at least some architectures, the __raw variants are
>> native-endian, whereas the regular accessors are explicitly
>> little-endian, so there is a slight risk of inadvertently changing
>> behaviour on big-endian systems (MIPS most likely, but a few old ARM
>> platforms run BE as well).
>
> Also on m68k, when ISA or PCI are enabled.
>
> In addition, the non-raw variants may do some extras to guarantee
> ordering, which you do not need on a frame buffer.
>
> So I'd go for the __raw_*() variants everywhere.

The only implementations in fbdev are

 1) sparc sbus
 2) __raw_writel
 3) direct pointer dereference

But none use the byte-swapping writel() implementations, and
the only ones that use the direct pointer dereference or sbus
are the ones on which these are defined the same as __raw_writel

      Arnd
