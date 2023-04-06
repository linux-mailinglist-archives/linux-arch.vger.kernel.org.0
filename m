Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160E36D9B40
	for <lists+linux-arch@lfdr.de>; Thu,  6 Apr 2023 16:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239546AbjDFOwz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Apr 2023 10:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239203AbjDFOwb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Apr 2023 10:52:31 -0400
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA0793CB;
        Thu,  6 Apr 2023 07:51:38 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.west.internal (Postfix) with ESMTP id C99D82B06973;
        Thu,  6 Apr 2023 10:51:35 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 06 Apr 2023 10:51:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1680792695; x=1680799895; bh=Pv
        VeZJF1LUSrqLOZVN7G2amPFlD1uKLgk4hVw/5gFkk=; b=SAvTW0KPiUiO6nJkgF
        hXZ6OppFeDIVldU5nH5Nk87ZkoYm0QSz5etEIyB9L3eiPRe38qOn7Yay2vgGarg1
        5sJwAO+fTphyJMnizGXGMZA7MS5VH44wwWkJ1MrHruWcMBzAdQsbwr/HG8Ar2/6h
        ssfgDaEh1nygQh/jhR37h09WkE3hI3ETItSeiXNozl3KXDBURktHhmDVxZ7Wdzy/
        n7mzlrgcvLLYYl4GB0Jixsnnu33HHsW0S8bOvegaRFpXUzyUpg1Wrf+HHQe3JHm6
        yvJTSISUw4ZJyAl6RHWKH0+KTevm+bV6eZ5nm+FcceTSwKUlPuUP8ZQUE6Rf/952
        Fm7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680792695; x=1680799895; bh=PvVeZJF1LUSrq
        LOZVN7G2amPFlD1uKLgk4hVw/5gFkk=; b=JPS0WnF6RsH6+Xmuz649TIwf6ULqn
        iR7dqMhGcWUzrcWDkP1wJOBg+pHwmqt0HjkWV3uYIx/iYEHGdo34iUw0sMt7lXAF
        TCiFGvS91OUTZmU8mGXL1ZAIYc+2wcAVLuiGns+9hZ9Q3u+wIDdzJwLYP/GBb0jY
        PipBM8nu/zuG+9luvqZ8Jihpwj/glGEHTGAsmTUO/OhJ+2KiMp2ZX3fbsikDkl9X
        CYmcVn5Qz5pgqlithu+GeIWG615/DhpktzMk+iHq+vbMD1i48CEcdpePaPEsYSg+
        /NqG6gY4RjzahVDTu3l6p6nPXr1gPCO41q3EMcyeoONEMlvZajqF4chSg==
X-ME-Sender: <xms:dtwuZISp_urJ8m5y_mrgBVrKzfVtV7jyqafaPhhnLlaMLrxVu-zOdQ>
    <xme:dtwuZFzhYOAHcjhP_UJhiFjuMOrAhWGolGLd007OLGuh7HLcDq44kr2pBY-nRsouX
    s_u4XRoQiKraC7XyvE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejfedgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:dtwuZF306BOOE6te4r8pL4BLeM6iLePYsvNvQT3RmqPvhsiPWIJBkw>
    <xmx:dtwuZMAFW_bz-t7uH1fIUNzgL7C4poUL5vgpabFNXqjqsotT3NYUJg>
    <xmx:dtwuZBi3L7XVmnFUihWDoER0dw0JdG93uknsbqbi8fYB_9UR12Cn-w>
    <xmx:d9wuZKZ3_VssJzan2b5oOIi7ZSLdwGBHtiVEVQK6f1B3PNR-RJRUt7wGRy0>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D73D5B6009B; Thu,  6 Apr 2023 10:51:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-334-g8c072af647-fm-20230330.001-g8c072af6
Mime-Version: 1.0
Message-Id: <cfa36e9a-7e19-4c43-b9b4-1ae4f9ef51c3@app.fastmail.com>
In-Reply-To: <20230406143019.6709-10-tzimmermann@suse.de>
References: <20230406143019.6709-1-tzimmermann@suse.de>
 <20230406143019.6709-10-tzimmermann@suse.de>
Date:   Thu, 06 Apr 2023 16:51:14 +0200
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
        sparclinux@vger.kernel.org, x86@kernel.org,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>
Subject: Re: [PATCH v2 09/19] arch/mips: Implement <asm/fb.h> with generic helpers
Content-Type: text/plain
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 6, 2023, at 16:30, Thomas Zimmermann wrote:
> Replace the architecture's fb_is_primary_device() with the generic
> one from <asm-generic/fb.h>. No functional changes.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

I think you should at least mention that the existing
fb_pgprotect() function is probably incorrect and should
be replaced with the generic version.

For reference, the fb_pgprotect function using pgprot_uncached()
was introduced in 2.6.22 along with all the other ones, but
the pgprot_writecombine function was only added in commit
4b050ba7a66c ("MIPS: pgtable.h: Implement the pgprot_writecombine
function for MIPS") for 3.18.

     Arnd
