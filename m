Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8771273F8B8
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jun 2023 11:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjF0J2J (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Jun 2023 05:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjF0J2I (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Jun 2023 05:28:08 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A86F1737;
        Tue, 27 Jun 2023 02:28:02 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id DAE255C0213;
        Tue, 27 Jun 2023 05:27:58 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 27 Jun 2023 05:27:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1687858078; x=1687944478; bh=Xl7RK4t97evjZO5aZJujPG/k7nUDLC5JaHH
        QUcJEi/Y=; b=CzkmzfkVGZCqQGoJ6mSms6ZwFk0RtDf0pOT4kI9NyDeggfeUk8Q
        IJzwsEEBrriomwZG2+Fjelj4G+mlKlbi1kPhwdiKMsifIyBZDdqML5zkS+WD7Bwp
        0DWN1aF/eusaLFKYf4MlTDOkkx6Uo9nH1cRy468cZB096kH7pua6xyuvv2m3QhdI
        oQNn0LTtuM2qvdHXLcOiESEXHnkUroLh2bZUkpAfo9d0CylOkczYmtNQ7DI6iBfw
        Ov/CcAEV3cgDd9hqIGJ5V1ux2z62lBKESDAaa917XLnNv3NXT5o+3vK7pNEgVTcs
        tdirOUFWwYa73aR5Kz1ONasOCKrN9gsCmSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1687858078; x=1687944478; bh=Xl7RK4t97evjZO5aZJujPG/k7nUDLC5JaHH
        QUcJEi/Y=; b=QTR04SvqjqdNJ+Oeij+MQps0muW6x00SsJYc2fpbkqk48EKaNnr
        9PFtsZvX6w6Hzb4yn1RSBtaKGv/T/ILmQTPrleoqlnjsUVsdLwP9QN4Bh2a5P0ip
        5xClbTPiNw6j1oz+9V3bySwurJdZa54d9ww3GknwGAkwcEqzpP2PvplB1kwJ1Q8P
        0mYHtyYWce4nzCXpIk0XExAg2eTxUqvI3gFXUGsPabBX7tCZPOpwtDFFN+hAL8Bi
        v2PGC+8Y/hTTFvgH3InLozh5PnR43W1L+6K5/2V6PKanu3Iun4GIGsVb5DvgBuMa
        +kGT+GIpSMhBQejOtyMDTWANAyyXArUHz1Q==
X-ME-Sender: <xms:nquaZD9eEjWIoL4oOqtY8Kffivf2Nd0Jreq_N2vSgSY0ZcBSqx03BQ>
    <xme:nquaZPvWiOVyNU-AiWftJvTwaiehfQsvry05BRPVKY9wzwyiPHWUiOkIxGrJ0h0Qo
    IYQ9H5YB-eCNiMh6Uk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeehhedgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeetteeljeejgeeivdevhffhieefteekheevffevudeijeejgeduhedtvdff
    hefgheenucffohhmrghinhepghhoohhglhgvshhouhhrtggvrdgtohhmnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggs
    rdguvg
X-ME-Proxy: <xmx:nquaZBBjLX0cgwn5zP7qKWwTzJUzqBW7GbHyYxG84DbhQOqQzHnTlQ>
    <xmx:nquaZPf59oqN1VkHubuBN5PRV_2BXtLJUd8onFgKNiklQtW5J67mBA>
    <xmx:nquaZIMctO32Jbf8F02Qo590imv-jdOzba3vOCGx5St4IvlTs5UDzw>
    <xmx:nquaZHPg43M9_NN3zTiycGfiW1-RXcEvxJm5wMrk73jiOJoKsx48vw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 27A8CB60086; Tue, 27 Jun 2023 05:27:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-499-gf27bbf33e2-fm-20230619.001-gf27bbf33
Mime-Version: 1.0
Message-Id: <d0bca239-2711-4268-a36c-7c3434982ab1@app.fastmail.com>
In-Reply-To: <6120750daede4eb40fb4d44ed68ba58e5716e038.camel@mediatek.com>
References: <20230609085214.31071-1-yi-de.wu@mediatek.com>
 <20230609085214.31071-6-yi-de.wu@mediatek.com>
 <1a15767c-0518-3763-e8cb-e271df82f87c@collabora.com>
 <6120750daede4eb40fb4d44ed68ba58e5716e038.camel@mediatek.com>
Date:   Tue, 27 Jun 2023 11:27:34 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     =?UTF-8?Q?Yi-De_Wu_=28=E5=90=B3=E4=B8=80=E5=BE=B7=29?= 
        <Yi-De.Wu@mediatek.com>,
        "AngeloGioacchino Del Regno" 
        <angelogioacchino.delregno@collabora.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        =?UTF-8?Q?Yingshiuan_Pan_=28=E6=BD=98=E7=A9=8E=E8=BB=92=29?= 
        <Yingshiuan.Pan@mediatek.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        =?UTF-8?Q?Ze-yu_Wang_=28=E7=8E=8B=E6=BE=A4=E5=AE=87=29?= 
        <Ze-yu.Wang@mediatek.com>, "Will Deacon" <will@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        =?UTF-8?Q?MY_Chuang_=28=E8=8E=8A=E6=98=8E=E8=BA=8D=29?= 
        <MY.Chuang@mediatek.com>, "Trilok Soni" <quic_tsoni@quicinc.com>,
        "Conor.Dooley" <conor.dooley@microchip.com>,
        =?UTF-8?Q?PeiLun_Suei_=28=E9=9A=8B=E5=9F=B9=E5=80=AB=29?= 
        <PeiLun.Suei@mediatek.com>,
        =?UTF-8?Q?Liju-clr_Chen_=28=E9=99=B3=E9=BA=97=E5=A6=82=29?= 
        <Liju-clr.Chen@mediatek.com>,
        =?UTF-8?Q?Jades_Shih_=28=E6=96=BD=E5=90=91=E7=8E=A8=29?= 
        <jades.shih@mediatek.com>, "Conor Dooley" <conor+dt@kernel.org>,
        "dbrazdil@google.com" <dbrazdil@google.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?Q?Shawn_Hsiao_=28=E8=95=AD=E5=BF=97=E7=A5=A5=29?= 
        <shawn.hsiao@mediatek.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        =?UTF-8?Q?Ivan_Tseng_=28=E6=9B=BE=E5=BF=97=E8=BB=92=29?= 
        <ivan.tseng@mediatek.com>,
        =?UTF-8?Q?Chi-shen_Yeh_=28=E8=91=89=E5=A5=87=E8=BB=92=29?= 
        <Chi-shen.Yeh@mediatek.com>
Subject: Re: [PATCH v4 5/9] virt: geniezone: Add irqfd support
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 27, 2023, at 09:54, Yi-De Wu (=E5=90=B3=E4=B8=80=E5=BE=B7) w=
rote:

>> ..snip..=20
>> > diff --git a/drivers/virt/geniezone/gzvm_main.c b/drivers/virt/geni=
ezone/gzvm_main.c > index 230970cb0953..e62c046d76b3 100644 > --- a/driv=
ers/virt/geniezone/gzvm_main.c > +++ b/drivers/virt/geniezone/gzvm_main.=
c > @@ -113,11 +113,12 @@ static int gzvm_drv_probe(void) >   return ret=
; >   gzvm_debug_dev =3D &gzvm_dev; >   > -return 0; > +return gzvm_drv_=
irqfd_init();=20
>> ret =3D gzvm_drv_irqfd_init(); if (ret) return ret;=20

Something went wrong with the quoting up here, please make sure to
use plaintext email instead of html.

>> return 0;=20
>
> We're wondering the pros and cons for this coding style.
> Could you kindly give us some hint for possibly we could miss it somew=
here.
>
> Some other suggestion had been made by AOSP reviewer on the very line=20
> mentioned. As a consequence, we'd like to dig in the rationale behind=20
> such debate.
> https://android-review.googlesource.com/c/kernel/common/+/2574178/comm=
ent/f23bbd52_e3b14396/

I think most developers prefer the shorter form here, and I've
seen cleanup patches actually changing the longer version to that.

     Arnd
