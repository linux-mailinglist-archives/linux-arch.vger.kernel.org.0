Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D555AC364
	for <lists+linux-arch@lfdr.de>; Sun,  4 Sep 2022 10:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbiIDILR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 4 Sep 2022 04:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232793AbiIDILQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 4 Sep 2022 04:11:16 -0400
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C9A3ED50;
        Sun,  4 Sep 2022 01:11:12 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 12DCE2B05E77;
        Sun,  4 Sep 2022 04:11:09 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Sun, 04 Sep 2022 04:11:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1662279069; x=1662282669; bh=GmIJUh8a0b
        qNdokPkQCJbK/aqSeG2wVzu5bAlLl44Yg=; b=VDzD4vEe1cQ8Qa+CwfOJLi6Yjf
        0CtxsOaLjvil3Bcmh/97DHGVpIm+SkQBL3X/zZ7R10pDR6kLiMhDb0UmY1oD5pvk
        TP7zSlf6y6p1WQQ3UxTP3Bu74fUen0x/DDvuecbz5YUt0QeitSYxfWVmbJtm70B0
        vCfrqSqaLTPV8bORbkzSoDIVH4Kfs+VUespVAMuEnVR6VBF9al6kh6Kj5saD5F2T
        Eyatx60smtoz+wtA+tCj+MCPuU6KEDpsnoxM+QOe3LCzv1RwbWMCorvMHDKpPrEF
        SuytBNnyEVAuYoui83mzyOc/Du0DOkS+Nz5VSsDkwt7YdGF4oE5MAq2tpp6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        i56a14606.fm1; t=1662279069; x=1662282669; bh=GmIJUh8a0bqNdokPkQ
        CJbK/aqSeG2wVzu5bAlLl44Yg=; b=utGey7os7UJCKWBcQwk4SM5x9OOCiQuJRj
        7nWp3WGGvAXOboRyUluQvWZoUFACDnkV52Dh7CPakiJN4g4OKiPwP7eVP5T96UMi
        OZeDSniSHQpSt9hZrFRYILIWMs7RR68CXoU9b+BkzKC04ZNIezhBlrkbUCbABPj3
        VVdho3b3Zxk2LFyaIDXe2pnXZ2e+eu5pzE+29yXgre2f7qAYATw58oGBetBgxqA2
        okknTzHKmhQMRYbuJJWDuMSVs53ZW1eayI6b2TzdeQv5TUAZdAwcR9u30AtjH7qY
        /RJwkZTSFti15KJjQnIl2AS52r+cI8wPmj6YlC2gvf37g0VYe84Q==
X-ME-Sender: <xms:nV0UY-u2oDOm6AeYCakuLXVtz-EHTAnp6N-8miNW3jow4HoZaKtS7A>
    <xme:nV0UYzcgXxJo2xIudA7dOmLoJjJs0legwLZSUH3eeebRMLET_pbAcEfFCM0Sv1rmz
    hHWts5_9ekP4rlZWGA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdelgedgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:nV0UY5x5hqUBtoPU6MBtv3uZgn23_StmLVUr4UT9WVQBlS0ezgbvZA>
    <xmx:nV0UY5NbN_T5PtU0YQcwJbeIzc5iE1fNboKxDrMMXHwmhf8yu0IfgA>
    <xmx:nV0UY-_Tn9kZR9JgmtNh4cF3iFFEs4kvTLQc8YDMy2Qbk5UO_e3B8w>
    <xmx:nV0UY1ZmzthWojjUxhUrw1f8auXbDw_rSNEq0tdsOkdn_qgUm0MGwONsjlc>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id EA084B60083; Sun,  4 Sep 2022 04:11:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-841-g7899e99a45-fm-20220811.002-g7899e99a
Mime-Version: 1.0
Message-Id: <eded16ee-b9c9-4830-a75c-685056e56b56@www.fastmail.com>
In-Reply-To: <20220903224526.553897-1-linus.walleij@linaro.org>
References: <20220903224526.553897-1-linus.walleij@linaro.org>
Date:   Sun, 04 Sep 2022 10:10:48 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Walleij" <linus.walleij@linaro.org>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Helge Deller" <deller@gmx.de>
Cc:     linux-parisc@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "John David Anglin" <dave.anglin@bell.net>
Subject: Re: [PATCH 1/2 v4] parisc: Remove 64bit access on 32bit machines
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

On Sun, Sep 4, 2022, at 12:45 AM, Linus Walleij wrote:
> The parisc was using some readq/writeq accessors without special
> considerations as to what will happen on 32bit CPUs if you do
> this. Maybe we have been lucky that it "just worked" on 32bit
> due to the compiler behaviour, or the code paths were never
> executed.
>
> Fix the two offending code sites like this:
>
> arch/parisc/lib/iomap.c:
>
> - Put ifdefs around the 64bit accessors and make sure
>   that ioread64, ioread64be, iowrite64 and iowrite64be
>   are not available on 32bit builds.
>
> - Also fold in a bug fix where 64bit access was by
>   mistake using 32bit writel() accessors rather
>   than 64bit writeq().
>
> drivers/parisc/sba_iommu.c:
>
> - Access any 64bit registers using _lo_hi-semantics by way
>   of the readq and writeq operations provided by
>   <linux/io-64-nonatomic-lo-hi.h>
>
> Cc: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: linux-parisc@vger.kernel.org
> Cc: linux-arch@vger.kernel.org
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: John David Anglin <dave.anglin@bell.net>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
