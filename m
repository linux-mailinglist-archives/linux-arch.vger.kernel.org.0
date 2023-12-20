Return-Path: <linux-arch+bounces-1146-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCB481AB1C
	for <lists+linux-arch@lfdr.de>; Thu, 21 Dec 2023 00:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05B851F23CF4
	for <lists+linux-arch@lfdr.de>; Wed, 20 Dec 2023 23:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDDD4B5C5;
	Wed, 20 Dec 2023 23:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="06r2xLwo"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32F24B13D
	for <linux-arch@vger.kernel.org>; Wed, 20 Dec 2023 23:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1f060e059a3so111754fac.1
        for <linux-arch@vger.kernel.org>; Wed, 20 Dec 2023 15:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1703115465; x=1703720265; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hqZmArtiXcDp/s2cDCE6VomUeBtSGPPb+28mpDKaCFA=;
        b=06r2xLwoQSA8lns02rRsdnIdDCnQG9524FvY6rw+4MoiXbJ49sl8k1TxRap88AC0ER
         bmcazPHa7dee+9pT9CMxmpxzoaHSbtO3dGS8bhfAHKKpu5Yrwwu9qjGAFfv7LSV6Skko
         ZqNdin08aVnG/RLZFuNxbm74iHDvF7B8nUrnSwXehKXtBB+exdjWK35uwUjxSn+/b6Mn
         n53tZuYbn56e6dd5u3Exk0ux+seFxddIUwr2G0jYkzNLRq41FtpZcx6RxpRZqxNPTAXg
         9WQQqKcGi9pBnT71zwxu4J+IuqW7NayiLF+3wkIDHHp0/FsHjn35JN7E3+hM3ELwNKqT
         BkqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703115465; x=1703720265;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hqZmArtiXcDp/s2cDCE6VomUeBtSGPPb+28mpDKaCFA=;
        b=LosVWzrSCtL7SUGp+0ICIV3wO7lUcUb+lb3fhUrIyhdTs4udIsn8G+zNGqhnzkmnHk
         XBBYYKaPjPFNkfH3fBCds8Ukg1OilPStAFp51vTcd3b6LfHHg9szcL4xjvCLskBtmIjK
         5dARSVMaKfxXDpGw+LIiKUtLXucSNNSAsQ/Te7Lj8C/XyzOp1VpqgG6PxuQZ3+lvBc47
         yDC5WJfBIcI6l2XkYB0Gh0y+buD9r41iE0AVpnUlY7UxYXcU447QXtX5OV58zxSaUTeI
         z6ovP3a/T7lJAKj++AamUodtdRT6jom/dkttQJKOhqZ5IF2xhoyH80YNE5e2Dbt3J1h5
         5ioQ==
X-Gm-Message-State: AOJu0YxjVu50EDula+6NEIhBFFs/i3N0GSfmEw2HJFA1tRP5LebwThn/
	H6PPdud8U27vvoISp7JNhrEeVQ==
X-Google-Smtp-Source: AGHT+IFeBdaPxfNAXv1ibol3y9dWmT3hdCcKUPEGPwsCmFqAkFbMInLhFpUXJrzsQqwTH1nXqMZtFQ==
X-Received: by 2002:a05:6870:970f:b0:203:bcc7:8fa2 with SMTP id n15-20020a056870970f00b00203bcc78fa2mr672978oaq.5.1703115464850;
        Wed, 20 Dec 2023 15:37:44 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id k5-20020a056830150500b006d87e38f91asm132834otp.56.2023.12.20.15.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 15:37:44 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 20 Dec 2023 15:37:40 -0800
Subject: [PATCH v13 2/5] riscv: Add static key for misaligned accesses
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231220-optimize_checksum-v13-2-a73547e1cad8@rivosinc.com>
References: <20231220-optimize_checksum-v13-0-a73547e1cad8@rivosinc.com>
In-Reply-To: <20231220-optimize_checksum-v13-0-a73547e1cad8@rivosinc.com>
To: Charlie Jenkins <charlie@rivosinc.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Conor Dooley <conor@kernel.org>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 David Laight <David.Laight@aculab.com>, Xiao Wang <xiao.w.wang@intel.com>, 
 Evan Green <evan@rivosinc.com>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Arnd Bergmann <arnd@arndb.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703115460; l=2270;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=zAvCCM1AIoiNlx7AQwltNFw7ekzVRWkGRkhZ8BNL3iE=;
 b=/aoALA0sPu/mQrg3wwtXeXAI2bR1ghCTU4z4qItLaJnMLYVXoeBeX/8KZsrRPbIY0Vt0eIUCZ
 CCU5N5pjCbdA2zEuvQCl+CIPeGSez/Ug3N2nd09YxVNQiBASexBl8Fz
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Support static branches depending on the value of misaligned accesses.
This will be used by a later patch in the series. All cpus must be
considered "fast" for this static branch to be flipped.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/cpufeature.h |  2 ++
 arch/riscv/kernel/cpufeature.c      | 30 ++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index a418c3112cd6..7b129e5e2f07 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -133,4 +133,6 @@ static __always_inline bool riscv_cpu_has_extension_unlikely(int cpu, const unsi
 	return __riscv_isa_extension_available(hart_isa[cpu].isa, ext);
 }
 
+DECLARE_STATIC_KEY_FALSE(fast_misaligned_access_speed_key);
+
 #endif
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index b3785ffc1570..095eb6ebdcaa 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -10,6 +10,7 @@
 #include <linux/bitmap.h>
 #include <linux/cpuhotplug.h>
 #include <linux/ctype.h>
+#include <linux/jump_label.h>
 #include <linux/log2.h>
 #include <linux/memory.h>
 #include <linux/module.h>
@@ -728,6 +729,35 @@ void riscv_user_isa_enable(void)
 		csr_set(CSR_SENVCFG, ENVCFG_CBZE);
 }
 
+DEFINE_STATIC_KEY_FALSE(fast_misaligned_access_speed_key);
+
+static int set_unaligned_access_static_branches(void)
+{
+	/*
+	 * This will be called after check_unaligned_access_all_cpus so the
+	 * result of unaligned access speed for all cpus will be available.
+	 */
+
+	int cpu;
+	bool fast_misaligned_access_speed = true;
+
+	for_each_online_cpu(cpu) {
+		int this_perf = per_cpu(misaligned_access_speed, cpu);
+
+		if (this_perf != RISCV_HWPROBE_MISALIGNED_FAST) {
+			fast_misaligned_access_speed = false;
+			break;
+		}
+	}
+
+	if (fast_misaligned_access_speed)
+		static_branch_enable(&fast_misaligned_access_speed_key);
+
+	return 0;
+}
+
+arch_initcall_sync(set_unaligned_access_static_branches);
+
 #ifdef CONFIG_RISCV_ALTERNATIVE
 /*
  * Alternative patch sites consider 48 bits when determining when to patch

-- 
2.43.0


