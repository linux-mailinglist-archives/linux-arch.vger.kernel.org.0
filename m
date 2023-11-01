Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D7F7DE64D
	for <lists+linux-arch@lfdr.de>; Wed,  1 Nov 2023 20:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232729AbjKATOh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Nov 2023 15:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232745AbjKATOh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Nov 2023 15:14:37 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DC7A2;
        Wed,  1 Nov 2023 12:14:31 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id AF6A75C0209;
        Wed,  1 Nov 2023 15:14:30 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 01 Nov 2023 15:14:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1698866070; x=1698952470; bh=Cy
        q7i6EaGgil28Xl5F/guM0LpGPiNQiaA+bO7M5w6ZI=; b=INM1HKJwabC3A1jeJN
        SVm82M0rXMmci4dXowbsR7aGUDKLj3VlikAYGG8ZozK6hAuJNntjuGI0DPQ8lxmT
        xW95NsvkU5rLlUvlaCKQ8qzx3mxUtk8k6K522+EHyl6AWnHJhJirOvwkQORvEqpM
        XbocrgQ9E0D90hLUqLtE1g/wdfQR9jdbecMotlmXBOEWSAgCOvmXK/di06MrjlW/
        c4lZOjgTUkpLXY6BTxYeQXbalTiYLuHDmWt+NmhS+z5phRQgf0XodcB0k/CqBOYn
        l7LJ8jzz9U2EDm4gIruiQydd9SXyOIrfcd7JG3wY1uLV7YpuMhTUqVUUjis3a5iy
        ATMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1698866070; x=1698952470; bh=Cyq7i6EaGgil2
        8Xl5F/guM0LpGPiNQiaA+bO7M5w6ZI=; b=dpQ8IFe5Ybpf0ckmqJ6zj1t3Uib0k
        2IHBDD8rKSUNAPVBge1lB+hTf1DM1/6XDdaxwGwwsGp2dCz4sWVOYW957PoQtmcw
        qUpzmRm25UA0KYrtMtqxF/4kEOfh0IsAqq4uG+ET0m/GJoQKFSzSyV9a2RnhfBNu
        6YCi0xaeQp67wt68qmKshfGI1SK8Ch3anX+qLvWLOF3us5Z9oOB/gQNgnJkUD4U6
        v4HEDig7Sh0OKfxsUkcW5UYxwQBjILMZpoU3WWmEdXNm00+C9VMPlZJF2acpx8In
        2Km2EOMw9cX7JnMX1GlLQbjMphdRO8ZfdTs3Zd/NbP7af8HY15k9bBx9A==
X-ME-Sender: <xms:lqNCZZ2cI36jOjIVjmRsCta6aqNW9vxE7_qfNtI0AfnPcLGwmEFfPQ>
    <xme:lqNCZQHZkILq72HZMew8ODZhY_gfVe7FS6MaU4iW4RooivjH4V5VIZsGZI22_Ma3O
    hKAAgPDlGLMmUO3EqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtgedguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:lqNCZZ6j75x7Tm3vMGEzC5KQHpMXaS_WCHbWfI6Fdh-xBZMA72PJ3A>
    <xmx:lqNCZW0KlD2LvlSsQf5eKPBEWzwVIQBMg_wHPCP708EL_wqUImOD8g>
    <xmx:lqNCZcEiJph1WKGyeKawt180YBLtmInIg-kiTod-NjqYM-pOIF6zMw>
    <xmx:lqNCZXCgJIFktVUXLcFbg4g0YlUHbF9a_7w6hNwfpIPZGRqcsda-cg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id F1B42B60089; Wed,  1 Nov 2023 15:14:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1108-g3a29173c6d-fm-20231031.005-g3a29173c
MIME-Version: 1.0
Message-Id: <be85f9cb-25cb-4d58-a0db-9b85af240bba@app.fastmail.com>
In-Reply-To: <20231031-optimize_checksum-v9-5-ea018e69b229@rivosinc.com>
References: <20231031-optimize_checksum-v9-0-ea018e69b229@rivosinc.com>
 <20231031-optimize_checksum-v9-5-ea018e69b229@rivosinc.com>
Date:   Wed, 01 Nov 2023 20:14:07 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Charlie Jenkins" <charlie@rivosinc.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        "Conor Dooley" <conor@kernel.org>,
        "Samuel Holland" <samuel.holland@sifive.com>,
        "David Laight" <David.Laight@aculab.com>,
        "Xiao W Wang" <xiao.w.wang@intel.com>,
        "Evan Green" <evan@rivosinc.com>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>
Cc:     "Paul Walmsley" <paul.walmsley@sifive.com>,
        "Albert Ou" <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v9 5/5] riscv: Test checksum functions
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Nov 1, 2023, at 01:18, Charlie Jenkins wrote:
> Add Kconfig support for riscv specific testing modules. This was created
> to supplement lib/checksum_kunit.c, and add tests for ip_fast_csum and
> csum_ipv6_magic.
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  arch/riscv/Kconfig.debug              |   1 +
>  arch/riscv/lib/Kconfig.debug          |  31 ++++
>  arch/riscv/lib/Makefile               |   2 +
>  arch/riscv/lib/riscv_checksum_kunit.c | 330 ++++++++++++++++++++++++++++++++++

I don't understand this bit, what is special about riscv here
that prevents you from adding it to the common lib/checksum_kunit.c?

       Arnd
