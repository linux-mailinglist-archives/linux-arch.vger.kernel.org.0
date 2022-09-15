Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19EF5B9AF0
	for <lists+linux-arch@lfdr.de>; Thu, 15 Sep 2022 14:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiIOMiY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Sep 2022 08:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiIOMiX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Sep 2022 08:38:23 -0400
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26327E81B;
        Thu, 15 Sep 2022 05:38:20 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 2E87B580A3A;
        Thu, 15 Sep 2022 08:38:18 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Thu, 15 Sep 2022 08:38:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1663245498; x=1663249098; bh=GOQu+p1fdW
        E5Hvw9mjSrByv4wqlK2YtuqQuIjWmQzbM=; b=iK5aPwGsVp4LFDgOT6v1vOcJXd
        v2t8uJQju2i8NkEtKrotkc5at3C7vkyEkNUUxz9B82lUwXv7Lr21VT80tZNk6Xg0
        VRUNf0hJD0plBl1FZ5GNRUtEqIwjfFhYH6YW1ePT91pqrlvLL+KGgT89uA9hxfn6
        y/08rc0ujo57MH7A18qUiPKHanmiiEVUS+YH4kezjtMvb680f/DDVV+g4ZUyIKQF
        G+8ELEfkrpp9D9oh46zsXllUYrXMC5N+wCJXgEzOA0k0mxgByf2UcCBISBR/xyim
        HR87b5q8kR/eRvt6H06SHTiTX6L0WAboqXD460/6N0lIuurIpQ/aXNFpRHng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1663245498; x=1663249098; bh=GOQu+p1fdWE5Hvw9mjSrByv4wqlK
        2YtuqQuIjWmQzbM=; b=XaP2SxmoImcj1BJ6jg8g6fEGc6KHKH0i4XzjSPePeibz
        wZwJE85YQWmeqJeFt25ucs8DVPCn4dDPa1/zkBlnTXJLa+V6CNhcZRSOI0TEpwhA
        GzICWSWNfPluom+CS1n8uoEzUs6YOUouK+x+auOp4GJxMAqFCx3F+gIxfFrAao7l
        bI6qVKdN1+VIslJf/FV3mxocas2V9/2nfiWksIwRSfJWzitRtJrTLOKoB7FGL+EX
        LTdB6SDyV8+n5Qiv70X6A8yHCmG+6Ks7xS44poXj+NO1UANnO7uID7gtTHKu9nMj
        MYZ4+v+XA8xhFq/2uDZMtGVBPM5pgY7lPEQhofEKkQ==
X-ME-Sender: <xms:uRwjYxy4457sp1J45hJz17mdgyC-fHkQu3jpgXB8k3GPtPBi2CSV8g>
    <xme:uRwjYxSoJIjfQx0nTyxs4Dx5qqAUuU5SZqiJUKACxcFlBExpeOjL0uW3XHBMSFWC6
    QlwuabPhy0cW1anTu4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedukedgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffgeffuddtvdehffefleethfejjeegvdelffejieegueetledvtedtudelgfdu
    gfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:uRwjY7XgbSh2gejrUG0URQLMnh5ZCUjw7_jlihEsNOxC_rdc_UmOjg>
    <xmx:uRwjYzi3alBKqtNJCZvnBe4DCeR0e54CtjSK3-tNYoEucuiBBLJ1yw>
    <xmx:uRwjYzAX8NFJFzjqDJ6_8NkuIZ2gBRjnK9nUrTeL3waIGlxcMFuKJw>
    <xmx:uhwjY1QFxdp0oD-rFYiv-ob2eFLeh0JULhb9m9QbhYG0ddWSVtPZqQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9768BB60089; Thu, 15 Sep 2022 08:38:17 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-935-ge4ccd4c47b-fm-20220914.001-ge4ccd4c4
Mime-Version: 1.0
Message-Id: <96457b14-e196-4f29-be9a-7fa25ac805d9@www.fastmail.com>
In-Reply-To: <20220915050106.650813-1-parav@nvidia.com>
References: <20220915050106.650813-1-parav@nvidia.com>
Date:   Thu, 15 Sep 2022 14:37:57 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Parav Pandit" <parav@nvidia.com>, stern@rowland.harvard.edu,
        parri.andrea@gmail.com, "Will Deacon" <will@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>, boqun.feng@gmail.com,
        "Nicholas Piggin" <npiggin@gmail.com>, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        "Paul E. McKenney" <paulmck@kernel.org>, akiyks@gmail.com,
        dlustig@nvidia.com, joel@joelfernandes.org,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] locking/memory-barriers.txt: Improve documentation for writel()
 usage
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

On Thu, Sep 15, 2022, at 7:01 AM, Parav Pandit wrote:
> The cited commit [1] describes that when using writel(), explcit wmb()
> is not needed. However, it should have said that dma_wmb() is not
> needed.

Are you sure? As I understand it, the dma_wmb() only serializes
a set of memory accesses, but does not serialized against an MMIO
access, which depending on the CPU architecture may require a
different type of barrier.

E.g. on arm, writel() uses __iowmb(), which like wmb() is defined
as "dsb(x); arm_heavy_mb();", while dma_wmb() is a "dmb(oshst)".

     Arnd
