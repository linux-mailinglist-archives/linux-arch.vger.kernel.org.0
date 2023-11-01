Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39917DE095
	for <lists+linux-arch@lfdr.de>; Wed,  1 Nov 2023 12:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235276AbjKAL4O (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Nov 2023 07:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235288AbjKAL4N (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Nov 2023 07:56:13 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B7B10F;
        Wed,  1 Nov 2023 04:56:04 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id C74A33200922;
        Wed,  1 Nov 2023 07:56:03 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
  by compute3.internal (MEProxy); Wed, 01 Nov 2023 07:56:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1698839763; x=1698926163; bh=IPh9CsqLU4u3dCRavOB07s+Kjay/eRFWrX3
        L+KjfSiU=; b=Y7z0PKTYBfI6u68m8CQDLFZwHj/6XtUJfZWUYhhuOK+zw1Purk8
        lm2A9wJEjNGZT1faNrWvvr98l86UhDK/LQhvZRfvHMdlNzT5mHKeD9ldKaIPgns2
        yRYLZPde2LQXlZCm/IXTCNWdgstuFXIr+msWhNW7t9G8IlpAVsUz9CxQKppRAoIb
        Xn1ybU4FVBz39SfQnn+p/ukJ7s+nkBqA3vZdY9WTJOLQQ7dI52dTLLucvvMZXEUt
        7q7dcZiSMJTTC6/qbVvtLGgRzSu9i5un1y1cIdjJWpfb3y5Fr4hv9bNLKJLY+sO2
        /q6Me5qNEgEPI34Q75Q9XfForgJAgjbsBwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1698839763; x=1698926163; bh=IPh9CsqLU4u3dCRavOB07s+Kjay/eRFWrX3
        L+KjfSiU=; b=oVhBir7M5Iwo2BKPZCIHt9eANhp3dqvhEP5KIhOh+E5NzHbctiO
        oWEB1OZK3P54rNE6F5SvtFBMOnaPZHRzod076DAgzpybNj98bkO3EB0HZlTrbbuR
        /7aAK4oD0GR5/SaHdD41ddTTrX8X/1TsTkQGRWsBkLmhIDbmdra7kbhEUgeQU2SY
        rJ4BGfnl07xERP5Q8PJTzptp9krw/kSlbsiluwt2w65wszeBMp/D8a/4rXcoEN7D
        MgXytY2torbiswy5tjnHu/ybk+Pdpz4+Qxmfu2sGJmgZ0NeUIuXq8MO03/zQYq8j
        3V7Mrq9HwKoNEGoj6l8ge5qI1K7FHepptTQ==
X-ME-Sender: <xms:0jxCZUhVg2WY2veJq0MurP3HEmtNia_tmadkzHdQPyvqgY0essl1Bg>
    <xme:0jxCZdAb4I17vQdOUg3wNDBiW7F0zT-xzNrNAuHsjQgeOBjgyGrijN0fkmf3oTpG1
    3Pw5PKAHNQIHhbZTpk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtgedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfl
    ihgrgihunhcujggrnhhgfdcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtoh
    hmqeenucggtffrrghtthgvrhhnpedufeegfeetudeghefftdehfefgveffleefgfehhfej
    ueegveethfduuddvieehgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:0jxCZcEPibyMS8E8e8y0YNehMoffJvcWHuGgSaYmr7DLZ6TaDr55VQ>
    <xmx:0jxCZVSHUpNAj0iHbu-cd3d1b3kYzxHsZLXptsOMHCuD234gtG5_8w>
    <xmx:0jxCZRzbbLW_kGOLUaQW6yKj3DCzIewbwq02xbpLIf6GPUJR3BeDYg>
    <xmx:0zxCZc-v9crm1aRjV9HOq2BPLfnjb0N4v0eadH1YvpcQeXstWZMnLA>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 979B036A0075; Wed,  1 Nov 2023 07:56:02 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1048-g9229b632c5-fm-20231019.001-g9229b632
MIME-Version: 1.0
Message-Id: <04275b02-0f04-4aed-9e05-7346daf7f102@app.fastmail.com>
In-Reply-To: <f548e9e7-e499-4e26-87d9-c45ce69236a1@app.fastmail.com>
References: <82076999-9346-473d-8841-1480cd70b527@app.fastmail.com>
 <f548e9e7-e499-4e26-87d9-c45ce69236a1@app.fastmail.com>
Date:   Wed, 01 Nov 2023 11:55:29 +0000
From:   "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To:     "Arnd Bergmann" <arnd@arndb.de>,
        Linux-Arch <linux-arch@vger.kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        "Baoquan He" <bhe@redhat.com>
Subject: Re: Overhead of io{read,write}{8,16,32,64} on x86
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



=E5=9C=A82023=E5=B9=B411=E6=9C=881=E6=97=A5=E5=8D=81=E4=B8=80=E6=9C=88 =E4=
=B8=8A=E5=8D=889:08=EF=BC=8CArnd Bergmann=E5=86=99=E9=81=93=EF=BC=9A
[...]
> My feeling is that converting to ioread/iowrite is generally a win
> for any driver that already needs to support both cases (e.g.
> serial-8250) since this can unify the two code paths.
>
> However, for drivers that only support inb()/outb() today, I don't
> see a real benefit in converting them from the traditional methods.

Unfortunately, there are tons of old system trying to mimic PC do
rely on those drivers :-(

I think the universal target is to remove provision of inb()/outb()
family on archs other than x86, and perhaps remove PCI_IOBASE
as well because we can manage io regions with ioremap afterwards.

Besides PnP system may need an overhaul to handle enablement of
ISA device, presumably the ability of receiving information from
OF and platform code can be helpful.

> Another question is whether we actually want to keep the ISA-only
> drivers around. Usually once you look closely, any particular
> ISA driver tends to be entirely unused already and can be removed,
> aside from a few known devices that are either soldered-down on
> motherboards or that have an LPC variant using the same ISA driver.

Well for MIPS Alpha PPC m68k I guess that's worth it. Those systems
tends to have random hardware pieces from PC, including ISA EISA slots.

Thanks.

>
>      Arnd

--=20
- Jiaxun
