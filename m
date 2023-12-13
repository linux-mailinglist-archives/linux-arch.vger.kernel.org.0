Return-Path: <linux-arch+bounces-951-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE8081077D
	for <lists+linux-arch@lfdr.de>; Wed, 13 Dec 2023 02:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DB4D282325
	for <lists+linux-arch@lfdr.de>; Wed, 13 Dec 2023 01:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8065A10EA;
	Wed, 13 Dec 2023 01:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="KucCqPgR"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20B6A7
	for <linux-arch@vger.kernel.org>; Tue, 12 Dec 2023 17:18:44 -0800 (PST)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1fab887fab8so4725440fac.0
        for <linux-arch@vger.kernel.org>; Tue, 12 Dec 2023 17:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1702430324; x=1703035124; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hqZmArtiXcDp/s2cDCE6VomUeBtSGPPb+28mpDKaCFA=;
        b=KucCqPgRNdBxdHYCeHek0CTVGOnVnjSG/P+mCD7WFFaXx+L8fQWDm+mlAbTSvqlMXW
         0SUxT7TkIrp+ELx7uigUy9bLMGThdifH228O1/7wS26Pz7DK21lKCO7andEtaEBdMi+x
         sHrQynGAZmszJ+9DDjsZRAZ50WXP0Ip/SmLJ37PZtZKdiy/SIYw4s9gefu8BKKFqPLq9
         1i3Z6hK1oeMKzrVwQLZLRlK2oEJumaTNTZdZJnGT9lBudt9YfPfLU8O6+IFCQxYawRxs
         qNdv/yjgFFcGTri+SiPdE3pUVc65Y4F2JymKDZzkPzZnyYYtXnXN+awWQy0lEII/7aNE
         zSgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702430324; x=1703035124;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hqZmArtiXcDp/s2cDCE6VomUeBtSGPPb+28mpDKaCFA=;
        b=WgBPZO8DdonncMSNSb2KjXRft/+oUXqUhe/MP3iirU9oWQMM34GvZU7D99nF8rjd4I
         FBqzAYatU1VvcORxsyq2SoRurCkXyyyCS12ArhFLRRv+VArHR2+Bg9o8/0UMSud3GS6C
         VE2u2jGplP7tsrI7zE+g4lbUJyU+UV+8T+bJ+agFmpbmWsysrJUmoXFQMgincmEC9ZFl
         1ekrpbViFeU7bV5qNhKYIS7pjdo0hpcrQ81JTpxpLbWqMavG1gv8jahactd6KZ151cKZ
         KYuRvS084bWRtKbGRcmTagBGBLICz9FEVQlK/qa4Nj9/l7QdvAOOQspCaMyMeaonOzn/
         0i3A==
X-Gm-Message-State: AOJu0YwMykvZFVZjhiIN5hsjZUu61W4bgXBp8LoLm1LCjIG3zAQQUu/g
	Cs0uy5AYYugcCA8+RoFdBoJjCQ==
X-Google-Smtp-Source: AGHT+IGsFck0SPpUMTDPNRoS1a9HAh0lw70Bi5Pk17kbqt6QzyhyTNrEMPN91SoWLcSJQPWhOYh+bw==
X-Received: by 2002:a05:6871:20c6:b0:1fb:75c:4001 with SMTP id rz6-20020a05687120c600b001fb075c4001mr8324843oab.97.1702430324255;
        Tue, 12 Dec 2023 17:18:44 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id cy26-20020a056830699a00b006d9a339773csm172548otb.27.2023.12.12.17.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 17:18:43 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Tue, 12 Dec 2023 17:18:39 -0800
Subject: [PATCH v12 2/5] riscv: Add static key for misaligned accesses
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231212-optimize_checksum-v12-2-419a4ba6d666@rivosinc.com>
References: <20231212-optimize_checksum-v12-0-419a4ba6d666@rivosinc.com>
In-Reply-To: <20231212-optimize_checksum-v12-0-419a4ba6d666@rivosinc.com>
To: Charlie Jenkins <charlie@rivosinc.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Conor Dooley <conor@kernel.org>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 David Laight <David.Laight@aculab.com>, Xiao Wang <xiao.w.wang@intel.com>, 
 Evan Green <evan@rivosinc.com>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Arnd Bergmann <arnd@arndb.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702430319; l=2270;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=zAvCCM1AIoiNlx7AQwltNFw7ekzVRWkGRkhZ8BNL3iE=;
 b=mhX85bB1xkJTvDWiO9LH4y8qdkyCuhl0OJGpKcki8af27Bjwiy5p7yu815B3I3qZ0Rfh+lfto
 f1c8q+01P7SDeQ4/BUdp2oRga8T4T4ieW8kC+gZMi3zzM0Sinc2hFWs
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


