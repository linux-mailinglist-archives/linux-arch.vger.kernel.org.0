Return-Path: <linux-arch+bounces-8994-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E08AD9C475B
	for <lists+linux-arch@lfdr.de>; Mon, 11 Nov 2024 21:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7354C1F2118E
	for <lists+linux-arch@lfdr.de>; Mon, 11 Nov 2024 20:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C8A1CB305;
	Mon, 11 Nov 2024 20:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="MVYSHO6S"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD4C1C9ED8
	for <linux-arch@vger.kernel.org>; Mon, 11 Nov 2024 20:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731358463; cv=none; b=Rc28BQ5N21RUUmb8Btb9yFrJO7CGnyb80bMbCHJhgJGpJPvwL8Ur623UVkGJnlujSIm9/gtV9RHbkSKE17SsMZHSwk3x680v5jXnJVoEaL2mYTsMbpDwBt6bhUneB7+qIEPsrXNp/jXqnPCvnxTzWMNlf41C/YJKd4L2+cf8gdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731358463; c=relaxed/simple;
	bh=vaFWjXy2DRrsSIuTbWduvBr7Hy/qYsbzVGbusd1hcYE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j1eBwEQx8VcAixs2l/uf19smYofuPoZjXEMnjlsr9VNqn4E42O0a8KvuNuQJSYBxP6OZA7PbZdG3bNcQXCKlv1q/gbsOHEs2ZOzFes6zsF3FILpJLqn+HOl9k/SeH45NOSxoJisA5daiU71HEUN7TtTsB7OAcC8qM/FIOgUFpH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=MVYSHO6S; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7f43259d220so2411736a12.3
        for <linux-arch@vger.kernel.org>; Mon, 11 Nov 2024 12:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1731358461; x=1731963261; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AMPZIqdzSjfHq7xJb4YaIgEu2GPeUmiCYK4jkAGMc38=;
        b=MVYSHO6SMurY2DIdwsLsSIPuG54P1l5d2Ka365mzBMpQLjyLXpZx/GSCvGqcjr5hXH
         Qa6/pO8sA8pDKeSUfI1x4hp5Iv3+RzbfQ9TYjSUPPHZh9Y8Z+rGT90YoyKFOVvy+g+hy
         Nm/f8+HyzM9xudplRoj0uqrWgYeWJD+LUbCY3nLo/fJTBrvyNoiNv+5IT+W4MEvGXub2
         WgVmKNHYI9F5qk+cVn6YF8RaOUUDNkyaGI3KE+YM2xPhAZMkhUEFFKPAtQvC3UvVJVK1
         3HEVNMDe+7Z9DgWS6+B3nMvSJqM630VuOOqCm8k7OShjor7BZWogzGWbZB/Ep+jKj1MC
         0MxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731358461; x=1731963261;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AMPZIqdzSjfHq7xJb4YaIgEu2GPeUmiCYK4jkAGMc38=;
        b=Q4ZBmGLSLCvSPUFfgJ8rmURvOkYbzrD7IJT/1EYNH9kgPZfJwQpZeVfKS6cv8b28Yr
         TA2hIk8RqNXuf2eBfPUsVhPXYm0pgG+jlIwaDDlrOMFt8DmCMG1flGGp6LNA+e/oaW6L
         YbB/N9A7Va7ooBOjIXaSjd4aGV7MshLC26+lrotkNBX7cwvvRWNYh0MMMxrmg7mP/26P
         PHwF53AlS9Vfx0WQn6aKgeeMrY+s3loRyVh2o/mVI9RMQ/gFavDDhVxlIMZuDWg8ryYu
         dw0ScwMxGF1ZtP4X5hsk75yH+iltCCCrmQsTVhRhZjGF+4pJEUXXlBi3BpTHrkwFIV4r
         mRIg==
X-Forwarded-Encrypted: i=1; AJvYcCWN3gc+T8LO/Gjp3AQasHRFQsUdx/AHzYwAeyC6NZn9z715/tJh3yVUgIe91FQxUtXzeJzrh2FE0a74@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsw0j2Hx7aeciZoBRGVmU2QZMCiMOKzjxONJVbzsq280P0oqUC
	0+JdIMRh8qE4h3IquXBhsJFVjT6wuBlnbB1aOJHaxldWjyDlNAlUHn8ybZE8514=
X-Google-Smtp-Source: AGHT+IGRLWN5kqeXRNQn8yzpCXFOSvMQOUs+A8CKa7xWJ/vZOijjwVJZJo9LQV0BVahQpTbnhrdFqQ==
X-Received: by 2002:a17:90b:2b50:b0:2e2:de27:db08 with SMTP id 98e67ed59e1d1-2e9b1770bffmr17545652a91.23.1731358461465;
        Mon, 11 Nov 2024 12:54:21 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e9a5fd1534sm9059974a91.42.2024.11.11.12.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 12:54:21 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 11 Nov 2024 12:53:55 -0800
Subject: [PATCH v8 10/29] riscv mmu: write protect and shadow stack
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-v5_user_cfi_series-v8-10-dce14aa30207@rivosinc.com>
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
 rick.p.edgecombe@intel.com, Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.14.0

`fork` implements copy on write (COW) by making pages readonly in child
and parent both.

ptep_set_wrprotect and pte_wrprotect clears _PAGE_WRITE in PTE.
Assumption is that page is readable and on fault copy on write happens.

To implement COW on shadow stack pages, clearing up W bit makes them XWR =
000. This will result in wrong PTE setting which says no perms but V=1 and
PFN field pointing to final page. Instead desired behavior is to turn it
into a readable page, take an access (load/store) fault on sspush/sspop
(shadow stack) and then perform COW on such pages. This way regular reads
would still be allowed and not lead to COW maintaining current behavior
of COW on non-shadow stack but writeable memory.

On the other hand it doesn't interfere with existing COW for read-write
memory. Assumption is always that _PAGE_READ must have been set and thus
setting _PAGE_READ is harmless.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/pgtable.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 7963ab11d924..fdab7d74437d 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -411,7 +411,7 @@ static inline int pte_devmap(pte_t pte)
 
 static inline pte_t pte_wrprotect(pte_t pte)
 {
-	return __pte(pte_val(pte) & ~(_PAGE_WRITE));
+	return __pte((pte_val(pte) & ~(_PAGE_WRITE)) | (_PAGE_READ));
 }
 
 /* static inline pte_t pte_mkread(pte_t pte) */
@@ -612,7 +612,15 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
 static inline void ptep_set_wrprotect(struct mm_struct *mm,
 				      unsigned long address, pte_t *ptep)
 {
-	atomic_long_and(~(unsigned long)_PAGE_WRITE, (atomic_long_t *)ptep);
+	pte_t read_pte = READ_ONCE(*ptep);
+	/*
+	 * ptep_set_wrprotect can be called for shadow stack ranges too.
+	 * shadow stack memory is XWR = 010 and thus clearing _PAGE_WRITE will lead to
+	 * encoding 000b which is wrong encoding with V = 1. This should lead to page fault
+	 * but we dont want this wrong configuration to be set in page tables.
+	 */
+	atomic_long_set((atomic_long_t *)ptep,
+			((pte_val(read_pte) & ~(unsigned long)_PAGE_WRITE) | _PAGE_READ));
 }
 
 #define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH

-- 
2.45.0


