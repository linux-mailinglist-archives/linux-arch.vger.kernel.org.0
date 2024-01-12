Return-Path: <linux-arch+bounces-1360-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 851CF82BDC8
	for <lists+linux-arch@lfdr.de>; Fri, 12 Jan 2024 10:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85A151C2598A
	for <lists+linux-arch@lfdr.de>; Fri, 12 Jan 2024 09:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1189B5EE8B;
	Fri, 12 Jan 2024 09:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CnkglU/M";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LtbMjz1V";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CnkglU/M";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LtbMjz1V"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BE45EE67;
	Fri, 12 Jan 2024 09:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4EE4F1FC31;
	Fri, 12 Jan 2024 09:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705053004; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0VtVMugAx0bf7F0Ks4LYKgivz5jC/UzmrIRwmqlOnbQ=;
	b=CnkglU/M/lLXvK59kvRO83tUZ3QyD7a+8Tcu7QI+Iep9bGC804RQyIUIXu7l0EH3zp1P/b
	QcIGQbXStRHVWK5yfn/jGt1gLCs1miyxQogPGquQdJj+UY/EDfJP+Ng10pwKE8xrIPQkYB
	lBd26xdI0AEdyzxYFOjM2yC5XddLWOk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705053004;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0VtVMugAx0bf7F0Ks4LYKgivz5jC/UzmrIRwmqlOnbQ=;
	b=LtbMjz1VKlZsgCNxKV1UJ2Adw7yR5POGNE2Y2VyKa5osHoLym3PHl4/TPodujojwdRwdFx
	i/Oo2wcUfVMN9DDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705053004; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0VtVMugAx0bf7F0Ks4LYKgivz5jC/UzmrIRwmqlOnbQ=;
	b=CnkglU/M/lLXvK59kvRO83tUZ3QyD7a+8Tcu7QI+Iep9bGC804RQyIUIXu7l0EH3zp1P/b
	QcIGQbXStRHVWK5yfn/jGt1gLCs1miyxQogPGquQdJj+UY/EDfJP+Ng10pwKE8xrIPQkYB
	lBd26xdI0AEdyzxYFOjM2yC5XddLWOk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705053004;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0VtVMugAx0bf7F0Ks4LYKgivz5jC/UzmrIRwmqlOnbQ=;
	b=LtbMjz1VKlZsgCNxKV1UJ2Adw7yR5POGNE2Y2VyKa5osHoLym3PHl4/TPodujojwdRwdFx
	i/Oo2wcUfVMN9DDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B812313782;
	Fri, 12 Jan 2024 09:50:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cAi2K0sLoWVmOgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 12 Jan 2024 09:50:03 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: ardb@kernel.org,
	nathan@kernel.org,
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
Subject: [PATCH v5 2/4] arch/x86: Move internal setup_data structures into setup_data.h
Date: Fri, 12 Jan 2024 10:44:37 +0100
Message-ID: <20240112095000.8952-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240112095000.8952-1-tzimmermann@suse.de>
References: <20240112095000.8952-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: **
X-Spam-Score: 2.20
X-Spamd-Result: default: False [2.20 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 R_RATELIMIT(0.00)[to_ip_from(RLf6fmkuiuubj71hj5sz5bt3qt)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[23];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FREEMAIL_TO(0.00)[kernel.org,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,google.com,arndb.de,linux.ibm.com,gmail.com,paul-moore.com,namei.org,hallyn.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

The type definition of struct pci_setup_rom in <asm/pci.h> requires
struct setup_data from <asm/bootparam.h>. Many drivers include
<linux/pci.h>, but do not use boot parameters. Changes to bootparam.h
or its included header files could easily trigger a large, unnecessary
rebuild of the kernel.

Moving struct pci_setup_rom into its own header file avoids including
<asm/bootparam.h> in <asm/pci.h>. Moving struct_efi_setup_data allows
to unify duplicated definition of the data structure in a single place.
Also silence clang's warnings about GNU extensions in real-mode code,
which might occur from the changed includes.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

---
v5:
	* silence clang's GNU warnings for real-mode code (Nathan)
---
 arch/x86/Makefile                 |  3 +++
 arch/x86/boot/compressed/efi.h    |  9 ---------
 arch/x86/include/asm/efi.h        |  9 ---------
 arch/x86/include/asm/pci.h        | 13 -------------
 arch/x86/include/asm/setup_data.h | 32 +++++++++++++++++++++++++++++++
 5 files changed, 35 insertions(+), 31 deletions(-)
 create mode 100644 arch/x86/include/asm/setup_data.h

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 1a068de12a56..24076db59783 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -53,6 +53,9 @@ REALMODE_CFLAGS += -fno-stack-protector
 REALMODE_CFLAGS += -Wno-address-of-packed-member
 REALMODE_CFLAGS += $(cc_stack_align4)
 REALMODE_CFLAGS += $(CLANG_FLAGS)
+ifdef CONFIG_CC_IS_CLANG
+REALMODE_CFLAGS += -Wno-gnu
+endif
 export REALMODE_CFLAGS
 
 # BITS is used as extension for files which are available in a 32 bit
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


