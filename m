Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 397F367C4D0
	for <lists+linux-arch@lfdr.de>; Thu, 26 Jan 2023 08:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjAZHWm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Jan 2023 02:22:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjAZHWl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Jan 2023 02:22:41 -0500
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4913611D9;
        Wed, 25 Jan 2023 23:22:39 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.nyi.internal (Postfix) with ESMTP id 84E2258287B;
        Thu, 26 Jan 2023 02:22:36 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 26 Jan 2023 02:22:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1674717756; x=1674724956; bh=E33V4yTgr/
        ebT73Eum3QUd1t2W82YQcLJ50MWaQWWA8=; b=GiLb/skMhyZcQ01dO+WmZTL0hL
        fZ2ikfEbw6M+0GfWoi9BCHFyTrzd/xw84UaBaAMBNbekfpfzAvn0+3OyIl7DpZIk
        AscfaN2jhi+H4+HQPHW6kdeYv0wuJbvXO+Nmf3robmrH9p5Eaz+pTFIh+gw7OUdr
        GHaCtnvyFflXRN840zxE0TueOxb7X1UKgvjA9BbNkN54rpLAR1FBHefwPtJLfO63
        HU5voKjovLZNYSTASSTneRk9lhMeYYIxU5ah7ERIB1I+Tlqz6Sh6cL1quV9LIBsu
        LJGaa2P7uDg6V7dGWcg5+AdhatDXLV001yKTEzZw6AETD2Ctpr5noVgk6LyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674717756; x=1674724956; bh=E33V4yTgr/ebT73Eum3QUd1t2W82
        YQcLJ50MWaQWWA8=; b=i56wP0aRGUynM8c34e7C84YjtNs5ESnKIS4Qk9sa0afa
        hZ6EA3tyzNwBZXGsbGt4dL3J7JuIzcSWHi3zNRP0iTUuzQE6/UwhR5FhRpLn/ouY
        xt6qq+vPBvkzpCHoSxo03igHd1P6lM5xa5cKrF0kUrwg7q2T50CTjxmrDjS0magc
        ZxGVHrCofyRHgqO1ckZj1XRFm2MlqCsUcWY5ZDdbx7SuYVnKPtd0L9F879LdS+aK
        Dn7zgQYu29nT9qh2c89O8Dw8mgobJhwQ28spFTbeCvY5iq0cHOI93ldlBxi2zZYx
        hCfhfAJXQq9sSPCh3KQtBHwxvY8+uaUayqJxJdu1iQ==
X-ME-Sender: <xms:OirSY0UrLGgYH3i-5TBnXx5kCGsN2YicrY23OHL1XQjg0oxapCF8GQ>
    <xme:OirSY4mGQAtxHP9bCv1xlHPGN64L04ZTpqbp3Zo_GJISeoNzutpf4eILgOt_wG15N
    1B3TnHPfXPQ5aq8ZzA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvfedguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:OirSY4a2BI8A8n6QHmfRNwvlyjZb0oHPUIh8AqkYJFN6HEjTyNF3mg>
    <xmx:OirSYzWHad1gVQ1pUnGhOP8BKq_-7XwGF62Qeq8f9YbfS8PPn3iaCw>
    <xmx:OirSY-nzh-yZLlxChEUc50uhXtONqG_p56LYIjKU8LygqILAOsLvJw>
    <xmx:PCrSY4uHnBHnmZDNTb4kWTrj5YTK-XYwojaMEFC5m6krF7i9k40zBQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7FEEBB60089; Thu, 26 Jan 2023 02:22:34 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <03605ec4-3e31-475e-8acf-2c342436aa24@app.fastmail.com>
In-Reply-To: <20230125190757.22555-4-rppt@kernel.org>
References: <20230125190757.22555-1-rppt@kernel.org>
 <20230125190757.22555-4-rppt@kernel.org>
Date:   Thu, 26 Jan 2023 08:22:15 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Mike Rapoport" <rppt@kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>
Cc:     "Brian Cain" <bcain@quicinc.com>,
        "David S . Miller" <davem@davemloft.net>,
        "Dinh Nguyen" <dinguyen@kernel.org>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Greg Ungerer" <gerg@linux-m68k.org>, guoren <guoren@kernel.org>,
        "Helge Deller" <deller@gmx.de>,
        "Huacai Chen" <chenhuacai@kernel.org>,
        "Matt Turner" <mattst88@gmail.com>,
        "Max Filippov" <jcmvbkbc@gmail.com>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "Michal Simek" <monstr@monstr.eu>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Rich Felker" <dalias@libc.org>,
        "Richard Weinberger" <richard@nod.at>,
        "Stafford Horne" <shorne@gmail.com>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        "Vineet Gupta" <vgupta@kernel.org>,
        "WANG Xuerui" <kernel@xen0n.name>,
        "Yoshinori Sato" <ysato@users.sourceforge.jp>,
        linux-alpha@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux--csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
        openrisc@lists.librecores.org, sparclinux@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH 3/3] mm, arch: add generic implementation of pfn_valid() for
 FLATMEM
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jan 25, 2023, at 20:07, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
>
> Every architecture that supports FLATMEM memory model defines its own
> version of pfn_valid() that essentially compares a pfn to max_mapnr.
>
> Use mips/powerpc version implemented as static inline as a generic
> implementation of pfn_valid() and drop its per-architecture definitions
>
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>

I assume this can best go through the mm tree, let me know if I should
pick it up in the asm-generic tree instead.

     Arnd
