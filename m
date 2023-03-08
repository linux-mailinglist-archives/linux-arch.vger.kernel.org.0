Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8C36B13F1
	for <lists+linux-arch@lfdr.de>; Wed,  8 Mar 2023 22:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjCHVfZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Mar 2023 16:35:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjCHVfY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Mar 2023 16:35:24 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D4192704;
        Wed,  8 Mar 2023 13:35:22 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id E12FF3200893;
        Wed,  8 Mar 2023 16:35:19 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 08 Mar 2023 16:35:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1678311319; x=1678397719; bh=3M
        jqPl34s3Z0DxZ95SEFHFqhYpQWxX80N5mapvV1olM=; b=D774f+OS+fX5cAxotv
        20JQC+4otb0th+n+4wcvY86S9jjTZNvssk8H7nRHmyjPe4Vjo0k3YaDiBMy+ENys
        YGGJ3tZjpUPLC7PUUffVBNxV6x6MAxzPKKHnTR5S2t5aqmF4sNV4tz6hp1zRT+Yh
        Q8it4dbcSs4+IlWVwQ9oGYRGAE97Sgfrf9z7PzbPUu9wy3PChkGK2jTsVBcxC7tk
        XL2BhUX64Gx4UKBPeo6/nbq11cQiAt038aJrc3RzbhXKh99kLsVyGOBlxx3IfKEl
        W+6QZ+6eIeZLMbbBPlqH0WbJ2DPsnLGmwdfkRZtF6l9dveKucmQaY1izxNhB2Ud6
        n6EQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1678311319; x=1678397719; bh=3MjqPl34s3Z0D
        xZ95SEFHFqhYpQWxX80N5mapvV1olM=; b=sU2i1B0PgZASHrK4oSqIjXMY3C6oJ
        juI6YpQbT1VDN7wtHTd2UeNclaos9/UVOJ+0BwrYgAd53flvOSkx2BxBGcvdTC3L
        c/oOK9/xCMowr2YbfJYsGiOX3G/6l8lSih09mIylvGaFNzQgXemVXDgPNrt2X1i5
        7atX89gN4zeQr4dAIecquhLSWcZvhNCd9dl/L3ZwP54STLon5z7EJ98fd45SKjJm
        BHNlvwY+c6LNw7eGA/p50N8j6WfI0Nf1eXM41Qd72dbnVywzFoCRUAZE/BUdHC8k
        uXgODE2UuNX0yHH01KRVIQCRi9d4uwI8sU6NPNwWfFuvY4YbtzXu9Q8xg==
X-ME-Sender: <xms:lv8IZA1tOXVUQtPtleY3hiQBxGCr9d_Rncr1hKFCXmzX9rkApbr5Gg>
    <xme:lv8IZLE4X5dazOcpmAEjnWQQ12zoXkvla3hMKkD5D9_Sb8lhGF-lWgr1YmHj2eXbu
    agfmBE7YlsKm_3VBXA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddufedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:lv8IZI6BBrkUHOLA1QEcbacVbVjAjvlIAsorK8j0FRdA247ZoPUOPQ>
    <xmx:lv8IZJ0p9ndc4Nnaz6oY5NyU1R6evB7bhMb6sGhV-ib_sNHTxPwzPQ>
    <xmx:lv8IZDGKMvxaB1nXpOGabWk-dlUyt4u00ekcK8gAZ23ub8bzyKq-rw>
    <xmx:l_8IZL8KhPzeLvgFCsinpmEYV8ANhzIXWP7nmGrmqfONml54WtP77w>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4524AB60086; Wed,  8 Mar 2023 16:35:18 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-206-g57c8fdedf8-fm-20230227.001-g57c8fded
Mime-Version: 1.0
Message-Id: <74915109-446a-4c1f-91bc-95dc6e3be200@app.fastmail.com>
In-Reply-To: <ZAjphWYHDoDw9sQS@bombadil.infradead.org>
References: <20230308130710.368085-1-bhe@redhat.com>
 <20230308130710.368085-2-bhe@redhat.com>
 <ZAjphWYHDoDw9sQS@bombadil.infradead.org>
Date:   Wed, 08 Mar 2023 22:34:57 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Luis Chamberlain" <mcgrof@kernel.org>,
        "Baoquan He" <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>, linux-mm@kvack.org,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Helge Deller" <deller@gmx.de>,
        "Thomas Zimmermann" <tzimmermann@suse.de>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v4 1/4] video: fbdev: atyfb: only use ioremap_uc() on i386 and ia64
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

0On Wed, Mar 8, 2023, at 21:01, Luis Chamberlain wrote:
> On Wed, Mar 08, 2023 at 09:07:07PM +0800, Baoquan He wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> ioremap_uc() is only meaningful on old x86-32 systems with the PAT
>> extension, and on ia64 with its slightly unconventional ioremap()
>> behavior, everywhere else this is the same as ioremap() anyway.
>> 
>> Change the only driver that still references ioremap_uc() to only do so
>> on x86-32/ia64 in order to allow removing that interface at some
>> point in the future for the other architectures.
>> 
>> On some architectures, ioremap_uc() just returns NULL, changing
>> the driver to call ioremap() means that they now have a chance
>> of working correctly.
>> 
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Baoquan He <bhe@redhat.com>
>> Cc: Helge Deller <deller@gmx.de>
>> Cc: Thomas Zimmermann <tzimmermann@suse.de>
>> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
>> Cc: linux-fbdev@vger.kernel.org
>> Cc: dri-devel@lists.freedesktop.org
>
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
>
> Is anyone using this driver these days? How often do fbdev drivers get
> audited to see what can be nuked?

Geert already mentioned that this one is likely used on old
powermac systems. I think my arm boardfile removal orphaned
some other fbdev drivers though. I removed the ones that can
no longer be enabled, but think a bunch of other ones
are still selectable but have no platform_device definition
or DT support: FB_PXA168, FB_DA8XX, FB_MX3, and MMP_FB.

These four platforms are all still supported with DT, but
over time it gets less likely that anyone is still interested
in adding DT support to the fbdev drivers.

    Arnd
