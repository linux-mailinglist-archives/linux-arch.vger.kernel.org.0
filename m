Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBCB1770456
	for <lists+linux-arch@lfdr.de>; Fri,  4 Aug 2023 17:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbjHDPXJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Aug 2023 11:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbjHDPXC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Aug 2023 11:23:02 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47198AC;
        Fri,  4 Aug 2023 08:23:01 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1bc02bd4eafso18920485ad.1;
        Fri, 04 Aug 2023 08:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691162581; x=1691767381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rfduK+LtiEx7csRmg3hNjj/M9RcB35FBofei0BjrvjM=;
        b=YQeNNUep97udHqQLPHfDPgE37kZ1vCY4MnjJflBBzlK48gs46T0yidVw1g38bKbo93
         zVCYV0Etlg7IJ0E1qHhbR9nNZq06e0oafIpIaHHYU4J+d1k78aH9700sqr5UMdNUgNDJ
         tzSB3cUO2e0KKpwQtQxnUb0UutyuEvQMKyfDRKsz1xVeErUL0NbvbzgcXJBwRhULngbm
         eHUmEOEAKBhxoTsjhEZ5lWM8+ayrv8g5crP3LRNCxMiP6Z1Mf7DsfJS6I34s8LZfXKje
         KAE55soEavsxPWmdmXduHcmGHbpA6dNIH1k2+BK+yhEeGBov+sUm6o1y8oq3P/AysFvk
         OU+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691162581; x=1691767381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rfduK+LtiEx7csRmg3hNjj/M9RcB35FBofei0BjrvjM=;
        b=QlstfYREMNoUwTmUeuANn1c8sjIKOB7U+IPY46kQasDTlOIMxFaZrgE7ormn3ABE6C
         PIknKmuSEkQ8e8r3MFNY3kZUQ+Jum0WFE/ZlPvWI0QLoYho8/UP6Kz5eoHIJHjAfcDGV
         DRi1E1Xq9AJYHsQltxKZkm2IUyP/9UcfbQEZ2NwM7AJ5g5aiLXHR5zicdYvMtZUlZ/wk
         RDy6c1sTYdohXR+p17AlITWog7VajlIZUTB/fYgNL+nrUHvfDylw7PTfS8zE2UxQX+oK
         g0hJN0e9zWOznVOQjlmAJMD2UsS3DFVwQwieO6nYALodYETb/ZAVMecIuMFo/IzWBABF
         cBjQ==
X-Gm-Message-State: AOJu0YxlNgZHEdn5i8NFNYMd2qIjoi7CEcKK8ljMDcEbTSWrW+hTXVp0
        orScJRx4zc94YLpsKVtBT28=
X-Google-Smtp-Source: AGHT+IFGR/7lU4GCf3qftPTnwMsrsydQGOF9yR510mo0H/bmM66fINrLigKbO9ZgO/erM8PGI7T/vw==
X-Received: by 2002:a17:902:d303:b0:1b8:b5f8:c485 with SMTP id b3-20020a170902d30300b001b8b5f8c485mr2424548plc.50.1691162580642;
        Fri, 04 Aug 2023 08:23:00 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:f:a0bf:7946:90be:721b])
        by smtp.gmail.com with ESMTPSA id s21-20020a170902989500b001aaf2e8b1eesm1891325plp.248.2023.08.04.08.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 08:23:00 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH V4 2/9] x86/hyperv: Set Virtual Trust Level in VMBus init message
Date:   Fri,  4 Aug 2023 11:22:46 -0400
Message-Id: <20230804152254.686317-3-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230804152254.686317-1-ltykernel@gmail.com>
References: <20230804152254.686317-1-ltykernel@gmail.com>
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

SEV-SNP guests on Hyper-V can run at multiple Virtual Trust
Levels (VTL).  During boot, get the VTL at which we're running
using the GET_VP_REGISTERs hypercall, and save the value
for future use.  Then during VMBus initialization, set the VTL
with the saved value as required in the VMBus init message.

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
* Change since v2:
       Update the change log.
---
 arch/x86/hyperv/hv_init.c          | 36 ++++++++++++++++++++++++++++++
 arch/x86/include/asm/hyperv-tlfs.h |  7 ++++++
 drivers/hv/connection.c            |  1 +
 include/asm-generic/mshyperv.h     |  1 +
 include/linux/hyperv.h             |  4 ++--
 5 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 6c04b52f139b..1ba367a9686e 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -378,6 +378,40 @@ static void __init hv_get_partition_id(void)
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
@@ -506,6 +540,8 @@ void __init hyperv_init(void)
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
index 6b5c41f90398..f73a044ecaa7 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -54,6 +54,7 @@ struct ms_hyperv_info {
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

