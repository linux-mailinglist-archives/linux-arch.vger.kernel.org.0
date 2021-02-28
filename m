Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9033272B8
	for <lists+linux-arch@lfdr.de>; Sun, 28 Feb 2021 16:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbhB1PFB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 28 Feb 2021 10:05:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbhB1PEz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 28 Feb 2021 10:04:55 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9015DC061788;
        Sun, 28 Feb 2021 07:04:14 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id k22so8246076pll.6;
        Sun, 28 Feb 2021 07:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p3g9pt5omNY6bfFlKVCXzHCT2+ov7BMWLm8XBtD3qIY=;
        b=Ec9WyEAM3yQhBwpcpVRUGskDeDWb7XmQo1G8llMyCdayW91y3Lp3iy620GTAovj5kQ
         McX6akF/sK+35OvSo8L0UYmVFQI2/JAf5MQzcoY7mLgscmV8KJtj8fAe1vwj1JGPpjvB
         DygIS5mIU9skM5wX8a4kQSZPGJ+KBcx1sTVuIzPfaYXQX9BGzEyAIb+vTUUTysacPTRJ
         u2to53L4poLxXyOrCRlE+5fIVYWSbA+jHfx9+bLJFrFz0UIBVGMG+49KyPJuarpG8bLQ
         bUnSBvytN0QrzqBPo0QGc1P5XDucficopF2Jef73xMFff+kPKe68ECRTrFC6An4ZsM3U
         cHNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p3g9pt5omNY6bfFlKVCXzHCT2+ov7BMWLm8XBtD3qIY=;
        b=NlCR0qIND86OHvw9UxiHJtZHuMTQ8aGM8TaP9EU9W4rg8IkATo6mF2rrwk4Vueow+J
         buTk8r2iS12VtU6ZFfLS70waUb/iRFtidm45Lq4rSnKXgULdbK7hoeVgZGaS67Mc/YEK
         iACH39SK/270EI7dFygmf5eMpXpsZplSh5cP/Hfnl5c19tXSWyZ8AK8THl+Iqj1ZhvJt
         VIXCToDDos+iIKRa8C3+UnZt0zLBqad5cB7TJnglVQJPKe7ImmJSCi7kG4KpI6hJ8VPe
         s8d4iOJzIXjy5iMyTFIUdI15tL3uAObWMVFR2zo5UHqWCETw4JdoE47yCbp6sowUJfC2
         mTtg==
X-Gm-Message-State: AOAM532J1QYkFO9ym5l6k5IOU8NxGYEjVdtkaTPhxm9+ind820mXqbb5
        vnAD8kx2GcORNkRAaQ/0JJWHYaAcyudw9A==
X-Google-Smtp-Source: ABdhPJyWF0AsoqTHrWsghsR+BxEJgNY+YcJu6Gp7v29FxHs6Ax1beCN+HkAZEruSvLmowH1I3esavg==
X-Received: by 2002:a17:902:8690:b029:e3:91f9:eaeb with SMTP id g16-20020a1709028690b02900e391f9eaebmr11663010plo.34.1614524654185;
        Sun, 28 Feb 2021 07:04:14 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:0:561f:afde:af07:8820])
        by smtp.gmail.com with ESMTPSA id 142sm8391331pfz.196.2021.02.28.07.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Feb 2021 07:04:13 -0800 (PST)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com, arnd@arndb.de
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, vkuznets@redhat.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com,
        sunilmut@microsoft.com
Subject: [RFC PATCH 3/12] x86/HV: Initialize GHCB page and shared memory boundary
Date:   Sun, 28 Feb 2021 10:03:06 -0500
Message-Id: <20210228150315.2552437-4-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210228150315.2552437-1-ltykernel@gmail.com>
References: <20210228150315.2552437-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

Hyper-V exposes GHCB page via SEV ES GHCB MSR for SNP guest
to communicate with hypervisor. Map GHCB page for all
cpus to read/write MSR register and submit hvcall request
via GHCB. Hyper-V also exposes shared memory boundary via
cpuid HYPERV_CPUID_ISOLATION_CONFIG and store it in the
shared_gpa_boundary of ms_hyperv struct. This prepares
to share memory with host for SNP guest.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 arch/x86/hyperv/hv_init.c      | 52 +++++++++++++++++++++++++++++++---
 arch/x86/kernel/cpu/mshyperv.c |  2 ++
 include/asm-generic/mshyperv.h | 14 ++++++++-
 3 files changed, 63 insertions(+), 5 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 0db5137d5b81..90e65fbf4c58 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -82,6 +82,9 @@ static int hv_cpu_init(unsigned int cpu)
 	struct hv_vp_assist_page **hvp = &hv_vp_assist_page[smp_processor_id()];
 	void **input_arg;
 	struct page *pg;
+	u64 ghcb_gpa;
+	void *ghcb_va;
+	void **ghcb_base;
 
 	/* hv_cpu_init() can be called with IRQs disabled from hv_resume() */
 	pg = alloc_pages(irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL, hv_root_partition ? 1 : 0);
@@ -128,6 +131,17 @@ static int hv_cpu_init(unsigned int cpu)
 		wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, val);
 	}
 
+	if (ms_hyperv.ghcb_base) {
+		rdmsrl(MSR_AMD64_SEV_ES_GHCB, ghcb_gpa);
+
+		ghcb_va = ioremap_cache(ghcb_gpa, HV_HYP_PAGE_SIZE);
+		if (!ghcb_va)
+			return -ENOMEM;
+
+		ghcb_base = (void **)this_cpu_ptr(ms_hyperv.ghcb_base);
+		*ghcb_base = ghcb_va;
+	}
+
 	return 0;
 }
 
@@ -223,6 +237,7 @@ static int hv_cpu_die(unsigned int cpu)
 	unsigned long flags;
 	void **input_arg;
 	void *pg;
+	void **ghcb_va = NULL;
 
 	local_irq_save(flags);
 	input_arg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
@@ -236,6 +251,13 @@ static int hv_cpu_die(unsigned int cpu)
 		*output_arg = NULL;
 	}
 
+	if (ms_hyperv.ghcb_base) {
+		ghcb_va = (void **)this_cpu_ptr(ms_hyperv.ghcb_base);
+		if (*ghcb_va)
+			iounmap(*ghcb_va);
+		*ghcb_va = NULL;
+	}
+
 	local_irq_restore(flags);
 
 	free_pages((unsigned long)pg, hv_root_partition ? 1 : 0);
@@ -372,6 +394,9 @@ void __init hyperv_init(void)
 	u64 guest_id, required_msrs;
 	union hv_x64_msr_hypercall_contents hypercall_msr;
 	int cpuhp, i;
+	u64 ghcb_gpa;
+	void *ghcb_va;
+	void **ghcb_base;
 
 	if (x86_hyper_type != X86_HYPER_MS_HYPERV)
 		return;
@@ -432,9 +457,24 @@ void __init hyperv_init(void)
 			VMALLOC_END, GFP_KERNEL, PAGE_KERNEL_ROX,
 			VM_FLUSH_RESET_PERMS, NUMA_NO_NODE,
 			__builtin_return_address(0));
-	if (hv_hypercall_pg == NULL) {
-		wrmsrl(HV_X64_MSR_GUEST_OS_ID, 0);
-		goto remove_cpuhp_state;
+	if (hv_hypercall_pg == NULL)
+		goto clean_guest_os_id;
+
+	if (hv_isolation_type_snp()) {
+		ms_hyperv.ghcb_base = alloc_percpu(void *);
+		if (!ms_hyperv.ghcb_base)
+			goto clean_guest_os_id;
+
+		rdmsrl(MSR_AMD64_SEV_ES_GHCB, ghcb_gpa);
+		ghcb_va = ioremap_cache(ghcb_gpa, HV_HYP_PAGE_SIZE);
+		if (!ghcb_va) {
+			free_percpu(ms_hyperv.ghcb_base);
+			ms_hyperv.ghcb_base = NULL;
+			goto clean_guest_os_id;
+		}
+
+		ghcb_base = (void **)this_cpu_ptr(ms_hyperv.ghcb_base);
+		*ghcb_base = ghcb_va;
 	}
 
 	rdmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
@@ -499,7 +539,8 @@ void __init hyperv_init(void)
 
 	return;
 
-remove_cpuhp_state:
+clean_guest_os_id:
+	wrmsrl(HV_X64_MSR_GUEST_OS_ID, 0);
 	cpuhp_remove_state(cpuhp);
 free_vp_assist_page:
 	kfree(hv_vp_assist_page);
@@ -528,6 +569,9 @@ void hyperv_cleanup(void)
 	 */
 	hv_hypercall_pg = NULL;
 
+	if (ms_hyperv.ghcb_base)
+		free_percpu(ms_hyperv.ghcb_base);
+
 	/* Reset the hypercall page */
 	hypercall_msr.as_uint64 = 0;
 	wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 347c32eac8fd..d6c363456cbf 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -330,6 +330,8 @@ static void __init ms_hyperv_init_platform(void)
 	if (ms_hyperv.features_b & HV_ISOLATION) {
 		ms_hyperv.isolation_config_a = cpuid_eax(HYPERV_CPUID_ISOLATION_CONFIG);
 		ms_hyperv.isolation_config_b = cpuid_ebx(HYPERV_CPUID_ISOLATION_CONFIG);
+		ms_hyperv.shared_gpa_boundary =
+			(u64)1 << ms_hyperv.shared_gpa_boundary_bits;
 
 		pr_info("Hyper-V: Isolation Config: Group A 0x%x, Group B 0x%x\n",
 			ms_hyperv.isolation_config_a, ms_hyperv.isolation_config_b);
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index dff58a3db5d5..ad0e33776668 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -34,7 +34,19 @@ struct ms_hyperv_info {
 	u32 max_vp_index;
 	u32 max_lp_index;
 	u32 isolation_config_a;
-	u32 isolation_config_b;
+	union
+	{
+		u32 isolation_config_b;;
+		struct {
+			u32 cvm_type : 4;
+			u32 Reserved11 : 1;
+			u32 shared_gpa_boundary_active : 1;
+			u32 shared_gpa_boundary_bits : 6;
+			u32 Reserved12 : 20;
+		};
+	};
+	void  __percpu **ghcb_base;
+	u64 shared_gpa_boundary;
 };
 extern struct ms_hyperv_info ms_hyperv;
 
-- 
2.25.1

