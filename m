Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B8A7DD98F
	for <lists+linux-arch@lfdr.de>; Wed,  1 Nov 2023 01:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236815AbjKAAT3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 31 Oct 2023 20:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345028AbjKAATO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 31 Oct 2023 20:19:14 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDE7ED
        for <linux-arch@vger.kernel.org>; Tue, 31 Oct 2023 17:19:11 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3b2df2fb611so4323720b6e.0
        for <linux-arch@vger.kernel.org>; Tue, 31 Oct 2023 17:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1698797951; x=1699402751; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Jfb6hOBzZpUnQKwLCoqR3E0xQBxJXpYyz1BMSpxkFw=;
        b=ltXoNmztbe3dRm6fON4mZNJQVoI7nho90UDD7/Ymj6EAw6cx8A0I9I1R3y0Aunwv39
         EjCZ5uwodG6P6QmEWfbJ6MOhCZWYTZdePxrkrPZ3RjpdqBXOC6KtjT1O9SQC6GSxIMkZ
         Lx//Qahj3niHLT/b7df/1Mcou5YBp3ymBttPAJapKcVgIhC5oL58ykcbDEXM/FaSTIwm
         jsSibH1wQ80nAiPeImoSwhbZvOCMFHl4/dOgt6ZJPbAjOd5bgBFIWPvbl4KVuMhHr4cb
         J/Eo6rboUFlRw0r9tntJLJYfglbjzinrCP7wpriCpkUw5aeB1375ApXAMMFC/9m1paKM
         BkeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698797951; x=1699402751;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Jfb6hOBzZpUnQKwLCoqR3E0xQBxJXpYyz1BMSpxkFw=;
        b=I09G3KZd5/Zt5Xm2Zv7wuhMH4WbOcJGA+TLwf8uxlQKGS2WD0DrL28iv0bHw+HDowX
         K2ewYngSiyl1p6XMc8TmCCi1RVTtTrEfO6UcGz/fXcCpd9GN5cpqAiTMxtuj0+1QlYYs
         bRb31aAiEmkncQWvMEDwLtOQfURE3YEQ/lzKHPgNIxWZJch/ZWyd54SP04Aa4cA00GXK
         B0Rqz3JtLFfnknuJPu1TnVOzE7dF+2jmojSatmFCLiVdFdguhJwEqrIE/nzQY5eYqh6b
         biJ9SUPFLP+I9HAgWDH98uii4WRhRMkW3kviomJ6zvoDvkyf/+P/YVmMdb5jGw/xTvE2
         IOZw==
X-Gm-Message-State: AOJu0YyId7hN3/IF23IU7Zw0IfGwbEq0cJpBMEi08gzb3AUH/bTR9ey/
        5SmYUlgS8PkgsQBIfFjMTNdMMQ==
X-Google-Smtp-Source: AGHT+IHgOyKkx/6qm85zvE+jM4hPpexZwI5ClZVow7qu93SXE6cEmFixVe60F6rBM7Xth6bG6pSb5A==
X-Received: by 2002:a05:6808:1143:b0:3b2:e34f:3495 with SMTP id u3-20020a056808114300b003b2e34f3495mr21939715oiu.33.1698797951261;
        Tue, 31 Oct 2023 17:19:11 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id n21-20020aca2415000000b003af638fd8e4sm65309oic.55.2023.10.31.17.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 17:19:10 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
Date:   Tue, 31 Oct 2023 17:18:52 -0700
Subject: [PATCH v9 2/5] riscv: Add static key for misaligned accesses
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231031-optimize_checksum-v9-2-ea018e69b229@rivosinc.com>
References: <20231031-optimize_checksum-v9-0-ea018e69b229@rivosinc.com>
In-Reply-To: <20231031-optimize_checksum-v9-0-ea018e69b229@rivosinc.com>
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
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
2.34.1

