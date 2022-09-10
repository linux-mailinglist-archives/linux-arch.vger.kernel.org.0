Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54B15B4513
	for <lists+linux-arch@lfdr.de>; Sat, 10 Sep 2022 09:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbiIJH6V (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 10 Sep 2022 03:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiIJH6U (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 10 Sep 2022 03:58:20 -0400
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53D619C0F;
        Sat, 10 Sep 2022 00:58:19 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id E69232B059A0;
        Sat, 10 Sep 2022 03:58:16 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Sat, 10 Sep 2022 03:58:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1662796696; x=1662800296; bh=HOcWEnyAB3
        sxWhsLzyvpOUY/Xf1a2nEZgigunXrDFMc=; b=BR73Y4i2K1cFuFy1AsJ4QYzjPX
        DSt8Roo8dYYBh82lBvn4mBuQWxqI0dC86bzjDHc6c8ZJGEvh762k6IYYyPcul2Yt
        0aTvkBQS/CqDc/SMiJgGBt5K2SmFiie8bBsbacIna8Su07ZtitcH2L42KGTDE5Vq
        9R2cxHubNqiUObiBpHGE7TrOoxpakJy6Nj0njKagrdxhur0oSEjjj7i1KxXtanxT
        xsiQkgJ5VNn0f2gAEICYFubRJTtDPFIAabxyAzGyt5GpODuMpWYyo+7OO3+VgSbe
        t8Oh1JgZ/d8T1KJVyekgUNEgLktIEK9q/cBG1pqP6aYJzfDXHK7AK3ym3Ivw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1662796696; x=1662800296; bh=HOcWEnyAB3sxWhsLzyvpOUY/Xf1a
        2nEZgigunXrDFMc=; b=Fylt1uHP9KG6Qb28QHXcpJr00/JBNyS6QtIpWYRYYAUT
        /jAENmIDONNg1izwNvtQMlYDRTbVOipRcyyzJKl2H9M85bu7Xvj1EP9pPtXgqqPT
        Frsf1FkOXvceVrjbf+0xRKw+hHcOIytkWqROUMyqqP7hq88QmfjdWmjO9rSzVP45
        +qTm9mBPkL71V+fKl4YIA5md9o+jr8/kRuzmbgkE60wq6FIJrAER9M2IYbJCTjQ6
        X0Kjm0fqApoSsrgyBybn7r11qVNvga2zb4fGChQMVgLzK/KC60eqG49RPYhSNqm9
        OojvBG2lby4p/oZXLfHRg/ixaEdobnPPy/mnJx4DAA==
X-ME-Sender: <xms:l0McY8gfHW0t9UhS-hTT-rNRaTEHWTix-WAVdSyFjFolRopwHGfrig>
    <xme:l0McY1BUSqTFxhOcEh3Vf6_BrCLOSVrVN1DhBQ01t8SDsLbFvv_I1_VOemMVImeP5
    U7EkbJ0W0wjyhd8jqU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedtiedguddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:l0McY0EehsynkzeOkV0THDsig-IapNTIwN_g9imtM6FWHtBCcl0vrw>
    <xmx:l0McY9SzGBsRqTKwBYypkN5N34gLms6n3KPk_pec-GOJ0IFiwfklTg>
    <xmx:l0McY5zNyJbw7kDF5Ngs42EEc6Z1IG-DEHyxjzH_-siVnhAx3_Pybw>
    <xmx:mEMcYx-vn76kmnuYa0T5RBRkHesrWiG797WyFigsWUb0vKksEP9HOm84i7c>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7E96DB60086; Sat, 10 Sep 2022 03:58:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-927-gf4c98c8499-fm-20220826.002-gf4c98c84
Mime-Version: 1.0
Message-Id: <44767c34-f2e9-491b-995a-249484ecc6b7@www.fastmail.com>
In-Reply-To: <CACRpkdaV0CQGeLgqCCw6gEY4yBHEe0uS3eE5hkf-OJOBxQynYQ@mail.gmail.com>
References: <20220903224526.553897-1-linus.walleij@linaro.org>
 <eded16ee-b9c9-4830-a75c-685056e56b56@www.fastmail.com>
 <CACRpkdaV0CQGeLgqCCw6gEY4yBHEe0uS3eE5hkf-OJOBxQynYQ@mail.gmail.com>
Date:   Sat, 10 Sep 2022 09:57:54 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Walleij" <linus.walleij@linaro.org>
Cc:     "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        "Helge Deller" <deller@gmx.de>, linux-parisc@vger.kernel.org,
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

On Sat, Sep 10, 2022, at 12:37 AM, Linus Walleij wrote:
> On Sun, Sep 4, 2022 at 10:11 AM Arnd Bergmann <arnd@arndb.de> wrote:
>> On Sun, Sep 4, 2022, at 12:45 AM, Linus Walleij wrote:
>>
>> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
>
> Thanks Arnd,
>
> it seems quiet around parisc, maybe you could apply these two to
> the arch tree as well?

Done. I had meant to do this when I applied the ia64 and alpha
bits but somehow forgot.

      Arnd
