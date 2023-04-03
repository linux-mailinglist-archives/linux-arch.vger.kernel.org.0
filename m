Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBF56D4F48
	for <lists+linux-arch@lfdr.de>; Mon,  3 Apr 2023 19:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbjDCRoY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Apr 2023 13:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbjDCRoS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Apr 2023 13:44:18 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6B02114;
        Mon,  3 Apr 2023 10:44:14 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id f6-20020a17090ac28600b0023b9bf9eb63so31369029pjt.5;
        Mon, 03 Apr 2023 10:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680543854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CizkYYSOlAsJPe03D8rmOV0gOBSN8nSrbNEPB/ot/CQ=;
        b=Hf9bG1s/shcJEEZGFOwmA96pHybN+72axE9tV+SYvePQjub19rmz7dUlO/mSUWuO4Q
         IkvilGjqL8wpqMm8XNw9absyyc4Wzno2YaW3DtPe5ajk7D8mh3JCxRRDrQH8p/yNmy3Q
         tu3idvP4NwClNZ5ObG0SMmmbtnATX+VLQmkLQkCY7pAcAdut0QSS8pDEwZJt9iCRCAia
         jamoT2yFcuNNpWwAHq9jnu8KD0IHYuDx+reiEwDKKV5TAuuXZzOSevUklgJElr7gRA5n
         jJvW8g9UIkG806oET4visFhJSMnQ5AahCTGOGUdQY2sEv/R7oZoaNa1pRDwhimPvDyzx
         QnsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680543854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CizkYYSOlAsJPe03D8rmOV0gOBSN8nSrbNEPB/ot/CQ=;
        b=qLqG2t8Qtaaz9YuKD1xD1HkIYjX94wID2ivXKyMAvH/GETEd7fLQ0BpetaYOocIWgv
         wCFmwGswTPKga0zSjvptxzZKX71PfdleWutolnF8vuFrhkFJRbePGErJpbTp+0hID9lC
         MpQROF6YCyNAefzIul3E14qWjHM0mpl0M5FK37oOOBUV5DDxv+oGQdgnufkHxKYz+gz4
         oTte24yDWNRTprIlbLL0mLiPj9w0u9bR6qceNhq6vjgs58md5z+m5Lw7ePfIPWPHIQjO
         K9Rt/3P9G7qpLAerTh34cw4AKQl0kfSU+ZV6oh69hDUeQP4G3+bZJHeVygCG7ZUXs6sh
         uRLA==
X-Gm-Message-State: AAQBX9eqe36VRwFMt1DKpGKvXBDfjK4/2cx5+kp/ZmbEMusd+qacLQfO
        OGGOz+Hmse183jc8boyWLyA=
X-Google-Smtp-Source: AKy350ahr1LccUTgtxrRakmD2iirEWBU/Y6C+6hduhZ/hoRdZ0l+1F/0dUh0cEDOJaFt8YS1rwaPlg==
X-Received: by 2002:a17:902:c404:b0:19f:2328:beee with SMTP id k4-20020a170902c40400b0019f2328beeemr47498322plk.11.1680543854233;
        Mon, 03 Apr 2023 10:44:14 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:2:8635:6e96:35c1:c560])
        by smtp.gmail.com with ESMTPSA id jj21-20020a170903049500b001a19196af48sm6883803plb.64.2023.04.03.10.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 10:44:13 -0700 (PDT)
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
Cc:     pangupta@amd.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [RFC PATCH V4 03/17] x86/hyperv: Set Virtual Trust Level in VMBus init message
Date:   Mon,  3 Apr 2023 13:43:51 -0400
Message-Id: <20230403174406.4180472-4-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230403174406.4180472-1-ltykernel@gmail.com>
References: <20230403174406.4180472-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <tiala@microsoft.com>

sev-snp guest provides vtl(Virtual Trust Level) and
get it from hyperv hvcall via HVCALL_GET_VP_REGISTERS.
Set target vtl in the VMBus init message.

Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
Change since RFC v3:
       * Use the standard helper functions to check hypercall result
       * Fix coding style

Change since RFC v2:
       * Rename get_current_vtl() to get_vtl()
       * Fix some coding style issues
---
 arch/x86/hyperv/hv_init.c          | 36 ++++++++++++++++++++++++++++++
 arch/x86/include/asm/hyperv-tlfs.h |  7 ++++++
 drivers/hv/connection.c            |  1 +
 include/asm-generic/mshyperv.h     |  2 ++
 include/linux/hyperv.h             |  4 ++--
 5 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 9f3e2d71d015..7602db5ad4aa 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -384,6 +384,40 @@ static void __init hv_get_partition_id(void)
 	local_irq_restore(flags);
 }
 
+static u8 __init get_vtl(void)
+{
+	u64 control = HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_REGISTERS;
+	struct hv_get_vp_registers_input *input;
+	struct hv_get_vp_registers_output *output;
+	u64 vtl = 0;
+	u64 ret;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	input = *(struct hv_get_vp_registers_input **)this_cpu_ptr(hyperv_pcpu_input_arg);
+	output = (struct hv_get_vp_registers_output *)input;
+	if (!input) {
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
+	if (hv_result_success(ret))
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
@@ -512,6 +546,8 @@ void __init hyperv_init(void)
 	/* Query the VMs extended capability once, so that it can be cached. */
 	hv_query_ext_cap(0);
 
+	/* Find the VTL */
+	ms_hyperv.vtl = get_vtl();
 	return;
 
 clean_guest_os_id:
diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index b4fb75bd1013..3d3f014976e8 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -301,6 +301,13 @@ enum hv_isolation_type {
 #define HV_X64_MSR_TIME_REF_COUNT	HV_REGISTER_TIME_REF_COUNT
 #define HV_X64_MSR_REFERENCE_TSC	HV_REGISTER_REFERENCE_TSC
 
+/*
+ * Registers are only accessible via HVCALL_GET_VP_REGISTERS hvcall and
+ * there is not associated MSR address.
+ */
+#define	HV_X64_REGISTER_VSM_VP_STATUS	0x000D0003
+#define	HV_X64_VTL_MASK			GENMASK(3, 0)
+
 /* Hyper-V memory host visibility */
 enum hv_mem_host_visibility {
 	VMBUS_PAGE_NOT_VISIBLE		= 0,
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
index afcd9ae9588c..f91fb06634f0 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -48,6 +48,7 @@ struct ms_hyperv_info {
 		};
 	};
 	u64 shared_gpa_boundary;
+	u8 vtl;
 };
 extern struct ms_hyperv_info ms_hyperv;
 extern bool hv_nested;
@@ -58,6 +59,7 @@ extern void * __percpu *hyperv_pcpu_output_arg;
 extern u64 hv_do_hypercall(u64 control, void *inputaddr, void *outputaddr);
 extern u64 hv_do_fast_hypercall8(u16 control, u64 input8);
 extern bool hv_isolation_type_snp(void);
+extern bool hv_isolation_type_en_snp(void);
 
 /* Helper functions that provide a consistent pattern for checking Hyper-V hypercall status. */
 static inline int hv_result(u64 status)
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index bfbc37ce223b..1f2bfec4abde 100644
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

