Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2314A5112D5
	for <lists+linux-arch@lfdr.de>; Wed, 27 Apr 2022 09:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359051AbiD0HwB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 Apr 2022 03:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359050AbiD0HwA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 27 Apr 2022 03:52:00 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B2E1171FC;
        Wed, 27 Apr 2022 00:48:50 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id x17so1647153lfa.10;
        Wed, 27 Apr 2022 00:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=PywqmiP2x+ADUigZQGCOhRXDGd7/GFP8SZ7Y3X8ZjnQ=;
        b=PF54JF+N2HYubzvXAUiKVBsDwnGvSCdcPnMH75kfT8z7wXKwEvXuw2qpE3LOuszhGS
         eYkxjlYJZMmhB3whtQRkNe9XFD4ljwnsGe44hVnqO37UNB+KeJU5sTtEBHa+r8F/uod7
         a1PB3qH4xBVstey3ZVHXlo1urtAoHcTH5QY4y5Ii5iAb7SjT4ZvZqYm4Wxz39DVL8Ji4
         qORLQMvDfFpck8bDeFkscRLoNwHTUX6QmV1dSo0AMNBGQyoxV/r2iPPVHgxrafIJGuh0
         TC3atBJRHrSMm65sUKWUSzHg1JQ63cmtiHRRDSBdnghJfOF3lOvcwSXTzJimtBwexq6e
         75dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=PywqmiP2x+ADUigZQGCOhRXDGd7/GFP8SZ7Y3X8ZjnQ=;
        b=WqGbw5liyogTSmMw51BUZBwzsIg3dwmHZbnoEPMi9SWG58nNoeMJI3x122EXrepGI9
         T2ogVyzGabrXlV69LpmV5TVv6AHokHP99aoVLzXlRdffJ2cskxGBpMZ60hkJHNnIyHo7
         tA+/DZyijVt5IhhGI0Bg6It2CGAUzBUZVzJ8KrnAY5EpiCS3dGa9FTUU73HSR/b/CnI7
         VtJxe3DmuIXXsyKcMoJ9VcubWly8AXzny0XwH/8lBqLbpYvgPZ0oq8+E8nDgaHY8qb/z
         R5X3RnHca16LiEdTXigdRbP/b+EIWt7VkqC/Lkozn0IhlsdqopwZI/K3iuryHVmcZln+
         VPZg==
X-Gm-Message-State: AOAM530LPjr4obzXSDH5+4SyAQOkPj2bpGZ8L9ztbuODV4ZuPs/nh3uH
        VruyT1a7nG9V3+jOvQpEqdGhwFviHJY=
X-Google-Smtp-Source: ABdhPJxqEWDZ6p9UjNTr9pT0/9M/LyGUg5Jot6OcqYp8CexBP0v6xAINOFNhx5NM7CwSiXCPq9kIZg==
X-Received: by 2002:a05:6512:31c2:b0:471:ad85:9553 with SMTP id j2-20020a05651231c200b00471ad859553mr18585166lfe.330.1651045728347;
        Wed, 27 Apr 2022 00:48:48 -0700 (PDT)
Received: from [192.168.1.7] ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id l7-20020a2e9087000000b0024f24a78dfdsm309710ljg.93.2022.04.27.00.48.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 00:48:47 -0700 (PDT)
Subject: Re: [PATCH 0/2] kernel: add new infrastructure for platform_has()
 support
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
References: <20220426134021.11210-1-jgross@suse.com>
From:   Oleksandr <olekstysh@gmail.com>
Message-ID: <9aa13b10-7342-461c-38a5-eb56d7e69b23@gmail.com>
Date:   Wed, 27 Apr 2022 10:48:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220426134021.11210-1-jgross@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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


On 26.04.22 16:40, Juergen Gross wrote:

Hello Juergen, all

> In another patch series [1] the need has come up to have support for
> a generic feature flag infrastructure.
>
> This patch series is introducing that infrastructure and adds the first
> use case.
>
> I have decided to use a similar interface as the already known x86
> cpu_has() function. As the new infrastructure is meant to be usable for
> general and arch-specific feature flags, the flags are being spread
> between a general bitmap and an arch specific one.
>
> The bitmaps start all being zero, single features can be set or reset
> at any time by using the related platform_[re]set_feature() functions.
>
> The platform_has() function is using a simple test_bit() call for now,
> further optimization might be added when needed.
>
> [1]: https://lore.kernel.org/lkml/1650646263-22047-1-git-send-email-olekstysh@gmail.com/T/#t

I have tested the series on Arm64 in the context of xen-virtio enabling 
work. I didn't see any issues with it. Thank you.

I reworked patch #3 [1] to use new functionality:


diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index ec5b082..f3b9e20 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -438,6 +438,8 @@ static int __init xen_guest_init(void)
         if (!xen_domain())
                 return 0;

+       xen_set_restricted_virtio_memory_access();
+
         if (!acpi_disabled)
                 xen_acpi_guest_init();
         else
diff --git a/arch/x86/xen/enlighten_hvm.c b/arch/x86/xen/enlighten_hvm.c
index 517a9d8..8b71b1d 100644
--- a/arch/x86/xen/enlighten_hvm.c
+++ b/arch/x86/xen/enlighten_hvm.c
@@ -195,6 +195,8 @@ static void __init xen_hvm_guest_init(void)
         if (xen_pv_domain())
                 return;

+       xen_set_restricted_virtio_memory_access();
+
         init_hvm_pv_info();

         reserve_shared_info();
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 5038edb..fcd5d5d 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -109,6 +109,8 @@ static DEFINE_PER_CPU(struct tls_descs, 
shadow_tls_desc);

  static void __init xen_pv_init_platform(void)
  {
+       xen_set_restricted_virtio_memory_access();
+
         populate_extra_pte(fix_to_virt(FIX_PARAVIRT_BOOTMAP));

         set_fixmap(FIX_PARAVIRT_BOOTMAP, xen_start_info->shared_info);
diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
index 313a9127..a7bd8ce 100644
--- a/drivers/xen/Kconfig
+++ b/drivers/xen/Kconfig
@@ -339,4 +339,15 @@ config XEN_GRANT_DMA_OPS
         bool
         select DMA_OPS

+config XEN_VIRTIO
+       bool "Xen virtio support"
+       depends on VIRTIO
+       select XEN_GRANT_DMA_OPS
+       help
+         Enable virtio support for running as Xen guest. Depending on the
+         guest type this will require special support on the backend side
+         (qemu or kernel, depending on the virtio device types used).
+
+         If in doubt, say n.
+
  endmenu
diff --git a/include/xen/xen.h b/include/xen/xen.h
index a99bab8..e2849c9 100644
--- a/include/xen/xen.h
+++ b/include/xen/xen.h
@@ -52,6 +52,14 @@ bool xen_biovec_phys_mergeable(const struct bio_vec 
*vec1,
  extern u64 xen_saved_max_mem_size;
  #endif

+#include <linux/platform-feature.h>
+
+static inline void xen_set_restricted_virtio_memory_access(void)
+{
+       if (IS_ENABLED(CONFIG_XEN_VIRTIO) && xen_domain())
+ platform_set_feature(PLATFORM_VIRTIO_RESTRICTED_MEM_ACCESS);
+}
+
  #ifdef CONFIG_XEN_UNPOPULATED_ALLOC
  int xen_alloc_unpopulated_pages(unsigned int nr_pages, struct page 
**pages);
  void xen_free_unpopulated_pages(unsigned int nr_pages, struct page 
**pages);
(END)


[1] 
https://lore.kernel.org/lkml/1650646263-22047-4-git-send-email-olekstysh@gmail.com/


>
> Juergen Gross (2):
>    kernel: add platform_has() infrastructure
>    virtio: replace arch_has_restricted_virtio_memory_access()
>
>   MAINTAINERS                            |  8 +++++++
>   arch/s390/Kconfig                      |  1 -
>   arch/s390/mm/init.c                    | 13 +++--------
>   arch/x86/Kconfig                       |  1 -
>   arch/x86/kernel/cpu/mshyperv.c         |  5 ++++-
>   arch/x86/mm/mem_encrypt.c              |  6 ------
>   arch/x86/mm/mem_encrypt_identity.c     |  5 +++++
>   drivers/virtio/Kconfig                 |  6 ------
>   drivers/virtio/virtio.c                |  5 ++---
>   include/asm-generic/Kbuild             |  1 +
>   include/asm-generic/platform-feature.h |  8 +++++++
>   include/linux/platform-feature.h       | 30 ++++++++++++++++++++++++++
>   include/linux/virtio_config.h          |  9 --------
>   kernel/Makefile                        |  2 +-
>   kernel/platform-feature.c              |  7 ++++++
>   15 files changed, 69 insertions(+), 38 deletions(-)
>   create mode 100644 include/asm-generic/platform-feature.h
>   create mode 100644 include/linux/platform-feature.h
>   create mode 100644 kernel/platform-feature.c
>
-- 
Regards,

Oleksandr Tyshchenko

