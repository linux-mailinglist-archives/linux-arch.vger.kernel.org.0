Return-Path: <linux-arch+bounces-4457-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FA48C8322
	for <lists+linux-arch@lfdr.de>; Fri, 17 May 2024 11:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3434B20B73
	for <lists+linux-arch@lfdr.de>; Fri, 17 May 2024 09:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14031EB37;
	Fri, 17 May 2024 09:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BbghCkdX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jt+OyQXy";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MSoh9Pd4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6EmY1xnz"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8F11CFBC;
	Fri, 17 May 2024 09:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715937369; cv=none; b=Ky+lNV7Fit6tpsCSZZ+IIyUcItC2O4NPHXWw165C4WEpCfymGBSM1Sm+aT/2BJLH4qw2DsVGhTmfKNFNfRJYt88HrkHL2f0/AJ7lYJwKNRk/QNg5+XBuK9uzpbvyHmwu127mw83sWMxOnyBV8/i83K1r59spMnTelc+q02Gjx5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715937369; c=relaxed/simple;
	bh=wY4YgXdaqsAKUexBfgDDerI/9Bx+fOhmVvc6Lpv7OVE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UsGji0P0jS7xaF5PCqyCQSv9vuD/r0tD7JSAHmqxEBulkysSJw8cq6FhuJj6eRuoBrlhV2Q9BRjul3rot/bxbm4igWOWV5UEKSKuAifZfhW4oA5b+QG+uQIJG0tYaKGOFDyhi+MI1g1teLH9Cq2iLf9UvSq5ol1Ue7ZCsw2cgW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BbghCkdX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jt+OyQXy; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MSoh9Pd4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6EmY1xnz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D221C5D1B3;
	Fri, 17 May 2024 09:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715937362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=9wYWAx2PYyOTbB/LCI3hz7bjDkyxOkz1uapIAToUark=;
	b=BbghCkdXksejkuJqJmch5Ijt4sdQZ5TDSe2a19haeMF2gXOdFAXHuIFAVy/ycjGDKXOahM
	3s35YHDhSOBZ0DBIbMJoZwDe1zdv8qmX78wJczE5ydgpmTceUqPruOPYs17PnMEifYtyGx
	Kf3WP8IRkhI9Qg1w1JdkXa4wR3S5njo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715937362;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=9wYWAx2PYyOTbB/LCI3hz7bjDkyxOkz1uapIAToUark=;
	b=jt+OyQXy4hJ1K2TSadbh5/0IARkIyYzVbNsRzT7YZJa0Y75FPbMfmoXTKJXCnAHwr/gG2B
	W7bx/+2Y8JLZKpAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=MSoh9Pd4;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=6EmY1xnz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715937361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=9wYWAx2PYyOTbB/LCI3hz7bjDkyxOkz1uapIAToUark=;
	b=MSoh9Pd4EH3z9qXcQcZ1OGdOiRW1eI7a9BCPHTXAOfjkWkcMJzvy2v535t1mnqA5yaLg6e
	KIcpJzCLRWJuOmJ/gF0nIaQShxltOwTdd0B3ersi5TNR0Tlqj9WyvqXlkG2ubPrJbsH3G/
	znOmxD/guKNiOlbjZztNkImArw9SnKE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715937361;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=9wYWAx2PYyOTbB/LCI3hz7bjDkyxOkz1uapIAToUark=;
	b=6EmY1xnz1/aS9A/f+O8Sf2mvTZcnlnUMR9VLtbJP9DiseQxwfCCDwKxnhj+6NTN3hoLP9f
	n7zleX6+JlE9M5Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 57EBD13991;
	Fri, 17 May 2024 09:16:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0dNMFFEgR2ZkfAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 17 May 2024 09:16:01 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: arnd@arndb.de,
	chaitanya.kumar.borah@intel.com,
	suresh.kumar.kurmi@intel.com,
	jani.saarinen@intel.com,
	davem@davemloft.net,
	andreas@gaisler.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	rafael@kernel.org,
	hdegoede@redhat.com
Cc: linux-arch@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH] arch: Fix name collision with ACPI's video.o
Date: Fri, 17 May 2024 11:14:33 +0200
Message-ID: <20240517091557.25800-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -5.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: D221C5D1B3
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]

Commit 2fd001cd3600 ("arch: Rename fbdev header and source files")
renames the video source files under arch/ such that they do not
refer to fbdev any longer. The new files named video.o conflict with
ACPI's video.ko module. Modprobing the ACPI module can then fail with
warnings about missing symbols, as shown below.

  (i915_selftest:1107) igt_kmod-WARNING: i915: Unknown symbol acpi_video_unregister (err -2)
  (i915_selftest:1107) igt_kmod-WARNING: i915: Unknown symbol acpi_video_register_backlight (err -2)
  (i915_selftest:1107) igt_kmod-WARNING: i915: Unknown symbol __acpi_video_get_backlight_type (err -2)
  (i915_selftest:1107) igt_kmod-WARNING: i915: Unknown symbol acpi_video_register (err -2)

Fix the issue by renaming the architecture's video.o to video-common.o.

Reported-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Closes: https://lore.kernel.org/intel-gfx/9dcac6e9-a3bf-4ace-bbdc-f697f767f9e0@suse.de/T/#t
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 2fd001cd3600 ("arch: Rename fbdev header and source files")
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
---
 arch/sparc/video/Makefile                    | 2 +-
 arch/sparc/video/{video.c => video-common.c} | 0
 arch/x86/video/Makefile                      | 2 +-
 arch/x86/video/{video.c => video-common.c}   | 0
 4 files changed, 2 insertions(+), 2 deletions(-)
 rename arch/sparc/video/{video.c => video-common.c} (100%)
 rename arch/x86/video/{video.c => video-common.c} (100%)

diff --git a/arch/sparc/video/Makefile b/arch/sparc/video/Makefile
index fdf83a408d750..dcfbe7a5912c0 100644
--- a/arch/sparc/video/Makefile
+++ b/arch/sparc/video/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-obj-y	+= video.o
+obj-y	+= video-common.o
diff --git a/arch/sparc/video/video.c b/arch/sparc/video/video-common.c
similarity index 100%
rename from arch/sparc/video/video.c
rename to arch/sparc/video/video-common.c
diff --git a/arch/x86/video/Makefile b/arch/x86/video/Makefile
index fdf83a408d750..dcfbe7a5912c0 100644
--- a/arch/x86/video/Makefile
+++ b/arch/x86/video/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-obj-y	+= video.o
+obj-y	+= video-common.o
diff --git a/arch/x86/video/video.c b/arch/x86/video/video-common.c
similarity index 100%
rename from arch/x86/video/video.c
rename to arch/x86/video/video-common.c
-- 
2.45.0


