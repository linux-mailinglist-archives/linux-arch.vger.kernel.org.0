Return-Path: <linux-arch+bounces-1077-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 723FA8147F7
	for <lists+linux-arch@lfdr.de>; Fri, 15 Dec 2023 13:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 966451C2347A
	for <lists+linux-arch@lfdr.de>; Fri, 15 Dec 2023 12:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D150D2C861;
	Fri, 15 Dec 2023 12:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cjUlkx06";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7c3nAJds";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="shzlDVD2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UDml0Zja"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0275C28E0D;
	Fri, 15 Dec 2023 12:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E26BA22018;
	Fri, 15 Dec 2023 12:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702643177; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=KqD1KC9XZSP4L8dzgJw0+F9VPRBQ4UFcAI+KfVQOw7c=;
	b=cjUlkx06BUesajNAo6xtnYGPY1VVmLWsbPrC1XCNDyqCzrBzBIJrYSpfOgqkRMKU/7Lxns
	Ms9svf17QGrflk7yI1NmG8hHn44jlonIsbnjJ6HC5eoha7cgaJXxJSH1Ge4HCsS6arVY7U
	/PwTQFvK8m5ql7a38EfXdFE3o9dUJnI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702643177;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=KqD1KC9XZSP4L8dzgJw0+F9VPRBQ4UFcAI+KfVQOw7c=;
	b=7c3nAJdsbXcqaVIyseZ/vbfDHIeUz067v+1KAD89dNHvSk9ri2UBhEYwoM+nj3Cy3GFbHt
	/rVKJLqJJIyBPwBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702643176; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=KqD1KC9XZSP4L8dzgJw0+F9VPRBQ4UFcAI+KfVQOw7c=;
	b=shzlDVD2svSNH59bqqPkWnAodpJaIXOYeYW5yD+9qfdesY9Q8vVomqQsUnpUOlxb/7BrfS
	Qq5deKnxrHbjgZ7lIm9TGH/Z3YxzVbsEN/J6z/leqIoHYDknFYS8CWxdfCK1L1cw3CXdun
	QRBLhzlGPHfYPh3DszRGOKRfTVyfFF0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702643176;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=KqD1KC9XZSP4L8dzgJw0+F9VPRBQ4UFcAI+KfVQOw7c=;
	b=UDml0ZjaLtv19cqheIHTnwsZ9nK+ZMRfHJo/36H5DWvjGgUhffmEyt1i8AmMlobkY749VH
	E+xIh4TIbRKsUEBw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 6195113A08;
	Fri, 15 Dec 2023 12:26:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id FqyeFuhFfGVIRwAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Fri, 15 Dec 2023 12:26:16 +0000
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
Subject: [PATCH v2 0/3] arch/x86: Remove unnecessary dependencies on bootparam.h
Date: Fri, 15 Dec 2023 13:18:11 +0100
Message-ID: <20231215122614.5481-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: *******
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=shzlDVD2;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=UDml0Zja
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.00 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 R_RATELIMIT(0.00)[to_ip_from(RL8bnzzinbm939qqjaserdumcx)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.19)[-0.962];
	 FREEMAIL_TO(0.00)[kernel.org,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,google.com,arndb.de,linux.ibm.com,gmail.com,paul-moore.com,namei.org,hallyn.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[22];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Spam-Score: -0.00
X-Rspamd-Queue-Id: E26BA22018
X-Spam-Flag: NO

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
  touch include/linus/screen_info.h
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

v2:
	* only keep struct boot_params in bootparam.h (Ard)
	* simplify arch_ima_efi_boot_mode define (Ard)
	* updated cover letter

Thomas Zimmermann (3):
  arch/x86: Move UAPI setup structures into setup_data.h
  arch/x86: Add <asm/ima-efi.h> for arch_ima_efi_boot_mode
  arch/x86: Do not include <asm/bootparam.h> in several header files

 arch/x86/boot/compressed/acpi.c        |   2 +
 arch/x86/boot/compressed/cmdline.c     |   2 +
 arch/x86/boot/compressed/efi.c         |   2 +
 arch/x86/boot/compressed/misc.h        |   3 +-
 arch/x86/boot/compressed/pgtable_64.c  |   1 +
 arch/x86/boot/compressed/sev.c         |   1 +
 arch/x86/include/asm/e820/types.h      |   2 +-
 arch/x86/include/asm/efi.h             |   3 -
 arch/x86/include/asm/ima-efi.h         |  11 ++
 arch/x86/include/asm/kexec.h           |   1 -
 arch/x86/include/asm/mem_encrypt.h     |   2 +-
 arch/x86/include/asm/pci.h             |   2 +-
 arch/x86/include/asm/sev.h             |   3 +-
 arch/x86/include/asm/x86_init.h        |   2 -
 arch/x86/include/uapi/asm/bootparam.h  | 218 +----------------------
 arch/x86/include/uapi/asm/setup_data.h | 229 +++++++++++++++++++++++++
 arch/x86/kernel/crash.c                |   1 +
 arch/x86/kernel/sev-shared.c           |   2 +
 arch/x86/platform/pvh/enlighten.c      |   1 +
 arch/x86/xen/enlighten_pvh.c           |   1 +
 arch/x86/xen/vga.c                     |   1 -
 include/asm-generic/Kbuild             |   1 +
 include/asm-generic/ima-efi.h          |  16 ++
 security/integrity/ima/ima_efi.c       |   5 +-
 24 files changed, 279 insertions(+), 233 deletions(-)
 create mode 100644 arch/x86/include/asm/ima-efi.h
 create mode 100644 arch/x86/include/uapi/asm/setup_data.h
 create mode 100644 include/asm-generic/ima-efi.h


base-commit: 961ef418705ac5808345e883acd91f8ce167e00b
prerequisite-patch-id: 0aa359f6144c4015c140c8a6750be19099c676fb
prerequisite-patch-id: c67e5d886a47b7d0266d81100837557fda34cb24
prerequisite-patch-id: cbc453ee02fae02af22fbfdce56ab732c7a88c36
prerequisite-patch-id: e7a5405fb48608e0c8e3b41bf983fefa2c8bd1f3
-- 
2.43.0


