Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14DEE6A4BF2
	for <lists+linux-arch@lfdr.de>; Mon, 27 Feb 2023 21:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjB0UE1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Feb 2023 15:04:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjB0UE0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Feb 2023 15:04:26 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDCA1227BD;
        Mon, 27 Feb 2023 12:04:25 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 633825C0113;
        Mon, 27 Feb 2023 15:04:25 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 27 Feb 2023 15:04:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1677528265; x=1677614665; bh=zexpZQ5bJ9
        hbIaBDiHdAg4Kdi9EcW4M9yOSGV4fDHqI=; b=UmD1++vWuDhma9hYn/5OBgkV9W
        SmKh3J+jW/DRQw9ZayTbfH4doyDnfMKGcrUjRg+MHXB7+skv9MR2Wn6feDUwa/pc
        PGT3Jx1cKFRVV3yUC+Xbv73xv4yG9hlMD+x2L5XYUsFkhcKBk+bS73Zg84OwAvEZ
        RNZMUvBcMXHf7fLXwSvthCoH+1LmkzeFxFlxrddpojiVz793BS8I93v3s80ny4oe
        1FufDxHhi6hoVKIkPvvLYmJ+SFsDbckDivUEjltSlVQ3ucoef5IiqpK+X/HiLHU1
        GwGjKaqWwuFOXkvK+hEEYfudtjKdyB2/Ux5tmyNKJb3vsbFLjm9k6AAh9Bvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1677528265; x=1677614665; bh=zexpZQ5bJ9hbIaBDiHdAg4Kdi9Ec
        W4M9yOSGV4fDHqI=; b=j7dASZo3V9dUBM6DtvQO9/dlt76IBaikXPpslXjq6pST
        jFfZh2uRAMePwDHhoQQLNQzkC12wPkXcZPLXx2ADjJtqEKy7bW2+gxDbbcJDDOVQ
        VuvwS4PM8MQcf2Rr7qyfXLPe5Lc46+01w63aLtcMijCn/ZKTsn+l9IY4axqQB3ol
        2+Oudolo5/Ha3o/ZLMIKLoOyX7RvZncBzpV5PZV5kFhzlW2izGNS0rTWVEdEpYEc
        Al+q0KEZn6nANGo4y6fiDSB7LzYpD7c9+b8aYZTgtvzwWVL+zjKnTCaX+ZymZxf+
        98xn4wFADSco0SR13mRCBDtf/UGEqWcwjxcgYDRQuQ==
X-ME-Sender: <xms:yAz9Y4QZ0bFqOsCcmYvhDiiHwpxCKqqbcoDxkoq0bcMaF6zxsmIhLA>
    <xme:yAz9Y1yRmthicotCWDvnALQCFqZxBnSU3xJUZLCygQBrua0hWqRWUqUEq7uINKysC
    ybAQeT6N9FlN87aCss>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeltddguddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:yAz9Y13kmNhmOhtb3wu_v8-vYIJiuGXAPPQgztyZ7fxY0YH2388u_Q>
    <xmx:yAz9Y8A15AZvjUD-laD2dBaFISanpvfqgH7VrgM-JuuNfwTcJV-QsQ>
    <xmx:yAz9YxgnuUCrgQLpa3tOZBdHss6HmqK7a0b2jqyXZwHv4uftJYQElA>
    <xmx:yQz9Y6anFwyHybOEKazqP3sfgZcO0TLbxR_X_5vMC9wUpJAVx2fVxA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B48BBB60086; Mon, 27 Feb 2023 15:04:24 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-183-gbf7d00f500-fm-20230220.001-gbf7d00f5
Mime-Version: 1.0
Message-Id: <5de30963-9be9-4e87-a696-7a642d92630f@app.fastmail.com>
In-Reply-To: <20230212084611.1311177-1-rppt@kernel.org>
References: <20230212084611.1311177-1-rppt@kernel.org>
Date:   Mon, 27 Feb 2023 21:04:04 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Mike Rapoport" <rppt@kernel.org>
Cc:     "Dave Airlie" <airlied@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        "Helge Deller" <deller@gmx.de>, "Matt Turner" <mattst88@gmail.com>,
        "Michael Ellerman" <mpe@ellerman.id.au>, x86@kernel.org,
        dri-devel@lists.freedesktop.org, linux-alpha@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org
Subject: Re: [PATCH 0/2] char/agp: consolidate asm/agp.h
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

On Sun, Feb 12, 2023, at 09:46, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
>
> asm/agp.h is duplicated in several architectures, with x86 being the
> only instance that differs from the rest.
>
> Introduce asm-generic/agp.h and use it instead of per-architecture
> headers for the most cases.
>
> I believe that asm-generic is the best tree to pick up this patches.
>
> Mike Rapoport (IBM) (2):  char/agp: consolidate
> {alloc,free}_gatt_pages()  char/agp: introduce asm-generic/agp.h

Hi Mike,

It looks like I wrote an email saying I merged these two patches,
but never actually sent it out. Not sure if you found out another
way, but this was part of the asm-generic tree for 6.3 and is now
merged upstream.

Thanks for the cleanup,

     Arnd
