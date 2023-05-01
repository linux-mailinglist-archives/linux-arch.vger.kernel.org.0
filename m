Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 867716F2F76
	for <lists+linux-arch@lfdr.de>; Mon,  1 May 2023 10:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbjEAI5i (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 May 2023 04:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbjEAI5g (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 May 2023 04:57:36 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A614DE77;
        Mon,  1 May 2023 01:57:34 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-64115e652eeso25489117b3a.0;
        Mon, 01 May 2023 01:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682931454; x=1685523454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6uYxV2dI/hb2rcrfooNSE6OrsK+/8Zb/z3h9orwCels=;
        b=C8uDAffQ6OHhqsfIO6Bq+5eTpKEILlK/GOpTu6rUfZvywEB76ytGf8lbazIOR7RQQm
         skQ5YvkOWDrA2OBKN1sODMUuPJTycrL1eGUHhcCQcIQ58UQFlRGh8MBIJWSLlmcRblmb
         3rxU5Q6hzz8rdy/+deCqoi4vJgKDMLoOwEXcLcKDjcrAuBeeStzaOSZmWEeMRaOzqFpI
         /qHGtbbC0bC5ekIQeqa3xIgbJBnR4tj2hhMxmEsaDqtqE1cFcV/PylIU3GESvRe78xa0
         +nyvIGwIcxAibNTg1Y6rloLSRyVgZ3UoFpmI6RVwrpVYFrL8dRuQCVuRp4Q9qH5FVdUl
         IX0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682931454; x=1685523454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6uYxV2dI/hb2rcrfooNSE6OrsK+/8Zb/z3h9orwCels=;
        b=UkWfriVuEA1bgnZ7xhfAIA5b70XnLUmKTsiFRcGesetPk9m9jgGoxQqQ3zu3jYFSNY
         ezBT9cBg274jzmQpUeu2SyX4coCoSwveMay/qH8NHzKM1CMNAU5oAdhAWa0o5XTPnNiQ
         85dzCllhfDdVBoazmMJGt4MyiuuaYHqI5fvxLZvOsqenNux8EvSsOp0xLsyt7kypoeAF
         oXaNZAAocF1FQ2xSy+EUHfP3PetNKZmIYV2yhlPm5lgqW5U7j7H2cIs3fwIpqjF8ApGb
         HxGUPwVIN9MPj4OHURBOSwEKPw0MXHB8HzhOKYkfpyUt0+zKr0q5MydynA20lejHJx1F
         GJfQ==
X-Gm-Message-State: AC+VfDzmuWj6F2g6+4kjkoeOunoP7ZLmD9HktXhoCeRU0HuW62JZHj9H
        c18GWZRIElnSbE8kYTfOq5U=
X-Google-Smtp-Source: ACHHUZ7cvb0mCeWDDY43OW9x5ugQOQdr9CWHyT9lhwZk2ZnwbZrVvHE4XgLdkwaIL+bl9uTCm+SsPg==
X-Received: by 2002:a17:902:e550:b0:1a9:7dc2:9427 with SMTP id n16-20020a170902e55000b001a97dc29427mr21398307plf.21.1682931454093;
        Mon, 01 May 2023 01:57:34 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:b:e11b:15ea:ad44:bde7])
        by smtp.gmail.com with ESMTPSA id t13-20020a1709028c8d00b001a4fe00a8d4sm17407070plo.90.2023.05.01.01.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 01:57:33 -0700 (PDT)
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
Subject: [RFC PATCH V5 03/15] x86/hyperv: Set Virtual Trust Level in VMBus init message
Date:   Mon,  1 May 2023 04:57:13 -0400
Message-Id: <20230501085726.544209-4-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230501085726.544209-1-ltykernel@gmail.com>
References: <20230501085726.544209-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
Change since RFC v4:
       * Use struct_size to calculate array size.
       * Fix some coding style

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
 include/asm-generic/mshyperv.h     |  1 +
 include/linux/hyperv.h             |  4 ++--
 5 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 9f3e2d71d015..331b855314b7 100644
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
+	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	output = (struct hv_get_vp_registers_output *)input;
+	if (!input) {
+		local_irq_restore(flags);
+		goto done;
+	}
+
+	memset(input, 0, struct_size(input, element, 1));
+	input->header.partitionid = HV_PARTITION_ID_SELF;
+	input->header.vpindex = HV_VP_INDEX_SELF;
+	input->header.inputvtl = 0;
+	input->element[0].name0 = HV_X64_REGISTER_VSM_VP_STATUS;
+
+	ret = hv_do_hypercall(control, input, output);
+	if (hv_result_success(ret))
+		vtl = output->as64.low & HV_X64_VTL_MASK;
+	else
+		pr_err("Hyper-V: failed to get VTL! %lld", ret);
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
index cea95dcd27c2..4bf0b315b0ce 100644
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
index 5978e9dbc286..02b54f85dc60 100644
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
index 402a8c1c202d..3052130ba4ef 100644
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

