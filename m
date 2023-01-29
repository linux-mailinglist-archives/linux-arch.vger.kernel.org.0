Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12F967FF17
	for <lists+linux-arch@lfdr.de>; Sun, 29 Jan 2023 13:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235056AbjA2Mnp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 29 Jan 2023 07:43:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235078AbjA2Mnh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 29 Jan 2023 07:43:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3901923C4E;
        Sun, 29 Jan 2023 04:43:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C39BBB80C63;
        Sun, 29 Jan 2023 12:43:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB863C433A8;
        Sun, 29 Jan 2023 12:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674996199;
        bh=LN+b67L2GuYmW7NwwfmoYPOQn6/pUneVShVCsQXwAMs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R0nQr0pB/ARk6wpI1wApVcVwgzvL3nJvZL0d1rEEnUQjWCN8tFtMC8RLAoPrMcWp2
         RDTPNMDGCtYLZKrFtqYc+unayS8BpfmpBREVaITviVkY9SQqoa9DIPak7ZMaylUoNU
         XkEUMVMunXKWmZPR9BcpXjNlA5vQUkeeuQZo5bDTV+GIseFI+xGOGnl6U0jF878itf
         mh/e6H0Y33/zTuC21r/0CJPhnc1+7P3/Qqea7El3CYfWpYJrYLN7QObiWb+sV322Md
         3wRUSA/Myj0DO5A4pbRCW2jOQFtmwI9nGJsN3Q1ij2VEBYnaXPWn8lukuSf+C48vvu
         mJ0VjB6iJLE0w==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Brian Cain <bcain@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        Matt Turner <mattst88@gmail.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Simek <monstr@monstr.eu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rich Felker <dalias@libc.org>,
        Richard Weinberger <richard@nod.at>,
        Russell King <linux@armlinux.org.uk>,
        Stafford Horne <shorne@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vineet Gupta <vgupta@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
        openrisc@lists.librecores.org, sparclinux@vger.kernel.org,
        x86@kernel.org, "Mike Rapoport (IBM)" <rppt@kernel.org>
Subject: [PATCH v2 2/4] m68k: use asm-generic/memory_model.h for both MMU and !MMU
Date:   Sun, 29 Jan 2023 14:42:33 +0200
Message-Id: <20230129124235.209895-3-rppt@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230129124235.209895-1-rppt@kernel.org>
References: <20230129124235.209895-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

The MMU variant uses generic definitions of page_to_pfn() and
pfn_to_page(), but !MMU defines them in include/asm/page_no.h for no
good reason.

Include asm-generic/memory_model.h in the common include/asm/page.h and
drop redundant definitions.

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/include/asm/page.h    | 6 +-----
 arch/m68k/include/asm/page_mm.h | 1 -
 arch/m68k/include/asm/page_no.h | 2 --
 3 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/m68k/include/asm/page.h b/arch/m68k/include/asm/page.h
index 2f1c54e4725d..a5993ad83ed8 100644
--- a/arch/m68k/include/asm/page.h
+++ b/arch/m68k/include/asm/page.h
@@ -62,11 +62,7 @@ extern unsigned long _ramend;
 #include <asm/page_no.h>
 #endif
 
-#ifndef CONFIG_MMU
-#define __phys_to_pfn(paddr)	((unsigned long)((paddr) >> PAGE_SHIFT))
-#define __pfn_to_phys(pfn)	PFN_PHYS(pfn)
-#endif
-
 #include <asm-generic/getorder.h>
+#include <asm-generic/memory_model.h>
 
 #endif /* _M68K_PAGE_H */
diff --git a/arch/m68k/include/asm/page_mm.h b/arch/m68k/include/asm/page_mm.h
index a5b459bcb7d8..3903db2e8da7 100644
--- a/arch/m68k/include/asm/page_mm.h
+++ b/arch/m68k/include/asm/page_mm.h
@@ -134,7 +134,6 @@ extern int m68k_virt_to_node_shift;
 })
 
 #define ARCH_PFN_OFFSET (m68k_memory[0].addr >> PAGE_SHIFT)
-#include <asm-generic/memory_model.h>
 
 #define virt_addr_valid(kaddr)	((unsigned long)(kaddr) >= PAGE_OFFSET && (unsigned long)(kaddr) < (unsigned long)high_memory)
 #define pfn_valid(pfn)		virt_addr_valid(pfn_to_virt(pfn))
diff --git a/arch/m68k/include/asm/page_no.h b/arch/m68k/include/asm/page_no.h
index c9d0d84158a4..0a8ccef777fd 100644
--- a/arch/m68k/include/asm/page_no.h
+++ b/arch/m68k/include/asm/page_no.h
@@ -26,8 +26,6 @@ extern unsigned long memory_end;
 #define virt_to_page(addr)	(mem_map + (((unsigned long)(addr)-PAGE_OFFSET) >> PAGE_SHIFT))
 #define page_to_virt(page)	__va(((((page) - mem_map) << PAGE_SHIFT) + PAGE_OFFSET))
 
-#define pfn_to_page(pfn)	virt_to_page(pfn_to_virt(pfn))
-#define page_to_pfn(page)	virt_to_pfn(page_to_virt(page))
 #define pfn_valid(pfn)	        ((pfn) < max_mapnr)
 
 #define	virt_addr_valid(kaddr)	(((unsigned long)(kaddr) >= PAGE_OFFSET) && \
-- 
2.35.1

