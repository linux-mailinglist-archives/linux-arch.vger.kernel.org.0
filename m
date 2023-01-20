Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3326756AC
	for <lists+linux-arch@lfdr.de>; Fri, 20 Jan 2023 15:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbjATOM3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Jan 2023 09:12:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbjATOLq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Jan 2023 09:11:46 -0500
Received: from fx403.security-mail.net (smtpout140.security-mail.net [85.31.212.143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB58C79C6
        for <linux-arch@vger.kernel.org>; Fri, 20 Jan 2023 06:11:00 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by fx403.security-mail.net (Postfix) with ESMTP id 0B11A46598F
        for <linux-arch@vger.kernel.org>; Fri, 20 Jan 2023 15:10:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1674223832;
        bh=tjQ30Z9ergbd5QQmn2LPAl2FE9a2esEgGsVsX8Hkh0Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=a1RUVvPhJFSFfSrK+MJedITiIbeTOz6d2WXE+CgVg0vhyCZ330cex/JmdzdC9kSw/
         zzl01cp2UY3crt0esWNgJaSFs/qidpM4TxmvACe/rDqYNV460xpO8sZGt8tOlyfQSE
         DH7MWRkN0pAddwy84zLXwKR6tDw8lLfyknEyxiAQ=
Received: from fx403 (localhost [127.0.0.1]) by fx403.security-mail.net
 (Postfix) with ESMTP id C5FF646527B; Fri, 20 Jan 2023 15:10:31 +0100 (CET)
Received: from zimbra2.kalray.eu (unknown [217.181.231.53]) by
 fx403.security-mail.net (Postfix) with ESMTPS id AE5D8465448; Fri, 20 Jan
 2023 15:10:30 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTPS id 4CC1A27E0440; Fri, 20 Jan 2023
 15:10:30 +0100 (CET)
Received: from localhost (localhost [127.0.0.1]) by zimbra2.kalray.eu
 (Postfix) with ESMTP id 2CBC627E043A; Fri, 20 Jan 2023 15:10:30 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1]) by localhost
 (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026) with ESMTP id
 Vglx1afFJmpx; Fri, 20 Jan 2023 15:10:30 +0100 (CET)
Received: from junon.lin.mbt.kalray.eu (unknown [192.168.37.161]) by
 zimbra2.kalray.eu (Postfix) with ESMTPSA id B43BA27E043D; Fri, 20 Jan 2023
 15:10:29 +0100 (CET)
X-Virus-Scanned: E-securemail
Secumail-id: <f06a.63caa0d6.ac49d.0>
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 2CBC627E043A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
 s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1674223830;
 bh=7ihbYuWX1g/NOZf5apPInAkKPctju2YordzLcMMvd+8=;
 h=From:To:Date:Message-Id:MIME-Version;
 b=YUYYebIRIJ5bk8n/CH4YvMdtNpTm9QVYSikQs07+iRmxxq3rubrDIth9BkffMcReC
 s/DZFrr3fFNMHE0WuwO9jyrorHXjMRuprOkFWk9k7sCTRKtwBpoZVgMyehGNcXP0g1
 2ygHrIFYBeDLTMm7y6M6ROAh2tifNdoeEu7Qcwv4=
From:   Yann Sionneau <ysionneau@kalray.eu>
To:     Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jules Maselbas <jmaselbas@kalray.eu>,
        Yann Sionneau <ysionneau@kalray.eu>,
        Guillaume Thouvenin <gthouvenin@kalray.eu>,
        Clement Leger <clement@clement-leger.fr>,
        Vincent Chardon <vincent.chardon@elsys-design.com>,
        Marc =?utf-8?b?UG91bGhpw6hz?= <dkm@kataplop.net>,
        Julian Vetter <jvetter@kalray.eu>,
        Samuel Jones <sjones@kalray.eu>,
        Ashley Lesdalons <alesdalons@kalray.eu>,
        Thomas Costis <tcostis@kalray.eu>,
        Marius Gligor <mgligor@kalray.eu>,
        Jonathan Borne <jborne@kalray.eu>,
        Julien Villette <jvillette@kalray.eu>,
        Luc Michel <lmichel@kalray.eu>,
        Louis Morhet <lmorhet@kalray.eu>,
        Julien Hascoet <jhascoet@kalray.eu>,
        Jean-Christophe Pince <jcpince@gmail.com>,
        Guillaume Missonnier <gmissonnier@kalray.eu>,
        Alex Michon <amichon@kalray.eu>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <git@xen0n.name>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        John Garry <john.garry@huawei.com>,
        Guangbin Huang <huangguangbin2@huawei.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        Bibo Mao <maobibo@loongson.cn>,
        Atish Patra <atishp@atishpatra.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Qi Liu <liuqi115@huawei.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Janosch Frank <frankja@linux.ibm.com>,
        Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Benjamin Mugnier <mugnier.benjamin@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-audit@redhat.com,
        linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Subject: [RFC PATCH v2 12/31] kvx: Add other common headers
Date:   Fri, 20 Jan 2023 15:09:43 +0100
Message-ID: <20230120141002.2442-13-ysionneau@kalray.eu>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230120141002.2442-1-ysionneau@kalray.eu>
References: <20230120141002.2442-1-ysionneau@kalray.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add some other common headers for basic kvx support.

Co-developed-by: Clement Leger <clement@clement-leger.fr>
Signed-off-by: Clement Leger <clement@clement-leger.fr>
Co-developed-by: Julian Vetter <jvetter@kalray.eu>
Signed-off-by: Julian Vetter <jvetter@kalray.eu>
Co-developed-by: Vincent Chardon <vincent.chardon@elsys-design.com>
Signed-off-by: Vincent Chardon <vincent.chardon@elsys-design.com>
Co-developed-by: Yann Sionneau <ysionneau@kalray.eu>
Signed-off-by: Yann Sionneau <ysionneau@kalray.eu>
---

Notes:
    V1 -> V2: no changes

 arch/kvx/include/asm/asm-prototypes.h   | 14 ++++++++
 arch/kvx/include/asm/clocksource.h      | 17 +++++++++
 arch/kvx/include/asm/linkage.h          | 13 +++++++
 arch/kvx/include/asm/pci.h              | 36 +++++++++++++++++++
 arch/kvx/include/asm/sections.h         | 18 ++++++++++
 arch/kvx/include/asm/spinlock.h         | 16 +++++++++
 arch/kvx/include/asm/spinlock_types.h   | 17 +++++++++
 arch/kvx/include/asm/stackprotector.h   | 47 +++++++++++++++++++++++++
 arch/kvx/include/asm/timex.h            | 20 +++++++++++
 arch/kvx/include/asm/types.h            | 12 +++++++
 arch/kvx/include/uapi/asm/bitsperlong.h | 14 ++++++++
 arch/kvx/include/uapi/asm/byteorder.h   | 12 +++++++
 tools/include/uapi/asm/bitsperlong.h    |  2 ++
 13 files changed, 238 insertions(+)
 create mode 100644 arch/kvx/include/asm/asm-prototypes.h
 create mode 100644 arch/kvx/include/asm/clocksource.h
 create mode 100644 arch/kvx/include/asm/linkage.h
 create mode 100644 arch/kvx/include/asm/pci.h
 create mode 100644 arch/kvx/include/asm/sections.h
 create mode 100644 arch/kvx/include/asm/spinlock.h
 create mode 100644 arch/kvx/include/asm/spinlock_types.h
 create mode 100644 arch/kvx/include/asm/stackprotector.h
 create mode 100644 arch/kvx/include/asm/timex.h
 create mode 100644 arch/kvx/include/asm/types.h
 create mode 100644 arch/kvx/include/uapi/asm/bitsperlong.h
 create mode 100644 arch/kvx/include/uapi/asm/byteorder.h

diff --git a/arch/kvx/include/asm/asm-prototypes.h b/arch/kvx/include/asm/asm-prototypes.h
new file mode 100644
index 000000000000..af032508e30c
--- /dev/null
+++ b/arch/kvx/include/asm/asm-prototypes.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#ifndef _ASM_KVX_ASM_PROTOTYPES_H
+#define _ASM_KVX_ASM_PROTOTYPES_H
+
+#include <asm/string.h>
+
+#include <asm-generic/asm-prototypes.h>
+
+#endif /* _ASM_KVX_ASM_PROTOTYPES_H */
diff --git a/arch/kvx/include/asm/clocksource.h b/arch/kvx/include/asm/clocksource.h
new file mode 100644
index 000000000000..4df7c66ffbb5
--- /dev/null
+++ b/arch/kvx/include/asm/clocksource.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Yann Sionneau
+ *            Clement Leger
+ */
+
+#ifndef _ASM_KVX_CLOCKSOURCE_H
+#define _ASM_KVX_CLOCKSOURCE_H
+
+#include <linux/compiler.h>
+
+struct arch_clocksource_data {
+	void __iomem *regs;
+};
+
+#endif /* _ASM_KVX_CLOCKSOURCE_H */
diff --git a/arch/kvx/include/asm/linkage.h b/arch/kvx/include/asm/linkage.h
new file mode 100644
index 000000000000..84e1cacf67c2
--- /dev/null
+++ b/arch/kvx/include/asm/linkage.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Yann Sionneau
+ */
+
+#ifndef __ASM_KVX_LINKAGE_H
+#define __ASM_KVX_LINKAGE_H
+
+#define __ALIGN		.align 4
+#define __ALIGN_STR	".align 4"
+
+#endif
diff --git a/arch/kvx/include/asm/pci.h b/arch/kvx/include/asm/pci.h
new file mode 100644
index 000000000000..d5bbaaf041b5
--- /dev/null
+++ b/arch/kvx/include/asm/pci.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Vincent Chardon
+ *            Clement Leger
+ */
+
+#ifndef __ASM_KVX_PCI_H_
+#define __ASM_KVX_PCI_H_
+
+#include <linux/dma-mapping.h>
+#include <linux/pci.h>
+#include <linux/of_gpio.h>
+
+#define ARCH_GENERIC_PCI_MMAP_RESOURCE	1
+#define HAVE_PCI_MMAP			1
+
+extern int isa_dma_bridge_buggy;
+
+/* Can be used to override the logic in pci_scan_bus for skipping
+ * already-configured bus numbers - to be used for buggy BIOSes
+ * or architectures with incomplete PCI setup by the loader.
+ */
+#define pcibios_assign_all_busses()	0
+
+#define PCIBIOS_MIN_IO          0UL
+#define PCIBIOS_MIN_MEM         0UL
+
+#ifdef CONFIG_PCI_DOMAINS
+static inline int pci_proc_domain(struct pci_bus *bus)
+{
+		return pci_domain_nr(bus);
+}
+#endif /*  CONFIG_PCI_DOMAINS */
+
+#endif /* _ASM_KVX_PCI_H */
diff --git a/arch/kvx/include/asm/sections.h b/arch/kvx/include/asm/sections.h
new file mode 100644
index 000000000000..0777675ef264
--- /dev/null
+++ b/arch/kvx/include/asm/sections.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#ifndef _ASM_KVX_SECTIONS_H
+#define _ASM_KVX_SECTIONS_H
+
+#include <asm-generic/sections.h>
+
+extern char __rodata_start[], __rodata_end[];
+extern char __initdata_start[], __initdata_end[];
+extern char __inittext_start[], __inittext_end[];
+extern char __exception_start[], __exception_end[];
+extern char __rm_firmware_regs_start[];
+
+#endif
diff --git a/arch/kvx/include/asm/spinlock.h b/arch/kvx/include/asm/spinlock.h
new file mode 100644
index 000000000000..ed32fdba1e19
--- /dev/null
+++ b/arch/kvx/include/asm/spinlock.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#ifndef _ASM_KVX_SPINLOCK_H
+#define _ASM_KVX_SPINLOCK_H
+
+#include <asm/qspinlock.h>
+#include <asm/qrwlock.h>
+
+/* See include/linux/spinlock.h */
+#define smp_mb__after_spinlock()	smp_mb()
+
+#endif
diff --git a/arch/kvx/include/asm/spinlock_types.h b/arch/kvx/include/asm/spinlock_types.h
new file mode 100644
index 000000000000..929a7df16ef3
--- /dev/null
+++ b/arch/kvx/include/asm/spinlock_types.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#ifndef _ASM_KVX_SPINLOCK_TYPES_H
+#define _ASM_KVX_SPINLOCK_TYPES_H
+
+#if !defined(__LINUX_SPINLOCK_TYPES_RAW_H) && !defined(__ASM_SPINLOCK_H)
+# error "please don't include this file directly"
+#endif
+
+#include <asm-generic/qspinlock_types.h>
+#include <asm-generic/qrwlock_types.h>
+
+#endif /* _ASM_KVX_SPINLOCK_TYPES_H */
diff --git a/arch/kvx/include/asm/stackprotector.h b/arch/kvx/include/asm/stackprotector.h
new file mode 100644
index 000000000000..2c190bbb5efc
--- /dev/null
+++ b/arch/kvx/include/asm/stackprotector.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * derived from arch/mips/include/asm/stackprotector.h
+ *
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+/*
+ * GCC stack protector support.
+ *
+ * Stack protector works by putting predefined pattern at the start of
+ * the stack frame and verifying that it hasn't been overwritten when
+ * returning from the function.  The pattern is called stack canary
+ * and gcc expects it to be defined by a global variable called
+ * "__stack_chk_guard" on KVX.  This unfortunately means that on SMP
+ * we cannot have a different canary value per task.
+ */
+
+#ifndef __ASM_STACKPROTECTOR_H
+#define __ASM_STACKPROTECTOR_H
+
+#include <linux/random.h>
+#include <linux/version.h>
+
+extern unsigned long __stack_chk_guard;
+
+/*
+ * Initialize the stackprotector canary value.
+ *
+ * NOTE: this must only be called from functions that never return,
+ * and it must always be inlined.
+ */
+static __always_inline void boot_init_stack_canary(void)
+{
+	unsigned long canary;
+
+	/* Try to get a semi random initial value. */
+	get_random_bytes(&canary, sizeof(canary));
+	canary ^= LINUX_VERSION_CODE;
+	canary &= CANARY_MASK;
+
+	current->stack_canary = canary;
+	__stack_chk_guard = current->stack_canary;
+}
+
+#endif	/* _ASM_STACKPROTECTOR_H */
diff --git a/arch/kvx/include/asm/timex.h b/arch/kvx/include/asm/timex.h
new file mode 100644
index 000000000000..51e346faa887
--- /dev/null
+++ b/arch/kvx/include/asm/timex.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#ifndef _ASM_KVX_TIMEX_H
+#define _ASM_KVX_TIMEX_H
+
+#define get_cycles get_cycles
+
+#include <asm/sfr.h>
+#include <asm-generic/timex.h>
+
+static inline cycles_t get_cycles(void)
+{
+	return kvx_sfr_get(PM0);
+}
+
+#endif	/* _ASM_KVX_TIMEX_H */
diff --git a/arch/kvx/include/asm/types.h b/arch/kvx/include/asm/types.h
new file mode 100644
index 000000000000..1e6c024ee892
--- /dev/null
+++ b/arch/kvx/include/asm/types.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#ifndef _ASM_KVX_TYPES_H
+#define _ASM_KVX_TYPES_H
+
+#include <asm-generic/int-ll64.h>
+
+#endif	/* _ASM_KVX_TYPES_H */
diff --git a/arch/kvx/include/uapi/asm/bitsperlong.h b/arch/kvx/include/uapi/asm/bitsperlong.h
new file mode 100644
index 000000000000..02a91596d567
--- /dev/null
+++ b/arch/kvx/include/uapi/asm/bitsperlong.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#ifndef _UAPI_ASM_KVX_BITSPERLONG_H
+#define _UAPI_ASM_KVX_BITSPERLONG_H
+
+#define __BITS_PER_LONG 64
+
+#include <asm-generic/bitsperlong.h>
+
+#endif /* _UAPI_ASM_KVX_BITSPERLONG_H */
diff --git a/arch/kvx/include/uapi/asm/byteorder.h b/arch/kvx/include/uapi/asm/byteorder.h
new file mode 100644
index 000000000000..b7d827daec73
--- /dev/null
+++ b/arch/kvx/include/uapi/asm/byteorder.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
+/*
+ * Copyright (C) 2017-2023 Kalray Inc.
+ * Author(s): Clement Leger
+ */
+
+#ifndef _ASM_KVX_BYTEORDER_H
+#define _ASM_KVX_BYTEORDER_H
+
+#include <linux/byteorder/little_endian.h>
+
+#endif	/* _ASM_KVX_BYTEORDER_H */
diff --git a/tools/include/uapi/asm/bitsperlong.h b/tools/include/uapi/asm/bitsperlong.h
index da5206517158..40272ffa9c32 100644
--- a/tools/include/uapi/asm/bitsperlong.h
+++ b/tools/include/uapi/asm/bitsperlong.h
@@ -19,6 +19,8 @@
 #include "../../../arch/alpha/include/uapi/asm/bitsperlong.h"
 #elif defined(__loongarch__)
 #include "../../../arch/loongarch/include/uapi/asm/bitsperlong.h"
+#elif defined(__kvx__)
+#include "../../../arch/kvx/include/uapi/asm/bitsperlong.h"
 #else
 #include <asm-generic/bitsperlong.h>
 #endif
-- 
2.37.2





