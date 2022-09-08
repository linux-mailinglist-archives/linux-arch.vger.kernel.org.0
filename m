Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7019C5B2144
	for <lists+linux-arch@lfdr.de>; Thu,  8 Sep 2022 16:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbiIHOwS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Sep 2022 10:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbiIHOwF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Sep 2022 10:52:05 -0400
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2287611C176;
        Thu,  8 Sep 2022 07:51:51 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 401F0580736;
        Thu,  8 Sep 2022 10:51:50 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Thu, 08 Sep 2022 10:51:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1662648710; x=1662652310; bh=fvxntO4oWr
        KM9m3QBIVXQh/akrVVbow7ITon7TAcDFg=; b=T3ovjRGcfRJnLcD9Dj0p5JMeaT
        BmkIJM8gPStOJLdxWxqgJFqY0TJ2gt83qcLKsXIFJt2rsolfrVqJEGRb9+/HVhKB
        +fF4lCUWVTPNo8QnR9r0xRaikzaQHLToKHw6BRsdzGY2xsnpzV0bulCZM32WNMD7
        vdwADYlleTuAgFAiVuGJKBPma3KAhJEwly6JefxBWenUkTv9Pn4SKl4goxlmdH9T
        M09CzEy9q2zhJgYabJdZthlvO1Hy1H7wDVPcI+29THc4U2EiuEKLCIPflKDSzDQC
        P1VksUmYQp2AzyVpRQ8x4Qwz2n8a3trFAMGmpNyyT15cJ3pmnqepgeBF6BEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1662648710; x=1662652310; bh=fvxntO4oWrKM9m3QBIVXQh/akrVV
        bow7ITon7TAcDFg=; b=E0pselW5NBkdYlX81XJiShZr7kwPjW3sXXWQ5B7h6orf
        zWyg4niSpfODKiiHWrCAI9oLMx7g9Zx78eqQ+WVOU+31aKdpBCbH4O/wvO49Oe0d
        BYQqxcCLMKAKudcCjI93HIz8fc5f8T4USA91oHVr/bbAkxVaOEkZzdbh4CgZtdqB
        J+Gnejw38SLVU1litTK5H05gBKkbwwCuB3hgO/WiCB1vFit9W/zKuSouPomYWHs+
        pjrp2pPaQR2vzujJEl2xlFv8/XzYBffSRJb6N/hZ4ArJk4MHa8HySVoNj+I5gqMk
        Lagjx6kQuCNUOdgmPQksE21Ypg2uepUCntElIISE1w==
X-ME-Sender: <xms:hQEaYzbvT8jeqj55jJQ-DjWEvt1TS8nw953_lEVR1ieO7Axg3Ycneg>
    <xme:hQEaYyZ6sbxsv0GMt4agYguZtplXeNmY0xVp5k66StalAWHrvkVfNGbR8YyuS7QP8
    B9C_964bdBNw29I50Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedtfedgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:hQEaY19-t1GL_DlBR_Kuv3ninTvZ3c8KdXGxfnxJQ7MWB3C-xAA9IA>
    <xmx:hQEaY5qUIc2aJKzc-Xc-OwX8_aOC1zASLIwNa2ZMZy65yZst08-fIA>
    <xmx:hQEaY-plCkkIBjcFUMcVhsA-oAH7Wfy9PzyisPg93NurNWFzRSphfg>
    <xmx:hgEaY1RoLO1Ga5sX8XtlT8LGTumNIQUIToAeeyaMcJ9aXXdG_IrQQw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D690EB60083; Thu,  8 Sep 2022 10:51:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-927-gf4c98c8499-fm-20220826.002-gf4c98c84
Mime-Version: 1.0
Message-Id: <d414eff0-a74b-480b-9449-ad6d114ff911@www.fastmail.com>
In-Reply-To: <3bdb5323c465daa81682ebd7f8594962320680e6.1662625281.git.christophe.leroy@csgroup.eu>
References: <3bdb5323c465daa81682ebd7f8594962320680e6.1662625281.git.christophe.leroy@csgroup.eu>
Date:   Thu, 08 Sep 2022 16:51:28 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Christophe Leroy" <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] asm-generic: Remove empty #ifdef SA_RESTORER
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

On Thu, Sep 8, 2022, at 11:12 AM, Christophe Leroy wrote:
> There was a #ifdef SA_RESTORER to guard the sa_restorer field
> in struct sigaction.
>
> Commit 8a1ab3155c2a ("UAPI: (Scripted) Disintegrate
> include/asm-generic") moved that struct into
> uapi/asm-generic/signal.h but the #ifdef SA_RESTORER remained.
>
> Remove it.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---


Applied to asm-generic tree, thanks

     Arnd
