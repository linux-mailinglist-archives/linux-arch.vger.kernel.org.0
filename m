Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 544716F18B3
	for <lists+linux-arch@lfdr.de>; Fri, 28 Apr 2023 15:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346113AbjD1NCo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Apr 2023 09:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjD1NCn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Apr 2023 09:02:43 -0400
Received: from mailrelay4-1.pub.mailoutpod2-cph3.one.com (mailrelay4-1.pub.mailoutpod2-cph3.one.com [46.30.211.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9CE1BE7
        for <linux-arch@vger.kernel.org>; Fri, 28 Apr 2023 06:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=HuayhvMNLZFfoE8myADqJK6FtKIr57X+86B8hGYQl2w=;
        b=SCpVSm5pBCpFNh1GPhNMzRfTOCZzKYGKhLHpLD+2ZTc79BM9sphzJXLP/eU5i49qwiXVdG3HmMVO2
         rJlPp/eQ+2P/0687zUr9U1bXmFWSrMuFImw+geVAS7iu89gHEm76IvwnGdvYSlAGB/0Kxexmu7J/dt
         n5fSk4fq6NS4Ksx5FPe1Al6xk8ePeQfNBjhJfPA2TD6MW+pf64Yv5A4zWhqyQ/FkRHsSwFg5LUo+D1
         z1kJx0y+Fv4gSrpYI9oyItlclXbhXUtkTwKrGHkGi93vco5wwETkCLKb+5aHbK76jqjIA1UeLlRmIo
         noD0H3DQUEN6q90007dlOgB/3PZkgUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=HuayhvMNLZFfoE8myADqJK6FtKIr57X+86B8hGYQl2w=;
        b=o571oP5bTkKtQAvnnX2JW1r4VqmjR5xfZ4ElG+d++wteJfV9kiMGihtD2n9iS3OnQnWMyStmAVDow
         ahuQyQYBg==
X-HalOne-ID: cdfc1691-e5c4-11ed-a696-592bb1efe9dc
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay4 (Halon) with ESMTPSA
        id cdfc1691-e5c4-11ed-a696-592bb1efe9dc;
        Fri, 28 Apr 2023 13:01:37 +0000 (UTC)
Date:   Fri, 28 Apr 2023 15:01:36 +0200
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
Subject: Re: [PATCH v2 3/5] fbdev: Include <linux/io.h> in various drivers
Message-ID: <20230428130136.GC3995435@ravnborg.org>
References: <20230428092711.406-1-tzimmermann@suse.de>
 <20230428092711.406-4-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428092711.406-4-tzimmermann@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Apr 28, 2023 at 11:27:09AM +0200, Thomas Zimmermann wrote:
> The code uses writel() and similar I/O-memory helpers. Include
> the header file to get the declarations.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> ---
>  drivers/video/fbdev/arcfb.c       | 1 +
>  drivers/video/fbdev/aty/atyfb.h   | 2 ++
>  drivers/video/fbdev/wmt_ge_rops.c | 2 ++
>  3 files changed, 5 insertions(+)
> 
> diff --git a/drivers/video/fbdev/arcfb.c b/drivers/video/fbdev/arcfb.c
> index 45e64016db32..d631d53f42ad 100644
> --- a/drivers/video/fbdev/arcfb.c
> +++ b/drivers/video/fbdev/arcfb.c
> @@ -41,6 +41,7 @@
>  #include <linux/vmalloc.h>
>  #include <linux/delay.h>
>  #include <linux/interrupt.h>
> +#include <linux/io.h>
>  #include <linux/fb.h>
>  #include <linux/init.h>
>  #include <linux/arcfb.h>
> diff --git a/drivers/video/fbdev/aty/atyfb.h b/drivers/video/fbdev/aty/atyfb.h
> index 465f55beb97f..30da3e82ed3c 100644
> --- a/drivers/video/fbdev/aty/atyfb.h
> +++ b/drivers/video/fbdev/aty/atyfb.h
> @@ -3,8 +3,10 @@
>   *  ATI Frame Buffer Device Driver Core Definitions
>   */
>  
> +#include <linux/io.h>
>  #include <linux/spinlock.h>
>  #include <linux/wait.h>
> +
>      /*
>       *  Elements of the hardware specific atyfb_par structure
>       */
> diff --git a/drivers/video/fbdev/wmt_ge_rops.c b/drivers/video/fbdev/wmt_ge_rops.c
> index 42255d27a1db..99c7b0aea615 100644
> --- a/drivers/video/fbdev/wmt_ge_rops.c
> +++ b/drivers/video/fbdev/wmt_ge_rops.c
> @@ -9,7 +9,9 @@
>  
>  #include <linux/module.h>
>  #include <linux/fb.h>
> +#include <linux/io.h>
>  #include <linux/platform_device.h>
> +
>  #include "core/fb_draw.h"
>  #include "wmt_ge_rops.h"
>  
> -- 
> 2.40.0
