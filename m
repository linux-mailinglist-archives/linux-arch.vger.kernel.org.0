Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203AE7A87E0
	for <lists+linux-arch@lfdr.de>; Wed, 20 Sep 2023 17:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235393AbjITPHT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Sep 2023 11:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235264AbjITPHS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Sep 2023 11:07:18 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A719AF;
        Wed, 20 Sep 2023 08:07:12 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id DE07F5C01BB;
        Wed, 20 Sep 2023 11:07:08 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 20 Sep 2023 11:07:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1695222428; x=1695308828; bh=ms
        4LUioRCx9g5Fcd6Nj2Z553BmfY/nfNy++/9p0eMTE=; b=BHuLRfyyuipWu6am6/
        M3C5KuEVtPRgHdnUSWE2tXf1NF5z/c0HjnG1qXb1WaGZu8Uq7k1Lq5DXx3SfUhLJ
        +AGNDQ0Gvdy1xUAqZGHxFG0dPweDd4IWaDHtLa1Ju8frSZGFQNlRlxX/YTmR+QTm
        FrxvvQHeQGOAH4tKQgxAP8/n/XDBfPur4ivYpz7AqfbRaoZFC/0DB/LRt6ogTvDK
        ibhf89hk7VyhvpN4sS3aoNoWA5NNg9KqAE+6NjLPwBok0RZB1mJOs3iV6MFt/MH4
        Dtvydol1NjIVeiH0yas9c7mbU50veoZbaGHU9IbQP2FByO/vbbLSQKTuw+/nHr+K
        WV2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1695222428; x=1695308828; bh=ms4LUioRCx9g5
        Fcd6Nj2Z553BmfY/nfNy++/9p0eMTE=; b=qgZHhiyUGnQdiRx/usTNHt32rPNJr
        9B5WYZMfGf4Wh7FyO6A52lomoJ9ynn4fijFhbL1uXxQvXbZqDqwI3RtNixlUDdBY
        nr7g83/UKByMv2jpbfoqr0MMhEyLeVl4HTvngpxiAH2TNzYOuQTYsysj+12PQUhh
        NfZeCSd5kQ2vll+YcV+q/+APQLD6yBY/5mJ6KzJ/VXaqAf54B8D5OfAW8ja+q4S8
        OwObw1sDeIiXVgJxGcmw5NakTXzLLouS4lIeLJo/w8h5AT4kacfRuTF+izO/lkmJ
        F56Yyuk075kXqXJcxdmlOPxlIIi+Xm++i+2jPz5jH6sqj1NLjf7H1eCog==
X-ME-Sender: <xms:nAoLZYwrTKoT42bcnpXZ4-w53D73C76DbJIuYsMLzYvbbB86qR_ffQ>
    <xme:nAoLZcRulMbaUjUAhbE-QFya1Gxyi5QzCzhATtS7FolBRFqxN9c07Aga3yV4Qoxiq
    eWbYSyImVFth6dskDE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekfedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:nAoLZaWZx_TRLb7BjvQU3lpTtrt3jJpa0avXJjdRrHX-EzABxErB_A>
    <xmx:nAoLZWgVBoycMfqp10qcSIzofTqfa999ofexvDZjpX2k4ORya7JL9g>
    <xmx:nAoLZaBR9j0jFMUdPxCKTuDNgoxms16P9lFOofBz07ktzPmbvA4Yng>
    <xmx:nAoLZe6LFDULF3sZ_R6NM9MvFBnTENxcVdrZ0bbn_jFL0BMhje4eJA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id EC7C5B60089; Wed, 20 Sep 2023 11:07:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-761-gece9e40c48-fm-20230913.001-gece9e40c
MIME-Version: 1.0
Message-Id: <df784a58-23f8-43d2-8506-ab1d351da8fe@app.fastmail.com>
In-Reply-To: <20230912135050.17155-1-tzimmermann@suse.de>
References: <20230912135050.17155-1-tzimmermann@suse.de>
Date:   Wed, 20 Sep 2023 11:06:48 -0400
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Thomas Zimmermann" <tzimmermann@suse.de>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        "Nicholas Piggin" <npiggin@gmail.com>,
        "Christophe Leroy" <christophe.leroy@csgroup.eu>,
        "Helge Deller" <deller@gmx.de>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-fbdev@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, sparclinux@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v4 0/5] ppc, fbdev: Clean up fbdev mmap helper
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 12, 2023, at 09:48, Thomas Zimmermann wrote:
> Clean up and rename fb_pgprotect() to work without struct file. Then
> refactor the implementation for PowerPC. This change has been discussed
> at [1] in the context of refactoring fbdev's mmap code.
>
> The first two patches update fbdev and replace fbdev's fb_pgprotect()
> with pgprot_framebuffer() on all architectures. The new helper's stream-
> lined interface enables more refactoring within fbdev's mmap
> implementation.
>
> Patches 3 to 5 adapt PowerPC's internal interfaces to provide
> phys_mem_access_prot() that works without struct file. Neither the
> architecture code or fbdev helpers need the parameter.
>
> v4:
> 	* fix commit message (Christophe)
> v3:
> 	* rename fb_pgrotect() to pgprot_framebuffer() (Arnd)

I had another look today, and everything look good to me now.

Whole series

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
