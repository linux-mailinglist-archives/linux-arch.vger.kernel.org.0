Return-Path: <linux-arch+bounces-10839-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9FAA61E6F
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 22:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFABD17092F
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 21:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A0A204F93;
	Fri, 14 Mar 2025 21:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="m7KCyXD5"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6150202F88
	for <linux-arch@vger.kernel.org>; Fri, 14 Mar 2025 21:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741988372; cv=none; b=r7eLyCKprmxdaxum33DT/EMwQNx0e7htx71MQ2Er4NHMNXPJruPI5lhA/GS7/0AZoSPeprrcDfl3Z7H0SxMVT9CxWbkRWgA9vf51kiihbS7IX6RQqicHWcczKQC/f2AZdFYafKPgTTcv6rw39g2so2moDRsRHZzSwrp8uxu1jc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741988372; c=relaxed/simple;
	bh=pbZsnVycfvlXR/jueZaepHgseReSQSx1x2o5rAzi9lQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=utBV6PLhb7GzsrTbuNPBGVE4kNItygCo8+5bij3kSjAtUfOF38k7HCtzwaAcQUTGrDvg5EGjSeMPFNx/+UKD1EsiAgctVq1OY0q3nyRrDw5VutLVqGDad3TBaSl/OZfT7ZEYRrpS1LxjVYVrCTuuqYen8Z4MbYB7zbBKOY50FJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=m7KCyXD5; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-224191d92e4so52579075ad.3
        for <linux-arch@vger.kernel.org>; Fri, 14 Mar 2025 14:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741988370; x=1742593170; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SDDw4jYk8ElhORayLnctVQ+77ceNByh8dqs8gmZ197w=;
        b=m7KCyXD5LnQkJc1z4hTDR+h/VGiM9ZJOvppzKGG89mi2z7hF997+HAp2iVNQvdG8gU
         Zv0IMTWNSNbV0PFimBwSB/VWO65+Py8SABFRH+hwGCAIkXUX189K/w+Jch8F4De4htFB
         L/ml8N0GPEI/0Tg63UW1AuemeMYmMbhk8RIbUkJ0lAIgphrfHA4y8agSB9cOZrdUQ0tm
         Cgst9vZr21qxvzsgRUiZYXVoL7i3iPwHOFk8ZX43QDBy/nsJVfoUvCFgBN72DuivKhp+
         d9q1u9Mu13Es5RX/iMYEoygtZTeQp8jF20lwvdgrnnsECasfo1mih6z4BLag2Ml7Kd8S
         jVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741988370; x=1742593170;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SDDw4jYk8ElhORayLnctVQ+77ceNByh8dqs8gmZ197w=;
        b=I1tP/BnttjVHNyx09nX61qHFh2eOZofrgzDpXlC0Yyf3z91O+9cd1zruDecoLwfH56
         E/WM4WFmlrDVLo7hRegP09AR0iDUBvFKkTCKB+sHV0RBM9QhxBJTxOaQYJRlpvY8a/2L
         pCWV+/VhQCJcWl7xmOf79Vb2pcG+4+Ar/O6V/fTcbcuZcWooCp3hQEAUkROmCKWQLPlo
         3Waf4VWnjHXccaj+HWbNpta1qwvG1XpksJHGvgjTZjTWWN27mEsDxaaAuyu3SaygG1Up
         4dO4oodu0kKSdPEqhQyiv40vEyXTPpIn6P+Yd64tma9yNSOkb1jmsZH2uMFAibyndni/
         x5PA==
X-Forwarded-Encrypted: i=1; AJvYcCWkj7dX4bONd65wk2uow6F+hZiLsmIZiwEig9Wls/b4TM1UvYWkm3N+1yKh5PGK643Has+JpUGjEPn7@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5Pk5pf3asBgCk+Opx6vZ4qykOwSXYds/JKs8s+Ss6hi/z6hcW
	QCnpMozpFsg15Kp2APiY18EBTSykAa9VRGAajBmLH8ZlNVxBUBRs74QjLLjR+4I=
X-Gm-Gg: ASbGncsYnaS4mHvHEvy+dP1xydlpgp5DwOLuQcjMVL+25TksDCdz5OP2KXsYQZNPI1s
	i5gdPCMZNZB3px7d7IzTpFXspznGtpmz76LJWMsDj/ZYghbgjLpzlyMr7mDL2YsOovm7JbGzcee
	OTLg5HkaB7UI/BQJw/i0ZSEx/E1jVr/37xfjZtaHivMj46IGzT10DplJ2xfVl0ihgrZdp0PUKCY
	n3/kunaiwyZi6YhqQpCA/ykoMpekSc4CqztWXKczARegKRo2b4PkZbv4T0AR98yReXCNsi8nytY
	118H+GyL61WjjQ8WzT6y3y+/5GaLKAa9mFd58bq+9WuWC9qlxUiFI5pKCsQ0V29mpg==
X-Google-Smtp-Source: AGHT+IFpg7z+OE/2A1gqmKjw7jqoEU+X8gr8RuneE9Exr7j30nKzCtL2OnQx5eLIT+ktDst/E1FOnA==
X-Received: by 2002:a17:902:db04:b0:224:8bd:a482 with SMTP id d9443c01a7336-225e0aa7e06mr46126855ad.25.1741988369862;
        Fri, 14 Mar 2025 14:39:29 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a6e09sm33368855ad.55.2025.03.14.14.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 14:39:29 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Fri, 14 Mar 2025 14:39:20 -0700
Subject: [PATCH v12 01/28] mm: VM_SHADOW_STACK definition for riscv
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-v5_user_cfi_series-v12-1-e51202b53138@rivosinc.com>
References: <20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com>
In-Reply-To: <20250314-v5_user_cfi_series-v12-0-e51202b53138@rivosinc.com>
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
 rick.p.edgecombe@intel.com, Zong Li <zong.li@sifive.com>, 
 Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.14.0

VM_HIGH_ARCH_5 is used for riscv

Reviewed-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 include/linux/mm.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7b1068ddcbb7..1ef231cbc8fe 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -378,6 +378,13 @@ extern unsigned int kobjsize(const void *objp);
 # define VM_SHADOW_STACK	VM_HIGH_ARCH_6
 #endif
 
+#if defined(CONFIG_RISCV_USER_CFI)
+/*
+ * Following x86 and picking up the same bitpos.
+ */
+# define VM_SHADOW_STACK	VM_HIGH_ARCH_5
+#endif
+
 #ifndef VM_SHADOW_STACK
 # define VM_SHADOW_STACK	VM_NONE
 #endif

-- 
2.34.1


