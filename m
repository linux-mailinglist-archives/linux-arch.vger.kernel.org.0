Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEF177E5D0
	for <lists+linux-arch@lfdr.de>; Wed, 16 Aug 2023 18:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344472AbjHPP7h (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Aug 2023 11:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344503AbjHPP7P (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Aug 2023 11:59:15 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549202721;
        Wed, 16 Aug 2023 08:58:57 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bddac1b7bfso24160345ad.0;
        Wed, 16 Aug 2023 08:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692201537; x=1692806337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mIa9hlZihJbLP1IdtCyi8AC3PEY7CTpUX8AI8533Wno=;
        b=jcNXz17ieHr1V3YRMX+WnHPa2ndIuq+OLSMhV7ejDYLJ+j2iRbi39GfFhYe/RgVE/C
         3JXRFkvzdAbSKmBd1HAj03pJ4qkFz28H0vhY9aG7c8h7RbA34xH/nf+XT5uKg/lY4MM9
         M0rdyt8F+s7nER71+5tzOkDUuFReYgReT8OSZf+Ub6LvUddMiSROOPeugZcfI2xVB89C
         7zF+Kp15dKiYBIzX5XEPacEWq2IeEjVK/RQKgkE7HhWUYZ7PV2g6MtFnLaeR5X0SuvPw
         uB7EuwrUcJJoR8ZVpckh8UoD7ceNJayXfLZWJuCGBCSkNLN5PNIGzHOZU36ubHRsBwGq
         aM2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692201537; x=1692806337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mIa9hlZihJbLP1IdtCyi8AC3PEY7CTpUX8AI8533Wno=;
        b=DVR+omOljAfWAlqNS1TgiQ81bYHytO6ZqGCczUK7UeTtcD4sjUFTE9BOqYvHAOe+He
         RZob9VFcP+0Vgn3vyxakK3vXyFXzoaNsHuNDuA1bX2Tx42UTrsBy11bNneDAF4ktRR6A
         p0XKeUhI6YDUnXiWpWSa9BBECYSmQ4iJCUDv6NMhT0cLMEGavjkn1XCgakSC5f3FApoi
         Lj+4coX74Es5gKDEmd5ypnWgz3LO/MiY3ywOxvvyKv8tf/sX+z+x9oA4Ivtijp645JT3
         YBx6Xwbnb6cp56ZoxABSZpV10NNWADsnTtG3KT9Ka6Ol0Opcp5tgN1QRc6vpDw5Edzib
         tINA==
X-Gm-Message-State: AOJu0YxaCbmDKC7rNgy6CS6sYZhdkFZHip0sutNJ46VYquUD5ObsYQe2
        imxG2SQFC6JaouqAdEWXKeENbMj7s+e5fA==
X-Google-Smtp-Source: AGHT+IHTndPNCpglHs+vb+MWtMNEPGLnTLPm2AMXo6dTjku8EHqpgmxgVNSSKxmbJ6194lzEPH+UMQ==
X-Received: by 2002:a17:902:dac3:b0:1b5:674d:2aa5 with SMTP id q3-20020a170902dac300b001b5674d2aa5mr24330plx.13.1692201536731;
        Wed, 16 Aug 2023 08:58:56 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:0:e588:8d80:9ae5:5adc])
        by smtp.gmail.com with ESMTPSA id h17-20020a170902f7d100b001bc930d4517sm13366973plw.42.2023.08.16.08.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 08:58:56 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH v6 2/8] x86/hyperv: Set Virtual Trust Level in VMBus init message
Date:   Wed, 16 Aug 2023 11:58:43 -0400
Message-Id: <20230816155850.1216996-3-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230816155850.1216996-1-ltykernel@gmail.com>
References: <20230816155850.1216996-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
* Change since v5:
       Remove hvcall input parameter page  check

* Change since v3:
       Call get_vtl() when SEV-SNP is available and set vtl to 0
       by default if fail to get VTL from Hyper-V.
* Change since v2:
       Update the change log.
---
 arch/x86/hyperv/hv_init.c          | 34 ++++++++++++++++++++++++++++++
 arch/x86/include/asm/hyperv-tlfs.h |  7 ++++++
 drivers/hv/connection.c            |  1 +
 include/asm-generic/mshyperv.h     |  1 +
 include/linux/hyperv.h             |  4 ++--
 5 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 6c04b52f139b..f62ca3f6e9b2 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -378,6 +378,36 @@ static void __init hv_get_partition_id(void)
 	local_irq_restore(flags);
 }
 
+static u8 __init get_vtl(void)
+{
+	u64 control = HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_REGISTERS;
+	struct hv_get_vp_registers_input *input;
+	struct hv_get_vp_registers_output *output;
+	unsigned long flags;
+	u64 ret = 0;
+
+	local_irq_save(flags);
+	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	output = (struct hv_get_vp_registers_output *)input;
+
+	memset(input, 0, struct_size(input, element, 1));
+	input->header.partitionid = HV_PARTITION_ID_SELF;
+	input->header.vpindex = HV_VP_INDEX_SELF;
+	input->header.inputvtl = 0;
+	input->element[0].name0 = HV_X64_REGISTER_VSM_VP_STATUS;
+
+	ret = hv_do_hypercall(control, input, output);
+	if (hv_result_success(ret)) {
+		ret = output->as64.low & HV_X64_VTL_MASK;
+	} else {
+		pr_err("Failed to get VTL(%lld) and set VTL to zero by default.\n", ret);
+		ret = 0;
+	}
+
+	local_irq_restore(flags);
+	return ret;
+}
+
 /*
  * This function is to be invoked early in the boot sequence after the
  * hypervisor has been detected.
@@ -506,6 +536,10 @@ void __init hyperv_init(void)
 	/* Query the VMs extended capability once, so that it can be cached. */
 	hv_query_ext_cap(0);
 
+	/* Find the VTL */
+	if (hv_isolation_type_en_snp())
+		ms_hyperv.vtl = get_vtl();
+
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
index 580c766958de..efd0d2aedad3 100644
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

