Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9AB779E8D
	for <lists+linux-arch@lfdr.de>; Sat, 12 Aug 2023 11:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236266AbjHLJ3O (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 12 Aug 2023 05:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbjHLJ3N (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 12 Aug 2023 05:29:13 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D233DA;
        Sat, 12 Aug 2023 02:29:16 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id D61135C00D7;
        Sat, 12 Aug 2023 05:29:13 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Sat, 12 Aug 2023 05:29:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1691832553; x=1691918953; bh=ycCh0iRFEDX650t2q02zbosoMHwrgpHymlC
        M61ZT6eQ=; b=Ixm/SqIUOckP/MxJJGfoqvNc+XcPAmKsv48ABv5RshTYQ23HkfE
        Y8N95y1f2774roeBDPb7JmQvsdNZgk6OheIVPpi9dc2NXu7/Da5w7lFRmXK9EjpK
        7qvGUqcMw/K7NY7a53f7WJVvk/4hBed9plRmUfA4K7jUTcUhUvlE9VhGDbgq/Auq
        5MhRPfx3dB1LQwEjpG4XPCkDr24OWPvgmyVKpRzQEDBP1Zg7HcIX5ggnP1Mk2zGj
        8H0PsoIcRXA0vwO/TdQnlSd4YOpUUkekVZqGlx7S8jgKHHriVX26FRO2taCpnDOu
        tQt9eLZdlseaz2WEOSMdCTtraHwgznYRrxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1691832553; x=1691918953; bh=ycCh0iRFEDX650t2q02zbosoMHwrgpHymlC
        M61ZT6eQ=; b=hHCRU9i6T4vg06KHMwPR74hLYeYBlL7+aZHkKcm5+4WqmoA6Cam
        fzzPTZckcs8IumnH5j46kpwpaSY/kWuFyMx7fRJTzKWzhSnpFLe336wDkG6t2stU
        PixVUAioMqrDrTlfAHxk6iODmq7RVGj6aTSJl4TFla+sG/N1rZRh3JY3GkfBXNBL
        6EOaVsVql8WPIY+9QmsQt1EemWRudJ66KJuE56YcViaIw9O7GzOlSMhQPiskpgr7
        GlN5BEZLGRwIA4fn4zhgt4PevQut7IQLulBUSksM9TNqQ0uVlmOjKS8rrWjOMOzF
        5hCErpTFgPKM0FnH+3a/tu58dLHxz3CDXPA==
X-ME-Sender: <xms:6FDXZJJzkuxGXtCTh7MvqRlKbPMQ2wbF_sPoV3SMtSBtrjbYdgBMvQ>
    <xme:6FDXZFJ9vrwKnDejiOjVrikXOsGxq96alqgAx2bvlP_phUBMoHEtQqUX39y7xawBf
    Y7N_tooTeILqmiWVcY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddttddgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:6FDXZBtgqxyY8c9ZcGBq-ZZxvDa1SytbixWrjUlIxa5b_ZbrOyqeTA>
    <xmx:6FDXZKaZF3X5DSyl24w_LNOVwa6JK0O0Z-6ZB-LRP1bewXNBhNUJUQ>
    <xmx:6FDXZAZUY-QQEvHX-jeiXLuqIiR2PO8ssZK0cML_nTGCULUGbBSLIQ>
    <xmx:6VDXZA4A6uQ3Rd-5A73JjMw9hzy6TZ58R4pvPOt4q-VlX5LAiYKndg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3A579B60089; Sat, 12 Aug 2023 05:29:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-624-g7714e4406d-fm-20230801.001-g7714e440
Mime-Version: 1.0
Message-Id: <6574626d-3853-4ef5-a481-5c03894e4ba2@app.fastmail.com>
In-Reply-To: <CAK7LNAT0BZ107ngRNQvVO4DjOKj8AOrD2860rOgQ84WP9QfaFw@mail.gmail.com>
References: <20230811140327.3754597-1-arnd@kernel.org>
 <20230811140327.3754597-4-arnd@kernel.org>
 <CAK7LNAT0BZ107ngRNQvVO4DjOKj8AOrD2860rOgQ84WP9QfaFw@mail.gmail.com>
Date:   Sat, 12 Aug 2023 11:28:51 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Masahiro Yamada" <masahiroy@kernel.org>,
        "Arnd Bergmann" <arnd@kernel.org>
Cc:     "Nathan Chancellor" <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "Nicolas Schier" <nicolas@fjasle.eu>,
        "Guenter Roeck" <linux@roeck-us.net>, "Lee Jones" <lee@kernel.org>,
        "Stephen Rothwell" <sfr@canb.auug.org.au>,
        linux-kbuild@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH 3/9] Kbuild: avoid duplicate warning options
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Aug 12, 2023, at 11:21, Masahiro Yamada wrote:
> On Sat, Aug 12, 2023 at 5:50=E2=80=AFPM Arnd Bergmann <arnd@kernel.org=
> wrote:
>
> GCC manual says -Wall implies -Wmaybe-uninitialized.
>
> If you move -Wno-maybe-uninitialize to the "W !=3D 2" part,
> -Wmaybe-uninitialized is unneeded in the 'W =3D=3D 2" part.
>
> Maybe, the same applies to -Wunused-but-set-parameter.
>
> Shall we drop warnings implied by another, or
> is it clearer to explicitly add either -Wfoo or -Wno-foo?
>
> If desired, we can do such a clean-up later, though.

Right, we can probably drop that, I've gone back and forth
on this how to handle these. Some of the warnings are
handled differently between gcc and clang, or differently
between compiler versions, where they are sometimes
implied and sometimes need to be specified explicitly.

What I've tried to do here is to do the change in the least
invasive way to ensure that this larger patch does not
change the behavior. My preference would be for you
to merge it like this unless you see a bug, and then
do another cleanup pass where we remove the ones implied
by either -Wall or -Wextra on all known versions.

I'll be on vacation the next few weeks starting on
Tuesday and will be able to reply to emails, but won't
have a chance to sufficiently test any significant
reworks of my series before the merge window.

    Arnd
