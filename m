Return-Path: <linux-arch+bounces-7850-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7C5995A37
	for <lists+linux-arch@lfdr.de>; Wed,  9 Oct 2024 00:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C2462863BB
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 22:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BC3218597;
	Tue,  8 Oct 2024 22:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="1iFoS2IK"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FA12178E4
	for <linux-arch@vger.kernel.org>; Tue,  8 Oct 2024 22:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728427075; cv=none; b=CUvlzMBB6O/Ede6QJumzFnstBSJKrWuRSGhF0gVVy4MWXE+HP2soFLcAX47wM2bxN5C+GIO5kfJkegwAJEQIMjtagwaQxzGFPsSl5mlMyt6a6LK1fBiYkj4GUGFNsGm0KSgwoP69tNDHEl3K4O+Fu2bE3LmpAfHDnc5ViAEP37A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728427075; c=relaxed/simple;
	bh=zXJMeVCU0/xR62pDJCipOAYdaSp2CdjUA0XW8sGT2qU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qj0kZen22sCSNuupeCWs2Yb7/x1VucHq6wppP1Rs9iDxJqISdMK70WwZzp4FXFZEUH5PXiBEj7YRBpGfaXlmNx+snD0dNsq0TBlvbEXG8GGJwm3RvozRYmB+yyVJo3k38GRN7j8M84oqpSm90K59PrrnlrIguMG6iGpJwT51EBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=1iFoS2IK; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71dfccba177so255494b3a.0
        for <linux-arch@vger.kernel.org>; Tue, 08 Oct 2024 15:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1728427072; x=1729031872; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OwXMBbOWCv06xRC7kuAtikxfL3CuNBKfrSTtPkKqEqk=;
        b=1iFoS2IKDK81u+aY5ToliWmDLYvXSb2gqeFKQedOlf4T43fZ/66zyVp4S/zTZNyw66
         oTUPG4W+ivNE+SwjYpSGIvv8aAXt5AvINbtZG3sG1bLUDyofcgkNeBGhfAn0/69zRiDA
         QJgUEVXOtgnDUiT+D6HJBX046vh9M49RZ58VOiSUJ8vmNq4euviwGJ1Ms01M/AjMM9SJ
         Rd7Inv4CnEYaLRBO/tEmP1rYacDygUQbiLqHH0RPlGnNZC/z4FrnSbkd+oZ7yhwGd2Nb
         qUpDjIOdB4QDsRBdT2mC1k5oZFdykEl9u5uYP8IO/vqzJ12DXq7eeMIE5nF+0TICHHZU
         g3KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728427072; x=1729031872;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OwXMBbOWCv06xRC7kuAtikxfL3CuNBKfrSTtPkKqEqk=;
        b=FSW0lexrWJvhG+DfvLA7+c2D/QYw5v90yfQOhVGjeyHux9cEPcUz9Bbrq2heNV0n25
         WYSTBPtoY/sxBAB0qE3HXFOYkrF8YNRtdFXesIIB7kbgJ4pXoY5OMiMwWigPMximlW4a
         X1nmQpfLxmaifbjRKw/4wWvUTMfma2VMp98EKiIhD1LghzilbXPrsw+JH5IuRlzyNyxz
         rivL3BJqdpPrLXSOEt9w17OX/BYVrChyhCLd3GC72GlqA3yWdUQXWGQ9J8Z9V0uCjN7Z
         FzMgZdJgpeapZOpWNMJnL3SozkMP4ysahU2bcNkPrhEhvbIjQ+0FgAkZTAFGPASoeY5I
         S5MQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUxIZt2VyDqx/yqU8TaSc9DFuotgQqMzVtluFucUvfUW1gIurU1+s9qxOdcLoTyNNpskuhzuhZTfO4@vger.kernel.org
X-Gm-Message-State: AOJu0YzjwaZifk+iv1kLUnvSHWSM6NaEV5KrSmFQRdotdGJ3rO3Z+ORY
	6Sm5C4dJDQXTmbb6Kvfmg4B3YH0z3NV/1hJR5wV21SHkDa1rlnAVX1p1x5YQdnk=
X-Google-Smtp-Source: AGHT+IE674Tlfxux7he+iKObmN4Z/Vy2GyXvFfvVMkaZszYDuFORWLn02mu8lREUGmUPEtmKzi9hiA==
X-Received: by 2002:a05:6a00:c94:b0:71d:f2e1:f02b with SMTP id d2e1a72fcca58-71e1048dfadmr8990425b3a.2.1728427072537;
        Tue, 08 Oct 2024 15:37:52 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0ccc4b2sm6591270b3a.45.2024.10.08.15.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 15:37:52 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Tue, 08 Oct 2024 15:36:44 -0700
Subject: [PATCH v6 02/33] mm: helper `is_shadow_stack_vma` to check shadow
 stack vma
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241008-v5_user_cfi_series-v6-2-60d9fe073f37@rivosinc.com>
References: <20241008-v5_user_cfi_series-v6-0-60d9fe073f37@rivosinc.com>
In-Reply-To: <20241008-v5_user_cfi_series-v6-0-60d9fe073f37@rivosinc.com>
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


