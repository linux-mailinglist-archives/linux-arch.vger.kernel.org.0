Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17E8F676ACA
	for <lists+linux-arch@lfdr.de>; Sun, 22 Jan 2023 03:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjAVCqk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 21 Jan 2023 21:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjAVCqf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 21 Jan 2023 21:46:35 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6EF241E7;
        Sat, 21 Jan 2023 18:46:24 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id 20so6544963pfu.13;
        Sat, 21 Jan 2023 18:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sbUgAHJXFKj0/h7fquHwD/wdAiG1+wRW3iFZ6bjAfVo=;
        b=Q5VAPOY3SQnuTZrIyw1xSxs2JgzIw3shIjHoYRpMCnUfvjjTwvP/BKGuunjS6NY5jZ
         Ci625w3rBRnZBK3U1sdaW/YREjkKN3Ttk71wsnDi4yol/yJxjH2Dl07DqKhv6Vr5xVYr
         6C+t/c+J7llg7IJiHrgcvCPcLqS1kkwC67Vrlg5GtCz8lX0c66rf059xdbhUC++FaW8M
         Zx6ngt4276VOoSJKNApMQG5XS4d1K6Upay7sQjORao/2JjvzfCewswdUGXYY0B9pUvVE
         rveMugJSP3awwnmZs9qvqIL6ZqB9zsDrea5uxgZ62Yh3Y+jR8ZugwILWTnhZY4rnFc8/
         mHrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sbUgAHJXFKj0/h7fquHwD/wdAiG1+wRW3iFZ6bjAfVo=;
        b=O9TD7ucEVddgJ10UR6hdMXmN/8shior1Wwfr7Tv1coNwPwrz2F5OFbICcBIUFc2ink
         q4WBm7M/a9PNCK6Jx11+xVhmhU4ut7cQhLf5lXUbwOXTa+99/3PLMR6aYVbkF3OYuH3B
         Xecsyfvi5B9m2ssjSi+mPaRkdARJDWoiNPWY/5J+gY4uVLeSIrZkeuYG1qZP+qlyhrpP
         g4gCPM06mMVJcxLWDjEMGAlqnzZesoEvRg+JWJNEMBKhOICO/e0sG4JXy1Y9spDIuGyf
         qrWury3tkGYnDiglHi6CFidXoqCVqOOdZMsUvJc6hETEUuFYzPQiZopyEwfjzWolKPP4
         DrBw==
X-Gm-Message-State: AFqh2kq8XCSLfKUk51+LjKXoKZWYoB1Knnj4pJbAK3sk0eVgZBWZA/zY
        YvZUNBTBZHO8Es8IscnUiX4=
X-Google-Smtp-Source: AMrXdXvUbjpvISFSYNBx+covuQ35XEsn7ZCKNFYhnCygXEhRGI2/2LiBOSghuNPgGh0dH0T+H9NE/A==
X-Received: by 2002:a62:150f:0:b0:58d:b5bd:e4fe with SMTP id 15-20020a62150f000000b0058db5bde4femr22013000pfv.13.1674355584229;
        Sat, 21 Jan 2023 18:46:24 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:36:d4:8b9d:a9e7:109b])
        by smtp.gmail.com with ESMTPSA id b75-20020a621b4e000000b0058ba53aaa75sm18523094pfb.99.2023.01.21.18.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 18:46:23 -0800 (PST)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, seanjc@google.com, pbonzini@redhat.com,
        jgross@suse.com, tiala@microsoft.com, kirill@shutemov.name,
        jiangshan.ljs@antgroup.com, peterz@infradead.org,
        ashish.kalra@amd.com, srutherford@google.com,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        pawan.kumar.gupta@linux.intel.com, adrian.hunter@intel.com,
        daniel.sneddon@linux.intel.com, alexander.shishkin@linux.intel.com,
        sandipan.das@amd.com, ray.huang@amd.com, brijesh.singh@amd.com,
        michael.roth@amd.com, thomas.lendacky@amd.com,
        venu.busireddy@oracle.com, sterritt@google.com,
        tony.luck@intel.com, samitolvanen@google.com, fenghua.yu@intel.com
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [RFC PATCH V3 09/16] x86/hyperv: SEV-SNP enlightened guest don't support legacy rtc
Date:   Sat, 21 Jan 2023 21:45:59 -0500
Message-Id: <20230122024607.788454-10-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230122024607.788454-1-ltykernel@gmail.com>
References: <20230122024607.788454-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <tiala@microsoft.com>

SEV-SNP enlightened guest doesn't support legacy rtc. Set
legacy.rtc, x86_platform.set_wallclock and get_wallclock to
0 or noop(). Make get/set_rtc_noop() to be public and reuse
them in the ms_hyperv_init_platform().

Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
 arch/x86/include/asm/mshyperv.h | 7 ++++++-
 arch/x86/include/asm/x86_init.h | 2 ++
 arch/x86/kernel/cpu/mshyperv.c  | 3 +++
 arch/x86/kernel/x86_init.c      | 4 ++--
 4 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 1a4af0a4f29a..7266d71d30d6 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -33,6 +33,12 @@ extern bool hv_isolation_type_en_snp(void);
 
 extern union hv_ghcb * __percpu *hv_ghcb_pg;
 
+/*
+ * Hyper-V puts processor and memory layout info
+ * to this address in SEV-SNP enlightened guest.
+ */
+#define EN_SEV_SNP_PROCESSOR_INFO_ADDR	0x802000
+
 int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
 int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
 int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags);
@@ -267,7 +273,6 @@ static inline void hv_set_register(unsigned int reg, u64 value) { }
 static inline u64 hv_get_register(unsigned int reg) { return 0; }
 #endif /* CONFIG_HYPERV */
 
-
 #include <asm-generic/mshyperv.h>
 
 #endif
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index c1c8c581759d..d8fb3a1639e9 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -326,5 +326,7 @@ extern void x86_init_uint_noop(unsigned int unused);
 extern bool bool_x86_init_noop(void);
 extern void x86_op_int_noop(int cpu);
 extern bool x86_pnpbios_disabled(void);
+extern int set_rtc_noop(const struct timespec64 *now);
+extern void get_rtc_noop(struct timespec64 *now);
 
 #endif
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index b1871a7bb4c9..197c8f2ec4eb 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -508,6 +508,9 @@ static void __init ms_hyperv_init_platform(void)
 		 * bios regions and reserve resources are not
 		 * available. Set these callback to NULL.
 		 */
+		x86_platform.legacy.rtc = 0;
+		x86_platform.set_wallclock = set_rtc_noop;
+		x86_platform.get_wallclock = get_rtc_noop;
 		x86_platform.legacy.reserve_bios_regions = x86_init_noop;
 		x86_init.resources.probe_roms = x86_init_noop;
 		x86_init.resources.reserve_resources = x86_init_noop;
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index ef80d361b463..d93aeffec19b 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -33,8 +33,8 @@ static int __init iommu_init_noop(void) { return 0; }
 static void iommu_shutdown_noop(void) { }
 bool __init bool_x86_init_noop(void) { return false; }
 void x86_op_int_noop(int cpu) { }
-static __init int set_rtc_noop(const struct timespec64 *now) { return -EINVAL; }
-static __init void get_rtc_noop(struct timespec64 *now) { }
+int set_rtc_noop(const struct timespec64 *now) { return -EINVAL; }
+void get_rtc_noop(struct timespec64 *now) { }
 
 static __initconst const struct of_device_id of_cmos_match[] = {
 	{ .compatible = "motorola,mc146818" },
-- 
2.25.1

