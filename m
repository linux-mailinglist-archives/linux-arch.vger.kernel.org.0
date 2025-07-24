Return-Path: <linux-arch+bounces-12910-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 508F6B10C48
	for <lists+linux-arch@lfdr.de>; Thu, 24 Jul 2025 15:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 034137B95B0
	for <lists+linux-arch@lfdr.de>; Thu, 24 Jul 2025 13:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040B22E2EF9;
	Thu, 24 Jul 2025 13:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lblUVM3P"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBE618E025
	for <linux-arch@vger.kernel.org>; Thu, 24 Jul 2025 13:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365389; cv=none; b=QMEfKhkd9+snizoqB7MsxDHdTeIC5KI7MMzZ34qXr3zJsVSFJdcA24i2UoRJ/XTJdW5QIGdzmL/QBZil8bD7ee0hSeQhgP3FCR95R++LHGfGphnowL8vGLkyAqiO3+/bx8KmXy3nu4YoBCy+Cz7jomBYaGpOmkookyDxS0GejeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365389; c=relaxed/simple;
	bh=++DNfnXyQWdsETwYm6bgVDRBrywEMYhV87J4dW4JDIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d0eiD1/mcB1Swv03Jt5sgdXVH93Eor2DI4OaHDZIRamvswqFJh2JHVs6aZu+DX341CSjlm1rEislL3R2Y96F1v/UuwvLsRLfwTwZWhZvM/Gv4wesuH04kBwcTtvC9hWFGX4irrBBRt8wrkOOCRA/xBQmNzWZh6+yGP6VOH3HIOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lblUVM3P; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45610582d07so7125645e9.0
        for <linux-arch@vger.kernel.org>; Thu, 24 Jul 2025 06:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753365384; x=1753970184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XG4UpkMMVRYtGXT6cuR8yNOWitjMYnN9sl4ER5EV3F0=;
        b=lblUVM3PxYfoa8+UR7+g7MngEyZ+MFxCyP7gS9jtyW93UvIp+IQdkUY63jbgGfDnCs
         +nSPrbY3qKwSW36QRm2/7FA5LwTVT6VkOxvSfry+NNfao9spwyo7rJA2OYSYyv316/J9
         mMEthMZiK/KwyhZDaCKOeQfBcp7UfmoE/o0iVHAdKi+xSB3Ivy9ny2Ehim9Dzk+4/cVy
         py+BeenSIfLXiVK/mVjOxASqdJx8VFCsx064OoZaa2QWRrZKh/Bo/8Acbx7OONhR5VYY
         Jzr+MgWSIZsgLeIC/RrGFCpPO2r65onKoGtJVod6rfv30clTiGvqy4cgXfT/iedFCbz5
         eF1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753365384; x=1753970184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XG4UpkMMVRYtGXT6cuR8yNOWitjMYnN9sl4ER5EV3F0=;
        b=FJOcEQ5FH30Ri1TGBJ3V2QjTI65qW8uwgflIlfQ1N09tbNxDntf5YumMD1saUm8Njo
         eNMm37m0iC956rh0Pq3uJvn+ScKES5kclbqQ/z1bzqs6peKz3pFeDzD0IzRMqFlTAFUb
         Vf2x+T+12mgFTMuOYWnBqkTK4D/2PKOApye0j/xb3NJ6X93UYbCmQt1LFMu6X+oAsgW4
         ly0p/sQe4EXq/7dA7PY7D6iiXtNxnubqpmOK8ytSdRKhbTU3xia2D7u2qSrk87DJh8kz
         /7mJbCSJH0Qivw+R7is1mVUPr0OC/vEB02TX4ganugyVk4UMBzBtr0zugtF4iHv9H0Bl
         nYaQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9PbckxuqvjQTnqxacl4r7F4Yqh8OfXqbYx1JMymTZTKslcOIAouPP/QHMIgQ3ZvIAeZcGMRz48vne@vger.kernel.org
X-Gm-Message-State: AOJu0YwEeaRHFJ6Qx/BYvKk1tf7C7NK8K0qc6JXFqtiNglrn7I5JSgVv
	OluxNrKBmAqRNAqkESdXX5WyYHuCjhEh3kLqbCStZXVfsKKN/uqIMNEkpZu0qbqTjGw=
X-Gm-Gg: ASbGncuq6LfDaEhWuP9ZZ6Pt5MDZcaIw8WHVxjGnIK1n+1jo8fy18ZuUTUIT+rqOS8v
	6Q4yCALV7dt/bz1Z7h6LapiuD1jl9vwICK8PATo8pWT6or3L8n6NdjkbkvFKC7GFiZBwALUzrV7
	iMg9cPja4C/BE6aDQtJNVEiHPt3bplXv3hoTQhsDFb1cdevtzXtpZUV6FA2OCO+3rnHgc7+8fC+
	l20gzMgRS1f9EgW7UIfV+2wkcCY0m4fAT3cpWBiwsqmvvSCe3tgMZmazOOGQyO4htyyZv0cH8tk
	FN/UZUSrj3p6yAkbNuEvT5V1XzsbuqzmjTyydbaMnCinYmRIIFt1HkgoL3yKpUvcgVZ1F2AiflO
	xY77A1Sx5BlN3WQDWzR0/bkh4I4E3WHsZofOCuzxn6JBgtEQIiA4WVwTUY00YgQ6unG9xg3lel4
	WerAUkstgID+yq
X-Google-Smtp-Source: AGHT+IFk0XSSRo6IltEN054dyX/SHvso8FPYoVfVtJ49vV2Kf2bz+TLyXa3T3TxRoIm60B1Sl6dIGg==
X-Received: by 2002:a05:600c:621b:b0:455:ed48:144f with SMTP id 5b1f17b1804b1-4586f218339mr27655495e9.14.1753365384388;
        Thu, 24 Jul 2025 06:56:24 -0700 (PDT)
Received: from eugen-station.. (cpc148880-bexl9-2-0-cust354.2-3.cable.virginm.net. [82.11.253.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054e37dsm20889375e9.14.2025.07.24.06.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:56:24 -0700 (PDT)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	tglx@linutronix.de,
	andersson@kernel.org,
	pmladek@suse.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	eugen.hristev@linaro.org,
	corbet@lwn.net,
	mojha@qti.qualcomm.com,
	rostedt@goodmis.org,
	jonechou@google.com,
	tudor.ambarus@linaro.org
Subject: [RFC][PATCH v2 03/29] kmemdump: add coreimage ELF layer
Date: Thu, 24 Jul 2025 16:54:46 +0300
Message-ID: <20250724135512.518487-4-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250724135512.518487-1-eugen.hristev@linaro.org>
References: <20250724135512.518487-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement kmemdumping into an ELF coreimage.
With this feature enabled, kmemdump will assemble all the regions
into a coreimage, by having an initial first region with an ELF header,
a second region with vmcoreinfo data, and then register vital kernel
information in the subsequent regions.
This image can then be dumped, assembled into a single file and loaded
into debugging tools like crash/gdb.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 MAINTAINERS                        |   1 +
 drivers/debug/Kconfig              |  14 ++
 drivers/debug/Makefile             |   1 +
 drivers/debug/kmemdump.c           |  25 ++++
 drivers/debug/kmemdump_coreimage.c | 223 +++++++++++++++++++++++++++++
 include/linux/kmemdump.h           |  70 ++++++++-
 6 files changed, 333 insertions(+), 1 deletion(-)
 create mode 100644 drivers/debug/kmemdump_coreimage.c

diff --git a/MAINTAINERS b/MAINTAINERS
index ef0ffdfaf3de..b43a43b61e19 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13622,6 +13622,7 @@ M:	Eugen Hristev <eugen.hristev@linaro.org>
 S:	Maintained
 F:	Documentation/debug/kmemdump.rst
 F:	drivers/debug/kmemdump.c
+F:	drivers/debug/kmemdump_coreimage.c
 F:	include/linux/kmemdump.h
 
 KMEMLEAK
diff --git a/drivers/debug/Kconfig b/drivers/debug/Kconfig
index b86585c5d621..903e3e2805b7 100644
--- a/drivers/debug/Kconfig
+++ b/drivers/debug/Kconfig
@@ -13,4 +13,18 @@ config KMEMDUMP
 
 	  Note that modules using this feature must be rebuilt if option
 	  changes.
+
+config KMEMDUMP_COREIMAGE
+	depends on KMEMDUMP
+	select VMCORE_INFO
+	bool "Assemble memory regions into a coredump readable with debuggers"
+	help
+	  Enabling this will assemble all the memory regions into a
+	  core ELF file. The first region will include program headers for
+	  all the regions. The second region is the vmcoreinfo and specific
+	  coredump structures.
+	  All the other regions follow. Specific kernel variables required
+	  for debug tools are being registered.
+	  The coredump file can then be loaded into GDB or crash  tool and
+	  further inspected.
 endmenu
diff --git a/drivers/debug/Makefile b/drivers/debug/Makefile
index 8ed6ec2d8a0d..2b67673393a6 100644
--- a/drivers/debug/Makefile
+++ b/drivers/debug/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_KMEMDUMP) += kmemdump.o
+obj-$(CONFIG_KMEMDUMP_COREIMAGE) += kmemdump_coreimage.o
diff --git a/drivers/debug/kmemdump.c b/drivers/debug/kmemdump.c
index b6d418aafbef..6dd49359d8ef 100644
--- a/drivers/debug/kmemdump.c
+++ b/drivers/debug/kmemdump.c
@@ -28,15 +28,34 @@ static const struct kmemdump_backend kmemdump_default_backend = {
 static const struct kmemdump_backend *backend = &kmemdump_default_backend;
 static DEFINE_MUTEX(kmemdump_lock);
 static struct kmemdump_zone kmemdump_zones[MAX_ZONES];
+static bool kmemdump_initialized;
 
 static int __init init_kmemdump(void)
 {
 	const struct kmemdump_zone *e;
+	enum kmemdump_uid uid;
+
+	init_elfheader();
 
 	/* Walk the kmemdump section for static variables and register them */
 	for_each_kmemdump_entry(e)
 		kmemdump_register_id(e->id, e->zone, e->size);
 
+	mutex_lock(&kmemdump_lock);
+	/*
+	 * Some regions may have been registered very early.
+	 * Update the elf header for all existing regions,
+	 * except for KMEMDUMP_ID_COREIMAGE_ELF and
+	 * KMEMDUMP_ID_COREIMAGE_VMCOREINFO, those are included in the
+	 * ELF header upon its creation.
+	 */
+	for (uid = KMEMDUMP_ID_COREIMAGE_CONFIG; uid < MAX_ZONES; uid++)
+		if (kmemdump_zones[uid].id)
+			update_elfheader(&kmemdump_zones[uid]);
+
+	kmemdump_initialized = true;
+	mutex_unlock(&kmemdump_lock);
+
 	return 0;
 }
 late_initcall(init_kmemdump);
@@ -95,6 +114,9 @@ int kmemdump_register_id(enum kmemdump_uid req_id, void *zone, size_t size)
 	z->size = size;
 	z->id = uid;
 
+	if (kmemdump_initialized)
+		update_elfheader(z);
+
 	mutex_unlock(&kmemdump_lock);
 
 	return uid;
@@ -122,6 +144,9 @@ void kmemdump_unregister(enum kmemdump_uid id)
 
 	backend->unregister_region(backend, z->id);
 
+	if (kmemdump_initialized)
+		clear_elfheader(z);
+
 	memset(z, 0, sizeof(*z));
 
 	mutex_unlock(&kmemdump_lock);
diff --git a/drivers/debug/kmemdump_coreimage.c b/drivers/debug/kmemdump_coreimage.c
new file mode 100644
index 000000000000..2cdab22d0c5c
--- /dev/null
+++ b/drivers/debug/kmemdump_coreimage.c
@@ -0,0 +1,223 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/elfcore.h>
+#include <linux/kmemdump.h>
+#include <linux/vmcore_info.h>
+
+#define CORE_STR "CORE"
+
+#define MAX_NUM_ENTRIES	201
+
+static struct elfhdr *ehdr;
+static size_t elf_offset;
+
+static void append_kcore_note(char *notes, size_t *i, const char *name,
+			      unsigned int type, const void *desc,
+			      size_t descsz)
+{
+	struct elf_note *note = (struct elf_note *)&notes[*i];
+
+	note->n_namesz = strlen(name) + 1;
+	note->n_descsz = descsz;
+	note->n_type = type;
+	*i += sizeof(*note);
+	memcpy(&notes[*i], name, note->n_namesz);
+	*i = ALIGN(*i + note->n_namesz, 4);
+	memcpy(&notes[*i], desc, descsz);
+	*i = ALIGN(*i + descsz, 4);
+}
+
+static void append_kcore_note_nodesc(char *notes, size_t *i, const char *name,
+				     unsigned int type, size_t descsz)
+{
+	struct elf_note *note = (struct elf_note *)&notes[*i];
+
+	note->n_namesz = strlen(name) + 1;
+	note->n_descsz = descsz;
+	note->n_type = type;
+	*i += sizeof(*note);
+	memcpy(&notes[*i], name, note->n_namesz);
+	*i = ALIGN(*i + note->n_namesz, 4);
+}
+
+static struct elf_phdr *elf_phdr_entry_addr(struct elfhdr *ehdr, int idx)
+{
+	struct elf_phdr *ephdr = (struct elf_phdr *)((size_t)ehdr + ehdr->e_phoff);
+
+	return &ephdr[idx];
+}
+
+/**
+ * clear_elfheader() - Remove the program header for a specific memory zone
+ * @z: pointer to the kmemdump zone
+ *
+ * Return: On success, it returns 0, errno otherwise
+ */
+int clear_elfheader(const struct kmemdump_zone *z)
+{
+	struct elf_phdr *phdr;
+	struct elf_phdr *tmp_phdr;
+	unsigned int phidx;
+	unsigned int i;
+
+	for (i = 0; i < ehdr->e_phnum; i++) {
+		phdr = elf_phdr_entry_addr(ehdr, i);
+		if (phdr->p_paddr == virt_to_phys(z->zone) &&
+		    phdr->p_memsz == ALIGN(z->size, 4))
+			break;
+	}
+
+	if (i == ehdr->e_phnum) {
+		pr_debug("Cannot find program header entry in elf\n");
+		return -EINVAL;
+	}
+
+	phidx = i;
+
+	/* Clear program header */
+	tmp_phdr = elf_phdr_entry_addr(ehdr, phidx);
+	for (i = phidx; i < ehdr->e_phnum - 1; i++) {
+		tmp_phdr = elf_phdr_entry_addr(ehdr, i + 1);
+		phdr = elf_phdr_entry_addr(ehdr, i);
+		memcpy(phdr, tmp_phdr, sizeof(*phdr));
+		phdr->p_offset = phdr->p_offset - ALIGN(z->size, 4);
+	}
+	memset(tmp_phdr, 0, sizeof(*tmp_phdr));
+	ehdr->e_phnum--;
+
+	elf_offset -= ALIGN(z->size, 4);
+
+	return 0;
+}
+
+/**
+ * update_elfheader() - Add the program header for a specific memory zone
+ * @z: pointer to the kmemdump zone
+ *
+ * Return: None
+ */
+void update_elfheader(const struct kmemdump_zone *z)
+{
+	struct elf_phdr *phdr;
+
+	phdr = elf_phdr_entry_addr(ehdr, ehdr->e_phnum++);
+
+	phdr->p_type = PT_LOAD;
+	phdr->p_offset = elf_offset;
+	phdr->p_vaddr = (elf_addr_t)z->zone;
+	phdr->p_paddr = (elf_addr_t)virt_to_phys(z->zone);
+	phdr->p_filesz = phdr->p_memsz = ALIGN(z->size, 4);
+	phdr->p_flags = PF_R | PF_W;
+
+	elf_offset += ALIGN(z->size, 4);
+}
+
+/**
+ * init_elfheader() - Prepare coreinfo elf header
+ *		This function prepares the elf header for the coredump image.
+ *		Initially there is a single program header for the elf NOTE.
+ *		The note contains the usual core dump information, and the
+ *		vmcoreinfo.
+ *
+ * Return: 0 on success, errno otherwise
+ */
+int init_elfheader(void)
+{
+	struct elf_phdr *phdr;
+	void *notes;
+	unsigned int elfh_size;
+	unsigned int phdr_off;
+	size_t note_len, i = 0;
+
+	struct elf_prstatus prstatus = {};
+	struct elf_prpsinfo prpsinfo = {
+		.pr_sname = 'R',
+		.pr_fname = "vmlinux",
+	};
+
+	/*
+	 * Header buffer contains:
+	 * ELF header, Note entry with PR status, PR ps info, and vmcoreinfo
+	 * MAX_NUM_ENTRIES Program headers,
+	 */
+	elfh_size = sizeof(*ehdr);
+	elfh_size += sizeof(struct elf_prstatus);
+	elfh_size += sizeof(struct elf_prpsinfo);
+	elfh_size += sizeof(VMCOREINFO_NOTE_NAME);
+	elfh_size += ALIGN(vmcoreinfo_size, 4);
+	elfh_size += (sizeof(*phdr)) * (MAX_NUM_ENTRIES);
+
+	elfh_size = ALIGN(elfh_size, 4);
+
+	/* Never freed */
+	ehdr = kzalloc(elfh_size, GFP_KERNEL);
+	if (!ehdr)
+		return -ENOMEM;
+
+	/* Assign Program headers offset, it's right after the elf header. */
+	phdr = (struct elf_phdr *)(ehdr + 1);
+	phdr_off = sizeof(*ehdr);
+
+	memcpy(ehdr->e_ident, ELFMAG, SELFMAG);
+	ehdr->e_ident[EI_CLASS] = ELF_CLASS;
+	ehdr->e_ident[EI_DATA] = ELF_DATA;
+	ehdr->e_ident[EI_VERSION] = EV_CURRENT;
+	ehdr->e_ident[EI_OSABI] = ELF_OSABI;
+	ehdr->e_type = ET_CORE;
+	ehdr->e_machine  = ELF_ARCH;
+	ehdr->e_version = EV_CURRENT;
+	ehdr->e_ehsize = sizeof(*ehdr);
+	ehdr->e_phentsize = sizeof(*phdr);
+
+	elf_offset = elfh_size;
+
+	notes = (void *)(((char *)ehdr) + elf_offset);
+
+	/* we have a single program header now */
+	ehdr->e_phnum = 1;
+
+	/* Length of the note is made of :
+	 * 3 elf notes structs (prstatus, prpsinfo, vmcoreinfo)
+	 * 3 notes names (2 core strings, 1 vmcoreinfo name)
+	 * sizeof each note
+	 */
+	note_len = (3 * sizeof(struct elf_note) +
+		    2 * ALIGN(sizeof(CORE_STR), 4) +
+		    VMCOREINFO_NOTE_NAME_BYTES +
+		    ALIGN(sizeof(struct elf_prstatus), 4) +
+		    ALIGN(sizeof(struct elf_prpsinfo), 4) +
+		    ALIGN(vmcoreinfo_size, 4));
+
+	phdr->p_type = PT_NOTE;
+	phdr->p_offset = elf_offset;
+	phdr->p_filesz = note_len;
+
+	/* advance elf offset */
+	elf_offset += note_len;
+
+	strscpy(prpsinfo.pr_psargs, saved_command_line,
+		sizeof(prpsinfo.pr_psargs));
+
+	append_kcore_note(notes, &i, CORE_STR, NT_PRSTATUS, &prstatus,
+			  sizeof(prstatus));
+	append_kcore_note(notes, &i, CORE_STR, NT_PRPSINFO, &prpsinfo,
+			  sizeof(prpsinfo));
+	append_kcore_note_nodesc(notes, &i, VMCOREINFO_NOTE_NAME, 0,
+				 ALIGN(vmcoreinfo_size, 4));
+
+	ehdr->e_phoff = phdr_off;
+
+	/* This is the first kmemdump region, the ELF header */
+	kmemdump_register_id(KMEMDUMP_ID_COREIMAGE_ELF, ehdr,
+			     elfh_size + note_len - ALIGN(vmcoreinfo_size, 4));
+
+	/*
+	 * The second region is the vmcoreinfo, which goes right after.
+	 * It's being registered through vmcoreinfo.
+	 */
+
+	return 0;
+}
+
diff --git a/include/linux/kmemdump.h b/include/linux/kmemdump.h
index c3690423a347..7933915c2c78 100644
--- a/include/linux/kmemdump.h
+++ b/include/linux/kmemdump.h
@@ -4,6 +4,37 @@
 
 enum kmemdump_uid {
 	KMEMDUMP_ID_START = 0,
+	KMEMDUMP_ID_COREIMAGE_ELF,
+	KMEMDUMP_ID_COREIMAGE_VMCOREINFO,
+	KMEMDUMP_ID_COREIMAGE_CONFIG,
+	KMEMDUMP_ID_COREIMAGE_MEMSECT,
+	KMEMDUMP_ID_COREIMAGE__totalram_pages,
+	KMEMDUMP_ID_COREIMAGE___cpu_possible_mask,
+	KMEMDUMP_ID_COREIMAGE___cpu_present_mask,
+	KMEMDUMP_ID_COREIMAGE___cpu_online_mask,
+	KMEMDUMP_ID_COREIMAGE___cpu_active_mask,
+	KMEMDUMP_ID_COREIMAGE_jiffies_64,
+	KMEMDUMP_ID_COREIMAGE_linux_banner,
+	KMEMDUMP_ID_COREIMAGE_nr_threads,
+	KMEMDUMP_ID_COREIMAGE_nr_irqs,
+	KMEMDUMP_ID_COREIMAGE_tainted_mask,
+	KMEMDUMP_ID_COREIMAGE_taint_flags,
+	KMEMDUMP_ID_COREIMAGE_mem_section,
+	KMEMDUMP_ID_COREIMAGE_node_data,
+	KMEMDUMP_ID_COREIMAGE_node_states,
+	KMEMDUMP_ID_COREIMAGE___per_cpu_offset,
+	KMEMDUMP_ID_COREIMAGE_nr_swapfiles,
+	KMEMDUMP_ID_COREIMAGE_init_uts_ns,
+	KMEMDUMP_ID_COREIMAGE_printk_rb_static,
+	KMEMDUMP_ID_COREIMAGE_printk_rb_dynamic,
+	KMEMDUMP_ID_COREIMAGE_prb,
+	KMEMDUMP_ID_COREIMAGE_prb_descs,
+	KMEMDUMP_ID_COREIMAGE_prb_infos,
+	KMEMDUMP_ID_COREIMAGE_prb_data,
+	KMEMDUMP_ID_COREIMAGE_runqueues,
+	KMEMDUMP_ID_COREIMAGE_high_memory,
+	KMEMDUMP_ID_COREIMAGE_init_mm,
+	KMEMDUMP_ID_COREIMAGE_init_mm_pgd,
 	KMEMDUMP_ID_USER_START,
 	KMEMDUMP_ID_USER_END,
 	KMEMDUMP_ID_NO_ID,
@@ -33,7 +64,20 @@ extern const struct kmemdump_zone __kmemdump_table_end[];
 					  .zone = (void *)&(sym),		\
 					  .size = (sz),				\
 					}
-
+/* Annotate a variable into the KMEMDUMP_ID_COREIMAGE_sym UID */
+#define KMEMDUMP_VAR_CORE(sym, sz)						\
+	static const struct kmemdump_zone __UNIQUE_ID(__kmemdump_entry_##sym)	\
+	__used __section(".kmemdump") = { .id = KMEMDUMP_ID_COREIMAGE_##sym,	\
+					  .zone = (void *)&(sym),		\
+					  .size = (sz),				\
+					}
+/* Annotate a variable into the KMEMDUMP_ID_COREIMAGE_name UID */
+#define KMEMDUMP_VAR_CORE_NAMED(name, sym, sz)					\
+	static const struct kmemdump_zone __UNIQUE_ID(__kmemdump_entry_##name)	\
+	__used __section(".kmemdump") = { .id = KMEMDUMP_ID_COREIMAGE_##name,	\
+					  .zone = (void *)&(sym),		\
+					  .size = (sz),				\
+					}
 /* Iterate through kmemdump section entries */
 #define for_each_kmemdump_entry(__entry)		\
 	for (__entry = __kmemdump_table;		\
@@ -42,6 +86,9 @@ extern const struct kmemdump_zone __kmemdump_table_end[];
 
 #else
 #define KMEMDUMP_VAR_ID(...)
+#define KMEMDUMP_VAR_CORE(...)
+#define KMEMDUMP_VAR_CORE_NAMED(...)
+#define KMEMDUMP_VAR_CORE_NAMED(...)
 #endif
 /*
  * Wrapper over an existing fn allocator
@@ -132,4 +179,25 @@ static inline void kmemdump_unregister(enum kmemdump_uid id)
 }
 #endif
 
+#ifdef CONFIG_KMEMDUMP
+#ifdef CONFIG_KMEMDUMP_COREIMAGE
+int init_elfheader(void);
+void update_elfheader(const struct kmemdump_zone *z);
+int clear_elfheader(const struct kmemdump_zone *z);
+#else
+static inline int init_elfheader(void)
+{
+	return 0;
+}
+
+static inline void update_elfheader(const struct kmemdump_zone *z)
+{
+}
+
+static inline int clear_elfheader(const struct kmemdump_zone *z)
+{
+	return 0;
+}
+#endif
+#endif
 #endif
-- 
2.43.0


