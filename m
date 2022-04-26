Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B4750FF53
	for <lists+linux-arch@lfdr.de>; Tue, 26 Apr 2022 15:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351035AbiDZNnm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Apr 2022 09:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241907AbiDZNnh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Apr 2022 09:43:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CF033EB8;
        Tue, 26 Apr 2022 06:40:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EB126210F4;
        Tue, 26 Apr 2022 13:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650980427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h5CLSs8Gh8CUFGudIyexUA79QqWpuqzqatZWV14fpNY=;
        b=p76aud3+uM4DlZad34bO/RHvxRamw8cjqkEXnBAz8uiZwWfGCLLNvmXRonqcFizU74PLFE
        bWNSa66L2fZycOqbxnYy5lbyyj5IsPvXGJ/fXNIZXHgVj9iphuMYQtknm0bhsIVbDpbUms
        xqSFgJILL5apX3LMQPa2/P45OEhgiiQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 46CBA13223;
        Tue, 26 Apr 2022 13:40:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cBIJEEv2Z2ImNQAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 26 Apr 2022 13:40:27 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-hyperv@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     Juergen Gross <jgross@suse.com>, Arnd Bergmann <arnd@arndb.de>,
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
        Christoph Hellwig <hch@infradead.org>,
        Oleksandr Tyshchenko <olekstysh@gmail.com>
Subject: [PATCH 2/2] virtio: replace arch_has_restricted_virtio_memory_access()
Date:   Tue, 26 Apr 2022 15:40:21 +0200
Message-Id: <20220426134021.11210-3-jgross@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220426134021.11210-1-jgross@suse.com>
References: <20220426134021.11210-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Instead of using arch_has_restricted_virtio_memory_access() together
with CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS, replace those
with platform_has() and a new platform feature
PLATFORM_VIRTIO_RESTRICTED_MEM_ACCESS.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
I've only done a compile test on x86 for now, as I can't test these
changes easily (SEV might be doable for me, but s390 isn't).
---
 arch/s390/Kconfig                  |  1 -
 arch/s390/mm/init.c                | 13 +++----------
 arch/x86/Kconfig                   |  1 -
 arch/x86/kernel/cpu/mshyperv.c     |  5 ++++-
 arch/x86/mm/mem_encrypt.c          |  6 ------
 arch/x86/mm/mem_encrypt_identity.c |  5 +++++
 drivers/virtio/Kconfig             |  6 ------
 drivers/virtio/virtio.c            |  5 ++---
 include/linux/platform-feature.h   |  3 ++-
 include/linux/virtio_config.h      |  9 ---------
 10 files changed, 16 insertions(+), 38 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index e084c72104f8..f97a22ae69a8 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -772,7 +772,6 @@ menu "Virtualization"
 config PROTECTED_VIRTUALIZATION_GUEST
 	def_bool n
 	prompt "Protected virtualization guest support"
-	select ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
 	help
 	  Select this option, if you want to be able to run this
 	  kernel as a protected virtualization KVM guest.
diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index 86ffd0d51fd5..8e4fa10c6b12 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -31,6 +31,7 @@
 #include <linux/cma.h>
 #include <linux/gfp.h>
 #include <linux/dma-direct.h>
+#include <linux/platform-feature.h>
 #include <asm/processor.h>
 #include <linux/uaccess.h>
 #include <asm/pgalloc.h>
@@ -168,22 +169,14 @@ bool force_dma_unencrypted(struct device *dev)
 	return is_prot_virt_guest();
 }
 
-#ifdef CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
-
-int arch_has_restricted_virtio_memory_access(void)
-{
-	return is_prot_virt_guest();
-}
-EXPORT_SYMBOL(arch_has_restricted_virtio_memory_access);
-
-#endif
-
 /* protected virtualization */
 static void pv_init(void)
 {
 	if (!is_prot_virt_guest())
 		return;
 
+	platform_set_feature(PLATFORM_VIRTIO_RESTRICTED_MEM_ACCESS);
+
 	/* make sure bounce buffers are shared */
 	swiotlb_force = SWIOTLB_FORCE;
 	swiotlb_init(1);
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index b0142e01002e..20ac72546ae4 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1515,7 +1515,6 @@ config X86_CPA_STATISTICS
 config X86_MEM_ENCRYPT
 	select ARCH_HAS_FORCE_DMA_UNENCRYPTED
 	select DYNAMIC_PHYSICAL_MASK
-	select ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
 	def_bool n
 
 config AMD_MEM_ENCRYPT
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 4b67094215bb..435611d83895 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -19,6 +19,7 @@
 #include <linux/i8253.h>
 #include <linux/random.h>
 #include <linux/swiotlb.h>
+#include <linux/platform-feature.h>
 #include <asm/processor.h>
 #include <asm/hypervisor.h>
 #include <asm/hyperv-tlfs.h>
@@ -347,8 +348,10 @@ static void __init ms_hyperv_init_platform(void)
 #endif
 		/* Isolation VMs are unenlightened SEV-based VMs, thus this check: */
 		if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
-			if (hv_get_isolation_type() != HV_ISOLATION_TYPE_NONE)
+			if (hv_get_isolation_type() != HV_ISOLATION_TYPE_NONE) {
 				cc_set_vendor(CC_VENDOR_HYPERV);
+				platform_set_feature(PLATFORM_VIRTIO_RESTRICTED_MEM_ACCESS);
+			}
 		}
 	}
 
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 50d209939c66..9b6a7c98b2b1 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -76,9 +76,3 @@ void __init mem_encrypt_init(void)
 
 	print_mem_encrypt_feature_info();
 }
-
-int arch_has_restricted_virtio_memory_access(void)
-{
-	return cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT);
-}
-EXPORT_SYMBOL_GPL(arch_has_restricted_virtio_memory_access);
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index b43bc24d2bb6..6043ba6cd17d 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -40,6 +40,7 @@
 #include <linux/mm.h>
 #include <linux/mem_encrypt.h>
 #include <linux/cc_platform.h>
+#include <linux/platform-feature.h>
 
 #include <asm/setup.h>
 #include <asm/sections.h>
@@ -566,6 +567,10 @@ void __init sme_enable(struct boot_params *bp)
 	} else {
 		/* SEV state cannot be controlled by a command line option */
 		sme_me_mask = me_mask;
+
+		/* Set restricted memory access for virtio. */
+		platform_set_feature(PLATFORM_VIRTIO_RESTRICTED_MEM_ACCESS);
+
 		goto out;
 	}
 
diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index b5adf6abd241..a6dc8b5846fe 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -6,12 +6,6 @@ config VIRTIO
 	  bus, such as CONFIG_VIRTIO_PCI, CONFIG_VIRTIO_MMIO, CONFIG_RPMSG
 	  or CONFIG_S390_GUEST.
 
-config ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
-	bool
-	help
-	  This option is selected if the architecture may need to enforce
-	  VIRTIO_F_ACCESS_PLATFORM
-
 config VIRTIO_PCI_LIB
 	tristate
 	help
diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 22f15f444f75..371e16b18381 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -5,6 +5,7 @@
 #include <linux/module.h>
 #include <linux/idr.h>
 #include <linux/of.h>
+#include <linux/platform-feature.h>
 #include <uapi/linux/virtio_ids.h>
 
 /* Unique numbering for virtio devices. */
@@ -170,12 +171,10 @@ EXPORT_SYMBOL_GPL(virtio_add_status);
 static int virtio_features_ok(struct virtio_device *dev)
 {
 	unsigned status;
-	int ret;
 
 	might_sleep();
 
-	ret = arch_has_restricted_virtio_memory_access();
-	if (ret) {
+	if (platform_has(PLATFORM_VIRTIO_RESTRICTED_MEM_ACCESS)) {
 		if (!virtio_has_feature(dev, VIRTIO_F_VERSION_1)) {
 			dev_warn(&dev->dev,
 				 "device must provide VIRTIO_F_VERSION_1\n");
diff --git a/include/linux/platform-feature.h b/include/linux/platform-feature.h
index df393d502a4f..34b649aaa1da 100644
--- a/include/linux/platform-feature.h
+++ b/include/linux/platform-feature.h
@@ -6,7 +6,8 @@
 #include <asm/platform-feature.h>
 
 /* The platform features are starting with the architecture specific ones. */
-#define PLATFORM_FEAT_N				(0 + PLATFORM_ARCH_FEAT_N)
+#define PLATFORM_VIRTIO_RESTRICTED_MEM_ACCESS	0
+#define PLATFORM_FEAT_N				(1 + PLATFORM_ARCH_FEAT_N)
 
 #define PLATFORM_FEAT_ARRAY_SZ	BITS_TO_LONGS(PLATFORM_FEAT_N)
 extern unsigned long platform_features[PLATFORM_FEAT_ARRAY_SZ];
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index b341dd62aa4d..79498298519d 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -559,13 +559,4 @@ static inline void virtio_cwrite64(struct virtio_device *vdev,
 		_r;							\
 	})
 
-#ifdef CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
-int arch_has_restricted_virtio_memory_access(void);
-#else
-static inline int arch_has_restricted_virtio_memory_access(void)
-{
-	return 0;
-}
-#endif /* CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS */
-
 #endif /* _LINUX_VIRTIO_CONFIG_H */
-- 
2.34.1

