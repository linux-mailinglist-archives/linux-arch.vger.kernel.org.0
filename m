Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26ADA78A1D2
	for <lists+linux-arch@lfdr.de>; Sun, 27 Aug 2023 23:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjH0V20 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 27 Aug 2023 17:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjH0V16 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 27 Aug 2023 17:27:58 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E714DEB;
        Sun, 27 Aug 2023 14:27:55 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 943725C00FE;
        Sun, 27 Aug 2023 17:27:52 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Sun, 27 Aug 2023 17:27:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1693171672; x=1693258072; bh=+t
        9yubBgGX1nrGznKy2YZXP7qckFjHgJxHS467gzkCU=; b=VJr6aiNOh3fxdk6/4K
        cNQIU4uiaiI5v+WwX/Evg+ExqsOanUWE0FT/CUPolosfzPBPOhGzPab59PcD2e2p
        4+syTvZZ7zt8jnhikD0kdcX2x54mABSOj9gJfO+EHHfCep/WMcub82QoOFO9AGj0
        /CFWnkX21e+8tT8cP6XnwR0xgGDAy6j7t0VJluqfRhCbfinI2PJkCuxxJ+OzV/R7
        gbC6u1mjE1GlYSJqrwNGVtwJUDPIniHU50RQC63uUH+h/18Ugm4/+4ib5cRq8sIJ
        FdSIa9e0h8WJfyVpv8FLuS0J9BN92uRPAFcZ2T+8t5BezzFrtBuXCbW31/FH17U4
        lw7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1693171672; x=1693258072; bh=+t9yubBgGX1nr
        GznKy2YZXP7qckFjHgJxHS467gzkCU=; b=Z2qURXB+cZXpH7p0CPyuer+su15RS
        1vGsHq0WgvYxw41TkkSsrfXkgOHgUKys2pCEbahHajo60g5yE+NHW8MAVYs62bUP
        McLCGwoRioTkJWRDcbbHfBT2R35NYCRmgrYrkobOq0Byb3WzZ58MjiVCLnuV/ho/
        fbNZWXcR5NEu1cFldNtyUnGM1RUfP3LGzFsrMfDxohgVN5eT6EUtYPPIUqUcDnTW
        c3SFZQniVgxQ0okfk8bjEnw77Fuw6g2vWQtinaCseY0oG0Q8ArCM9p8MbtwkHkWB
        dlyoMu9zYD0UKPC8V+/Hp8Wk4Wx313xatB887VmxQ1aywdc8OgAFRHrOQ==
X-ME-Sender: <xms:17_rZBDLgwunWGJubX1ftHGXNvji95zw-obisd5seOrplDSOBHwMnQ>
    <xme:17_rZPjxQ6r7mINGHweNS7v6mBdTe7BxotYoaNB8oUiRO2taYztmfYQMLjPjxyHjd
    4fmiujT097Gh7jK-C0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudefvddgudeivdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:2L_rZMkuU6Kp1Ok5_hlGjFvdOAu7O6IjCm7mPWdy5_P_wNEc0jqw-A>
    <xmx:2L_rZLztoo23ycwgLO_vi5wCZFUQ9bAs47FGJeDzyEV95Hy6ZxogHA>
    <xmx:2L_rZGTliR0uuY1q9XAZGzIc96hs-tGRtPwX2ppMJMbf7Crg6kKINA>
    <xmx:2L_rZEdcP_B0q1oSlWOl3mzyZS2xGeMLoqn3-74SdE-laVTt0kuYTw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id DB0B1B60089; Sun, 27 Aug 2023 17:27:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-647-g545049cfe6-fm-20230814.001-g545049cf
Mime-Version: 1.0
Message-Id: <9f7799cc-4b9e-4da9-8cd3-e2258a597089@app.fastmail.com>
In-Reply-To: <20230824040329.132810-1-jiaxun.yang@flygoat.com>
References: <20230824040329.132810-1-jiaxun.yang@flygoat.com>
Date:   Sun, 27 Aug 2023 17:27:31 -0400
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Jiaxun Yang" <jiaxun.yang@flygoat.com>, linux-mips@vger.kernel.org
Cc:     "Baoquan He" <bhe@redhat.com>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        "Huacai Chen" <chenhuacai@kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v5] mips: add <asm-generic/io.h> including
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

On Thu, Aug 24, 2023, at 00:03, Jiaxun Yang wrote:
> With the adding, some default ioremap_xx methods defined in
> asm-generic/io.h can be used. E.g the default ioremap_uc() returning
> NULL.
>
> We also massaged various headers to avoid nested includes.
>
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> [jiaxun.yang@flygoat.com: Massage more headers, fix ioport defines]
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Huacai Chen <chenhuacai@kernel.org>
> Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-mips@vger.kernel.org
> Cc: linux-arch@vger.kernel.org

I'm not able to do any testing at the moment, but this all looks
good to me,

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
