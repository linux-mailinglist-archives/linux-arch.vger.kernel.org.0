Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2A7E512286
	for <lists+linux-arch@lfdr.de>; Wed, 27 Apr 2022 21:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbiD0T1Y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 Apr 2022 15:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233183AbiD0T1X (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 27 Apr 2022 15:27:23 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA20932D;
        Wed, 27 Apr 2022 12:24:10 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id k12so4853168lfr.9;
        Wed, 27 Apr 2022 12:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=pmg9eRfQpwcLMR5lkJg14lCHYf1jgo1mZ8R/uEh2NcM=;
        b=dgGddCVJMZenF3RahHHFuLmMOw5tyQ9QfPuTkQWIWU2Qil2Cn3gpire3r84vt/zxxb
         E8Kq75bD5kabWgZ31jZQl9FL9ySi4AVbeIB+vV1gamCoouQuDxbcFdkCNRifSn5jcyIu
         9PgRZUGFf4sU3Y2Y5J5wnjchOddTK0+u6wjiO6aJdhpOThZNWJGBNd7CMPpyMqaKUPpz
         Sl9X3JHmrjWUenjAPR9EEqpY4IX/LZXG2eIIqXczUjT7dEEpbmtOywC5NgdmS1QGpvte
         lcekBiOeNQvbYveziicyBVl8FjSNJDKJ1yAEEo4gzBVlj7xdlehklvpgxDMWhk2AhZGB
         sGjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=pmg9eRfQpwcLMR5lkJg14lCHYf1jgo1mZ8R/uEh2NcM=;
        b=keBRWrE0YnJXCQwCJGvFV3Dn+xppYiCg2OI39WM4mvRaw1bOVcnFbNcrJKpz5So9PY
         WvAgzUwCtaaDnxLshGm7hF5Ky6pBGjLghvEQkG9/v/kEVTjYhZlkZF0MBjCBP0zTfxB1
         HusMwc9fTgmP7iWmSxH8l8aooYqg/z3f/E0FvGLo86/1vZxN0STFGpqs+2blXNAhaAH3
         PtcLVdzgpg/pEduHB7k/MuMpsZgKbs9NXSMGHnIgp4GOUzopGhVVAJYHGqnaCWOhEqxw
         pZPSaMlNcRatzasH9BXXluSIl2OP+Iyn20u2PATT+fMlV4we6Gvx+550NV6xj1HKij9s
         DWXA==
X-Gm-Message-State: AOAM53287GHw5piiZoznz8oS9ljaocS6UiV6kea3Knf01bcr0uCE1/iP
        6wGB+QnyG0uNXZ6x1F0Sb58=
X-Google-Smtp-Source: ABdhPJzo+xYrfyRoYNmBe0lc6s+9QZp/3p32wuIOdd0rLs+DCuZcQyF13esAG5AU3FOGUaqQXyA1Nw==
X-Received: by 2002:ac2:5a47:0:b0:471:fdbe:910b with SMTP id r7-20020ac25a47000000b00471fdbe910bmr14912506lfn.315.1651087448735;
        Wed, 27 Apr 2022 12:24:08 -0700 (PDT)
Received: from [192.168.1.7] ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id p16-20020a056512313000b004722373eda4sm439639lfd.92.2022.04.27.12.24.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 12:24:08 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] virtio: replace
 arch_has_restricted_virtio_memory_access()
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        x86@kernel.org, linux-s390@vger.kernel.org,
        linux-hyperv@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Arnd Bergmann <arnd@arndb.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
References: <20220427153336.11091-1-jgross@suse.com>
 <20220427153336.11091-3-jgross@suse.com>
From:   Oleksandr <olekstysh@gmail.com>
Message-ID: <9668d693-73f6-99e2-3931-bb5683c4afe2@gmail.com>
Date:   Wed, 27 Apr 2022 22:24:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220427153336.11091-3-jgross@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 27.04.22 18:33, Juergen Gross wrote:


Hello Juergen, all

> Instead of using arch_has_restricted_virtio_memory_access() together
> with CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS, replace those
> with platform_has() and a new platform feature
> PLATFORM_VIRTIO_RESTRICTED_MEM_ACCESS.
>
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
> V2:
> - move setting of PLATFORM_VIRTIO_RESTRICTED_MEM_ACCESS in SEV case
>    to sev_setup_arch().


V2 works as fine as V1 did. I have tested on Arm64 in the context of 
xen-virtio enabling work [1]. Thank you!


Just small NIT below.


> ---
>   arch/s390/Kconfig                |  1 -
>   arch/s390/mm/init.c              | 13 +++----------
>   arch/x86/Kconfig                 |  1 -
>   arch/x86/kernel/cpu/mshyperv.c   |  5 ++++-
>   arch/x86/mm/mem_encrypt.c        |  6 ------
>   arch/x86/mm/mem_encrypt_amd.c    |  4 ++++
>   drivers/virtio/Kconfig           |  6 ------
>   drivers/virtio/virtio.c          |  5 ++---
>   include/linux/platform-feature.h |  3 ++-
>   include/linux/virtio_config.h    |  9 ---------
>   10 files changed, 15 insertions(+), 38 deletions(-)
>
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index e084c72104f8..f97a22ae69a8 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -772,7 +772,6 @@ menu "Virtualization"
>   config PROTECTED_VIRTUALIZATION_GUEST
>   	def_bool n
>   	prompt "Protected virtualization guest support"
> -	select ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
>   	help
>   	  Select this option, if you want to be able to run this
>   	  kernel as a protected virtualization KVM guest.
> diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
> index 86ffd0d51fd5..2c3b451813ed 100644
> --- a/arch/s390/mm/init.c
> +++ b/arch/s390/mm/init.c
> @@ -31,6 +31,7 @@
>   #include <linux/cma.h>
>   #include <linux/gfp.h>
>   #include <linux/dma-direct.h>
> +#include <linux/platform-feature.h>
>   #include <asm/processor.h>
>   #include <linux/uaccess.h>
>   #include <asm/pgalloc.h>
> @@ -168,22 +169,14 @@ bool force_dma_unencrypted(struct device *dev)
>   	return is_prot_virt_guest();
>   }
>   
> -#ifdef CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
> -
> -int arch_has_restricted_virtio_memory_access(void)
> -{
> -	return is_prot_virt_guest();
> -}
> -EXPORT_SYMBOL(arch_has_restricted_virtio_memory_access);
> -
> -#endif
> -
>   /* protected virtualization */
>   static void pv_init(void)
>   {
>   	if (!is_prot_virt_guest())
>   		return;
>   
> +	platform_set(PLATFORM_VIRTIO_RESTRICTED_MEM_ACCESS);
> +
>   	/* make sure bounce buffers are shared */
>   	swiotlb_force = SWIOTLB_FORCE;
>   	swiotlb_init(1);
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index b0142e01002e..20ac72546ae4 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1515,7 +1515,6 @@ config X86_CPA_STATISTICS
>   config X86_MEM_ENCRYPT
>   	select ARCH_HAS_FORCE_DMA_UNENCRYPTED
>   	select DYNAMIC_PHYSICAL_MASK
> -	select ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
>   	def_bool n
>   
>   config AMD_MEM_ENCRYPT
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index 4b67094215bb..965518b9d14b 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -19,6 +19,7 @@
>   #include <linux/i8253.h>
>   #include <linux/random.h>
>   #include <linux/swiotlb.h>
> +#include <linux/platform-feature.h>
>   #include <asm/processor.h>
>   #include <asm/hypervisor.h>
>   #include <asm/hyperv-tlfs.h>
> @@ -347,8 +348,10 @@ static void __init ms_hyperv_init_platform(void)
>   #endif
>   		/* Isolation VMs are unenlightened SEV-based VMs, thus this check: */
>   		if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
> -			if (hv_get_isolation_type() != HV_ISOLATION_TYPE_NONE)
> +			if (hv_get_isolation_type() != HV_ISOLATION_TYPE_NONE) {
>   				cc_set_vendor(CC_VENDOR_HYPERV);
> +				platform_set(PLATFORM_VIRTIO_RESTRICTED_MEM_ACCESS);
> +			}
>   		}
>   	}
>   
> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> index 50d209939c66..9b6a7c98b2b1 100644
> --- a/arch/x86/mm/mem_encrypt.c
> +++ b/arch/x86/mm/mem_encrypt.c
> @@ -76,9 +76,3 @@ void __init mem_encrypt_init(void)
>   
>   	print_mem_encrypt_feature_info();
>   }
> -
> -int arch_has_restricted_virtio_memory_access(void)
> -{
> -	return cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT);
> -}
> -EXPORT_SYMBOL_GPL(arch_has_restricted_virtio_memory_access);

I assume, everywhere where <linux/virtio_config.h> was specifically 
included only for sake of arch_has_restricted_virtio_memory_access(), 
the inclusion of <linux/virtio_config.h>

could be removed now.


> diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
> index 6169053c2854..39b71084d36b 100644
> --- a/arch/x86/mm/mem_encrypt_amd.c
> +++ b/arch/x86/mm/mem_encrypt_amd.c
> @@ -21,6 +21,7 @@
>   #include <linux/dma-mapping.h>
>   #include <linux/virtio_config.h>
>   #include <linux/cc_platform.h>
> +#include <linux/platform-feature.h>
>   
>   #include <asm/tlbflush.h>
>   #include <asm/fixmap.h>
> @@ -206,6 +207,9 @@ void __init sev_setup_arch(void)
>   	size = total_mem * 6 / 100;
>   	size = clamp_val(size, IO_TLB_DEFAULT_SIZE, SZ_1G);
>   	swiotlb_adjust_size(size);
> +
> +	/* Set restricted memory access for virtio. */
> +	platform_set(PLATFORM_VIRTIO_RESTRICTED_MEM_ACCESS);
>   }
>   
>   static unsigned long pg_level_to_pfn(int level, pte_t *kpte, pgprot_t *ret_prot)
> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> index b5adf6abd241..a6dc8b5846fe 100644
> --- a/drivers/virtio/Kconfig
> +++ b/drivers/virtio/Kconfig
> @@ -6,12 +6,6 @@ config VIRTIO
>   	  bus, such as CONFIG_VIRTIO_PCI, CONFIG_VIRTIO_MMIO, CONFIG_RPMSG
>   	  or CONFIG_S390_GUEST.
>   
> -config ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
> -	bool
> -	help
> -	  This option is selected if the architecture may need to enforce
> -	  VIRTIO_F_ACCESS_PLATFORM
> -
>   config VIRTIO_PCI_LIB
>   	tristate
>   	help
> diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> index 22f15f444f75..371e16b18381 100644
> --- a/drivers/virtio/virtio.c
> +++ b/drivers/virtio/virtio.c
> @@ -5,6 +5,7 @@
>   #include <linux/module.h>
>   #include <linux/idr.h>
>   #include <linux/of.h>
> +#include <linux/platform-feature.h>
>   #include <uapi/linux/virtio_ids.h>
>   
>   /* Unique numbering for virtio devices. */
> @@ -170,12 +171,10 @@ EXPORT_SYMBOL_GPL(virtio_add_status);
>   static int virtio_features_ok(struct virtio_device *dev)
>   {
>   	unsigned status;
> -	int ret;
>   
>   	might_sleep();
>   
> -	ret = arch_has_restricted_virtio_memory_access();
> -	if (ret) {
> +	if (platform_has(PLATFORM_VIRTIO_RESTRICTED_MEM_ACCESS)) {
>   		if (!virtio_has_feature(dev, VIRTIO_F_VERSION_1)) {
>   			dev_warn(&dev->dev,
>   				 "device must provide VIRTIO_F_VERSION_1\n");
> diff --git a/include/linux/platform-feature.h b/include/linux/platform-feature.h
> index 6ed859928b97..5e2f08554b38 100644
> --- a/include/linux/platform-feature.h
> +++ b/include/linux/platform-feature.h
> @@ -6,7 +6,8 @@
>   #include <asm/platform-feature.h>
>   
>   /* The platform features are starting with the architecture specific ones. */
> -#define PLATFORM_FEAT_N				(0 + PLATFORM_ARCH_FEAT_N)
> +#define PLATFORM_VIRTIO_RESTRICTED_MEM_ACCESS	(0 + PLATFORM_ARCH_FEAT_N)

I would add a sentence describing the purpose of that "common" feature.


> +#define PLATFORM_FEAT_N				(1 + PLATFORM_ARCH_FEAT_N)
>   
>   void platform_set(unsigned int feature);
>   void platform_clear(unsigned int feature);
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> index b341dd62aa4d..79498298519d 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -559,13 +559,4 @@ static inline void virtio_cwrite64(struct virtio_device *vdev,
>   		_r;							\
>   	})
>   
> -#ifdef CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
> -int arch_has_restricted_virtio_memory_access(void);
> -#else
> -static inline int arch_has_restricted_virtio_memory_access(void)
> -{
> -	return 0;
> -}
> -#endif /* CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS */
> -
>   #endif /* _LINUX_VIRTIO_CONFIG_H */


[1] 
https://lore.kernel.org/lkml/1650646263-22047-1-git-send-email-olekstysh@gmail.com/T/#mf3eaee90da6bb2c52a4c4b36b9989dacc4e9c597


-- 
Regards,

Oleksandr Tyshchenko

