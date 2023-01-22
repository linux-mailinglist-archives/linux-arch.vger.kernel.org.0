Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507E8676AAF
	for <lists+linux-arch@lfdr.de>; Sun, 22 Jan 2023 03:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjAVCqV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 21 Jan 2023 21:46:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjAVCqR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 21 Jan 2023 21:46:17 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CC31A4BA;
        Sat, 21 Jan 2023 18:46:16 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id f3so6762383pgc.2;
        Sat, 21 Jan 2023 18:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4HMWUk1NYLJENsgefdfkWCLD2sRZMB9RYEswQeGCc7s=;
        b=h3JJuuB6rADx1MHxkLIycta4gXabf+UX6sWe2K8A1dlwPy+cF7v5WR4NnGdk7i/Ttr
         UIZcrUjH/tM+sn17iO95Enbrv2VNEMrPzsnD+xo3T27jccby4VRbflqQ2pM3of7Ex/lr
         +5PV8xsRIKaS2lV+UxXg7ZUcItqwbo1Q7sbl0i49WtOYE3I+6Z7TZapYD22eAubRaLfC
         0hcqE4JjgkOnYXVYuNN5529Z5gpuk/FcIfc5bp08uTracsh+egQqLC/Q81yZYa0ZCLR+
         O137kXex2d5/PIwq1mF+pFDV7Hz2m173sH0uhoEMp6390e/aY2YN+6TCAGxjqfWzfedQ
         I33A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4HMWUk1NYLJENsgefdfkWCLD2sRZMB9RYEswQeGCc7s=;
        b=cgYio7AlXz2ubI24YBY+3fVNy2WN5hoxzlER9tHHYHqooJS+af8vFyRBJ5EWQxXI3q
         4g839NII8b8u7ePud8WJG+WxRhN2c/bL4bkMCyMjBQJ03A1d5WkZFatExq9cGoq2ioF0
         ES7L2tOrPp5tYVHfxsEy011je3R5Vi0SMlCfgkvCf9O/k5JtqIIR2jd9p2fYGhx4c7qf
         menS/5qyVx6TmtDLiQzneYzY1cPuDziQHo6IcaTUZYjR88EeyglGfANSZLw6hpHORKX3
         jxNF72IxFSH5X0dctQf0IdzG5qq4lLTjQ3XTvJwTDIX5XrjICKTxY8W+5qmNLwfG3kxY
         hFhA==
X-Gm-Message-State: AFqh2krviQ2VGRNP/qSL8TnjAsGclsXe7q3pYpCyfjWM1/9GFsU6Xd64
        351PJshuTydtm+S9YgN78ic=
X-Google-Smtp-Source: AMrXdXvEPu6iaeq12zTvr+TtjIn6yQRqAGvEfTzkVLLlba9Vf7le7b/JTJ1igbLBddp6yEV2lxFAGA==
X-Received: by 2002:a05:6a00:2ba:b0:576:7fb9:85cc with SMTP id q26-20020a056a0002ba00b005767fb985ccmr18626990pfs.14.1674355575792;
        Sat, 21 Jan 2023 18:46:15 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:36:d4:8b9d:a9e7:109b])
        by smtp.gmail.com with ESMTPSA id b75-20020a621b4e000000b0058ba53aaa75sm18523094pfb.99.2023.01.21.18.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 18:46:15 -0800 (PST)
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
Subject: [RFC PATCH V3 03/16] x86/hyperv: Set Virtual Trust Level in vmbus init message
Date:   Sat, 21 Jan 2023 21:45:53 -0500
Message-Id: <20230122024607.788454-4-ltykernel@gmail.com>
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

sev-snp guest provides vtl(Virtual Trust Level) and
get it from hyperv hvcall via HVCALL_GET_VP_REGISTERS.
Set target vtl in the vmbus init message.

Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
Change since RFC v2:
       * Rename get_current_vtl() to get_vtl()
       * Fix some coding style issues
---
 arch/x86/hyperv/hv_init.c          | 37 ++++++++++++++++++++++++++++++
 arch/x86/include/asm/hyperv-tlfs.h |  4 ++++
 drivers/hv/connection.c            |  1 +
 include/asm-generic/mshyperv.h     |  2 ++
 include/linux/hyperv.h             |  4 ++--
 5 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 24154c1ee12b..9e9757049915 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -384,6 +384,40 @@ static void __init hv_get_partition_id(void)
 	local_irq_restore(flags);
 }
 
+static u8 __init get_vtl(void)
+{
+	u64 control = HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_REGISTERS;
+	struct hv_get_vp_registers_input *input = NULL;
+	struct hv_get_vp_registers_output *output = NULL;
+	u64 vtl = 0;
+	int ret;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	input = *(struct hv_get_vp_registers_input **)this_cpu_ptr(hyperv_pcpu_input_arg);
+	output = (struct hv_get_vp_registers_output *)input;
+	if (!input || !output) {
+		local_irq_restore(flags);
+		goto done;
+	}
+
+	memset(input, 0, sizeof(*input) + sizeof(input->element[0]));
+	input->header.partitionid = HV_PARTITION_ID_SELF;
+	input->header.vpindex = HV_VP_INDEX_SELF;
+	input->header.inputvtl = 0;
+	input->element[0].name0 = HV_X64_REGISTER_VSM_VP_STATUS;
+
+	ret = hv_do_hypercall(control, input, output);
+	if (ret == 0)
+		vtl = output->as64.low & HV_X64_VTL_MASK;
+	else
+		pr_err("Hyper-V: failed to get VTL!");
+	local_irq_restore(flags);
+
+done:
+	return vtl;
+}
+
 /*
  * This function is to be invoked early in the boot sequence after the
  * hypervisor has been detected.
@@ -512,6 +546,9 @@ void __init hyperv_init(void)
 	/* Query the VMs extended capability once, so that it can be cached. */
 	hv_query_ext_cap(0);
 
+	/* Find the VTL */
+	ms_hyperv.vtl = get_vtl();
+
 	return;
 
 clean_guest_os_id:
diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index db2202d985bd..6dcbb21aac2b 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -36,6 +36,10 @@
 #define HYPERV_CPUID_MIN			0x40000005
 #define HYPERV_CPUID_MAX			0x4000ffff
 
+/* Support for HVCALL_GET_VP_REGISTERS hvcall */
+#define	HV_X64_REGISTER_VSM_VP_STATUS	0x000D0003
+#define HV_X64_VTL_MASK			GENMASK(3, 0)
+
 /*
  * Group D Features.  The bit assignments are custom to each architecture.
  * On x86/x64 these are HYPERV_CPUID_FEATURES.EDX bits.
diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index f670cfd2e056..e4c39f4016ad 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -98,6 +98,7 @@ int vmbus_negotiate_version(struct vmbus_channel_msginfo *msginfo, u32 version)
 	 */
 	if (version >= VERSION_WIN10_V5) {
 		msg->msg_sint = VMBUS_MESSAGE_SINT;
+		msg->msg_vtl = ms_hyperv.vtl;
 		vmbus_connection.msg_conn_id = VMBUS_MESSAGE_CONNECTION_ID_4;
 	} else {
 		msg->interrupt_page = virt_to_phys(vmbus_connection.int_page);
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index f2c0856f1797..44e56777fea7 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -48,6 +48,7 @@ struct ms_hyperv_info {
 		};
 	};
 	u64 shared_gpa_boundary;
+	u8 vtl;
 };
 extern struct ms_hyperv_info ms_hyperv;
 
@@ -57,6 +58,7 @@ extern void * __percpu *hyperv_pcpu_output_arg;
 extern u64 hv_do_hypercall(u64 control, void *inputaddr, void *outputaddr);
 extern u64 hv_do_fast_hypercall8(u16 control, u64 input8);
 extern bool hv_isolation_type_snp(void);
+extern bool hv_isolation_type_en_snp(void);
 
 /* Helper functions that provide a consistent pattern for checking Hyper-V hypercall status. */
 static inline int hv_result(u64 status)
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 85f7c5a63aa6..65121b21b0af 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -665,8 +665,8 @@ struct vmbus_channel_initiate_contact {
 		u64 interrupt_page;
 		struct {
 			u8	msg_sint;
-			u8	padding1[3];
-			u32	padding2;
+			u8	msg_vtl;
+			u8	reserved[6];
 		};
 	};
 	u64 monitor_page1;
-- 
2.25.1

