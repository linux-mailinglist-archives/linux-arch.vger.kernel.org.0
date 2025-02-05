Return-Path: <linux-arch+bounces-10027-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2797EA2811A
	for <lists+linux-arch@lfdr.de>; Wed,  5 Feb 2025 02:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D62C01883A64
	for <lists+linux-arch@lfdr.de>; Wed,  5 Feb 2025 01:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4306C22F159;
	Wed,  5 Feb 2025 01:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ENMMHziZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA4922E400
	for <linux-arch@vger.kernel.org>; Wed,  5 Feb 2025 01:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738718553; cv=none; b=TkWIqFzfnwse72wsVKnTvgjDYjnBq1HPDdZGHhr7J2dnbnlD6go7q5Qc9MDFzX4W0XuOMnmuhWSyGxszS/dXcSuf0kyy+YUvjDKdeX7FzQ0Fo4/ilxjnVVIm71ZVl6gcS7wPwF0lbxAfpNC+pSLLrIyYbJBMAOb9wOq/6OcvDQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738718553; c=relaxed/simple;
	bh=NmVWKk7RCdoTm8/kxl5H6XmDwgptfJerdilzp6YHjbI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S5F/aK9oxef0nQvtzNDp5jlE03EwFdZtaRKy+ebAOe5pjJa/1HkYBjIYbX6y9408x20sKSOMUqO72X3s4MixUvH+L0oZWSKLtJzQXkWjAwlxwvMf9JTGV20h6MXeFeC1lnmwMr+5rWW4hHFwsVmrLISLpxUF6uxPJyeJWQxt4NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ENMMHziZ; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2f13acbe29bso553530a91.1
        for <linux-arch@vger.kernel.org>; Tue, 04 Feb 2025 17:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738718550; x=1739323350; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BEoq6zqSeLFMaXOoiuM7yp6ZSaKHVlNR4X3PvApIHRU=;
        b=ENMMHziZQe6bXB5sk2Y/9WjQO2+mdCxbs574iaeCJSyPJQwtomjmK8AMYJ4V5UGgSn
         NyXv3xVSb6VqLW7WZeHhKisi1WOQl0y30caKBs6wcu58Q/dns3Y4z12w+KYFLwK9hUGO
         p53vaHjS7JgAkSGNtsNZ04+luW/BjBsdfs4QVqQhAupS5AA/ZYsRAE0R43jVEomBI025
         ZeT+PtqHvaocRe2E7TybImMkWQFHc/CprUecXj+1kjSLpH5VahnagEX7SxPJmra4SQaC
         s12wcBr5ynbjNCNkON6NylCeMNZtbtzEPB8NqmetVtjaAK25WO48QCcs4xKZ6A6zTIZ4
         vjeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738718550; x=1739323350;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BEoq6zqSeLFMaXOoiuM7yp6ZSaKHVlNR4X3PvApIHRU=;
        b=PIPL4Ay3vzs6IuCY4MepOptHHKnntnD/FyfWAh9Gc00OyuKsM2NPDgJV+AUMPbo5x9
         nX8Un+uZRdTmm3SGi5LbWIM0A7RH9vycxGpa80LKHc3d0T6R8+hda6AmUjZFnO8lc4JD
         qhe3bulS35OusjY7KCRv4uqb4h5ihPNfqjqXokY7PPUez5PZo5DAfA57xuHBDEkYHa2m
         vv/YH3wLIs0Vln6atzgDdo4OSqnVx9Du8loFsa8RDI5l5uSzOVD8NfKAWJKH6Y5A7UiE
         oOr1AzNfvbIynvmgWHbhdDODDARJo2+Z6E1w/XwbFI2X77GiMAjpQWYAuQ5Mz8RekMDs
         PslA==
X-Forwarded-Encrypted: i=1; AJvYcCX0WOm8g6xz5FXcNUu3/nUXmsmLv2/JuRKEIJTiB/1OQXdcQCM4o8DDaqNajLuawSxhXuWnHPDUoDTF@vger.kernel.org
X-Gm-Message-State: AOJu0YzDHcZNAJQaCnLWR/f+b09E4YjZs3rpmGslgV3W+WpJJ4gpJ8Xv
	v4dc7ouTnaJ0Neca352R3L2PZ5qkkctY9lfOmNwuaxLF6V8SvUqwtThSer1xMYA=
X-Gm-Gg: ASbGncstZLzcZEbXUlwAl2tepzuqRFGGlgAF0tzbODEmx1LJf/bb8B0396n87b9pDlc
	PipNZ+Mg694TrwkyfKOe2zOfAABZKwIDOex99nboTOWgZyB+f/f3WD39zqUWtzPGBPV9vpC885h
	9Wks5D5ZKzrKMkp8TAJOwZCfcBHIVL+QUJ2GE1l4H/yJ/1d2PLyrfWTSAC3czJVmUkkzMEH4HBH
	+vaGbPnOJcC/4vtKzmZSyUgGpWsyDvT6a5zMrddG+0bLlfTW15G/e2mQNMqEdUGy1da0br6wSwM
	Wb1HGrxl7ja59Jsh4SxXBpldMw==
X-Google-Smtp-Source: AGHT+IFRFqE0ahq5ulRUML95GVOJ0DexxJ072ed1PioG6NF+P3Y5e0hdICNgMJ1J/XjbYt4HuYIKmA==
X-Received: by 2002:a05:6a00:3a19:b0:729:1c0f:b94e with SMTP id d2e1a72fcca58-73035131885mr1809338b3a.6.1738718550207;
        Tue, 04 Feb 2025 17:22:30 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69cec0fsm11457202b3a.137.2025.02.04.17.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 17:22:29 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Tue, 04 Feb 2025 17:22:06 -0800
Subject: [PATCH v9 19/26] riscv/hwprobe: zicfilp / zicfiss enumeration in
 hwprobe
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250204-v5_user_cfi_series-v9-19-b37a49c5205c@rivosinc.com>
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

Adding enumeration of zicfilp and zicfiss extensions in hwprobe syscall.

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
2.34.1


