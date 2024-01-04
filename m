Return-Path: <linux-arch+bounces-1275-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC13823F06
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jan 2024 10:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0C8F2867FD
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jan 2024 09:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818EA210F4;
	Thu,  4 Jan 2024 09:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UC8ZblSf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UPonx0mO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UC8ZblSf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UPonx0mO"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DA320B0C;
	Thu,  4 Jan 2024 09:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1188921F18;
	Thu,  4 Jan 2024 09:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704362066; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+9cuiaFBoH53rifqhpcKmv1PSCTBZIUqSH8muwBZX6s=;
	b=UC8ZblSffhYGkjArDFBitXD4mquvsvVKatfZnluVMwulrqlQLMPxOyCfTEh4dZBoxx7I/8
	xdEma3fbZdNNtks2rfo3xeLVG2eVhCZzyeQHcENHqHKCgZi0Gll6Nd1bQTLX+M3RhONrb+
	ST6SPvz8EH/FhzyHWgRACh9j+hT+5SA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704362066;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+9cuiaFBoH53rifqhpcKmv1PSCTBZIUqSH8muwBZX6s=;
	b=UPonx0mOF3l3BWkHzNk/1ABR25UNALJPhJkLGUo4euPwkYnxA3kUqwpbMYp98bVKbiN2Um
	AtvWghZWalYo65CA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1704362066; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+9cuiaFBoH53rifqhpcKmv1PSCTBZIUqSH8muwBZX6s=;
	b=UC8ZblSffhYGkjArDFBitXD4mquvsvVKatfZnluVMwulrqlQLMPxOyCfTEh4dZBoxx7I/8
	xdEma3fbZdNNtks2rfo3xeLVG2eVhCZzyeQHcENHqHKCgZi0Gll6Nd1bQTLX+M3RhONrb+
	ST6SPvz8EH/FhzyHWgRACh9j+hT+5SA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1704362066;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+9cuiaFBoH53rifqhpcKmv1PSCTBZIUqSH8muwBZX6s=;
	b=UPonx0mOF3l3BWkHzNk/1ABR25UNALJPhJkLGUo4euPwkYnxA3kUqwpbMYp98bVKbiN2Um
	AtvWghZWalYo65CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7B30B13C96;
	Thu,  4 Jan 2024 09:54:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CL69HFGAlmXPZwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 04 Jan 2024 09:54:25 +0000
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
Subject: [PATCH v3 3/4] arch/x86: Implement arch_ima_efi_boot_mode() in source file
Date: Thu,  4 Jan 2024 10:51:21 +0100
Message-ID: <20240104095421.12772-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240104095421.12772-1-tzimmermann@suse.de>
References: <20240104095421.12772-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: *******
X-Spamd-Bar: +++++++
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=UC8ZblSf;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=UPonx0mO
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [7.49 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 R_RATELIMIT(0.00)[to_ip_from(RLfgmttzabnpkr34rizty4fwu5)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_TO(0.00)[kernel.org,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,google.com,arndb.de,linux.ibm.com,gmail.com,paul-moore.com,namei.org,hallyn.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[43.95%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 RCPT_COUNT_TWELVE(0.00)[22];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Score: 7.49
X-Rspamd-Queue-Id: 1188921F18
X-Spam-Flag: NO

The x86 implementation of arch_ima_efi_boot_mode() uses the global
boot_param state. Move it into a source file to clean up the header.
Avoid potential rebuilds of unrelated source files if boot_params
changes.

Suggested-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 arch/x86/include/asm/efi.h  | 5 +++--
 arch/x86/platform/efi/efi.c | 5 +++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index a5d7a83e4c2a..1dc600fa3ba5 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -409,8 +409,9 @@ extern int __init efi_memmap_split_count(efi_memory_desc_t *md,
 extern void __init efi_memmap_insert(struct efi_memory_map *old_memmap,
 				     void *buf, struct efi_mem_range *mem);
 
-#define arch_ima_efi_boot_mode	\
-	({ extern struct boot_params boot_params; boot_params.secure_boot; })
+extern enum efi_secureboot_mode __x86_ima_efi_boot_mode(void);
+
+#define arch_ima_efi_boot_mode	__x86_ima_efi_boot_mode()
 
 #ifdef CONFIG_EFI_RUNTIME_MAP
 int efi_get_runtime_map_size(void);
diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index e9f99c56f3ce..f090ec972d7b 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -950,3 +950,8 @@ umode_t efi_attr_is_visible(struct kobject *kobj, struct attribute *attr, int n)
 	}
 	return attr->mode;
 }
+
+enum efi_secureboot_mode __x86_ima_efi_boot_mode(void)
+{
+	return boot_params.secure_boot;
+}
-- 
2.43.0


