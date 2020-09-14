Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D15A2693B5
	for <lists+linux-arch@lfdr.de>; Mon, 14 Sep 2020 19:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgINRkv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Sep 2020 13:40:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:52902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbgINRkj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 14 Sep 2020 13:40:39 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4C1220732;
        Mon, 14 Sep 2020 17:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600105215;
        bh=if6Es0VsB8MaG8QejheWTTYU8BkRC0QntRBGhvtidoM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LQwm0vYOwRa7KiiLyHjdP5hGoS85NhaSFbL460dFopmIRGmfiHT9zPxoVMwNXL+uN
         1lehAo3GZ6IPLVD/5VMtLvd6+rKR+3YEXCXzdx1Oj9Pwn4obsLfGYMrVllqkg4Ozam
         YHtIERNA5xYGuoqCtHn5QMr6IjWaQQGnN8X0dzmo=
Date:   Mon, 14 Sep 2020 18:40:09 +0100
From:   Will Deacon <will@kernel.org>
To:     David Brazdil <dbrazdil@google.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Arnd Bergmann <arnd@arndb.de>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, linux-arch@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v2 00/10] Independent per-CPU data section for nVHE
Message-ID: <20200914174008.GA25238@willie-the-truck>
References: <20200903091712.46456-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903091712.46456-1-dbrazdil@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi David,

On Thu, Sep 03, 2020 at 11:17:02AM +0200, David Brazdil wrote:
> Introduce '.hyp.data..percpu' as part of ongoing effort to make nVHE
> hyp code self-contained and independent of the rest of the kernel.
> 
> The series builds on top of the "Split off nVHE hyp code" series which
> used objcopy to rename '.text' to '.hyp.text' and prefix all ELF
> symbols with '__kvm_nvhe' for all object files under kvm/hyp/nvhe.

I've been playing around with this series this afternoon, trying to see
if we can reduce the coupling between the nVHE code and the core code. I've
ended up with the diff below on top of your series, but I think it actually
removes the need to change the core code at all. The idea is to collapse
the percpu sections during prelink, and then we can just deal with the
resulting data section a bit like we do for .hyp.text already.

Have I missed something critical?

Cheers,

Will

--->8

diff --git a/arch/arm64/include/asm/hyp_image.h b/arch/arm64/include/asm/hyp_image.h
new file mode 100644
index 000000000000..40bbf2ddb50f
--- /dev/null
+++ b/arch/arm64/include/asm/hyp_image.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __ASM_HYP_IMAGE_H
+#define __ASM_HYP_IMAGE_H
+
+/*
+ * KVM nVHE code has its own symbol namespace prefixed with __kvm_nvhe_, to
+ * separate it from the kernel proper.
+ */
+#define kvm_nvhe_sym(sym)	__kvm_nvhe_##sym
+
+#ifdef LINKER_SCRIPT
+/*
+ * Defines an ELF hyp section from input section @NAME and its subsections.
+ */
+#define HYP_SECTION(NAME)	.hyp ## NAME : { *(NAME NAME ## .*) }
+#define KVM_NVHE_ALIAS(sym)	kvm_nvhe_sym(sym) = sym;
+#endif	/* LINKER_SCRIPT */
+
+#endif	/* __ASM_HYP_IMAGE_H */
diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index c87111c25d9e..e0e1e404f6eb 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -7,6 +7,7 @@
 #ifndef __ARM_KVM_ASM_H__
 #define __ARM_KVM_ASM_H__
 
+#include <asm/hyp_image.h>
 #include <asm/virt.h>
 
 #define	VCPU_WORKAROUND_2_FLAG_SHIFT	0
@@ -42,13 +43,6 @@
 
 #include <linux/mm.h>
 
-/*
- * Translate name of a symbol defined in nVHE hyp to the name seen
- * by kernel proper. All nVHE symbols are prefixed by the build system
- * to avoid clashes with the VHE variants.
- */
-#define kvm_nvhe_sym(sym)	__kvm_nvhe_##sym
-
 #define DECLARE_KVM_VHE_SYM(sym)	extern char sym[]
 #define DECLARE_KVM_NVHE_SYM(sym)	extern char kvm_nvhe_sym(sym)[]
 
diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index 21307e2db3fc..f16205300dbc 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -54,15 +54,11 @@ __efistub__ctype		= _ctype;
 #ifdef CONFIG_KVM
 
 /*
- * KVM nVHE code has its own symbol namespace prefixed with __kvm_nvhe_, to
- * separate it from the kernel proper. The following symbols are legally
- * accessed by it, therefore provide aliases to make them linkable.
- * Do not include symbols which may not be safely accessed under hypervisor
- * memory mappings.
+ * The following symbols are legally accessed by the KVM nVHE code, therefore
+ * provide aliases to make them linkable. Do not include symbols which may not
+ * be safely accessed under hypervisor memory mappings.
  */
 
-#define KVM_NVHE_ALIAS(sym) __kvm_nvhe_##sym = sym;
-
 /* Alternative callbacks for init-time patching of nVHE hyp code. */
 KVM_NVHE_ALIAS(arm64_enable_wa2_handling);
 KVM_NVHE_ALIAS(kvm_patch_vector_branch);
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 5904a4de9f40..c06e6860adfd 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -9,27 +9,37 @@
 
 #include <asm-generic/vmlinux.lds.h>
 #include <asm/cache.h>
+#include <asm/hyp_image.h>
 #include <asm/kernel-pgtable.h>
 #include <asm/memory.h>
 #include <asm/page.h>
 
 #include "image.h"
 
-#define __CONCAT3(x, y, z) x ## y ## z
-#define CONCAT3(x, y, z) __CONCAT3(x, y, z)
-
 OUTPUT_ARCH(aarch64)
 ENTRY(_text)
 
 jiffies = jiffies_64;
 
-
+#ifdef CONFIG_KVM
 #define HYPERVISOR_EXTABLE					\
 	. = ALIGN(SZ_8);					\
 	__start___kvm_ex_table = .;				\
 	*(__kvm_ex_table)					\
 	__stop___kvm_ex_table = .;
 
+#define HYPERVISOR_PERCPU_SECTION			\
+	. = ALIGN(PAGE_SIZE);				\
+	.hyp.data..percpu : {				\
+		kvm_nvhe_sym(__per_cpu_start) = .;	\
+		*(.hyp.data..percpu)			\
+		kvm_nvhe_sym(__per_cpu_end) = .;	\
+	}
+#else
+#define HYPERVISOR_EXTABLE
+#define HYPERVISOR_PERCPU_SECTION
+#endif
+
 #define HYPERVISOR_TEXT					\
 	/*						\
 	 * Align to 4 KB so that			\
@@ -193,13 +203,7 @@ SECTIONS
 	}
 
 	PERCPU_SECTION(L1_CACHE_BYTES)
-
-	/* KVM nVHE per-cpu section */
-	#undef PERCPU_SECTION_NAME
-	#undef PERCPU_SYMBOL_NAME
-	#define PERCPU_SECTION_NAME(suffix)	CONCAT3(.hyp, PERCPU_SECTION_BASE_NAME, suffix)
-	#define PERCPU_SYMBOL_NAME(name)	__kvm_nvhe_ ## name
-	PERCPU_SECTION(L1_CACHE_BYTES)
+	HYPERVISOR_PERCPU_SECTION
 
 	.rela.dyn : ALIGN(8) {
 		*(.rela .rela*)
diff --git a/arch/arm64/kvm/hyp/nvhe/.gitignore b/arch/arm64/kvm/hyp/nvhe/.gitignore
new file mode 100644
index 000000000000..695d73d0249e
--- /dev/null
+++ b/arch/arm64/kvm/hyp/nvhe/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+hyp.lds
diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index 1b2fbb19f3e8..decc2373aa6c 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -33,8 +33,8 @@ $(obj)/hyp.lds: $(src)/hyp.lds.S FORCE
 
 # 3) Partially link all '.hyp.o' files and apply the linker script.
 #    Prefixes names of ELF sections with '.hyp', eg. '.hyp.text'.
-LDFLAGS_hyp.tmp.o := -r -T $(obj)/hyp.lds
-$(obj)/hyp.tmp.o: $(addprefix $(obj)/,$(hyp-obj)) $(obj)/hyp.lds FORCE
+LDFLAGS_hyp.tmp.o := -r -T
+$(obj)/hyp.tmp.o: $(obj)/hyp.lds $(addprefix $(obj)/,$(hyp-obj)) FORCE
 	$(call if_changed,ld)
 
 # 4) Produce the final 'hyp.o', ready to be linked into 'vmlinux'.
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp.lds.S b/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
index 7d8c3fa004f4..8121f2a6aedf 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
+++ b/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
@@ -4,16 +4,9 @@
  * Written by David Brazdil <dbrazdil@google.com>
  */
 
-/*
- * Defines an ELF hyp section from input section @NAME and its subsections.
- */
-#define HYP_SECTION(NAME) .hyp##NAME : { *(NAME NAME##.[0-9a-zA-Z_]*) }
+#include <asm/hyp_image.h>
 
 SECTIONS {
 	HYP_SECTION(.text)
 	HYP_SECTION(.data..percpu)
-	HYP_SECTION(.data..percpu..first)
-	HYP_SECTION(.data..percpu..page_aligned)
-	HYP_SECTION(.data..percpu..read_mostly)
-	HYP_SECTION(.data..percpu..shared_aligned)
 }
