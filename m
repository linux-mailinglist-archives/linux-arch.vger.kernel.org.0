Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15201516EBB
	for <lists+linux-arch@lfdr.de>; Mon,  2 May 2022 13:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381044AbiEBLU7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 May 2022 07:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbiEBLU5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 May 2022 07:20:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D88BC17;
        Mon,  2 May 2022 04:17:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 773AEB81058;
        Mon,  2 May 2022 11:17:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E30FC385B1;
        Mon,  2 May 2022 11:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651490246;
        bh=XZW/JCwgq6tAw7SBVFrShBag6VMdsc/+bw/ci9pjai8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=meMSGpfLtiqiULufuetTFyooi5QvodYIOaB5T5MTHvniaV4y6KWwIgcoYX4wOyU5D
         TA49uykteL1QTu3HrWw7etPRbxupDe0Ho1VmFo5X77RWEiap7aGziyQZ+Ac6igpK3V
         SyVwtqbsxTkXeypY+mLIFP6/rOBZGL8UYLVuTXz8U4+u/5D/UaRu//3Yw6R2MKLf9P
         KtR/nzrh+K0QoAsacvlOKA2XTvFocohhV43OzYhzpfTfMKSBcL5AnnpBy8lwdp57ob
         RvvqHLbYxph5Y04LYj/eUkgSkzpwzNZlu8JoELW8gFC6wH6oB24dDmKd82GU3NY1ks
         HNaTFH58s0DVQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [RFC PATCH 3/4] efi: stub: implement generic EFI zboot
Date:   Mon,  2 May 2022 13:17:09 +0200
Message-Id: <20220502111710.4093567-4-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220502111710.4093567-1-ardb@kernel.org>
References: <20220502111710.4093567-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7694; h=from:subject; bh=XZW/JCwgq6tAw7SBVFrShBag6VMdsc/+bw/ci9pjai8=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBib720DoYS1bUZZqROM1Mfg1BFpkY8ohlfCZ05VNuj EZm9+suJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYm+9tAAKCRDDTyI5ktmPJFEKC/ 0drSc8Ho8I6aLTjcpoamZCH+R6SoI0sjd2wraHC7ZcEB8BPaNgYg6m1FgUoquOi1Te4zRDR4bV5dfy KjLF5vBGKl7auXLXe5BwvvQsWYd/+8KhPTZV5kYIsI9NAx5OyyjZ4J9RX/p69HZk0GYJut6PC50A5C 2KsikHg+fnNPESpyl4J9lQEN7Um6yJPv/y82WrEfQz7Jdd12BFAswjTQMP69K3PDcoZZ+BBuaBD9NA SfdJ8gwNPS9yY82wIpRZ+T+kC5bJokuL1wV+fR6QNVu8DZxWphLuDKpPGrcG2eVB+Xhv5BlKPEomac Hcx/Q6JvC0V55cFEhLqatprR+rKNugVgX55a8VRop+O8kbpteSz5ojcvXSDWdamxQRciG62SAZn9x4 vvkOQEtswViTWS8gRWAc3xzxFpPaIVvpDRblelK9j93HrfE2rV53GiGt1rgc88VZ232bcIGUeFT56G FrlFtP4F2Miv3t+LAdXjRWyNiZs65wH+PAOUl1T+wgT10=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Implement a minimal EFI app that decompresses the real kernel image and
launches it using the firmware's LoadImage and StartImage boot services.
This removes the need for any arch-specific hacks.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/Kconfig                |  6 ++
 drivers/firmware/efi/libstub/Makefile       |  2 +
 drivers/firmware/efi/libstub/zboot-header.S | 88 ++++++++++++++++++++
 drivers/firmware/efi/libstub/zboot.c        | 86 +++++++++++++++++++
 drivers/firmware/efi/libstub/zboot.lds      | 44 ++++++++++
 5 files changed, 226 insertions(+)

diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 4720ba98cec3..5fc986f66505 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -116,6 +116,12 @@ config EFI_RUNTIME_WRAPPERS
 config EFI_GENERIC_STUB
 	bool
 
+config EFI_ZBOOT
+	bool "Enable the generic EFI decompressor"
+	depends on EFI_GENERIC_STUB
+	depends on !ARM && !X86
+	select HAVE_KERNEL_GZIP
+
 config EFI_ARMSTUB_DTB_LOADER
 	bool "Enable the DTB loader"
 	depends on EFI_GENERIC_STUB && !RISCV
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 475224be08e1..71bd877077b1 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -111,8 +111,10 @@ STUBCOPY_RELOC-$(CONFIG_ARM)	:= R_ARM_ABS
 # a verification pass to see if any absolute relocations exist in any of the
 # object files.
 #
+lib-$(CONFIG_EFI_ZBOOT)		+= zboot.o
 extra-y				:= $(lib-y)
 lib-y				:= $(patsubst %.o,%.stub.o,$(lib-y))
+lib-$(CONFIG_EFI_ZBOOT)		+= zboot-header.o
 
 STUBCOPY_FLAGS-$(CONFIG_ARM64)	+= --prefix-alloc-sections=.init \
 				   --prefix-symbols=__efistub_
diff --git a/drivers/firmware/efi/libstub/zboot-header.S b/drivers/firmware/efi/libstub/zboot-header.S
new file mode 100644
index 000000000000..8f471866081a
--- /dev/null
+++ b/drivers/firmware/efi/libstub/zboot-header.S
@@ -0,0 +1,88 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/pe.h>
+
+	.section	".head", "a"
+	.globl		__efistub_efi_zboot_header
+__efistub_efi_zboot_header:
+.Ldoshdr:
+	.long		MZ_MAGIC
+	.org		.Ldoshdr + 0x3c
+	.long		.Lpehdr - .Ldoshdr
+
+.Lpehdr:
+	.long		PE_MAGIC
+	.short		pe_machine_type
+	.short		.Lsection_count
+	.long		0
+	.long		0
+	.long		0
+	.short		.Lsection_table - .Loptional_header
+	.short		IMAGE_FILE_DEBUG_STRIPPED | \
+			IMAGE_FILE_EXECUTABLE_IMAGE | \
+			IMAGE_FILE_LINE_NUMS_STRIPPED
+
+.Loptional_header:
+#ifdef CONFIG_64BIT
+	.short		PE_OPT_MAGIC_PE32PLUS
+#else
+	.short		PE_OPT_MAGIC_PE32
+#endif
+	.byte		0, 0
+	.long		_etext - .Lefi_header_end
+	.long		__data_size
+	.long		0
+	.long		__efistub_efi_zboot_entry - .Ldoshdr
+	.long		.Lefi_header_end - .Ldoshdr
+
+#ifdef CONFIG_64BIT
+	.quad		0
+#else
+	.long		_etext - .Lhead
+	.long		0
+#endif
+	.long		4096
+	.long		512
+	.short		0, 0, 0, 0, 0, 0
+	.long		0
+	.long		_end - .Ldoshdr
+
+	.long		.Lefi_header_end - .Ldoshdr
+	.long		0
+	.short		IMAGE_SUBSYSTEM_EFI_APPLICATION
+	.short		0
+	.quad		0, 0, 0, 0
+	.long		0
+	.long		(.Lsection_table - .) / 8
+	.quad		0, 0, 0, 0, 0, 0
+
+.Lsection_table:
+	.ascii		".text\0\0\0"
+	.long		_etext - .Lefi_header_end
+	.long		.Lefi_header_end - .Ldoshdr
+	.long		_etext - .Lefi_header_end
+	.long		.Lefi_header_end - .Ldoshdr
+
+	.long		0, 0
+	.short		0, 0
+	.long		IMAGE_SCN_CNT_CODE | \
+			IMAGE_SCN_MEM_READ | \
+			IMAGE_SCN_MEM_EXECUTE
+
+	.ascii		".data\0\0\0"
+	.long		__data_size
+	.long		_etext - .Ldoshdr
+	.long		__data_rawsize
+	.long		_etext - .Ldoshdr
+
+	.long		0, 0
+	.short		0, 0
+	.long		IMAGE_SCN_CNT_INITIALIZED_DATA | \
+			IMAGE_SCN_MEM_READ | \
+			IMAGE_SCN_MEM_WRITE
+
+	.set		.Lsection_count, (. - .Lsection_table) / 40
+
+	.align		12
+.Lefi_header_end:
+
diff --git a/drivers/firmware/efi/libstub/zboot.c b/drivers/firmware/efi/libstub/zboot.c
new file mode 100644
index 000000000000..edb3390c808c
--- /dev/null
+++ b/drivers/firmware/efi/libstub/zboot.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/efi.h>
+#include <asm/efi.h>
+
+#include "efistub.h"
+
+#define STATIC static
+
+static unsigned char zboot_heap[SZ_64K] __aligned(64);
+static unsigned long free_mem_ptr, free_mem_end_ptr;
+
+#ifdef CONFIG_KERNEL_GZIP
+#include "../../../../lib/decompress_inflate.c"
+#endif
+
+const efi_system_table_t *efi_system_table;
+
+extern char _gzdata_start[], _gzdata_end[];
+extern u32 uncompressed_size __aligned(1);
+
+static void error(char *x)
+{
+	efi_err("%s\n", x);
+}
+
+efi_status_t __efiapi efi_zboot_entry(efi_handle_t handle,
+				      efi_system_table_t *systab)
+{
+	efi_guid_t loaded_image = LOADED_IMAGE_PROTOCOL_GUID;
+	efi_loaded_image_t *parent, *child;
+	efi_handle_t child_handle = NULL;
+	unsigned long image_buffer;
+	efi_status_t status;
+
+	free_mem_ptr = (unsigned long)&zboot_heap;
+	free_mem_end_ptr = free_mem_ptr + sizeof(zboot_heap);
+
+	efi_system_table = systab;
+
+	efi_info("Entering EFI decompressor\n");
+
+	status = efi_bs_call(handle_protocol, handle, &loaded_image,
+			     (void **)&parent);
+	if (status != EFI_SUCCESS) {
+		efi_err("Failed to locate parent's loaded image protocol\n");
+		return status;
+	}
+
+	status = efi_allocate_pages(uncompressed_size, &image_buffer, ULONG_MAX);
+	if (status != EFI_SUCCESS) {
+		efi_err("Failed to allocate memory\n");
+		return status;
+	}
+
+	if (__decompress(_gzdata_start, _gzdata_end - _gzdata_start, NULL,
+			 NULL, (unsigned char *)image_buffer, 0, NULL,
+			 error) < 0)
+		return EFI_LOAD_ERROR;
+
+	status = efi_bs_call(load_image, true, handle, NULL,
+			     (void *)image_buffer, uncompressed_size,
+			     &child_handle);
+	if (status != EFI_SUCCESS) {
+		efi_err("Failed to load image: %lx\n", status);
+		return status;
+	}
+
+	status = efi_bs_call(handle_protocol, child_handle, &loaded_image,
+			     (void **)&child);
+	if (status != EFI_SUCCESS) {
+		efi_err("Failed to locate child's loaded image protocol\n");
+		return status;
+	}
+
+	// Copy the kernel command line
+	child->load_options = parent->load_options;
+	child->load_options_size = parent->load_options_size;
+
+	status = efi_bs_call(start_image, child_handle, NULL, NULL);
+	if (status != EFI_SUCCESS) {
+		efi_err("Failed to start image: %lx\n", status);
+		return status;
+	}
+	return EFI_SUCCESS;
+}
diff --git a/drivers/firmware/efi/libstub/zboot.lds b/drivers/firmware/efi/libstub/zboot.lds
new file mode 100644
index 000000000000..56777b5f2668
--- /dev/null
+++ b/drivers/firmware/efi/libstub/zboot.lds
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+ENTRY(__efistub_efi_zboot_header);
+
+SECTIONS
+{
+	.text : ALIGN(4096) {
+		*(.head)
+		*(.text* .init.text*)
+	}
+
+	.rodata : ALIGN(8) {
+		__efistub__gzdata_start = .;
+		*(.gzdata)
+		__efistub__gzdata_end = . - 4;
+		__efistub_uncompressed_size = . - 4;
+		*(.rodata* .init.rodata*)
+		_etext = ALIGN(4096);
+		. = _etext;
+	}
+
+	.data : ALIGN(4096) {
+		*(.data* .init.data*)
+		_edata = ALIGN(512);
+		. = _edata;
+	}
+
+	.bss : {
+		*(.bss* .init.bss*)
+		_end = ALIGN(512);
+		. = _end;
+	}
+
+	/DISCARD/ : {
+		*(__ksymtab_strings ___ksymtab+*)
+	}
+}
+
+PROVIDE(__data_rawsize = ABSOLUTE(_edata - _etext));
+PROVIDE(__data_size = ABSOLUTE(_end - _etext));
+
+PROVIDE(__efistub_memcpy = __pi_memcpy);
+PROVIDE(__efistub_memset = __pi_memset);
+PROVIDE(__efistub_strnlen = __pi_strnlen);
-- 
2.30.2

