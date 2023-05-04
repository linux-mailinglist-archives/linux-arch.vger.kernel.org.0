Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A401C6F69EC
	for <lists+linux-arch@lfdr.de>; Thu,  4 May 2023 13:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjEDLa3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 May 2023 07:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjEDLa2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 May 2023 07:30:28 -0400
X-Greylist: delayed 275 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 04 May 2023 04:30:26 PDT
Received: from 189.cn (ptr.189.cn [183.61.185.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EC6013C0F;
        Thu,  4 May 2023 04:30:26 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.31:33766.1806946331
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.31])
        by 189.cn (HERMES) with SMTP id 6339F1001C8;
        Thu,  4 May 2023 19:30:15 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-85667d6c59-lhcrq with ESMTP id 2f3efb12223041b6ba940f4f90629d4f for tzimmermann@suse.de;
        Thu, 04 May 2023 19:30:25 CST
X-Transaction-ID: 2f3efb12223041b6ba940f4f90629d4f
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
Message-ID: <4c3444e2-390b-8c9e-e136-bf888fccd10f@189.cn>
Date:   Thu, 4 May 2023 19:30:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [v4,2/6] ipu-v3: Include <linux/io.h>
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
References: <20230504074539.8181-3-tzimmermann@suse.de>
Content-Language: en-US
From:   Sui Jingfeng <15330273260@189.cn>
In-Reply-To: <20230504074539.8181-3-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


Reviewed-by: Sui Jingfeng <suijingfeng@loongson.cn>


On 2023/5/4 15:45, Thomas Zimmermann wrote:
> The code uses readl() and writel(). Include the header file to
> get the declarations.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> ---
>   drivers/gpu/ipu-v3/ipu-prv.h | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/ipu-v3/ipu-prv.h b/drivers/gpu/ipu-v3/ipu-prv.h
> index 291ac1bab66d..d4621b1ea7f1 100644
> --- a/drivers/gpu/ipu-v3/ipu-prv.h
> +++ b/drivers/gpu/ipu-v3/ipu-prv.h
> @@ -8,6 +8,7 @@
>   
>   struct ipu_soc;
>   
> +#include <linux/io.h>
>   #include <linux/types.h>
>   #include <linux/device.h>
>   #include <linux/clk.h>
