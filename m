Return-Path: <linux-arch+bounces-1080-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A69EC81480C
	for <lists+linux-arch@lfdr.de>; Fri, 15 Dec 2023 13:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D580B22B32
	for <lists+linux-arch@lfdr.de>; Fri, 15 Dec 2023 12:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757272DB7B;
	Fri, 15 Dec 2023 12:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PwbUOjoy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/utvE8Cm";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PwbUOjoy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/utvE8Cm"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CC62C6B1;
	Fri, 15 Dec 2023 12:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 911971F829;
	Fri, 15 Dec 2023 12:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702643178; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ionOnhVqbRQv5yJFH2KkaG5cDoE/rfCo3Lap5LRFeCQ=;
	b=PwbUOjoydVNdPC49q1JsmoxCgf8nZ3vdiYzrlNb1/ZCY6ASMRxEYHPK73nGjjtsUMEdhuq
	EnZlyjneCh23omNHtUB+un1qccKZquKI5jeCSLG7ZEIACknW8eJ7MXgYypYc21ciYyagVD
	YQmpO5kbUSDkyqnCn8NE4bsnVrKtG2E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702643178;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ionOnhVqbRQv5yJFH2KkaG5cDoE/rfCo3Lap5LRFeCQ=;
	b=/utvE8CmGuI3thDXTy3J8aIeKraIgUqof+nluhrMGQT0jveIhLhr0yaGOjP2ta1iNv96DV
	CIHfPlsAAX+uYfDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702643178; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ionOnhVqbRQv5yJFH2KkaG5cDoE/rfCo3Lap5LRFeCQ=;
	b=PwbUOjoydVNdPC49q1JsmoxCgf8nZ3vdiYzrlNb1/ZCY6ASMRxEYHPK73nGjjtsUMEdhuq
	EnZlyjneCh23omNHtUB+un1qccKZquKI5jeCSLG7ZEIACknW8eJ7MXgYypYc21ciYyagVD
	YQmpO5kbUSDkyqnCn8NE4bsnVrKtG2E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702643178;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ionOnhVqbRQv5yJFH2KkaG5cDoE/rfCo3Lap5LRFeCQ=;
	b=/utvE8CmGuI3thDXTy3J8aIeKraIgUqof+nluhrMGQT0jveIhLhr0yaGOjP2ta1iNv96DV
	CIHfPlsAAX+uYfDg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 0860713BA0;
	Fri, 15 Dec 2023 12:26:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id mJTrAOpFfGVIRwAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Fri, 15 Dec 2023 12:26:18 +0000
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
Subject: [PATCH v2 3/3] arch/x86: Do not include <asm/bootparam.h> in several header files
Date: Fri, 15 Dec 2023 13:18:14 +0100
Message-ID: <20231215122614.5481-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231215122614.5481-1-tzimmermann@suse.de>
References: <20231215122614.5481-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: 3.40
X-Spam-Flag: NO
X-Spamd-Result: default: False [3.40 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-3.00)[99.99%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 R_MISSING_CHARSET(2.50)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLthqzz6q5hnubohss7ffybi86)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[22];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FREEMAIL_TO(0.00)[kernel.org,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,google.com,arndb.de,linux.ibm.com,gmail.com,paul-moore.com,namei.org,hallyn.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Level: ***
X-Spam-Score: 3.40
Authentication-Results: smtp-out2.suse.de;
	none

Remove the include statement for <asm/bootparam.h> from several header
files that don't require it. Limits the exposure of the boot parameters
within the Linux kernel code. Update several source files that require
code from bootparam.h.

v2:
	* clean up misc.h and e820/types.h
	* include bootparam.h in several source files

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/acpi.c       | 2 ++
 arch/x86/boot/compressed/cmdline.c    | 2 ++
 arch/x86/boot/compressed/efi.c        | 2 ++
 arch/x86/boot/compressed/misc.h       | 3 ++-
 arch/x86/boot/compressed/pgtable_64.c | 1 +
 arch/x86/boot/compressed/sev.c        | 1 +
 arch/x86/include/asm/e820/types.h     | 2 +-
 arch/x86/include/asm/kexec.h          | 1 -
 arch/x86/include/asm/mem_encrypt.h    | 2 +-
 arch/x86/include/asm/sev.h            | 3 ++-
 arch/x86/include/asm/x86_init.h       | 2 --
 arch/x86/kernel/crash.c               | 1 +
 arch/x86/kernel/sev-shared.c          | 2 ++
 arch/x86/platform/pvh/enlighten.c     | 1 +
 arch/x86/xen/enlighten_pvh.c          | 1 +
 arch/x86/xen/vga.c                    | 1 -
 16 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index 55c98fdd67d2..4db998a8d8f0 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -5,6 +5,8 @@
 #include "../string.h"
 #include "efi.h"
 
+#include <asm/bootparam.h>
+
 #include <linux/numa.h>
 
 /*
diff --git a/arch/x86/boot/compressed/cmdline.c b/arch/x86/boot/compressed/cmdline.c
index c1bb180973ea..e162d7f59cc5 100644
--- a/arch/x86/boot/compressed/cmdline.c
+++ b/arch/x86/boot/compressed/cmdline.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "misc.h"
 
+#include <asm/bootparam.h>
+
 static unsigned long fs;
 static inline void set_fs(unsigned long seg)
 {
diff --git a/arch/x86/boot/compressed/efi.c b/arch/x86/boot/compressed/efi.c
index 6edd034b0b30..f2e50f9758e6 100644
--- a/arch/x86/boot/compressed/efi.c
+++ b/arch/x86/boot/compressed/efi.c
@@ -7,6 +7,8 @@
 
 #include "misc.h"
 
+#include <asm/bootparam.h>
+
 /**
  * efi_get_type - Given a pointer to boot_params, determine the type of EFI environment.
  *
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index c0d502bd8716..01c89c410efd 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -33,7 +33,6 @@
 #include <linux/elf.h>
 #include <asm/page.h>
 #include <asm/boot.h>
-#include <asm/bootparam.h>
 #include <asm/desc_defs.h>
 
 #include "tdx.h"
@@ -53,6 +52,8 @@
 #define memptr unsigned
 #endif
 
+struct boot_param;
+
 /* boot/compressed/vmlinux start and end markers */
 extern char _head[], _end[];
 
diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index 51f957b24ba7..c882e1f67af0 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "misc.h"
+#include <asm/bootparam.h>
 #include <asm/e820/types.h>
 #include <asm/processor.h>
 #include "pgtable.h"
diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 454acd7a2daf..13beae767e48 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -12,6 +12,7 @@
  */
 #include "misc.h"
 
+#include <asm/bootparam.h>
 #include <asm/pgtable_types.h>
 #include <asm/sev.h>
 #include <asm/trapnr.h>
diff --git a/arch/x86/include/asm/e820/types.h b/arch/x86/include/asm/e820/types.h
index 314f75d886d0..47695db18246 100644
--- a/arch/x86/include/asm/e820/types.h
+++ b/arch/x86/include/asm/e820/types.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_E820_TYPES_H
 #define _ASM_E820_TYPES_H
 
-#include <uapi/asm/bootparam.h>
+#include <asm/setup_data.h>
 
 /*
  * These are the E820 types known to the kernel:
diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index c9f6a6c5de3c..91ca9a9ee3a2 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -25,7 +25,6 @@
 
 #include <asm/page.h>
 #include <asm/ptrace.h>
-#include <asm/bootparam.h>
 
 struct kimage;
 
diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index 359ada486fa9..c1a8a3408c18 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -15,7 +15,7 @@
 #include <linux/init.h>
 #include <linux/cc_platform.h>
 
-#include <asm/bootparam.h>
+struct boot_params;
 
 #ifdef CONFIG_X86_MEM_ENCRYPT
 void __init mem_encrypt_init(void);
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 5b4a1ce3d368..8dad8b1613bf 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -13,7 +13,6 @@
 
 #include <asm/insn.h>
 #include <asm/sev-common.h>
-#include <asm/bootparam.h>
 #include <asm/coco.h>
 
 #define GHCB_PROTOCOL_MIN	1ULL
@@ -22,6 +21,8 @@
 
 #define	VMGEXIT()			{ asm volatile("rep; vmmcall\n\r"); }
 
+struct boot_params;
+
 enum es_result {
 	ES_OK,			/* All good */
 	ES_UNSUPPORTED,		/* Requested operation not supported */
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index c878616a18b8..f062715578a0 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -2,8 +2,6 @@
 #ifndef _ASM_X86_PLATFORM_H
 #define _ASM_X86_PLATFORM_H
 
-#include <asm/bootparam.h>
-
 struct ghcb;
 struct mpc_bus;
 struct mpc_cpu;
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index c92d88680dbf..564cff7ed33a 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -26,6 +26,7 @@
 #include <linux/vmalloc.h>
 #include <linux/memblock.h>
 
+#include <asm/bootparam.h>
 #include <asm/processor.h>
 #include <asm/hardirq.h>
 #include <asm/nmi.h>
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index ccb0915e84e1..4962ec42dc68 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -9,6 +9,8 @@
  * and is included directly into both code-bases.
  */
 
+#include <asm/setup_data.h>
+
 #ifndef __BOOT_COMPRESSED
 #define error(v)	pr_err(v)
 #define has_cpuflag(f)	boot_cpu_has(f)
diff --git a/arch/x86/platform/pvh/enlighten.c b/arch/x86/platform/pvh/enlighten.c
index 00a92cb2c814..944e0290f2c0 100644
--- a/arch/x86/platform/pvh/enlighten.c
+++ b/arch/x86/platform/pvh/enlighten.c
@@ -3,6 +3,7 @@
 
 #include <xen/hvc-console.h>
 
+#include <asm/bootparam.h>
 #include <asm/io_apic.h>
 #include <asm/hypervisor.h>
 #include <asm/e820/api.h>
diff --git a/arch/x86/xen/enlighten_pvh.c b/arch/x86/xen/enlighten_pvh.c
index ada3868c02c2..9e9db601bd52 100644
--- a/arch/x86/xen/enlighten_pvh.c
+++ b/arch/x86/xen/enlighten_pvh.c
@@ -4,6 +4,7 @@
 
 #include <xen/hvc-console.h>
 
+#include <asm/bootparam.h>
 #include <asm/io_apic.h>
 #include <asm/hypervisor.h>
 #include <asm/e820/api.h>
diff --git a/arch/x86/xen/vga.c b/arch/x86/xen/vga.c
index d97adab8420f..f7547807b0bd 100644
--- a/arch/x86/xen/vga.c
+++ b/arch/x86/xen/vga.c
@@ -2,7 +2,6 @@
 #include <linux/screen_info.h>
 #include <linux/init.h>
 
-#include <asm/bootparam.h>
 #include <asm/setup.h>
 
 #include <xen/interface/xen.h>
-- 
2.43.0


