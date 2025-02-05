Return-Path: <linux-arch+bounces-10015-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B12A280D2
	for <lists+linux-arch@lfdr.de>; Wed,  5 Feb 2025 02:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C734163560
	for <lists+linux-arch@lfdr.de>; Wed,  5 Feb 2025 01:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A427F22A7E4;
	Wed,  5 Feb 2025 01:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="j1rs/SHg"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57D622A4E3
	for <linux-arch@vger.kernel.org>; Wed,  5 Feb 2025 01:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738718529; cv=none; b=PMK7ckFMQl17dMWCC30CTwBAPqLu9RZbUidBO73bV1wNMLiwK9T+4bS9XDUGuqZStN+cKu2mvAGY85Ez49m27WRbsHVyKcVrAif8H+wA+uoBTFZTgsXGvpI4aVvKVx1EaZPnKRq3bkWEqsjsuG1byI7hliKon3LtuuP02LeJg+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738718529; c=relaxed/simple;
	bh=VGYxjWQw4QYGSfT3AnAkedt5HRuw2tlx5dJCnKUawWM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jU18CKZod/jQUMOzoLxC3ML+WoG9Q5PrACpCkbzqlsI5JZK4Ga8gCRdtZCEKLSAd6tlncUfvtlsszuYHa38aqsAqXZY0sW4PN8wqDyAv6D0RHkCSwlZamEZMiIl4TWvGwBlsFXJJNzJu/zIv3ihSGytqGLwJPzG3rJDNJoQHEr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=j1rs/SHg; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2f9bac7699aso2312284a91.1
        for <linux-arch@vger.kernel.org>; Tue, 04 Feb 2025 17:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738718527; x=1739323327; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bi056oDr44X6mEA5ptOBWamFE29btTVHHp5F60vYQ4s=;
        b=j1rs/SHg28XiLfRMfuRru09SdeL6lTzWOIGLPwJy4RmpTQ8id/T0uwXZlfEAJXZlC5
         RTFQf7ZqPPq8QDR00+rjd6Tk6IgLg3sEmV9xjbVdjH6jzbyPDMdvSqfOkDF+M36egZxm
         wh8xp+h2TwRM8zV8UN4yMU/iD8QqJPMcj67+YQvHQUh7I1b3BUHZv1H3buBnU3sm5CUy
         8Xh+aX3bSolOQNuCWenMsCqMdGjwf5MYf9zhnnN1N/ZfKDSZ0TZPSU0VVOrEQVh9udRi
         YWT/X12LwaNNmU4/RMxCmelO9keEqqvMbsKI+AxFx5ilEiq2s+ODoCcjojxXZqIUi+LZ
         /scw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738718527; x=1739323327;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bi056oDr44X6mEA5ptOBWamFE29btTVHHp5F60vYQ4s=;
        b=U4vSHqfETwpMmnjJxSBpBi7ZuF5ttzwEeX6RJpS8Ctk/k5YtlCLXaoPokYQsVSuWiO
         3SCxzPD0/LCQlANnCprNSofn03HqQ3b4eEPIi8sl9P4lu2QqwSFbB7OZKL8J8vw1eflT
         2Ck4RgIzDZYPF/M7LhUIDNF+/sVjbbdfBLSrRf1ub/50JryvTrJ9q0gY+4I+a2Xiz+4/
         rEVObfU/TeZzi4rtIX96WvYgccjpQ0KUmCnpmptziiFSeJC/7ph8jcNTVU9l9FXzM/Gv
         xDhaSfbBjxF7L9Apd0jOIHjyz7ZimPCmBz8FDcLYodeguRuutav21+zYwVpsO94poPq3
         VSpg==
X-Forwarded-Encrypted: i=1; AJvYcCVmb6wdtwb9YcV33xICI1ql1vUEJjrYUR1VZuNbrBV5uZyb4KnQUpdXC+oSEl/gCUfR/TRD6U/0uAdg@vger.kernel.org
X-Gm-Message-State: AOJu0YyC8sqMvQbpCOmtroAUIwmqxVRI50kqkTirfugy6pYs5jUxcDJV
	HZUZ0P3uw9AlY38W5ajrS1Q7C6RXWsacAMGk/T52UVYRsJREoG1bbr2YWpSvlc0=
X-Gm-Gg: ASbGncuz0IHiVbm6mQhoG8bS6zTr9z3SGf6qNrXrx0Tml2DsxthQuI9It/tOpHCgZcf
	Qlo1Ehf4zbDZqRI5hvuyOKcV8SVH+XxeksWUDBBWZpgh+mL5C93yAhAaT7QbAtCG8vUZcJeXRq5
	53wFp/0dkDnQqfk0MhorCnU/b+k/cJlN+u7Jh74nqLSg793eLnjKOG/UEc/DytrDy6wCcNpCR7G
	64+sN6U2LNcJoRgqffz7gX/2fByD93rlLUMrJdEQlAsxO3/cg9RFSDJpHK/onhUIJres3qoC491
	fKka6H/8+gJh1tOMv45qLytQXg==
X-Google-Smtp-Source: AGHT+IGqNdkqdj5d5A5aA6gKpwq89EtcxR1nZ3Ul1+SB6k4syDnXtWKiLDwMtPZuQ0/gHb49XAPbWg==
X-Received: by 2002:a05:6a00:1d88:b0:72f:d7ce:4ff8 with SMTP id d2e1a72fcca58-7303520d315mr1572110b3a.22.1738718527421;
        Tue, 04 Feb 2025 17:22:07 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69cec0fsm11457202b3a.137.2025.02.04.17.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 17:22:07 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Tue, 04 Feb 2025 17:21:54 -0800
Subject: [PATCH v9 07/26] riscv mm: manufacture shadow stack pte
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250204-v5_user_cfi_series-v9-7-b37a49c5205c@rivosinc.com>
References: <20250204-v5_user_cfi_series-v9-0-b37a49c5205c@rivosinc.com>
In-Reply-To: <20250204-v5_user_cfi_series-v9-0-b37a49c5205c@rivosinc.com>
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


