Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166BB6FE402
	for <lists+linux-arch@lfdr.de>; Wed, 10 May 2023 20:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjEJSWn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 May 2023 14:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236062AbjEJSWj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 10 May 2023 14:22:39 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 35412868D;
        Wed, 10 May 2023 11:22:10 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.31:41422.1440474362
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.31])
        by 189.cn (HERMES) with SMTP id 60D1C1001EA;
        Thu, 11 May 2023 02:20:32 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-85667d6c59-lhcrq with ESMTP id 2e0243989df1455fa5a7afdcf2c485d3 for tzimmermann@suse.de;
        Thu, 11 May 2023 02:20:34 CST
X-Transaction-ID: 2e0243989df1455fa5a7afdcf2c485d3
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
Message-ID: <0e13efbf-9a48-6e70-fdf3-8290f28c6dc7@189.cn>
Date:   Thu, 11 May 2023 02:20:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v6 1/6] fbdev/matrox: Remove trailing whitespaces
To:     Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
        geert@linux-m68k.org, javierm@redhat.com, daniel@ffwll.ch,
        vgupta@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name,
        davem@davemloft.net, James.Bottomley@HansenPartnership.com,
        arnd@arndb.de, sam@ravnborg.org
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arch@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-parisc@vger.kernel.org
References: <20230510110557.14343-1-tzimmermann@suse.de>
 <20230510110557.14343-2-tzimmermann@suse.de>
Content-Language: en-US
From:   Sui Jingfeng <15330273260@189.cn>
In-Reply-To: <20230510110557.14343-2-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Thomas


I love your patch, yet something to improve:


On 2023/5/10 19:05, Thomas Zimmermann wrote:
> Fix coding style. No functional changes.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> Reviewed-by: Sui Jingfeng <suijingfeng@loongson.cn>
> Tested-by: Sui Jingfeng <suijingfeng@loongson.cn>
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

Noticed that there are plenty of coding style problems in matroxfb_base.h,

why you only fix a few of them?   Take this two line as an example, 
shouldn't

they be fixed also as following?


  	int		(*verifymode)(void *altout_dev, u_int32_t mode);
  	int		(*getqueryctrl)(void *altout_dev,
  					struct v4l2_queryctrl *ctrl);


> -	int		(*getctrl)(void* altout_dev,
> +	int		(*getctrl)(void *altout_dev,
>   				   struct v4l2_control* ctrl);
> -	int		(*setctrl)(void* altout_dev,
> +	int		(*setctrl)(void *altout_dev,
>   				   struct v4l2_control* ctrl);
>   };
>   
