Return-Path: <linux-arch+bounces-1295-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18901826B2C
	for <lists+linux-arch@lfdr.de>; Mon,  8 Jan 2024 10:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C066B21570
	for <lists+linux-arch@lfdr.de>; Mon,  8 Jan 2024 09:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A927F12B98;
	Mon,  8 Jan 2024 09:59:10 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E953012B87;
	Mon,  8 Jan 2024 09:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2D28E21DA5;
	Mon,  8 Jan 2024 09:59:07 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A94621392C;
	Mon,  8 Jan 2024 09:59:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GNY5KGrHm2XFMwAAD6G6ig
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
Subject: [PATCH v4 2/4] arch/x86: Move internal setup_data structures into setup_data.h
Date: Mon,  8 Jan 2024 10:57:28 +0100
Message-ID: <20240108095903.8427-3-tzimmermann@suse.de>
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
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 2D28E21DA5
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.00 / 50.00];
	 TAGGED_RCPT(0.00)[];
	 REPLY(-4.00)[]

The type definition of struct pci_setup_rom in <asm/pci.h> requires
struct setup_data from <asm/bootparam.h>. Many drivers include
<linux/pci.h>, but do not use boot parameters. Changes to bootparam.h
or its included header files could easily trigger a large, unnecessary
rebuild of the kernel.

Moving struct pci_setup_rom into its own header file avoids including
<asm/bootparam.h> in <asm/pci.h>. Moving struct_efi_setup_data allows
to unify duplicated definition of the data structure in a single place.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 arch/x86/boot/compressed/efi.h    |  9 ---------
 arch/x86/include/asm/efi.h        |  9 ---------
 arch/x86/include/asm/pci.h        | 13 -------------
 arch/x86/include/asm/setup_data.h | 32 +++++++++++++++++++++++++++++++
 4 files changed, 32 insertions(+), 31 deletions(-)
 create mode 100644 arch/x86/include/asm/setup_data.h

diff --git a/arch/x86/boot/compressed/efi.h b/arch/x86/boot/compressed/efi.h
index 866c0af8b5b9..b22300970f97 100644
--- a/arch/x86/boot/compressed/efi.h
+++ b/arch/x86/boot/compressed/efi.h
@@ -97,15 +97,6 @@ typedef struct {
 	u32 tables;
 } efi_system_table_32_t;
 
-/* kexec external ABI */
-struct efi_setup_data {
-	u64 fw_vendor;
-	u64 __unused;
-	u64 tables;
-	u64 smbios;
-	u64 reserved[8];
-};
-
 struct efi_unaccepted_memory {
 	u32 version;
 	u32 unit_size;
diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index c4555b269a1b..a5d7a83e4c2a 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -143,15 +143,6 @@ extern void efi_free_boot_services(void);
 void arch_efi_call_virt_setup(void);
 void arch_efi_call_virt_teardown(void);
 
-/* kexec external ABI */
-struct efi_setup_data {
-	u64 fw_vendor;
-	u64 __unused;
-	u64 tables;
-	u64 smbios;
-	u64 reserved[8];
-};
-
 extern u64 efi_setup;
 
 #ifdef CONFIG_EFI
diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
index f6100df3652e..b3ab80a03365 100644
--- a/arch/x86/include/asm/pci.h
+++ b/arch/x86/include/asm/pci.h
@@ -10,7 +10,6 @@
 #include <linux/numa.h>
 #include <asm/io.h>
 #include <asm/memtype.h>
-#include <asm/setup_data.h>
 
 struct pci_sysdata {
 	int		domain;		/* PCI domain */
@@ -124,16 +123,4 @@ cpumask_of_pcibus(const struct pci_bus *bus)
 }
 #endif
 
-struct pci_setup_rom {
-	struct setup_data data;
-	uint16_t vendor;
-	uint16_t devid;
-	uint64_t pcilen;
-	unsigned long segment;
-	unsigned long bus;
-	unsigned long device;
-	unsigned long function;
-	uint8_t romdata[];
-};
-
 #endif /* _ASM_X86_PCI_H */
diff --git a/arch/x86/include/asm/setup_data.h b/arch/x86/include/asm/setup_data.h
new file mode 100644
index 000000000000..77c51111a893
--- /dev/null
+++ b/arch/x86/include/asm/setup_data.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_SETUP_DATA_H
+#define _ASM_X86_SETUP_DATA_H
+
+#include <uapi/asm/setup_data.h>
+
+#ifndef __ASSEMBLY__
+
+struct pci_setup_rom {
+	struct setup_data data;
+	uint16_t vendor;
+	uint16_t devid;
+	uint64_t pcilen;
+	unsigned long segment;
+	unsigned long bus;
+	unsigned long device;
+	unsigned long function;
+	uint8_t romdata[];
+};
+
+/* kexec external ABI */
+struct efi_setup_data {
+	u64 fw_vendor;
+	u64 __unused;
+	u64 tables;
+	u64 smbios;
+	u64 reserved[8];
+};
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* _ASM_X86_SETUP_DATA_H */
-- 
2.43.0


