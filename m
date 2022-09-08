Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F655B214C
	for <lists+linux-arch@lfdr.de>; Thu,  8 Sep 2022 16:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbiIHOxR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Sep 2022 10:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232385AbiIHOxN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Sep 2022 10:53:13 -0400
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E0A11C16F;
        Thu,  8 Sep 2022 07:53:06 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 939C0580AEF;
        Thu,  8 Sep 2022 10:53:05 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Thu, 08 Sep 2022 10:53:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1662648785; x=1662652385; bh=kS0JpLcQIj
        ApaQj6/G8PpIMa+Bvf17l4VEilnzuZytk=; b=FGnLltUvdfBYpJDr5Uvp6kDZJ6
        WFoYLQXjcYRVAX/qmhJKfVdhksV4sh2PZuXs560JSWPighI/y9YTPb08H/xZ/hlL
        uV4SneEx+HjtV6bKY5XQl3faYtXdkIXB0zJaQQ4LbriXqS7usT5YwUGrgp5Ln2ax
        QesROQ/JDS2Gn5AsJ+cFFMBpKVTG9JGVDamYpUMHj1i0O6cnZTLJgQ2WXaQj2vQq
        JD+MYZIkvYGXZIDUnPg67vPBGgmxnqrGC3pLRz8M5gH6RjXLfJqGSPuwhBq6psge
        nfbQO1iGR+2/YFoQvUJ/7GviFGNVaG/1pHaG+IwcRd74ZqHc3ahgosvBxT6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1662648785; x=1662652385; bh=kS0JpLcQIjApaQj6/G8PpIMa+Bvf
        17l4VEilnzuZytk=; b=pYC6sf+zD9VOpzCRSngPA5GkUOOAi5c1aLixA22nSSop
        4Z62vUmL/h5l2lbpQPocUdwr6yaxYQLZ9Sn+sB0cl4iZEjQ+nUeoy0lsEGOmi+5H
        sYEMQJJpwHgmia2XwYutWSmDZjqz+7/CRzw4PaCW0UY9/MiebiQne+B5sAFOTRdJ
        FTpGAQCbU5WQMvmbCdo+ja81QslIibF1ZeIDSor6KBy9NirrMQaGvZ/pRKgv0HgE
        vfNmC17f6sbaXKVGsTeqL3harDUe96S1GL/WX9ei82T+XFDhUvYqj1nyJaP9bDxx
        hLesLBfjnhQtG7f1QjFeS36AKGFbj24My8QhFWforQ==
X-ME-Sender: <xms:0AEaY6vD8MqMTNx44UbYOr9Z8Ybn0IPeVanKBLgzy_Do-Q8e0RKWzA>
    <xme:0AEaY_cN6asRvWlW9bkhPpZgmbmdDAYlRSeY5UkpE5-ZEjlty3CZf3fLIZ-v9th1n
    NpwjfwBWDR-gAauxmc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedtfedgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dunecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:0AEaY1w02521UAk5l3m4BPPMJmRdf9jYm9-naBh2qU87CmhOGtvbew>
    <xmx:0AEaY1NfE3lnVZVFpHkhK9dsVHpXcj-hagJgjPudoDkB5Yia0HvooA>
    <xmx:0AEaY6_sqws4gn-PjBkKIEx_6Gf3V45mAlxc8k-EgOsUUluOWXIufw>
    <xmx:0QEaYxkg6OU46eW4UfPa3DBsG9Ami96UjpS99ZSSGwis0x3ERks17w>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 94CC9B60083; Thu,  8 Sep 2022 10:53:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-927-gf4c98c8499-fm-20220826.002-gf4c98c84
Mime-Version: 1.0
Message-Id: <67ecb725-2e2d-4aae-8c99-76fad5875080@www.fastmail.com>
In-Reply-To: <20220906185939.765081-1-linus.walleij@linaro.org>
References: <20220906185939.765081-1-linus.walleij@linaro.org>
Date:   Thu, 08 Sep 2022 16:52:42 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Walleij" <linus.walleij@linaro.org>,
        "Richard Henderson" <richard.henderson@linaro.org>,
        "Ivan Kokshaysky" <ink@jurassic.park.msu.ru>,
        "Matt Turner" <mattst88@gmail.com>
Cc:     linux-alpha@vger.kernel.org, "kernel test robot" <lkp@intel.com>,
        "Mark Brown" <broonie@kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v2] alpha: Use generic <asm-generic/io.h>
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

On Tue, Sep 6, 2022, at 8:59 PM, Linus Walleij wrote:
> This enables the alpha to use <asm-generic/io.h> to fill in the
> missing (undefined) I/O accessor functions.
>
> This is needed if Alpha ever wants to uses CONFIG_REGMAP_MMIO
> which has been patches to use accelerated _noinc accessors
> such as readsq/writesq that Alpha, while being a 64bit platform,
> as of now not yet provide. readq/writeq is however provided
> so the machine can do 64bit I/O.
>
> This comes with the requirement that everything the architecture
> already provides needs to be defined, rather than just being,
> say, static inline functions.
>
> Bite the bullet and just provide the definitions and make it work.
>
> Some defines need to be piled right before the inclusion of
> <asm-generic/io.h> due to the fact that alpha is including
> <asm-generic/iomap.h> without selecting GENERIC_IOMAP.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/linux-mm/202208181447.G9FLcMkI-lkp@intel.com/
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> Cc: Matt Turner <mattst88@gmail.com>
> Cc: linux-arch@vger.kernel.org
> Cc: linux-alpha@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Applied to asm-generic tree, thanks

     Arnd
