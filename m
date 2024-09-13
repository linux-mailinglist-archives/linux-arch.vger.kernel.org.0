Return-Path: <linux-arch+bounces-7253-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 551A79774C5
	for <lists+linux-arch@lfdr.de>; Fri, 13 Sep 2024 01:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDDB1285E67
	for <lists+linux-arch@lfdr.de>; Thu, 12 Sep 2024 23:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988B21C3F11;
	Thu, 12 Sep 2024 23:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="RfGRxe+W"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F12B1C3F02
	for <linux-arch@vger.kernel.org>; Thu, 12 Sep 2024 23:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726183032; cv=none; b=LZf7mzcmbM3t7Uh0fhSANrw75tSLwSSuH6/7CetObakf4RR7mPrTm2mWc3Zy72H4/ndonJzBE/vLTRGFzm3XhZUlnS5JuCBe8CzlKzsWtiA3I4WLX5ELxssc+vbKfd8LqT8U45+AvivGaz7DEYf3ynaq0ZUl3ES6/r0JSmarbOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726183032; c=relaxed/simple;
	bh=6wEksoyf/wCrFvWsPZmk7PaqpjJJV/43ZtHDQEhD3lU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EBTNCjsWHrcWX4rFkJ1uD24X5xzKT5gVMH6Ie5DD5IrDtIcnqbZ8S0jU5K1T2TD/KWgTg2A4nP+i2/gAzZmp+kf5O0WkoFEiNIxcOdHzJ70HaiPeJaX1L0Tl7Moou4gb2Qu/CirXRYwD6Oo5mY+Y2A5Hk0FgdFU5OZbwMzeALZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=RfGRxe+W; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2da4e84c198so1123230a91.0
        for <linux-arch@vger.kernel.org>; Thu, 12 Sep 2024 16:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726183030; x=1726787830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nw1dKcVSLCCt5un4d6VomXZplHXDD/4tgdiLE024NX8=;
        b=RfGRxe+WoB19W27zn+WrjZ+fPVd+s2WjyD91YZU70Wp8lfNKMvgxE3y+eUzYgfqKER
         r0Mekb+dY4xziEvrFi1M5Tnzed/YjNdHGOBNnZwrVTw9/JkRkIXY2+xXn2oZqwOgNn1e
         Uefks4sy6wqfq4pye4FMP36eCbzYj7VfAt/nqv6RsU3fUK4k4qkKudFRS+xas5v+8n2j
         MRDebfXOjj0vnCSJYBQ0kkWty5cWcpIW66Ww4aQKDcFAkkBzHnqHVnqo0iBM4R9Oupjg
         bTGjKs+2pm1K0uT7QYKAz7Ju/wBFIjrcqyigRnhmj251TYH2OeOPnZSSUkBDdGWntEtx
         +h9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726183030; x=1726787830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nw1dKcVSLCCt5un4d6VomXZplHXDD/4tgdiLE024NX8=;
        b=AlEjzGzD6mTSZzKT/Jf0cGEgpwHUvt7RAYpJ7m8nwSpl+xrO9/L3qHjjltKAhryvsA
         ivCnfEOx6C7THP6IVoUGaQ1rzlo7lJBvjv72Cugtnvi4T1urwCdlARn7GJ/C0dJ3ekNF
         R7T48d+WwNPc1XW+GPXYBQ9KMEOLX6KjMk1Xhv26v0YlYXm5Y53q4fr+3nKz/ZhNsSEg
         5+cCSF3nTLFAs8+ps9OEvtBIFEbtI+I3FymCepJuDu42ZFWOw0K/uonxjmeFzP/flleo
         tyJjzjySRBac6qVbENw84dnfwK0alINxgwkFV1TkvZUFgY6jV2EZ/d9QdN1M6L5/H9rC
         MM5A==
X-Forwarded-Encrypted: i=1; AJvYcCWkVVyOb6yLLMjxsE7lneuSmb3/VvoY83zCUsiWSOr+87d8XxAi5367DFDDyV9dwMkChlLfwzVCDxPN@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ2fG3zKMwpKJXsyOvhco0flsXtZOyEedQ2IrF8NVFtTv3AIEG
	hIkRL38iccDgDmSOyCGYZpDxTuhAM+yzs4LtbGg31uuXjP/wul4Y9NXSxkTpKT8=
X-Google-Smtp-Source: AGHT+IHV0R4LSdRMN0UeGhZXF9FypysCDDOC5LIEh5xrA8oVwZ2edglc2TZ3k8QjvVsKUPvcjGWQgQ==
X-Received: by 2002:a17:90b:17cb:b0:2d8:e7db:9996 with SMTP id 98e67ed59e1d1-2db9ff93f7amr4718623a91.13.1726183029966;
        Thu, 12 Sep 2024 16:17:09 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db6c1ac69asm3157591a91.0.2024.09.12.16.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 16:17:09 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: paul.walmsley@sifive.com,
	palmer@sifive.com,
	conor@kernel.org,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: corbet@lwn.net,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	robh@kernel.org,
	krzk+dt@kernel.org,
	oleg@redhat.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	peterz@infradead.org,
	akpm@linux-foundation.org,
	arnd@arndb.de,
	ebiederm@xmission.com,
	kees@kernel.org,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	lorenzo.stoakes@oracle.com,
	shuah@kernel.org,
	brauner@kernel.org,
	samuel.holland@sifive.com,
	debug@rivosinc.com,
	andy.chiu@sifive.com,
	jerry.shih@sifive.com,
	greentime.hu@sifive.com,
	charlie@rivosinc.com,
	evan@rivosinc.com,
	cleger@rivosinc.com,
	xiao.w.wang@intel.com,
	ajones@ventanamicro.com,
	anup@brainfault.org,
	mchitale@ventanamicro.com,
	atishp@rivosinc.com,
	sameo@rivosinc.com,
	bjorn@rivosinc.com,
	alexghiti@rivosinc.com,
	david@redhat.com,
	libang.li@antgroup.com,
	jszhang@kernel.org,
	leobras@redhat.com,
	guoren@kernel.org,
	samitolvanen@google.com,
	songshuaishuai@tinylab.org,
	costa.shul@redhat.com,
	bhe@redhat.com,
	zong.li@sifive.com,
	puranjay@kernel.org,
	namcaov@gmail.com,
	antonb@tenstorrent.com,
	sorear@fastmail.com,
	quic_bjorande@quicinc.com,
	ancientmodern4@gmail.com,
	ben.dooks@codethink.co.uk,
	quic_zhonhan@quicinc.com,
	cuiyunhui@bytedance.com,
	yang.lee@linux.alibaba.com,
	ke.zhao@shingroup.cn,
	sunilvl@ventanamicro.com,
	tanzhasanwork@gmail.com,
	schwab@suse.de,
	dawei.li@shingroup.cn,
	rppt@kernel.org,
	willy@infradead.org,
	usama.anjum@collabora.com,
	osalvador@suse.de,
	ryan.roberts@arm.com,
	andrii@kernel.org,
	alx@kernel.org,
	catalin.marinas@arm.com,
	broonie@kernel.org,
	revest@chromium.org,
	bgray@linux.ibm.com,
	deller@gmx.de,
	zev@bewilderbeest.net,
	Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH v4 01/30] mm: Introduce ARCH_HAS_USER_SHADOW_STACK
Date: Thu, 12 Sep 2024 16:16:20 -0700
Message-ID: <20240912231650.3740732-2-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240912231650.3740732-1-debug@rivosinc.com>
References: <20240912231650.3740732-1-debug@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mark Brown <broonie@kernel.org>

Since multiple architectures have support for shadow stacks and we need to
select support for this feature in several places in the generic code
provide a generic config option that the architectures can select.

Suggested-by: David Hildenbrand <david@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Deepak Gupta <debug@rivosinc.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/x86/Kconfig   | 1 +
 fs/proc/task_mmu.c | 2 +-
 include/linux/mm.h | 2 +-
 mm/Kconfig         | 6 ++++++
 4 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 007bab9f2a0e..320e1f411163 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1957,6 +1957,7 @@ config X86_USER_SHADOW_STACK
 	depends on AS_WRUSS
 	depends on X86_64
 	select ARCH_USES_HIGH_VMA_FLAGS
+	select ARCH_HAS_USER_SHADOW_STACK
 	select X86_CET
 	help
 	  Shadow stack protection is a hardware feature that detects function
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 5f171ad7b436..0ea49725f524 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -984,7 +984,7 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
 #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
 		[ilog2(VM_UFFD_MINOR)]	= "ui",
 #endif /* CONFIG_HAVE_ARCH_USERFAULTFD_MINOR */
-#ifdef CONFIG_X86_USER_SHADOW_STACK
+#ifdef CONFIG_ARCH_HAS_USER_SHADOW_STACK
 		[ilog2(VM_SHADOW_STACK)] = "ss",
 #endif
 #ifdef CONFIG_64BIT
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 147073601716..e39796ea17db 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -346,7 +346,7 @@ extern unsigned int kobjsize(const void *objp);
 #endif
 #endif /* CONFIG_ARCH_HAS_PKEYS */
 
-#ifdef CONFIG_X86_USER_SHADOW_STACK
+#ifdef CONFIG_ARCH_HAS_USER_SHADOW_STACK
 /*
  * VM_SHADOW_STACK should not be set with VM_SHARED because of lack of
  * support core mm.
diff --git a/mm/Kconfig b/mm/Kconfig
index b72e7d040f78..3167be663bca 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -1263,6 +1263,12 @@ config IOMMU_MM_DATA
 config EXECMEM
 	bool
 
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


