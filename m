Return-Path: <linux-arch+bounces-8985-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CCA9C4731
	for <lists+linux-arch@lfdr.de>; Mon, 11 Nov 2024 21:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ADEE1F230CB
	for <lists+linux-arch@lfdr.de>; Mon, 11 Nov 2024 20:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1595C1BB6BC;
	Mon, 11 Nov 2024 20:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="VkWEdnSP"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7F01B3F30
	for <linux-arch@vger.kernel.org>; Mon, 11 Nov 2024 20:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731358439; cv=none; b=Gi9bdPdV4L5XliGPcur+ZLDYRUfYztRsZbiPDs1mdvZZUGClRHTX+6WdCPSEsXFUKxxVQAfZnJLskRLzYaEtY2CpODMN3EJQMwHZV2XEYqQAaaH5ROkx7fmsx3GtsDY3Y2y93chD6WymUITDyILIscyC/0lH2oEcm1OQBa4+tFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731358439; c=relaxed/simple;
	bh=CMiPgPumnCnoSrycZat5YsbcVRmp/82gNFFmnfa+3aY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PNPYkN1lhTmCKUw7kmjMEZB5E9GowE66/389wGw1ST8qCV60Imd/bDPJb0w7FLDOeYuQyUl6YQpxk9yBXmZixGreUibq/G+p26Kdp6NDDkh0RRr3gKOBzN1Y5AdKudnWVDCBbYO2P+X46lm5v7o+F9uLTStLnghTnQguuxWZHUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=VkWEdnSP; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20cf6eea3c0so47318925ad.0
        for <linux-arch@vger.kernel.org>; Mon, 11 Nov 2024 12:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1731358437; x=1731963237; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ziaktb89WDbwUZ535GFbmTELWOQHyNOPVHZfKRHAH5o=;
        b=VkWEdnSPQq/ApwfbpfjUYlsTmhlgTnlIrpalVhb/n6TrzeDPTEIhhLFW9mUVJPavsD
         lFQnmI40IMo4qHa8Y85txInBPxKYqFWaKQl8bC+C6UE9Cao6E+WbBYFvYQUYCBOwd5pC
         lsJ4abDs5Pvs6MulP3iepun7NQUriKSsy27mZx4Ith+j16lbqeqV3fFa3w6MkaKMcXFV
         4GgUo7eMV0SkLgwOccVtMHTVca4NZMpkpUShbuhtCQtevAWhRsIlbFiZ8AroJa7gATG8
         lNONHY+MlN4/JhPRSFQ+O+Xka9l0zOdJP5Yvs86+AyzgG+WaJJuZIAwJEUDDUD69a3lD
         uAdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731358437; x=1731963237;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ziaktb89WDbwUZ535GFbmTELWOQHyNOPVHZfKRHAH5o=;
        b=kM+2e5YXJzQ2V8JTYy916O9uPFZwzD9UNhGYuuXmsX8OOVe7rYRjl+oatpDJkU1uvj
         PKBMqwx9VOCuS/g76i7FlEUgY47wW+GkhPFvYrq+dqaHGqLDVrdRqync1cfI1TCfznZZ
         mFlvmnr/98zXTbsj8x1WVR4/aYODFlaHOnd1z2DgyOOG3W0kAx9kYF9ptSekt3OW6ZJV
         yKoMcyPVWD87O4W94OraHTynEicckwtfJL6LKxwxePhrqLmlP54YgkXJravDNabgYned
         H4BXB16ypVQTg/eKdBlouLCfl80R4EEQwwcu57QjZ042Xqop9cMAKjztysJll/HDwf5H
         2a/A==
X-Forwarded-Encrypted: i=1; AJvYcCWDcCOnvuRvRm3uGNpLNcPTSggBYSqeTl2BpzAO8J2Pqm9pwmgghI188GutdwxmGeZ2r4qHhJVosBBP@vger.kernel.org
X-Gm-Message-State: AOJu0YxccpdN8JfvLCKMFeuc3M2vnm2uTI1S3iR/1wCHeQCzK6xTXqHz
	BOZnMVmFCmXpq00Rf8jbts3N4bYcUPlGlsm8hlO2oye5sUmJSUcppRLikDdshMo=
X-Google-Smtp-Source: AGHT+IEyGabgVA75UQcsueBpJ7RpOtRzKc95ETC4lvjZRAohKnXlL6Ozkv/pWiQeL+cJUAE6GKxHGg==
X-Received: by 2002:a17:902:db0b:b0:20b:5b16:b16b with SMTP id d9443c01a7336-2118359cb22mr204360415ad.36.1731358436616;
        Mon, 11 Nov 2024 12:53:56 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9a5fd1534sm9059974a91.42.2024.11.11.12.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 12:53:56 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 11 Nov 2024 12:53:46 -0800
Subject: [PATCH v8 01/29] mm: Introduce ARCH_HAS_USER_SHADOW_STACK
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-v5_user_cfi_series-v8-1-dce14aa30207@rivosinc.com>
References: <20241111-v5_user_cfi_series-v8-0-dce14aa30207@rivosinc.com>
In-Reply-To: <20241111-v5_user_cfi_series-v8-0-dce14aa30207@rivosinc.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>, 
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com, 
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com, 
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
 rick.p.edgecombe@intel.com, David Hildenbrand <david@redhat.com>, 
 Deepak Gupta <debug@rivosinc.com>, 
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
index 16354dfa6d96..fe6e9ece64b9 100644
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
index e52bd96137a6..f57ea9b308bb 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -978,7 +978,7 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
 #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
 		[ilog2(VM_UFFD_MINOR)]	= "ui",
 #endif /* CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
-#ifdef CONFIG_X86_USER_SHADOW_STACK
+#ifdef CONFIG_ARCH_HAS_USER_SHADOW_STACK
 		[ilog2(VM_SHADOW_STACK)] = "ss",
 #endif
 #if defined(CONFIG_64BIT) || defined(CONFIG_PPC32)
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 61fff5d34ed5..2291c02c74d2 100644
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


