Return-Path: <linux-arch+bounces-8009-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1AD9997F4
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2024 02:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6E00282985
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2024 00:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46942F507;
	Fri, 11 Oct 2024 00:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="LrDx79Dk"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EED747F
	for <linux-arch@vger.kernel.org>; Fri, 11 Oct 2024 00:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728606745; cv=none; b=fPhC3DxDkTqHmqt/wgpdA7L/MjpuVG+livF9lvEprS41M2R2U3usH7FSknzMWBI8RnZC2q+Pbmkiie19Bbf+YejauW/BR47B7V4YVxd/MN/i2rKejBMVbui9+WiNowUeL6sIe6quQeF40FTNqgJ4uLiH4ky+ha/HLAAnr8a1Tyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728606745; c=relaxed/simple;
	bh=UyWMIIBCmwkbjPM0A+FmTU87MU0ZGnNGDXu/rgKEGp8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g5Wh0JIaUXwdvBpesMO3HX735DffK0ju/d1Vom7pg75E2NY5rJXbLj/sc59ai0dd9iYJEiGNaePTrTn0vlHpA1qfQsriYNeOYaWNp7wrsmH/SsLD+wcy2FOE7y1WPWxiEAV+TUBTLI/Rbu84YlH4zwPyV/5x+YBMI6MRP46sb4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=LrDx79Dk; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71dfc78d6ddso1380606b3a.0
        for <linux-arch@vger.kernel.org>; Thu, 10 Oct 2024 17:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1728606742; x=1729211542; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pcb1JUl7nxyzCR2L+K51gN2ROJJ8XrFInAPZeivTlr8=;
        b=LrDx79DkE5kkxe8AIxK1FbyJMJ55ltQH3yftF8CJwC1cKU3ShVXF+kSFd/ZH7rn6DA
         B9jq3ISVBRMoPCVZnp60vR12xlmV5JtTCWJDaL1+p8qYuT9ScGwXkLPB28hcsaIr/8HH
         FzxPkt+JJw/FGTq5OfRwFvg3TsRqRYljLjsMa3ndOZZ3qH+SzLkrYpQRqoJLQvn6oZBh
         5hNzs/zPF77UUOVq2vmgoWgSg1IPYQfs+Jsfo7vMKAjKm2/A7G24QYWjRj19XdtH831i
         ofQRo6rryrHjre1nLSVBlQSCguTBqxMR541h2ipzLzWOrBt76b0aLGt1mTuRiBU/g1oJ
         6ukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728606742; x=1729211542;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pcb1JUl7nxyzCR2L+K51gN2ROJJ8XrFInAPZeivTlr8=;
        b=xLZYxkzoNfg0+Zxxo2av7OIbek5omYLQ4e3LnzsAA/m4TOf66wn2h9F+c+TB9uU3di
         dOZIfO+ejSRnUBecQY69kCXL2I4z+vZz8jB3mXz5i2tVYXZOjGo3rmAeDTq7WR7GBj7M
         ulBs6hQlDQ1JaBym+xcZXq4uYcvtqOeF3ychRjOLmObqhqOU0GESOP+EayS1Px3JrTWH
         KazU4zosbutW+d9v5xm4FUaOV44jqr50ME4JhtRp0iTOjPeMEAPH+EhMreI3ZTVfxVaE
         xs9buADZ+j3lvvWqJWpQZcbA5Q734UCx/cnKbktNEvYMlLvdnt0ZIAfqhyxo8I8Efdwn
         Outw==
X-Forwarded-Encrypted: i=1; AJvYcCXFCaRX8M5elaUzXJIDfTuJhFvFU/z7rPgf91j+7doibZ0LanLfl+FwqwpRG4/UBP0Rf6joFUQZY0jk@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdb+YYkc/yK2agGqIARY+UFkH7nX5219mpGhM938OwTzabyC7P
	2Zab/4jDyUXZIuYrb5kGlUo68h2szbJQw+HAlhZr6wgZnx7Y/wS3LFX/E7pbUe0=
X-Google-Smtp-Source: AGHT+IFSf80aIAMN4Fscyo/d2B9xB9WQkYt/Q471M36cO+ATFH/XCXiTEEuhz953CSaf5qR503Upaw==
X-Received: by 2002:a05:6a00:14ce:b0:71e:cd0:cc99 with SMTP id d2e1a72fcca58-71e37e2d6admr1520196b3a.4.1728606741623;
        Thu, 10 Oct 2024 17:32:21 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea4496b1afsm1545600a12.94.2024.10.10.17.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 17:32:21 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 10 Oct 2024 17:32:03 -0700
Subject: [PATCH RFC/RFT 1/3] mm: Introduce ARCH_HAS_USER_SHADOW_STACK
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241010-shstk_converge-v1-1-631beca676e7@rivosinc.com>
References: <20241010-shstk_converge-v1-0-631beca676e7@rivosinc.com>
In-Reply-To: <20241010-shstk_converge-v1-0-631beca676e7@rivosinc.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-arch@vger.kernel.org, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Mark Brown <broonie@kernel.org>, Deepak Gupta <debug@rivosinc.com>, 
 David Hildenbrand <david@redhat.com>, 
 Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
X-Mailer: b4 0.14.0

From: Mark Brown <broonie@kernel.org>

Since multiple architectures have support for shadow stacks and we need to
select support for this feature in several places in the generic code
provide a generic config option that the architectures can select.

Suggested-by: David Hildenbrand <david@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Deepak Gupta <debug@rivosinc.com>
Reviewed-by: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
---
 arch/x86/Kconfig   | 1 +
 fs/proc/task_mmu.c | 2 +-
 include/linux/mm.h | 2 +-
 mm/Kconfig         | 6 ++++++
 4 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2852fcd82cbd..8ccae77d40f7 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1954,6 +1954,7 @@ config X86_USER_SHADOW_STACK
 	depends on AS_WRUSS
 	depends on X86_64
 	select ARCH_USES_HIGH_VMA_FLAGS
+	select ARCH_HAS_USER_SHADOW_STACK
 	select X86_CET
 	help
 	  Shadow stack protection is a hardware feature that detects function
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 72f14fd59c2d..23f875e78eae 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -971,7 +971,7 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
 #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
 		[ilog2(VM_UFFD_MINOR)]	= "ui",
 #endif /* CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
-#ifdef CONFIG_X86_USER_SHADOW_STACK
+#ifdef CONFIG_ARCH_HAS_USER_SHADOW_STACK
 		[ilog2(VM_SHADOW_STACK)] = "ss",
 #endif
 #if defined(CONFIG_64BIT) || defined(CONFIG_PPC32)
diff --git a/include/linux/mm.h b/include/linux/mm.h
index ecf63d2b0582..57533b9cae95 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -354,7 +354,7 @@ extern unsigned int kobjsize(const void *objp);
 #endif
 #endif /* CONFIG_ARCH_HAS_PKEYS */
 
-#ifdef CONFIG_X86_USER_SHADOW_STACK
+#ifdef CONFIG_ARCH_HAS_USER_SHADOW_STACK
 /*
  * VM_SHADOW_STACK should not be set with VM_SHARED because of lack of
  * support core mm.
diff --git a/mm/Kconfig b/mm/Kconfig
index 4c9f5ea13271..4b2a1ef9a161 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1296,6 +1296,12 @@ config NUMA_EMU
 	  into virtual nodes when booted with "numa=fake=N", where N is the
 	  number of nodes. This is only useful for debugging.
 
+config ARCH_HAS_USER_SHADOW_STACK
+	bool
+	help
+	  The architecture has hardware support for userspace shadow call
+          stacks (eg, x86 CET, arm64 GCS or RISC-V Zicfiss).
+
 source "mm/damon/Kconfig"
 
 endmenu

-- 
2.45.0


