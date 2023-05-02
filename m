Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B066F4AA2
	for <lists+linux-arch@lfdr.de>; Tue,  2 May 2023 21:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjEBTyi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 2 May 2023 15:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjEBTyi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 May 2023 15:54:38 -0400
Received: from mailrelay1-1.pub.mailoutpod2-cph3.one.com (mailrelay1-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:400::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA42019B3
        for <linux-arch@vger.kernel.org>; Tue,  2 May 2023 12:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=w8AYFc45O0NSET2uKXuZttSIHO5lI9T1X8bLU49ivoE=;
        b=kInIw482HDfm6bpoAz1sLMDMLP3rOIWNjuMerayf0RvX4o3BuEimQ3bxRyGbsxcPj19euojDP5y4e
         Z/JS3LV4PcZPRg4llnFz7WOs7qYBOlWL9Qf1JOf7n6zwdAYH4X7tMXg/6lWf4i+0yy8oczAga7SZVc
         BtQ/fUaOxi2SuFKuF3gv/SCPYAX4AKaifz3JHL7M4lvV31utXuXH890fO8n+9P8Ao0Mqy845bRh15e
         aA3ka1TvnQRm1gh6VorcOUp9qudNzF86fqTll2cC6eRr7owW+f28KAr5tMS3vAtLDHf4hmoBC9ITSv
         rzSnX266wUy3E2fdGJyKO9JjLxQLpkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=w8AYFc45O0NSET2uKXuZttSIHO5lI9T1X8bLU49ivoE=;
        b=C1LvBG55q+HMla4pI7wcdYeyi9TR37VaVBIFhPId1l2slSful+bcYpB9k+shRarpk0DSh6j/kaMLO
         A51lTJFCg==
X-HalOne-ID: 2612f7da-e923-11ed-94d1-99461c6a3fe8
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay1 (Halon) with ESMTPSA
        id 2612f7da-e923-11ed-94d1-99461c6a3fe8;
        Tue, 02 May 2023 19:54:30 +0000 (UTC)
Date:   Tue, 2 May 2023 21:54:29 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     deller@gmx.de, geert@linux-m68k.org, javierm@redhat.com,
        daniel@ffwll.ch, vgupta@kernel.org, chenhuacai@kernel.org,
        kernel@xen0n.name, davem@davemloft.net,
        James.Bottomley@hansenpartnership.com, arnd@arndb.de,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arch@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-parisc@vger.kernel.org
Subject: Re: [PATCH v3 4/6] fbdev: Include <linux/io.h> via <asm/fb.h>
Message-ID: <20230502195429.GA319489@ravnborg.org>
References: <20230502130223.14719-1-tzimmermann@suse.de>
 <20230502130223.14719-5-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230502130223.14719-5-tzimmermann@suse.de>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Thomas,

On Tue, May 02, 2023 at 03:02:21PM +0200, Thomas Zimmermann wrote:
> Fbdev's main header file, <linux/fb.h>, includes <asm/io.h> to get
> declarations for I/O helper functions. From these declarations, it
> later defines framebuffer I/O helpers, such as fb_{read,write}[bwlq]()
> or fb_memset().
> 
> The framebuffer I/O helpers depend on the system architecture and
> will therefore be moved into <asm/fb.h>. Prepare this change by first
> adding an include statement for <linux/io.h> to <asm-generic/fb.h>.
> Include <asm/fb.h> in all source files that use the framebuffer I/O
> helpers, so that they still get the necessary I/O functions.
> 
...
> 
> diff --git a/drivers/video/fbdev/arkfb.c b/drivers/video/fbdev/arkfb.c
> index 60a96fdb5dd8..fd38e8a073b8 100644
> --- a/drivers/video/fbdev/arkfb.c
> +++ b/drivers/video/fbdev/arkfb.c
> @@ -27,6 +27,8 @@
>  #include <linux/console.h> /* Why should fb driver call console functions? because console_lock() */
>  #include <video/vga.h>
>  
> +#include <asm/fb.h>

When we have a header like linux/fb.h - it is my understanding that it is
preferred to include that file, and not the asm/fb.h variant.

This is assuming the linux/fb.h contains the generic stuff, and includes
asm/fb.h for the architecture specific parts.

So drivers will include linux/fb.h and then they automatically get the
architecture specific parts from asm/fb.h.

In other words, drivers are not supposed to include asm/fb.h, if
linux.fb.h exists - and linux/fb.h shall include the asm/fb.h.

If the above holds true, then it is wrong and not needed to add asm/fb.h
as seen above.


There are countless examples where the above are not followed,
but to my best understanding the above it the preferred way to do it.

	Sam
