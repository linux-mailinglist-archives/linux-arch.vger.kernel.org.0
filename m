Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E59533607F1
	for <lists+linux-arch@lfdr.de>; Thu, 15 Apr 2021 13:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbhDOLE4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Apr 2021 07:04:56 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:64835 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbhDOLEz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Apr 2021 07:04:55 -0400
X-Originating-IP: 2.7.49.219
Received: from debian.home (lfbn-lyo-1-457-219.w2-7.abo.wanadoo.fr [2.7.49.219])
        (Authenticated sender: alex@ghiti.fr)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id E665324000C;
        Thu, 15 Apr 2021 11:04:27 +0000 (UTC)
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-arch@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH] riscv: Protect kernel linear mapping only if CONFIG_STRICT_KERNEL_RWX is set
Date:   Thu, 15 Apr 2021 07:04:26 -0400
Message-Id: <20210415110426.2238-1-alex@ghiti.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

If CONFIG_STRICT_KERNEL_RWX is not set, we cannot set different permissions
to the kernel data and text sections, so make sure it is defined before
trying to protect the kernel linear mapping.

Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 arch/riscv/kernel/setup.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 626003bb5fca..ab394d173cd4 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -264,12 +264,12 @@ void __init setup_arch(char **cmdline_p)
 
 	sbi_init();
 
-	if (IS_ENABLED(CONFIG_STRICT_KERNEL_RWX))
+	if (IS_ENABLED(CONFIG_STRICT_KERNEL_RWX)) {
 		protect_kernel_text_data();
-
-#if defined(CONFIG_64BIT) && defined(CONFIG_MMU)
-	protect_kernel_linear_mapping_text_rodata();
+#ifdef CONFIG_64BIT
+		protect_kernel_linear_mapping_text_rodata();
 #endif
+	}
 
 #ifdef CONFIG_SWIOTLB
 	swiotlb_init(1);
-- 
2.20.1

