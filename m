Return-Path: <linux-arch+bounces-1294-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B24B826B25
	for <lists+linux-arch@lfdr.de>; Mon,  8 Jan 2024 10:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 864651C21EBB
	for <lists+linux-arch@lfdr.de>; Mon,  8 Jan 2024 09:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550BA13AE2;
	Mon,  8 Jan 2024 09:59:10 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958AC12B7C;
	Mon,  8 Jan 2024 09:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A25101F795;
	Mon,  8 Jan 2024 09:59:06 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2B07913CA6;
	Mon,  8 Jan 2024 09:59:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UIZmCWrHm2XFMwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 08 Jan 2024 09:59:06 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: ardb@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	bhelgaas@google.com,
	arnd@arndb.de,
	zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	javierm@redhat.com
Cc: linux-arch@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v4 1/4] arch/x86: Move UAPI setup structures into setup_data.h
Date: Mon,  8 Jan 2024 10:57:27 +0100
Message-ID: <20240108095903.8427-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108095903.8427-1-tzimmermann@suse.de>
References: <20240108095903.8427-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 TAGGED_RCPT(0.00)[];
	 REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: A25101F795
X-Spam-Flag: NO

The type definition of struct pci_setup_rom in <asm/pci.h> requires
struct setup_data from <asm/bootparam.h>. Many drivers include
<linux/pci.h>, but do not use boot parameters. Changes to bootparam.h
or its included header files could easily trigger a large, unnecessary
rebuild of the kernel.

Moving struct setup_data and related code into its own header file
avoids including <asm/bootparam.h> in <asm/pci.h>. Instead include the
new header <asm/screen_data.h> and remove the include statement for
x86_init.h, which is unnecessary but pulls in bootparams.h.

Suggested-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

---

v3:
	* keep setup_header and friends in bootparam.h (Ard)
---
 arch/x86/include/asm/pci.h             |  2 +-
 arch/x86/include/uapi/asm/bootparam.h  | 72 +---------------------
 arch/x86/include/uapi/asm/setup_data.h | 83 ++++++++++++++++++++++++++
 3 files changed, 85 insertions(+), 72 deletions(-)
 create mode 100644 arch/x86/include/uapi/asm/setup_data.h

diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
index b40c462b4af3..f6100df3652e 100644
--- a/arch/x86/include/asm/pci.h
+++ b/arch/x86/include/asm/pci.h
@@ -10,7 +10,7 @@
 #include <linux/numa.h>
 #include <asm/io.h>
 #include <asm/memtype.h>
-#include <asm/x86_init.h>
+#include <asm/setup_data.h>
 
 struct pci_sysdata {
 	int		domain;		/* PCI domain */
diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
index 01d19fc22346..4a38e7917756 100644
--- a/arch/x86/include/uapi/asm/bootparam.h
+++ b/arch/x86/include/uapi/asm/bootparam.h
@@ -2,21 +2,7 @@
 #ifndef _ASM_X86_BOOTPARAM_H
 #define _ASM_X86_BOOTPARAM_H
 
-/* setup_data/setup_indirect types */
-#define SETUP_NONE			0
-#define SETUP_E820_EXT			1
-#define SETUP_DTB			2
-#define SETUP_PCI			3
-#define SETUP_EFI			4
-#define SETUP_APPLE_PROPERTIES		5
-#define SETUP_JAILHOUSE			6
-#define SETUP_CC_BLOB			7
-#define SETUP_IMA			8
-#define SETUP_RNG_SEED			9
-#define SETUP_ENUM_MAX			SETUP_RNG_SEED
-
-#define SETUP_INDIRECT			(1<<31)
-#define SETUP_TYPE_MAX			(SETUP_ENUM_MAX | SETUP_INDIRECT)
+#include <asm/setup_data.h>
 
 /* ram_size flags */
 #define RAMDISK_IMAGE_START_MASK	0x07FF
@@ -48,22 +34,6 @@
 #include <asm/ist.h>
 #include <video/edid.h>
 
-/* extensible setup data list node */
-struct setup_data {
-	__u64 next;
-	__u32 type;
-	__u32 len;
-	__u8 data[];
-};
-
-/* extensible setup indirect data node */
-struct setup_indirect {
-	__u32 type;
-	__u32 reserved;  /* Reserved, must be set to zero. */
-	__u64 len;
-	__u64 addr;
-};
-
 struct setup_header {
 	__u8	setup_sects;
 	__u16	root_flags;
@@ -136,51 +106,11 @@ struct efi_info {
  */
 #define E820_MAX_ENTRIES_ZEROPAGE 128
 
-/*
- * The E820 memory region entry of the boot protocol ABI:
- */
-struct boot_e820_entry {
-	__u64 addr;
-	__u64 size;
-	__u32 type;
-} __attribute__((packed));
-
 /*
  * Smallest compatible version of jailhouse_setup_data required by this kernel.
  */
 #define JAILHOUSE_SETUP_REQUIRED_VERSION	1
 
-/*
- * The boot loader is passing platform information via this Jailhouse-specific
- * setup data structure.
- */
-struct jailhouse_setup_data {
-	struct {
-		__u16	version;
-		__u16	compatible_version;
-	} __attribute__((packed)) hdr;
-	struct {
-		__u16	pm_timer_address;
-		__u16	num_cpus;
-		__u64	pci_mmconfig_base;
-		__u32	tsc_khz;
-		__u32	apic_khz;
-		__u8	standard_ioapic;
-		__u8	cpu_ids[255];
-	} __attribute__((packed)) v1;
-	struct {
-		__u32	flags;
-	} __attribute__((packed)) v2;
-} __attribute__((packed));
-
-/*
- * IMA buffer setup data information from the previous kernel during kexec
- */
-struct ima_setup_data {
-	__u64 addr;
-	__u64 size;
-} __attribute__((packed));
-
 /* The so-called "zeropage" */
 struct boot_params {
 	struct screen_info screen_info;			/* 0x000 */
diff --git a/arch/x86/include/uapi/asm/setup_data.h b/arch/x86/include/uapi/asm/setup_data.h
new file mode 100644
index 000000000000..b111b0c18544
--- /dev/null
+++ b/arch/x86/include/uapi/asm/setup_data.h
@@ -0,0 +1,83 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_ASM_X86_SETUP_DATA_H
+#define _UAPI_ASM_X86_SETUP_DATA_H
+
+/* setup_data/setup_indirect types */
+#define SETUP_NONE			0
+#define SETUP_E820_EXT			1
+#define SETUP_DTB			2
+#define SETUP_PCI			3
+#define SETUP_EFI			4
+#define SETUP_APPLE_PROPERTIES		5
+#define SETUP_JAILHOUSE			6
+#define SETUP_CC_BLOB			7
+#define SETUP_IMA			8
+#define SETUP_RNG_SEED			9
+#define SETUP_ENUM_MAX			SETUP_RNG_SEED
+
+#define SETUP_INDIRECT			(1<<31)
+#define SETUP_TYPE_MAX			(SETUP_ENUM_MAX | SETUP_INDIRECT)
+
+#ifndef __ASSEMBLY__
+
+#include <linux/types.h>
+
+/* extensible setup data list node */
+struct setup_data {
+	__u64 next;
+	__u32 type;
+	__u32 len;
+	__u8 data[];
+};
+
+/* extensible setup indirect data node */
+struct setup_indirect {
+	__u32 type;
+	__u32 reserved;  /* Reserved, must be set to zero. */
+	__u64 len;
+	__u64 addr;
+};
+
+/*
+ * The E820 memory region entry of the boot protocol ABI:
+ */
+struct boot_e820_entry {
+	__u64 addr;
+	__u64 size;
+	__u32 type;
+} __attribute__((packed));
+
+/*
+ * The boot loader is passing platform information via this Jailhouse-specific
+ * setup data structure.
+ */
+struct jailhouse_setup_data {
+	struct {
+		__u16	version;
+		__u16	compatible_version;
+	} __attribute__((packed)) hdr;
+	struct {
+		__u16	pm_timer_address;
+		__u16	num_cpus;
+		__u64	pci_mmconfig_base;
+		__u32	tsc_khz;
+		__u32	apic_khz;
+		__u8	standard_ioapic;
+		__u8	cpu_ids[255];
+	} __attribute__((packed)) v1;
+	struct {
+		__u32	flags;
+	} __attribute__((packed)) v2;
+} __attribute__((packed));
+
+/*
+ * IMA buffer setup data information from the previous kernel during kexec
+ */
+struct ima_setup_data {
+	__u64 addr;
+	__u64 size;
+} __attribute__((packed));
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* _UAPI_ASM_X86_SETUP_DATA_H */
-- 
2.43.0


