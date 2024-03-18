Return-Path: <linux-arch+bounces-3024-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F7A87ECBD
	for <lists+linux-arch@lfdr.de>; Mon, 18 Mar 2024 16:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A339280E2C
	for <lists+linux-arch@lfdr.de>; Mon, 18 Mar 2024 15:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17DA52F83;
	Mon, 18 Mar 2024 15:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5+CA+A3"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC2052F6D;
	Mon, 18 Mar 2024 15:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710777266; cv=none; b=pyE2M6ikfoex4KKv7sYl7u5kRP8GyEyQrKZZaeAd2Vl66OEuAWBweYji0VkFPZjQWIvgmc7rcm1ZpJ9zcnMiXSSgcNHU+afwVqocil3ZGDk1oKccAY9kJx8rpisrGp8Gzuo0uv5di/QAJhmGxg1JEzVT6Bh5gDKan7lbrjjFZAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710777266; c=relaxed/simple;
	bh=elUv1hYWfbQaDffhIbaJRDBf1X2KxzMKUjA0oh/yR4Q=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=laSB9i4iBA8+s2eMmPfzMy+shG9YQoaw+awBIK2uLZVsDNe5M1lcHzu0OOO4lf7xR8k2HoMnXZpu/yS7k1jQT/UppVmaEw9jSxWQZUutBS8soK/0mUZ1POAeHvNGmDEOFgunXtdElATzjtN9Rx9dI0BcF6ag/iwjZp2GAfnyhGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P5+CA+A3; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1dddbeac9f9so30017765ad.3;
        Mon, 18 Mar 2024 08:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710777264; x=1711382064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pY6Srnd5Kh93En3qT+oLWoFRArvvI8UEhcxxei/JIjg=;
        b=P5+CA+A3oeiTmLB4EOjOGoq21CKwwM/HfRZEYdcfXrTVDfbugMNoKHCs9GSH/qqirI
         w4r/igYnBviRxkef1cDTy6iSMSt8c0koqR0wltWBOyXSeVr6L1ZAeZsSb+cR7guXkr/4
         NxCM7TmuF6mFgY/F/93G+58zRxssXjp48vSSRi641zqtb84uX52MQPQvHY1tJ346sAZr
         fC1t/HS+HxZmD4Evug5Y/S8nXmT7+SR2f9olf0DUdpxd1s0o1qPtWLpeECr7nxDNjPWh
         VoDBiRpvKYYyCj6irTPqZTA2W3sjYctgCoXq1cfKbp2iUo5zzeFg3rukb4rUuhmdHBMv
         LHRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710777264; x=1711382064;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pY6Srnd5Kh93En3qT+oLWoFRArvvI8UEhcxxei/JIjg=;
        b=wo6Fxd0XosPw44aQdpVwTtu3yTpl6OL+QdRIzuFc9b27dyjz6pQR3sExC1pqOlD/VS
         MIyfQJ1w5ZCJzrRK0aXwSamIuC4gTxDKI19wO2LYXdI5ENMKB7cUTqmRW2d5AK4Jmb71
         jYoYFVzyD2Z9uS17DQM7weyqukr6gCdA6pLpspBRFBzSG1vM2ihf5rRdtXJke2TTw1K3
         xRQdi1YSGclZlf+Rzq5J/c5dG7S5ouPbmpV/jbCBGNERZyBbZ42O2OffA3BJ7Axl4Ll0
         0WVHQnQ/ckSlsFnLyuS5d2IYPYEoRjvR+eDagj/x5+kiiEukHTpx0PdtoGLxLDHtlcxf
         a78Q==
X-Forwarded-Encrypted: i=1; AJvYcCUWx0bp372Agbcp4EumlbBtMFJVDs+JBjtXPdU5vZqbMSjZyeo61xNONywwocccQtncJvCje1n8M+POhtSBcbajQkGE2v/w6fbUHnwak6aivquGkXaCvOQdySJyoM9Bzu+M0mcm5jbe7W4cfUQMrYONQjLLExEgT7yAtCMAm+aZDjrxq/YaCw==
X-Gm-Message-State: AOJu0YxrMTQp6AzPvel+RIyS7bCONrAtEeL7P6R5kHj0Lomz1WGadV+W
	b2zk2rKH8VxVNQFufnr+8qHlX7ahX0kx0CAU6uHbW7XlexkfnTFd
X-Google-Smtp-Source: AGHT+IF+vlUFwAFTMs1qkhcULE6I3RIHgARg3GJmsJSO8I1QNVdMwKAGni0/muEuWtAL/VbS71OqGQ==
X-Received: by 2002:a17:902:ea03:b0:1df:3a42:2769 with SMTP id s3-20020a170902ea0300b001df3a422769mr9377201plg.6.1710777264215;
        Mon, 18 Mar 2024 08:54:24 -0700 (PDT)
Received: from localhost.localdomain (c-73-254-87-52.hsd1.wa.comcast.net. [73.254.87.52])
        by smtp.gmail.com with ESMTPSA id cp5-20020a170902e78500b001def18c0cfdsm6964268plb.300.2024.03.18.08.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 08:54:23 -0700 (PDT)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	catalin.marinas@arm.com,
	will@kernel.org,
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
Subject: [PATCH v3 1/1] x86/hyperv: Use Hyper-V entropy to seed guest random number generator
Date: Mon, 18 Mar 2024 08:54:08 -0700
Message-Id: <20240318155408.216851-1-mhklinux@outlook.com>
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
entropy. The ACPI OEM0 table provided in such VMs is an additional
source of entropy.

Generation 1 VMs on Hyper-V boot from BIOS. For these VMs, Linux
doesn't currently get any entropy from the Hyper-V host. While this
is not fundamentally broken because Linux can generate its own entropy,
using the Hyper-V host provided entropy would get the rng off to a
better start and would do so earlier in the boot process.

Improve the rng seeding for Generation 1 VMs by having Hyper-V specific
code in Linux take advantage of the OEM0 table to seed the rng. For
Generation 2 VMs, use the OEM0 table to provide additional entropy
beyond the EFI_RNG_PROTOCOL. Because the OEM0 table is custom to
Hyper-V, parse it directly in the Hyper-V code in the Linux kernel
and use add_bootloader_randomness() to add it to the rng. Once the
entropy bits are read from OEM0, zero them out in the table so
they don't appear in /sys/firmware/acpi/tables/OEM0 in the running
VM. The zero'ing is done out of an abundance of caution to avoid
potential security risks to the rng. Also set the OEM0 data length
to zero so a kexec or other subsequent use of the table won't try
to use the zero'ed bits.

[1] https://download.microsoft.com/download/1/c/9/1c9813b8-089c-4fef-b2ad-ad80e79403ba/Whitepaper%20-%20The%20Windows%2010%20random%20number%20generation%20infrastructure.pdf

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
Changes in v3:
* Removed restriction to just Generation 1 VMs. Generation 2 VMs
  now also use the additional entropy even though they also get
  initial entropy via EFI_RNG_PROTOCOL [Jason Donenfeld]
* Process the OEM0 table on ARM64 systems in addition to x86/x64,
  as a result of no longer excluding Generation 2 VM.
* Enlarge the range of entropy byte counts that are considered valid
  in the OEM0 table. New range is 8 to 4K; previously the range was
  32 to 256. [Jason Donenfeld]
* After processing the entropy bits in OEM0, also set the OEM0
  table length to indicate that the entropy byte count is zero,
  to prevent a subsequent kexec or other use of the table from
  trying to use the zero'ed bits. [Jason Donenfeld]

Changes in v2:
* Tweaked commit message [Wei Liu]
* Removed message when OEM0 table isn't found. Added debug-level
  message when OEM0 is successfully used to add randomness. [Wei Liu]

 arch/arm64/hyperv/mshyperv.c   |  2 +
 arch/x86/kernel/cpu/mshyperv.c |  1 +
 drivers/hv/hv_common.c         | 69 ++++++++++++++++++++++++++++++++++
 include/asm-generic/mshyperv.h |  2 +
 4 files changed, 74 insertions(+)

diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
index f1b8a04ee9f2..c8193cec1b90 100644
--- a/arch/arm64/hyperv/mshyperv.c
+++ b/arch/arm64/hyperv/mshyperv.c
@@ -74,6 +74,8 @@ static int __init hyperv_init(void)
 		return ret;
 	}
 
+	ms_hyperv_late_init();
+
 	hyperv_initialized = true;
 	return 0;
 }
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
index 0285a74363b3..724de94d885f 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -20,8 +20,11 @@
 #include <linux/sched/task_stack.h>
 #include <linux/panic_notifier.h>
 #include <linux/ptrace.h>
+#include <linux/random.h>
+#include <linux/efi.h>
 #include <linux/kdebug.h>
 #include <linux/kmsg_dump.h>
+#include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/dma-map-ops.h>
 #include <linux/set_memory.h>
@@ -347,6 +350,72 @@ int __init hv_common_init(void)
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
+	 * the Hyper-V host in ACPI table OEM0.
+	 */
+	if (!IS_ENABLED(CONFIG_ACPI))
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
+	 * Ensure the length is reasonable. Requiring at least 8 bytes and
+	 * no more than 4K bytes is somewhat arbitrary and just protects
+	 * against a malformed table. Hyper-V currently provides 64 bytes,
+	 * but allow for a change in a later version.
+	 */
+	if (header->length < sizeof(*header) + 8 ||
+	    header->length > sizeof(*header) + SZ_4K)
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
+	 * The zero'ing is done out of an abundance of caution in avoiding
+	 * potential security risks to the rng. Similarly, reset the table
+	 * length to just the header size so that a subsequent kexec doesn't
+	 * try to use the zero'ed out random data.
+	 */
+	for (i = 0; i < length; i++) {
+		header->checksum += randomdata[i];
+		randomdata[i] = 0;
+	}
+
+	for (i = 0; i < sizeof(header->length); i++)
+		header->checksum += ((u8 *)&header->length)[i];
+	header->length = sizeof(*header);
+	for (i = 0; i < sizeof(header->length); i++)
+		header->checksum -= ((u8 *)&header->length)[i];
+
+error:
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


