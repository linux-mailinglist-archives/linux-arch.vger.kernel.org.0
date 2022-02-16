Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E104B8991
	for <lists+linux-arch@lfdr.de>; Wed, 16 Feb 2022 14:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233951AbiBPNUT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Feb 2022 08:20:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234222AbiBPNTW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Feb 2022 08:19:22 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A91299250;
        Wed, 16 Feb 2022 05:18:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4CC4BCE26EE;
        Wed, 16 Feb 2022 13:18:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A9E1C340F0;
        Wed, 16 Feb 2022 13:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645017514;
        bh=HK+tVapaV31snBn8v5Q1USmrkGxBnfuKp+8RGzmZzjI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bsuYzbxkAoiYAmxDbgE0FResaoqYp9lL2WRBFz6fdmL0V8tZZV8xaWKFJSo/3mJYx
         WdQCiIu/zsrVqbxz09YsCZ9c64A7VZw0Vdg9LFehAVDOqZCFj+XOgd0VRFqvGKGYoO
         +KodvujkWwd2KS2nWL6OlgsdBaGtV5H4BiRuPDazGZlooWEAIcbJSmY1TqXF9NJZbj
         mRzzQ8X9nW3OGRlGtXQqj1EE+it/xVoinYPLds9k81saknC5jOmycuYH/4EUfXiqIz
         PW0jEYAhflNTNWI39oCemJzad46eq07obLNFXbCilj6TnxpIOrAQV7vcvZgB/r5sRC
         yEaD2i/JrlYBA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Cc:     linux@armlinux.org.uk, will@kernel.org, guoren@kernel.org,
        bcain@codeaurora.org, geert@linux-m68k.org, monstr@monstr.eu,
        tsbogend@alpha.franken.de, nickhu@andestech.com,
        green.hu@gmail.com, dinguyen@kernel.org, shorne@gmail.com,
        deller@gmx.de, mpe@ellerman.id.au, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com, hca@linux.ibm.com,
        dalias@libc.org, davem@davemloft.net, richard@nod.at,
        x86@kernel.org, jcmvbkbc@gmail.com, ebiederm@xmission.com,
        akpm@linux-foundation.org, ardb@kernel.org,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org
Subject: [PATCH v2 17/18] ia64: remove CONFIG_SET_FS support
Date:   Wed, 16 Feb 2022 14:13:31 +0100
Message-Id: <20220216131332.1489939-18-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220216131332.1489939-1-arnd@kernel.org>
References: <20220216131332.1489939-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

ia64 only uses set_fs() in one file to handle unaligned access for
both user space and kernel instructions. Rewrite this to explicitly
pass around a flag about which one it is and drop the feature from
the architecture.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/ia64/Kconfig                   |  1 -
 arch/ia64/include/asm/processor.h   |  4 --
 arch/ia64/include/asm/thread_info.h |  2 -
 arch/ia64/include/asm/uaccess.h     | 21 +++-------
 arch/ia64/kernel/unaligned.c        | 60 +++++++++++++++++++----------
 5 files changed, 45 insertions(+), 43 deletions(-)

diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index a7e01573abd8..6b6a35b3d959 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -61,7 +61,6 @@ config IA64
 	select NEED_SG_DMA_LENGTH
 	select NUMA if !FLATMEM
 	select PCI_MSI_ARCH_FALLBACKS if PCI_MSI
-	select SET_FS
 	select ZONE_DMA32
 	default y
 	help
diff --git a/arch/ia64/include/asm/processor.h b/arch/ia64/include/asm/processor.h
index 45365c2ef598..7cbce290f4e5 100644
--- a/arch/ia64/include/asm/processor.h
+++ b/arch/ia64/include/asm/processor.h
@@ -243,10 +243,6 @@ DECLARE_PER_CPU(struct cpuinfo_ia64, ia64_cpu_info);
 
 extern void print_cpu_info (struct cpuinfo_ia64 *);
 
-typedef struct {
-	unsigned long seg;
-} mm_segment_t;
-
 #define SET_UNALIGN_CTL(task,value)								\
 ({												\
 	(task)->thread.flags = (((task)->thread.flags & ~IA64_THREAD_UAC_MASK)			\
diff --git a/arch/ia64/include/asm/thread_info.h b/arch/ia64/include/asm/thread_info.h
index 51d20cb37706..ef83493e6778 100644
--- a/arch/ia64/include/asm/thread_info.h
+++ b/arch/ia64/include/asm/thread_info.h
@@ -27,7 +27,6 @@ struct thread_info {
 	__u32 cpu;			/* current CPU */
 	__u32 last_cpu;			/* Last CPU thread ran on */
 	__u32 status;			/* Thread synchronous flags */
-	mm_segment_t addr_limit;	/* user-level address space limit */
 	int preempt_count;		/* 0=premptable, <0=BUG; will also serve as bh-counter */
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
 	__u64 utime;
@@ -48,7 +47,6 @@ struct thread_info {
 	.task		= &tsk,			\
 	.flags		= 0,			\
 	.cpu		= 0,			\
-	.addr_limit	= KERNEL_DS,		\
 	.preempt_count	= INIT_PREEMPT_COUNT,	\
 }
 
diff --git a/arch/ia64/include/asm/uaccess.h b/arch/ia64/include/asm/uaccess.h
index e242a3cc1330..60adadeb3e9e 100644
--- a/arch/ia64/include/asm/uaccess.h
+++ b/arch/ia64/include/asm/uaccess.h
@@ -42,26 +42,17 @@
 #include <asm/extable.h>
 
 /*
- * For historical reasons, the following macros are grossly misnamed:
- */
-#define KERNEL_DS	((mm_segment_t) { ~0UL })		/* cf. access_ok() */
-#define USER_DS		((mm_segment_t) { TASK_SIZE-1 })	/* cf. access_ok() */
-
-#define get_fs()  (current_thread_info()->addr_limit)
-#define set_fs(x) (current_thread_info()->addr_limit = (x))
-
-/*
- * When accessing user memory, we need to make sure the entire area really is in
- * user-level space.  In order to do this efficiently, we make sure that the page at
- * address TASK_SIZE is never valid.  We also need to make sure that the address doesn't
+ * When accessing user memory, we need to make sure the entire area really is
+ * in user-level space.  We also need to make sure that the address doesn't
  * point inside the virtually mapped linear page table.
  */
 static inline int __access_ok(const void __user *p, unsigned long size)
 {
+	unsigned long limit = TASK_SIZE;
 	unsigned long addr = (unsigned long)p;
-	unsigned long seg = get_fs().seg;
-	return likely(addr <= seg) &&
-	 (seg == KERNEL_DS.seg || likely(REGION_OFFSET(addr) < RGN_MAP_LIMIT));
+
+	return likely((size <= limit) && (addr <= (limit - size)) &&
+		 likely(REGION_OFFSET(addr) < RGN_MAP_LIMIT));
 }
 #define __access_ok __access_ok
 #include <asm-generic/access_ok.h>
diff --git a/arch/ia64/kernel/unaligned.c b/arch/ia64/kernel/unaligned.c
index 6c1a8951dfbb..0acb5a0cd7ab 100644
--- a/arch/ia64/kernel/unaligned.c
+++ b/arch/ia64/kernel/unaligned.c
@@ -749,9 +749,25 @@ emulate_load_updates (update_t type, load_store_t ld, struct pt_regs *regs, unsi
 	}
 }
 
+static int emulate_store(unsigned long ifa, void *val, int len, bool kernel_mode)
+{
+	if (kernel_mode)
+		return copy_to_kernel_nofault((void *)ifa, val, len);
+
+	return copy_to_user((void __user *)ifa, val, len);
+}
+
+static int emulate_load(void *val, unsigned long ifa, int len, bool kernel_mode)
+{
+	if (kernel_mode)
+	       return copy_from_kernel_nofault(val, (void *)ifa, len);
+
+	return copy_from_user(val, (void __user *)ifa, len);
+}
 
 static int
-emulate_load_int (unsigned long ifa, load_store_t ld, struct pt_regs *regs)
+emulate_load_int (unsigned long ifa, load_store_t ld, struct pt_regs *regs,
+		  bool kernel_mode)
 {
 	unsigned int len = 1 << ld.x6_sz;
 	unsigned long val = 0;
@@ -774,7 +790,7 @@ emulate_load_int (unsigned long ifa, load_store_t ld, struct pt_regs *regs)
 		return -1;
 	}
 	/* this assumes little-endian byte-order: */
-	if (copy_from_user(&val, (void __user *) ifa, len))
+	if (emulate_load(&val, ifa, len, kernel_mode))
 		return -1;
 	setreg(ld.r1, val, 0, regs);
 
@@ -872,7 +888,8 @@ emulate_load_int (unsigned long ifa, load_store_t ld, struct pt_regs *regs)
 }
 
 static int
-emulate_store_int (unsigned long ifa, load_store_t ld, struct pt_regs *regs)
+emulate_store_int (unsigned long ifa, load_store_t ld, struct pt_regs *regs,
+		   bool kernel_mode)
 {
 	unsigned long r2;
 	unsigned int len = 1 << ld.x6_sz;
@@ -901,7 +918,7 @@ emulate_store_int (unsigned long ifa, load_store_t ld, struct pt_regs *regs)
 	}
 
 	/* this assumes little-endian byte-order: */
-	if (copy_to_user((void __user *) ifa, &r2, len))
+	if (emulate_store(ifa, &r2, len, kernel_mode))
 		return -1;
 
 	/*
@@ -1021,7 +1038,7 @@ float2mem_double (struct ia64_fpreg *init, struct ia64_fpreg *final)
 }
 
 static int
-emulate_load_floatpair (unsigned long ifa, load_store_t ld, struct pt_regs *regs)
+emulate_load_floatpair (unsigned long ifa, load_store_t ld, struct pt_regs *regs, bool kernel_mode)
 {
 	struct ia64_fpreg fpr_init[2];
 	struct ia64_fpreg fpr_final[2];
@@ -1050,8 +1067,8 @@ emulate_load_floatpair (unsigned long ifa, load_store_t ld, struct pt_regs *regs
 		 * This assumes little-endian byte-order.  Note that there is no "ldfpe"
 		 * instruction:
 		 */
-		if (copy_from_user(&fpr_init[0], (void __user *) ifa, len)
-		    || copy_from_user(&fpr_init[1], (void __user *) (ifa + len), len))
+		if (emulate_load(&fpr_init[0], ifa, len, kernel_mode)
+		    || emulate_load(&fpr_init[1], (ifa + len), len, kernel_mode))
 			return -1;
 
 		DPRINT("ld.r1=%d ld.imm=%d x6_sz=%d\n", ld.r1, ld.imm, ld.x6_sz);
@@ -1126,7 +1143,8 @@ emulate_load_floatpair (unsigned long ifa, load_store_t ld, struct pt_regs *regs
 
 
 static int
-emulate_load_float (unsigned long ifa, load_store_t ld, struct pt_regs *regs)
+emulate_load_float (unsigned long ifa, load_store_t ld, struct pt_regs *regs,
+	            bool kernel_mode)
 {
 	struct ia64_fpreg fpr_init;
 	struct ia64_fpreg fpr_final;
@@ -1152,7 +1170,7 @@ emulate_load_float (unsigned long ifa, load_store_t ld, struct pt_regs *regs)
 	 * See comments in ldX for descriptions on how the various loads are handled.
 	 */
 	if (ld.x6_op != 0x2) {
-		if (copy_from_user(&fpr_init, (void __user *) ifa, len))
+		if (emulate_load(&fpr_init, ifa, len, kernel_mode))
 			return -1;
 
 		DPRINT("ld.r1=%d x6_sz=%d\n", ld.r1, ld.x6_sz);
@@ -1202,7 +1220,8 @@ emulate_load_float (unsigned long ifa, load_store_t ld, struct pt_regs *regs)
 
 
 static int
-emulate_store_float (unsigned long ifa, load_store_t ld, struct pt_regs *regs)
+emulate_store_float (unsigned long ifa, load_store_t ld, struct pt_regs *regs,
+		     bool kernel_mode)
 {
 	struct ia64_fpreg fpr_init;
 	struct ia64_fpreg fpr_final;
@@ -1244,7 +1263,7 @@ emulate_store_float (unsigned long ifa, load_store_t ld, struct pt_regs *regs)
 	DDUMP("fpr_init =", &fpr_init, len);
 	DDUMP("fpr_final =", &fpr_final, len);
 
-	if (copy_to_user((void __user *) ifa, &fpr_final, len))
+	if (emulate_store(ifa, &fpr_final, len, kernel_mode))
 		return -1;
 
 	/*
@@ -1295,7 +1314,6 @@ void
 ia64_handle_unaligned (unsigned long ifa, struct pt_regs *regs)
 {
 	struct ia64_psr *ipsr = ia64_psr(regs);
-	mm_segment_t old_fs = get_fs();
 	unsigned long bundle[2];
 	unsigned long opcode;
 	const struct exception_table_entry *eh = NULL;
@@ -1304,6 +1322,7 @@ ia64_handle_unaligned (unsigned long ifa, struct pt_regs *regs)
 		load_store_t insn;
 	} u;
 	int ret = -1;
+	bool kernel_mode = false;
 
 	if (ia64_psr(regs)->be) {
 		/* we don't support big-endian accesses */
@@ -1367,13 +1386,13 @@ ia64_handle_unaligned (unsigned long ifa, struct pt_regs *regs)
 			if (unaligned_dump_stack)
 				dump_stack();
 		}
-		set_fs(KERNEL_DS);
+		kernel_mode = true;
 	}
 
 	DPRINT("iip=%lx ifa=%lx isr=%lx (ei=%d, sp=%d)\n",
 	       regs->cr_iip, ifa, regs->cr_ipsr, ipsr->ri, ipsr->it);
 
-	if (__copy_from_user(bundle, (void __user *) regs->cr_iip, 16))
+	if (emulate_load(bundle, regs->cr_iip, 16, kernel_mode))
 		goto failure;
 
 	/*
@@ -1467,7 +1486,7 @@ ia64_handle_unaligned (unsigned long ifa, struct pt_regs *regs)
 	      case LDCCLR_IMM_OP:
 	      case LDCNC_IMM_OP:
 	      case LDCCLRACQ_IMM_OP:
-		ret = emulate_load_int(ifa, u.insn, regs);
+		ret = emulate_load_int(ifa, u.insn, regs, kernel_mode);
 		break;
 
 	      case ST_OP:
@@ -1478,7 +1497,7 @@ ia64_handle_unaligned (unsigned long ifa, struct pt_regs *regs)
 		fallthrough;
 	      case ST_IMM_OP:
 	      case STREL_IMM_OP:
-		ret = emulate_store_int(ifa, u.insn, regs);
+		ret = emulate_store_int(ifa, u.insn, regs, kernel_mode);
 		break;
 
 	      case LDF_OP:
@@ -1486,21 +1505,21 @@ ia64_handle_unaligned (unsigned long ifa, struct pt_regs *regs)
 	      case LDFCCLR_OP:
 	      case LDFCNC_OP:
 		if (u.insn.x)
-			ret = emulate_load_floatpair(ifa, u.insn, regs);
+			ret = emulate_load_floatpair(ifa, u.insn, regs, kernel_mode);
 		else
-			ret = emulate_load_float(ifa, u.insn, regs);
+			ret = emulate_load_float(ifa, u.insn, regs, kernel_mode);
 		break;
 
 	      case LDF_IMM_OP:
 	      case LDFA_IMM_OP:
 	      case LDFCCLR_IMM_OP:
 	      case LDFCNC_IMM_OP:
-		ret = emulate_load_float(ifa, u.insn, regs);
+		ret = emulate_load_float(ifa, u.insn, regs, kernel_mode);
 		break;
 
 	      case STF_OP:
 	      case STF_IMM_OP:
-		ret = emulate_store_float(ifa, u.insn, regs);
+		ret = emulate_store_float(ifa, u.insn, regs, kernel_mode);
 		break;
 
 	      default:
@@ -1521,7 +1540,6 @@ ia64_handle_unaligned (unsigned long ifa, struct pt_regs *regs)
 
 	DPRINT("ipsr->ri=%d iip=%lx\n", ipsr->ri, regs->cr_iip);
   done:
-	set_fs(old_fs);		/* restore original address limit */
 	return;
 
   failure:
-- 
2.29.2

