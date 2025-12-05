Return-Path: <linux-arch+bounces-15247-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C44CA8ECE
	for <lists+linux-arch@lfdr.de>; Fri, 05 Dec 2025 19:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3AD1A3180CC7
	for <lists+linux-arch@lfdr.de>; Fri,  5 Dec 2025 18:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB14352FB2;
	Fri,  5 Dec 2025 18:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="NVKiUuMy"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DBB350D4F
	for <linux-arch@vger.kernel.org>; Fri,  5 Dec 2025 18:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764959859; cv=none; b=FInMCpS9oUKf++axrrvhHJf7/mT0U/iXuCkZyj07Y21wzNV3gyYi2XgP0v21uY3adsK3xc7pQm9/FKvxKxsUk4XVAwrYx8i4vw31OAn8uZN0nTWDEc8KNxwG0M2xqvf9+v90CtNN9I7RY1RPl+QsRZ8rwZHjLT4FOjZS/C+Xy/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764959859; c=relaxed/simple;
	bh=o+mupBbwLM9S2HS2KmSc2gYbDSK/gb3i74YBTExGXIE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A4UhBdTcdTi8z5hM0etq2Q/uX1c89B/Amjemsqug/GeAE5M3cQhYCwDBtcFvajUw1uc1kXXNcMFecdhQtM3c45YhJcKacGwVyTMl6kpB7NuNNTt4IOA9wmkHA515h7pv+mtKeSJ653D2Q/M9rDQ9jlmKMaIlphSVChhplEilxsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=NVKiUuMy; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-bd610f4425fso1419103a12.3
        for <linux-arch@vger.kernel.org>; Fri, 05 Dec 2025 10:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1764959849; x=1765564649; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=caVRo7M49OcsqhffOXnqYtJLXHun4v2kvB6IB4MWH/w=;
        b=NVKiUuMyNgGw92yCMyCjdpDG0JgmSWC5u00V/HAQ4oOJ8QjBMNret5j7IauIVYWZW6
         aRRDiFFljsTjIIYII+VJGAw6ypjI6nQQBEclHP9U3uIHLCK972QoOG8p2m3EDvYcOAHm
         p+I26dqZZRLqpclZ2L15NSdblTSfrGfFPSRI5KMi/H6iVbFKpuGxmB/Cno3sbi+g6gce
         lIexN85jnDVbBXtUVrGWY/MUMmdSGOzYQQR/iJZJTuXoUPd2XfMQXNAPQzZYKzss12Pz
         E5jTD/AJ+45Ti3Hv56/hXt5IfnM02zh1RwgSbTC6rWS1glp+QvDrDU7H+m4pCI3A55Zy
         swww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764959849; x=1765564649;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=caVRo7M49OcsqhffOXnqYtJLXHun4v2kvB6IB4MWH/w=;
        b=sOvx7h+CVs2etujDMazLkMCHpC7vDtYAbxqNr68WwpQRIZr5Gj6mTJCyWIIkpnIe/q
         U0rU8KQKIp3WM1JTnhA00GnC+KgyAbkPzlVOfDXMjbgrP0fBJYApLYwIKe14PMErKcdO
         3Oxpw8EsqtyX8n3y/sjIabtaP7K/05MWQx0BPMgAncmMUlVksfYo94hxKIDf1v2NJVm3
         +xvCJMDnXkdoMjv88V3CIQ1tZUFWBhgp2RDFGsimNTwHYpFncjJ0F3H9iHwISM/XpgnS
         Y6uEY9URZkeDVvuorzDR3/6huyd66oU6Uy44BGfBund9tAHaQ8d5MbLZFQQ0vhbNoua3
         UhnA==
X-Forwarded-Encrypted: i=1; AJvYcCXVgJPGvYAWs47odyAXmlZBy+T1jcJ+etr9gP/Kxls0BkdaIgNf/8Zdd/a0A1coA3TqXnwheEl56jxf@vger.kernel.org
X-Gm-Message-State: AOJu0YzYWlr7AhoWF9vemeYU9BQMQygnQvPv7O66DMtSBago8tIExVsD
	+Uf39yTZzRBCM811YGarLe7hVYblCEGyOsp9Z6crQX9HtrwZwphwR2M/WAerHtS/U1A=
X-Gm-Gg: ASbGncuEKatT7P+8vXRYkDgmnea7OvCSZfYCs+6xViLyBaAQ9fMoA88v2vKrZi0m4rn
	Ft7ZX7Uc4EC3gXmYdTkLdov/2QCvAN8cpgIrv5cB1peJHR4i9fIKf5oj74IUfivY8p5uwcruwYZ
	RZ3jB8D2LDRUWj0YCYEel7g/QOg0IWPyjaAh7cY4j8t5+xKdFhfTtcbHj0tFnzhyZy3+0imr7nF
	4zOJ37kIm+RBy1XNr0Z50MGmojQqac/0xytAf9OXDnGJJ61bTYc7OZFg8HKB5fL9hzwU5VHSfA5
	WcBFngsflJ5skQK7GLUapK0RK+3MbG2rZUAeEUwGX067HRsoQhx9X24OM6o8rd2uLQg0Ng4r6Fm
	ybByZ7vhy0z/Wj5746YQPkA3i72HSVpXv1QAigrtWTBWfLcczKqmkkE4R2gShXaPhaWnjXfrX4q
	qs3L0fETgt5gAcwa02fEvp
X-Google-Smtp-Source: AGHT+IE2xGqf6PsGRkrxaqECp1R5gZSEA6uoyMXhatYShxnn+tFhMQT5orx1xHyQl0N4uRXeo3OQqg==
X-Received: by 2002:a05:7301:f07:b0:2a4:3592:c60c with SMTP id 5a478bee46e88-2abc71e17e9mr78847eec.29.1764959848864;
        Fri, 05 Dec 2025 10:37:28 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2aba8395d99sm23933342eec.1.2025.12.05.10.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 10:37:28 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Fri, 05 Dec 2025 10:37:06 -0800
Subject: [PATCH v25 20/28] riscv/hwprobe: zicfilp / zicfiss enumeration in
 hwprobe
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251205-v5_user_cfi_series-v25-20-8a3570c3e145@rivosinc.com>
References: <20251205-v5_user_cfi_series-v25-0-8a3570c3e145@rivosinc.com>
In-Reply-To: <20251205-v5_user_cfi_series-v25-0-8a3570c3e145@rivosinc.com>
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
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Benno Lossin <lossin@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com, 
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com, 
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
 rick.p.edgecombe@intel.com, rust-for-linux@vger.kernel.org, 
 Zong Li <zong.li@sifive.com>, 
 Valentin Haudiquet <valentin.haudiquet@canonical.com>, 
 Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764959808; l=1494;
 i=debug@rivosinc.com; s=20251023; h=from:subject:message-id;
 bh=o+mupBbwLM9S2HS2KmSc2gYbDSK/gb3i74YBTExGXIE=;
 b=h5kVDkaUUUs99aJk0qS23WgDcswkl3+9vDfiJ5qfqx4Kce4+ENPu1q1DoLCHOQG7/oTl1GxgM
 WtrUtrWksYgCk00mzDTDyGq09yoemSOOYeLn27NuQe2huLJS2GIT4Gi
X-Developer-Key: i=debug@rivosinc.com; a=ed25519;
 pk=O37GQv1thBhZToXyQKdecPDhtWVbEDRQ0RIndijvpjk=

Adding enumeration of zicfilp and zicfiss extensions in hwprobe syscall.

Reviewed-by: Zong Li <zong.li@sifive.com>
Tested-by: Valentin Haudiquet <valentin.haudiquet@canonical.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/uapi/asm/hwprobe.h | 2 ++
 arch/riscv/kernel/sys_hwprobe.c       | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index 5d30a4fae37a..0efc9c7d1199 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -82,6 +82,8 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_EXT_ZAAMO		(1ULL << 56)
 #define		RISCV_HWPROBE_EXT_ZALRSC	(1ULL << 57)
 #define		RISCV_HWPROBE_EXT_ZABHA		(1ULL << 58)
+#define		RISCV_HWPROBE_EXT_ZICFILP	(1ULL << 59)
+#define		RISCV_HWPROBE_EXT_ZICFISS	(1ULL << 60)
 #define RISCV_HWPROBE_KEY_CPUPERF_0	5
 #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
 #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index 000f4451a9d8..d13d9d0d1669 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -114,6 +114,8 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
 		EXT_KEY(ZCMOP);
 		EXT_KEY(ZICBOM);
 		EXT_KEY(ZICBOZ);
+		EXT_KEY(ZICFILP);
+		EXT_KEY(ZICFISS);
 		EXT_KEY(ZICNTR);
 		EXT_KEY(ZICOND);
 		EXT_KEY(ZIHINTNTL);

-- 
2.45.0


