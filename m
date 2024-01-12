Return-Path: <linux-arch+bounces-1359-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1518782BDC2
	for <lists+linux-arch@lfdr.de>; Fri, 12 Jan 2024 10:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B458528AC06
	for <lists+linux-arch@lfdr.de>; Fri, 12 Jan 2024 09:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739265EE74;
	Fri, 12 Jan 2024 09:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iE9SBgHU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4nkMfEww";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iE9SBgHU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4nkMfEww"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41A65EE69;
	Fri, 12 Jan 2024 09:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B06331FC26;
	Fri, 12 Jan 2024 09:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705053003; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CLL7UbqwTRO+jPA8knyhwnEyA/q8aoU+IUIrhnjEs40=;
	b=iE9SBgHUFyrEOexiRQ3sfM60JaTmX6NgjmQW4ooSkUYFqcZBe/u96YvcRHebTfqOzmEw58
	LSHQRS/+St7Skel9H4BqyYxhMn6tEBj5lzZcZY2YlXqM+djQmXDrgXqvlu4wZz2uPW7jfZ
	QIuDRyJC74qFuOjFtKRPAxuGqfV82RM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705053003;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CLL7UbqwTRO+jPA8knyhwnEyA/q8aoU+IUIrhnjEs40=;
	b=4nkMfEww/YnYnOmbBdVf4ZkBJluYDa6Lo8BrMF+mJbkyIP0urxxYbEt47GMGlCHTFxacSc
	y9lNd5o7filJwhAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705053003; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CLL7UbqwTRO+jPA8knyhwnEyA/q8aoU+IUIrhnjEs40=;
	b=iE9SBgHUFyrEOexiRQ3sfM60JaTmX6NgjmQW4ooSkUYFqcZBe/u96YvcRHebTfqOzmEw58
	LSHQRS/+St7Skel9H4BqyYxhMn6tEBj5lzZcZY2YlXqM+djQmXDrgXqvlu4wZz2uPW7jfZ
	QIuDRyJC74qFuOjFtKRPAxuGqfV82RM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705053003;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CLL7UbqwTRO+jPA8knyhwnEyA/q8aoU+IUIrhnjEs40=;
	b=4nkMfEww/YnYnOmbBdVf4ZkBJluYDa6Lo8BrMF+mJbkyIP0urxxYbEt47GMGlCHTFxacSc
	y9lNd5o7filJwhAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 23BB3139A1;
	Fri, 12 Jan 2024 09:50:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aCNtB0sLoWVmOgAAD6G6ig
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
Subject: [PATCH v5 1/4] arch/x86: Move UAPI setup structures into setup_data.h
Date: Fri, 12 Jan 2024 10:44:36 +0100
Message-ID: <20240112095000.8952-2-tzimmermann@suse.de>
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
X-Spam-Level: **********
X-Spam-Score: 10.30
X-Spamd-Result: default: False [10.30 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_SPAM(5.10)[100.00%];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLf6fmkuiuubj71hj5sz5bt3qt)];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_TO(0.00)[kernel.org,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,google.com,arndb.de,linux.ibm.com,gmail.com,paul-moore.com,namei.org,hallyn.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[23];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
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


