Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2DC267FF07
	for <lists+linux-arch@lfdr.de>; Sun, 29 Jan 2023 13:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234941AbjA2MnN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 29 Jan 2023 07:43:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234954AbjA2MnM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 29 Jan 2023 07:43:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEAB125A7;
        Sun, 29 Jan 2023 04:43:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 980EAB80C2C;
        Sun, 29 Jan 2023 12:43:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52C73C433A7;
        Sun, 29 Jan 2023 12:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674996188;
        bh=cgWDMwNotrvgtwLOXkxr022OhYpC4uBm5qKZZMTCdc4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UOlDKwso6wRfZVylh618GS0Ouplr5vx0EbZPPHD3xUb+8QoPpiFEHadR57onqorCd
         YVV0X4T7n8gLAlDCcDoHkjHy+WzsJoiwhi5dfYlZ0/SJbhBTB4CLpq8O6xDe8ABdAj
         ibLF/6hCOLr13VOj/azi035hOFFfeFmuDXjRvCo9nQzUAZ1DneDknyLVqg+z3u91Hb
         JSM0yS+mjSe2REo/FRs3DbdIX7npqpWYBVELIqlPxuJWRXDIEj2eP/ud0TKhe2R7e/
         shdVeHbLA/9GwBZjKAbCX1zbNI+chUKkqGr1E/I9bnpduDb0l68n12sXR48UTQjqrn
         2HPElfopuZj9Q==
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
Subject: [PATCH v2 1/4] arm: include asm-generic/memory_model.h from page.h rather than memory.h
Date:   Sun, 29 Jan 2023 14:42:32 +0200
Message-Id: <20230129124235.209895-2-rppt@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230129124235.209895-1-rppt@kernel.org>
References: <20230129124235.209895-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

Makes it consistent with other architectures and allows for generic
definition of pfn_valid() in asm-generic/memory_model.h with clear override
in arch/arm/include/asm/page.h

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 arch/arm/include/asm/memory.h | 2 --
 arch/arm/include/asm/page.h   | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index d8eef4bd8c71..62e9df024445 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -386,6 +386,4 @@ static inline unsigned long __virt_to_idmap(unsigned long x)
 
 #endif
 
-#include <asm-generic/memory_model.h>
-
 #endif
diff --git a/arch/arm/include/asm/page.h b/arch/arm/include/asm/page.h
index 5fcc8a600e36..74bb5947b387 100644
--- a/arch/arm/include/asm/page.h
+++ b/arch/arm/include/asm/page.h
@@ -158,6 +158,7 @@ typedef struct page *pgtable_t;
 
 #ifdef CONFIG_HAVE_ARCH_PFN_VALID
 extern int pfn_valid(unsigned long);
+#define pfn_valid pfn_valid
 #endif
 
 #include <asm/memory.h>
@@ -167,5 +168,6 @@ extern int pfn_valid(unsigned long);
 #define VM_DATA_DEFAULT_FLAGS	VM_DATA_FLAGS_TSK_EXEC
 
 #include <asm-generic/getorder.h>
+#include <asm-generic/memory_model.h>
 
 #endif
-- 
2.35.1

