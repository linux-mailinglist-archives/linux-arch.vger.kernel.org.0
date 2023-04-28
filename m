Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBB26F190E
	for <lists+linux-arch@lfdr.de>; Fri, 28 Apr 2023 15:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346115AbjD1NNJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Apr 2023 09:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346210AbjD1NMy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Apr 2023 09:12:54 -0400
X-Greylist: delayed 336 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 28 Apr 2023 06:12:43 PDT
Received: from mailrelay2-1.pub.mailoutpod2-cph3.one.com (mailrelay2-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:401::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED51199D
        for <linux-arch@vger.kernel.org>; Fri, 28 Apr 2023 06:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=kmbigf8ZVmooEPRLcPWea0C5h/tG8tqKZ9j5z66PqBY=;
        b=eF1EsYiPJqXNskjn8lLNQ9+SL1ozu7DWmdUJ0wcEG54JzKFiSjRAPjbhy8H0+ZeYNmOBVGFyCGbxz
         1DqXAIXpm/M1j1pEPlF21UxeOY9nSl8/Iap7s1D3yCRgky5Tf80L/WY954alIRbLpoRtvZVhxcohcH
         gZD+6fQpR0DA7lwuphoh9i3Dd/maumGn+Tt03U+E+G1J826wfTSa+oaLhdKuvV7O3rOy6M3AH/bTVT
         eeFuoeTpNjqcA1avBxePv+IBiCUAGPqV57NpcpjKAT9+Yl5+7MpsaighKpk8/33r2f8BLL2Qa32pZL
         7l5szrsw+UlNB1/m+sTEJZXBaipCRvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=kmbigf8ZVmooEPRLcPWea0C5h/tG8tqKZ9j5z66PqBY=;
        b=4Jlvbtvr17/0MN2lAZB4KR0YNvraiUSF3TAKjdHVbDRCCaeKQbtDwZJbVZrTzY+ezyqRT4rd+YKPh
         HNdg4s7Ag==
X-HalOne-ID: 4f01baa5-e5c6-11ed-95e5-13111ccb208d
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay2 (Halon) with ESMTPSA
        id 4f01baa5-e5c6-11ed-95e5-13111ccb208d;
        Fri, 28 Apr 2023 13:12:23 +0000 (UTC)
Date:   Fri, 28 Apr 2023 15:12:21 +0200
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
Subject: Re: [PATCH v2 5/5] fbdev: Define framebuffer I/O from Linux' I/O
 functions
Message-ID: <20230428131221.GE3995435@ravnborg.org>
References: <20230428092711.406-1-tzimmermann@suse.de>
 <20230428092711.406-6-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428092711.406-6-tzimmermann@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Thomas,

On Fri, Apr 28, 2023 at 11:27:11AM +0200, Thomas Zimmermann wrote:
> Implement framebuffer I/O helpers, such as fb_read*() and fb_write*()
> with Linux' regular I/O functions. Remove all ifdef cases for the
> various architectures.
> 
> Most of the supported architectures use __raw_() I/O functions or treat
> framebuffer memory like regular memory. This is also implemented by the
> architectures' I/O function, so we can use them instead.
> 
> Sparc uses SBus to connect to framebuffer devices. It provides respective
> implementations of the framebuffer I/O helpers. The involved sbus_()
> I/O helpers map to the same code as Sparc's regular I/O functions. As
> with other platforms, we can use those instead.
> 
> We leave a TODO item to replace all fb_() functions with their regular
> I/O counterparts throughout the fbdev drivers.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  include/linux/fb.h | 63 +++++++++++-----------------------------------
>  1 file changed, 15 insertions(+), 48 deletions(-)
> 
> diff --git a/include/linux/fb.h b/include/linux/fb.h
> index 08cb47da71f8..4aa9e90edd17 100644
> --- a/include/linux/fb.h
> +++ b/include/linux/fb.h
> @@ -15,7 +15,6 @@
>  #include <linux/list.h>
>  #include <linux/backlight.h>
>  #include <linux/slab.h>
> -#include <asm/io.h>
>  
>  struct vm_area_struct;
>  struct fb_info;
> @@ -511,58 +510,26 @@ struct fb_info {
>   */
>  #define STUPID_ACCELF_TEXT_SHIT
>  
> -// This will go away
> -#if defined(__sparc__)
> -
> -/* We map all of our framebuffers such that big-endian accesses
> - * are what we want, so the following is sufficient.
> +/*
> + * TODO: Update fbdev drivers to call the I/O helpers directly and
> + *       remove the fb_() tokens.
>   */
When the __raw_* variants are used, as Geert points out, then I think
the memcpy / memset can be replaced, but the rest seems fine to keep.

My personal opinion is that __raw_* is for macro use etc, and not
something to use everywhere. So I like the fb_read/fb_write macros.
But that is just my color of the bikeshed.

	Sam
