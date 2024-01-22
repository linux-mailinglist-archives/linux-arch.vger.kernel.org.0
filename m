Return-Path: <linux-arch+bounces-1416-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B565C836C90
	for <lists+linux-arch@lfdr.de>; Mon, 22 Jan 2024 18:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65D7D285354
	for <lists+linux-arch@lfdr.de>; Mon, 22 Jan 2024 17:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA094C625;
	Mon, 22 Jan 2024 16:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmxIow+S"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548723D98E;
	Mon, 22 Jan 2024 16:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705939228; cv=none; b=q3MVYLzNX7bQEIGME4DWrBOi6I1jmK95pehlGdm1AWnxzJCYOJCmdz5QprV3nIVZLDJ5nGUSowCvMSFu8W3lpPD2VMvO4mxQ+lOaFTlhwHtnw1mAcpFJSfJwZPb7kXwXktepOmXjEW2ZkGGPJs4FtsEwhfdgg4crKBD+nbMd23k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705939228; c=relaxed/simple;
	bh=oUuA39q9NysCLP5y2VB29sFok8GYF4MFOaRUFr9J6B4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=SVfINhzXcVA3giPo1/QINjYZ9kMuj0NWhg2so84Y8ERP0dtMj/83UGpMpFz57XiMxsyH1RgQVelCTIwJ80g5ISi4BJubbs7nhJuXB3ylq4wTJRKw785PfeO4PruOBGk1Dimy3CkMwiZKwIumYaNP1jwAywV6UTMAA7UKphxdALI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lmxIow+S; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5cdfbd4e8caso2952502a12.0;
        Mon, 22 Jan 2024 08:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705939226; x=1706544026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=P4DFxv7u9MxtnN8PbxbWszByo4QQvqldIQNFxhqzua0=;
        b=lmxIow+S2N7gNdLC7bEVz1XvwXlNCKf3cTLmzUVHtUX8+ZITcKSk0DHEhQ4XNjToTS
         Xzbai3TX5DI1PhwjmHVvx3yqDt2K3sdmyPTPBkhNAkzi7Zhw6R8NB4l0x+/CU1Y7oqd2
         ONOY0pFOuEpae/xDlB5RWE7qsAAx4NxCcoDVX+/P8m7Tsu2s63xk5nuxya/5K0VMgg72
         3SaCldrvOTT4zX1NJBd5UN+d25OQB1WSKiXp+Ppv/+0DJ3pQ5d5nZwCPP8wQa7/7MGpe
         xNY/u9a5Tw4rxtx4ep13XgerCexDQF5dJ2XEDrIFbRLp6X6TuzLoPczHph4gzWCW0uw5
         sViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705939226; x=1706544026;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P4DFxv7u9MxtnN8PbxbWszByo4QQvqldIQNFxhqzua0=;
        b=HJGFVMiCO1Fsylto7Qw82/231HvKGQWs7sYxLoUazgrgQpOLM289bzaFAwZ0ZnPuwY
         jHpiMwWmvKFDvqPgqYMujbiq5zF4auV0xNhG2vyaPAJDd43Vi8fjEwHx3EA9FwWXSmxs
         UJAsxS1k+SEv15S2G6AZwcg26SZ+EKvXWZriJduhssP56z9AqNZZXTE12tA4o+qIo1Id
         RkBfiX5q3tHtMSx+QC83rKpN4iafnvU3085s6wK01sV7KgXhuSSbTEz7vR9WTf4WWj6w
         CvjTNPb79FnfOiW0ixxjlFQJVa1Oxvm/OOSLkiGo8bJFdIVO9Zbco3fgNpRmCMjV4ljN
         hUBw==
X-Gm-Message-State: AOJu0YwMb9zx18VAPhmFn2dHWNHMx5FzFgrMir0o+G4XWZoZnr0FT5wg
	hbP1MIi5n9ofwMfHBwKWug1l4HfH6t9lP/ueeYye3VfVAM2Y67rg
X-Google-Smtp-Source: AGHT+IHtmxMDFzoMpy+qtrDTzexx4Zuhn9AVSM4sTIBuLxSL3pAUX4p8b+/tAjNOh4k8MZ527c5vEw==
X-Received: by 2002:a17:90a:bb0f:b0:290:b20e:125 with SMTP id u15-20020a17090abb0f00b00290b20e0125mr718916pjr.92.1705939225025;
        Mon, 22 Jan 2024 08:00:25 -0800 (PST)
Received: from localhost.localdomain (c-73-254-87-52.hsd1.wa.comcast.net. [73.254.87.52])
        by smtp.gmail.com with ESMTPSA id sh18-20020a17090b525200b002901ded7356sm9611587pjb.2.2024.01.22.08.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 08:00:24 -0800 (PST)
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
Subject: [PATCH 1/1] x86/hyperv: Use Hyper-V entropy to seed guest random number generator
Date: Mon, 22 Jan 2024 08:00:03 -0800
Message-Id: <20240122160003.348521-1-mhklinux@outlook.com>
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
number generator (rng).  See a brief description of OEM0 in [1].

Generation 2 VMs on Hyper-V boot using UEFI.  Existing EFI code in
Linux seeds the rng with entropy bits from the EFI_RNG_PROTOCOL.
Via this path, the rng is seeded very early during boot with good
entropy.  The ACPI OEM0 table is still provided in such VMs, though
it isn't needed.

But Generation 1 VMs on Hyper-V boot from BIOS. For these VMs, Linux
doesn't currently get any entropy from the Hyper-V host.  While this
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
ARM64.  Such VMs are always Generation 2 and the rng is seeded
with entropy obtained via the EFI_RNG_PROTOCOL as described above.

[1] https://download.microsoft.com/download/1/c/9/1c9813b8-089c-4fef-b2ad-ad80e79403ba/Whitepaper%20-%20The%20Windows%2010%20random%20number%20generation%20infrastructure.pdf

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 arch/x86/kernel/cpu/mshyperv.c |  1 +
 drivers/hv/hv_common.c         | 62 ++++++++++++++++++++++++++++++++++
 include/asm-generic/mshyperv.h |  2 ++
 3 files changed, 65 insertions(+)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index e6bba12c759c..c202a60ecc6c 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -640,6 +640,7 @@ const __initconst struct hypervisor_x86 x86_hyper_ms_hyperv = {
 	.init.x2apic_available	= ms_hyperv_x2apic_available,
 	.init.msi_ext_dest_id	= ms_hyperv_msi_ext_dest_id,
 	.init.init_platform	= ms_hyperv_init_platform,
+	.init.guest_late_init	= ms_hyperv_late_init,
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 	.runtime.sev_es_hcall_prepare = hv_sev_es_hcall_prepare,
 	.runtime.sev_es_hcall_finish = hv_sev_es_hcall_finish,
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index ccad7bca3fd3..ebae19b708b4 100644
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
@@ -348,6 +350,66 @@ int __init hv_common_init(void)
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
+	if (ACPI_FAILURE(status) || !header) {
+		pr_info("Hyper-V: ACPI table OEM0 not found\n");
+		return;
+	}
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


