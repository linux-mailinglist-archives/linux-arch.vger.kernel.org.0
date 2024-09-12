Return-Path: <linux-arch+bounces-7279-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A41977570
	for <lists+linux-arch@lfdr.de>; Fri, 13 Sep 2024 01:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84E2E281475
	for <lists+linux-arch@lfdr.de>; Thu, 12 Sep 2024 23:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9311D47D3;
	Thu, 12 Sep 2024 23:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="XU9+kRuy"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B32A1D47B7
	for <linux-arch@vger.kernel.org>; Thu, 12 Sep 2024 23:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726183146; cv=none; b=QIwTeIgUWkxwEYYsnNSA3PT9xyat4JHNHGA9MU/2F1Cn0HDIExi9oKd+w+QcftOQ0IqPtsYaOwNDouqwxgfP68QZhirOebsguxEoYEeOxza1EUI6dIdJH6Ad0CKyY0sfupUry8Ecq3GvP2YG8amIpXAmBVYO9N93WEBGBrPAzNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726183146; c=relaxed/simple;
	bh=pQ36bqJQc3crTMuG6nwBSgk8a0zlUdw1gw6SE4Q4lIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hhrmtfj3pkI3JVJfGEdisJuxb6bmmMKQDvJWYcnbqEaGF95drbzJu3ntmnPxFSsQxeUrAdHKi6odTnP1sT/oACyIb3IWBq1Kz0VhHdEEtbOftJNg/1qV68x5aij38Jq+iit3+pZCbSHthREsXeyIWIy+RYiA9wuoz6QmBHke5eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=XU9+kRuy; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2d877e9054eso1107301a91.3
        for <linux-arch@vger.kernel.org>; Thu, 12 Sep 2024 16:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726183144; x=1726787944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CbpKVNKRMfAtkqYXzA8w+8eVro8K48y9vmHyffj7Qao=;
        b=XU9+kRuy2rqqni/gJQi22KGOBl9Hg5D0UefCSy20BfL49aTLTqse19LUDg4KPFreKa
         2SNm1ZTnlDSOjjByklMxOUarGs+9r5fk/ebApVGuGDObxkW2h/IHcV1Xud6JF2yFrPnc
         7mufPWpztwNnBpoytc/hXBEj7hVLkDLMerTdSt1x57UweRzThrIxpK1o3ixUojx4dzEA
         fZYxhG1laVNPwodBc2mLyDAcEtvu0HQM+j0/6Jh1c3hEISEwdWFdKJPxVoCCBEsfvdFt
         KaombzvOd4w66392mS4XXATMJdDDqMvM/96XpuEKEDUZpg+/KlU5tt70k6lovuVMpP5y
         +/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726183144; x=1726787944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CbpKVNKRMfAtkqYXzA8w+8eVro8K48y9vmHyffj7Qao=;
        b=ODvSEKFN2cgtdF5nWo9IqF8dUBYcwWc2mUKthl1QDwBfBe1oFvNcd4U4LXgKYMN9qh
         LqwKNlDBimoozgCWhoVAQpHFD/8b/JBF7a5uaD4hJ6eZzN9F1/SViuAZCKrcEcUnZQkW
         UA7e2p7cMljHuFXYkjY+I4b7kfSXzpg/TAv8ZJ/SJVBb9KjM1VBdbAXvRDTUXzdDefq8
         tykVJpzpTneQkcmNVh0VII69OH3Ck7SLKKd3SJqLlA/NLRspW1l9O0BTNH3Z/QrQS81+
         fa7SXzdm+zvzrfCuTmyYDNCurmSxAnrMp7yDeb6KEVJiNqS8Mh09595an0Zxg4KgbOkd
         0b1w==
X-Forwarded-Encrypted: i=1; AJvYcCXCXXuhLN8TvVktt+jRi6GMC3aIpYJv4PksCpEJFBv5dldOsXRt4RyBIo38pi8K7x8kUwJK7ZWHUZYT@vger.kernel.org
X-Gm-Message-State: AOJu0YxLwHJyw1W6Xdxj5e1AkR1Lu+GPLnSTDxljWn/xoyUhrYeopGfC
	hmuq8jmlXAc/uooyQWwZsXf+4a51ndgAk1i7r1Ezuz4oKyFVRR5NyZA7ltGltP8=
X-Google-Smtp-Source: AGHT+IERJQSRxOQYUrcoeWqKKFDuWvirFZC93eScxDPtDLfWGyU08Qp8o+SGLVlkTYVlfOG74jZpnw==
X-Received: by 2002:a17:90b:1043:b0:2d3:da6d:8330 with SMTP id 98e67ed59e1d1-2db9ff79ba2mr4907026a91.4.1726183144244;
        Thu, 12 Sep 2024 16:19:04 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2db6c1ac69asm3157591a91.0.2024.09.12.16.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 16:19:03 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: paul.walmsley@sifive.com,
	palmer@sifive.com,
	conor@kernel.org,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: corbet@lwn.net,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	robh@kernel.org,
	krzk+dt@kernel.org,
	oleg@redhat.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	peterz@infradead.org,
	akpm@linux-foundation.org,
	arnd@arndb.de,
	ebiederm@xmission.com,
	kees@kernel.org,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	lorenzo.stoakes@oracle.com,
	shuah@kernel.org,
	brauner@kernel.org,
	samuel.holland@sifive.com,
	debug@rivosinc.com,
	andy.chiu@sifive.com,
	jerry.shih@sifive.com,
	greentime.hu@sifive.com,
	charlie@rivosinc.com,
	evan@rivosinc.com,
	cleger@rivosinc.com,
	xiao.w.wang@intel.com,
	ajones@ventanamicro.com,
	anup@brainfault.org,
	mchitale@ventanamicro.com,
	atishp@rivosinc.com,
	sameo@rivosinc.com,
	bjorn@rivosinc.com,
	alexghiti@rivosinc.com,
	david@redhat.com,
	libang.li@antgroup.com,
	jszhang@kernel.org,
	leobras@redhat.com,
	guoren@kernel.org,
	samitolvanen@google.com,
	songshuaishuai@tinylab.org,
	costa.shul@redhat.com,
	bhe@redhat.com,
	zong.li@sifive.com,
	puranjay@kernel.org,
	namcaov@gmail.com,
	antonb@tenstorrent.com,
	sorear@fastmail.com,
	quic_bjorande@quicinc.com,
	ancientmodern4@gmail.com,
	ben.dooks@codethink.co.uk,
	quic_zhonhan@quicinc.com,
	cuiyunhui@bytedance.com,
	yang.lee@linux.alibaba.com,
	ke.zhao@shingroup.cn,
	sunilvl@ventanamicro.com,
	tanzhasanwork@gmail.com,
	schwab@suse.de,
	dawei.li@shingroup.cn,
	rppt@kernel.org,
	willy@infradead.org,
	usama.anjum@collabora.com,
	osalvador@suse.de,
	ryan.roberts@arm.com,
	andrii@kernel.org,
	alx@kernel.org,
	catalin.marinas@arm.com,
	broonie@kernel.org,
	revest@chromium.org,
	bgray@linux.ibm.com,
	deller@gmx.de,
	zev@bewilderbeest.net
Subject: [PATCH v4 27/30] riscv: create a config for shadow stack and landing pad instr support
Date: Thu, 12 Sep 2024 16:16:46 -0700
Message-ID: <20240912231650.3740732-28-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240912231650.3740732-1-debug@rivosinc.com>
References: <20240912231650.3740732-1-debug@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch creates a config for shadow stack support and landing pad instr
support. Shadow stack support and landing instr support can be enabled by
selecting `CONFIG_RISCV_USER_CFI`. Selecting `CONFIG_RISCV_USER_CFI` wires
up path to enumerate CPU support and if cpu support exists, kernel will
support cpu assisted user mode cfi.

If CONFIG_RISCV_USER_CFI is selected, select `ARCH_USES_HIGH_VMA_FLAGS`
and `ARCH_HAS_USER_SHADOW_STACK` for riscv.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/Kconfig | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index d1d629a3eb91..24bf08c905d2 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -231,6 +231,25 @@ config ARCH_HAS_BROKEN_DWARF5
 	# https://github.com/llvm/llvm-project/commit/7ffabb61a5569444b5ac9322e22e5471cc5e4a77
 	depends on LD_IS_LLD && LLD_VERSION < 180000
 
+config RISCV_USER_CFI
+	def_bool y
+	bool "riscv userspace control flow integrity"
+	depends on 64BIT && $(cc-option,-mabi=lp64 -march=rv64ima_zicfiss)
+	depends on RISCV_ALTERNATIVE
+	select ARCH_HAS_USER_SHADOW_STACK
+	select ARCH_USES_HIGH_VMA_FLAGS
+	help
+	  Provides CPU assisted control flow integrity to userspace tasks.
+	  Control flow integrity is provided by implementing shadow stack for
+	  backward edge and indirect branch tracking for forward edge in program.
+	  Shadow stack protection is a hardware feature that detects function
+	  return address corruption. This helps mitigate ROP attacks.
+	  Indirect branch tracking enforces that all indirect branches must land
+	  on a landing pad instruction else CPU will fault. This mitigates against
+	  JOP / COP attacks. Applications must be enabled to use it, and old user-
+	  space does not get protection "for free".
+	  default y
+
 config ARCH_MMAP_RND_BITS_MIN
 	default 18 if 64BIT
 	default 8
-- 
2.45.0


