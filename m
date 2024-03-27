Return-Path: <linux-arch+bounces-3244-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E038E88F051
	for <lists+linux-arch@lfdr.de>; Wed, 27 Mar 2024 21:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FAA91C2E8CB
	for <lists+linux-arch@lfdr.de>; Wed, 27 Mar 2024 20:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E7E1534F5;
	Wed, 27 Mar 2024 20:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="J5DnRALO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qKAtjPYe";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="J5DnRALO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qKAtjPYe"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB2254FAC;
	Wed, 27 Mar 2024 20:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711572300; cv=none; b=W6Nibvlhf26XX2T4hP6OyLWEC1mRfyEKbP/4kZrm7PHmlKIqINFdPmwTFU2odb3F0gDDQ2pyiT7mV6wN7zAFAewbPS0CzDbv6bEvfaUhComOiF27PBvmw7GTlW5YNvU1R/8YSK01lco2Tl5szMPWMPnz8uM9vOnT/03DtQ6Oi74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711572300; c=relaxed/simple;
	bh=OrF18IDFwI6flGgEpimPzRhp+XTrybACCnJ/SNmMJ9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pbNgBg+VLg/iLsBwxyKMfwl87q7q5PwmNzLRhkCVawz+kfu82TYonnG8XiFSTz8+4qzh3HaW8s8UvawXkUmS3PYAwprnph9FBGQ2fHsW/vdfsFbqfFk05dbSv2YstAqLlMgDFFyl+g6/9Q90NX5ZpoIZUmjXQczi/LZ3Bwwon2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=J5DnRALO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qKAtjPYe; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=J5DnRALO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qKAtjPYe; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 18AAC229DB;
	Wed, 27 Mar 2024 20:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711572297; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gvNYpjPCMP3bY8u5dBMnCwR0tl6uUjrhgXbs0rKvAd0=;
	b=J5DnRALO8oxp1paKt25KLzQ/CWLNr0nEdbAXmUacLVmFY6BetSYDsDGtJbDgzF6nh3pI11
	bir5J0VQ5Thx0TUrKUf0lp3V6ZLwiYVhjiiZNEiGKxv5sW0Kt/jDdaBuWNiuoOGZhO7KdK
	5JSNjhEuVdoOHCc4X9YHLcIA/wtS1FI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711572297;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gvNYpjPCMP3bY8u5dBMnCwR0tl6uUjrhgXbs0rKvAd0=;
	b=qKAtjPYe0YZLjXfM54u9I6bl6MmSDiPCLddSbLHuhcjvV51ZGW/oSYV4yrQi3yrAwbUSek
	buJJaf1BirRZUxAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711572297; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gvNYpjPCMP3bY8u5dBMnCwR0tl6uUjrhgXbs0rKvAd0=;
	b=J5DnRALO8oxp1paKt25KLzQ/CWLNr0nEdbAXmUacLVmFY6BetSYDsDGtJbDgzF6nh3pI11
	bir5J0VQ5Thx0TUrKUf0lp3V6ZLwiYVhjiiZNEiGKxv5sW0Kt/jDdaBuWNiuoOGZhO7KdK
	5JSNjhEuVdoOHCc4X9YHLcIA/wtS1FI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711572297;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gvNYpjPCMP3bY8u5dBMnCwR0tl6uUjrhgXbs0rKvAd0=;
	b=qKAtjPYe0YZLjXfM54u9I6bl6MmSDiPCLddSbLHuhcjvV51ZGW/oSYV4yrQi3yrAwbUSek
	buJJaf1BirRZUxAQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 898E313AB3;
	Wed, 27 Mar 2024 20:44:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id E2GmH0iFBGZ2FQAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Wed, 27 Mar 2024 20:44:56 +0000
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
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 0/3] arch: Remove fbdev dependency from video helpers
Date: Wed, 27 Mar 2024 21:41:28 +0100
Message-ID: <20240327204450.14914-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=J5DnRALO;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qKAtjPYe
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.51 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_TO(0.00)[arndb.de,redhat.com,gmx.de,linux.dev];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 FREEMAIL_ENVRCPT(0.00)[gmx.de];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[18];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -1.51
X-Rspamd-Queue-Id: 18AAC229DB
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

Patch 3 renames the source and files from fbdev to video.

v2:
- improve cover letter
- rebase onto v6.9-rc1

Thomas Zimmermann (3):
  arch: Select fbdev helpers with CONFIG_VIDEO
  arch: Remove struct fb_info from video helpers
  arch: Rename fbdev header and source files

 arch/arc/include/asm/fb.h                    |  8 ------
 arch/arc/include/asm/video.h                 |  8 ++++++
 arch/arm/include/asm/fb.h                    |  6 -----
 arch/arm/include/asm/video.h                 |  6 +++++
 arch/arm64/include/asm/fb.h                  | 10 --------
 arch/arm64/include/asm/video.h               | 10 ++++++++
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
 arch/sh/include/asm/video.h                  |  7 ++++++
 arch/sparc/Makefile                          |  4 +--
 arch/sparc/include/asm/{fb.h => video.h}     | 15 +++++------
 arch/sparc/video/Makefile                    |  2 +-
 arch/sparc/video/fbdev.c                     | 26 --------------------
 arch/sparc/video/video.c                     | 25 +++++++++++++++++++
 arch/x86/Makefile                            |  2 +-
 arch/x86/include/asm/fb.h                    | 19 --------------
 arch/x86/include/asm/video.h                 | 21 ++++++++++++++++
 arch/x86/video/Makefile                      |  3 ++-
 arch/x86/video/{fbdev.c => video.c}          | 21 +++++++---------
 drivers/video/fbdev/core/fbcon.c             |  2 +-
 include/asm-generic/Kbuild                   |  2 +-
 include/asm-generic/{fb.h => video.h}        | 17 +++++++------
 include/linux/fb.h                           |  2 +-
 32 files changed, 154 insertions(+), 150 deletions(-)
 delete mode 100644 arch/arc/include/asm/fb.h
 create mode 100644 arch/arc/include/asm/video.h
 delete mode 100644 arch/arm/include/asm/fb.h
 create mode 100644 arch/arm/include/asm/video.h
 delete mode 100644 arch/arm64/include/asm/fb.h
 create mode 100644 arch/arm64/include/asm/video.h
 rename arch/loongarch/include/asm/{fb.h => video.h} (86%)
 rename arch/m68k/include/asm/{fb.h => video.h} (86%)
 rename arch/mips/include/asm/{fb.h => video.h} (76%)
 delete mode 100644 arch/parisc/include/asm/fb.h
 create mode 100644 arch/parisc/include/asm/video.h
 rename arch/parisc/video/{fbdev.c => video-sti.c} (78%)
 rename arch/powerpc/include/asm/{fb.h => video.h} (76%)
 delete mode 100644 arch/sh/include/asm/fb.h
 create mode 100644 arch/sh/include/asm/video.h
 rename arch/sparc/include/asm/{fb.h => video.h} (75%)
 delete mode 100644 arch/sparc/video/fbdev.c
 create mode 100644 arch/sparc/video/video.c
 delete mode 100644 arch/x86/include/asm/fb.h
 create mode 100644 arch/x86/include/asm/video.h
 rename arch/x86/video/{fbdev.c => video.c} (66%)
 rename include/asm-generic/{fb.h => video.h} (89%)

-- 
2.44.0


