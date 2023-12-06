Return-Path: <linux-arch+bounces-713-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC7780704E
	for <lists+linux-arch@lfdr.de>; Wed,  6 Dec 2023 13:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D5061C20B01
	for <lists+linux-arch@lfdr.de>; Wed,  6 Dec 2023 12:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3E537141;
	Wed,  6 Dec 2023 12:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="v8TF6YlG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/P2CsblD"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5021A5;
	Wed,  6 Dec 2023 04:54:38 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2D3A31FD0D;
	Wed,  6 Dec 2023 12:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1701867276; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qj72gcam6ZOgbPA7jLBKhrKJdI1UayiC+aw5zIvz5kc=;
	b=v8TF6YlGTAT1dsLbU/AVFy+6XxDM+kdUJtr49J2z3Bw3ADPgdGoUrU2R8jqYhHSEotD2qb
	aQTWPlmzT0sXvVmlPhIA9GMJ36dp/FzFtQ04p405WlZm4+BbXY8RQiXbrsKpwDszp9bh9k
	g4cJ069YEwpwDP5TnEN5bXCKmHeVAUI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1701867276;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qj72gcam6ZOgbPA7jLBKhrKJdI1UayiC+aw5zIvz5kc=;
	b=/P2CsblDpuVxsZ2yqCSmzm+k2EfrrjxiEkHJLU5p8b7TLQmLZqvccqgBsvL2ofBonAkkcn
	h4Y9dyfCFjPcD5Dw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A25AE13B3C;
	Wed,  6 Dec 2023 12:54:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id AORtJgtvcGV6dAAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Wed, 06 Dec 2023 12:54:35 +0000
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
Subject: [PATCH 1/3] arch/x86: Move struct pci_setup_rom into pci_setup.h
Date: Wed,  6 Dec 2023 13:38:37 +0100
Message-ID: <20231206125433.18420-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231206125433.18420-1-tzimmermann@suse.de>
References: <20231206125433.18420-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: 3.20
X-Spamd-Result: default: False [3.20 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 R_MISSING_CHARSET(2.50)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[22];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FREEMAIL_TO(0.00)[kernel.org,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,google.com,arndb.de,linux.ibm.com,gmail.com,paul-moore.com,namei.org,hallyn.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]

The type definition of struct pci_setup_rom in <asm/pci.h> requires
struct setup_data from <asm/bootparam.h>. Many drivers include
<linux/pci.h>, but do not use boot parameters. Changes to bootparam.h
or its included header files could easily trigger a large, unnecessary
rebuild of the kernel.

Moving struct pci_setup_rom into its own header file avoid including
<asm/bootparam.h> in <asm/pci.h>. Update the only two users of the
struct in the x86 PCI code and in the EFI code. Also remove the include
statement for x86_init.h, which is unnecessary but pulls in bootparams.h.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 arch/x86/include/asm/pci.h              | 13 -------------
 arch/x86/include/asm/pci_setup.h        | 19 +++++++++++++++++++
 arch/x86/pci/common.c                   |  1 +
 drivers/firmware/efi/libstub/x86-stub.c |  1 +
 4 files changed, 21 insertions(+), 13 deletions(-)
 create mode 100644 arch/x86/include/asm/pci_setup.h

diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
index b40c462b4af3..b3ab80a03365 100644
--- a/arch/x86/include/asm/pci.h
+++ b/arch/x86/include/asm/pci.h
@@ -10,7 +10,6 @@
 #include <linux/numa.h>
 #include <asm/io.h>
 #include <asm/memtype.h>
-#include <asm/x86_init.h>
 
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
diff --git a/arch/x86/include/asm/pci_setup.h b/arch/x86/include/asm/pci_setup.h
new file mode 100644
index 000000000000..b4b246ef6f2b
--- /dev/null
+++ b/arch/x86/include/asm/pci_setup.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_PCI_SETUP_H
+#define _ASM_X86_PCI_SETUP_H
+
+#include <asm/bootparam.h>
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
+#endif /* _ASM_X86_PCI_SETUP_H */
diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index ddb798603201..c6cbb9182160 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -17,6 +17,7 @@
 #include <asm/segment.h>
 #include <asm/io.h>
 #include <asm/smp.h>
+#include <asm/pci_setup.h>
 #include <asm/pci_x86.h>
 #include <asm/setup.h>
 #include <asm/irqdomain.h>
diff --git a/drivers/firmware/efi/libstub/x86-stub.c b/drivers/firmware/efi/libstub/x86-stub.c
index 1bfdae34df39..0c878ebe5257 100644
--- a/drivers/firmware/efi/libstub/x86-stub.c
+++ b/drivers/firmware/efi/libstub/x86-stub.c
@@ -17,6 +17,7 @@
 #include <asm/boot.h>
 #include <asm/kaslr.h>
 #include <asm/sev.h>
+#include <asm/pci_setup.h>
 
 #include "efistub.h"
 #include "x86-stub.h"
-- 
2.43.0


