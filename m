Return-Path: <linux-arch+bounces-9361-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 571299EE3C8
	for <lists+linux-arch@lfdr.de>; Thu, 12 Dec 2024 11:10:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46B38286A88
	for <lists+linux-arch@lfdr.de>; Thu, 12 Dec 2024 10:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3952101A3;
	Thu, 12 Dec 2024 10:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGsiyAQf"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7A320FA8A;
	Thu, 12 Dec 2024 10:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733998217; cv=none; b=cx2fXV8h2Jk6Z2EBJ4vGX3n439TC/Esr94Vvrzq6rpKHzf4V0pVbuwdCV9nkPRUomm0QxP98RxZO/AzoAMSLghhrVj/EaVvkgStwc+EJjOrM+t93XHwGiNAQHLqwiszsNqHw2/nA5YvAeuXHoxF9kFLyYW8ml8TZ27XC0ZCBNFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733998217; c=relaxed/simple;
	bh=AorsqWl1jCnLZ9DfDFY4FtXuOTptz0N+4mQHfMQ2WEY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GKAe/jwB2pIdz4PWZTDv03XBhhaxHeg2cC1W2UaD0DhaItbfC7hdu0C3s2DsoS17CKupfaVHyey7arJ28O5V7Wp6kqZasO2Iw16xlxsOGFZI8kCf3YQzibB88veAd4FaoHssFuDQPQ/XerdH7q14OKTdlxhKeYJDJaxzWE/AKmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BGsiyAQf; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-216281bc30fso4616865ad.0;
        Thu, 12 Dec 2024 02:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733998215; x=1734603015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zZanVRx4WAhit1sZ/hOnh7NH4U6nFyxymYnnlN3ZoUU=;
        b=BGsiyAQfYNayYDDnrN2C0MP48iEcA8LpCIzLPRP9w2djVMkLDaws5P+kmoqwaXklUP
         MyjGlUaSykPNZNUUnDVV8yPyY8DNBktoekq+EmXQADuwaiaJUv9x849dl1C/L9EnMzoG
         v3mAgNRyy1pApKHmj7EVTkkfrymEyXZC7Vl3kvOE2CesLEonJrzjv2yI6GGst/iTVJi2
         Yc2Fe4Djnid0YMtRd4xbste8aAyM26d7K387/eq3m4dy506quhdtolHRGUWGGXuF5Zv1
         pJq/i5vtkiDOwF053OpLaQyhzIJyWySavczhiOoKj/uX+5eb2JHMfcgXaz+X0MMu+oRJ
         zNVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733998215; x=1734603015;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zZanVRx4WAhit1sZ/hOnh7NH4U6nFyxymYnnlN3ZoUU=;
        b=CDvD+1kWsY68kN/MieHgUN4egLim/X/dI4K58kev7tZLfpo0ZiMqfQafjFtc2LIlEH
         vhQDgzi4SQPC1bZ10zzRICFrdbjqJzxDfNhl4Qnm44c8f12UQ4/EHcjphWOW1hCDcrxt
         nC7j8tQ5EsMaqdmoibVZ52SzdKO15iIOcB2v7Os5bw6ns5dATNs3TgbXnidkF9hj8ep/
         5B5A/o0jASYXR0wHjUpy2cMecu6bxSH5ppVAVSiObfwyJE/oaN8LJbI8WO3wlLMIp/hf
         wj3WZ8M9pQeAoT1QBXgSKblBME0bywNeyW7XHc1u5ds/9ZFchDnZRfV1pTpZ4NZ+5HbG
         Ih/A==
X-Forwarded-Encrypted: i=1; AJvYcCULlDYDiGj6Cz6+JGSwA68cbyrRBAOOTfVl8agA/EE9dMqQEAMqC35yHlXaXQar/Jnjaqdbhr9vXNKJ@vger.kernel.org, AJvYcCVJsDf67lKkN5OdX/RC6myCN5des5VfEyhrQbTGe7ulDlEpwl4ZM1GwHCD391mD8HyMsP83a+HBIt6K1A==@vger.kernel.org, AJvYcCVQfwjKVx0eEK1lV/pjPm+V+uY5d0RV6z43s27ZSAy1tZXLbiM077j0AuWRc2tMOhvGeQ6KHfpeNZ+4fiOa@vger.kernel.org
X-Gm-Message-State: AOJu0YzqSG3HtMwfZBz9dndiYxjM7BAchA8Gv0CIAKj8chiEwGufn4+l
	uCvLw4oJLOVPQV2AtJPdC3jU6/vFwEQt7PcL8N0CjqyjAS6Fgq5u
X-Gm-Gg: ASbGncuDrUeq9DoIBKgO5UGTnNR9NRdNSXzRCw+jB2A/4j8mx87G65lGHiCEgbwgkfy
	NJrhwYBjcpE5gZJCkVaoWzjCEwpvY7G4DCnQ19OaYU+7Ops2x6XbbzUXgTywFmw0y26CT2kCPv/
	5+jYn9YSfS4NQpc3XOYS9AKPtJAUVVgomkXYVtGgcZAqbezIcl2Xez6t1fVdMXgbfGtustaIoXX
	uhLHCTZxBhrHxG1JcDA1NLonBI9X9oHGgwduCWdtPNqd9pRNrp9c9lSssthGvYIn8DvIWB/Chhz
	Dyme
X-Google-Smtp-Source: AGHT+IH6gcwPQeo8o7QWFQKnzChC6uQO93gPkmdmDG/SQmzj5FSwJNJHWHb5JoN5L+bUnuXzcp5J7w==
X-Received: by 2002:a17:902:d389:b0:215:6816:6345 with SMTP id d9443c01a7336-21778536e08mr75258075ad.16.1733998214774;
        Thu, 12 Dec 2024 02:10:14 -0800 (PST)
Received: from localhost.localdomain ([36.110.106.149])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd1570ae4esm10519521a12.43.2024.12.12.02.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 02:10:14 -0800 (PST)
From: Guo Weikang <guoweikang.kernel@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Julian Stecklina <julian.stecklina@cyberus-technology.de>,
	"Xin Li (Intel)" <xin@zytor.com>,
	Guo Weikang <guoweikang.kernel@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>,
	Kevin Loughlin <kevinloughlin@google.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH] mm/early_ioremap: Add null pointer checks to prevent NULL-pointer dereference
Date: Thu, 12 Dec 2024 18:10:00 +0800
Message-Id: <20241212101004.1544070-1-guoweikang.kernel@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The early_ioremap interface can fail and return NULL in certain cases. To
prevent NULL-pointer dereference crashes, fixed issues in the acpi_extlog
and copy_early_mem interfaces, improving robustness when handling early
memory.

Signed-off-by: Guo Weikang <guoweikang.kernel@gmail.com>
---
 arch/x86/kernel/setup.c             |  5 ++++-
 drivers/acpi/acpi_extlog.c          | 14 ++++++++++++++
 include/asm-generic/early_ioremap.h |  2 +-
 mm/early_ioremap.c                  |  8 +++++++-
 4 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index f1fea506e20f..cebee310e200 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -259,6 +259,7 @@ static void __init relocate_initrd(void)
 	u64 ramdisk_image = get_ramdisk_image();
 	u64 ramdisk_size  = get_ramdisk_size();
 	u64 area_size     = PAGE_ALIGN(ramdisk_size);
+	int ret = 0;
 
 	/* We need to move the initrd down into directly mapped mem */
 	u64 relocated_ramdisk = memblock_phys_alloc_range(area_size, PAGE_SIZE, 0,
@@ -272,7 +273,9 @@ static void __init relocate_initrd(void)
 	printk(KERN_INFO "Allocated new RAMDISK: [mem %#010llx-%#010llx]\n",
 	       relocated_ramdisk, relocated_ramdisk + ramdisk_size - 1);
 
-	copy_from_early_mem((void *)initrd_start, ramdisk_image, ramdisk_size);
+	ret = copy_from_early_mem((void *)initrd_start, ramdisk_image, ramdisk_size);
+	if (ret)
+		panic("Copy RAMDISK failed\n");
 
 	printk(KERN_INFO "Move RAMDISK from [mem %#010llx-%#010llx] to"
 		" [mem %#010llx-%#010llx]\n",
diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index ca87a0939135..f7fb7205028d 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -251,6 +251,10 @@ static int __init extlog_init(void)
 	}
 
 	extlog_l1_hdr = acpi_os_map_iomem(l1_dirbase, l1_hdr_size);
+	if (!extlog_l1_hdr) {
+		rc = -ENOMEM;
+		goto err_release_l1_hdr;
+	}
 	l1_head = (struct extlog_l1_head *)extlog_l1_hdr;
 	l1_size = l1_head->total_len;
 	l1_percpu_entry = l1_head->entries;
@@ -268,6 +272,10 @@ static int __init extlog_init(void)
 		goto err;
 	}
 	extlog_l1_addr = acpi_os_map_iomem(l1_dirbase, l1_size);
+	if (!extlog_l1_addr) {
+		rc = -ENOMEM;
+		goto err_release_l1_dir;
+	}
 	l1_entry_base = (u64 *)((u8 *)extlog_l1_addr + l1_hdr_size);
 
 	/* remap elog table */
@@ -279,6 +287,10 @@ static int __init extlog_init(void)
 		goto err_release_l1_dir;
 	}
 	elog_addr = acpi_os_map_iomem(elog_base, elog_size);
+	if (!elog_addr) {
+		rc = -ENOMEM;
+		goto err_release_elog;
+	}
 
 	rc = -ENOMEM;
 	/* allocate buffer to save elog record */
@@ -300,6 +312,8 @@ static int __init extlog_init(void)
 	if (extlog_l1_addr)
 		acpi_os_unmap_iomem(extlog_l1_addr, l1_size);
 	release_mem_region(l1_dirbase, l1_size);
+err_release_l1_hdr:
+	release_mem_region(l1_dirbase, l1_hdr_size);
 err:
 	pr_warn(FW_BUG "Extended error log disabled because of problems parsing f/w tables\n");
 	return rc;
diff --git a/include/asm-generic/early_ioremap.h b/include/asm-generic/early_ioremap.h
index 9d0479f50f97..5db59a1efb65 100644
--- a/include/asm-generic/early_ioremap.h
+++ b/include/asm-generic/early_ioremap.h
@@ -35,7 +35,7 @@ extern void early_ioremap_reset(void);
 /*
  * Early copy from unmapped memory to kernel mapped memory.
  */
-extern void copy_from_early_mem(void *dest, phys_addr_t src,
+extern int copy_from_early_mem(void *dest, phys_addr_t src,
 				unsigned long size);
 
 #else
diff --git a/mm/early_ioremap.c b/mm/early_ioremap.c
index ce06b2884789..ff35b84a7b50 100644
--- a/mm/early_ioremap.c
+++ b/mm/early_ioremap.c
@@ -245,7 +245,10 @@ early_memremap_prot(resource_size_t phys_addr, unsigned long size,
 
 #define MAX_MAP_CHUNK	(NR_FIX_BTMAPS << PAGE_SHIFT)
 
-void __init copy_from_early_mem(void *dest, phys_addr_t src, unsigned long size)
+/*
+ * If no empty slot, handle that and return -ENOMEM.
+ */
+int __init copy_from_early_mem(void *dest, phys_addr_t src, unsigned long size)
 {
 	unsigned long slop, clen;
 	char *p;
@@ -256,12 +259,15 @@ void __init copy_from_early_mem(void *dest, phys_addr_t src, unsigned long size)
 		if (clen > MAX_MAP_CHUNK - slop)
 			clen = MAX_MAP_CHUNK - slop;
 		p = early_memremap(src & PAGE_MASK, clen + slop);
+		if (!p)
+			return -ENOMEM;
 		memcpy(dest, p + slop, clen);
 		early_memunmap(p, clen + slop);
 		dest += clen;
 		src += clen;
 		size -= clen;
 	}
+	return 0;
 }
 
 #else /* CONFIG_MMU */
-- 
2.25.1


