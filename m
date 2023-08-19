Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6EBC781C10
	for <lists+linux-arch@lfdr.de>; Sun, 20 Aug 2023 04:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjHTCgB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 19 Aug 2023 22:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjHTCfr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 19 Aug 2023 22:35:47 -0400
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84355D4C7;
        Sat, 19 Aug 2023 16:12:57 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.nyi.internal (Postfix) with ESMTP id 0106B580126;
        Sat, 19 Aug 2023 19:12:55 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Sat, 19 Aug 2023 19:12:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1692486774; x=1692493974; bh=eF
        p9xFgSVp+I1HTUH+y+7224okESMQ+VhbU3Am512Uw=; b=GXs5Ux18dB7s0wFIA7
        EqEXXEICoPI+MlJNUcsMVjF7KAdxknUeboQC5nn/yYM6tgVpl/0TwWMvATMWmHtZ
        hkhuQaHdleRtYpTuCi0aIVczwIb5ZMgxlN59ySsDf7vRpemRUuR2fS0+ICwtJJG7
        qTqYF0dpBsTOaGt81+niyXp1SOH+gdl2UekcgeMO3ns+Hw/YckLwE91NXkRyH1LK
        oLIZbt0G8sqGDBiWeWNOsvs48hgFiRT43a31LbgBuSD/BtnQI1UHBVTBXpkxygoW
        +aMuYaE7TEx2ASCa1kooI7poXJi0tfN1WFo5UrMrfVYL5r+EhBOqC0koyppfKcTW
        kjDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1692486774; x=1692493974; bh=eFp9xFgSVp+I1
        HTUH+y+7224okESMQ+VhbU3Am512Uw=; b=Udursr+emtzG/itOBWyrlF2MXy/uT
        JC8uydwvvtDYj3J6YYUbAp7hQSYTYVpNZkujBOjtQeedXkQuWLtN3LTll+AVzSwA
        yECKLkED1sAXwOkHu0SecwJbyYfbTc8vhjKF+YVTplEZpTrz7bQTwjcp0Mfdf75N
        CO3+YgwY/KEbAAWElpsSZTbhk83SrFMKVl6NFZXDq8LkSFtlTsVzmfZUGOsABvh9
        SW8hntLOBpOe9NCE2I99ewFmBrUfl7T1ejFkCvr2ExDNM58bhUMwS2gZ+2cNPrdC
        cUYhGlwW0psGSQtEJBJF5WtrasD3qV17MD7gOs+JDwzW2EaQ7hfC2ljyQ==
X-ME-Sender: <xms:dUzhZDLE_dc_K6K0vpAUQcVXmUImZgpV1_84N9Yng8QEZeY_dQgoLQ>
    <xme:dUzhZHKRX3cLgqezx5P2CgtwfNzFzojKxOmVe3o13tiG4DCgPanXrZS3O1CSXk0cM
    ZyM7vzMVkA1bMsZK-U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudduiedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:dUzhZLux1Zi5xpS4iCD97tHjabzhI9G0FDo2K5c3WVlbJ1xD3dDhOQ>
    <xmx:dUzhZMYa8lfbuwQNZ31QQc8XW_2lKi_-jfHs6gVm3JGhdoK6kRxoKg>
    <xmx:dUzhZKYO75Qn0D2iw1RJooEoSom1tSj-PNdIlOspoRWfx4U6_GCtEQ>
    <xmx:dkzhZCoWf9xiWHn0WlPoS7_tyK_KM9JWHPGnMtwc2JJfcAyVrBqQfQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id F0FB0B60089; Sat, 19 Aug 2023 19:12:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-624-g7714e4406d-fm-20230801.001-g7714e440
Mime-Version: 1.0
Message-Id: <320be16c-32a2-4f34-9a30-e352f8203671@app.fastmail.com>
In-Reply-To: <20230704083022.692368-1-davidgow@google.com>
References: <20230704083022.692368-1-davidgow@google.com>
Date:   Sat, 19 Aug 2023 19:12:29 -0400
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "David Gow" <davidgow@google.com>,
        "Richard Weinberger" <richard@nod.at>,
        "Anton Ivanov" <anton.ivanov@cambridgegreys.com>,
        "Johannes Berg" <johannes@sipsolutions.net>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Noah Goldstein" <goldstein.w.n@gmail.com>
Cc:     linux-um@lists.infradead.org, x86@kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] asm-generic: current: Don't include thread-info.h if building
 asm
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 4, 2023, at 04:30, David Gow wrote:
> asm/current.h is included by some assembly files (either directly, or
> indirectly). This works on some architectures (such as x86), as their
> implementation of current.h is careful to not include any C, but the
> asm-generic version includes linux/thread-info.h unconditionally, which
> leads to errors when either C code or non-asm-compatible preprocessor
> directives are included.
>
> Just wrap the contents behind an #ifndef __ASSEMBLY__ to avoid any C
> code making its way in.
>
> Signed-off-by: David Gow <davidgow@google.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
