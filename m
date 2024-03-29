Return-Path: <linux-arch+bounces-3339-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF92892554
	for <lists+linux-arch@lfdr.de>; Fri, 29 Mar 2024 21:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A8621F23A89
	for <lists+linux-arch@lfdr.de>; Fri, 29 Mar 2024 20:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12756A014;
	Fri, 29 Mar 2024 20:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QY1r+7rZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RJiftMBu"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EF61755B;
	Fri, 29 Mar 2024 20:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711744502; cv=none; b=XAS0zjTmWyP18iLsFtWshgfMuITmPUPTR/9nB1ln/sb3t6MjQkCqmJSf1ZKO5G8+MEq5zGVPR0KQoc0nDMkNJPntWjVRmiVI9bvneDhWDYYR/k+ny+oXLQGJ6lOImGEgJMWgljHZTloVavz1hIwCZniYR+LSY+p6WG8XDKuw/+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711744502; c=relaxed/simple;
	bh=ckMqFXi6kTsnOzb8osXAnAv4sHJYNyhIzPOzcZ99Dic=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VCqowHOpMD1Lrb63QvbHfwDu21haisFYfjDkJaVgSTEy1VOMFXKurT9HDLydY0aSbvqqdAeg9xBoPEgxNwIYmrzNO0wMz/Do7RHvFAgEDcbzFYKTRv0D2KXOs1ErHwfgh4OTI8TZoVWZF8YhvcXb/Dx+bOj4vXwtj+Q1/Nj0DRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QY1r+7rZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RJiftMBu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 05A20347A8;
	Fri, 29 Mar 2024 20:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711744498; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=smB51pG299mQ+sn5M49FhJbogDK6m3Fu/4A/11xq4sY=;
	b=QY1r+7rZLp0OmxaZbOCAlEbX33erpNB/FSvGnP0OAXxFl9AD6xL1e8/zuT9t/6afGe1A/h
	EOSxhk4UmNVeO6UPeem5fq96DouJ5AAgB6W6T5O7jifVpgESTYbdo+edHqNrTirp8k6K8K
	M8G687la3ZBMSflDxzFTGY+d+vyVs90=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711744498;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=smB51pG299mQ+sn5M49FhJbogDK6m3Fu/4A/11xq4sY=;
	b=RJiftMBuEATBRYkGcBqrLySXzGby1sR+TC3iYmtCEDUHkAqAN2yFD05Gh/NJhVEFYOWHm/
	x19G+fDjzW4if/CQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 5C5BD13A7E;
	Fri, 29 Mar 2024 20:34:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id XkJhE/ElB2YTPgAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Fri, 29 Mar 2024 20:34:57 +0000
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
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 0/3] arch: Remove fbdev dependency from video helpers
Date: Fri, 29 Mar 2024 21:32:09 +0100
Message-ID: <20240329203450.7824-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 05A20347A8
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.19)[-0.967];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[arndb.de,ravnborg.org,redhat.com,gmx.de,linux.dev];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:rdns,imap2.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Score: -1.80
X-Spam-Level: 
X-Spam-Flag: NO

Make architecture helpers for display functionality depend on general
video functionality instead of fbdev. This avoids the dependency on
fbdev and makes the functionality available for non-fbdev code.

Patch 1 replaces the variety of Kconfig options that control the
Makefiles with CONFIG_VIDEO. More fine-grained control of the build
can then be done within each video/ directory; see parisc for an
example.

Patch 2 replaces fb_is_primary_device() with video_is_primary_device(),
which has no dependencies on fbdev. The implementation remains identical
on all affected platforms. There's one minor change in fbcon, which is
the only caller of fb_is_primary_device().

Patch 3 renames the source and header files from fbdev to video.

v3:
- arc, arm, arm64, sh, um: generate asm/video.h (Sam, Helge, Arnd)
- fix typos (Sam)
v2:
- improve cover letter
- rebase onto v6.9-rc1

Thomas Zimmermann (3):
  arch: Select fbdev helpers with CONFIG_VIDEO
  arch: Remove struct fb_info from video helpers
  arch: Rename fbdev header and source files

 arch/arc/include/asm/fb.h                    |  8 ------
 arch/arm/include/asm/fb.h                    |  6 -----
 arch/arm64/include/asm/fb.h                  | 10 --------
 arch/loongarch/include/asm/{fb.h => video.h} |  8 +++---
 arch/m68k/include/asm/{fb.h => video.h}      |  8 +++---
 arch/mips/include/asm/{fb.h => video.h}      | 12 ++++-----
 arch/parisc/Makefile                         |  2 +-
 arch/parisc/include/asm/fb.h                 | 14 -----------
 arch/parisc/include/asm/video.h              | 16 ++++++++++++
 arch/parisc/video/Makefile                   |  2 +-
 arch/parisc/video/{fbdev.c => video-sti.c}   |  9 ++++---
 arch/powerpc/include/asm/{fb.h => video.h}   |  8 +++---
 arch/powerpc/kernel/pci-common.c             |  2 +-
 arch/sh/include/asm/fb.h                     |  7 ------
 arch/sparc/Makefile                          |  4 +--
 arch/sparc/include/asm/{fb.h => video.h}     | 15 +++++------
 arch/sparc/video/Makefile                    |  2 +-
 arch/sparc/video/fbdev.c                     | 26 --------------------
 arch/sparc/video/video.c                     | 25 +++++++++++++++++++
 arch/um/include/asm/Kbuild                   |  2 +-
 arch/x86/Makefile                            |  2 +-
 arch/x86/include/asm/fb.h                    | 19 --------------
 arch/x86/include/asm/video.h                 | 21 ++++++++++++++++
 arch/x86/video/Makefile                      |  3 ++-
 arch/x86/video/{fbdev.c => video.c}          | 21 +++++++---------
 drivers/video/fbdev/core/fbcon.c             |  2 +-
 include/asm-generic/Kbuild                   |  2 +-
 include/asm-generic/{fb.h => video.h}        | 17 +++++++------
 include/linux/fb.h                           |  2 +-
 29 files changed, 124 insertions(+), 151 deletions(-)
 delete mode 100644 arch/arc/include/asm/fb.h
 delete mode 100644 arch/arm/include/asm/fb.h
 delete mode 100644 arch/arm64/include/asm/fb.h
 rename arch/loongarch/include/asm/{fb.h => video.h} (86%)
 rename arch/m68k/include/asm/{fb.h => video.h} (86%)
 rename arch/mips/include/asm/{fb.h => video.h} (76%)
 delete mode 100644 arch/parisc/include/asm/fb.h
 create mode 100644 arch/parisc/include/asm/video.h
 rename arch/parisc/video/{fbdev.c => video-sti.c} (78%)
 rename arch/powerpc/include/asm/{fb.h => video.h} (76%)
 delete mode 100644 arch/sh/include/asm/fb.h
 rename arch/sparc/include/asm/{fb.h => video.h} (75%)
 delete mode 100644 arch/sparc/video/fbdev.c
 create mode 100644 arch/sparc/video/video.c
 delete mode 100644 arch/x86/include/asm/fb.h
 create mode 100644 arch/x86/include/asm/video.h
 rename arch/x86/video/{fbdev.c => video.c} (66%)
 rename include/asm-generic/{fb.h => video.h} (89%)

-- 
2.44.0


