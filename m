Return-Path: <linux-arch+bounces-1293-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F4C826B24
	for <lists+linux-arch@lfdr.de>; Mon,  8 Jan 2024 10:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01D5BB21038
	for <lists+linux-arch@lfdr.de>; Mon,  8 Jan 2024 09:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB52912E44;
	Mon,  8 Jan 2024 09:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zqHOACDY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RbiD7G63";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zqHOACDY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RbiD7G63"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129BE12B93;
	Mon,  8 Jan 2024 09:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 238DF21D7B;
	Mon,  8 Jan 2024 09:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704707946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=G5qj6FS2SV+JN9E4He4C/nYHFG2WviTmSD1YuZrsv04=;
	b=zqHOACDYHBXzNWTIcsrywOb7CrAwugblOhk94KFM7NKVXx/eORiz8iL9bY3xyPWc3Qr0WI
	doxym5oCv1FMs1mi45w8CGRzuYm7PtizcV8UhYz7JpaGFjLveHgVQoiR0jZdCza/aaD7iH
	Nma9oHNL3ecg8GveKpIdfEICMb8/uR4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704707946;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=G5qj6FS2SV+JN9E4He4C/nYHFG2WviTmSD1YuZrsv04=;
	b=RbiD7G63fUIzTKXRZw0Dev7eEs/COM4hOd1pde4AyEywedpkXL6pQqvgtdcLkdn5iIHnpu
	C19656rjWkG6o2Bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704707946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=G5qj6FS2SV+JN9E4He4C/nYHFG2WviTmSD1YuZrsv04=;
	b=zqHOACDYHBXzNWTIcsrywOb7CrAwugblOhk94KFM7NKVXx/eORiz8iL9bY3xyPWc3Qr0WI
	doxym5oCv1FMs1mi45w8CGRzuYm7PtizcV8UhYz7JpaGFjLveHgVQoiR0jZdCza/aaD7iH
	Nma9oHNL3ecg8GveKpIdfEICMb8/uR4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704707946;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=G5qj6FS2SV+JN9E4He4C/nYHFG2WviTmSD1YuZrsv04=;
	b=RbiD7G63fUIzTKXRZw0Dev7eEs/COM4hOd1pde4AyEywedpkXL6pQqvgtdcLkdn5iIHnpu
	C19656rjWkG6o2Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9CAF51392C;
	Mon,  8 Jan 2024 09:59:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sacMJWnHm2XFMwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 08 Jan 2024 09:59:05 +0000
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
Subject: [PATCH v4 0/4] arch/x86: Remove unnecessary dependencies on bootparam.h
Date: Mon,  8 Jan 2024 10:57:26 +0100
Message-ID: <20240108095903.8427-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: 2.20
X-Spam-Level: **
X-Spam-Flag: NO
X-Spamd-Result: default: False [2.20 / 50.00];
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
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[22];
	 MID_CONTAINS_FROM(1.00)[];
	 FREEMAIL_TO(0.00)[kernel.org,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,google.com,arndb.de,linux.ibm.com,gmail.com,paul-moore.com,namei.org,hallyn.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]

Reduce built time in some cases by removing unnecessary include statements
for <asm/bootparam.h>. Reorganize some header files accordingly.

While working on the kernel's boot-up graphics, I noticed that touching
include/linux/screen_info.h triggers a complete rebuild of the kernel
on x86. It turns out that the architecture's PCI and EFI headers include
<asm/bootparam.h>, which depends on <linux/screen_info.h>. But none of
the drivers have any business with boot parameters or the screen_info
state.

The patchset moves code from bootparam.h and efi.h into separate header
files and removes obsolete include statements on x86. I did

  make allmodconfig
  make -j28
  touch include/linux/screen_info.h
  time make -j28

to measure the time it takes to rebuild. Results without the patchset
are around 20 minutes.

  real    20m46,705s
  user    354m29,166s
  sys     28m27,359s

And with the patchset applied it goes down to less than one minute.

  real    0m56,643s
  user    4m0,661s
  sys     0m32,956s

The test system is an Intel i5-13500.

v4:
	* fix fwd declaration in compressed/misc.h (Ard)
v3:
	* keep setup_header in bootparam.h (Ard)
	* implement arch_ima_efi_boot_mode() in source file (Ard)
v2:
	* only keep struct boot_params in bootparam.h (Ard)
	* simplify arch_ima_efi_boot_mode define (Ard)
	* updated cover letter

Thomas Zimmermann (4):
  arch/x86: Move UAPI setup structures into setup_data.h
  arch/x86: Move internal setup_data structures into setup_data.h
  arch/x86: Implement arch_ima_efi_boot_mode() in source file
  arch/x86: Do not include <asm/bootparam.h> in several files

 arch/x86/boot/compressed/acpi.c        |  2 +
 arch/x86/boot/compressed/cmdline.c     |  2 +
 arch/x86/boot/compressed/efi.c         |  2 +
 arch/x86/boot/compressed/efi.h         |  9 ---
 arch/x86/boot/compressed/misc.h        |  3 +-
 arch/x86/boot/compressed/pgtable_64.c  |  1 +
 arch/x86/boot/compressed/sev.c         |  1 +
 arch/x86/include/asm/efi.h             | 14 +----
 arch/x86/include/asm/kexec.h           |  1 -
 arch/x86/include/asm/mem_encrypt.h     |  2 +-
 arch/x86/include/asm/pci.h             | 13 ----
 arch/x86/include/asm/setup_data.h      | 32 ++++++++++
 arch/x86/include/asm/sev.h             |  3 +-
 arch/x86/include/asm/x86_init.h        |  2 -
 arch/x86/include/uapi/asm/bootparam.h  | 72 +---------------------
 arch/x86/include/uapi/asm/setup_data.h | 83 ++++++++++++++++++++++++++
 arch/x86/kernel/crash.c                |  1 +
 arch/x86/kernel/sev-shared.c           |  2 +
 arch/x86/platform/efi/efi.c            |  5 ++
 arch/x86/platform/pvh/enlighten.c      |  1 +
 arch/x86/xen/enlighten_pvh.c           |  1 +
 arch/x86/xen/vga.c                     |  1 -
 22 files changed, 142 insertions(+), 111 deletions(-)
 create mode 100644 arch/x86/include/asm/setup_data.h
 create mode 100644 arch/x86/include/uapi/asm/setup_data.h

-- 
2.43.0


