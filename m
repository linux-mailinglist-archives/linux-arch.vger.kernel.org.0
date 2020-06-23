Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A72E2049C5
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jun 2020 08:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730781AbgFWGUc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 Jun 2020 02:20:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:40346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730510AbgFWGUc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 23 Jun 2020 02:20:32 -0400
Received: from coco.lan (unknown [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FBF820720;
        Tue, 23 Jun 2020 06:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592893231;
        bh=Dxxtu9JejAl8IVsxWoK8TC+TGSvvbQrjHiwpR/3/1ng=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xiCNweWMDBrmlOdtr3Nz9fvmudwtUf8FgnWO/KvRuTdTH19r5jFz+kQpF36lfcser
         cGjqt1Bp/vRd6H0Z5ucCAY9GXYq40M/kagvXhXqUlCzblYYr6a1H17k0eL2yKBCTYj
         AT5TBqE+0uRB6svC2t1jX72L8GY5w7UANmpx/olQ=
Date:   Tue, 23 Jun 2020 08:20:26 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH 1/2] media: omap3isp: Remove cacheflush.h
Message-ID: <20200623082026.055d361a@coco.lan>
In-Reply-To: <20200622234740.72825-2-natechancellor@gmail.com>
References: <20200622234740.72825-1-natechancellor@gmail.com>
        <20200622234740.72825-2-natechancellor@gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Em Mon, 22 Jun 2020 16:47:39 -0700
Nathan Chancellor <natechancellor@gmail.com> escreveu:

> After mm.h was removed from the asm-generic version of cacheflush.h,
> s390 allyesconfig shows several warnings of the following nature:
> 
> In file included from ./arch/s390/include/generated/asm/cacheflush.h:1,
>                  from drivers/media/platform/omap3isp/isp.c:42:
> ./include/asm-generic/cacheflush.h:16:42: warning: 'struct mm_struct'
> declared inside parameter list will not be visible outside of this
> definition or declaration
> 
> As Geert and Laurent point out, this driver does not need this header in
> the two files that include it. Remove it so there are no warnings.
> 
> Fixes: e0cf615d725c ("asm-generic: don't include <linux/mm.h> in cacheflush.h")
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

> ---
>  drivers/media/platform/omap3isp/isp.c      | 2 --
>  drivers/media/platform/omap3isp/ispvideo.c | 1 -
>  2 files changed, 3 deletions(-)
> 
> diff --git a/drivers/media/platform/omap3isp/isp.c b/drivers/media/platform/omap3isp/isp.c
> index a4ee6b86663e..b91e472ee764 100644
> --- a/drivers/media/platform/omap3isp/isp.c
> +++ b/drivers/media/platform/omap3isp/isp.c
> @@ -39,8 +39,6 @@
>   *	Troy Laramy <t-laramy@ti.com>
>   */
>  
> -#include <asm/cacheflush.h>
> -
>  #include <linux/clk.h>
>  #include <linux/clkdev.h>
>  #include <linux/delay.h>
> diff --git a/drivers/media/platform/omap3isp/ispvideo.c b/drivers/media/platform/omap3isp/ispvideo.c
> index 10c214bd0903..1ac9aef70dff 100644
> --- a/drivers/media/platform/omap3isp/ispvideo.c
> +++ b/drivers/media/platform/omap3isp/ispvideo.c
> @@ -18,7 +18,6 @@
>  #include <linux/sched.h>
>  #include <linux/slab.h>
>  #include <linux/vmalloc.h>
> -#include <asm/cacheflush.h>
>  
>  #include <media/v4l2-dev.h>
>  #include <media/v4l2-ioctl.h>
> 
> base-commit: 27f11fea33608cbd321a97cbecfa2ef97dcc1821



Thanks,
Mauro
