Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD67C78E1A5
	for <lists+linux-arch@lfdr.de>; Wed, 30 Aug 2023 23:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237586AbjH3Vwt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 30 Aug 2023 17:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242844AbjH3Vws (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 30 Aug 2023 17:52:48 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFAFACF9;
        Wed, 30 Aug 2023 14:52:16 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 473173200681;
        Wed, 30 Aug 2023 15:51:26 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 30 Aug 2023 15:51:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1693425085; x=1693511485; bh=EA
        AokXkBZ1oabmHLEd4xI3A+ZO14oLciXrp5+OaR49E=; b=DoI3vSr5VzKvXd7sPf
        vRiV8hH4rK6fXmpdJRGIVz1xGTgPKfqxxjxs24kmW6FihHX3N0yEKJ8qik6UEGYb
        95CHQ6ljd4jxgRKFewqaAnNDL0JPJm3B5SGXKL9Evt0PvSK8XunFWlPJ7q8dC1pX
        f+XJHFZYW51CKc9uWzF73aumHv/iTm1jzTDMeosWM5Q17KXBxjKMqIqnv1n+wSUH
        eyTyuY85ZMSBpy5vJvMmZECuzaz9Ma/NHSiqsHNdwnq0d1aZBNpnNOI9utHoOU9J
        gwqUgdnaYkRQK5DO47QZ7WJrVANHCPMtolWnf/7GcrtDYnTcSw9i+Q6PzcM7p+NS
        0Qlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1693425085; x=1693511485; bh=EAAokXkBZ1oab
        mHLEd4xI3A+ZO14oLciXrp5+OaR49E=; b=L/Jph3j1eWucO0jOVPQwlTO5pQs0i
        Oa6lNnCSl1I4DN3KB5hNWbqv8JQBp2j7r9d8DsVoc/W3GZj0ZvbfWcpXxFkOJT0/
        xrftvIs7dkBf5CCzG8MHY3sdizv0DjtM4PnyiPV/GX1JFSlltO6gZZ35IBDQAp+e
        g6tgTurFihzq0RQPk09i9wb7+nTsfRAslfqOG14Kj4TblbyOQ81FSpT0g/KDW7tJ
        Narg1/ORjjTOz/4gd+j1jRc6EtJ6Tv94/lXXzWqMz0ik2H8ND5yfHmEW8AgglMJ9
        /2sbZLr8idRZcbpl98+PxcUqsvtEh7084D3d1gVXzLD02/wRY1Eg8lLqg==
X-ME-Sender: <xms:vJ3vZMv0SI2oeOcUO_qrvCHdVfncwt-xTicrG-Hh0D-D8L8vWYXFPA>
    <xme:vJ3vZJe4GLF3uWbGnIuBaz6fW_SjcddvKynT3EAfcKAOQVIbpsyE8vKuXKuoVIqwR
    OvBpwAEHswci-5M468>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudefkedgudeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:vJ3vZHya8rFzM3ZWaUkc_0L78fMJGWsuFavX5429EJzhI_YZIzrgCA>
    <xmx:vJ3vZPOaSvJN-gwiqYhVSY4bWeTHvX9b7yuvVLoQPViDqBFSvqktDg>
    <xmx:vJ3vZM8PQv_XjkHXjy4_uFZIB8s_CT2nvs7nPBEhf097Lr6-wNjw_g>
    <xmx:vZ3vZNjSLyi2FUZobnkLrgMlbC0JTdK73QaaP7HMVy6rBf63jdmuEg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3B057B6008D; Wed, 30 Aug 2023 15:51:24 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-701-g9b2f44d3ee-fm-20230823.001-g9b2f44d3
Mime-Version: 1.0
Message-Id: <0036d0ee-4329-4fd8-9317-95818f576e98@app.fastmail.com>
In-Reply-To: <e53f0f8da1607856028d941e7ac8646aa2abc555.1692288018.git.geert@linux-m68k.org>
References: <cover.1692288018.git.geert@linux-m68k.org>
 <e53f0f8da1607856028d941e7ac8646aa2abc555.1692288018.git.geert@linux-m68k.org>
Date:   Wed, 30 Aug 2023 15:51:03 -0400
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Russell King" <linux@armlinux.org.uk>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Helge Deller" <deller@gmx.de>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "Nicholas Piggin" <npiggin@gmail.com>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "David S . Miller" <davem@davemloft.net>,
        "Sergey Shtylyov" <s.shtylyov@omp.ru>,
        "Damien Le Moal" <dlemoal@kernel.org>,
        "Christoph Hellwig" <hch@lst.de>, "Jens Axboe" <axboe@kernel.dk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/9] ARM: Remove <asm/ide.h>
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Aug 17, 2023, at 12:07, Geert Uytterhoeven wrote:
> As of commit b7fb14d3ac63117e ("ide: remove the legacy ide driver") in
> v5.14, there are no more generic users of <asm/ide.h>.
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---

Acked-by: Arnd Bergmann <arnd@arndb.de>
