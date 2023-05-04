Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E726F6A03
	for <lists+linux-arch@lfdr.de>; Thu,  4 May 2023 13:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjEDLd5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 May 2023 07:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjEDLd4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 May 2023 07:33:56 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7152959D2;
        Thu,  4 May 2023 04:33:46 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.43:38752.2115179215
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.43])
        by 189.cn (HERMES) with SMTP id B79E41002C4;
        Thu,  4 May 2023 19:33:43 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-85667d6c59-fm8l8 with ESMTP id f7215669ae40498ba23b2762f0724b0b for tzimmermann@suse.de;
        Thu, 04 May 2023 19:33:45 CST
X-Transaction-ID: f7215669ae40498ba23b2762f0724b0b
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
Message-ID: <799a4027-cd45-5005-1b3d-56213fcd9042@189.cn>
Date:   Thu, 4 May 2023 19:33:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [v4,6/6] fbdev: Rename fb_mem*() helpers
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
References: <20230504074539.8181-7-tzimmermann@suse.de>
From:   Sui Jingfeng <15330273260@189.cn>
In-Reply-To: <20230504074539.8181-7-tzimmermann@suse.de>
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
> Update the names of the fb_mem*() helpers to be consistent with their
> regular counterparts. Hence, fb_memset() now becomes fb_memset_io(),
> fb_memcpy_fromfb() now becomes fb_memcpy_fromio() and fb_memcpy_tofb()
> becomes fb_memcpy_toio(). No functional changes.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> ---
>   arch/ia64/include/asm/fb.h              | 12 ++++++------
>   arch/loongarch/include/asm/fb.h         | 12 ++++++------
>   arch/sparc/include/asm/fb.h             | 12 ++++++------
>   drivers/video/fbdev/aty/mach64_cursor.c |  2 +-
>   drivers/video/fbdev/chipsfb.c           |  2 +-
>   drivers/video/fbdev/core/fbmem.c        |  4 ++--
>   drivers/video/fbdev/kyro/fbdev.c        |  2 +-
>   drivers/video/fbdev/pvr2fb.c            |  2 +-
>   drivers/video/fbdev/sstfb.c             |  2 +-
>   drivers/video/fbdev/stifb.c             |  4 ++--
>   drivers/video/fbdev/tdfxfb.c            |  2 +-
>   include/asm-generic/fb.h                | 16 ++++++++--------
>   12 files changed, 36 insertions(+), 36 deletions(-)
>
> diff --git a/arch/ia64/include/asm/fb.h b/arch/ia64/include/asm/fb.h
> index bcf982043a5c..1717b26fd423 100644
> --- a/arch/ia64/include/asm/fb.h
> +++ b/arch/ia64/include/asm/fb.h
> @@ -20,23 +20,23 @@ static inline void fb_pgprotect(struct file *file, struct vm_area_struct *vma,
>   }
>   #define fb_pgprotect fb_pgprotect
>   
> -static inline void fb_memcpy_fromfb(void *to, const volatile void __iomem *from, size_t n)
> +static inline void fb_memcpy_fromio(void *to, const volatile void __iomem *from, size_t n)
>   {
>   	memcpy(to, (void __force *)from, n);
>   }
> -#define fb_memcpy_fromfb fb_memcpy_fromfb
> +#define fb_memcpy_fromio fb_memcpy_fromio
>   
> -static inline void fb_memcpy_tofb(volatile void __iomem *to, const void *from, size_t n)
> +static inline void fb_memcpy_toio(volatile void __iomem *to, const void *from, size_t n)
>   {
>   	memcpy((void __force *)to, from, n);
>   }
> -#define fb_memcpy_tofb fb_memcpy_tofb
> +#define fb_memcpy_toio fb_memcpy_toio
>   
> -static inline void fb_memset(volatile void __iomem *addr, int c, size_t n)
> +static inline void fb_memset_io(volatile void __iomem *addr, int c, size_t n)
>   {
>   	memset((void __force *)addr, c, n);
>   }
> -#define fb_memset fb_memset
> +#define fb_memset fb_memset_io
>   
>   #include <asm-generic/fb.h>
>   
> diff --git a/arch/loongarch/include/asm/fb.h b/arch/loongarch/include/asm/fb.h
> index c6fc7ef374a4..0b218b10a9ec 100644
> --- a/arch/loongarch/include/asm/fb.h
> +++ b/arch/loongarch/include/asm/fb.h
> @@ -8,23 +8,23 @@
>   #include <linux/compiler.h>
>   #include <linux/string.h>
>   
> -static inline void fb_memcpy_fromfb(void *to, const volatile void __iomem *from, size_t n)
> +static inline void fb_memcpy_fromio(void *to, const volatile void __iomem *from, size_t n)
>   {
>   	memcpy(to, (void __force *)from, n);
>   }
> -#define fb_memcpy_fromfb fb_memcpy_fromfb
> +#define fb_memcpy_fromio fb_memcpy_fromio
>   
> -static inline void fb_memcpy_tofb(volatile void __iomem *to, const void *from, size_t n)
> +static inline void fb_memcpy_toio(volatile void __iomem *to, const void *from, size_t n)
>   {
>   	memcpy((void __force *)to, from, n);
>   }
> -#define fb_memcpy_tofb fb_memcpy_tofb
> +#define fb_memcpy_toio fb_memcpy_toio
>   
> -static inline void fb_memset(volatile void __iomem *addr, int c, size_t n)
> +static inline void fb_memset_io(volatile void __iomem *addr, int c, size_t n)
>   {
>   	memset((void __force *)addr, c, n);
>   }
> -#define fb_memset fb_memset
> +#define fb_memset fb_memset_io
>   
>   #include <asm-generic/fb.h>
>   
> diff --git a/arch/sparc/include/asm/fb.h b/arch/sparc/include/asm/fb.h
> index 077da91aeba1..572ecd3e1cc4 100644
> --- a/arch/sparc/include/asm/fb.h
> +++ b/arch/sparc/include/asm/fb.h
> @@ -18,23 +18,23 @@ static inline void fb_pgprotect(struct file *file, struct vm_area_struct *vma,
>   int fb_is_primary_device(struct fb_info *info);
>   #define fb_is_primary_device fb_is_primary_device
>   
> -static inline void fb_memcpy_fromfb(void *to, const volatile void __iomem *from, size_t n)
> +static inline void fb_memcpy_fromio(void *to, const volatile void __iomem *from, size_t n)
>   {
>   	sbus_memcpy_fromio(to, from, n);
>   }
> -#define fb_memcpy_fromfb fb_memcpy_fromfb
> +#define fb_memcpy_fromio fb_memcpy_fromio
>   
> -static inline void fb_memcpy_tofb(volatile void __iomem *to, const void *from, size_t n)
> +static inline void fb_memcpy_toio(volatile void __iomem *to, const void *from, size_t n)
>   {
>   	sbus_memcpy_toio(to, from, n);
>   }
> -#define fb_memcpy_tofb fb_memcpy_tofb
> +#define fb_memcpy_toio fb_memcpy_toio
>   
> -static inline void fb_memset(volatile void __iomem *addr, int c, size_t n)
> +static inline void fb_memset_io(volatile void __iomem *addr, int c, size_t n)
>   {
>   	sbus_memset_io(addr, c, n);
>   }
> -#define fb_memset fb_memset
> +#define fb_memset fb_memset_io
>   
>   #include <asm-generic/fb.h>
>   
> diff --git a/drivers/video/fbdev/aty/mach64_cursor.c b/drivers/video/fbdev/aty/mach64_cursor.c
> index 4ad0331a8c57..971355c2cd7e 100644
> --- a/drivers/video/fbdev/aty/mach64_cursor.c
> +++ b/drivers/video/fbdev/aty/mach64_cursor.c
> @@ -153,7 +153,7 @@ static int atyfb_cursor(struct fb_info *info, struct fb_cursor *cursor)
>   	    u8 m, b;
>   
>   	    // Clear cursor image with 1010101010...
> -	    fb_memset(dst, 0xaa, 1024);
> +	    fb_memset_io(dst, 0xaa, 1024);
>   
>   	    offset = align - width*2;
>   
> diff --git a/drivers/video/fbdev/chipsfb.c b/drivers/video/fbdev/chipsfb.c
> index 7799d52a651f..2a27ba94f652 100644
> --- a/drivers/video/fbdev/chipsfb.c
> +++ b/drivers/video/fbdev/chipsfb.c
> @@ -332,7 +332,7 @@ static const struct fb_var_screeninfo chipsfb_var = {
>   
>   static void init_chips(struct fb_info *p, unsigned long addr)
>   {
> -	fb_memset(p->screen_base, 0, 0x100000);
> +	fb_memset_io(p->screen_base, 0, 0x100000);
>   
>   	p->fix = chipsfb_fix;
>   	p->fix.smem_start = addr;
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> index 38f7e83fa6e3..d433ba8015a7 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -802,7 +802,7 @@ fb_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
>   	while (count) {
>   		c  = (count > PAGE_SIZE) ? PAGE_SIZE : count;
>   		dst = buffer;
> -		fb_memcpy_fromfb(dst, src, c);
> +		fb_memcpy_fromio(dst, src, c);
>   		dst += c;
>   		src += c;
>   
> @@ -879,7 +879,7 @@ fb_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
>   			break;
>   		}
>   
> -		fb_memcpy_tofb(dst, src, c);
> +		fb_memcpy_toio(dst, src, c);
>   		dst += c;
>   		src += c;
>   		*ppos += c;
> diff --git a/drivers/video/fbdev/kyro/fbdev.c b/drivers/video/fbdev/kyro/fbdev.c
> index 0596573ef140..3f277bdb3a32 100644
> --- a/drivers/video/fbdev/kyro/fbdev.c
> +++ b/drivers/video/fbdev/kyro/fbdev.c
> @@ -737,7 +737,7 @@ static int kyrofb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>   			       info->var.bits_per_pixel);
>   	size *= info->var.yres_virtual;
>   
> -	fb_memset(info->screen_base, 0, size);
> +	fb_memset_io(info->screen_base, 0, size);
>   
>   	if (register_framebuffer(info) < 0)
>   		goto out_unmap;
> diff --git a/drivers/video/fbdev/pvr2fb.c b/drivers/video/fbdev/pvr2fb.c
> index 6888127a5eb8..d8d97a9d2436 100644
> --- a/drivers/video/fbdev/pvr2fb.c
> +++ b/drivers/video/fbdev/pvr2fb.c
> @@ -798,7 +798,7 @@ static int __maybe_unused pvr2fb_common_init(void)
>   		goto out_err;
>   	}
>   
> -	fb_memset(fb_info->screen_base, 0, pvr2_fix.smem_len);
> +	fb_memset_io(fb_info->screen_base, 0, pvr2_fix.smem_len);
>   
>   	pvr2_fix.ypanstep	= nopan  ? 0 : 1;
>   	pvr2_fix.ywrapstep	= nowrap ? 0 : 1;
> diff --git a/drivers/video/fbdev/sstfb.c b/drivers/video/fbdev/sstfb.c
> index da296b2ab54a..582324f5d869 100644
> --- a/drivers/video/fbdev/sstfb.c
> +++ b/drivers/video/fbdev/sstfb.c
> @@ -335,7 +335,7 @@ static int sst_calc_pll(const int freq, int *freq_out, struct pll_timing *t)
>   static void sstfb_clear_screen(struct fb_info *info)
>   {
>   	/* clear screen */
> -	fb_memset(info->screen_base, 0, info->fix.smem_len);
> +	fb_memset_io(info->screen_base, 0, info->fix.smem_len);
>   }
>   
>   
> diff --git a/drivers/video/fbdev/stifb.c b/drivers/video/fbdev/stifb.c
> index baca6974e288..01363dccfdaf 100644
> --- a/drivers/video/fbdev/stifb.c
> +++ b/drivers/video/fbdev/stifb.c
> @@ -527,8 +527,8 @@ rattlerSetupPlanes(struct stifb_info *fb)
>   	fb->id = saved_id;
>   
>   	for (y = 0; y < fb->info.var.yres; ++y)
> -		fb_memset(fb->info.screen_base + y * fb->info.fix.line_length,
> -			0xff, fb->info.var.xres * fb->info.var.bits_per_pixel/8);
> +		fb_memset_io(fb->info.screen_base + y * fb->info.fix.line_length,
> +			     0xff, fb->info.var.xres * fb->info.var.bits_per_pixel/8);
>   
>   	CRX24_SET_OVLY_MASK(fb);
>   	SETUP_FB(fb);
> diff --git a/drivers/video/fbdev/tdfxfb.c b/drivers/video/fbdev/tdfxfb.c
> index d17e5e1472aa..cdf8e9fe9948 100644
> --- a/drivers/video/fbdev/tdfxfb.c
> +++ b/drivers/video/fbdev/tdfxfb.c
> @@ -1116,7 +1116,7 @@ static int tdfxfb_cursor(struct fb_info *info, struct fb_cursor *cursor)
>   		u8 *mask = (u8 *)cursor->mask;
>   		int i;
>   
> -		fb_memset(cursorbase, 0, 1024);
> +		fb_memset_io(cursorbase, 0, 1024);
>   
>   		for (i = 0; i < cursor->image.height; i++) {
>   			int h = 0;
> diff --git a/include/asm-generic/fb.h b/include/asm-generic/fb.h
> index 6ef624b3ce12..1964611f1ce2 100644
> --- a/include/asm-generic/fb.h
> +++ b/include/asm-generic/fb.h
> @@ -107,28 +107,28 @@ static inline void fb_writeq(u64 b, volatile void __iomem *addr)
>   #endif
>   #endif
>   
> -#ifndef fb_memcpy_fromfb
> -static inline void fb_memcpy_fromfb(void *to, const volatile void __iomem *from, size_t n)
> +#ifndef fb_memcpy_fromio
> +static inline void fb_memcpy_fromio(void *to, const volatile void __iomem *from, size_t n)
>   {
>   	memcpy_fromio(to, from, n);
>   }
> -#define fb_memcpy_fromfb fb_memcpy_fromfb
> +#define fb_memcpy_fromio fb_memcpy_fromio
>   #endif
>   
> -#ifndef fb_memcpy_tofb
> -static inline void fb_memcpy_tofb(volatile void __iomem *to, const void *from, size_t n)
> +#ifndef fb_memcpy_toio
> +static inline void fb_memcpy_toio(volatile void __iomem *to, const void *from, size_t n)
>   {
>   	memcpy_toio(to, from, n);
>   }
> -#define fb_memcpy_tofb fb_memcpy_tofb
> +#define fb_memcpy_toio fb_memcpy_toio
>   #endif
>   
>   #ifndef fb_memset
> -static inline void fb_memset(volatile void __iomem *addr, int c, size_t n)
> +static inline void fb_memset_io(volatile void __iomem *addr, int c, size_t n)
>   {
>   	memset_io(addr, c, n);
>   }
> -#define fb_memset fb_memset
> +#define fb_memset fb_memset_io
>   #endif
>   
>   #endif /* __ASM_GENERIC_FB_H_ */
