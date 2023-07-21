Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFAF75CC87
	for <lists+linux-arch@lfdr.de>; Fri, 21 Jul 2023 17:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbjGUPun (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Jul 2023 11:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbjGUPua (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Jul 2023 11:50:30 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9D93A9F;
        Fri, 21 Jul 2023 08:50:20 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id B987D3200991;
        Fri, 21 Jul 2023 11:50:17 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 21 Jul 2023 11:50:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1689954617; x=1690041017; bh=y5
        4uRtwGDGLZ7GqFD8k0STYKrRWoOfjzVI0Vx/9N7dk=; b=nmtvSspkC3uTez9C5F
        gHx6BkI71eZke/2pCOmXoo9R+nw834+h68niYapL2YcDYZTV7v4cwTRmyZcdXOcY
        KrQuqSGezKIqEhB4A6fStMmqm0v8xqhAh0mLAs0z0q//J0WnUfI0oVN2XbxIcZ/H
        hhDV76NAFZvzmI7D3oG2Br+pfFjDnbTtLO3TEaGkUhNWVndiZc3r/oAXR69KjxwY
        Jx2BZTyH1FxBVPsICvOAp+qZ0g4Sne3q2nZ574aC9G571kABlAT+sZGZzR3aXoyM
        20BEmVZmNL1WK2xtGN32J7On7Ox6AWbOsaVTRU0lAd6H8wBEoN9p3TJ7rNK9ycy8
        vHrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1689954617; x=1690041017; bh=y54uRtwGDGLZ7
        GqFD8k0STYKrRWoOfjzVI0Vx/9N7dk=; b=bGsTsXOCon+ZBCXtUCj/eDlR9j61u
        rHJIfPhr5/ybw5vUU9zKOEO/b//GxNqMOsco4UDG1G9RaYhSetOH1ano73x5qkIj
        cteH4C9VBo260gomlOkA9uIQppC9Yd0VTylUBNpvQI+VTuId6UClbiHnkcX6Epk7
        tDYgaptF6WWBKZPuk+yRz40MVcbaFg4GBO+5rTqeamdYzBXuUMoDeOX5fQkFiB4z
        bIKT2x7pF6kBCoTCFUZNUq5LZeLNDvZ1l66oF7l3PKh1naMmUxqpncZtWO732gaM
        CDsElA6lr8zbAklFstzeZc8xOL5gLDOC2ZhCRLIgWdDieUCPyulBC0oDw==
X-ME-Sender: <xms:Oam6ZBBX6io6V7cIVIQik9cm1u34HV5Z-hRCE5nDKB1fPVO6PqgMeg>
    <xme:Oam6ZPiNtTq1Vk5ngSAUhy-XGwwPN7YhGZLoTTyPljUqepsNMNU1pFBJ1aCP_nR_s
    rLi5fYTp3ERafCw_XQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrhedvgdekkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:Oam6ZMma2gQ28KGq2DnaCyR8KIJZ_Jw_ieq6NH5x9hHOB6L2QVd5CQ>
    <xmx:Oam6ZLzpU7wX92qUDFb0TMzqzbddSpNZN6fxUo5j_cf-P9ethYLNuQ>
    <xmx:Oam6ZGQxTVFWibPvd-XNNEmK70GRtPNYNJ2oHnAZK0yfstMITyO8oQ>
    <xmx:Oam6ZADgHZNctbChEFxSLf4tIv2Y2EWNf99CrGan2ATgDbEXUiGZ-Q>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 01364B6008D; Fri, 21 Jul 2023 11:50:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-531-gfdfa13a06d-fm-20230703.001-gfdfa13a0
Mime-Version: 1.0
Message-Id: <59ba1179-d166-4bae-b7b6-c1084471192e@app.fastmail.com>
In-Reply-To: <20230721102237.268073801@infradead.org>
References: <20230721102237.268073801@infradead.org>
Date:   Fri, 21 Jul 2023 17:49:56 +0200
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
Subject: Re: [PATCH v1 00/14] futex: More futex2 bits
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
> Hi,
>
> New version of the futex2 patches. These are actually tested and appear to work
> as expected.
>
> I'm hoping to get at least the first 3 patches merged such that Jens can base
> the io_uring futex patches on them.
>
>
> Changes since v0:
>  - switched over to 'unsigned long' for values (Arnd)
>  - unshare vmalloc_huge() (Willy)
>  - added wait/requeue syscalls
>  - fixed NUMA to support sparse nodemask
>  - added FUTEX2_n vs FUTEX2_NUMA check to ensure
>    the node_id fits in the futex
>  - added selftests
>  - fixed a ton of silly bugs

The changes look good to me, and the ABI should be fine without
special compat handler now. I sent a couple of minor comments, but
nothing important.

     Arnd
