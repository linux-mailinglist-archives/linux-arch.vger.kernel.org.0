Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC266F4ADF
	for <lists+linux-arch@lfdr.de>; Tue,  2 May 2023 22:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjEBUGn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 2 May 2023 16:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjEBUGm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 May 2023 16:06:42 -0400
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C10198C;
        Tue,  2 May 2023 13:06:37 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.west.internal (Postfix) with ESMTP id EB34B2B066FC;
        Tue,  2 May 2023 16:06:32 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 02 May 2023 16:06:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1683057992; x=1683065192; bh=5x
        TPMX3pv0srvr+ZsZiut6qJVZAYp0ChcBRbjNGHX30=; b=ZTvsHN9+uxpCL7FksS
        kwo3JrlnKSMBz/v6oovLN4gFfPuDwcis1zK1a7zX+U4EMCkEskzl8t9L3thdkkyp
        uYpHqLLEV8Y2/gwcUusIJLNIe8UPFQZDbvrgmfRa1pY2hBUtlVdJ/9XlRWissH8L
        RZUqWVGEZqc7kbQToz2df+wMKPzvJZz7OfH9fm/KKJfI4vdjYI50mKj4FFphTWtO
        15HBxbJh0hY7E5UW3e2N1yL6hg5QoeHpQ3aNrNchnn1WlChZDtrEj2EiD/5MCGDF
        40wwVa0xZ+AZ/o0IY+iQ3jM0Z1ruvVGOOHGjtm7BF+wspVkvTB48vtzziLBeW8k7
        q61A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683057992; x=1683065192; bh=5xTPMX3pv0srv
        r+ZsZiut6qJVZAYp0ChcBRbjNGHX30=; b=PU/7+KxYrASE8LNYfBiYFyUBHfHyC
        l+jhzmQBZAlBIO7EvQqNGSc1CmBFJf/RgZVQKMnPT5dOAs+EUf/U0nUYSNRtg8Co
        PzwAszRrzyl9Bj01mORZO8Iy7Pbm1Exx9HGDXLmQLfNT/EqHRH7kOp3xs314GtbL
        rDRPiHOPVfbZqPMsLcG97h9UMnWTdKQdNtHM+pCUcGCTFS7dUGxwWiyoQ7PfZ+3K
        9xLpTd1yhPC9o5H73dTxWPQtmoY+hZcnopHUvwXwz3kk7Z15u87rIiHztLfs24rT
        q53zbLCDTHvpwvaxqrctfu8Q4n4okdhysDgOXqX/nncLC5HQ0cdYfOtdA==
X-ME-Sender: <xms:R21RZMlQBaLMhGObVjBBPDKtv1QgEyEhRzx179kO5ggChyEPxTx0tQ>
    <xme:R21RZL0XGtLduJZvCo-pJW5VS-DW7npsNWdYiCxnKOUs_dT2K3sCLou3ehz-XykP_
    NnO0QGZDzR-VUm4l1M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedviedgudeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:R21RZKpBDKaqeHli7lfYc369Oa_vqRdwUIZba0FfKx21xYpELI9Nig>
    <xmx:R21RZIkd0u9WmHoox2AO07O0aYwAiw9yp1D8axvKmsMalWfC0g6YnQ>
    <xmx:R21RZK1tjycpPbv3cFlRKNc0IpX6pBZh8MoYB9AdqV7SOp0rhgOg0Q>
    <xmx:SG1RZD7KQd0sqq2OL80mg5nQwQw1Kh3gjL_wjLEfaQNvdLYFSTRtleJE-BU>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id ED568B60086; Tue,  2 May 2023 16:06:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-386-g2404815117-fm-20230425.001-g24048151
Mime-Version: 1.0
Message-Id: <67d6a188-041f-4604-99a3-548c41af0693@app.fastmail.com>
In-Reply-To: <20230502130223.14719-6-tzimmermann@suse.de>
References: <20230502130223.14719-1-tzimmermann@suse.de>
 <20230502130223.14719-6-tzimmermann@suse.de>
Date:   Tue, 02 May 2023 22:06:10 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Thomas Zimmermann" <tzimmermann@suse.de>,
        "Helge Deller" <deller@gmx.de>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Javier Martinez Canillas" <javierm@redhat.com>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        "Vineet Gupta" <vgupta@kernel.org>,
        "Huacai Chen" <chenhuacai@kernel.org>,
        "WANG Xuerui" <kernel@xen0n.name>,
        "David S . Miller" <davem@davemloft.net>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Sam Ravnborg" <sam@ravnborg.org>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, loongarch@lists.linux.dev,
        linux-m68k@lists.linux-m68k.org, sparclinux@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org
Subject: Re: [PATCH v3 5/6] fbdev: Move framebuffer I/O helpers into <asm/fb.h>
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 2, 2023, at 15:02, Thomas Zimmermann wrote:
> Implement framebuffer I/O helpers, such as fb_read*() and fb_write*(),
> in the architecture's <asm/fb.h> header file or the generic one.
>
> The common case has been the use of regular I/O functions, such as
> __raw_readb() or memset_io(). A few architectures used plain system-
> memory reads and writes. Sparc used helpers for its SBus.
>
> The architectures that used special cases provide the same code in
> their __raw_*() I/O helpers. So the patch replaces this code with the
> __raw_*() functions and moves it to <asm-generic/fb.h> for all
> architectures.
>
> v3:
> 	* implement all architectures with generic helpers
> 	* support reordering and native byte order (Geert, Arnd)

This looks good for the read/write helpers, but I'm a little
worried about the memset and memcpy functions, since they do
change behavior on some architectures:

- on sparc64, fb_mem{set,cpy} uses ASI_PHYS_BYPASS_EC_E (like __raw_readb)
  while mem{set_,cpy_from,cpy_to} uses ASI_PHYS_BYPASS_EC_E_L (like readb)
  I don't know the effect of that, but it seems intentional

- on loongarch and csky, the _io variants avoid unaligned access,
  while the normal memcpy/memset is probably broken, so your
  patch is a bugfix

- on ia64, the _io variants use bytewise access and avoid any longer
  loads and stores, so your patch probably makes things slower.

It's probably safe to deal with all the above by either adding
architecture specific overrides to the current version, or
by doing the semantic changes before the move to asm/fb.h, but
one way or the other I'd prefer this to be separate from the
consolidation patch that should not have any changes in behavior.

     Arnd
