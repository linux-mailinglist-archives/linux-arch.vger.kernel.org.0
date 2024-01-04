Return-Path: <linux-arch+bounces-1276-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBEB823F0F
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jan 2024 10:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D57721F216D7
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jan 2024 09:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9153D21352;
	Thu,  4 Jan 2024 09:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fustg9+o";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dbXGBzKJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fustg9+o";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dbXGBzKJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BAB20DE1;
	Thu,  4 Jan 2024 09:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A5BB91F7FC;
	Thu,  4 Jan 2024 09:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704362066; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4i41TaruQR4Pq5LXVEoj7/T9YHF9NQenB4+HeINuBzQ=;
	b=fustg9+o6qY6TdkQ3bcIke++mqLviQ0aEDOI0jykhmrcW5x4qRYGZjNEUDkZL/krZ41f5i
	KWUA6mdqYEKTND1s/sQjOp/uNrumayJQa368Ek6PQYjNjwN1ypUWhjWBJoTt0qKCvkNm8Y
	GzNAFybAGvMDkMpmXNqwfPin/Mkb0PU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704362066;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4i41TaruQR4Pq5LXVEoj7/T9YHF9NQenB4+HeINuBzQ=;
	b=dbXGBzKJXvS9A4pyna6aepGghBvFxQypR9kpnM2NVdT36NzRsMZRdwSmbUEkrbgflYoYiu
	dIl2cW7cX8NyIuBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704362066; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4i41TaruQR4Pq5LXVEoj7/T9YHF9NQenB4+HeINuBzQ=;
	b=fustg9+o6qY6TdkQ3bcIke++mqLviQ0aEDOI0jykhmrcW5x4qRYGZjNEUDkZL/krZ41f5i
	KWUA6mdqYEKTND1s/sQjOp/uNrumayJQa368Ek6PQYjNjwN1ypUWhjWBJoTt0qKCvkNm8Y
	GzNAFybAGvMDkMpmXNqwfPin/Mkb0PU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704362066;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4i41TaruQR4Pq5LXVEoj7/T9YHF9NQenB4+HeINuBzQ=;
	b=dbXGBzKJXvS9A4pyna6aepGghBvFxQypR9kpnM2NVdT36NzRsMZRdwSmbUEkrbgflYoYiu
	dIl2cW7cX8NyIuBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 184EE137E8;
	Thu,  4 Jan 2024 09:54:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6LObBFKAlmXPZwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 04 Jan 2024 09:54:26 +0000
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
Subject: [PATCH v3 4/4] arch/x86: Do not include <asm/bootparam.h> in several files
Date: Thu,  4 Jan 2024 10:51:22 +0100
Message-ID: <20240104095421.12772-5-tzimmermann@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240104095421.12772-1-tzimmermann@suse.de>
References: <20240104095421.12772-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: 3.40
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
	 R_RATELIMIT(0.00)[to_ip_from(RLf6fmkuiuubj71hj5sz5bt3qt)];
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
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: ***
X-Spam-Flag: NO

Remove the include statement for <asm/bootparam.h> from several files
that don't require it. Limits the exposure of the boot parameters
within the Linux kernel code.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Acked-by: Ard Biesheuvel <ardb@kernel.org>

---

v3:
	* revert of e820/types.h required
v2:
	* clean up misc.h and e820/types.h
	* include bootparam.h in several source files
---
 arch/x86/boot/compressed/acpi.c       | 2 ++
 arch/x86/boot/compressed/cmdline.c    | 2 ++
 arch/x86/boot/compressed/efi.c        | 2 ++
 arch/x86/boot/compressed/misc.h       | 3 ++-
 arch/x86/boot/compressed/pgtable_64.c | 1 +
 arch/x86/boot/compressed/sev.c        | 1 +
 arch/x86/include/asm/kexec.h          | 1 -
 arch/x86/include/asm/mem_encrypt.h    | 2 +-
 arch/x86/include/asm/sev.h            | 3 ++-
 arch/x86/include/asm/x86_init.h       | 2 --
 arch/x86/kernel/crash.c               | 1 +
 arch/x86/kernel/sev-shared.c          | 2 ++
 arch/x86/platform/pvh/enlighten.c     | 1 +
 arch/x86/xen/enlighten_pvh.c          | 1 +
 arch/x86/xen/vga.c                    | 1 -
 15 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index 18d15d1ce87d..f196b1d1ddf8 100644
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


