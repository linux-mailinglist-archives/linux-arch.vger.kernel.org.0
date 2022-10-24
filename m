Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC57E609AF5
	for <lists+linux-arch@lfdr.de>; Mon, 24 Oct 2022 09:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiJXHFr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Oct 2022 03:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbiJXHFk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Oct 2022 03:05:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D76F481C0;
        Mon, 24 Oct 2022 00:05:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61AB961018;
        Mon, 24 Oct 2022 07:05:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74943C433D6;
        Mon, 24 Oct 2022 07:05:28 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Feiyang Chen <chenfeiyang@loongson.cn>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH V13 4/4] LoongArch: Enable ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
Date:   Mon, 24 Oct 2022 15:01:05 +0800
Message-Id: <20221024070105.306280-5-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221024070105.306280-1-chenhuacai@loongson.cn>
References: <20221024070105.306280-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Feiyang Chen <chenfeiyang@loongson.cn>

The feature of minimizing overhead of struct page associated with each
HugeTLB page is implemented on x86_64. However, the infrastructure of
this feature is already there, so just select ARCH_WANT_HUGETLB_PAGE_
OPTIMIZE_VMEMMAP is enough to enable this feature for LoongArch.

To avoid the following build error on LoongArch we should include linux/
static_key.h in page-flags.h. This is straightforward but the build
error is implicitly a LoongArch-specific problem, because ARM64 and X86
have already include static_key.h from their arch-specific core headers.

In file included from ./include/linux/mmzone.h:22,
from ./include/linux/gfp.h:6,
from ./include/linux/mm.h:7,
from arch/loongarch/kernel/asm-offsets.c:9:
./include/linux/page-flags.h:208:1: warning: data definition has no
type or storage class
208 | DECLARE_STATIC_KEY_MAYBE(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON,
| ^~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/page-flags.h:208:1: error: type defaults to 'int' in
declaration of 'DECLARE_STATIC_KEY_MAYBE' [-Werror=implicit-int]
./include/linux/page-flags.h:209:26: warning: parameter names (without
types) in function declaration
209 | hugetlb_optimize_vmemmap_key);
| ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/page-flags.h: In function 'hugetlb_optimize_vmemmap_enabled':
./include/linux/page-flags.h:213:16: error: implicit declaration of
function 'static_branch_maybe' [-Werror=implicit-function-declaration]
213 | return static_branch_maybe(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON,
| ^~~~~~~~~~~~~~~~~~~
./include/linux/page-flags.h:213:36: error:
'CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON' undeclared (first
use in this function); did you mean
'CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP'?
213 | return static_branch_maybe(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON,
| ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
| CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
./include/linux/page-flags.h:213:36: note: each undeclared identifier
is reported only once for each function it appears in
./include/linux/page-flags.h:214:37: error:
'hugetlb_optimize_vmemmap_key' undeclared (first use in this
function); did you mean 'hugetlb_optimize_vmemmap_enabled'?
214 | &hugetlb_optimize_vmemmap_key);
| ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
| hugetlb_optimize_vmemmap_enabled

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/Kconfig     | 1 +
 include/linux/page-flags.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 6f7fa0c0ca08..0a6ef613124c 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -52,6 +52,7 @@ config LOONGARCH
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_USE_QUEUED_SPINLOCKS
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
+	select ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
 	select ARCH_WANT_LD_ORPHAN_WARN
 	select ARCH_WANTS_NO_INSTR
 	select BUILDTIME_TABLE_SORT
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 0b0ae5084e60..1aafdc73e399 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -9,6 +9,7 @@
 #include <linux/types.h>
 #include <linux/bug.h>
 #include <linux/mmdebug.h>
+#include <linux/static_key.h>
 #ifndef __GENERATING_BOUNDS_H
 #include <linux/mm_types.h>
 #include <generated/bounds.h>
-- 
2.31.1

