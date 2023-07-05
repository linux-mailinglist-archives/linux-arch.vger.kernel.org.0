Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B39747B3A
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jul 2023 03:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjGEBnS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Jul 2023 21:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjGEBnR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Jul 2023 21:43:17 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2C17EDD;
        Tue,  4 Jul 2023 18:43:12 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8Cx5_GuyqRk5i4AAA--.1123S3;
        Wed, 05 Jul 2023 09:43:10 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxJ82tyqRkCM4bAA--.17672S3;
        Wed, 05 Jul 2023 09:43:09 +0800 (CST)
Message-ID: <dc239a28-4314-1661-f556-670946a0982b@loongson.cn>
Date:   Wed, 5 Jul 2023 09:43:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [11/12] fbdev/core: Protect edid_info with
 CONFIG_ARCH_HAS_EDID_INFO
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, arnd@arndb.de,
        deller@gmx.de, daniel@ffwll.ch, airlied@gmail.com
Cc:     linux-arch@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-fbdev@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        dri-devel@lists.freedesktop.org, loongarch@lists.linux.dev,
        linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org
References: <20230629121952.10559-12-tzimmermann@suse.de>
From:   Sui Jingfeng <suijingfeng@loongson.cn>
In-Reply-To: <20230629121952.10559-12-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8DxJ82tyqRkCM4bAA--.17672S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoW7ZF4rtF4rKw1kKFWkJF1fAFc_yoW8Gr1Upr
        W0qa98trW8tr47W3y8Kws2vFW5X34rGFy29rZ7G3W5Kryqv3y5WFyUJrn0kr93ur4xAr4I
        yryvqw13CFnruagCm3ZEXasCq-sJn29KB7ZKAUJUUUUk529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUHab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
        wI0_Gr1j6F4UJwAaw2AFwI0_Jw0_GFyle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
        xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
        Wrv_ZF1lYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcV
        AKI48JM4x0Y40E4IxF1VCIxcxG6Fyj6r4UJwACI402YVCY1x026xAvFcxGjxylc7I2V7IY
        0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxV
        CFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUtVW8ZwC20s026c02F40E14v26r1j6r18
        MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr4
        1lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1U
        MIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8Jr0_Cr1UMIIF0x
        vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUymiiDUUUU
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,


On 2023/6/29 19:45, Thomas Zimmermann wrote:
> Guard usage of edid_info with CONFIG_ARCH_HAS_EDID_INFO instead
> of CONFIG_X86. No functional changes.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>


Reviewed-by: Sui Jingfeng <suijingfeng@loongson.cn>


> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> ---
>   drivers/video/fbdev/core/fbmon.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/video/fbdev/core/fbmon.c b/drivers/video/fbdev/core/fbmon.c
> index 35be4431f649a..9ae063021e431 100644
> --- a/drivers/video/fbdev/core/fbmon.c
> +++ b/drivers/video/fbdev/core/fbmon.c
> @@ -1480,17 +1480,19 @@ int fb_validate_mode(const struct fb_var_screeninfo *var, struct fb_info *info)
>   		-EINVAL : 0;
>   }
>   
> -#if defined(CONFIG_FIRMWARE_EDID) && defined(CONFIG_X86)
> +#if defined(CONFIG_FIRMWARE_EDID)
>   const unsigned char *fb_firmware_edid(struct fb_info *info)
>   {
>   	unsigned char *edid = NULL;
>   
> +#if defined(CONFIG_ARCH_HAS_EDID_INFO)
>   	/*
>   	 * We need to ensure that the EDID block is only
>   	 * returned for the primary graphics adapter.
>   	 */
>   	if (fb_is_primary_device(info))
>   		edid = edid_info.dummy;
> +#endif
>   
>   	return edid;
>   }

