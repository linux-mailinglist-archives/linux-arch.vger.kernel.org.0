Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD113778840
	for <lists+linux-arch@lfdr.de>; Fri, 11 Aug 2023 09:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233918AbjHKHd0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Aug 2023 03:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233911AbjHKHdZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Aug 2023 03:33:25 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F252312B;
        Fri, 11 Aug 2023 00:33:23 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 432595C015E;
        Fri, 11 Aug 2023 03:33:23 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 11 Aug 2023 03:33:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1691739203; x=1691825603; bh=OL
        4AYFZyzV0IyAs6oX+QxBd0gaGJ0aoBa9K2dbekbkY=; b=mogk/r/N8yRt7QB9kN
        nerarNGuigc7ZWP4WZmeGAlA5wFDlMAsJDGjMqb5YqxKKDWpl4gOnGykt6axlq4I
        rhkzi7cnW1p+lCFTmC26NW6GrQ3hMjNdWk34Sy9yFtomKI2DNlZQ3BYcy5+HXj5L
        cBEH4cFxKGfFBf2qpSJ0OcVScCnH4gaEfY196SFNFRI6ChwocNlTf5riKunEOzJZ
        kr8KB84UEgBoD8HFUb7M9iSu+7SX7RdRgM17k4koiKZgZ8pWD1a2D5IwdAKfV9sK
        xmZEgewXUegev+ljO0pFPZ5fSKrCTf8s3WD1yxCvBjURZO+AdKv5Nsy8cVPphRel
        HMsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1691739203; x=1691825603; bh=OL4AYFZyzV0Iy
        As6oX+QxBd0gaGJ0aoBa9K2dbekbkY=; b=knkQ54EKuud/lRkoQfZeo0qWOiFzb
        DI1Ez5BbouSpdayi3z+wmQWR382KJh0saLx9dGNvKgF4nvQ74HH89n9/ZMyECM5l
        Xd6mNnoBTUSI9mYiBhW0AvE9SKT4Reifbp2Acrels/GYSCLOvdgrAKkqVv5T3tBz
        HxOEmc5ST/7/EDzXcyqxsAfHkbpusPG26vULV6zWyIqpnhpw3O+tLzZMYB02C5xn
        AFJPovfLOChpmqJtI9dHFxrLNCLVcUejSuVT+LYkNTbkjhywpwydJwdHXHT4eZCy
        xwthmElWCQbmKkkPFJ7DOZKgEvpsBvD9Lildl4O/cKDzh0QjLREbC4psA==
X-ME-Sender: <xms:QuTVZCaL-odrYsqh-vD3r7e3VV0UiwW3e343fAaLwFypTfA7RsyZRQ>
    <xme:QuTVZFZ_r4FriVU1FuOIdPYWM3VSNtE_GHImJE80CSNygXDMWv8HJIR7SucXD4pai
    HVCKl0dtg6soLr8REk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrleejgdduudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:QuTVZM_TyNIMrrrfOZ3Ff2Apa4MR7CXxe9jGzA0mW3DtQ6uJi0n5tA>
    <xmx:QuTVZEqVhTdO9_7nTS8JMUVSOG_FmjSWn_ItHYuj-mPo4KAfJZZrqg>
    <xmx:QuTVZNrQfLAMHPkyjFN-JBjmz-srIQFMFCYIZDauOKx0wWYMWF9Qww>
    <xmx:Q-TVZEXLQQuGq39wZz3SdCUHMf4zQLzBxrafj8Qbed0tm8MZMYDrDQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C8769B60089; Fri, 11 Aug 2023 03:33:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-624-g7714e4406d-fm-20230801.001-g7714e440
Mime-Version: 1.0
Message-Id: <cf25b0f4-ee4b-40bd-a928-afdc4cad5c2e@app.fastmail.com>
In-Reply-To: <20230811030750.1335526-1-guoren@kernel.org>
References: <20230811030750.1335526-1-guoren@kernel.org>
Date:   Fri, 11 Aug 2023 09:32:59 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     guoren <guoren@kernel.org>
Cc:     "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "Guo Ren" <guoren@linux.alibaba.com>,
        "Arnd Bergmann" <arnd@kernel.org>
Subject: Re: [PATCH] csky: Fixup -Wmissing-prototypes warning
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 11, 2023, at 05:07, guoren@kernel.org wrote:
>
> Link: https://lore.kernel.org/lkml/20230810141947.1236730-17-arnd@kernel.org/
> Reported-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>

Thanks for addressing these!

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

> --- a/arch/csky/kernel/vdso/vgettimeofday.c
> +++ b/arch/csky/kernel/vdso/vgettimeofday.c
> @@ -3,24 +3,35 @@
>  #include <linux/time.h>
>  #include <linux/types.h>
> 
> +extern
> +int __vdso_clock_gettime(clockid_t clock,
> +			 struct old_timespec32 *ts);
>  int __vdso_clock_gettime(clockid_t clock,
>  			 struct old_timespec32 *ts)
>  {
>  	return __cvdso_clock_gettime32(clock, ts);
>  }
> 

This works, but it would be a bit nicer to move the
declarations into a header. I see that we already handle
this in three different ways across x86, arm and arm64,
and you picked method from x86 (and loongarch) here, so
I can't really complain.

What we should probably have instead is a new header
in include/vdso/ that  declares the functions for
every architecture.

      Arnd
