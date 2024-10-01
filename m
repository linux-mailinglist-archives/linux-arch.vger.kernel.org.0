Return-Path: <linux-arch+bounces-7525-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF3498C256
	for <lists+linux-arch@lfdr.de>; Tue,  1 Oct 2024 18:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E68C81C24248
	for <lists+linux-arch@lfdr.de>; Tue,  1 Oct 2024 16:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C480B1CBEBA;
	Tue,  1 Oct 2024 16:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="KgfDwByT"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9831CBEA2
	for <linux-arch@vger.kernel.org>; Tue,  1 Oct 2024 16:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727798826; cv=none; b=O7U45X7i9SseYFemAAtu0FiS4oVc6+WEt/7ISxpdCcgu+M5UNW4RTO8rss3t4Q2Mhsad7sAFDN/DnxvRubjR53/aYy5TQABeIovDMrY2UlAyY1duZS10EWYZznXLwYOg+2NAAxasQxaJVD9SoQTnC0hjsxBDH2F1QT3ziTqxwKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727798826; c=relaxed/simple;
	bh=zXJMeVCU0/xR62pDJCipOAYdaSp2CdjUA0XW8sGT2qU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hnzrtnBqfRXpGMFYRCFGA2sE3F6bgtU6RFVC/HExSHIyNVl2elbuQu3gAQhlTXxagvSFjCMZ7G5vSsWzh/XOCZLJPtin1k6ZM+9s+kPtmyXHGAaPlhgKX9noMdlewYh8MfMirq3zOAUS6wEYEJh1683nawcCUJgPNm7sQYPQIpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=KgfDwByT; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20b0b5cdb57so45641475ad.1
        for <linux-arch@vger.kernel.org>; Tue, 01 Oct 2024 09:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1727798824; x=1728403624; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OwXMBbOWCv06xRC7kuAtikxfL3CuNBKfrSTtPkKqEqk=;
        b=KgfDwByTMD8OHWAsaLGjK8QtVjQvdUM5eChWkTv0hEKJM/Bvl8xKllgVVI8GxeBP+n
         rykimy4BEg9O5Uq1wlbUuo4E8x2UJM8Q0T6VaKlaAUkKwNzcKswAmxT5urgZbtUG/zrH
         PHV2e34yOm07GJrCyQc3RWia0lmYp4JGJsg8HedtaSxuYZm5R2QQQuIBEbLVsoOWk4Hu
         3xNMLB5+gYDxY0b85oUR+xpaTRmNwGj/SE1BMfVS+fVlspdbRIaItCh8GwhXzbsHimVZ
         2BruALFbLjlU6o9/UcGegz/96XqzsjAXfEoyzV4GWN456yEnKJSozouXZN85cc0mJqK9
         yXDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727798824; x=1728403624;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OwXMBbOWCv06xRC7kuAtikxfL3CuNBKfrSTtPkKqEqk=;
        b=jQYBvigj1vqrS56kZwgVzTyNoerdVJR+m8i+qzKqlf62mWS5DNlgL4QZRRj4hv577s
         y23zR1SXp+Qvx+pVXIQB/6QFaXV+JiIo4cZBsYE/bRQa57zTh4wLshJCF6kzvdfN0n5h
         q+9kXThTJ25EVV5Gy9VKZLK2AQTxJl2axRpzWfKQbxlSlCIZpyC7gUgdVKnm2+IUFxBK
         UgQEKU3V0UaYh93HQJJlb6zVFiyjP+R4uxYgOB0AWAXXkuUKEczAc6CWOZwQviTFIHED
         Od/aawO8SSnFo211aagDhM2bICjMlVCXjiUULwqu3UIg6qGfvfxfYUmJ1T0GD2c7A2qe
         5x6g==
X-Forwarded-Encrypted: i=1; AJvYcCXvcLaPB+7Kfg5hwoeA97+zsIskK/BJc0fMWgHw2I/rh3S6ZTEIeVv5+u2o0oCaQpFMtjZX7RBT6CoZ@vger.kernel.org
X-Gm-Message-State: AOJu0YylT4uNNFkjuG+P1YIhovuAlXnXCJGbS8E9EniCHz9t5DKORm7o
	rfmJkxYHHzRur5cTntFNIopfMe1fRY9iEJum1D5L5pQI7mA5OeDjEzFq/Hl5NvU=
X-Google-Smtp-Source: AGHT+IHz3lo2CWK5+xlTScPaDZKtUmo8trno2Ltv0riHEvGYwt0AENfouR5jnL074g0esmpKOm5AYw==
X-Received: by 2002:a17:90b:154:b0:2d8:e6d8:14c8 with SMTP id 98e67ed59e1d1-2e1853e1474mr122588a91.15.1727798824224;
        Tue, 01 Oct 2024 09:07:04 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e06e1d7d47sm13843973a91.28.2024.10.01.09.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 09:07:03 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Tue, 01 Oct 2024 09:06:07 -0700
Subject: [PATCH 02/33] mm: helper `is_shadow_stack_vma` to check shadow
 stack vma
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-v5_user_cfi_series-v1-2-3ba65b6e550f@rivosinc.com>
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
 rick.p.edgecombe@intel.com, Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.14.0

VM_SHADOW_STACK (alias to VM_HIGH_ARCH_5) is used to encode shadow stack
VMA on three architectures (x86 shadow stack, arm GCS and RISC-V shadow
stack). In case architecture doesn't implement shadow stack, it's VM_NONE
Introducing a helper `is_shadow_stack_vma` to determine shadow stack vma
or not.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 mm/gup.c |  2 +-
 mm/vma.h | 10 +++++++---
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index a82890b46a36..8e6e14179f6c 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1282,7 +1282,7 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
 		    !writable_file_mapping_allowed(vma, gup_flags))
 			return -EFAULT;
 
-		if (!(vm_flags & VM_WRITE) || (vm_flags & VM_SHADOW_STACK)) {
+		if (!(vm_flags & VM_WRITE) || is_shadow_stack_vma(vm_flags)) {
 			if (!(gup_flags & FOLL_FORCE))
 				return -EFAULT;
 			/* hugetlb does not support FOLL_FORCE|FOLL_WRITE. */
diff --git a/mm/vma.h b/mm/vma.h
index 819f994cf727..0f238dc37231 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -357,7 +357,7 @@ static inline struct vm_area_struct *vma_prev_limit(struct vma_iterator *vmi,
 }
 
 /*
- * These three helpers classifies VMAs for virtual memory accounting.
+ * These four helpers classifies VMAs for virtual memory accounting.
  */
 
 /*
@@ -368,6 +368,11 @@ static inline bool is_exec_mapping(vm_flags_t flags)
 	return (flags & (VM_EXEC | VM_WRITE | VM_STACK)) == VM_EXEC;
 }
 
+static inline bool is_shadow_stack_vma(vm_flags_t vm_flags)
+{
+	return !!(vm_flags & VM_SHADOW_STACK);
+}
+
 /*
  * Stack area (including shadow stacks)
  *
@@ -376,7 +381,7 @@ static inline bool is_exec_mapping(vm_flags_t flags)
  */
 static inline bool is_stack_mapping(vm_flags_t flags)
 {
-	return ((flags & VM_STACK) == VM_STACK) || (flags & VM_SHADOW_STACK);
+	return ((flags & VM_STACK) == VM_STACK) || is_shadow_stack_vma(flags);
 }
 
 /*
@@ -387,7 +392,6 @@ static inline bool is_data_mapping(vm_flags_t flags)
 	return (flags & (VM_WRITE | VM_SHARED | VM_STACK)) == VM_WRITE;
 }
 
-
 static inline void vma_iter_config(struct vma_iterator *vmi,
 		unsigned long index, unsigned long last)
 {

-- 
2.45.0


