Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92046D9B2B
	for <lists+linux-arch@lfdr.de>; Thu,  6 Apr 2023 16:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239208AbjDFOvl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Apr 2023 10:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjDFOv1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Apr 2023 10:51:27 -0400
X-Greylist: delayed 349 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 06 Apr 2023 07:50:51 PDT
Received: from wnew3-smtp.messagingengine.com (wnew3-smtp.messagingengine.com [64.147.123.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99956AD3C;
        Thu,  6 Apr 2023 07:50:51 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.west.internal (Postfix) with ESMTP id 888492B06973;
        Thu,  6 Apr 2023 10:44:17 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 06 Apr 2023 10:44:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1680792257; x=1680799457; bh=Va
        G4DIeiqknCp5VUw5TWbqr8Q6Xy/qs0760D+gB2/CE=; b=EWWMukw3BXb4Q/h2C/
        YS7dzTsU0Ar5/xROCa1/7bm3aePP1XNH9H2e8o71Ztok9LPbZQQCzO/hHG6ZPM1p
        GoCeoL832i+xKeNkS0KXU8c0WXOWNUN02App/G+QHK5CjSeDsvT54IC+UKLq5y0W
        7Bj0u+pXCcYRPzXBsUqe5DlmO1VzXH5ZTLEgPjdccmXA/6z2kb2GzEFUrIuyZoJL
        JE205jnLgaiETXL15uw4jCFU3tP+QRZn/8HvPxiftfXcO7a3UgEoiBimB5zsyODA
        rh1xpm67rsR3MA5GCAtJVR1sPuC6xq0Wqfo86Rjl+6m1rQKEicJ8/hOQkK2gfgKs
        SXRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680792257; x=1680799457; bh=VaG4DIeiqknCp
        5VUw5TWbqr8Q6Xy/qs0760D+gB2/CE=; b=rUv6i+tWNj90SnYvslS0D9SQvYEia
        hbth2DWbO6XoNOCPL0tQo0K5pGEzOxLlpTdzm9k/1tZklpQW57yikfYIpTuH0Oen
        FpzdiO+ssCVt7O1z6Q5P4IqYIp15PFvYkqBOqnKQnnSdL+YWBrv3O/8kPg6TB3Ty
        nP4AQs+RY8jkA8BD2EQMS9JAiQfaha8PDirIUX5DMjBpFPvO43av/mIe+ypzD/Mq
        rQI6lRY09fj7bETJ5kpUkImmWeeGn82AK+9+PegtKb4qJiuKwD1VSSkpLgKQq5Je
        QuhTYv5sbksq2vqZt7Ajex2obQmTZjZX/Zb5y96hPatPiMCd+y2OEMZZg==
X-ME-Sender: <xms:wNouZNHPa0TYmwB2r--5RtnOLRPAja0qtAEYACVjkTGVAgZvDkZu9w>
    <xme:wNouZCVePxlYaemLqrpfpWGxVOOM4y1dgc5cEsXgXvS0KUHqiJTJHrD2ayxERgDtu
    LARQW9FlguB3_hH47w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejfedgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:wdouZPKrDIYPd5_lNpIWwD1dm3PopYDH_mzSp_r4l6k3ItjXO9cK3g>
    <xmx:wdouZDEO3BmqQX8s9GpXZv_fvUkhsmGasqLZB0SmcMu_589oaCj0Kg>
    <xmx:wdouZDXV4YbtggYa_LRgP3NzenKzP1-bmca0EJqhagkOthPGPz6iNg>
    <xmx:wdouZKMF_xP1FnBqI73ZlUYXbIcQL6US9hEkrDdfk3w-HL8Jt1308E982bM>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E83EBB60093; Thu,  6 Apr 2023 10:44:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-334-g8c072af647-fm-20230330.001-g8c072af6
Mime-Version: 1.0
Message-Id: <27c1210f-4e40-4bbc-905b-155427465e00@app.fastmail.com>
In-Reply-To: <20230406143019.6709-3-tzimmermann@suse.de>
References: <20230406143019.6709-1-tzimmermann@suse.de>
 <20230406143019.6709-3-tzimmermann@suse.de>
Date:   Thu, 06 Apr 2023 16:43:56 +0200
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
        "Vineet Gupta" <vgupta@kernel.org>
Subject: Re: [PATCH v2 02/19] arch/arc: Implement <asm/fb.h> with generic helpers
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
> +
>  static inline void fb_pgprotect(struct file *file, struct vm_area_struct *vma,
>  				unsigned long off)
>  {
>  	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
>  }
> +#define fb_pgprotect fb_pgprotect

I still feel that for architectures like arc that don't have
pgprot_writecombine(), it would b best to go with the
generic implementation that currently behaves the exact
same way. If pgprot_writecombine() gets added in the future,
it would cause the architecture to behave as expected rather
than introducing the same bug that mips has.

      Arnd
