Return-Path: <linux-arch+bounces-7524-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B498098C24F
	for <lists+linux-arch@lfdr.de>; Tue,  1 Oct 2024 18:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 729962848B6
	for <lists+linux-arch@lfdr.de>; Tue,  1 Oct 2024 16:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069361CBE86;
	Tue,  1 Oct 2024 16:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="L+gTsnYC"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438B61CB339
	for <linux-arch@vger.kernel.org>; Tue,  1 Oct 2024 16:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727798823; cv=none; b=Jrf6KWOb+B7rf8np0K9nJBVfxbj1+a4Xmk9JhxPAux7/yhNUvXQm/CO1J/RMPnGuMuWEP3cHT0SfTvpUDXKw1+y+07VSwlFNam8j+Up/J8Zu9T6gjhwZvW0ooKyrIM4vMst8XTCAQpZJvgPOyeQF2gOCiCzc6f7CZwebYm41I3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727798823; c=relaxed/simple;
	bh=UyWMIIBCmwkbjPM0A+FmTU87MU0ZGnNGDXu/rgKEGp8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UUtZY8bqJw2+KIeQQq1QZGYhabqhDSKh/7/fgDrD/iLWXPvY1x5aR/GZvvs0dpU5n5cD7GUzGr9+Uc0f7qXWSomkXhBIGID1CcVOUmChi5gwGepBQ7lQ3xIAYPEQwsbEx8ra1hC/rIg1p6rP41T9dZdwqYyVoQUtTKBP8g5qOgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=L+gTsnYC; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20b5affde14so25430135ad.3
        for <linux-arch@vger.kernel.org>; Tue, 01 Oct 2024 09:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1727798821; x=1728403621; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pcb1JUl7nxyzCR2L+K51gN2ROJJ8XrFInAPZeivTlr8=;
        b=L+gTsnYCu9stnnO17H/zQAfCHigLou3l1RHCrbc7E2KQD5cNhnEhRGGe0SZtfrTCUP
         4BM95mXYobeV3JJuyfXkdWjMaf1N7hgiZPiiIz3xWas7d8lVB8CYdun2yg0XLLm2pU+Y
         SMCi2X4msSYvpuBtPFBEdSI4WGkvJYFL0aEiCRyWXZF9N9tcJVCKIHNeVV9L59LmgSWw
         f3AbHV5WlGRMrNhuLcEgCvXzIW3320P6RoZgO6edfpI5w6BiqIfrp4OAF9Q1DaIT/CKs
         SpwElHcYOMmK6tr/V6PYRlIGtN7JOrog8mS93mVucZReZ6L8Kws1NXocJz2LmpIDauTW
         dXBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727798821; x=1728403621;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pcb1JUl7nxyzCR2L+K51gN2ROJJ8XrFInAPZeivTlr8=;
        b=Z26WTxZ8yQVS1RH9/FrfIqG97HEi72pgaDPKnd8taWeBQVHMeCN5NDMYj1n9Yo4aPC
         2paEXt/qFa30iJXHl+q48mso4oujgsXfFgYRhveJ46iW2xLT9cfnU2Zhn8pvdDsRBhRn
         LrtUuxckARZqvzxms7WCBpfqdeOt9Wvkzpc5NoAebgdP9HYMNEompJlPT9oNAk7q7/C/
         MzHEAbj/GhcVBDdu6f5bZO0GaaTPXI9I2YPhUd7h60tLQlh+/fnr2Tndeax8yvhLp+CA
         lxgX0O1HEF7mZ85KZ5ltfdW7WKKhsiqbLtW2JlhK+2hRcPdxhKDnUk+V/gbwlm/32YYw
         0Qlg==
X-Forwarded-Encrypted: i=1; AJvYcCXvAEINHuwFSy6fAzPBoO/oM7M5U52ss+y7a5hqkYSETF3hSuNRsTBIe53jLscfoVrN8TfBrSW4MMAC@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4Fn3ulz/pGgIXPyE0jj0R6pmhbgLLrtU3yNUPWHY/aYnnX9hI
	Bz9hKNN9qIeKARC5nqwDrBhIqJz8kiW9wcxNdxWnJ01O4G9IWAy4k2Ipgk9dsxI=
X-Google-Smtp-Source: AGHT+IG/9AhOFkVlsb1ZH2XMKlQ6f717lLd7IRjhRM+ZTMobdV3S8kdqvcOsBq5NGgSC9+zelAG6Ow==
X-Received: by 2002:a17:90a:650c:b0:2cc:ff56:5be1 with SMTP id 98e67ed59e1d1-2e184526f71mr233618a91.7.1727798821325;
        Tue, 01 Oct 2024 09:07:01 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e06e1d7d47sm13843973a91.28.2024.10.01.09.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 09:07:00 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Tue, 01 Oct 2024 09:06:06 -0700
Subject: [PATCH 01/33] mm: Introduce ARCH_HAS_USER_SHADOW_STACK
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-v5_user_cfi_series-v1-1-3ba65b6e550f@rivosinc.com>
References: <20241001-v5_user_cfi_series-v1-0-3ba65b6e550f@rivosinc.com>
In-Reply-To: <20241001-v5_user_cfi_series-v1-0-3ba65b6e550f@rivosinc.com>
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
 rick.p.edgecombe@intel.com, Deepak Gupta <debug@rivosinc.com>, 
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


