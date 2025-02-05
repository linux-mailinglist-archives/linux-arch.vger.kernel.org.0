Return-Path: <linux-arch+bounces-10025-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E6AA2810E
	for <lists+linux-arch@lfdr.de>; Wed,  5 Feb 2025 02:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AABE7A229E
	for <lists+linux-arch@lfdr.de>; Wed,  5 Feb 2025 01:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5962D22DFB8;
	Wed,  5 Feb 2025 01:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="UH6TOKp2"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E60822DF8B
	for <linux-arch@vger.kernel.org>; Wed,  5 Feb 2025 01:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738718549; cv=none; b=hr6JDbGWy2ormo7SI6Louq/sEgSrxinfCJWn1gnDY/zwLfepV8FWCR+m6NYZEb7f8FXBF1AzICvCFi2Ssr1Rmxjen2tGIW5OXa2QusU5q9rPthGbQh2/wEFDa3MTu4OgmLCNiWsuF0ReuaguyqmK/HIBGPor7/UvFlbQy2XrDY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738718549; c=relaxed/simple;
	bh=UvMauEZ7ujgiT53rhoVNtF8wKatfWBS5dd1E01vsJYA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o85IqV6ZXWnFk4HJgJ2epr0iV9xsD018EtizIkN9uWgtqesfGNk9jPYDjoTSGshMvpSoJZ74x2sX88vP1D9NdytFdWetCFmlIPIY5Kr7qaKjiirD96FEOdlX//UzaheLr08d2ddyR/7/oyW603ZCGzjeCdaWYDC5mwiPfnbOTvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=UH6TOKp2; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21628b3fe7dso116074325ad.3
        for <linux-arch@vger.kernel.org>; Tue, 04 Feb 2025 17:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738718546; x=1739323346; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hU6IAlGSwKWKw5iWDrFBqBdwaJZ69/+Cs7+/DXu3do8=;
        b=UH6TOKp2XDIX2RDSSxZoYegAnyBxwo0XIC7ua1NMCJFOQ0TdjSvRxd38IpvvwqVWxU
         dIJtIJ7yIaaWYcWhf6b50bJDmv5Uj0iwX9zQQQN//tb2wZNB8DsHIjVzrilfZa+MuhJy
         E9kDP412ZyWztUXyNVIf7rC5uUfvhYl4OOW8r6iy5SdGXGYUIZorJomg/10Zd7oMPgJZ
         33FJV0xGBEoMpYUg449zVvu8EAI4HLqOMwUYPiPoSctQTeJL92rSPwWQ0jxNrLsoKkgx
         1GanFUK6i8L7N9MPZLlBr/sph3xi2Mbi8fsOpd7upYSnIZ+AjzYBZavow9HUgk8cRc5u
         Irdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738718546; x=1739323346;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hU6IAlGSwKWKw5iWDrFBqBdwaJZ69/+Cs7+/DXu3do8=;
        b=k17bKh9m463nBuBCldQxYvin0gRwrUD6ciDTB02ibrN8TaNx5VhF2K3KFwFhAuFNfr
         fo5ZL0plGOnPB8CZ9jXotliQRqtLK8JWrdMPHygKN4SWg3uq/SMxAOCZGcJi2C6fSoW+
         IdlmQGXjJf+lTDLns2gRaKJHlvqUiatBMRmjEZqlFUodBZKM4GABpLazZvhMfr/lbxEw
         COV/d64Cd2kKPCdYxVitYVMF4JNDQpnH7KFfpzjzcPFj6yZnfK8Jk6JOu7QYcRM8MJvX
         AB5erbU0GnP8VkO+J2eCnEGNGBFZGO2N/d/CLeoO8YbT37/IGMQgL9rKAsOzCVjkQHci
         SCLQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+mO89lrIIblc557RtA7ihPwcWaZUvRiSz2dO1Y6gBSDB0IfuUTzV9Va6oH8O2ciPHfP4kDKxkrc+L@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2Es/+cxYttPKr+ZQbm27/TrhdTW1Lmkie3SZX1mfaZNp/dMfq
	gG/Hpt+l7B1n2wqXM2nThsjTs8Lm14WRpF6e9hP0bDh564DcQT3wQ8WZkIuCkHw=
X-Gm-Gg: ASbGncuraxdF4YyzIgvwaX+c7qgEo1sA/sgHiTNWp8F6+wr+Mf+qQpvoEBaIMozJPQO
	4qnE7fN7OxLYjBU65QpyBTboGjo3W8pF2COEkIW9+HxaYsRxzZrJ6zaFkmcvIp/TIwnDpRfnerr
	3pRp6Ma7RyPmTRUb3Hfxu41qnTDEPuPDVqR8jTT2hnp6yXcGMqhyHU8Aos0oPebzSUjQML95TQa
	CyY4Y/BMGFnnmDVqJnWeNxoIQoCnWWHng5wRzK31UPQ5hUeLizl6VJnIUdgAWtS+lSuebQXZxMm
	eAOEmjHQPBC0uWNylwS18G5ndQ==
X-Google-Smtp-Source: AGHT+IGWWoW/7lRLh8J45NtMl4EugfElwrrMWaqnc/KSZ7FxaiKV7MT8r9isBGhbF0Mg00kAPNlQiw==
X-Received: by 2002:a05:6a20:ce45:b0:1e1:a75a:c452 with SMTP id adf61e73a8af0-1ede8844f5emr1528777637.19.1738718546388;
        Tue, 04 Feb 2025 17:22:26 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69cec0fsm11457202b3a.137.2025.02.04.17.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 17:22:26 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Tue, 04 Feb 2025 17:22:04 -0800
Subject: [PATCH v9 17/26] riscv/kernel: update __show_regs to print shadow
 stack register
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250204-v5_user_cfi_series-v9-17-b37a49c5205c@rivosinc.com>
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

Updating __show_regs to print captured shadow stack pointer as well.
On tasks where shadow stack is disabled, it'll simply print 0.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/kernel/process.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 4587201dd81d..6bb53ce72ed5 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -90,8 +90,8 @@ void __show_regs(struct pt_regs *regs)
 		regs->s8, regs->s9, regs->s10);
 	pr_cont(" s11: " REG_FMT " t3 : " REG_FMT " t4 : " REG_FMT "\n",
 		regs->s11, regs->t3, regs->t4);
-	pr_cont(" t5 : " REG_FMT " t6 : " REG_FMT "\n",
-		regs->t5, regs->t6);
+	pr_cont(" t5 : " REG_FMT " t6 : " REG_FMT " ssp : " REG_FMT "\n",
+		regs->t5, regs->t6, get_active_shstk(current));
 
 	pr_cont("status: " REG_FMT " badaddr: " REG_FMT " cause: " REG_FMT "\n",
 		regs->status, regs->badaddr, regs->cause);

-- 
2.34.1


