Return-Path: <linux-arch+bounces-3340-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E72892563
	for <lists+linux-arch@lfdr.de>; Fri, 29 Mar 2024 21:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DC2B1F2354B
	for <lists+linux-arch@lfdr.de>; Fri, 29 Mar 2024 20:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E22E13C3C1;
	Fri, 29 Mar 2024 20:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BEH6k13F";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DYl3wj2R"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA1C3D0C4;
	Fri, 29 Mar 2024 20:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711744505; cv=none; b=WtP/IPWExHAOSh+6kx/FYzE16OfqJGpOCRHH9OrLWS2rZ/RdO3iKd6pnXyk2CePrNa+dfwO32smaKPS0+D5iDaA2uUfagbAcNNT3RWqtiq/ZC5COELtVnApQ9gHEHKBt5tX81TOaf+o8W6jyCtWjQggSxY3urEb6T8Nt/UYvM0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711744505; c=relaxed/simple;
	bh=K0PZNh0IwdmRYNywJS8uN8kyw19Kuc+wMw/tHgm0lhc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kach7GyzAn1dl+uc6Hx/JAKgIAu3VAqrPwYhexEHRQ8BZMF2ROolzLEYcHd5LWZ2jsOKCQAamThIS2mEfdUnan7oVpxE5xXjJEUEOPmUURxm058NTpYQn1EH36jMM8tA28ZrZ5ret2c4HypuRBQdw4BvBpJvdIFgRw8Ydsuz/eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BEH6k13F; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DYl3wj2R; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E30ED5CAD0;
	Fri, 29 Mar 2024 20:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711744500; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bco5nPUaHMrSgY6j/Seo6orLpynLXVjb/8rV94Hb23o=;
	b=BEH6k13Fm6/PU2cMC2+bp//nWdvY9zIRQfIsyQ5gQiaVX0lFnSiNf1h5/6YZihpL4C0TEI
	lKgEhfmMt2IJeWnXvb31kGRTSA/oWpwaea4++t1gJKStPMBNbJUOTfovf2/NLrsja+uJYt
	hld51KxaK3fhnQbBd2+4HYclVSPPKa8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711744500;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bco5nPUaHMrSgY6j/Seo6orLpynLXVjb/8rV94Hb23o=;
	b=DYl3wj2R3rJZx3F5OiXkO8tUlH775X765GSN+KcLe3BI3He7N/3ue+etLabQ/M61Eao88A
	6XNGfIuup87xRbBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id CB02313A8B;
	Fri, 29 Mar 2024 20:34:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id iAMwMPMlB2YTPgAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Fri, 29 Mar 2024 20:34:59 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: arnd@arndb.de,
	sam@ravnborg.org,
	javierm@redhat.com,
	deller@gmx.de,
	sui.jingfeng@linux.dev
Cc: linux-arch@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-parisc@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	loongarch@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-snps-arc@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Vineet Gupta <vgupta@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v3 3/3] arch: Rename fbdev header and source files
Date: Fri, 29 Mar 2024 21:32:12 +0100
Message-ID: <20240329203450.7824-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240329203450.7824-1-tzimmermann@suse.de>
References: <20240329203450.7824-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: 2.89
X-Spam-Flag: NO
X-Spamd-Bar: ++
X-Spamd-Result: default: False [2.89 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 R_RATELIMIT(0.00)[to_ip_from(RL8bnzzinbm939qqjaserdumcx)];
	 RCVD_COUNT_THREE(0.00)[3];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 FREEMAIL_TO(0.00)[arndb.de,ravnborg.org,redhat.com,gmx.de,linux.dev];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[40];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[vger.kernel.org,lists.freedesktop.org,lists.ozlabs.org,lists.linux-m68k.org,lists.linux.dev,lists.infradead.org,suse.de,kernel.org,arm.com,xen0n.name,linux-m68k.org,alpha.franken.de,HansenPartnership.com,ellerman.id.au,gmail.com,users.sourceforge.jp,libc.org,physik.fu-berlin.de,davemloft.net,gaisler.com,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Level: **
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E30ED5CAD0

The per-architecture fbdev code has no dependencies on fbdev and can
be used for any video-related subsystem. Rename the files to 'video'.
Use video-sti.c on parisc as the source file depends on CONFIG_STI_CORE.

On arc, arm, arm64, sh, and um the asm header file is an empty wrapper
around the file in asm-generic. Let Kbuild generate the file. The build
system does this automatically. Only um needs to generate video.h
explicitly, so that it overrides the host architecture's header. The
latter would otherwise interfere with the build.

Further update all includes statements, include guards, and Makefiles.
Also update a few strings and comments to refer to video instead of
fbdev.

v3:
- arc, arm, arm64, sh: generate asm header via build system (Sam,
Helge, Arnd)
- um: rename fb.h to video.h
- fix typo in commit message (Sam)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Vineet Gupta <vgupta@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/arc/include/asm/fb.h                    |  8 --------
 arch/arm/include/asm/fb.h                    |  6 ------
 arch/arm64/include/asm/fb.h                  | 10 ----------
 arch/loongarch/include/asm/{fb.h => video.h} |  8 ++++----
 arch/m68k/include/asm/{fb.h => video.h}      |  8 ++++----
 arch/mips/include/asm/{fb.h => video.h}      | 12 ++++++------
 arch/parisc/include/asm/{fb.h => video.h}    |  8 ++++----
 arch/parisc/video/Makefile                   |  2 +-
 arch/parisc/video/{fbdev.c => video-sti.c}   |  2 +-
 arch/powerpc/include/asm/{fb.h => video.h}   |  8 ++++----
 arch/powerpc/kernel/pci-common.c             |  2 +-
 arch/sh/include/asm/fb.h                     |  7 -------
 arch/sparc/include/asm/{fb.h => video.h}     |  8 ++++----
 arch/sparc/video/Makefile                    |  2 +-
 arch/sparc/video/{fbdev.c => video.c}        |  4 ++--
 arch/um/include/asm/Kbuild                   |  2 +-
 arch/x86/include/asm/{fb.h => video.h}       |  8 ++++----
 arch/x86/video/Makefile                      |  2 +-
 arch/x86/video/{fbdev.c => video.c}          |  3 ++-
 include/asm-generic/Kbuild                   |  2 +-
 include/asm-generic/{fb.h => video.h}        |  6 +++---
 include/linux/fb.h                           |  2 +-
 22 files changed, 45 insertions(+), 75 deletions(-)
 delete mode 100644 arch/arc/include/asm/fb.h
 delete mode 100644 arch/arm/include/asm/fb.h
 delete mode 100644 arch/arm64/include/asm/fb.h
 rename arch/loongarch/include/asm/{fb.h => video.h} (86%)
 rename arch/m68k/include/asm/{fb.h => video.h} (86%)
 rename arch/mips/include/asm/{fb.h => video.h} (76%)
 rename arch/parisc/include/asm/{fb.h => video.h} (68%)
 rename arch/parisc/video/{fbdev.c => video-sti.c} (96%)
 rename arch/powerpc/include/asm/{fb.h => video.h} (76%)
 delete mode 100644 arch/sh/include/asm/fb.h
 rename arch/sparc/include/asm/{fb.h => video.h} (89%)
 rename arch/sparc/video/{fbdev.c => video.c} (86%)
 rename arch/x86/include/asm/{fb.h => video.h} (77%)
 rename arch/x86/video/{fbdev.c => video.c} (97%)
 rename include/asm-generic/{fb.h => video.h} (96%)

diff --git a/arch/arc/include/asm/fb.h b/arch/arc/include/asm/fb.h
deleted file mode 100644
index 9c2383d29cbb9..0000000000000
--- a/arch/arc/include/asm/fb.h
+++ /dev/null
@@ -1,8 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-
-#ifndef _ASM_FB_H_
-#define _ASM_FB_H_
-
-#include <asm-generic/fb.h>
-
-#endif /* _ASM_FB_H_ */
diff --git a/arch/arm/include/asm/fb.h b/arch/arm/include/asm/fb.h
deleted file mode 100644
index ce20a43c30339..0000000000000
--- a/arch/arm/include/asm/fb.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef _ASM_FB_H_
-#define _ASM_FB_H_
-
-#include <asm-generic/fb.h>
-
-#endif /* _ASM_FB_H_ */
diff --git a/arch/arm64/include/asm/fb.h b/arch/arm64/include/asm/fb.h
deleted file mode 100644
index 1a495d8fb2ce0..0000000000000
--- a/arch/arm64/include/asm/fb.h
+++ /dev/null
@@ -1,10 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) 2012 ARM Ltd.
- */
-#ifndef __ASM_FB_H_
-#define __ASM_FB_H_
-
-#include <asm-generic/fb.h>
-
-#endif /* __ASM_FB_H_ */
diff --git a/arch/loongarch/include/asm/fb.h b/arch/loongarch/include/asm/video.h
similarity index 86%
rename from arch/loongarch/include/asm/fb.h
rename to arch/loongarch/include/asm/video.h
index 0b218b10a9ec3..9f76845f2d4fd 100644
--- a/arch/loongarch/include/asm/fb.h
+++ b/arch/loongarch/include/asm/video.h
@@ -2,8 +2,8 @@
 /*
  * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
  */
-#ifndef _ASM_FB_H_
-#define _ASM_FB_H_
+#ifndef _ASM_VIDEO_H_
+#define _ASM_VIDEO_H_
 
 #include <linux/compiler.h>
 #include <linux/string.h>
@@ -26,6 +26,6 @@ static inline void fb_memset_io(volatile void __iomem *addr, int c, size_t n)
 }
 #define fb_memset fb_memset_io
 
-#include <asm-generic/fb.h>
+#include <asm-generic/video.h>
 
-#endif /* _ASM_FB_H_ */
+#endif /* _ASM_VIDEO_H_ */
diff --git a/arch/m68k/include/asm/fb.h b/arch/m68k/include/asm/video.h
similarity index 86%
rename from arch/m68k/include/asm/fb.h
rename to arch/m68k/include/asm/video.h
index 9941b7434b696..6cf2194c413d8 100644
--- a/arch/m68k/include/asm/fb.h
+++ b/arch/m68k/include/asm/video.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_FB_H_
-#define _ASM_FB_H_
+#ifndef _ASM_VIDEO_H_
+#define _ASM_VIDEO_H_
 
 #include <asm/page.h>
 #include <asm/setup.h>
@@ -27,6 +27,6 @@ static inline pgprot_t pgprot_framebuffer(pgprot_t prot,
 }
 #define pgprot_framebuffer pgprot_framebuffer
 
-#include <asm-generic/fb.h>
+#include <asm-generic/video.h>
 
-#endif /* _ASM_FB_H_ */
+#endif /* _ASM_VIDEO_H_ */
diff --git a/arch/mips/include/asm/fb.h b/arch/mips/include/asm/video.h
similarity index 76%
rename from arch/mips/include/asm/fb.h
rename to arch/mips/include/asm/video.h
index d98d6681d64ec..007c106d980fd 100644
--- a/arch/mips/include/asm/fb.h
+++ b/arch/mips/include/asm/video.h
@@ -1,5 +1,5 @@
-#ifndef _ASM_FB_H_
-#define _ASM_FB_H_
+#ifndef _ASM_VIDEO_H_
+#define _ASM_VIDEO_H_
 
 #include <asm/page.h>
 
@@ -13,8 +13,8 @@ static inline pgprot_t pgprot_framebuffer(pgprot_t prot,
 
 /*
  * MIPS doesn't define __raw_ I/O macros, so the helpers
- * in <asm-generic/fb.h> don't generate fb_readq() and
- * fb_write(). We have to provide them here.
+ * in <asm-generic/video.h> don't generate fb_readq() and
+ * fb_writeq(). We have to provide them here.
  *
  * TODO: Convert MIPS to generic I/O. The helpers below can
  *       then be removed.
@@ -33,6 +33,6 @@ static inline void fb_writeq(u64 b, volatile void __iomem *addr)
 #define fb_writeq fb_writeq
 #endif
 
-#include <asm-generic/fb.h>
+#include <asm-generic/video.h>
 
-#endif /* _ASM_FB_H_ */
+#endif /* _ASM_VIDEO_H_ */
diff --git a/arch/parisc/include/asm/fb.h b/arch/parisc/include/asm/video.h
similarity index 68%
rename from arch/parisc/include/asm/fb.h
rename to arch/parisc/include/asm/video.h
index ed2a195a3e762..c5dff3223194a 100644
--- a/arch/parisc/include/asm/fb.h
+++ b/arch/parisc/include/asm/video.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_FB_H_
-#define _ASM_FB_H_
+#ifndef _ASM_VIDEO_H_
+#define _ASM_VIDEO_H_
 
 #include <linux/types.h>
 
@@ -11,6 +11,6 @@ bool video_is_primary_device(struct device *dev);
 #define video_is_primary_device video_is_primary_device
 #endif
 
-#include <asm-generic/fb.h>
+#include <asm-generic/video.h>
 
-#endif /* _ASM_FB_H_ */
+#endif /* _ASM_VIDEO_H_ */
diff --git a/arch/parisc/video/Makefile b/arch/parisc/video/Makefile
index 16a73cce46612..b5db5b42880f8 100644
--- a/arch/parisc/video/Makefile
+++ b/arch/parisc/video/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-obj-$(CONFIG_STI_CORE) += fbdev.o
+obj-$(CONFIG_STI_CORE) += video-sti.o
diff --git a/arch/parisc/video/fbdev.c b/arch/parisc/video/video-sti.c
similarity index 96%
rename from arch/parisc/video/fbdev.c
rename to arch/parisc/video/video-sti.c
index 540fa0c919d59..564661e87093c 100644
--- a/arch/parisc/video/fbdev.c
+++ b/arch/parisc/video/video-sti.c
@@ -9,7 +9,7 @@
 
 #include <video/sticore.h>
 
-#include <asm/fb.h>
+#include <asm/video.h>
 
 bool video_is_primary_device(struct device *dev)
 {
diff --git a/arch/powerpc/include/asm/fb.h b/arch/powerpc/include/asm/video.h
similarity index 76%
rename from arch/powerpc/include/asm/fb.h
rename to arch/powerpc/include/asm/video.h
index c0c5d1df7ad1e..e1770114ffc36 100644
--- a/arch/powerpc/include/asm/fb.h
+++ b/arch/powerpc/include/asm/video.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_FB_H_
-#define _ASM_FB_H_
+#ifndef _ASM_VIDEO_H_
+#define _ASM_VIDEO_H_
 
 #include <asm/page.h>
 
@@ -12,6 +12,6 @@ static inline pgprot_t pgprot_framebuffer(pgprot_t prot,
 }
 #define pgprot_framebuffer pgprot_framebuffer
 
-#include <asm-generic/fb.h>
+#include <asm-generic/video.h>
 
-#endif /* _ASM_FB_H_ */
+#endif /* _ASM_VIDEO_H_ */
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index d95a48eff412e..eac84d687b53f 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -517,7 +517,7 @@ int pci_iobar_pfn(struct pci_dev *pdev, int bar, struct vm_area_struct *vma)
 }
 
 /*
- * This one is used by /dev/mem and fbdev who have no clue about the
+ * This one is used by /dev/mem and video who have no clue about the
  * PCI device, it tries to find the PCI device first and calls the
  * above routine
  */
diff --git a/arch/sh/include/asm/fb.h b/arch/sh/include/asm/fb.h
deleted file mode 100644
index 19df13ee9ca73..0000000000000
--- a/arch/sh/include/asm/fb.h
+++ /dev/null
@@ -1,7 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_FB_H_
-#define _ASM_FB_H_
-
-#include <asm-generic/fb.h>
-
-#endif /* _ASM_FB_H_ */
diff --git a/arch/sparc/include/asm/fb.h b/arch/sparc/include/asm/video.h
similarity index 89%
rename from arch/sparc/include/asm/fb.h
rename to arch/sparc/include/asm/video.h
index 07f0325d6921c..a6f48f52db584 100644
--- a/arch/sparc/include/asm/fb.h
+++ b/arch/sparc/include/asm/video.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _SPARC_FB_H_
-#define _SPARC_FB_H_
+#ifndef _SPARC_VIDEO_H_
+#define _SPARC_VIDEO_H_
 
 #include <linux/io.h>
 #include <linux/types.h>
@@ -40,6 +40,6 @@ static inline void fb_memset_io(volatile void __iomem *addr, int c, size_t n)
 }
 #define fb_memset fb_memset_io
 
-#include <asm-generic/fb.h>
+#include <asm-generic/video.h>
 
-#endif /* _SPARC_FB_H_ */
+#endif /* _SPARC_VIDEO_H_ */
diff --git a/arch/sparc/video/Makefile b/arch/sparc/video/Makefile
index 9dd82880a027a..fdf83a408d750 100644
--- a/arch/sparc/video/Makefile
+++ b/arch/sparc/video/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-obj-y	+= fbdev.o
+obj-y	+= video.o
diff --git a/arch/sparc/video/fbdev.c b/arch/sparc/video/video.c
similarity index 86%
rename from arch/sparc/video/fbdev.c
rename to arch/sparc/video/video.c
index e46f0499c2774..2414380caadc9 100644
--- a/arch/sparc/video/fbdev.c
+++ b/arch/sparc/video/video.c
@@ -4,8 +4,8 @@
 #include <linux/device.h>
 #include <linux/module.h>
 
-#include <asm/fb.h>
 #include <asm/prom.h>
+#include <asm/video.h>
 
 bool video_is_primary_device(struct device *dev)
 {
@@ -21,5 +21,5 @@ bool video_is_primary_device(struct device *dev)
 }
 EXPORT_SYMBOL(video_is_primary_device);
 
-MODULE_DESCRIPTION("Sparc fbdev helpers");
+MODULE_DESCRIPTION("Sparc video helpers");
 MODULE_LICENSE("GPL");
diff --git a/arch/um/include/asm/Kbuild b/arch/um/include/asm/Kbuild
index b2d834a29f3a9..6fe34779291a8 100644
--- a/arch/um/include/asm/Kbuild
+++ b/arch/um/include/asm/Kbuild
@@ -8,7 +8,6 @@ generic-y += dma-mapping.h
 generic-y += emergency-restart.h
 generic-y += exec.h
 generic-y += extable.h
-generic-y += fb.h
 generic-y += ftrace.h
 generic-y += hw_irq.h
 generic-y += irq_regs.h
@@ -28,3 +27,4 @@ generic-y += trace_clock.h
 generic-y += kprobes.h
 generic-y += mm_hooks.h
 generic-y += vga.h
+generic-y += video.h
diff --git a/arch/x86/include/asm/fb.h b/arch/x86/include/asm/video.h
similarity index 77%
rename from arch/x86/include/asm/fb.h
rename to arch/x86/include/asm/video.h
index 999db33792869..0950c9535fae9 100644
--- a/arch/x86/include/asm/fb.h
+++ b/arch/x86/include/asm/video.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_X86_FB_H
-#define _ASM_X86_FB_H
+#ifndef _ASM_X86_VIDEO_H
+#define _ASM_X86_VIDEO_H
 
 #include <linux/types.h>
 
@@ -16,6 +16,6 @@ pgprot_t pgprot_framebuffer(pgprot_t prot,
 bool video_is_primary_device(struct device *dev);
 #define video_is_primary_device video_is_primary_device
 
-#include <asm-generic/fb.h>
+#include <asm-generic/video.h>
 
-#endif /* _ASM_X86_FB_H */
+#endif /* _ASM_X86_VIDEO_H */
diff --git a/arch/x86/video/Makefile b/arch/x86/video/Makefile
index 9dd82880a027a..fdf83a408d750 100644
--- a/arch/x86/video/Makefile
+++ b/arch/x86/video/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-obj-y	+= fbdev.o
+obj-y	+= video.o
diff --git a/arch/x86/video/fbdev.c b/arch/x86/video/video.c
similarity index 97%
rename from arch/x86/video/fbdev.c
rename to arch/x86/video/video.c
index 4d87ce8e257fe..81fc97a2a837a 100644
--- a/arch/x86/video/fbdev.c
+++ b/arch/x86/video/video.c
@@ -10,7 +10,8 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/vgaarb.h>
-#include <asm/fb.h>
+
+#include <asm/video.h>
 
 pgprot_t pgprot_framebuffer(pgprot_t prot,
 			    unsigned long vm_start, unsigned long vm_end,
diff --git a/include/asm-generic/Kbuild b/include/asm-generic/Kbuild
index d436bee4d129d..b20fa25a7e8d8 100644
--- a/include/asm-generic/Kbuild
+++ b/include/asm-generic/Kbuild
@@ -22,7 +22,6 @@ mandatory-y += dma-mapping.h
 mandatory-y += dma.h
 mandatory-y += emergency-restart.h
 mandatory-y += exec.h
-mandatory-y += fb.h
 mandatory-y += ftrace.h
 mandatory-y += futex.h
 mandatory-y += hardirq.h
@@ -62,5 +61,6 @@ mandatory-y += uaccess.h
 mandatory-y += unaligned.h
 mandatory-y += vermagic.h
 mandatory-y += vga.h
+mandatory-y += video.h
 mandatory-y += word-at-a-time.h
 mandatory-y += xor.h
diff --git a/include/asm-generic/fb.h b/include/asm-generic/video.h
similarity index 96%
rename from include/asm-generic/fb.h
rename to include/asm-generic/video.h
index 4788c1e1c6bc0..b1da2309d9434 100644
--- a/include/asm-generic/fb.h
+++ b/include/asm-generic/video.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
-#ifndef __ASM_GENERIC_FB_H_
-#define __ASM_GENERIC_FB_H_
+#ifndef __ASM_GENERIC_VIDEO_H_
+#define __ASM_GENERIC_VIDEO_H_
 
 /*
  * Only include this header file from your architecture's <asm/fb.h>.
@@ -133,4 +133,4 @@ static inline void fb_memset_io(volatile void __iomem *addr, int c, size_t n)
 #define fb_memset fb_memset_io
 #endif
 
-#endif /* __ASM_GENERIC_FB_H_ */
+#endif /* __ASM_GENERIC_VIDEO_H_ */
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 3417103885e27..0f0834939b6a9 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -12,7 +12,7 @@
 #include <linux/types.h>
 #include <linux/workqueue.h>
 
-#include <asm/fb.h>
+#include <asm/video.h>
 
 struct backlight_device;
 struct device;
-- 
2.44.0


