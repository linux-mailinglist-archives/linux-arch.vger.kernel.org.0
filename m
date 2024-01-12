Return-Path: <linux-arch+bounces-1362-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D7882BDD5
	for <lists+linux-arch@lfdr.de>; Fri, 12 Jan 2024 10:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FEE11C25372
	for <lists+linux-arch@lfdr.de>; Fri, 12 Jan 2024 09:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59CC5FF12;
	Fri, 12 Jan 2024 09:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WVfb89vf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GNKTw6kD";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WVfb89vf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GNKTw6kD"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D565EE82;
	Fri, 12 Jan 2024 09:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8193F21E5A;
	Fri, 12 Jan 2024 09:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705053005; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ZY5CvUKPTyR/DoYhG/6WLW1e06/fH9Nafua63trqkc=;
	b=WVfb89vfFOsfEQtmvvxMABtAAqd4mvPtclri/fLLV0HtETZ+f00vBbuf84LcqDqTUtmYd9
	p/p8uNqVD/25+fIw+MfJ1sfpaJrtNp+CCiew/2fWJXXvrpXIBIAu+xNM2wDiJgWbKLtUN9
	AGN/surNnYHZzBkP7vm2uaTwYYrP+os=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705053005;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ZY5CvUKPTyR/DoYhG/6WLW1e06/fH9Nafua63trqkc=;
	b=GNKTw6kDfumSrhXL8aBNPuFDSXgOyUwW5MG5LU3CTmblkDYzL7mYhh6rl38fA3ZfOkQmcz
	7bHg3H6dazhdIbAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705053005; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ZY5CvUKPTyR/DoYhG/6WLW1e06/fH9Nafua63trqkc=;
	b=WVfb89vfFOsfEQtmvvxMABtAAqd4mvPtclri/fLLV0HtETZ+f00vBbuf84LcqDqTUtmYd9
	p/p8uNqVD/25+fIw+MfJ1sfpaJrtNp+CCiew/2fWJXXvrpXIBIAu+xNM2wDiJgWbKLtUN9
	AGN/surNnYHZzBkP7vm2uaTwYYrP+os=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705053005;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ZY5CvUKPTyR/DoYhG/6WLW1e06/fH9Nafua63trqkc=;
	b=GNKTw6kDfumSrhXL8aBNPuFDSXgOyUwW5MG5LU3CTmblkDYzL7mYhh6rl38fA3ZfOkQmcz
	7bHg3H6dazhdIbAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EBCF613782;
	Fri, 12 Jan 2024 09:50:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MPxPOEwLoWVmOgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 12 Jan 2024 09:50:04 +0000
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
Subject: [PATCH v5 4/4] arch/x86: Do not include <asm/bootparam.h> in several files
Date: Fri, 12 Jan 2024 10:44:39 +0100
Message-ID: <20240112095000.8952-5-tzimmermann@suse.de>
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
X-Spam-Level: *
X-Spamd-Bar: +
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=WVfb89vf;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GNKTw6kD
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [1.99 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLfgmttzabnpkr34rizty4fwu5)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_TO(0.00)[kernel.org,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,google.com,arndb.de,linux.ibm.com,gmail.com,paul-moore.com,namei.org,hallyn.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[23];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: 1.99
X-Rspamd-Queue-Id: 8193F21E5A
X-Spam-Flag: NO

Remove the include statement for <asm/bootparam.h> from several files
that don't require it. Limits the exposure of the boot parameters
within the Linux kernel code.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Acked-by: Ard Biesheuvel <ardb@kernel.org>

---

v5:
	* revert of boot/compressed/misc.h (kernel test robot)
v3:
	* revert of e820/types.h required
v2:
	* clean up misc.h and e820/types.h
	* include bootparam.h in several source files
---
 arch/x86/boot/compressed/acpi.c       | 2 ++
 arch/x86/boot/compressed/cmdline.c    | 2 ++
 arch/x86/boot/compressed/efi.c        | 2 ++
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
 14 files changed, 16 insertions(+), 6 deletions(-)

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


