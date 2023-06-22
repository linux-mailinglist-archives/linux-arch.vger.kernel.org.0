Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB0DF73A45C
	for <lists+linux-arch@lfdr.de>; Thu, 22 Jun 2023 17:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjFVPKD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Jun 2023 11:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbjFVPKB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Jun 2023 11:10:01 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A280A2;
        Thu, 22 Jun 2023 08:10:00 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 7B1773200258;
        Thu, 22 Jun 2023 11:09:56 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 22 Jun 2023 11:09:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1687446596; x=1687532996; bh=UF
        Ik7GqKMTQQbMewPZ3JZd1cKUV2IvhZU7QLYY4nLQk=; b=VqXzuiAnU40BIyTBrS
        9/SRN8hrv7scO6zI3Wgs3SMHosS7t3TIJr1SBen8U4HVEj75R1HMftaR11UagFuI
        dQDwOO6WznyWPpjHfiZA/qhgUCvAGQy5BbZaxLT8/yzptS5v9ubV79kwpAGGxQuM
        DE1SwgGx2/ZH4LHcTmR8+ATYG4+1ChyqonunUcwENZ8WIemWrIms+PVug0q2eEMY
        TSR/0Lv+VsDmf75Ax2ZUYJHD9iEFh1NOs/D996wZlKS3iocCzmdyaCf0ugaZ8754
        mkrP5Erd8AZHVvjwPj+SwlMzINCbTf+N7Ax13yVW7pywBRzZV7toq41p/Zg6HRml
        8+aA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687446596; x=1687532996; bh=UFIk7GqKMTQQb
        MewPZ3JZd1cKUV2IvhZU7QLYY4nLQk=; b=GDkxVJy0ljSrkyo6YnDKY4pFJLdfF
        2IiwBq716JjjpA1//mgjXXP5rcXOZixDJgoknebyqw1EqT2D2QU8dP8YL2NcTi1O
        IcPYk8faxiG7shlcm1dGUo/6sDJPCw3Xx0CSF1UrFWPh0CpWGKFhWKa1eSkHxUvZ
        hQKxsPVNrue7m49ASD49SHR8b6Ycrxepba23aSdmT5JPYAnwwLCp85qf4tpFV9QC
        s7uZrWeg6Rcr0aeiWooXqJ01AnWywTF72j+hj2YO3Lel+WKAuW51T7GBsJGC4tEX
        zBWePkKQBus17YZIOFzKmp68jsxY9m/bGzWsIxe3JfxKnYUSnioOb56VA==
X-ME-Sender: <xms:QmSUZLkPh6E0UqDs8VS6ZyRN4qZgBuUFafXc6Are0ycgDlrH6NDVqg>
    <xme:QmSUZO0DJFPef8z4dg0gEklyqcQOteSgU8sjn_ihzdZQGYc5BSSDYBjdql0sceTKV
    t-Mz_Lh8TLjXlZnyUY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeeguddgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:QmSUZBryuN3fCOL33LL87iiMJqMuPdQ374jsU4AyA3x_IUnaAeTNqw>
    <xmx:QmSUZDndHZJxE8ISniqoZMrjyBRb3ilM9dINXYaxUJ00LFwhgi62PA>
    <xmx:QmSUZJ0rSKbadaLwaeA2sIbRM2gI4zZSyduBaxYgvlWuucs5KccdXw>
    <xmx:RGSUZGlj-v19qlVP4kskwEzbSFARUROY_1DQ0zqqUTkr7VMXuaT54Q>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7DFC4B60089; Thu, 22 Jun 2023 11:09:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-499-gf27bbf33e2-fm-20230619.001-gf27bbf33
Mime-Version: 1.0
Message-Id: <1412dbaf-56f4-418b-85ea-681b1c44cc26@app.fastmail.com>
In-Reply-To: <1687443219-11946-1-git-send-email-yangtiezhu@loongson.cn>
References: <1687443219-11946-1-git-send-email-yangtiezhu@loongson.cn>
Date:   Thu, 22 Jun 2023 17:09:34 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Tiezhu Yang" <yangtiezhu@loongson.cn>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, loongarch@lists.linux.dev,
        Linux-Arch <linux-arch@vger.kernel.org>, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v3 0/2] Unify uapi bitsperlong.h
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 22, 2023, at 16:13, Tiezhu Yang wrote:
> v3:
>   -- Check the definition of __BITS_PER_LONG first at
>      the beginning of uapi/asm-generic/bitsperlong.h
>
> v2:
>   -- Check __CHAR_BIT__ and __SIZEOF_LONG__ rather than
>      __aarch64__, __riscv, __loongarch__, thanks Ruoyao
>   -- Update the code comment and commit message
>
> v1:
>   -- Rebase on 6.4-rc6
>   -- Only unify uapi bitsperlong.h for arm64, riscv and loongarch
>   -- Remove uapi bitsperlong.h of hexagon and microblaze in a new patch
>
> Here is the RFC patch:
> https://lore.kernel.org/linux-arch/1683615903-10862-1-git-send-email-yangtiezhu@loongson.cn/

I've applied these to the asm-generic tree now

Thanks,

   Arnd
