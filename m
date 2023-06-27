Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D1C73F2A9
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jun 2023 05:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjF0D2y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Jun 2023 23:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjF0D2U (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Jun 2023 23:28:20 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2BF2107;
        Mon, 26 Jun 2023 20:22:55 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-544c0d768b9so3289183a12.0;
        Mon, 26 Jun 2023 20:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687836175; x=1690428175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V1z877s9cdWqHPRWW2XoomxLF4Ko1N0KieO7s3qiybM=;
        b=QAabkL3Ofzm9XDTI/IWFugYTFhTKChrsC0ueRyh4N6Olfut7c8UBUesPAqNxSrg0ee
         bCAlVUcJ7r7ceeC0x4le+45nMSHUdDm/vPJuy9Slh2uFzcc3LTea076asMc+ZyQ8PBz+
         iRdRWZO58T1CUIaYKbLP+iZJwQJETM42r256fnZ/qJHyE3ZbkmZU2bdJ++Gz5DDsb1/d
         2qCEPs9M6LJD9QiSs58f31BX3F/yoghTFbp5pETDlnXDYJusFH5D9bgH5GCxZHkQ9GWx
         6vh355jexv4Jncp9qChheDeEPKOWFNFyWWUY87vpdCj3CcfHSWtTL5IGGw8D4WKPzjgk
         zBPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687836175; x=1690428175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V1z877s9cdWqHPRWW2XoomxLF4Ko1N0KieO7s3qiybM=;
        b=hEXaccSZMlChT5XyY9RFrgUD8hRVfs+2gEkz/dFPwNqzxAUyYCPAtaBgP3YtuWajSn
         hUKC5MacNRMqWPyfN4C5hiCvLrq4gfpPx6vxxuKWEdnVP/nN2nFJHeP8SWbN0okK12W8
         FQLU5jpw7BYl6V/iPw/IxvderXBeYq3ysSgqAJkFAvJEze7AVPEP/MwS3e6WEN2patso
         tAUITaAoFI4d+qOVtz/kU9c1zkQ2yXS8clcFp/Bhr3akpP6LYLK/LNp1wQJ5dZcdt/68
         C8kOOcwsbfXDwXwZQSJnEd4ZKJDIAsps6qD6iXM5dMb4hLECQ3i1xJVbUeUrEhv/6bOD
         aweQ==
X-Gm-Message-State: AC+VfDxinsnLmnIbyd001rfdZlrmeancI/2SmM5nQLKoX2O2lWytzWNB
        rommwM9DMCWTwR11KxSXfYasq75cLeBGpQ==
X-Google-Smtp-Source: ACHHUZ7iTDnZ5NE1qKX2TZOw6G9hJyTpCMSyOiyqniONvH4HTaMyPh3bzrvV4qXmyrvrApT1rXHCLQ==
X-Received: by 2002:a17:90a:550:b0:258:b651:4f80 with SMTP id h16-20020a17090a055000b00258b6514f80mr28854208pjf.36.1687836174790;
        Mon, 26 Jun 2023 20:22:54 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:37:c5e9:2003:6c97:8057])
        by smtp.gmail.com with ESMTPSA id mm12-20020a17090b358c00b0025ec54be16asm618756pjb.2.2023.06.26.20.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 20:22:54 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com
Subject: [PATCH V2 2/9] x86/hyperv: Set Virtual Trust Level in VMBus init message
Date:   Mon, 26 Jun 2023 23:22:40 -0400
Message-Id: <20230627032248.2170007-3-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230627032248.2170007-1-ltykernel@gmail.com>
References: <20230627032248.2170007-1-ltykernel@gmail.com>
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

SEV-SNP guest provides vtl(Virtual Trust Level) and
get it from Hyper-V hvcall via register hvcall HVCALL_
GET_VP_REGISTERS.

During initialization of VMBus, vtl needs to be set in the
VMBus init message.

Signed-off-by: Tianyu Lan <tiala@microsoft.com>
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

