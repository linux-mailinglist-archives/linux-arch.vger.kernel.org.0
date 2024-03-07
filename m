Return-Path: <linux-arch+bounces-2890-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 524C9875659
	for <lists+linux-arch@lfdr.de>; Thu,  7 Mar 2024 19:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C00631F21F21
	for <lists+linux-arch@lfdr.de>; Thu,  7 Mar 2024 18:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11A3134CD4;
	Thu,  7 Mar 2024 18:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G88Txh06"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B0112EBE1;
	Thu,  7 Mar 2024 18:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709837313; cv=none; b=Xyhm0/TW0rp8zIsaLcizDyRx//kzS0HzmVnh4o8mFaqBMg1bWHUCpp43QFdyeaUeJaqjMJpkJcxBLfJFARcDZhzgLWWWsA8gaiE8B4x1isJE+AFt7/tc8j/Q5nDlV4SmfZlL6v0DQp/oIiFNknMv42IN+j+Z+gwTJX/KzG6jhlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709837313; c=relaxed/simple;
	bh=ZlVuiwcY3+tKFvMTuVwdIuga51AzO7GCDg1uyB1uMmc=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=Cy1eVD9AFuSlwFwGx5V4xj71deghhLFeZbFIi7K97+cD9R7vGL1+e/F6ebvngdUIVkmumJ3JPinTc/NwsNyoTn1SFIMqv6u8r/vpmzdpMIwk+/5MQpngtl/KhtPt56oG1Ha7ne3fzV/RbWItPAMazRR+qzOBU1tdMbyGrgSxZHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G88Txh06; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1dc75972f25so10513655ad.1;
        Thu, 07 Mar 2024 10:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709837311; x=1710442111; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DM6xLHdRM5YVSpxA0XD8pf8TNWCksal/JAtwGJQYz8s=;
        b=G88Txh06uLzX9d0vTLb/notD1X/oHcIipv2U84bd9yoJQ5zO+iXdjNgLvhDlbjx31V
         gWWNXvuVQ9QLWd4nZic3b9NTLR4iXH9VEMGkmeMoKoQJYMlqqqn9/SQGrfT2/MMMqjzF
         3I3BmBY6pgduhD+ntyjfS55zvCvb0jXw2tXumK+Qy3gE8mNN63i0LQq0oIolXqHVoBk/
         xD6jdi5XK+bnDk72mI8SCoZiFe9eyZWOd64o/XxtTJKtG2Slsqo1lqjxlpYRsGfsFeOX
         rCqaMcAmQTjTMbrba+HsFattfGTJhQlc5/0VIdzQ+ZdA7zOayNw1mjpkOZdcnVOdQ8JM
         5eTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709837311; x=1710442111;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DM6xLHdRM5YVSpxA0XD8pf8TNWCksal/JAtwGJQYz8s=;
        b=w84BkBjc8xnURgqmzLrjBdFDfcs9/rfWG+LZ8DVOUtnMVHQKPQOBD5W9oLKJdJb2Ae
         MIesZ2RSVgvzBCa4ybQNYERY6JYcoTf/RmqUz9T1FroBKqQQsCtNq4gareFhuMGnwYE7
         45CZ6KdrNJVBnUvjviwEEtdym3sE2mhJzuH6Jl0CeCMPrUIn+YftYvLNDmr0Nsrg3wzu
         KEKWSD1iiyInnNLidkmg79/iMtxSg+o/bop9JkRYVhdinQwoAIqYHX4qm5Svf/QH3zXR
         9IjV6Wtue4fnacB5dU2/TzT5aVClowXhxXpEYwEs00iagkwY2hb0cFqddqSJVm3ZWY46
         UWDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRw6wSt1Owk2KG5yniOG0ZEzZsPeHxFcKb1ZC28QHxb7jUzJejJg2/HUrRRqysEAqgdnRkDPjnzOIs31t9JP45rkFMVANgHtZLknJTTW1SHA0TkqG4thiHnCXXOtYPbgNlqHeG3Cn+Q/DVc5ngVXm1z8+cik3U4OqVqjdL5ntDN31VwWeT3A==
X-Gm-Message-State: AOJu0YxCaHDYb6Y3XxtrLGWxdKsnwcwRmKGrRcWE+64OcKYQfTptJ5d9
	CXa+XTDym837K1TCymQYsyGG4ms4bPSrMVrfFxiVAwUCw3jhXux/MMryg8wu
X-Google-Smtp-Source: AGHT+IH5lwnw1qFd96pNJ/vPQHDXDUC4wmgRO3AqnHGRP5XlyBljbgEjm9qmvgc+7czvdNbAnqbARw==
X-Received: by 2002:a17:902:db0a:b0:1dd:a34:7321 with SMTP id m10-20020a170902db0a00b001dd0a347321mr10432443plx.25.1709837311226;
        Thu, 07 Mar 2024 10:48:31 -0800 (PST)
Received: from localhost.localdomain (c-73-254-87-52.hsd1.wa.comcast.net. [73.254.87.52])
        by smtp.gmail.com with ESMTPSA id p24-20020a170903249800b001dbcfb4766csm14922726plw.226.2024.03.07.10.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 10:48:30 -0800 (PST)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	arnd@arndb.de,
	tytso@mit.edu,
	Jason@zx2c4.com,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: [PATCH v2 1/1] x86/hyperv: Use Hyper-V entropy to seed guest random number generator
Date: Thu,  7 Mar 2024 10:48:20 -0800
Message-Id: <20240307184820.70589-1-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

A Hyper-V host provides its guest VMs with entropy in a custom ACPI
table named "OEM0".  The entropy bits are updated each time Hyper-V
boots the VM, and are suitable for seeding the Linux guest random
number generator (rng). See a brief description of OEM0 in [1].

Generation 2 VMs on Hyper-V use UEFI to boot. Existing EFI code in
Linux seeds the rng with entropy bits from the EFI_RNG_PROTOCOL.
Via this path, the rng is seeded very early during boot with good
entropy. The ACPI OEM0 table is still provided in such VMs, though
it isn't needed.

But Generation 1 VMs on Hyper-V boot from BIOS. For these VMs, Linux
doesn't currently get any entropy from the Hyper-V host. While this
is not fundamentally broken because Linux can generate its own entropy,
using the Hyper-V host provided entropy would get the rng off to a
better start and would do so earlier in the boot process.

Improve the rng seeding for Generation 1 VMs by having Hyper-V specific
code in Linux take advantage of the OEM0 table to seed the rng. Because
the OEM0 table is custom to Hyper-V, parse it directly in the Hyper-V
code in the Linux kernel and use add_bootloader_randomness() to
seed the rng.  Once the entropy bits are read from OEM0, zero them
out in the table so they don't appear in /sys/firmware/acpi/tables/OEM0
in the running VM.

An equivalent change is *not* made for Linux VMs on Hyper-V for
ARM64. Such VMs are always Generation 2 and the rng is seeded
with entropy obtained via the EFI_RNG_PROTOCOL as described above.

[1] https://download.microsoft.com/download/1/c/9/1c9813b8-089c-4fef-b2ad-ad80e79403ba/Whitepaper%20-%20The%20Windows%2010%20random%20number%20generation%20infrastructure.pdf

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
Changes in v2:
* Tweaked commit message [Wei Liu]
* Removed message when OEM0 table isn't found. Added debug-level
  message when OEM0 is successfully used to add randomness. [Wei Liu]

 arch/x86/kernel/cpu/mshyperv.c |  1 +
 drivers/hv/hv_common.c         | 64 ++++++++++++++++++++++++++++++++++
 include/asm-generic/mshyperv.h |  2 ++
 3 files changed, 67 insertions(+)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 303fef824167..65c9cbdd2282 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -648,6 +648,7 @@ const __initconst struct hypervisor_x86 x86_hyper_ms_hyperv = {
 	.init.x2apic_available	= ms_hyperv_x2apic_available,
 	.init.msi_ext_dest_id	= ms_hyperv_msi_ext_dest_id,
 	.init.init_platform	= ms_hyperv_init_platform,
+	.init.guest_late_init	= ms_hyperv_late_init,
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 	.runtime.sev_es_hcall_prepare = hv_sev_es_hcall_prepare,
 	.runtime.sev_es_hcall_finish = hv_sev_es_hcall_finish,
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 0285a74363b3..219c4371314d 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -20,6 +20,8 @@
 #include <linux/sched/task_stack.h>
 #include <linux/panic_notifier.h>
 #include <linux/ptrace.h>
+#include <linux/random.h>
+#include <linux/efi.h>
 #include <linux/kdebug.h>
 #include <linux/kmsg_dump.h>
 #include <linux/slab.h>
@@ -347,6 +349,68 @@ int __init hv_common_init(void)
 	return 0;
 }
 
+void __init ms_hyperv_late_init(void)
+{
+	struct acpi_table_header *header;
+	acpi_status status;
+	u8 *randomdata;
+	u32 length, i;
+
+	/*
+	 * Seed the Linux random number generator with entropy provided by
+	 * the Hyper-V host in ACPI table OEM0.  It would be nice to do this
+	 * even earlier in ms_hyperv_init_platform(), but the ACPI subsystem
+	 * isn't set up at that point. Skip if booted via EFI as generic EFI
+	 * code has already done some seeding using the EFI RNG protocol.
+	 */
+	if (!IS_ENABLED(CONFIG_ACPI) || efi_enabled(EFI_BOOT))
+		return;
+
+	status = acpi_get_table("OEM0", 0, &header);
+	if (ACPI_FAILURE(status) || !header)
+		return;
+
+	/*
+	 * Since the "OEM0" table name is for OEM specific usage, verify
+	 * that what we're seeing purports to be from Microsoft.
+	 */
+	if (strncmp(header->oem_table_id, "MICROSFT", 8))
+		goto error;
+
+	/*
+	 * Ensure the length is reasonable.  Requiring at least 32 bytes and
+	 * no more than 256 bytes is somewhat arbitrary.  Hyper-V currently
+	 * provides 64 bytes, but allow for a change in a later version.
+	 */
+	if (header->length < sizeof(*header) + 32 ||
+	    header->length > sizeof(*header) + 256)
+		goto error;
+
+	length = header->length - sizeof(*header);
+	randomdata = (u8 *)(header + 1);
+
+	pr_debug("Hyper-V: Seeding rng with %d random bytes from ACPI table OEM0\n",
+			length);
+
+	add_bootloader_randomness(randomdata, length);
+
+	/*
+	 * To prevent the seed data from being visible in /sys/firmware/acpi,
+	 * zero out the random data in the ACPI table and fixup the checksum.
+	 */
+	for (i = 0; i < length; i++) {
+		header->checksum += randomdata[i];
+		randomdata[i] = 0;
+	}
+
+	acpi_put_table(header);
+	return;
+
+error:
+	pr_info("Hyper-V: Ignoring malformed ACPI table OEM0\n");
+	acpi_put_table(header);
+}
+
 /*
  * Hyper-V specific initialization and die code for
  * individual CPUs that is common across all architectures.
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 430f0ae0dde2..e861223093df 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -193,6 +193,7 @@ extern u64 (*hv_read_reference_counter)(void);
 
 int __init hv_common_init(void);
 void __init hv_common_free(void);
+void __init ms_hyperv_late_init(void);
 int hv_common_cpu_init(unsigned int cpu);
 int hv_common_cpu_die(unsigned int cpu);
 
@@ -290,6 +291,7 @@ void hv_setup_dma_ops(struct device *dev, bool coherent);
 static inline bool hv_is_hyperv_initialized(void) { return false; }
 static inline bool hv_is_hibernation_supported(void) { return false; }
 static inline void hyperv_cleanup(void) {}
+static inline void ms_hyperv_late_init(void) {}
 static inline bool hv_is_isolation_supported(void) { return false; }
 static inline enum hv_isolation_type hv_get_isolation_type(void)
 {
-- 
2.25.1


