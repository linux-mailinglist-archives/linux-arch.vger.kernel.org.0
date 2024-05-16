Return-Path: <linux-arch+bounces-4448-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5B88C76B4
	for <lists+linux-arch@lfdr.de>; Thu, 16 May 2024 14:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 740582821AB
	for <lists+linux-arch@lfdr.de>; Thu, 16 May 2024 12:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A862145FE7;
	Thu, 16 May 2024 12:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lfFd290Q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7w/3v7pY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lfFd290Q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7w/3v7pY"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69880335B5;
	Thu, 16 May 2024 12:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715863405; cv=none; b=ryZ7FDXhuK26B2BwMtdWNwOz0itssDduxnF62bfLGLwU2N3Z2Ywlyc4/mvq5f7jnwpn+1t9EBaw3GULYH4O9g3jbIXX8lCXJx/c+zJqOocHWcxshtnNBh45Cp9z71dgXypClNCnHwLBI6TqQ4j7Pj9tL7FvZhVFzXvcRn8ovQCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715863405; c=relaxed/simple;
	bh=1HyW0gCvi46vYJIx6HzhgwPyzVZRVNb82UZXwWS3WQw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eM3LXT6ysV52T+msrm3BCth1CNyY+wmhGVYcBytRWyDiTqWPG9YYaMMSXvwanzDU2CYtjuNeMa586GbyXVht1EyIrPvnxpILUHTrc5tgVchPvcawjUpeAuTEcPalUX9U9F0PIauDxaQW63jFMQ5Al8P/fXwr+nLUil54CS7ATfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lfFd290Q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7w/3v7pY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lfFd290Q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7w/3v7pY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4E4FC5C399;
	Thu, 16 May 2024 12:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715863401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ekZcd8pJFpXVNDlEU83NveCWqM2djxgv35HO1YJlkyA=;
	b=lfFd290QtjS+lowshx7oGM3UbFZcSJIap0DHzkn1mqsE9pCC9lTxenQlCUgZj24E1JzKPV
	8j7JH6jMRDqdW80/1yFh9p45d/ufgvLsFlR8ZyeOngXPmxY/lzEOvc1ARJ5XnqWBj8W1/Q
	B8ia9Kd7HjM+SQSFejnPj2xumgyNCuI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715863401;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ekZcd8pJFpXVNDlEU83NveCWqM2djxgv35HO1YJlkyA=;
	b=7w/3v7pYZrCZGViKO0nJgFV5VuX7WseN6i/uv1Lay2Tdd+s+NVBIMn6Di7L0JQnARtKjIn
	KvXe69XxMZnL0gBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lfFd290Q;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="7w/3v7pY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1715863401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ekZcd8pJFpXVNDlEU83NveCWqM2djxgv35HO1YJlkyA=;
	b=lfFd290QtjS+lowshx7oGM3UbFZcSJIap0DHzkn1mqsE9pCC9lTxenQlCUgZj24E1JzKPV
	8j7JH6jMRDqdW80/1yFh9p45d/ufgvLsFlR8ZyeOngXPmxY/lzEOvc1ARJ5XnqWBj8W1/Q
	B8ia9Kd7HjM+SQSFejnPj2xumgyNCuI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1715863401;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ekZcd8pJFpXVNDlEU83NveCWqM2djxgv35HO1YJlkyA=;
	b=7w/3v7pYZrCZGViKO0nJgFV5VuX7WseN6i/uv1Lay2Tdd+s+NVBIMn6Di7L0JQnARtKjIn
	KvXe69XxMZnL0gBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EE1FF137C3;
	Thu, 16 May 2024 12:43:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qYnLOGj/RWavCwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 16 May 2024 12:43:20 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: rafael@kernel.org,
	lenb@kernel.org,
	arnd@arndb.de,
	chaitanya.kumar.borah@intel.com,
	suresh.kumar.kurmi@intel.com,
	jani.saarinen@intel.com
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	linux-arch@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH] ACPI: video: Fix name collision with architecture's video.o
Date: Thu, 16 May 2024 14:43:15 +0200
Message-ID: <20240516124317.710-1-tzimmermann@suse.de>
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
X-Rspamd-Queue-Id: 4E4FC5C399
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,intel.com:email]

Commit 2fd001cd3600 ("arch: Rename fbdev header and source files")
renames the video source files under arch/ such that they does not
refer to fbdev any longer. The new files named video.o conflict with
ACPI's video.ko module. Modprobing the ACPI module can then fail with
warnings about missing symbols, as shown below.

  (i915_selftest:1107) igt_kmod-WARNING: i915: Unknown symbol acpi_video_unregister (err -2)
  (i915_selftest:1107) igt_kmod-WARNING: i915: Unknown symbol acpi_video_register_backlight (err -2)
  (i915_selftest:1107) igt_kmod-WARNING: i915: Unknown symbol __acpi_video_get_backlight_type (err -2)
  (i915_selftest:1107) igt_kmod-WARNING: i915: Unknown symbol acpi_video_register (err -2)

Fix this problem by renaming ACPI's video.ko to acpi_video.ko. Also
rename a related source file and clean up the Makefile.

Reported-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Closes: https://lore.kernel.org/intel-gfx/9dcac6e9-a3bf-4ace-bbdc-f697f767f9e0@suse.de/T/#t
Tested-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 2fd001cd3600 ("arch: Rename fbdev header and source files")
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
---
 drivers/acpi/Makefile                            | 5 +++--
 drivers/acpi/{acpi_video.c => acpi_video_core.c} | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)
 rename drivers/acpi/{acpi_video.c => acpi_video_core.c} (99%)

diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 8cc8c0d9c8732..fc9e11f7afbf7 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -84,7 +84,9 @@ obj-$(CONFIG_ACPI_FAN)		+= fan.o
 fan-objs			:= fan_core.o
 fan-objs			+= fan_attr.o
 
-obj-$(CONFIG_ACPI_VIDEO)	+= video.o
+obj-$(CONFIG_ACPI_VIDEO)	+= acpi_video.o
+acpi_video-objs			+= acpi_video_core.o video_detect.o
+
 obj-$(CONFIG_ACPI_TAD)		+= acpi_tad.o
 obj-$(CONFIG_ACPI_PCI_SLOT)	+= pci_slot.o
 obj-$(CONFIG_ACPI_PROCESSOR)	+= processor.o
@@ -124,7 +126,6 @@ obj-$(CONFIG_ACPI_CONFIGFS)	+= acpi_configfs.o
 
 obj-y				+= pmic/
 
-video-objs			+= acpi_video.o video_detect.o
 obj-y				+= dptf/
 
 obj-$(CONFIG_ARM64)		+= arm64/
diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video_core.c
similarity index 99%
rename from drivers/acpi/acpi_video.c
rename to drivers/acpi/acpi_video_core.c
index 1fda303882973..32bf81c5773a4 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video_core.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *  video.c - ACPI Video Driver
+ *  acpi_video_core.c - ACPI Video Driver
  *
  *  Copyright (C) 2004 Luming Yu <luming.yu@intel.com>
  *  Copyright (C) 2004 Bruno Ducrot <ducrot@poupinou.org>
-- 
2.45.0


