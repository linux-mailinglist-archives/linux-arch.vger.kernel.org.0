Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 597DC662440
	for <lists+linux-arch@lfdr.de>; Mon,  9 Jan 2023 12:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234675AbjAILeB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 Jan 2023 06:34:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234890AbjAILd6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Jan 2023 06:33:58 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C48818E38;
        Mon,  9 Jan 2023 03:33:53 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id DE6785C0072;
        Mon,  9 Jan 2023 06:33:50 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 09 Jan 2023 06:33:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1673264030; x=1673350430; bh=gBn/439VzV
        QtPbgVACzNbdN6KJ6qdM4clDp7wD6tlpo=; b=SKPGFq65Y2rkOjEjygDNvI5pOC
        5U8DYdTD9QwIap3B78QQ1obXcLFdql2v38YSD/vnfpQlVVgGKrAIb3NUpUNPIXiY
        3mRnl8CEpjNJ/qAY/KSDv0bOhX6fWk5KG7t7zQDGDthx6XFEjqD1y1U0/xyEZgK8
        jJSq8sQPuqc6CFg2vMfuHvpSd/70cjHiYFVyNOKBl1XT9zF7/qkO+MyeYRdjtfgo
        ksMfH6C98E74YRhzmlMizTSb09gCebZH1cP8py6RC1KvWLaC2iR33tvrYfrQPayg
        9q2YgHqMESDEYF68hlxfIeVxdaOfjIzsRsBnhF9aV96vIMw5S5dvU/S4LBAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1673264030; x=1673350430; bh=gBn/439VzVQtPbgVACzNbdN6KJ6q
        dM4clDp7wD6tlpo=; b=TnQ9Aq1nCXtRLCjbzDMVqOOElzXXPyMIGfphAMEgCGyV
        anqu7vcu2giD7ydGbk5Ag0s1YOJaUuPGu8jNXytgEre/LRQSNVvKHVUUW8VIaZnx
        6gB3b4bLWIaP78ISfRHa9w2a36yR3X8sET7kHTGvANEwKlucjD0RegPTXv1+F0B7
        zunZ4WXGp0D9bmUh+W/IcVt06Dg3rIKhHi57qc44yowtk7wz1GLpxFA+cxJSXRDN
        WRlS9latr1Lx5noT9fjcO2ckgSZKNgfvIaKcyR1JrnVqRLB7JZDdH+M6AffFLmiC
        ffKCJQ6r++LBNNKL59VixCUx+dkhHDfnOigh5sMT5g==
X-ME-Sender: <xms:nvu7Y76sC9lRW2FazJO6zT07VVBbSybyword4yPw6tyD2-buk-GOAg>
    <xme:nvu7Yw5dSTIvvRqP2aPNEMVSTlxxucsNcWuCIde0H-ghzlw8wKDvRMMSZf10HuTuk
    T7N3Qlu1Oa1cMRyaDI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrkeeigddvgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:nvu7YyeLHzf28B5dzYZBQJXLf2tnZv7YN-1zIDhTyIssnaz9x9pXRA>
    <xmx:nvu7Y8K1Si4h71Jn8WavwGcXc8HVG6Z1jd2qUESQtt5XkFJkIylntQ>
    <xmx:nvu7Y_JzN9zCtr_apchVAgodjkmIQgAPDQF0Q7bYKm_MqJEZBt48IQ>
    <xmx:nvu7YxxGbjBCWz6neAI8CikzA710RcYJHIDlgLlxYsp0ABz6w2tqxA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B318BB60086; Mon,  9 Jan 2023 06:33:50 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <9105d6fc-880b-4734-857d-e3d30b87ccf6@app.fastmail.com>
In-Reply-To: <20230109104054.gabdvjxyawdfbqii@skbuf>
References: <20230109104054.gabdvjxyawdfbqii@skbuf>
Date:   Mon, 09 Jan 2023 12:33:31 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Vladimir Oltean" <vladimir.oltean@nxp.com>
Cc:     Linux-Arch <linux-arch@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Sparse warning when using ioread64() from include/asm-generic/io.h
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jan 9, 2023, at 11:40, Vladimir Oltean wrote:
> Hi,
>
> I would like to get rid of the following sparse error in the enetc
> driver (for arm64), which uses ioread64().
>
> ../drivers/net/ethernet/freescale/enetc/enetc_ethtool.c: note: in included file
> 	(through ../arch/arm64/include/asm/io.h, ../include/linux/io.h,
> 	../include/linux/irq.h, ../include/asm-generic/hardirq.h,
> 	../arch/arm64/include/asm/hardirq.h, ...):
> ../include/asm-generic/io.h:239:15: warning: cast to restricted __le64
>
> The trouble is I don't understand why the casts to __le64 and use of
> __le64_to_cpu() are even needed, when everything seems to be native
> endianness. I've seen commit c1d55d50139b ("asm-generic/io.h: Fix sparse
> warnings on big-endian architectures"), but that doesn't claim to fix
> anything for little endian (and doesn't touch the 64 accessors, for some
> reason).
>
> Could you please help?

From what I can tell, the fix for openrisc was described as
a big-endian warning fix, but the warning is actually the same
on both. The difference is that on little-endian kernels,
the __le64_to_cpu() conversion only changes the type but not
the value, while on big-endian machines, the value would
be wrong without the conversion: __raw_readl() is defined
to never byteswap the data, while readl() must byteswap
little-endian MMIO registers into big-endian CPU registers
when CONFIG_CPU_BIG_ENDIAN is set.

Since Stafford only tested on 32-bit OpenRISC, he missed the
readq()/writeq() accessors that need the same warning fix.

     Arnd
