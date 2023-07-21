Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 848D975CC5D
	for <lists+linux-arch@lfdr.de>; Fri, 21 Jul 2023 17:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbjGUPsA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Jul 2023 11:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232260AbjGUPr4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Jul 2023 11:47:56 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1756C10C3;
        Fri, 21 Jul 2023 08:47:55 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 3C0F13200991;
        Fri, 21 Jul 2023 11:47:53 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 21 Jul 2023 11:47:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1689954472; x=1690040872; bh=Bv
        QYir1TgtFJ0697wOUYpEwh4jkIy8qXO/mCyyCNVlQ=; b=ZFzNJsmblah8v7+tzm
        pvg9g9dqG78Pn972Bj1F9+KdCSDjD3uCQRDbYndZTShRtg30fkvYoGTX8P5lCB46
        amLI52y80joBeKH6pyCgpfjdaq0xPRw7e2W30qv4Ij55F8YeiOKSnasFJW4MGuCv
        oTnQkGeeoPWcGXdS6GihL2mTvgvJSb14frr/X8stZ0DZyj/x5Th5eWypwQN+RyFN
        FqUrhyyKa672B3D4H3rqyaXoXIhaeatnIHVcWCGuIjuiGm+yEoB+LnolbrxCrt+J
        /Ludj38mG9YTSkcsHT57dP3tMIP0UAiU4rfPIvFGZOXOhHdoVedfDlqiz4gV5QXV
        7oSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1689954472; x=1690040872; bh=BvQYir1TgtFJ0
        697wOUYpEwh4jkIy8qXO/mCyyCNVlQ=; b=2cpUgxQHdTe/oGeCxgK/z1dXdvf0r
        nI+DJk6sCYQkGXyawb5ZLMqaVBDvd4ux5LwWHEfbwULXqJQOK/cseoRhc0eTTMF2
        32Xr6K7VYAMBkTdtPFBSrsYOpL/hbhOrAmtx24BYkby0b6gGWl7MKFPBhcmFF6gb
        E0PP4klBMjk6e8WkGZ7Kcrn2Y5sncq/JzkKLFAfOdAvw+xGfY5MQY/OWYlfTV5Vp
        Xa+gvtB4HtjIu/zx1jkyCKHkuVsAYxsZ7XS9WXxDBP3r0FL8OWf4zt/nreHyPMaf
        fxo5yvljEbV0XiZpxIdaT26boEgMjEzY0XDt+pTEl7bCgHSGoIrz7xkPA==
X-ME-Sender: <xms:qKi6ZO-jxfly8qW6kFEU9JH9FrMa5Z-nf7jOh5A50xabFGNht8Wv1g>
    <xme:qKi6ZOuiuZR8Q6zB1ULRn_aG3zzK1gT8J6gH07juS1u6zIuZ3eOXvT98DQHFhkPXx
    NeRBnAuuVjt7KoR4ko>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrhedvgdekkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:qKi6ZEDYbQ3ZaQqvLfmVOn5-x8ABZ0E_blMq66LZK6KoTAaU25ZdfQ>
    <xmx:qKi6ZGf_8Yf3u8ntgFwnARHozfhSue9QNtQh5gB1P6gDmRFo6NbW5w>
    <xmx:qKi6ZDMNuE7QKBHLnpF2bQd6vMsFGXVewYMVM0s4t80b7Rj1GvTE8g>
    <xmx:qKi6ZBvSi12HgiCr0t7VlhHhAaI6RR7tLTcdE1Q0eW4A6cyfbfuQbA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 297B9B60089; Fri, 21 Jul 2023 11:47:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-531-gfdfa13a06d-fm-20230703.001-gfdfa13a0
Mime-Version: 1.0
Message-Id: <6a49b585-05d0-4b79-b5ab-d710f5d6d598@app.fastmail.com>
In-Reply-To: <20230721105743.819362688@infradead.org>
References: <20230721102237.268073801@infradead.org>
 <20230721105743.819362688@infradead.org>
Date:   Fri, 21 Jul 2023 17:47:31 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Peter Zijlstra" <peterz@infradead.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Jens Axboe" <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, "Ingo Molnar" <mingo@redhat.com>,
        "Darren Hart" <dvhart@infradead.org>, dave@stgolabs.net,
        andrealmeid@igalia.com,
        "Andrew Morton" <akpm@linux-foundation.org>, urezki@gmail.com,
        "Christoph Hellwig" <hch@infradead.org>,
        "Lorenzo Stoakes" <lstoakes@gmail.com>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, Linux-Arch <linux-arch@vger.kernel.org>,
        malteskarupke@web.de
Subject: Re: [PATCH v1 02/14] futex: Extend the FUTEX2 flags
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 21, 2023, at 12:22, Peter Zijlstra wrote:
>   * futex_parse_waitv - Parse a waitv array from userspace
> @@ -207,7 +207,12 @@ static int futex_parse_waitv(struct fute
>  		if ((aux.flags & ~FUTEX2_MASK) || aux.__reserved)
>  			return -EINVAL;
> 
> -		if (!(aux.flags & FUTEX2_32))
> +		if (!IS_ENABLED(CONFIG_64BIT) || in_compat_syscall()) {
> +			if ((aux.flags & FUTEX2_64) == FUTEX2_64)
> +				return -EINVAL;
> +		}
> +
> +		if ((aux.flags & FUTEX2_64) != FUTEX2_32)
>  			return -EINVAL;

This looks slightly confusing, how about defining another
FUTEX2_SIZEMASK (or similar) macro to clarify that
"aux.flags & FUTEX2_64" is a mask operation that can
match the FUTEX2_{8,16,32,64} values?

       Arnd
