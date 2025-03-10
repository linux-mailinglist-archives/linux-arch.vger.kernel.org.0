Return-Path: <linux-arch+bounces-10619-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 442F9A59861
	for <lists+linux-arch@lfdr.de>; Mon, 10 Mar 2025 15:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02BA93A44B3
	for <lists+linux-arch@lfdr.de>; Mon, 10 Mar 2025 14:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA0B22D4E0;
	Mon, 10 Mar 2025 14:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="oc1s/WCY"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578D622F39B
	for <linux-arch@vger.kernel.org>; Mon, 10 Mar 2025 14:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741618372; cv=none; b=R9dTw0RuxUgut9GNFKqWf2zrSh51cpzmIi+CcbcDJpkcQw4NXuVzrYRbRGWAKte/W4RFrdK5FVD112GcNws+n42fynAOoODvYmscZEa4s8KdceLKv/N5Mda0n+ndaR4aLn2lj7EyU25vt7KCxYj7dDKQpWgv6mbJE+yCtfblNgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741618372; c=relaxed/simple;
	bh=VGYxjWQw4QYGSfT3AnAkedt5HRuw2tlx5dJCnKUawWM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pv6xj1MnMSwvnaKArntS2dBkcO7mx2O4Bd3EnGODN9tVSquwaVz3rDelfwU0ZDFSPA0ZVzE9+K/86SQBHF23HymNkhJvIpVzsPcHb73bgxQi/OKudGJngAVoAT+WFwVyUwCVv/WpFYme6F2b/yGJvitA54JvUFJklUTxw6p8QR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=oc1s/WCY; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2232aead377so13117695ad.0
        for <linux-arch@vger.kernel.org>; Mon, 10 Mar 2025 07:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741618370; x=1742223170; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bi056oDr44X6mEA5ptOBWamFE29btTVHHp5F60vYQ4s=;
        b=oc1s/WCYZRpnVyFozEO8JkLT7a/d9l53T015BjY4bGVFrZrfX7l0wLxzZeeBFrmEaN
         qLm2gSBxCbttdRqkiIg32bsbrOfwXAdXPhDKlTshunkV2KtrufBxbKTyWdPryJNUwHsU
         MFPhz4EZVX0KJfZ1ycLZ/SxkIEr7i9u6zrtd1c/V6a74x9lararexA/WTlNp7QZLTX9a
         c6ciXdtgNvSbH0v9PqKBaMy0KAEUkJXLK+nGpbQBIHtc+/qVZ6pHXlR4elVQArkSngp3
         ODr8KoS0BzLiGxIroIlf5qDx9Bdzi8vZiUEbE8FQZf8GRqNMc3iE6iN9dSr+vzCf4tb1
         nRlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741618370; x=1742223170;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bi056oDr44X6mEA5ptOBWamFE29btTVHHp5F60vYQ4s=;
        b=aRSpJBv9pniOqEn7ALoH7vsTnZy8OuPFAWnDdLtAX9z/ksTM1jKCNs2ZFqoU3bZUPZ
         BOocrnXfPyJTdWvbFxKH4jFPfydaz04xTEpaO0GrZeeYVdr69oA8yv+U3qUoY6tmE9hw
         g3dN6BNRe9Bk24Zfh1k9mTcTIqp3ZgfFUVE3QXQDwD5uGQpgfIp9gOzhQ9yhXxQLYz4+
         76DROeffTYW/SMajr5vERlrPP2esAj+teZnHombsMQsser8TqZjvpkNhy9H3UfLH/udA
         0M4lfuDjeD/itIU0X725BnrdDTmb4pxdYBzb61iqwqctnXsnrZHD6Mv2MG6rPEzlyHUH
         iKgg==
X-Forwarded-Encrypted: i=1; AJvYcCW7F9jpwAgjIt6j5KVaEsJM7iXD0HhGtx3PUhWwmxbshGYyun+3BK5vS56fpZAxzFH5ICqONe9+Isad@vger.kernel.org
X-Gm-Message-State: AOJu0YzbJtatbTZgDdbLOs8P2Jtd5Qqm7Zniwbe3YWeblG0erjyeCjHU
	oqGDx+zBgxWLEgLW32o53biRalZ3ofMi1LsZqb+PLgWWg3xi0PT1dukiHnPF67k=
X-Gm-Gg: ASbGncvqWC7oKWzyIWsAa8rgZop0aPumdniVl3ZetZP96pvKteKn5Jtev+xe7uPuSyL
	wbNVq16WtcqbS+NDwULIAJlgUaVxJcm89gyoqbRg8DVLdfW/RwSYyWTSvadPpeo+SGayrtqMGBR
	wu6bA7do+XF2gGQu58TEwGb20aV7flxSfM92aA+A8yKkyQdwsBzMX7krtv/OHzK7phzRJhX0h0U
	AQKnkgYHq9e5ihSRbfD+ltg1q6pdVyP0mSEIfwCa7mEtGHoAgT6oYb0NYPpyydCScrp7ckltYc2
	TOlz+IvKQdsnQrlQhWuHocAwooQOVo5i+4STSYfUbZKY8aZsvzh0NGE=
X-Google-Smtp-Source: AGHT+IHIjPCK5/0EhbZcTRnURyZw0NTj2K+W71g/3+djiMGOR5iYaRFLtirQywnmf6SGr6Tob6ydqg==
X-Received: by 2002:a05:6a00:218c:b0:736:562b:9a9c with SMTP id d2e1a72fcca58-736aaadf10emr17282132b3a.18.1741618369717;
        Mon, 10 Mar 2025 07:52:49 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736d11d4600sm2890275b3a.116.2025.03.10.07.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 07:52:49 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 10 Mar 2025 07:52:29 -0700
Subject: [PATCH v11 07/27] riscv mm: manufacture shadow stack pte
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250310-v5_user_cfi_series-v11-7-86b36cbfb910@rivosinc.com>
References: <20250310-v5_user_cfi_series-v11-0-86b36cbfb910@rivosinc.com>
In-Reply-To: <20250310-v5_user_cfi_series-v11-0-86b36cbfb910@rivosinc.com>
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
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
 Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>
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

This patch implements creating shadow stack pte (on riscv). Creating
shadow stack PTE on riscv means that clearing RWX and then setting W=1.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/pgtable.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 8c528cd7347a..ede43185ffdf 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -421,6 +421,11 @@ static inline pte_t pte_mkwrite_novma(pte_t pte)
 	return __pte(pte_val(pte) | _PAGE_WRITE);
 }
 
+static inline pte_t pte_mkwrite_shstk(pte_t pte)
+{
+	return __pte((pte_val(pte) & ~(_PAGE_LEAF)) | _PAGE_WRITE);
+}
+
 /* static inline pte_t pte_mkexec(pte_t pte) */
 
 static inline pte_t pte_mkdirty(pte_t pte)
@@ -749,6 +754,11 @@ static inline pmd_t pmd_mkwrite_novma(pmd_t pmd)
 	return pte_pmd(pte_mkwrite_novma(pmd_pte(pmd)));
 }
 
+static inline pmd_t pmd_mkwrite_shstk(pmd_t pte)
+{
+	return __pmd((pmd_val(pte) & ~(_PAGE_LEAF)) | _PAGE_WRITE);
+}
+
 static inline pmd_t pmd_wrprotect(pmd_t pmd)
 {
 	return pte_pmd(pte_wrprotect(pmd_pte(pmd)));

-- 
2.34.1


