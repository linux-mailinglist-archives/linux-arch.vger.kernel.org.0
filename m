Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99CCC5F30AC
	for <lists+linux-arch@lfdr.de>; Mon,  3 Oct 2022 15:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbiJCNFH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Oct 2022 09:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiJCNFE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Oct 2022 09:05:04 -0400
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0F21C118;
        Mon,  3 Oct 2022 06:05:02 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 1F38E58039C;
        Mon,  3 Oct 2022 09:05:02 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Mon, 03 Oct 2022 09:05:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1664802302; x=1664805902; bh=IxedUfhaz4
        AE03vRli7rrJA0oAe3quAOi2FtrsBi/Mc=; b=r9Jdkr/Gr2Kj90IOTigFzOwng6
        fKoFfmdStbz0Wp11GyjQWUrFGqRFUF2hc3m6LeIgE1nJ28dtffrjUZPy50SEFPJu
        no9TYq7W/qbO+PndUGrUGzvMI0vnywcWV9xpQel8FMq+GdkBXl8x3uWOBfLyeUiK
        zOHrhCE/LVAiIOVaVOfO83wWrl54GvkAcEHfIfC0bN5CUgJ4YPp5TY70/6oUni2p
        upUsf9URei5ajXHxw1ZzXHSX9RH+oeQJwKdc9814sbN78a1ikDIoj4b7qNYS+Aki
        LuLTmR0KbEKC8sHPADPhOGZwRpITScr/9SuPLWoWOMDCAwhaW/YoYC5HDPZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1664802302; x=1664805902; bh=IxedUfhaz4AE03vRli7rrJA0oAe3
        quAOi2FtrsBi/Mc=; b=bdjKk2+P6AyfC5zmWszJzPY3kYCbXYq+dq9qC44CR7Dh
        TunlFhpT1JSgYutT3fvqpXpuIDV3L7aggs3H5/VoBE7gdveGxzz+NWjGmTCrx7nR
        3AzAbzPv5cZpGUA4Ch44Vma+wR66Bd6uRNztEpxEepP7HwIDXQiVplZc3LxQoQ6z
        VTVy0wNEF0kIb6CG2Jjh0vIDfIDCvcZD4dh0KSCn87LiGVi8FwFjW9SZiOOfvYUj
        pv1PktfE6zU6v2jCn0X+tcOi0oB18vrTPgoZPs7zskjHtF7+K45jtIN8PgU114c0
        8ZY6peAZ/HI/ZHlDQpmom8QXSXu2qQp3KxETPg8gWg==
X-ME-Sender: <xms:_d06Yyqx44g5Wud1elRXmydShFsXMQv-xDC_wrJaCVxG9gUgeoMsOQ>
    <xme:_d06YwpHzODswsUNU6SOYMrJe6JMLhfMMU6TTVeJTI5trV-vHC6HJcO2niKOxRS4D
    MUXWYZ_0h6d3lxd77A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeehledgheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dunecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:_d06Y3OTZV_JCSA-2_J2DkPIKUAPX2JATms9h0yEg67mMQH4NALJUg>
    <xmx:_d06Yx6GoM3bi4sikSZHc-SjDLn8zGYt_lfDAS3lEq0Y2U-pIwhvJg>
    <xmx:_d06Yx7Tw6mldFFAAh1xk451brCfwEHMjWvUm6qroQdGRt6TiWjNjA>
    <xmx:_d06Y00YaQs6F9QVDYJR-cW5os7IjmHB5anBTBOTEz4Wj3xlESIcOg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4E90DB60089; Mon,  3 Oct 2022 09:05:01 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-968-g04df58079d-fm-20220921.001-g04df5807
Mime-Version: 1.0
Message-Id: <49e40308-969f-4b22-a8b5-d7f07e50b8ef@app.fastmail.com>
In-Reply-To: <20221003121316.2540339-1-linus.walleij@linaro.org>
References: <20221003121316.2540339-1-linus.walleij@linaro.org>
Date:   Mon, 03 Oct 2022 15:04:41 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Walleij" <linus.walleij@linaro.org>,
        "Richard Henderson" <richard.henderson@linaro.org>,
        "Ivan Kokshaysky" <ink@jurassic.park.msu.ru>,
        "Matt Turner" <mattst88@gmail.com>
Cc:     linux-alpha@vger.kernel.org, "Guenter Roeck" <linux@roeck-us.net>,
        Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] alpha: Fix ioread64/iowrite64 helpers
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

On Mon, Oct 3, 2022, at 2:13 PM, Linus Walleij wrote:
> When doing allmod builds it turns out some modules are using
> ioread64() and iowrite64() that the alpha does not implement,
> as it is using <asm-generic/iomap.h> without selecting
> GENERIC_IOMAP.
>
> Fix this by implementing the ioread64()/iowrite64() stubs
> as well, using readq() and writeq() respectively.
>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Fixes: 7e772dad9913 ("alpha: Use generic <asm-generic/io.h>")
> Link: https://lore.kernel.org/linux-arch/20221002224521.GA968453@roeck-us.net/
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> Cc: Matt Turner <mattst88@gmail.com>
> Cc: linux-arch@vger.kernel.org
> Cc: linux-alpha@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Arnd if this looks OK then please apply it on linux-arch
> for fixes.
> --

It looks like we just crossed patches. I also sent a fix a minute
ago, but I think mine is better here because it also works on
I/O ports.

     Arnd
