Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2986FEFF2
	for <lists+linux-arch@lfdr.de>; Thu, 11 May 2023 12:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237858AbjEKKa1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 11 May 2023 06:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236394AbjEKKaV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 11 May 2023 06:30:21 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8D29ED3;
        Thu, 11 May 2023 03:30:19 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 95DB65C05AF;
        Thu, 11 May 2023 06:30:16 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 11 May 2023 06:30:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683801016; x=1683887416; bh=9I
        OGDiblkFRbDZIjCr3R6F10Wwf4xRuN5F/Cayos2jI=; b=Nu1zdydqZGCHE0j49I
        b1k0Pza4Yxzh5UOd/RddabRlgX7vN1ntsEJ8ojvzErPj1SDzt9fIe8B7umjxQcNr
        OfLFMPMaFR56rNrU6APH2AnhiT0891XGP/q1QMdSYzBLzdytjTkoZNQfvzTSAFse
        m0BwusgsmgGpJPuAYFkaY0/B3uQ3kuUpEv9dmI4TUvy6p+EgvVs3wFyinhDtsBl8
        L3NFfBCAC6NOdBSbOP91fXMV3/0fWHLZtPGbTWDv49o29AeKJXsTL1kuLFJn/PZh
        56xXvj7NAogVE0cKFpbmELF8c2bAqWS9iDhtF3ofSAKCzTHmfygM5wHWVlLuEO46
        0fLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683801016; x=1683887416; bh=9IOGDiblkFRbD
        ZIjCr3R6F10Wwf4xRuN5F/Cayos2jI=; b=WncwX4Jt/jzTIfIQYCMYWxq7z7isX
        fNHgLClzqebm3J6gYU2Sok+J53nhjgGkdHHb08TMhl3O9ukUUoeh1A5MFdCIc34R
        sLrNV2vzdQQl1Vxtg1epPEAL7YHFr3QOmcxrO93cZBEAAcO58dTVPc95ccQ4guf5
        xHqCVc5HMBe9DUg9hrZO80U1eIXSpfZQtQcNfdAGkL+GnF7t/bGNrqOYVXwQKQDH
        2HidTQjqlErstt3yUuBj34zKvXxczaun/QE/afg8X+45i9Y9O5VC4gnyG085oe6D
        /vQnehnCCRf9uc7r2lETo+KwZ/dof0urrYBB7wxJQIxWN+qNI0LQKJlmQ==
X-ME-Sender: <xms:uMNcZFN5d3RLTQpsbp3-Y8sp4mcnKZAOsW2pflnBFC_HJ2lvjLI8-g>
    <xme:uMNcZH9WWQjS3g-CSuZ-aN-Zy_PoUVYgDAHtX9x8uj-5v7XSh6MdrngspbULuyKxc
    oLVet4PkU7r_rU5Gpc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeegkedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:uMNcZERGNKhe9tdebJrR5LZENEySVw0VDwmm-6HaPYIjThyAWV-mqQ>
    <xmx:uMNcZBtv9piiW3dHHJo2bxc7S2Vrs6HqloMrWMKQ7dTyTo5vGEm4jw>
    <xmx:uMNcZNdU55v5RiCLOGsTin7jcw1z31lw-jxPktg2isucnP4Mbp5cSA>
    <xmx:uMNcZMxHUaxKV8AYw7L9HMKMPe1NH-TXo3rTyTPh84QMGNIi-SCRjw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 21CD9B60086; Thu, 11 May 2023 06:30:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-415-gf2b17fe6c3-fm-20230503.001-gf2b17fe6
Mime-Version: 1.0
Message-Id: <601fc504-0722-4292-8d3c-0195714a2a59@app.fastmail.com>
In-Reply-To: <20230511092843.3896327-1-nphamcs@gmail.com>
References: <20230510195806.2902878-1-nphamcs@gmail.com>
 <20230511092843.3896327-1-nphamcs@gmail.com>
Date:   Thu, 11 May 2023 12:29:55 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Nhat Pham" <nphamcs@gmail.com>,
        "Andrew Morton" <akpm@linux-foundation.org>
Cc:     linux-api@vger.kernel.org, kernel-team@meta.com,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "Johannes Weiner" <hannes@cmpxchg.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: wire up cachestat for arm64
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

On Thu, May 11, 2023, at 11:28, Nhat Pham wrote:
> cachestat is a new syscall that was previously wired in for most
> architectures:
>
> https://lore.kernel.org/lkml/20230503013608.2431726-1-nphamcs@gmail.com/
> https://lore.kernel.org/linux-mm/20230510195806.2902878-1-nphamcs@gmail.com/
>
> However, those patches miss arm64, which has its own syscall table in 
> arch/arm64.
> This patch wires cachestat in for arm64.
>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Suggested-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
