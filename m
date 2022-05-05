Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D42051C4F2
	for <lists+linux-arch@lfdr.de>; Thu,  5 May 2022 18:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352848AbiEEQRh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 May 2022 12:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240127AbiEEQRg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 May 2022 12:17:36 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB8A5F96;
        Thu,  5 May 2022 09:13:56 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id w4so6736361wrg.12;
        Thu, 05 May 2022 09:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=0i9RkkeLX/a8FzO4tLn2BkIX5lR98eNO9g+/uG49UQE=;
        b=TFfCLhoxYT56Nn3x7jCyVrlcC07sWTbmQD1AANF/ehbQxFzjKfx9p0RhCXiQ9vZATC
         vT5nje7UrDRvgKIr44wPnSwPQG+pY1XmJFE4xlRE/mevmlBZUcwA4wvh3YOS0sW8jD01
         RkyB1FsNIQX4gNXT/Lf6truNDyI/Weeenh7pNiIH3v48Wa1mIvHKXHJW8gTMaiplaplb
         Mlyp0zQn+e+A3PxkBqku7eWW5U9iGPWxfYsQplvI6Qe8UCk8ZRUyV6G8IoIU7oOphOC7
         WMz7KJEMFeVpjJNnuVAHWTpqXMQlRlBpiphHq//udnTragjcHo48ZNDk4aPxXFEQHL6i
         QTIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=0i9RkkeLX/a8FzO4tLn2BkIX5lR98eNO9g+/uG49UQE=;
        b=YFqYbqU0XlzDs3hkNggjjKPMkB92AtIB3Lo9OjjZGOfBSw6HOaTo1/qt8qK+mXUBiG
         qTb9cFJBvSPKlU7CW43LIAeKYubTWnKoLF50KUJaWtCIFVwHD9KTtxJiuM3WRWXP2w+M
         an4FVhLPprdh43LMqP+8LkxGat9AWynpNHskAoO7yKbwhAaee0BhwZX6mWjr2EtTmjU1
         FtX+tj0tObX+x7j95ZkKi8FO2hbgDXCS6HFtTYz6Do7E6bNNsgs9CFEL/C89FloqRymS
         o5bKFQSkmleXoKUwMXqQuz4lLsQWfIbLRIVIlDMfJ4lWxL6uy/ErkfQ0tVA6ZWRF5h8c
         0PYg==
X-Gm-Message-State: AOAM530uNLgmVgtFYk3BefbuTMntFkrrra7rirFK7uiRI93NaVz23ekX
        VHe4dr0SCe7fQKXg2VPWJsE=
X-Google-Smtp-Source: ABdhPJwN1Z2UQzvnntlWy/amZSNuSoBj/nJlFK1rINxD93dAb5bOGKvY2oKNVEC6Zjj1GuDmcVJhpg==
X-Received: by 2002:a5d:680f:0:b0:20a:d858:f703 with SMTP id w15-20020a5d680f000000b0020ad858f703mr21357176wru.414.1651767234914;
        Thu, 05 May 2022 09:13:54 -0700 (PDT)
Received: from [192.168.1.7] ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id n13-20020a056000170d00b0020c5253d911sm1595572wrc.93.2022.05.05.09.13.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 May 2022 09:13:54 -0700 (PDT)
Subject: Re: [PATCH v3 0/2] kernel: add new infrastructure for platform_has()
 support
To:     Juergen Gross <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, x86@kernel.org,
        linux-s390@vger.kernel.org,
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
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
References: <20220504155703.13336-1-jgross@suse.com>
From:   Oleksandr <olekstysh@gmail.com>
Message-ID: <f7b43321-eb31-b8fb-0a65-0f5f04526be5@gmail.com>
Date:   Thu, 5 May 2022 19:13:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220504155703.13336-1-jgross@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 04.05.22 18:57, Juergen Gross wrote:


Hello Juergen

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


For both patches:

Reviewed-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>


Also I haven't faced any issues with testing current series (w/ and w/o 
xen-virtio series [1] applied) in Xen guest (Linux v5.18-rc4) on Arm64 
based board.

So, you can also add:

[Arm64 only]

Tested-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>


Thanks!


Note, I reworked patch #3 [1] to use new platform_xxx functionality:


diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index 07eb69f..1f9c3ba 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -443,6 +443,8 @@ static int __init xen_guest_init(void)
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
index a99bab8..0780a81 100644
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
+ platform_set(PLATFORM_VIRTIO_RESTRICTED_MEM_ACCESS);
+}
+
  #ifdef CONFIG_XEN_UNPOPULATED_ALLOC
  int xen_alloc_unpopulated_pages(unsigned int nr_pages, struct page 
**pages);
  void xen_free_unpopulated_pages(unsigned int nr_pages, struct page 
**pages);
(END)






>
> Juergen Gross (2):
>    kernel: add platform_has() infrastructure
>    virtio: replace arch_has_restricted_virtio_memory_access()
>
>   MAINTAINERS                            |  8 ++++++++
>   arch/s390/Kconfig                      |  1 -
>   arch/s390/mm/init.c                    | 13 +++----------
>   arch/x86/Kconfig                       |  1 -
>   arch/x86/mm/mem_encrypt.c              |  7 -------
>   arch/x86/mm/mem_encrypt_amd.c          |  4 ++++
>   drivers/virtio/Kconfig                 |  6 ------
>   drivers/virtio/virtio.c                |  5 ++---
>   include/asm-generic/Kbuild             |  1 +
>   include/asm-generic/platform-feature.h |  8 ++++++++
>   include/linux/platform-feature.h       | 19 ++++++++++++++++++
>   include/linux/virtio_config.h          |  9 ---------
>   kernel/Makefile                        |  2 +-
>   kernel/platform-feature.c              | 27 ++++++++++++++++++++++++++
>   14 files changed, 73 insertions(+), 38 deletions(-)
>   create mode 100644 include/asm-generic/platform-feature.h
>   create mode 100644 include/linux/platform-feature.h
>   create mode 100644 kernel/platform-feature.c
>
-- 
Regards,

Oleksandr Tyshchenko

