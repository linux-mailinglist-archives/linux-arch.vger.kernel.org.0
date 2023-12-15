Return-Path: <linux-arch+bounces-1079-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13038814804
	for <lists+linux-arch@lfdr.de>; Fri, 15 Dec 2023 13:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA8D8285DB1
	for <lists+linux-arch@lfdr.de>; Fri, 15 Dec 2023 12:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F232D7A2;
	Fri, 15 Dec 2023 12:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gVP6H5kw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Q6vnj5Gu";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gVP6H5kw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Q6vnj5Gu"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D6B2C68A;
	Fri, 15 Dec 2023 12:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 821F922047;
	Fri, 15 Dec 2023 12:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702643177; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yRSvKmc/J7/5tWJgZpc9pXN0+dl1c7KVuJDbYsdVexE=;
	b=gVP6H5kwzQ/CjDX9eY//OSsf/qhwQZaov+Yk+O6dW0qHkbWgAjDlDZXPKtGgS8XS5zhXHd
	CwKxmR8x+ZlAIZHWKmoFNG9JvnO7Hh6Z5U62n2p0W7qTFaJyEhUEc9MrLf9IUEqprbqQAJ
	qa3aBUbDkHDI+6FvrkBBfjXpA/KACds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702643177;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yRSvKmc/J7/5tWJgZpc9pXN0+dl1c7KVuJDbYsdVexE=;
	b=Q6vnj5GunHcI0dCexNHF4UfCcbfOPINokium3ZcDmnfZnvbgjLPZrGlQzPdoa6l8JRkT88
	Uabr95EZQT61B7Bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702643177; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yRSvKmc/J7/5tWJgZpc9pXN0+dl1c7KVuJDbYsdVexE=;
	b=gVP6H5kwzQ/CjDX9eY//OSsf/qhwQZaov+Yk+O6dW0qHkbWgAjDlDZXPKtGgS8XS5zhXHd
	CwKxmR8x+ZlAIZHWKmoFNG9JvnO7Hh6Z5U62n2p0W7qTFaJyEhUEc9MrLf9IUEqprbqQAJ
	qa3aBUbDkHDI+6FvrkBBfjXpA/KACds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702643177;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yRSvKmc/J7/5tWJgZpc9pXN0+dl1c7KVuJDbYsdVexE=;
	b=Q6vnj5GunHcI0dCexNHF4UfCcbfOPINokium3ZcDmnfZnvbgjLPZrGlQzPdoa6l8JRkT88
	Uabr95EZQT61B7Bg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id EA62C13BA0;
	Fri, 15 Dec 2023 12:26:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id OGMOOOhFfGVIRwAAn2gu4w
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
Subject: [PATCH v2 1/3] arch/x86: Move UAPI setup structures into setup_data.h
Date: Fri, 15 Dec 2023 13:18:12 +0100
Message-ID: <20231215122614.5481-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231215122614.5481-1-tzimmermann@suse.de>
References: <20231215122614.5481-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: 3.40
X-Spam-Flag: NO
X-Spamd-Result: default: False [3.40 / 50.00];
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
	 R_RATELIMIT(0.00)[to_ip_from(RLthqzz6q5hnubohss7ffybi86)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[22];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FREEMAIL_TO(0.00)[kernel.org,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,google.com,arndb.de,linux.ibm.com,gmail.com,paul-moore.com,namei.org,hallyn.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Level: ***
X-Spam-Score: 3.40
Authentication-Results: smtp-out1.suse.de;
	none

The type definition of struct pci_setup_rom in <asm/pci.h> requires
struct setup_data from <asm/bootparam.h>. Many drivers include
<linux/pci.h>, but do not use boot parameters. Changes to bootparam.h
or its included header files could easily trigger a large, unnecessary
rebuild of the kernel.

Moving struct setup_data and related code into its own own header file
avoids including <asm/bootparam.h> in <asm/pci.h>. Instead include the
new header <asm/screen_data.h> and remove the include statement for
x86_init.h, which is unnecessary but pulls in bootparams.h.

Suggested-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 arch/x86/include/asm/pci.h             |   2 +-
 arch/x86/include/uapi/asm/bootparam.h  | 218 +----------------------
 arch/x86/include/uapi/asm/setup_data.h | 229 +++++++++++++++++++++++++
 3 files changed, 231 insertions(+), 218 deletions(-)
 create mode 100644 arch/x86/include/uapi/asm/setup_data.h

diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
index b40c462b4af3..f6100df3652e 100644
--- a/arch/x86/include/asm/pci.h
+++ b/arch/x86/include/asm/pci.h
@@ -10,7 +10,7 @@
 #include <linux/numa.h>
 #include <asm/io.h>
 #include <asm/memtype.h>
-#include <asm/x86_init.h>
+#include <asm/setup_data.h>
 
 struct pci_sysdata {
 	int		domain;		/* PCI domain */
diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
index 01d19fc22346..f6361eb792fd 100644
--- a/arch/x86/include/uapi/asm/bootparam.h
+++ b/arch/x86/include/uapi/asm/bootparam.h
@@ -2,42 +2,7 @@
 #ifndef _ASM_X86_BOOTPARAM_H
 #define _ASM_X86_BOOTPARAM_H
 
-/* setup_data/setup_indirect types */
-#define SETUP_NONE			0
-#define SETUP_E820_EXT			1
-#define SETUP_DTB			2
-#define SETUP_PCI			3
-#define SETUP_EFI			4
-#define SETUP_APPLE_PROPERTIES		5
-#define SETUP_JAILHOUSE			6
-#define SETUP_CC_BLOB			7
-#define SETUP_IMA			8
-#define SETUP_RNG_SEED			9
-#define SETUP_ENUM_MAX			SETUP_RNG_SEED
-
-#define SETUP_INDIRECT			(1<<31)
-#define SETUP_TYPE_MAX			(SETUP_ENUM_MAX | SETUP_INDIRECT)
-
-/* ram_size flags */
-#define RAMDISK_IMAGE_START_MASK	0x07FF
-#define RAMDISK_PROMPT_FLAG		0x8000
-#define RAMDISK_LOAD_FLAG		0x4000
-
-/* loadflags */
-#define LOADED_HIGH	(1<<0)
-#define KASLR_FLAG	(1<<1)
-#define QUIET_FLAG	(1<<5)
-#define KEEP_SEGMENTS	(1<<6)
-#define CAN_USE_HEAP	(1<<7)
-
-/* xloadflags */
-#define XLF_KERNEL_64			(1<<0)
-#define XLF_CAN_BE_LOADED_ABOVE_4G	(1<<1)
-#define XLF_EFI_HANDOVER_32		(1<<2)
-#define XLF_EFI_HANDOVER_64		(1<<3)
-#define XLF_EFI_KEXEC			(1<<4)
-#define XLF_5LEVEL			(1<<5)
-#define XLF_5LEVEL_ENABLED		(1<<6)
+#include <asm/setup_data.h>
 
 #ifndef __ASSEMBLY__
 
@@ -48,139 +13,6 @@
 #include <asm/ist.h>
 #include <video/edid.h>
 
-/* extensible setup data list node */
-struct setup_data {
-	__u64 next;
-	__u32 type;
-	__u32 len;
-	__u8 data[];
-};
-
-/* extensible setup indirect data node */
-struct setup_indirect {
-	__u32 type;
-	__u32 reserved;  /* Reserved, must be set to zero. */
-	__u64 len;
-	__u64 addr;
-};
-
-struct setup_header {
-	__u8	setup_sects;
-	__u16	root_flags;
-	__u32	syssize;
-	__u16	ram_size;
-	__u16	vid_mode;
-	__u16	root_dev;
-	__u16	boot_flag;
-	__u16	jump;
-	__u32	header;
-	__u16	version;
-	__u32	realmode_swtch;
-	__u16	start_sys_seg;
-	__u16	kernel_version;
-	__u8	type_of_loader;
-	__u8	loadflags;
-	__u16	setup_move_size;
-	__u32	code32_start;
-	__u32	ramdisk_image;
-	__u32	ramdisk_size;
-	__u32	bootsect_kludge;
-	__u16	heap_end_ptr;
-	__u8	ext_loader_ver;
-	__u8	ext_loader_type;
-	__u32	cmd_line_ptr;
-	__u32	initrd_addr_max;
-	__u32	kernel_alignment;
-	__u8	relocatable_kernel;
-	__u8	min_alignment;
-	__u16	xloadflags;
-	__u32	cmdline_size;
-	__u32	hardware_subarch;
-	__u64	hardware_subarch_data;
-	__u32	payload_offset;
-	__u32	payload_length;
-	__u64	setup_data;
-	__u64	pref_address;
-	__u32	init_size;
-	__u32	handover_offset;
-	__u32	kernel_info_offset;
-} __attribute__((packed));
-
-struct sys_desc_table {
-	__u16 length;
-	__u8  table[14];
-};
-
-/* Gleaned from OFW's set-parameters in cpu/x86/pc/linux.fth */
-struct olpc_ofw_header {
-	__u32 ofw_magic;	/* OFW signature */
-	__u32 ofw_version;
-	__u32 cif_handler;	/* callback into OFW */
-	__u32 irq_desc_table;
-} __attribute__((packed));
-
-struct efi_info {
-	__u32 efi_loader_signature;
-	__u32 efi_systab;
-	__u32 efi_memdesc_size;
-	__u32 efi_memdesc_version;
-	__u32 efi_memmap;
-	__u32 efi_memmap_size;
-	__u32 efi_systab_hi;
-	__u32 efi_memmap_hi;
-};
-
-/*
- * This is the maximum number of entries in struct boot_params::e820_table
- * (the zeropage), which is part of the x86 boot protocol ABI:
- */
-#define E820_MAX_ENTRIES_ZEROPAGE 128
-
-/*
- * The E820 memory region entry of the boot protocol ABI:
- */
-struct boot_e820_entry {
-	__u64 addr;
-	__u64 size;
-	__u32 type;
-} __attribute__((packed));
-
-/*
- * Smallest compatible version of jailhouse_setup_data required by this kernel.
- */
-#define JAILHOUSE_SETUP_REQUIRED_VERSION	1
-
-/*
- * The boot loader is passing platform information via this Jailhouse-specific
- * setup data structure.
- */
-struct jailhouse_setup_data {
-	struct {
-		__u16	version;
-		__u16	compatible_version;
-	} __attribute__((packed)) hdr;
-	struct {
-		__u16	pm_timer_address;
-		__u16	num_cpus;
-		__u64	pci_mmconfig_base;
-		__u32	tsc_khz;
-		__u32	apic_khz;
-		__u8	standard_ioapic;
-		__u8	cpu_ids[255];
-	} __attribute__((packed)) v1;
-	struct {
-		__u32	flags;
-	} __attribute__((packed)) v2;
-} __attribute__((packed));
-
-/*
- * IMA buffer setup data information from the previous kernel during kexec
- */
-struct ima_setup_data {
-	__u64 addr;
-	__u64 size;
-} __attribute__((packed));
-
 /* The so-called "zeropage" */
 struct boot_params {
 	struct screen_info screen_info;			/* 0x000 */
@@ -231,54 +63,6 @@ struct boot_params {
 	__u8  _pad9[276];				/* 0xeec */
 } __attribute__((packed));
 
-/**
- * enum x86_hardware_subarch - x86 hardware subarchitecture
- *
- * The x86 hardware_subarch and hardware_subarch_data were added as of the x86
- * boot protocol 2.07 to help distinguish and support custom x86 boot
- * sequences. This enum represents accepted values for the x86
- * hardware_subarch.  Custom x86 boot sequences (not X86_SUBARCH_PC) do not
- * have or simply *cannot* make use of natural stubs like BIOS or EFI, the
- * hardware_subarch can be used on the Linux entry path to revector to a
- * subarchitecture stub when needed. This subarchitecture stub can be used to
- * set up Linux boot parameters or for special care to account for nonstandard
- * handling of page tables.
- *
- * These enums should only ever be used by x86 code, and the code that uses
- * it should be well contained and compartmentalized.
- *
- * KVM and Xen HVM do not have a subarch as these are expected to follow
- * standard x86 boot entries. If there is a genuine need for "hypervisor" type
- * that should be considered separately in the future. Future guest types
- * should seriously consider working with standard x86 boot stubs such as
- * the BIOS or EFI boot stubs.
- *
- * WARNING: this enum is only used for legacy hacks, for platform features that
- *	    are not easily enumerated or discoverable. You should not ever use
- *	    this for new features.
- *
- * @X86_SUBARCH_PC: Should be used if the hardware is enumerable using standard
- *	PC mechanisms (PCI, ACPI) and doesn't need a special boot flow.
- * @X86_SUBARCH_LGUEST: Used for x86 hypervisor demo, lguest, deprecated
- * @X86_SUBARCH_XEN: Used for Xen guest types which follow the PV boot path,
- * 	which start at asm startup_xen() entry point and later jump to the C
- * 	xen_start_kernel() entry point. Both domU and dom0 type of guests are
- * 	currently supported through this PV boot path.
- * @X86_SUBARCH_INTEL_MID: Used for Intel MID (Mobile Internet Device) platform
- *	systems which do not have the PCI legacy interfaces.
- * @X86_SUBARCH_CE4100: Used for Intel CE media processor (CE4100) SoC
- * 	for settop boxes and media devices, the use of a subarch for CE4100
- * 	is more of a hack...
- */
-enum x86_hardware_subarch {
-	X86_SUBARCH_PC = 0,
-	X86_SUBARCH_LGUEST,
-	X86_SUBARCH_XEN,
-	X86_SUBARCH_INTEL_MID,
-	X86_SUBARCH_CE4100,
-	X86_NR_SUBARCHS,
-};
-
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_X86_BOOTPARAM_H */
diff --git a/arch/x86/include/uapi/asm/setup_data.h b/arch/x86/include/uapi/asm/setup_data.h
new file mode 100644
index 000000000000..e1396e1bf048
--- /dev/null
+++ b/arch/x86/include/uapi/asm/setup_data.h
@@ -0,0 +1,229 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_ASM_X86_SETUP_DATA_H
+#define _UAPI_ASM_X86_SETUP_DATA_H
+
+/* setup_data/setup_indirect types */
+#define SETUP_NONE			0
+#define SETUP_E820_EXT			1
+#define SETUP_DTB			2
+#define SETUP_PCI			3
+#define SETUP_EFI			4
+#define SETUP_APPLE_PROPERTIES		5
+#define SETUP_JAILHOUSE			6
+#define SETUP_CC_BLOB			7
+#define SETUP_IMA			8
+#define SETUP_RNG_SEED			9
+#define SETUP_ENUM_MAX			SETUP_RNG_SEED
+
+#define SETUP_INDIRECT			(1<<31)
+#define SETUP_TYPE_MAX			(SETUP_ENUM_MAX | SETUP_INDIRECT)
+
+/* ram_size flags */
+#define RAMDISK_IMAGE_START_MASK	0x07FF
+#define RAMDISK_PROMPT_FLAG		0x8000
+#define RAMDISK_LOAD_FLAG		0x4000
+
+/* loadflags */
+#define LOADED_HIGH	(1<<0)
+#define KASLR_FLAG	(1<<1)
+#define QUIET_FLAG	(1<<5)
+#define KEEP_SEGMENTS	(1<<6)
+#define CAN_USE_HEAP	(1<<7)
+
+/* xloadflags */
+#define XLF_KERNEL_64			(1<<0)
+#define XLF_CAN_BE_LOADED_ABOVE_4G	(1<<1)
+#define XLF_EFI_HANDOVER_32		(1<<2)
+#define XLF_EFI_HANDOVER_64		(1<<3)
+#define XLF_EFI_KEXEC			(1<<4)
+#define XLF_5LEVEL			(1<<5)
+#define XLF_5LEVEL_ENABLED		(1<<6)
+
+#ifndef __ASSEMBLY__
+
+#include <linux/types.h>
+
+/* extensible setup data list node */
+struct setup_data {
+	__u64 next;
+	__u32 type;
+	__u32 len;
+	__u8 data[];
+};
+
+/* extensible setup indirect data node */
+struct setup_indirect {
+	__u32 type;
+	__u32 reserved;  /* Reserved, must be set to zero. */
+	__u64 len;
+	__u64 addr;
+};
+
+struct setup_header {
+	__u8	setup_sects;
+	__u16	root_flags;
+	__u32	syssize;
+	__u16	ram_size;
+	__u16	vid_mode;
+	__u16	root_dev;
+	__u16	boot_flag;
+	__u16	jump;
+	__u32	header;
+	__u16	version;
+	__u32	realmode_swtch;
+	__u16	start_sys_seg;
+	__u16	kernel_version;
+	__u8	type_of_loader;
+	__u8	loadflags;
+	__u16	setup_move_size;
+	__u32	code32_start;
+	__u32	ramdisk_image;
+	__u32	ramdisk_size;
+	__u32	bootsect_kludge;
+	__u16	heap_end_ptr;
+	__u8	ext_loader_ver;
+	__u8	ext_loader_type;
+	__u32	cmd_line_ptr;
+	__u32	initrd_addr_max;
+	__u32	kernel_alignment;
+	__u8	relocatable_kernel;
+	__u8	min_alignment;
+	__u16	xloadflags;
+	__u32	cmdline_size;
+	__u32	hardware_subarch;
+	__u64	hardware_subarch_data;
+	__u32	payload_offset;
+	__u32	payload_length;
+	__u64	setup_data;
+	__u64	pref_address;
+	__u32	init_size;
+	__u32	handover_offset;
+	__u32	kernel_info_offset;
+} __attribute__((packed));
+
+struct sys_desc_table {
+	__u16 length;
+	__u8  table[14];
+};
+
+/* Gleaned from OFW's set-parameters in cpu/x86/pc/linux.fth */
+struct olpc_ofw_header {
+	__u32 ofw_magic;	/* OFW signature */
+	__u32 ofw_version;
+	__u32 cif_handler;	/* callback into OFW */
+	__u32 irq_desc_table;
+} __attribute__((packed));
+
+struct efi_info {
+	__u32 efi_loader_signature;
+	__u32 efi_systab;
+	__u32 efi_memdesc_size;
+	__u32 efi_memdesc_version;
+	__u32 efi_memmap;
+	__u32 efi_memmap_size;
+	__u32 efi_systab_hi;
+	__u32 efi_memmap_hi;
+};
+
+/*
+ * This is the maximum number of entries in struct boot_params::e820_table
+ * (the zeropage), which is part of the x86 boot protocol ABI:
+ */
+#define E820_MAX_ENTRIES_ZEROPAGE 128
+
+/*
+ * The E820 memory region entry of the boot protocol ABI:
+ */
+struct boot_e820_entry {
+	__u64 addr;
+	__u64 size;
+	__u32 type;
+} __attribute__((packed));
+
+/*
+ * Smallest compatible version of jailhouse_setup_data required by this kernel.
+ */
+#define JAILHOUSE_SETUP_REQUIRED_VERSION	1
+
+/*
+ * The boot loader is passing platform information via this Jailhouse-specific
+ * setup data structure.
+ */
+struct jailhouse_setup_data {
+	struct {
+		__u16	version;
+		__u16	compatible_version;
+	} __attribute__((packed)) hdr;
+	struct {
+		__u16	pm_timer_address;
+		__u16	num_cpus;
+		__u64	pci_mmconfig_base;
+		__u32	tsc_khz;
+		__u32	apic_khz;
+		__u8	standard_ioapic;
+		__u8	cpu_ids[255];
+	} __attribute__((packed)) v1;
+	struct {
+		__u32	flags;
+	} __attribute__((packed)) v2;
+} __attribute__((packed));
+
+/*
+ * IMA buffer setup data information from the previous kernel during kexec
+ */
+struct ima_setup_data {
+	__u64 addr;
+	__u64 size;
+} __attribute__((packed));
+
+/**
+ * enum x86_hardware_subarch - x86 hardware subarchitecture
+ *
+ * The x86 hardware_subarch and hardware_subarch_data were added as of the x86
+ * boot protocol 2.07 to help distinguish and support custom x86 boot
+ * sequences. This enum represents accepted values for the x86
+ * hardware_subarch.  Custom x86 boot sequences (not X86_SUBARCH_PC) do not
+ * have or simply *cannot* make use of natural stubs like BIOS or EFI, the
+ * hardware_subarch can be used on the Linux entry path to revector to a
+ * subarchitecture stub when needed. This subarchitecture stub can be used to
+ * set up Linux boot parameters or for special care to account for nonstandard
+ * handling of page tables.
+ *
+ * These enums should only ever be used by x86 code, and the code that uses
+ * it should be well contained and compartmentalized.
+ *
+ * KVM and Xen HVM do not have a subarch as these are expected to follow
+ * standard x86 boot entries. If there is a genuine need for "hypervisor" type
+ * that should be considered separately in the future. Future guest types
+ * should seriously consider working with standard x86 boot stubs such as
+ * the BIOS or EFI boot stubs.
+ *
+ * WARNING: this enum is only used for legacy hacks, for platform features that
+ *	    are not easily enumerated or discoverable. You should not ever use
+ *	    this for new features.
+ *
+ * @X86_SUBARCH_PC: Should be used if the hardware is enumerable using standard
+ *	PC mechanisms (PCI, ACPI) and doesn't need a special boot flow.
+ * @X86_SUBARCH_LGUEST: Used for x86 hypervisor demo, lguest, deprecated
+ * @X86_SUBARCH_XEN: Used for Xen guest types which follow the PV boot path,
+ * 	which start at asm startup_xen() entry point and later jump to the C
+ * 	xen_start_kernel() entry point. Both domU and dom0 type of guests are
+ * 	currently supported through this PV boot path.
+ * @X86_SUBARCH_INTEL_MID: Used for Intel MID (Mobile Internet Device) platform
+ *	systems which do not have the PCI legacy interfaces.
+ * @X86_SUBARCH_CE4100: Used for Intel CE media processor (CE4100) SoC
+ * 	for settop boxes and media devices, the use of a subarch for CE4100
+ * 	is more of a hack...
+ */
+enum x86_hardware_subarch {
+	X86_SUBARCH_PC = 0,
+	X86_SUBARCH_LGUEST,
+	X86_SUBARCH_XEN,
+	X86_SUBARCH_INTEL_MID,
+	X86_SUBARCH_CE4100,
+	X86_NR_SUBARCHS,
+};
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* _UAPI_ASM_X86_SETUP_DATA_H */
-- 
2.43.0


