Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A49F6F69F3
	for <lists+linux-arch@lfdr.de>; Thu,  4 May 2023 13:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjEDLan (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 May 2023 07:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjEDLab (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 May 2023 07:30:31 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BBB373C0F;
        Thu,  4 May 2023 04:30:30 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.31:56734.294361253
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.31])
        by 189.cn (HERMES) with SMTP id 3F9DF10021A;
        Thu,  4 May 2023 19:25:47 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-85667d6c59-6qwzn with ESMTP id 9f667beeb43d4e3781deb21ab0482b44 for tzimmermann@suse.de;
        Thu, 04 May 2023 19:25:50 CST
X-Transaction-ID: 9f667beeb43d4e3781deb21ab0482b44
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
Message-ID: <8feb341c-fafa-9ca2-4522-fc907aebb0f1@189.cn>
Date:   Thu, 4 May 2023 19:25:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [v4,1/6] fbdev/matrox: Remove trailing whitespaces
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
References: <20230504074539.8181-2-tzimmermann@suse.de>
From:   Sui Jingfeng <15330273260@189.cn>
In-Reply-To: <20230504074539.8181-2-tzimmermann@suse.de>
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

Tested-by: Sui Jingfeng <suijingfeng@loongson.cn>


On 2023/5/4 15:45, Thomas Zimmermann wrote:
> Fix coding style. No functional changes.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> ---
>   drivers/video/fbdev/matrox/matroxfb_accel.c | 6 +++---
>   drivers/video/fbdev/matrox/matroxfb_base.h  | 4 ++--
>   2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/video/fbdev/matrox/matroxfb_accel.c b/drivers/video/fbdev/matrox/matroxfb_accel.c
> index 9cb0685feddd..ce51227798a1 100644
> --- a/drivers/video/fbdev/matrox/matroxfb_accel.c
> +++ b/drivers/video/fbdev/matrox/matroxfb_accel.c
> @@ -88,7 +88,7 @@
>   
>   static inline void matrox_cfb4_pal(u_int32_t* pal) {
>   	unsigned int i;
> -	
> +
>   	for (i = 0; i < 16; i++) {
>   		pal[i] = i * 0x11111111U;
>   	}
> @@ -96,7 +96,7 @@ static inline void matrox_cfb4_pal(u_int32_t* pal) {
>   
>   static inline void matrox_cfb8_pal(u_int32_t* pal) {
>   	unsigned int i;
> -	
> +
>   	for (i = 0; i < 16; i++) {
>   		pal[i] = i * 0x01010101U;
>   	}
> @@ -482,7 +482,7 @@ static void matroxfb_1bpp_imageblit(struct matrox_fb_info *minfo, u_int32_t fgx,
>   			/* Tell... well, why bother... */
>   			while (height--) {
>   				size_t i;
> -				
> +
>   				for (i = 0; i < step; i += 4) {
>   					/* Hope that there are at least three readable bytes beyond the end of bitmap */
>   					fb_writel(get_unaligned((u_int32_t*)(chardata + i)),mmio.vaddr);
> diff --git a/drivers/video/fbdev/matrox/matroxfb_base.h b/drivers/video/fbdev/matrox/matroxfb_base.h
> index 958be6805f87..c93c69bbcd57 100644
> --- a/drivers/video/fbdev/matrox/matroxfb_base.h
> +++ b/drivers/video/fbdev/matrox/matroxfb_base.h
> @@ -301,9 +301,9 @@ struct matrox_altout {
>   	int		(*verifymode)(void* altout_dev, u_int32_t mode);
>   	int		(*getqueryctrl)(void* altout_dev,
>   					struct v4l2_queryctrl* ctrl);
> -	int		(*getctrl)(void* altout_dev,
> +	int		(*getctrl)(void *altout_dev,
>   				   struct v4l2_control* ctrl);
> -	int		(*setctrl)(void* altout_dev,
> +	int		(*setctrl)(void *altout_dev,
>   				   struct v4l2_control* ctrl);
>   };
>   
