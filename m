Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA136E4B01
	for <lists+linux-arch@lfdr.de>; Mon, 17 Apr 2023 16:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjDQOMj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Apr 2023 10:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbjDQOMh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Apr 2023 10:12:37 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FFA4C17;
        Mon, 17 Apr 2023 07:12:36 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 3CB715C0076;
        Mon, 17 Apr 2023 10:12:36 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 17 Apr 2023 10:12:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1681740756; x=1681827156; bh=rt
        mXUVStrgw6nKVv7ID95dfZD6+whmhR2sZpfAx2JC8=; b=cvpI950jylHNWGGxX3
        ffHYboh+iDIsBvhpEDw08gT0LYZ8oMMkcdcXDZVKzSkh8esFParV3MdHeic+dgn+
        kH0rbkdfurwqLl5v5uDyvgv2Zfru5aIsiX+9hVd4psY1p8GfC9rDavxuvI0+p+vV
        HopcxWe/RDLjKvGegghWwXZuxEWZTQL17wUgNwlbJVpWThS7jri3Bq5bz/+fBp8a
        C9ogLLe/DWQcOTqHQ3w2nVO8Jy28kXGWEQlTt1fhSgoUOE5X4sfausj36i66OtQq
        n+sFD0KYJ9gc9yFZJbxxbxucxrkLiwRn2Ike/DVt9GdSUl4cglZbI9zSDG53SEdY
        jt2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681740756; x=1681827156; bh=rtmXUVStrgw6n
        KVv7ID95dfZD6+whmhR2sZpfAx2JC8=; b=aD83kUhjQpSMNmNM/jNLZdKF7Z1Y9
        aAF8LixyaBK3Kb9Alnq4xfmtqhcmzQfzFzhW54TeND6tHtJ6DlFW0p7RY6giFVXL
        tf9egb1+THfNCfp2se+/8HsOhTd+4Sq7v2bWd17TyxcJ4+J4B0MofIb6m9cSZrEQ
        wzfIBj34Bfh2DUjI/GhTces0G4/SxB0KIBf+7D0zRQHMGkLcJ/1RMKY97H8eThSf
        aqCPgo8YFDSNijB+9gI6uSiAa1ep9EHgcG7rmPXjeQSNwIvQjZ+dOlNI9Q2dvc5A
        i2eHfsj9szgXcC+xocDDLHhNF3PDLhPslESBV1Jdy07DSiQsw8Vhd5Z+g==
X-ME-Sender: <xms:01M9ZLDvPtWAPmi3WXNzECAofp8SL7yIxzpWl6AAWPVMnFZITSexig>
    <xme:01M9ZBhKWjWONa2OiIi9-RqJwrx92V0sTYJWqtEZOVy0Lm4y32eWpPkSBIKJxwd9n
    z3hjS-kxClz5Wygqt8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeliedgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:01M9ZGl0g-tLHtvweyZxjzJgmeNqpttS9QZsz_hHc4GKSgFu8tXu5Q>
    <xmx:01M9ZNxSPgUXj44dwCEqX3eLnDK1yoDkjqmHV181SYugEkImQvHuiw>
    <xmx:01M9ZAS0DqGZ_SAOY1Oquyq7riLCXVeBCKulpduFz67EWr0UDhOBtg>
    <xmx:1FM9ZCFTyE9BhjDjf2qCzcWdgAa-x5jPF0aSST4sLwe56mYmcMZMXA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C62C0B60089; Mon, 17 Apr 2023 10:12:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-372-g43825cb665-fm-20230411.003-g43825cb6
Mime-Version: 1.0
Message-Id: <1641007d-7953-426a-a3de-ca9c90f6c5a9@app.fastmail.com>
In-Reply-To: <20230417125651.25126-1-tzimmermann@suse.de>
References: <20230417125651.25126-1-tzimmermann@suse.de>
Date:   Mon, 17 Apr 2023 16:12:15 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Thomas Zimmermann" <tzimmermann@suse.de>,
        "Daniel Vetter" <daniel.vetter@ffwll.ch>,
        "Helge Deller" <deller@gmx.de>,
        "Javier Martinez Canillas" <javierm@redhat.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     Linux-Arch <linux-arch@vger.kernel.org>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v3 00/19] arch: Consolidate <asm/fb.h>
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Apr 17, 2023, at 14:56, Thomas Zimmermann wrote:
> Various architectures provide <asm/fb.h> with helpers for fbdev
> framebuffer devices. Share the contained code where possible. There
> is already <asm-generic/fb.h>, which implements generic (as in
> 'empty') functions of the fbdev helpers. The header was added in
> commit aafe4dbed0bf ("asm-generic: add generic versions of common
> headers"), but never used.
>
> Each per-architecture header file declares and/or implements fbdev
> helpers and defines a preprocessor token for each. The generic
> header then provides the remaining helpers. It works like the I/O
> helpers in <asm/io.h>.

Looks all good to me,

Acked-by: Arnd Bergmann <arnd@arndb.de>

     Arnd
