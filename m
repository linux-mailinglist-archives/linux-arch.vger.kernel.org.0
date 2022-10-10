Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9A85F9E4F
	for <lists+linux-arch@lfdr.de>; Mon, 10 Oct 2022 14:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbiJJMFT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Oct 2022 08:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbiJJMFR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Oct 2022 08:05:17 -0400
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D384746DA9;
        Mon, 10 Oct 2022 05:05:14 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 7C7982B06795;
        Mon, 10 Oct 2022 08:05:13 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Mon, 10 Oct 2022 08:05:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1665403513; x=1665407113; bh=YTwEq0FuNB
        DUiayerqkRMfFBTk/XwiZ5UcKY7hh9tes=; b=m0mau8NTnitQZydqPCyzPvsxat
        kiOKAfvhVdcNmQfMAuTPtYBM2lvXwNHDTQjxd/M4txAqGJ3m8rAIzUUsEqdQ5l8e
        2hwqM4QS/MDcgN/gdXV2HtY1gbH1oFEOeuaAjRbfVM8nBCGXzqI2Mcx7eTOekGNc
        MohyzVNr3WLnyTnWftq996PGZ+TTZr8o8eBStmDi03n2Vpo6bNygt688vEVy4U51
        YdktG21W/pIKxyx/rrMvpoyOXtVXW19YxR40KdxptlI+NKZ+/2U6im5B8428uCin
        NGS+CdowzRCGpUgRfTy97lNXIoBkMGZLdYHWZMo/MvdP+HOGKOQmPbAvqWow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1665403513; x=1665407113; bh=YTwEq0FuNBDUiayerqkRMfFBTk/X
        wiZ5UcKY7hh9tes=; b=XzTlKwew07gMwGudCG/jIWNdJzyMJfrh08OnzsLgr/Nh
        LLOlUmI4YCNTo82pL9hSLF4x10rri/f6Y5fj2gJC4tEJgY+8jcYhVMMOrX0JQf8O
        dVFTK+PKlVri/kGXZ44uL1iItOL2qwtY7HnX5ioZRT634+xFDzA6TAF+0CkzSPTj
        QYRyYFNR+AHTkPFRCuXIHEVM876+wyFHxZ9ksPwmeLfn9+4vnsYq7o3QK/sDsBmg
        cP8LU+XNZhM4CMLvsyK3cC9SiDPNUenqR1soU43DscIOp/guhd/8z6o9WfJAj8fC
        6nwLS1m+3UNsrZ9pNI6DtQnNZFc50DzH0/iOf+sT7A==
X-ME-Sender: <xms:eApEY2h_a2NdBdMRPkYsTd5LFKIb11gQM0EtLmQnG13YulQpZSLVeg>
    <xme:eApEY3DLEtXLRU0KPEEbOYUOb8TX-MCo3Plsl4WeWq2ylE9j5GdAsPgytXxyBhnKq
    fuG1er7Bwt1dpFIupQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeejgedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:eApEY-GWZz7WfqlbWCBYtZjYr6OsImE-FJ-l8F38T8x7Jge9xXAkNA>
    <xmx:eApEY_TP-B1CkJJMuKcYZC4vZhkrsMz8X4Gof0sma22nntDtuf8Odg>
    <xmx:eApEYzyH-dbXFYzq7h5xnJWirKBnRxNMUPIJuN4gouGp9TA5iwqclg>
    <xmx:eQpEY6mO13uF-udZJGXL-Vt2x06vPvy0iQcoHdZH5VCwllUrzqVUDd2-TLY>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 55465B60086; Mon, 10 Oct 2022 08:05:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1015-gaf7d526680-fm-20220929.001-gaf7d5266
Mime-Version: 1.0
Message-Id: <03e79306-1b6a-48a9-b851-d9be057bf83e@app.fastmail.com>
In-Reply-To: <20221010115620.779812-1-chenhuacai@loongson.cn>
References: <20221010115620.779812-1-chenhuacai@loongson.cn>
Date:   Mon, 10 Oct 2022 14:04:52 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Huacai Chen" <chenhuacai@loongson.cn>,
        "Huacai Chen" <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, Linux-Arch <linux-arch@vger.kernel.org>,
        "Xuefeng Li" <lixuefeng@loongson.cn>, guoren <guoren@kernel.org>,
        "WANG Xuerui" <kernel@xen0n.name>,
        "Jiaxun Yang" <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] LoongArch: Mark __xchg() and __cmpxchg() as __always_inline
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 10, 2022, at 1:56 PM, Huacai Chen wrote:
> Commit ac7c3e4ff401 ("compiler: enable CONFIG_OPTIMIZE_INLINING
> forcibly") allows compiler to uninline functions marked as 'inline'.
> In case of __xchg()/__cmpxchg() this would cause to reference
> BUILD_BUG(), which is an error case for catching bugs and will not
> happen for correct code, if __xchg()/__cmpxchg() is inlined.
>
> This bug can be produced with CONFIG_DEBUG_SECTION_MISMATCH enabled,
> and the solution is similar to below commits:
> 46f1619500d0225 ("MIPS: include: Mark __xchg as __always_inline"),
> 88356d09904bc60 ("MIPS: include: Mark __cmpxchg as __always_inline").
>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

Looks good to me,

Acked-by: Arnd Bergmann <arnd@arndb.de>
