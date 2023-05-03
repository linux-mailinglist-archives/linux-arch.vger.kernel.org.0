Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77FEB6F5A9A
	for <lists+linux-arch@lfdr.de>; Wed,  3 May 2023 17:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjECPHF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 May 2023 11:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjECPHE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 May 2023 11:07:04 -0400
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F413A4C15;
        Wed,  3 May 2023 08:07:02 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.nyi.internal (Postfix) with ESMTP id D7C39580192;
        Wed,  3 May 2023 11:06:59 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 03 May 2023 11:06:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683126419; x=1683133619; bh=VJ
        t2NCaR1dSCR48usj7TiL9m0aFyTQB4ngpTHc/wzNQ=; b=fWJmhJIQIjPfE0lPmm
        2UUUsui9hK1EONioNtG6XwBvLEDBvBxWfFLQ9N1tFGkGwliU9yz6nObIhjKeToCC
        bOuSHwnPUFWVc1GvN6m/EdkHVQKkpb604IurKdO/9InTVd5vTzU5d2iVigisoIm9
        4gq2jLPIug5jHmpZc0rslk2Xj4l3SvhsCZPAjlEXGarhG7krdPhI3x8NitksJAfo
        tYDl+DHnKp88gZ0zrjylkyygbSAqCJ34r3G+WSX8xRpLvbG35Kxyh2gNtLoHTEbZ
        J9eceuXp5T7bkpNuwlU2Nn9ZVhzBpBEZ65RYAxta21HkybOMf+rDE6vuOkjpbFmd
        k70g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683126419; x=1683133619; bh=VJt2NCaR1dSCR
        48usj7TiL9m0aFyTQB4ngpTHc/wzNQ=; b=iwh/U6vLmswIa3ZMz2TyphQ0p3mxw
        /PfsOG0YBvIFJiK0YdJok8ez88E84BqeEydOwuMsHbERhRnQWa1jVmo9N6PU0wXj
        v1msIiMaTbFwQAVnj/LnGQHSHJ4VT2tvqtnNPzD3/1/sQnuUSFnWdyVEggJNwF3i
        GhqmBsRhzAf61JR15C0WdazOIg1Z9a9ASX/7rHQg8LseB6Ch/Fd+zJUxkqJZWliN
        A6mPn/RBrGbW1t7grbGpAiFDLa8+UOCaaegmxhtITsCQ/+nqhKZSDww627LKvrLR
        Akf6DAcnHjAniziM/oUzZ6HGvBtIvoek+KBdspGK9Usi69nxEi00tJLKg==
X-ME-Sender: <xms:kXhSZN-9H5s1bhLJ6A4BrSSA8u23bM9KPdG9aZBVi6Vx7ttWzwFj4g>
    <xme:kXhSZBtOpEQrvQSpGvqieF5mg9zfO9L78_hVsMKITr2FmH2UMwYQTD0RcbxdHK-LE
    fjd2wqoShzKWEE9HP8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedvkedgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:kXhSZLDbZTo8b8vLn4_1sIrA2TKPplauxliuy1lkEmJlepSP7t9PIw>
    <xmx:kXhSZBcW4sv-KQYA40dQFN8qx_vykn6TAKbj5-otIqOh7yBd6gwTfQ>
    <xmx:kXhSZCPWk3peePgjhptjqH3qDnIMxLup6tjVPNovu7IcIqvBdhS8MA>
    <xmx:k3hSZLyNTBeb8R9B8Rjvb47iNEFyVIScCzaPoMQcfpENafp15C45lQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 10509B60086; Wed,  3 May 2023 11:06:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-386-g2404815117-fm-20230425.001-g24048151
Mime-Version: 1.0
Message-Id: <2054ae6a-dcf9-42a3-9850-dd2587d40c58@app.fastmail.com>
In-Reply-To: <dd921bae-0145-09e2-24b1-f08d89a78eba@suse.de>
References: <20230502130223.14719-1-tzimmermann@suse.de>
 <20230502130223.14719-6-tzimmermann@suse.de>
 <67d6a188-041f-4604-99a3-548c41af0693@app.fastmail.com>
 <dd921bae-0145-09e2-24b1-f08d89a78eba@suse.de>
Date:   Wed, 03 May 2023 17:06:36 +0200
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
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 3, 2023, at 16:55, Thomas Zimmermann wrote:
> Am 02.05.23 um 22:06 schrieb Arnd Bergmann:

>> It's probably safe to deal with all the above by either adding
>> architecture specific overrides to the current version, or
>> by doing the semantic changes before the move to asm/fb.h, but
>> one way or the other I'd prefer this to be separate from the
>> consolidation patch that should not have any changes in behavior.
>
> I think I'll add architecture overrides that contain the current code, 
> even if they contain some force-casting wrt __iomem. If anyone wants to 
> fix the issues, they can then address them easily.

Ok, sounds good,

     Arnd
