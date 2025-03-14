Return-Path: <linux-arch+bounces-10799-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0045DA609ED
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 08:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA5193A75F0
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 07:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C721FC7EA;
	Fri, 14 Mar 2025 07:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B3/702sF"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256781FC7F4
	for <linux-arch@vger.kernel.org>; Fri, 14 Mar 2025 07:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741936410; cv=none; b=Y2/9zpoVi2o4bq07pA/HmiVVCZ0XbnRg2ZXRTu+rkS57WcB9VtePk2IoZBafzaDBhpbVCR6MnL0s1OQxco2TkzvptYi6BY3oRv0YxSEYtAs6pMjyQaBnTQHGs/z+rztJl1rEAJUmCcsi+9hlo5Q0LKOO16qRomFdY4XcJgaT98I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741936410; c=relaxed/simple;
	bh=DID8ahspXvMdAsIMMLmbsgn7rcxSktB7ZURhISF3ch0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XCyDg9kCRZ641Npj1xxbPTfWBr8E1H6ccMplcu3pFYz4OOSZ45bOEilO8MzdI8gWwoUfOQoG6tgcEc4vfAaTyoCwHoRzPSC6Jh9J2YqQpevyRdjflbkr0EoXrwM8TLpxWJEEMzHUcerV3Ju8XkEKD+V686/ImglCLLZ4qGPDJMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B3/702sF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741936407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yt0IGn8657fgY46bIl1eIEnpinKG1Vnp6VXMqFsLyAY=;
	b=B3/702sFasphf/ZVk3U3xmGSG2QTBl4vSj/jfqJV/hRE7L3c7gMdNcMMEFhapSW0g8qWaP
	nSj4LcpoejKS5q+pSmSRk8xKHMqlqrwWS3RdsqxZLLpVlPbNJEZOOET9tQInjgbwE2F92S
	lmc+D74bbQaWSCoIbdbk9ydBnIRKeKs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-0CRuZXtUPCSuciMMgF00qg-1; Fri,
 14 Mar 2025 03:13:23 -0400
X-MC-Unique: 0CRuZXtUPCSuciMMgF00qg-1
X-Mimecast-MFC-AGG-ID: 0CRuZXtUPCSuciMMgF00qg_1741936403
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F0F11180025A;
	Fri, 14 Mar 2025 07:13:22 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.82])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3B89D18001D4;
	Fri, 14 Mar 2025 07:13:20 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	Thomas Huth <thuth@redhat.com>
Subject: [PATCH 41/41] treewide: Stop defining __ASSEMBLY__ for assembler files
Date: Fri, 14 Mar 2025 08:10:12 +0100
Message-ID: <20250314071013.1575167-42-thuth@redhat.com>
In-Reply-To: <20250314071013.1575167-1-thuth@redhat.com>
References: <20250314071013.1575167-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

All spots have been changed to __ASSEMBLER__ (i.e. the macro that
gets defined by the compiler), so we don't have to manually define
__ASSEMBLY__ now anymore.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Makefile                                         | 2 +-
 arch/arm64/kernel/vdso32/Makefile                | 1 -
 arch/loongarch/vdso/Makefile                     | 2 +-
 arch/mips/boot/compressed/Makefile               | 2 +-
 arch/mips/vdso/Makefile                          | 2 +-
 arch/powerpc/boot/Makefile                       | 2 +-
 arch/powerpc/platforms/cell/spufs/Makefile       | 2 +-
 arch/s390/Makefile                               | 2 +-
 arch/x86/boot/Makefile                           | 2 +-
 arch/x86/boot/compressed/Makefile                | 2 +-
 arch/x86/realmode/rm/Makefile                    | 2 +-
 arch/xtensa/kernel/Makefile                      | 2 +-
 drivers/net/wan/Makefile                         | 2 +-
 scripts/Makefile.build                           | 2 +-
 scripts/gfp-translate                            | 2 +-
 tools/testing/selftests/kvm/lib/riscv/handlers.S | 4 ----
 tools/testing/selftests/vDSO/vgetrandom-chacha.S | 2 --
 17 files changed, 14 insertions(+), 21 deletions(-)

diff --git a/Makefile b/Makefile
index 1d6a9ec8a2ace..b95210e975836 100644
--- a/Makefile
+++ b/Makefile
@@ -573,7 +573,7 @@ LINUXINCLUDE    := \
 		-I$(objtree)/include \
 		$(USERINCLUDE)
 
-KBUILD_AFLAGS   := -D__ASSEMBLY__ -fno-PIE
+KBUILD_AFLAGS   := -fno-PIE
 
 KBUILD_CFLAGS :=
 KBUILD_CFLAGS += -std=gnu11
diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
index 25a2cb6317f35..a10a6a7eb9fed 100644
--- a/arch/arm64/kernel/vdso32/Makefile
+++ b/arch/arm64/kernel/vdso32/Makefile
@@ -93,7 +93,6 @@ VDSO_CFLAGS += -marm
 endif
 
 VDSO_AFLAGS := $(VDSO_CAFLAGS)
-VDSO_AFLAGS += -D__ASSEMBLY__
 
 # From arm vDSO Makefile
 VDSO_LDFLAGS += -Bsymbolic --no-undefined -soname=linux-vdso.so.1
diff --git a/arch/loongarch/vdso/Makefile b/arch/loongarch/vdso/Makefile
index fdde1bcd4e266..00ce65ef6150b 100644
--- a/arch/loongarch/vdso/Makefile
+++ b/arch/loongarch/vdso/Makefile
@@ -24,7 +24,7 @@ cflags-vdso := $(ccflags-vdso) \
 	$(call cc-option, -fno-asynchronous-unwind-tables) \
 	$(call cc-option, -fno-stack-protector)
 aflags-vdso := $(ccflags-vdso) \
-	-D__ASSEMBLY__ -Wa,-gdwarf-2
+	-Wa,-gdwarf-2
 
 ifneq ($(c-gettimeofday-y),)
   CFLAGS_vgettimeofday.o += -include $(c-gettimeofday-y)
diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
index e0b8ec9a95162..41ec115d4795b 100644
--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -30,7 +30,7 @@ endif
 KBUILD_CFLAGS := $(KBUILD_CFLAGS) -D__KERNEL__ -D__DISABLE_EXPORTS \
 	-DBOOT_HEAP_SIZE=$(BOOT_HEAP_SIZE) -D"VMLINUX_LOAD_ADDRESS_ULL=$(VMLINUX_LOAD_ADDRESS)ull"
 
-KBUILD_AFLAGS := $(KBUILD_AFLAGS) -D__ASSEMBLY__ \
+KBUILD_AFLAGS := $(KBUILD_AFLAGS) \
 	-DBOOT_HEAP_SIZE=$(BOOT_HEAP_SIZE) \
 	-DKERNEL_ENTRY=$(VMLINUX_ENTRY_ADDRESS)
 
diff --git a/arch/mips/vdso/Makefile b/arch/mips/vdso/Makefile
index b289b2c1b2946..edff6c01506f1 100644
--- a/arch/mips/vdso/Makefile
+++ b/arch/mips/vdso/Makefile
@@ -32,7 +32,7 @@ cflags-vdso := $(ccflags-vdso) \
 	-fno-stack-protector -fno-jump-tables -DDISABLE_BRANCH_PROFILING \
 	$(call cc-option, -fno-asynchronous-unwind-tables)
 aflags-vdso := $(ccflags-vdso) \
-	-D__ASSEMBLY__ -Wa,-gdwarf-2
+	-Wa,-gdwarf-2
 
 ifneq ($(c-gettimeofday-y),)
 CFLAGS_vgettimeofday.o = -include $(c-gettimeofday-y)
diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 1ff6ad4f6cd27..5cecf0ca22599 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -79,7 +79,7 @@ BOOTCFLAGS	:= $(BOOTTARGETFLAGS) \
 		   $(call cc-option,-mno-spe) $(call cc-option,-mspe=no) \
 		   -fomit-frame-pointer -fno-builtin -fPIC
 
-BOOTAFLAGS	:= $(BOOTTARGETFLAGS) -D__ASSEMBLY__
+BOOTAFLAGS	:= $(BOOTTARGETFLAGS)
 
 BOOTARFLAGS	:= -crD
 
diff --git a/arch/powerpc/platforms/cell/spufs/Makefile b/arch/powerpc/platforms/cell/spufs/Makefile
index 52e4c80ec8d03..c13928aea20c6 100644
--- a/arch/powerpc/platforms/cell/spufs/Makefile
+++ b/arch/powerpc/platforms/cell/spufs/Makefile
@@ -16,7 +16,7 @@ SPU_AS		:= $(SPU_CROSS)gcc
 SPU_LD		:= $(SPU_CROSS)ld
 SPU_OBJCOPY	:= $(SPU_CROSS)objcopy
 SPU_CFLAGS	:= -O2 -Wall -I$(srctree)/include -D__KERNEL__
-SPU_AFLAGS	:= -c -D__ASSEMBLY__ -I$(srctree)/include -D__KERNEL__
+SPU_AFLAGS	:= -c -I$(srctree)/include -D__KERNEL__
 SPU_LDFLAGS	:= -N -Ttext=0x0
 
 $(obj)/switch.o: $(obj)/spu_save_dump.h $(obj)/spu_restore_dump.h
diff --git a/arch/s390/Makefile b/arch/s390/Makefile
index 5fae311203c26..f024e39bfc13f 100644
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -18,7 +18,7 @@ KBUILD_CFLAGS	+= -fPIC
 LDFLAGS_vmlinux	:= -no-pie --emit-relocs --discard-none
 extra_tools	:= relocs
 aflags_dwarf	:= -Wa,-gdwarf-2
-KBUILD_AFLAGS_DECOMPRESSOR := $(CLANG_FLAGS) -m64 -D__ASSEMBLY__
+KBUILD_AFLAGS_DECOMPRESSOR := $(CLANG_FLAGS) -m64
 ifndef CONFIG_AS_IS_LLVM
 KBUILD_AFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO),$(aflags_dwarf))
 endif
diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
index 9cc0ff6e9067d..350d9c176c468 100644
--- a/arch/x86/boot/Makefile
+++ b/arch/x86/boot/Makefile
@@ -53,7 +53,7 @@ targets += cpustr.h
 # ---------------------------------------------------------------------------
 
 KBUILD_CFLAGS	:= $(REALMODE_CFLAGS) -D_SETUP
-KBUILD_AFLAGS	:= $(KBUILD_CFLAGS) -D__ASSEMBLY__
+KBUILD_AFLAGS	:= $(KBUILD_CFLAGS)
 KBUILD_CFLAGS	+= $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
 KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables
 KBUILD_CFLAGS	+= $(CONFIG_CC_IMPLICIT_FALLTHROUGH)
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 606c74f274593..7816033203207 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -50,7 +50,7 @@ KBUILD_CFLAGS += -include $(srctree)/include/linux/hidden.h
 # that the compiler finds it even with out-of-tree builds (make O=/some/path).
 CFLAGS_sev.o += -I$(objtree)/arch/x86/lib/
 
-KBUILD_AFLAGS  := $(KBUILD_CFLAGS) -D__ASSEMBLY__
+KBUILD_AFLAGS  := $(KBUILD_CFLAGS)
 
 KBUILD_LDFLAGS := -m elf_$(UTS_MACHINE)
 KBUILD_LDFLAGS += $(call ld-option,--no-ld-generated-unwind-info)
diff --git a/arch/x86/realmode/rm/Makefile b/arch/x86/realmode/rm/Makefile
index a0fb39abc5c86..20bbe1af05acd 100644
--- a/arch/x86/realmode/rm/Makefile
+++ b/arch/x86/realmode/rm/Makefile
@@ -65,5 +65,5 @@ $(obj)/realmode.relocs: $(obj)/realmode.elf FORCE
 
 KBUILD_CFLAGS	:= $(REALMODE_CFLAGS) -D_SETUP -D_WAKEUP \
 		   -I$(srctree)/arch/x86/boot
-KBUILD_AFLAGS	:= $(KBUILD_CFLAGS) -D__ASSEMBLY__
+KBUILD_AFLAGS	:= $(KBUILD_CFLAGS)
 KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables
diff --git a/arch/xtensa/kernel/Makefile b/arch/xtensa/kernel/Makefile
index f28b8e3d717ee..b0ba47cdce5e3 100644
--- a/arch/xtensa/kernel/Makefile
+++ b/arch/xtensa/kernel/Makefile
@@ -39,7 +39,7 @@ sed-y = -e ':a; s/\*(\([^)]*\)\.text\.unlikely/*(\1.literal.unlikely .{text}.unl
 	-e 's/\.{text}/.text/g'
 
 quiet_cmd__cpp_lds_S = LDS     $@
-cmd__cpp_lds_S = $(CPP) $(cpp_flags) -P -C -Uxtensa -D__ASSEMBLY__ \
+cmd__cpp_lds_S = $(CPP) $(cpp_flags) -P -C -Uxtensa \
 		 -DLINKER_SCRIPT $< | sed $(sed-y) >$@
 
 $(obj)/vmlinux.lds: $(src)/vmlinux.lds.S FORCE
diff --git a/drivers/net/wan/Makefile b/drivers/net/wan/Makefile
index 00e9b7ee1e012..4233143534465 100644
--- a/drivers/net/wan/Makefile
+++ b/drivers/net/wan/Makefile
@@ -57,7 +57,7 @@ $(obj)/wanxlfw.bin: $(obj)/wanxlfw.o FORCE
 	$(call if_changed,m68kld_bin_o)
 
 quiet_cmd_m68kas_o_S = M68KAS  $@
-      cmd_m68kas_o_S = $(M68KCC) -D__ASSEMBLY__ -Wp,-MD,$(depfile) -I$(srctree)/include/uapi -c -o $@ $<
+      cmd_m68kas_o_S = $(M68KCC) -Wp,-MD,$(depfile) -I$(srctree)/include/uapi -c -o $@ $<
 
 $(obj)/wanxlfw.o: $(src)/wanxlfw.S FORCE
 	$(call if_changed_dep,m68kas_o_S)
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 993708d118745..89f8606a7dea0 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -346,7 +346,7 @@ targets += $(lib-y) $(always-y)
 # ---------------------------------------------------------------------------
 quiet_cmd_cpp_lds_S = LDS     $@
       cmd_cpp_lds_S = $(CPP) $(cpp_flags) -P -U$(ARCH) \
-	                     -D__ASSEMBLY__ -DLINKER_SCRIPT -o $@ $<
+	                     -DLINKER_SCRIPT -o $@ $<
 
 $(obj)/%.lds: $(src)/%.lds.S FORCE
 	$(call if_changed_dep,cpp_lds_S)
diff --git a/scripts/gfp-translate b/scripts/gfp-translate
index 8385ae0d5af93..f6353795fdca3 100755
--- a/scripts/gfp-translate
+++ b/scripts/gfp-translate
@@ -73,7 +73,7 @@ echo Parsing: $GFPMASK
 #include <stdio.h>
 
 // Try to fool compiler.h into not including extra stuff
-#define __ASSEMBLY__	1
+#define __ASSEMBLER__	1
 
 #include <generated/autoconf.h>
 #include <linux/gfp_types.h>
diff --git a/tools/testing/selftests/kvm/lib/riscv/handlers.S b/tools/testing/selftests/kvm/lib/riscv/handlers.S
index aa0abd3f35bb0..f6d43979032df 100644
--- a/tools/testing/selftests/kvm/lib/riscv/handlers.S
+++ b/tools/testing/selftests/kvm/lib/riscv/handlers.S
@@ -3,10 +3,6 @@
  * Copyright (c) 2023 Intel Corporation
  */
 
-#ifndef __ASSEMBLY__
-#define __ASSEMBLY__
-#endif
-
 #include <asm/csr.h>
 
 .macro save_context
diff --git a/tools/testing/selftests/vDSO/vgetrandom-chacha.S b/tools/testing/selftests/vDSO/vgetrandom-chacha.S
index d6e09af7c0a92..fffe3c700bba9 100644
--- a/tools/testing/selftests/vDSO/vgetrandom-chacha.S
+++ b/tools/testing/selftests/vDSO/vgetrandom-chacha.S
@@ -3,8 +3,6 @@
  * Copyright (C) 2024 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
  */
 
-#define __ASSEMBLY__
-
 #if defined(__aarch64__)
 #include "../../../../arch/arm64/kernel/vdso/vgetrandom-chacha.S"
 #elif defined(__loongarch__)
-- 
2.48.1


