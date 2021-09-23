Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1372641689D
	for <lists+linux-arch@lfdr.de>; Fri, 24 Sep 2021 01:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243606AbhIWXxl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Sep 2021 19:53:41 -0400
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:45349 "EHLO
        wnew1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240701AbhIWXxl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 23 Sep 2021 19:53:41 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.west.internal (Postfix) with ESMTP id 2E9F72B012E2;
        Thu, 23 Sep 2021 19:52:08 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
  by compute2.internal (MEProxy); Thu, 23 Sep 2021 19:52:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type:content-transfer-encoding; s=fm3; bh=v5nvr
        /c1C/JJVmNNr0va2VihjkEqDsuPinNtEL20Fdc=; b=PN3PhQyrhimN59gLGDQV9
        ANiT+SLLncPigslF+EAy2Zn/Tx42UkzGoiF69KBelRU4npjeszLYM00fa2WELfkL
        SqojfcOMiP/MncB+gavSPOlVuWOBrsdYs1tfEBWDQRyptahAhxfiiBCfwiIJcxQU
        ZJvY9/exfaEfInxUL0oRG4zKOKMXWljPVPa9TKwhw3z1tjxOLLdL9iFqCvi5B1oi
        xfbbOTcNxDIQ0DzxTb1w3ZQnC9+O4hALTe99Utg7p4ucCqPQbcDW6WEO/3y3IMbb
        eaJfn7Z+9zxFGB0cPzpCoEktCxM2TLrxHYkNsZi27j83u3MH22dM4lIAzQ5FIw+Z
        Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=v5nvr/c1C/JJVmNNr0va2VihjkEqDsuPinNtEL20F
        dc=; b=kqnF05pOr3bw7a5nr6W4nw7ziUQTbyaZdPED5SM/rUvrsiIPZnnMUsHwy
        9QSiYS5dr0XwaLsGXbyQoXjWGp2Mg5OZLWP7umTr9o7C+ps0jZ/RCWlj/yse0diC
        kVX9Ln03U6mJUlza/37k+nZx3Q3Xmh9VAWvMjo68Re2AdqZNGjoXVeT7FYXfSG5m
        mOkqgSivjKU8XNTIPtQJBEd0vjU27jlga/+VCjvjWIr9jk9AkvqjbHYdnGdO67yM
        0lN+B8IFJqVSmJVpEuyPtmg7N9FaKNpIWzzwcbqfj9im1L/GURGKLD97df8fq3HV
        MQ1cGbAAx47KZX/r7aceGerJvMqdQ==
X-ME-Sender: <xms:JRNNYQla6U3TgG6kPTxEZ5gMMR5R4jVth9b9kI39ypTWhO5-QmU8aw>
    <xme:JRNNYf2HgekmJSsAzQtuysqxC40ljJKKKtQ3CjuduHcbkkXyf3iz6TXs8V1pP2gdo
    pQ5K0YP3mjPZbePOJo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudejtddgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpedflfhi
    rgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
    eqnecuggftrfgrthhtvghrnhepfeetgeekveeftefhgfduheegvdeuuddvieefvddvlefh
    feehkeetfeeukedtfeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:JRNNYeqM8IYHSAdhfq4eVoPxRSkYb9eYyOcMBUJEWnQvXUYQWsU6Vg>
    <xmx:JRNNYcmnoas90TO5o7OvIp_CHG7109HlHZzkEM0wSVbeqa-9PWGvuw>
    <xmx:JRNNYe3KIogSyRNp6MYQVd9YMJs6hEgtDA9_0Alad5VyJ74JUe6VWw>
    <xmx:JxNNYcxMhFsWQDz8PXuGgkNW053t18SsCC4gBS0IxmgkY2tE-jvUls0KKBY>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8ECC5FA0AA5; Thu, 23 Sep 2021 19:52:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1303-gb2406efd75-fm-20210922.002-gb2406efd
Mime-Version: 1.0
Message-Id: <16d09c59-ba76-4dca-b9f2-bde502b96ecf@www.fastmail.com>
In-Reply-To: <20210921155708.GA12237@alpha.franken.de>
References: <cover.1631583258.git.chenfeiyang@loongson.cn>
 <3907ec0f-42a0-ff4c-d4ea-63ad2a1516c2@flygoat.com>
 <CACWXhK=YW6Kn9FO1JrU1mP_xxMnEF_ajkD6hou=4rpgR2hOM5w@mail.gmail.com>
 <20210921155708.GA12237@alpha.franken.de>
Date:   Fri, 24 Sep 2021 00:51:35 +0100
From:   "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To:     "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        FreeFlyingSheep <chris.chenfeiyang@gmail.com>
Cc:     "Thomas Gleixner" <tglx@linutronix.de>, peterz@infradead.org,
        luto@kernel.org, "Arnd Bergmann" <arnd@arndb.de>,
        "Feiyang Chen" <chenfeiyang@loongson.cn>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        linux-arch@vger.kernel.org, "Huacai Chen" <chenhuacai@kernel.org>,
        "Zhou Yanjie" <zhouyu@wanyeetech.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v2 0/2] MIPS: convert to generic entry
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



=E5=9C=A82021=E5=B9=B49=E6=9C=8821=E6=97=A5=E4=B9=9D=E6=9C=88 =E4=B8=8B=E5=
=8D=884:57=EF=BC=8CThomas Bogendoerfer=E5=86=99=E9=81=93=EF=BC=9A
>
> can people, who provided performance numbers for v1 do the same for v2=
 ?

Sorry I just move abroad (to UK) to seek higher education. Currently I d=
on't have any MIPS device available so I won't be able to provide test r=
esults as v1.

I'll try to get some MIPS devices soonish.

Thanks.

>
> Thomas,
>
> --=20
> Crap can work. Given enough thrust pigs will fly, but it's not necessa=
rily a
> good idea.                                                [ RFC1925, 2=
.3 ]

--=20
- Jiaxun
