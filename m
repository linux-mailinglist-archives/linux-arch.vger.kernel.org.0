Return-Path: <linux-arch+bounces-10098-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 729FAA2FA77
	for <lists+linux-arch@lfdr.de>; Mon, 10 Feb 2025 21:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1911B1885FA7
	for <lists+linux-arch@lfdr.de>; Mon, 10 Feb 2025 20:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB28A250C08;
	Mon, 10 Feb 2025 20:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="P+MOXZ/e"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2238325D559
	for <linux-arch@vger.kernel.org>; Mon, 10 Feb 2025 20:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739219251; cv=none; b=l4TzGFTOWyfcSCZzpnyKoKTu2n5bwbv0YPbsDZGE3b2L2c8fFoDHOboVsDqTz0MwrLEJsCgYOS7vC/7O74MTKxMpIWJeaLd/0W3ghfnJeufs4dmeXhLEF08j5Q1boR7eCDFhbzqQGrsuEh4/VpnaLiFLrxST9sRynOD2NABluto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739219251; c=relaxed/simple;
	bh=NmVWKk7RCdoTm8/kxl5H6XmDwgptfJerdilzp6YHjbI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PNJOD1EgOmP/8C17RlLAFR80yJneohRmZDGV1a0mid9UCjZJtVR4I/bev7fWkvuQ/nvVd/BDhIe39FKMYuP8aSwjbpbI9WtAHdMtCUA17o8Z8FLwVVuazAzvEz/X5VAsAchrFg1lJ8YD/FTBWJ7YHbxMbbf4EUEMkuFoARNffU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=P+MOXZ/e; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21f2f386cbeso88908275ad.0
        for <linux-arch@vger.kernel.org>; Mon, 10 Feb 2025 12:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1739219249; x=1739824049; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BEoq6zqSeLFMaXOoiuM7yp6ZSaKHVlNR4X3PvApIHRU=;
        b=P+MOXZ/ewCBOEQQ3PgRWhwMFXy7m/YkwALhtYvrVVVzozxwYXwirhID323RIFh2W85
         vqjoC4NX/rbn4nuPDdbnOXAHBHUPWcGRnooREnJp7dxZg96krfjR6f7hnUmZBZ2krWHf
         1nab+xxqifZnD+xo4LbJ5Fw/pMrGrtPNIeyrr/I2HnrWYprxlYSEzjG/bKwtxjo5s9Z3
         MOMKTstOqaxFfMlb6lU5cqpY2bjT1rPDhLTwRFzOiNfkO2cIfb1dCUTXpke99gbzmm01
         HZtjGAbEymku8yG/ceaHJaHRJY52Y4hXvV1Q7ZF83C2cLxGwRRtj4baLv+skbF16uUuB
         dPzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739219249; x=1739824049;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BEoq6zqSeLFMaXOoiuM7yp6ZSaKHVlNR4X3PvApIHRU=;
        b=vZ94V0eWiZj0nWl29HLjWZ4DXgILV4gSwEP6jm3Y6JrBV4JyRQhVZBaQJ80n652LAv
         ZATCqaLoG/1hHriXwbwoJkVFwYIWGcii4bSZO1GUOWV6yA2SPQx0QNJ40EOBqXVjjt4z
         nPPqvGUH24PYa/rR45ZHbjivS4ybzfPbpxLEaV4MZ/Hjtzf64R3qR2vehYCRZooDwSaq
         qs9CAzVM82zeraH7LaBSdlm1qvklcIyVMnbuLLmhrOdRQvVK0lMV9AHNn8+Kqk1jq6rx
         5K91wydCf/mUn5OSBOIpMrOw2EhJJ3WXeY9yF27krs+XG2gWwWEF5bvo7chg06wUff7H
         8goQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBGVDINp+YreRQAhtZ7M/0/PGN6kP2mbQba2pQOuMvzbacPkNuVZMFJ531XWDP8dUiNu3NX6lh7MWm@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7kjQmhL4WSTnN2LTtCSw46n5dQIiS9SbuHtEOmX3TgC29Ziil
	PHOkiDZjWBIqubaCRbOgy/hXfGhQgETiVwiFaC6RujFq3G9VeAncC9ri2tezJJo=
X-Gm-Gg: ASbGnctXgEFjbWMCjzRV7tS4TAh+G8/8TIxQNwzuD5JyiRpmNh4OKxhktRFAfGktKrs
	hWEQxSWEmtZ8OAV4Ash5WZ0YMvpGUu9hKL82IOS/nxAr95Jm4YlvlXcW9gtGcE+LXoR3xw1P74p
	ZG0Y//jGq+Ub7VH6BSlmoVTjosCgInCsRVP8IAUs4cPu6uzmH+XYl8RTnLepwFDcdWSpd+4HxO7
	toA/JDb182oXMIfX4KMGiiQjr46zxmwCd+YFL39dloEA04KPxNneeugRMPyz37CZOpCS5DgG/Rt
	4h/ECBnPZkZMNEEeC742VXUIyQ==
X-Google-Smtp-Source: AGHT+IEt5F3RjsoBA/4cHXJN1Ltv5WX03R8vCEuQgHxCW+5M2vSetK20AA29/O7CLlddL+JvfC+2OA==
X-Received: by 2002:a17:902:d484:b0:21f:617a:f1b4 with SMTP id d9443c01a7336-21f617b009dmr211020025ad.45.1739219249583;
        Mon, 10 Feb 2025 12:27:29 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3687c187sm83711555ad.168.2025.02.10.12.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 12:27:29 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 10 Feb 2025 12:26:52 -0800
Subject: [PATCH v10 19/27] riscv/hwprobe: zicfilp / zicfiss enumeration in
 hwprobe
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-v5_user_cfi_series-v10-19-163dcfa31c60@rivosinc.com>
References: <20250210-v5_user_cfi_series-v10-0-163dcfa31c60@rivosinc.com>
In-Reply-To: <20250210-v5_user_cfi_series-v10-0-163dcfa31c60@rivosinc.com>
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


