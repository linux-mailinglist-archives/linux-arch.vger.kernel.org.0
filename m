Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA17693683
	for <lists+linux-arch@lfdr.de>; Sun, 12 Feb 2023 09:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjBLIqe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 12 Feb 2023 03:46:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjBLIqd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 12 Feb 2023 03:46:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0027710411;
        Sun, 12 Feb 2023 00:46:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64BFE60C79;
        Sun, 12 Feb 2023 08:46:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97661C4339E;
        Sun, 12 Feb 2023 08:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676191590;
        bh=wJKO+AO9ehGyCmpU0Nwq3DEZS0c6b1KlppYJ5nGg6XM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nwKbB+zMw9BFAoqSQ1PEav58XX8TubiRD9FWzPHjS+PetN4JGZlDDWLdp5ZaWd3iy
         B0AZJyl0tvIP813KlE+MlgwL68ykOxAHHUT5yW2h6Oe53GguBeLLCKqoupq6FDTYC5
         Qq0k6Jx3xEAABQ+xR1KwgmlXFGkQ7iaE4WRtMGs+ckdYdx+/E0+RAo6IpWSTVnXSPG
         5Af2K9uMqW3qP6LNOokN/G2+XC6Nlgfve4Rj0YfRdNcirv8rOcOHGh9Ry2WaALQwRZ
         DroMXoGsz1rviych9nxkPDi32UHxhA7zKHWb/FrTsxNbv5KkKTWNhr6C/9Jf3toM7B
         BBeqjvqC40gMQ==
From:   Mike Rapoport <rppt@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     David Airlie <airlied@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Helge Deller <deller@gmx.de>, Matt Turner <mattst88@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
        dri-devel@lists.freedesktop.org, linux-alpha@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        "Mike Rapoport (IBM)" <rppt@kernel.org>
Subject: [PATCH 1/2] char/agp: consolidate {alloc,free}_gatt_pages()
Date:   Sun, 12 Feb 2023 10:46:10 +0200
Message-Id: <20230212084611.1311177-2-rppt@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230212084611.1311177-1-rppt@kernel.org>
References: <20230212084611.1311177-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

There is a copy of alloc_gatt_pages() and free_gatt_pages in several
architectures in arch/$ARCH/include/asm/agp.h. All the copies do exactly
the same: alias alloc_gatt_pages() to __get_free_pages(GFP_KERNEL) and
alias free_gatt_pages() to free_pages().

Define alloc_gatt_pages() and free_gatt_pages() in drivers/char/agp/agp.h
and drop per-architecture definitions.

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 arch/alpha/include/asm/agp.h   | 6 ------
 arch/ia64/include/asm/agp.h    | 6 ------
 arch/parisc/include/asm/agp.h  | 6 ------
 arch/powerpc/include/asm/agp.h | 6 ------
 arch/sparc/include/asm/agp.h   | 6 ------
 arch/x86/include/asm/agp.h     | 6 ------
 drivers/char/agp/agp.h         | 6 ++++++
 7 files changed, 6 insertions(+), 36 deletions(-)

diff --git a/arch/alpha/include/asm/agp.h b/arch/alpha/include/asm/agp.h
index 7874f063d000..4197b3bc78ee 100644
--- a/arch/alpha/include/asm/agp.h
+++ b/arch/alpha/include/asm/agp.h
@@ -10,10 +10,4 @@
 #define unmap_page_from_agp(page)	do { } while (0)
 #define flush_agp_cache() mb()
 
-/* GATT allocation. Returns/accepts GATT kernel virtual address. */
-#define alloc_gatt_pages(order)		\
-	((char *)__get_free_pages(GFP_KERNEL, (order)))
-#define free_gatt_pages(table, order)	\
-	free_pages((unsigned long)(table), (order))
-
 #endif
diff --git a/arch/ia64/include/asm/agp.h b/arch/ia64/include/asm/agp.h
index 0261507dc264..f42c7dcb3d79 100644
--- a/arch/ia64/include/asm/agp.h
+++ b/arch/ia64/include/asm/agp.h
@@ -18,10 +18,4 @@
 #define unmap_page_from_agp(page)	do { } while (0)
 #define flush_agp_cache()		mb()
 
-/* GATT allocation. Returns/accepts GATT kernel virtual address. */
-#define alloc_gatt_pages(order)		\
-	((char *)__get_free_pages(GFP_KERNEL, (order)))
-#define free_gatt_pages(table, order)	\
-	free_pages((unsigned long)(table), (order))
-
 #endif /* _ASM_IA64_AGP_H */
diff --git a/arch/parisc/include/asm/agp.h b/arch/parisc/include/asm/agp.h
index 14ae54cfd368..d193a48490e2 100644
--- a/arch/parisc/include/asm/agp.h
+++ b/arch/parisc/include/asm/agp.h
@@ -12,10 +12,4 @@
 #define unmap_page_from_agp(page)	do { } while (0)
 #define flush_agp_cache()		mb()
 
-/* GATT allocation. Returns/accepts GATT kernel virtual address. */
-#define alloc_gatt_pages(order)		\
-	((char *)__get_free_pages(GFP_KERNEL, (order)))
-#define free_gatt_pages(table, order)	\
-	free_pages((unsigned long)(table), (order))
-
 #endif /* _ASM_PARISC_AGP_H */
diff --git a/arch/powerpc/include/asm/agp.h b/arch/powerpc/include/asm/agp.h
index 6b6485c988dd..e86f2ce476c9 100644
--- a/arch/powerpc/include/asm/agp.h
+++ b/arch/powerpc/include/asm/agp.h
@@ -9,11 +9,5 @@
 #define unmap_page_from_agp(page) do {} while (0)
 #define flush_agp_cache() mb()
 
-/* GATT allocation. Returns/accepts GATT kernel virtual address. */
-#define alloc_gatt_pages(order)		\
-	((char *)__get_free_pages(GFP_KERNEL, (order)))
-#define free_gatt_pages(table, order)	\
-	free_pages((unsigned long)(table), (order))
-
 #endif /* __KERNEL__ */
 #endif	/* _ASM_POWERPC_AGP_H */
diff --git a/arch/sparc/include/asm/agp.h b/arch/sparc/include/asm/agp.h
index 2d0ff84cee3f..5186924fa673 100644
--- a/arch/sparc/include/asm/agp.h
+++ b/arch/sparc/include/asm/agp.h
@@ -8,10 +8,4 @@
 #define unmap_page_from_agp(page)	do { } while (0)
 #define flush_agp_cache()		mb()
 
-/* GATT allocation. Returns/accepts GATT kernel virtual address. */
-#define alloc_gatt_pages(order)		\
-	((char *)__get_free_pages(GFP_KERNEL, (order)))
-#define free_gatt_pages(table, order)	\
-	free_pages((unsigned long)(table), (order))
-
 #endif
diff --git a/arch/x86/include/asm/agp.h b/arch/x86/include/asm/agp.h
index cd7b14322035..c8c111d8fbd7 100644
--- a/arch/x86/include/asm/agp.h
+++ b/arch/x86/include/asm/agp.h
@@ -23,10 +23,4 @@
  */
 #define flush_agp_cache() wbinvd()
 
-/* GATT allocation. Returns/accepts GATT kernel virtual address. */
-#define alloc_gatt_pages(order)		\
-	((char *)__get_free_pages(GFP_KERNEL, (order)))
-#define free_gatt_pages(table, order)	\
-	free_pages((unsigned long)(table), (order))
-
 #endif /* _ASM_X86_AGP_H */
diff --git a/drivers/char/agp/agp.h b/drivers/char/agp/agp.h
index bb09d64cd51e..8771dcc9b8e2 100644
--- a/drivers/char/agp/agp.h
+++ b/drivers/char/agp/agp.h
@@ -236,6 +236,12 @@ void agp3_generic_tlbflush(struct agp_memory *mem);
 int agp3_generic_configure(void);
 void agp3_generic_cleanup(void);
 
+/* GATT allocation. Returns/accepts GATT kernel virtual address. */
+#define alloc_gatt_pages(order)		\
+	((char *)__get_free_pages(GFP_KERNEL, (order)))
+#define free_gatt_pages(table, order)	\
+	free_pages((unsigned long)(table), (order))
+
 /* aperture sizes have been standardised since v3 */
 #define AGP_GENERIC_SIZES_ENTRIES 11
 extern const struct aper_size_info_16 agp3_generic_sizes[];
-- 
2.35.1

