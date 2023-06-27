Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C9073FFC8
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jun 2023 17:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjF0Pdt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Jun 2023 11:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjF0Pdt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Jun 2023 11:33:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3582978;
        Tue, 27 Jun 2023 08:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=OQge3nifXrNPOjpUkyjoaiLSJ4o64jeqktl/JSuxz0U=; b=BPNF9k7N6aO5rO/UVrPXpqzL5Q
        gWF+p3Y5CluA6eTNwIz2jHEsuV3FEksJTVmgCOJXuO+xWDKpZs4GkhH0gDefESDl1VFywYy6Cs+23
        6gehDy1cTa3np8BLG+MCB0uKtPTtpSq6OM2HL04+A9khAfacVpuGrGJ/YqIAvRxFDw7Xg/dR5NQ50
        YRkeK32Pj7XzYvcfBBJkXe/w2gioz8bOn4Wh7FpmuoHdisio/9vzdZGVjPOerKw2ADEJSzcRLO59p
        VLo9I3XsqlO4eo5KT3A9n5JBLBjxT4klDL3m8P5QfK/nii34IzNRHR4yG2I+octcAaMiPmgP+0oiK
        SvDiBuwA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qEAhB-00DX6t-1L;
        Tue, 27 Jun 2023 15:33:33 +0000
Message-ID: <afd7bccc-6a3f-6c43-1966-2fb9ff68a5e7@infradead.org>
Date:   Tue, 27 Jun 2023 08:33:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] arch/sparc: Add module license and description for fbdev
 helpers
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, davem@davemloft.net,
        arnd@arndb.de, linux@roeck-us.net, sam@ravnborg.org, deller@gmx.de
Cc:     sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20230627145843.31794-1-tzimmermann@suse.de>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230627145843.31794-1-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 6/27/23 07:58, Thomas Zimmermann wrote:
> Add MODULE_LICENSE() and MODULE_DESCRIPTION() for fbdev helpers
> on sparc. Fixes the following error:
> 
> ERROR: modpost: missing MODULE_LICENSE() in arch/sparc/video/fbdev.o
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Closes: https://lore.kernel.org/dri-devel/c525adc9-6623-4660-8718-e0c9311563b8@roeck-us.net/
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 4eec0b3048fc ("arch/sparc: Implement fb_is_primary_device() in source file")
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: sparclinux@vger.kernel.org
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  arch/sparc/video/fbdev.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/sparc/video/fbdev.c b/arch/sparc/video/fbdev.c
> index 25837f128132d..bff66dd1909a4 100644
> --- a/arch/sparc/video/fbdev.c
> +++ b/arch/sparc/video/fbdev.c
> @@ -21,3 +21,6 @@ int fb_is_primary_device(struct fb_info *info)
>  	return 0;
>  }
>  EXPORT_SYMBOL(fb_is_primary_device);
> +
> +MODULE_DESCRIPTION("Sparc fbdev helpers");
> +MODULE_LICENSE("GPL");

-- 
~Randy
