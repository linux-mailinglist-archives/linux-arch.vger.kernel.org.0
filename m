Return-Path: <linux-arch+bounces-3246-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8C388F065
	for <lists+linux-arch@lfdr.de>; Wed, 27 Mar 2024 21:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C863BB2680B
	for <lists+linux-arch@lfdr.de>; Wed, 27 Mar 2024 20:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006E8153570;
	Wed, 27 Mar 2024 20:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UQx1OWwa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="p4BZexRC";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fQS5APUa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QyrwrTQo"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8A715350C;
	Wed, 27 Mar 2024 20:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711572303; cv=none; b=hXyxrMQ/P32xGniY596qE+chwwuatufNiIQnrbopkbt9gh1gr8wHa63P/lFLfh+3xH9MOrsUqVoTHElD+DpU2UZsiagDCejEEVleTPjAXk0TMs9Zcw9wMk8JM87a+KQ4Xs67v+rUlTAcFv1rZS2/4s5HZ12QIVDwr+1op1i/nJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711572303; c=relaxed/simple;
	bh=fyYkbHT6MNG2JHz3f/RPRalfESGEEFh+s4Q1k9kiftw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JltKrleKZBpbA1KGCmy8vTJ2Qy7s3tXlByz3j58C5rxa8UsHeJy7x97wGVvwhGq1aj1TV2iJE7MMHoY2RwnIFZG8UMZS2xQwTrjRIv0qrb8h9x7VzYKQkWu4Z64KgQa81A3d/60G8Xhde6EDnTG2YaEtPV4j5zIN5sGCM4kVxuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UQx1OWwa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=p4BZexRC; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fQS5APUa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QyrwrTQo; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CBB621FBA5;
	Wed, 27 Mar 2024 20:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711572299; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0z2Dh//uKAfjU5KhbIcIWrL4XJtx4qBTJAMQSF41C2w=;
	b=UQx1OWwaMJXL2KlSVSTTpKwbi3N7zHSDdCXeI2LFMMIiMHp3xZ+n7kcMbDYFOAokldfvDi
	abE35qtE+d2yZBw4w3e0/6rF675Xb/x7ojqL/Vt/WrKWNwV3L1KCNRUWOiIQ7Fte5S6Ih2
	/88zYOJTrp9DTDbLyxzLinr90LqI0Ew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711572299;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0z2Dh//uKAfjU5KhbIcIWrL4XJtx4qBTJAMQSF41C2w=;
	b=p4BZexRCSMqPbKyYUyeH3zVUYjFtVMbGcOuFoWUxbogbF+9W+LoHSWvhB/WO9727+HjG2V
	X1V9mkn2KzC71GBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711572297; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0z2Dh//uKAfjU5KhbIcIWrL4XJtx4qBTJAMQSF41C2w=;
	b=fQS5APUagKJnE73lYSqu7UvpbW2n1AY9L5G+pwMo8QJ4oei4VPTNOk5KhhVOB5PjkHYZTd
	73pDOwDtWl20BoPuSUzKb/PJ8NaKb2t0i36FXgRWnDEcJdlExrmyJpzr1/4KRZVI0QRocv
	CQpQGuPg5ifOKPedZ7WU7rakTH6X9ME=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711572297;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0z2Dh//uKAfjU5KhbIcIWrL4XJtx4qBTJAMQSF41C2w=;
	b=QyrwrTQo9xBmYrU+ysyvddvS2oBfLJL8jF2sEuJQlTe7Dupm60OMbKZY/jXRrLQeCIB3oX
	dR7oWIf3iK9zPwBg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 1B8A013AC5;
	Wed, 27 Mar 2024 20:44:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id qH5vBUmFBGZ2FQAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Wed, 27 Mar 2024 20:44:57 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: arnd@arndb.de,
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
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2 1/3] arch: Select fbdev helpers with CONFIG_VIDEO
Date: Wed, 27 Mar 2024 21:41:29 +0100
Message-ID: <20240327204450.14914-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240327204450.14914-1-tzimmermann@suse.de>
References: <20240327204450.14914-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: 0.70
X-Spamd-Result: default: False [0.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmx.de];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 R_RATELIMIT(0.00)[to_ip_from(RLthqzz6q5hnubohss7ffybi86)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 RCPT_COUNT_TWELVE(0.00)[27];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,linutronix.de:email,zytor.com:email,davemloft.net:email,gaisler.com:email,gmx.de:email,hansenpartnership.com:email,alien8.de:email,intel.com:email];
	 FREEMAIL_TO(0.00)[arndb.de,redhat.com,gmx.de,linux.dev];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Flag: NO

Various Kconfig options selected the per-architecture helpers for
fbdev. But none of the contained code depends on fbdev. Standardize
on CONFIG_VIDEO, which will allow to add more general helpers for
video functionality.

CONFIG_VIDEO protects each architecture's video/ directory. This
allows for the use of more fine-grained control for each directory's
files, such as the use of CONFIG_STI_CORE on parisc.

v2:
- sparc: rebased onto Makefile changes

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/parisc/Makefile      | 2 +-
 arch/sparc/Makefile       | 4 ++--
 arch/sparc/video/Makefile | 2 +-
 arch/x86/Makefile         | 2 +-
 arch/x86/video/Makefile   | 3 ++-
 5 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/parisc/Makefile b/arch/parisc/Makefile
index 316f84f1d15c8..21b8166a68839 100644
--- a/arch/parisc/Makefile
+++ b/arch/parisc/Makefile
@@ -119,7 +119,7 @@ export LIBGCC
 
 libs-y	+= arch/parisc/lib/ $(LIBGCC)
 
-drivers-y += arch/parisc/video/
+drivers-$(CONFIG_VIDEO) += arch/parisc/video/
 
 boot	:= arch/parisc/boot
 
diff --git a/arch/sparc/Makefile b/arch/sparc/Makefile
index 2a03daa68f285..757451c3ea1df 100644
--- a/arch/sparc/Makefile
+++ b/arch/sparc/Makefile
@@ -59,8 +59,8 @@ endif
 libs-y                 += arch/sparc/prom/
 libs-y                 += arch/sparc/lib/
 
-drivers-$(CONFIG_PM) += arch/sparc/power/
-drivers-$(CONFIG_FB_CORE) += arch/sparc/video/
+drivers-$(CONFIG_PM)    += arch/sparc/power/
+drivers-$(CONFIG_VIDEO) += arch/sparc/video/
 
 boot := arch/sparc/boot
 
diff --git a/arch/sparc/video/Makefile b/arch/sparc/video/Makefile
index d4d83f1702c61..9dd82880a027a 100644
--- a/arch/sparc/video/Makefile
+++ b/arch/sparc/video/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-obj-$(CONFIG_FB_CORE) += fbdev.o
+obj-y	+= fbdev.o
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 15a5f4f2ff0aa..c0ea612c62ebe 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -265,7 +265,7 @@ drivers-$(CONFIG_PCI)            += arch/x86/pci/
 # suspend and hibernation support
 drivers-$(CONFIG_PM) += arch/x86/power/
 
-drivers-$(CONFIG_FB_CORE) += arch/x86/video/
+drivers-$(CONFIG_VIDEO) += arch/x86/video/
 
 ####
 # boot loader support. Several targets are kept for legacy purposes
diff --git a/arch/x86/video/Makefile b/arch/x86/video/Makefile
index 5ebe48752ffc4..9dd82880a027a 100644
--- a/arch/x86/video/Makefile
+++ b/arch/x86/video/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_FB_CORE)		+= fbdev.o
+
+obj-y	+= fbdev.o
-- 
2.44.0


