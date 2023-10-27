Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11F17DA3B4
	for <lists+linux-arch@lfdr.de>; Sat, 28 Oct 2023 00:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346703AbjJ0WoM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Oct 2023 18:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346676AbjJ0WoE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 27 Oct 2023 18:44:04 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E8B1B8
        for <linux-arch@vger.kernel.org>; Fri, 27 Oct 2023 15:44:02 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6ce37d0f1a9so1565713a34.0
        for <linux-arch@vger.kernel.org>; Fri, 27 Oct 2023 15:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1698446642; x=1699051442; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lkuVRV2BU2bq68g2g/lXL36oTT7d/CXQaqu3G/K1tPY=;
        b=l2ea5DKMDmMARdGChQ0Q+yW2sSpAUsjs1Ptoq2mvqCgpf4T8N72tRUdzzkXYh2NHrX
         JmXF6v/OwZVC6eyh/K0XsXO+dN3zs8mMYqCAxWEswYSdGavaTrpsZtvNMLP3oiXPAT+G
         Sf+FipAByq9O0cP/hDnMGAtGDEvIlPBTAqifWrZiZ2IbfnFPYPu9dCSiP+Ldugq4e5wN
         q2dcynfPAfghNziBthbp+bLtmwnKpPoCr3LiAhCuAfGm3nFmoP2Vvw3KMt/ky1XrGBdF
         RwjjhNdtFj4Hx7mF8yWNeBkE8uBLJAr7x9j3EMROwqTkm5DM+gAQzrkiQCx9qnd4wBdC
         PfDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698446642; x=1699051442;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lkuVRV2BU2bq68g2g/lXL36oTT7d/CXQaqu3G/K1tPY=;
        b=OBiMBNwr3mM+7frEaTMcIUtB17gF3mZJ+C++hKGMwG0fJsoxamkjbwl1sv6PBZvOkX
         kQoUw0/bvqd0aYgndmcyrUIp7H6hyZdGLD1+cZQhJtgIW+oWu1wYPrdum7RJbVi1oTGT
         z51oKiuGvsybEjiNAk/ysyCMAusOIrzWTtJkKLDO+L38uhHLIOjHCQFuiQFgpNvXZ1rA
         gG9QmsebEK5OzuudPFK4Ex18YB8MPnLdfz2cxgdHhbkJn8yi+pvVcpBH7etXPM/dtFV9
         otrd9M8JOi7SSsX8lTYHpclFAKgnL6aBBQx2noWeEIaiErpJKGJx0KL0P3xW2t1FYx4O
         Lalg==
X-Gm-Message-State: AOJu0Yy100+12JxyTKNNN08aCsr73VyPeTVaKRUjVuYQkqeWSZyVTTWD
        0syBMi008WYBlckQaMTG0LwWrw==
X-Google-Smtp-Source: AGHT+IEifoZmkZ0JYpGGDw8fgxafPG8lvBp43skyV4czBADds8egtLlIOYW5YWE8tbfXGV/KpmGh5g==
X-Received: by 2002:a05:6830:7190:b0:6c6:3926:8055 with SMTP id el16-20020a056830719000b006c639268055mr4329785otb.6.1698446641925;
        Fri, 27 Oct 2023 15:44:01 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id t15-20020a9d748f000000b006c61c098d38sm448564otk.21.2023.10.27.15.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 15:44:01 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
Date:   Fri, 27 Oct 2023 15:43:52 -0700
Subject: [PATCH v8 2/5] riscv: Add static key for misaligned accesses
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231027-optimize_checksum-v8-2-feb7101d128d@rivosinc.com>
References: <20231027-optimize_checksum-v8-0-feb7101d128d@rivosinc.com>
In-Reply-To: <20231027-optimize_checksum-v8-0-feb7101d128d@rivosinc.com>
To:     Charlie Jenkins <charlie@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        Samuel Holland <samuel.holland@sifive.com>,
        David Laight <David.Laight@aculab.com>,
        Xiao Wang <xiao.w.wang@intel.com>,
        Evan Green <evan@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Support static branches depending on the value of misaligned accesses.
This will be used by a later patch in the series. All cpus must be
considered "fast" for this static branch to be flipped.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/cpufeature.h |  3 +++
 arch/riscv/kernel/cpufeature.c      | 30 ++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
index b139796392d0..febd9de4373e 100644
--- a/arch/riscv/include/asm/cpufeature.h
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -7,6 +7,7 @@
 #define _ASM_CPUFEATURE_H
 
 #include <linux/bitmap.h>
+#include <linux/jump_label.h>
 #include <asm/hwcap.h>
 
 /*
@@ -32,4 +33,6 @@ extern struct riscv_isainfo hart_isa[NR_CPUS];
 
 int check_unaligned_access(void *unused);
 
+DECLARE_STATIC_KEY_FALSE(fast_misaligned_access_speed_key);
+
 #endif
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 40bb854fcb96..8935481d32da 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -9,6 +9,7 @@
 #include <linux/acpi.h>
 #include <linux/bitmap.h>
 #include <linux/ctype.h>
+#include <linux/jump_label.h>
 #include <linux/log2.h>
 #include <linux/memory.h>
 #include <linux/module.h>
@@ -665,6 +666,35 @@ static int check_unaligned_access_all_cpus(void)
 
 arch_initcall(check_unaligned_access_all_cpus);
 
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
2.42.0

