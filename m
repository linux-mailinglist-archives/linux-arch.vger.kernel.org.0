Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E86174987E
	for <lists+linux-arch@lfdr.de>; Thu,  6 Jul 2023 11:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbjGFJas (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Jul 2023 05:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232215AbjGFJao (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Jul 2023 05:30:44 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53C11FC3;
        Thu,  6 Jul 2023 02:30:39 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 1D5195C026E;
        Thu,  6 Jul 2023 05:30:37 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 06 Jul 2023 05:30:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1688635837; x=1688722237; bh=ns
        aS9in3LbXPzSdPJrRJrYRmx15Icn3WUEtWx/SxKes=; b=ZN98/1+O6qB5riXF70
        +mNRLOVw3TiqieDCeEju6zy5uDVeea4K3SqCWXiO88U2+yF4nSnWAovmW+N1phEg
        Mx+XGVZfeCtfCi4aShlM+yax/o1GWyvcIkwQLBzvgpau8NJN8y+hwro0BjB3G99h
        GACoa9waYIMNr11k+4puA/t6vwMb/Pc/KmqWm2LcWthR/RGOmoHh3kcXGSMXF9BU
        f6GkiUMECDGmNZ2lqFKwJxwGgf86zLFPA6PkIz33zrN0bvaF54PXgTbmr96M1pCD
        LGStVXxucTWuWWkY6965OtFvBa54jKp3kDmixGciUrRjnlu8UhP6MFjlI1U8u29O
        +3Rg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1688635837; x=1688722237; bh=nsaS9in3LbXPz
        SdPJrRJrYRmx15Icn3WUEtWx/SxKes=; b=eCvIaXK6twlneFhMTfKsE5+313ncU
        np1sKcLVcZ+r5wW1MxmWSx4ILmov0RPtFvDGLNfNfNHhKEkQyfd3pIovyQELfH6o
        7JH/F81Q6UTNDsboqazVonqE+IwUChqRg2AdZxd8zC3sQbe7MMrIa4Elibkp1Quq
        MNfOzXhmJVt4Sr1ihFoQbm9Ym3pzbMQsaD27DYaKBTJoKw7IAJd7ETvU/9sJ/9Vh
        JNIEvSycaEvZAta9hRHawukqFkr2ryBLlaNWKKre4U0LawhbkJbpY1enHrI8C7dd
        i7k2G13HDlHTVgejgXdrUjVWm9oI2df6x/8+NzBUfx/+PDzZyy8Mbrh+A==
X-ME-Sender: <xms:u4mmZAEJpoPeuWa_zK_ky-W9KFKW3sDvXBzXckVg0y-6B0MtNdQM4w>
    <xme:u4mmZJXXqqx8L2czd7UmtUR8hKN52s_shs8NDNQWKWwbnlYNCaehKxgc4mptXqRNU
    JK5xC541ZeHnWQr_rs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudelgdduiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:u4mmZKIAKu1a3173UlVLaAJxpVrGNnRcsg--1Vakr7VGYbs1T7Ls-w>
    <xmx:u4mmZCE9rw0hhJWsWzqnXDzLG88XRtkzqz08zLwZ8kOfj2aIsup6ig>
    <xmx:u4mmZGVxOHkdmACwAYTDM6wA_yrKTMBb_Vs6OpejhKWbbQyMsp34kQ>
    <xmx:vYmmZFTf2JLCgRM8cY_zsf1zBrYD4gxADv9wHZzbkwBV_eIjkfHB2Q>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id BD3E7B60086; Thu,  6 Jul 2023 05:30:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-531-gfdfa13a06d-fm-20230703.001-gfdfa13a0
Mime-Version: 1.0
Message-Id: <245a1e0d-197b-4ee0-985d-5c91a90e2a65@app.fastmail.com>
In-Reply-To: <9a23db59-1f53-4a24-87d7-a59293972a29@app.fastmail.com>
References: <9a23db59-1f53-4a24-87d7-a59293972a29@app.fastmail.com>
Date:   Thu, 06 Jul 2023 11:30:15 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     Linux-Arch <linux-arch@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Sohil Mehta" <sohil.mehta@intel.com>,
        "Tiezhu Yang" <yangtiezhu@loongson.cn>
Subject: Re: [GIT PULL] asm-generic updates for 6.5
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jul 6, 2023, at 10:20, Arnd Bergmann wrote:
>  - A cleanup for virt_to_pfn/virt_to_bus to have proper type
>    checking, forcing the use of pointers

Sorry, I meant to mention a conflict against f5f82cd18732
("Move netfs_extract_iter_to_sg() to lib/scatterlist.c"), which
Stephen fixed up in linux-next as below.

    Arnd

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 9 Jun 2023 10:35:56 +1000
Subject: [PATCH] fix up for "Move netfs_extract_iter_to_sg() to lib/scatterlist.c"

interacting with "netfs: Pass a pointer to virt_to_page()"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 lib/scatterlist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index e97d7060329e..e86231a44c3d 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -1237,7 +1237,7 @@ static ssize_t extract_kvec_to_sg(struct iov_iter *iter,
 			if (is_vmalloc_or_module_addr((void *)kaddr))
 				page = vmalloc_to_page((void *)kaddr);
 			else
-				page = virt_to_page(kaddr);
+				page = virt_to_page((void *)kaddr);
 
 			sg_set_page(sg, page, len, off);
 			sgtable->nents++;

