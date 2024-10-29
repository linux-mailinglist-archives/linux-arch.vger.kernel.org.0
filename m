Return-Path: <linux-arch+bounces-8715-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA9E9B57CE
	for <lists+linux-arch@lfdr.de>; Wed, 30 Oct 2024 00:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E9861C22DD9
	for <lists+linux-arch@lfdr.de>; Tue, 29 Oct 2024 23:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C62A21502B;
	Tue, 29 Oct 2024 23:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="tpACsMkN"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C154C20CCDB
	for <linux-arch@vger.kernel.org>; Tue, 29 Oct 2024 23:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730245524; cv=none; b=fm0BgMfKfffhz4Qht5earD65R8ImFtDKqaklhoRah76ncXRP+XaTzojHCBrXV90EThCwn3fO4kFIVitJsO4JC4LXUkSURdfnEStQ8sjfq/LUMgNQyPnARieiYFjBBebBrYjIk1yB2ekzuyMr3S7Eb4ks68AGIrzcnA5k9Fhr+K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730245524; c=relaxed/simple;
	bh=uIj6D6eKxGy22T3W83W2H4Fei/chUVRqxoKSzM5k6/M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hPoCmSiTho8incsv8rMzp+T/36sFt08/gf7mnZttZY7ydfNcoladu1CI5R2W2XYkC4YbDJrpvjgRqhpYuOn5Tjnhupr2Y4cTNjuy6tr2WtKatwi1jJu9NFxkW9Msh9gIfHtJwOpp5rN1zGP7Kzp36jcDcfU0ZPWiyzZZkJ1uk3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=tpACsMkN; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7eda47b7343so3884718a12.0
        for <linux-arch@vger.kernel.org>; Tue, 29 Oct 2024 16:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1730245521; x=1730850321; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kn/sn+D1z+93mY85aikbkRt+t3FRvwF0B8Ok3zV+OA0=;
        b=tpACsMkNDdHDMljNEfzxdFWJukqwQPAK6dy9qtuDt+FvoNqjYJQDXJmiLSxFz9KKvp
         QLY6DX1IIcTg1cEKmVYhfMcnOrfAtEyOEoeYY9prN77TOfsLcwcX03tycZ71gR/Mz/A1
         Ie+IYvktVIsz5iTd3ax1eHk7gwW29LC+JlmrjS9r/rbajNiOwCyGKLvIwk/4Z6frMj3R
         U9kDn5gc2YBbhwXJh9zbTtTLZt6BdjwydgcgNWaNiITBbp0PNZLUp9qngN7r4XCudRfh
         PVUzNxPOOVGprPwDRI2TnvJJS7esOG0Ekph4ruIK/qEFAsAHQXiGQgIfHyGIWb2GUuA7
         eJew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730245521; x=1730850321;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kn/sn+D1z+93mY85aikbkRt+t3FRvwF0B8Ok3zV+OA0=;
        b=JgKVQvwBqtiP6Trw2dQWffqOJl/lNAVSlkQSV6J0NaRNNuwaf4TsxdWDxyiVv4mldJ
         ZV/4fushhJRmsUzFKAB5nSqw9x9GEtY37DmzX0ew+2RzNGHU1KYNNgt6jn9Gv7GGh3AV
         h9X9qyhWE/yTrAjwIPYzwWFazdEvix9K5bnO59L/nKdiENc1cg00x57J32XnrbnUir1e
         xgy/ah4WS4VvDmRZsTWs5PEmXt7K8GCjO7ST+e1VZ4IcizQPqMTf0neO761hY7f6hMEA
         rHuS9T4Etq0N5epSjTkNDBLZPmIq0lyzU/Qy3gEUwj2nwfesS8Zomubsp2pBSPcbTmyT
         jxKw==
X-Forwarded-Encrypted: i=1; AJvYcCXM3lrWD7Yx7TYBr8nKHykDzDDESL+Z+zmrCiIoY0fmo5N8Ybz5+zCsh9QbgDyVrFSnjOb8pWhHqZ5I@vger.kernel.org
X-Gm-Message-State: AOJu0YzI+Qqa5Xbw/ytYqR2NEDfbIomllMw6tBk5ALL2t6da7SYCYO2D
	bd5dBekNZ9oFq9mrftBSckyN1DVP96lFhcaavHWk2Jm4xyrekB+bBLNX8w7M5Ag=
X-Google-Smtp-Source: AGHT+IFSRRwDJwzMEik28WuiCu9TazkISCRtSEmteAY39kMNDbrF9hMfjaoxtBbs1QyHM1hw6YiZLw==
X-Received: by 2002:a05:6a21:e96:b0:1d2:eaca:4fa8 with SMTP id adf61e73a8af0-1d9a84d9df9mr21491704637.35.1730245520903;
        Tue, 29 Oct 2024 16:45:20 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057921863sm8157643b3a.33.2024.10.29.16.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 16:45:20 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Tue, 29 Oct 2024 16:44:25 -0700
Subject: [PATCH v7 25/32] riscv/hwprobe: zicfilp / zicfiss enumeration in
 hwprobe
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-v5_user_cfi_series-v7-25-2727ce9936cb@rivosinc.com>
References: <20241029-v5_user_cfi_series-v7-0-2727ce9936cb@rivosinc.com>
In-Reply-To: <20241029-v5_user_cfi_series-v7-0-2727ce9936cb@rivosinc.com>
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

Adding enumeration of zicfilp and zicfiss extensions in hwprobe syscall.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/uapi/asm/hwprobe.h | 2 ++
 arch/riscv/kernel/sys_hwprobe.c       | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
index 1e153cda57db..d5c5dec9ae6c 100644
--- a/arch/riscv/include/uapi/asm/hwprobe.h
+++ b/arch/riscv/include/uapi/asm/hwprobe.h
@@ -72,6 +72,8 @@ struct riscv_hwprobe {
 #define		RISCV_HWPROBE_EXT_ZCF		(1ULL << 46)
 #define		RISCV_HWPROBE_EXT_ZCMOP		(1ULL << 47)
 #define		RISCV_HWPROBE_EXT_ZAWRS		(1ULL << 48)
+#define		RISCV_HWPROBE_EXT_ZICFILP	(1ULL << 49)
+#define		RISCV_HWPROBE_EXT_ZICFISS	(1ULL << 50)
 #define RISCV_HWPROBE_KEY_CPUPERF_0	5
 #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
 #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index cea0ca2bf2a2..98f72ad7124f 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -107,6 +107,8 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
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


