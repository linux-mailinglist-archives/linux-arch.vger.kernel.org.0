Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94AA36F69F8
	for <lists+linux-arch@lfdr.de>; Thu,  4 May 2023 13:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjEDLba (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 May 2023 07:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjEDLb3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 May 2023 07:31:29 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2276B3C0F;
        Thu,  4 May 2023 04:31:28 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.31:55282.482502416
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.31])
        by 189.cn (HERMES) with SMTP id 40663100283;
        Thu,  4 May 2023 19:31:24 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-85667d6c59-6qwzn with ESMTP id 70d89bba14af4bc3806cb9bbf0733f71 for tzimmermann@suse.de;
        Thu, 04 May 2023 19:31:27 CST
X-Transaction-ID: 70d89bba14af4bc3806cb9bbf0733f71
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
Message-ID: <58d2bd17-3b51-bd24-2f30-d849d3f72b0e@189.cn>
Date:   Thu, 4 May 2023 19:31:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [v4,3/6] fbdev: Include <linux/io.h> in various drivers
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
        geert@linux-m68k.org, javierm@redhat.com, daniel@ffwll.ch,
        vgupta@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name,
        davem@davemloft.net, James.Bottomley@HansenPartnership.com,
        arnd@arndb.de, sam@ravnborg.org
Cc:     linux-arch@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-m68k@lists.linux-m68k.org, loongarch@lists.linux.dev,
        sparclinux@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20230504074539.8181-4-tzimmermann@suse.de>
From:   Sui Jingfeng <15330273260@189.cn>
In-Reply-To: <20230504074539.8181-4-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


Reviewed-by: Sui Jingfeng <suijingfeng@loongson.cn>


On 2023/5/4 15:45, Thomas Zimmermann wrote:
> The code uses writel() and similar I/O-memory helpers. Include
> the header file to get the declarations.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> ---
>   drivers/video/fbdev/arcfb.c       | 1 +
>   drivers/video/fbdev/aty/atyfb.h   | 2 ++
>   drivers/video/fbdev/wmt_ge_rops.c | 2 ++
>   3 files changed, 5 insertions(+)
>
> diff --git a/drivers/video/fbdev/arcfb.c b/drivers/video/fbdev/arcfb.c
> index 45e64016db32..d631d53f42ad 100644
> --- a/drivers/video/fbdev/arcfb.c
> +++ b/drivers/video/fbdev/arcfb.c
> @@ -41,6 +41,7 @@
>   #include <linux/vmalloc.h>
>   #include <linux/delay.h>
>   #include <linux/interrupt.h>
> +#include <linux/io.h>
>   #include <linux/fb.h>
>   #include <linux/init.h>
>   #include <linux/arcfb.h>
> diff --git a/drivers/video/fbdev/aty/atyfb.h b/drivers/video/fbdev/aty/atyfb.h
> index 465f55beb97f..30da3e82ed3c 100644
> --- a/drivers/video/fbdev/aty/atyfb.h
> +++ b/drivers/video/fbdev/aty/atyfb.h
> @@ -3,8 +3,10 @@
>    *  ATI Frame Buffer Device Driver Core Definitions
>    */
>   
> +#include <linux/io.h>
>   #include <linux/spinlock.h>
>   #include <linux/wait.h>
> +
>       /*
>        *  Elements of the hardware specific atyfb_par structure
>        */
> diff --git a/drivers/video/fbdev/wmt_ge_rops.c b/drivers/video/fbdev/wmt_ge_rops.c
> index 42255d27a1db..99c7b0aea615 100644
> --- a/drivers/video/fbdev/wmt_ge_rops.c
> +++ b/drivers/video/fbdev/wmt_ge_rops.c
> @@ -9,7 +9,9 @@
>   
>   #include <linux/module.h>
>   #include <linux/fb.h>
> +#include <linux/io.h>
>   #include <linux/platform_device.h>
> +
>   #include "core/fb_draw.h"
>   #include "wmt_ge_rops.h"
>   
