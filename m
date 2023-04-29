Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88CAE6F24FF
	for <lists+linux-arch@lfdr.de>; Sat, 29 Apr 2023 16:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjD2OLl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 29 Apr 2023 10:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjD2OLk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 29 Apr 2023 10:11:40 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A377198A;
        Sat, 29 Apr 2023 07:11:38 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 2DD955C00FB;
        Sat, 29 Apr 2023 10:11:36 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Sat, 29 Apr 2023 10:11:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1682777496; x=1682863896; bh=8d
        kHZ7/OLsjO2XUx8f1h6VDCdqS9HsgrgUgQPoekbMU=; b=Tt4hmIAKM+NNZGRbGy
        USiFmRb7ZQ7VESvUpDkvDC9rS9I/kjpxYoq4IidwwhIKTPcYD5vR6RqvLLGr+CaD
        1I9aUqlKLEp8YNzWVAXHUtUi2kVpAha/zdduG5raE+Wi0wvbUISzk2AadoiGxkiZ
        fZrZqC1pSn3Zxe1+KbPC8fVvKo3sFwMmI+khbEppmvaKW9CmFCgdX2QktEKQKG96
        0SC2oHRE3uFMLM/L3dVGCHbScyE7YVtM0HH4gQT9Mh2zq/OoF5XuXAM6yoLd/EIj
        ZLMzsUC3vaXLLJ6GGE7oLNpIHGXhuLTVOB66jjYD1eINb3WthQd7wDNhLD/+UKGq
        YWnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1682777496; x=1682863896; bh=8dkHZ7/OLsjO2
        XUx8f1h6VDCdqS9HsgrgUgQPoekbMU=; b=L+nvmAfj8gymGhB5xVReToYxjM6wj
        v8YL/JxVhiXT6yjB2/Yx5h/SGJAuFpH+LYE4mRnIgEwvZrwch6NpT/gSOm3PSm30
        bwzptyafMGf1520s8iYPvchCZ9FvC7zQx/AofzoW8CnPAm9cpnsX+tvIm8l6CBkt
        l6Yt2qTVsuFf+UtcSo0isg2MhJafTaqRhqjDh5e0bCdNSt6QOAH4NkSPUTzq6lqg
        IaNqSJFzzHT4wF8tk6iLVEl76ZIcQvAzUYcqtzZGN7wjqt4YIm/cBFu+jOkocHJJ
        6aUIjnMFtOd00CnQB01bWd1lVpHN1OGQkflEeBtWUxIcBUtPa00kswySw==
X-ME-Sender: <xms:lyVNZPz3z-p16274zMKpAKi5nlxUSJ7lk28d3S-Ob8c6-Zv8Bdk-Gw>
    <xme:lyVNZHQanz9SNk_GaqKBAu-Y-aPLh9z5YLE6AO4jRKX5HaqlB0s8ya2eyd2wC7WEQ
    j71iw5FIizBJSeFfXU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedvtddggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:lyVNZJXT0voWt151wzrxLt_t0PVcRbC_n0gzPllt-KSJgQjWEnhfPQ>
    <xmx:lyVNZJhgG76zOedSkzOp0As8nsjokHBAqvY3P4YbxzGMIvgrdkwY3A>
    <xmx:lyVNZBB11KK0qljfYMVgugmi1r0rm1svPDZhbgiqX_QChEeIGgbRGg>
    <xmx:mCVNZABxHV6GlowlDf3Y7NrFIlL86oq1NhGnPXRrsYfMgDf0xjmKGw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 00DD4B60086; Sat, 29 Apr 2023 10:11:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-374-g72c94f7a42-fm-20230417.001-g72c94f7a
Mime-Version: 1.0
Message-Id: <260ee591-a71b-4c83-a775-5591d4222cec@app.fastmail.com>
In-Reply-To: <df6fa134-3a62-0872-e008-393e4a29a5ab@suse.de>
References: <20230428092711.406-1-tzimmermann@suse.de>
 <20230428092711.406-6-tzimmermann@suse.de>
 <430c73f0-45f4-f81e-6506-bc8cc955d936@arm.com>
 <CAMuHMdUGjtiAR37L4_e0_p8ee2=gxoUj7+e7rqMLTBK+vpV4yw@mail.gmail.com>
 <f612c682-5767-4a58-82f6-f4a4d1b592a1@app.fastmail.com>
 <df6fa134-3a62-0872-e008-393e4a29a5ab@suse.de>
Date:   Sat, 29 Apr 2023 16:11:13 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Thomas Zimmermann" <tzimmermann@suse.de>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Robin Murphy" <robin.murphy@arm.com>
Cc:     "Helge Deller" <deller@gmx.de>,
        "Javier Martinez Canillas" <javierm@redhat.com>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        "Vineet Gupta" <vgupta@kernel.org>,
        "Huacai Chen" <chenhuacai@kernel.org>,
        "WANG Xuerui" <kernel@xen0n.name>,
        "David S . Miller" <davem@davemloft.net>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        "Sam Ravnborg" <sam@ravnborg.org>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, loongarch@lists.linux.dev,
        linux-m68k@lists.linux-m68k.org, sparclinux@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org
Subject: Re: [PATCH v2 5/5] fbdev: Define framebuffer I/O from Linux' I/O functions
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Apr 29, 2023, at 14:26, Thomas Zimmermann wrote:
> Am 28.04.23 um 15:17 schrieb Arnd Bergmann:
>> The only implementations in fbdev are
>> 
>>   1) sparc sbus
>>   2) __raw_writel
>>   3) direct pointer dereference
>> 
>> But none use the byte-swapping writel() implementations, and
>> the only ones that use the direct pointer dereference or sbus
>> are the ones on which these are defined the same as __raw_writel
>
> After thinking a bit more about the requirements, I'd like to got back 
> to v1, but with a different spin. We want to avoid ordering guarantees, 
> so I looked at the _relaxed() helpers, but they seem to swap bytes to 
> little endian.

Right, the _relaxed() oens are clearly wrong, aside from
the byteswap they also include barriers on some architectures
where the __raw_* version is more relaxed than the required
semantics for relaxed.

> I guess we can remove the fb_mem*() functions entirely. They are the 
> same as the non-fb_ counterparts.

These might actually be different in some cases, or sub-optimal
at the moment. memcpy()/memset() don't take __iomem pointers, so they
cause sparse warnings, while the memset_io()/memcpy_fromio()/
memcpy_toio() sometimes fall back to bytewise access that is slower
than word-sized copy. I only looked at the readl/writel style 
functions earlier, no idea what we want here.

> For the fb read/write helpers, I'd 
> like to add them to <asm-generic/fb.h> in a platform-neutral way. They'd 
> be wrappers around __raw_(), as I wouldn't want invocations of  __raw_() 
> functions in the fbdev drivers.

That sounds good to me.

     Arnd
