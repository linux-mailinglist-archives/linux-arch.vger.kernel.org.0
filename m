Return-Path: <linux-arch+bounces-11542-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B14DFA9A3B8
	for <lists+linux-arch@lfdr.de>; Thu, 24 Apr 2025 09:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5BFD1B60690
	for <lists+linux-arch@lfdr.de>; Thu, 24 Apr 2025 07:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0062F22424B;
	Thu, 24 Apr 2025 07:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="fiVHsPJQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4C5221F2D
	for <linux-arch@vger.kernel.org>; Thu, 24 Apr 2025 07:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745479290; cv=none; b=RJnn+L5Yiodbc8drfuPFnHN+mUPU9NoDMXxhJmdnwt/Th90MXJXOQ+ZDbg75jjpcwqXpAJnzPIuXT12cVjdeKS005cn6+tGfq+MJo7kIyVAqw4L1rBuWjiBBGX2bx4se8XvvOTM5o/trtSPAVCiSiq5O6ldB8V+SzjYy44syVx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745479290; c=relaxed/simple;
	bh=zlFZINb76FMBoVli7x5G/rJ3gW2orU8ElvZAB3SBxII=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AqKWL6JmZRcdwzrYO6ov0vDFMLkUxdpFVwpOtE/PeCAMXpUFeMUwk8WNKsABJpsx6Ij9XmSZX6xTIqLZ/8VwthJc9u4eYPSjyI2OW+pK3EskPZ++76l/gaWEiOtSW3ZU6hUQB4ZcEef4EKP0tNGEL6eF1Wj2EpLCLMNF8Xp/er8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=fiVHsPJQ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-227d6b530d8so6997705ad.3
        for <linux-arch@vger.kernel.org>; Thu, 24 Apr 2025 00:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1745479288; x=1746084088; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8eeH2xWhp7150dL05xNnwhOrsm/0dm8O4b6IoAKLk28=;
        b=fiVHsPJQxvR2aPUQlNOxkEqQ9Pzg1OKJ5WeMIl/l12booTnJD2qIgl6w6yNcDtN/hm
         L1YPthvuL8ROd0HxvgxEBsyoHuMeSL1z1H17gkiGEmfGeAmc/l/6sneZzpagBKGOMy0Y
         YKkgALzOjYReeHhElSSzZHUc7ZUG4QGIPPLjaPEcrpFKFYUvQPImplR/fK/J66HFkX7x
         aIdC7gdUclq3E4TYuZa52wPYnLBpSP9D92Z9vp5I89suOdinqhFFAZ+pcBg5Pf+RDtKx
         ZzcsTb6I0Bx1yoszoP5Z630SJZx1qLvvAHBBMNZaqZ75fhYuFrLqU28vcqQ7PsdM7jRO
         31IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745479288; x=1746084088;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8eeH2xWhp7150dL05xNnwhOrsm/0dm8O4b6IoAKLk28=;
        b=KOW/GYHmFCn/RmuHCTu00kz2k32crZpkYG+0+K33mq3ntmXTDioPkdZyxys9au6sp5
         tkW7idyJFQhOoeVIXldnK/wvTKuEGsCYtycUZjCl/WjDystVI5fktcpLg4MR9HbL992d
         RhJ+bGHV9uEevNU/bJ/WaiWIM1/60Qbmjqz+54i7gEGmWvn+eoWaqlnBvdHbuPyoBK64
         YsT20YPLjdXMxiNloCyyrTAIQ0i7aVGyXrQSCvu9sApryTTgxZZFSz+a4ZO88zvSj7nt
         RYX55j5IlGyh9VDsvOzf7BZJb4VN1pK39XCd3M/1oVdZA/X7WHi0npLZgI2M5S1VSzGO
         0qRA==
X-Forwarded-Encrypted: i=1; AJvYcCXe22+i6g/GjNVN0j/JLcIYdTz8bphhxdQWFmuJRbfkvEvOtP8wZmk80zcjI5Tz3SYQRxA194FgR/uG@vger.kernel.org
X-Gm-Message-State: AOJu0YyAzxvuRnKjPtOBASvzwi3OWWsBTpDJXFMfJ7oiFwVq5MRbM9AA
	nC71pr76H1i7OfHjszFyFLpijiEnzdnzCWAJVXUv92ZSCoVz1qjID/npE3X0i6U=
X-Gm-Gg: ASbGnctG/0ANIHrgylr2ndMU9GP+WDcc7Lr4tgFG6LWt/8q9dYnOrKhdUu28bcY0xw+
	NqtTYrZZdFu4frVVaG9PBe4PdUTtKUG75AATVkD04QBvOJ89hs2ColmadOyPvQA+OfDfypTz0IJ
	B4WYr4HT74YrUm/+/7P+J3EO8UylB8KOQBUKHbX122bsfN4ylIyWHZL1XmRKsZ9k5GKFAjE7A8j
	DoK3AbMW2Ce+/jBUe5n1rKnl7j9zSWkX3L/zcsLRMkUR0zdQqPipVDltfhYEvDc/724i/yUMkRK
	iNOAYcULTzOMUWNYpLj5ZVEQpVpbjEJVWzIvqfp34aQtY+Vda8yHf7+Rhk46fQ==
X-Google-Smtp-Source: AGHT+IHQaPNWR8AWB4C6qrLbgpXQ/uCnelvpmMXGyE7SN/TZw8kP+Kpttxym0RazMvhkr34F2t3brw==
X-Received: by 2002:a17:902:f64c:b0:223:4537:65b1 with SMTP id d9443c01a7336-22db3d99508mr26205085ad.36.1745479288201;
        Thu, 24 Apr 2025 00:21:28 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db52163d6sm6240765ad.214.2025.04.24.00.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 00:21:27 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 24 Apr 2025 00:20:35 -0700
Subject: [PATCH v13 20/28] riscv/hwprobe: zicfilp / zicfiss enumeration in
 hwprobe
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-v5_user_cfi_series-v13-20-971437de586a@rivosinc.com>
References: <20250424-v5_user_cfi_series-v13-0-971437de586a@rivosinc.com>
In-Reply-To: <20250424-v5_user_cfi_series-v13-0-971437de586a@rivosinc.com>
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
 Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com, 
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com, 
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
 rick.p.edgecombe@intel.com, rust-for-linux@vger.kernel.org, 
 Zong Li <zong.li@sifive.com>, Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.13.0

Adding enumeration of zicfilp and zicfiss extensions in hwprobe syscall.

Reviewed-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/uapi/asm/hwprobe.h | 2 ++
 arch/riscv/kernel/sys_hwprobe.c       | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index c3c1cc951cb9..c1b537b50158 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -73,6 +73,8 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_EXT_ZCMOP		(1ULL << 47)
 #define		RISCV_HWPROBE_EXT_ZAWRS		(1ULL << 48)
 #define		RISCV_HWPROBE_EXT_SUPM		(1ULL << 49)
+#define		RISCV_HWPROBE_EXT_ZICFILP	(1ULL << 50)
+#define		RISCV_HWPROBE_EXT_ZICFISS	(1ULL << 51)
 #define RISCV_HWPROBE_KEY_CPUPERF_0	5
 #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
 #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index bcd3b816306c..d802ff707913 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -108,6 +108,8 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
 		EXT_KEY(ZCB);
 		EXT_KEY(ZCMOP);
 		EXT_KEY(ZICBOZ);
+		EXT_KEY(ZICFILP);
+		EXT_KEY(ZICFISS);
 		EXT_KEY(ZICOND);
 		EXT_KEY(ZIHINTNTL);
 		EXT_KEY(ZIHINTPAUSE);

-- 
2.43.0


