Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E54C6D4F5F
	for <lists+linux-arch@lfdr.de>; Mon,  3 Apr 2023 19:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbjDCRo4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Apr 2023 13:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbjDCRop (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Apr 2023 13:44:45 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0183588;
        Mon,  3 Apr 2023 10:44:25 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id kc4so28791105plb.10;
        Mon, 03 Apr 2023 10:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680543865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wR0AzrPzYG8OJqqCg/MeK2RAGKVdybTSl0W3QOrUJm4=;
        b=SY9MAvUMv0Z6B9kvhH9fJTPTFmqJueX5AK4+E8LO50Nza65kNzX6ERGapqjeiZxU6z
         2531ngDn6jSFzmuGYp4z2ECysW9mulBaLiDMP7qwOc50HTQ/n7gar9Nwpo75Lpa3Q7DY
         OaM+PEYGs20eN5RaNUIR3lmvVUJFl+b/3i8CddQqB4mP/6+orFhbDViWs+3lC0KZTM3G
         v3nF6MCFW2Fa1vD9TYhNEqKRurm9sV+fW6Fuwb8L+2NCVA1DYw8v6qI4JE/zUmHphrqE
         P7Nx18D/4bKXevy8r6xXO8qOLCOy2jNkueGLcVrl9CXs++nGPg/Flej+NY3mEFjfP3lF
         YUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680543865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wR0AzrPzYG8OJqqCg/MeK2RAGKVdybTSl0W3QOrUJm4=;
        b=i8aVRY9ryP2W2Oj+sBmQiTyNqzXoljr6BywlP+IvsL9bIcqN97F5BWOPqPPrI4WwyT
         /7fZTfWEQgrGz/wl4S91AFgwRlLMKVzwQ0BE1owUKKHxUIIOmDe38wL6eKIdPEQMp31v
         1lAuPPHxie+ikHNFZQWa1m08tCcBUJJR67KyPXwFf15zRUKA66Ocuc/Wp2iOSR/rY/XJ
         htsiFbo//JgWBjKhKRpFlvJgia650AG5VhdDZjPTTw+0F0zpvBS8o6q+ieLzZnXGshFL
         leAoSDYtCtwstDA6D6m2puE7IS5utM3gxNinz7TuTX/SR2CnOMt09BxngRgIyAayh1Ne
         FcXg==
X-Gm-Message-State: AAQBX9c5Et99zlc5l96P/0707f4hPy0h5VuQ4c/pqqQp92WSvYb0lfeY
        Kn5LgkWkTNmtWWTwx49Wk9s=
X-Google-Smtp-Source: AKy350Ymu8g42Sls7u3/3eR7Wme8+uJHZttkV5AzLFy780UTDLk8y3o19x52ab6AosSxwAna7OMxQg==
X-Received: by 2002:a17:902:f283:b0:1a0:7065:e000 with SMTP id k3-20020a170902f28300b001a07065e000mr29673761plc.14.1680543864770;
        Mon, 03 Apr 2023 10:44:24 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:2:8635:6e96:35c1:c560])
        by smtp.gmail.com with ESMTPSA id jj21-20020a170903049500b001a19196af48sm6883803plb.64.2023.04.03.10.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 10:44:24 -0700 (PDT)
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
Subject: [RFC PATCH V4 11/17] x86/hyperv: Add hyperv-specific handling for VMMCALL under SEV-ES
Date:   Mon,  3 Apr 2023 13:43:59 -0400
Message-Id: <20230403174406.4180472-12-ltykernel@gmail.com>
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

Add Hyperv-specific handling for faults caused by VMMCALL
instructions.

Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
 arch/x86/kernel/cpu/mshyperv.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 829234ba8da5..69ca4b8f615a 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -32,6 +32,7 @@
 #include <asm/nmi.h>
 #include <clocksource/hyperv_timer.h>
 #include <asm/numa.h>
+#include <asm/svm.h>
 
 /* Is Linux running as the root partition? */
 bool hv_root_partition;
@@ -577,6 +578,20 @@ static bool __init ms_hyperv_msi_ext_dest_id(void)
 	return eax & HYPERV_VS_PROPERTIES_EAX_EXTENDED_IOAPIC_RTE;
 }
 
+static void hv_sev_es_hcall_prepare(struct ghcb *ghcb, struct pt_regs *regs)
+{
+	/* RAX and CPL are already in the GHCB */
+	ghcb_set_rcx(ghcb, regs->cx);
+	ghcb_set_rdx(ghcb, regs->dx);
+	ghcb_set_r8(ghcb, regs->r8);
+}
+
+static bool hv_sev_es_hcall_finish(struct ghcb *ghcb, struct pt_regs *regs)
+{
+	/* No checking of the return state needed */
+	return true;
+}
+
 const __initconst struct hypervisor_x86 x86_hyper_ms_hyperv = {
 	.name			= "Microsoft Hyper-V",
 	.detect			= ms_hyperv_platform,
@@ -584,4 +599,6 @@ const __initconst struct hypervisor_x86 x86_hyper_ms_hyperv = {
 	.init.x2apic_available	= ms_hyperv_x2apic_available,
 	.init.msi_ext_dest_id	= ms_hyperv_msi_ext_dest_id,
 	.init.init_platform	= ms_hyperv_init_platform,
+	.runtime.sev_es_hcall_prepare = hv_sev_es_hcall_prepare,
+	.runtime.sev_es_hcall_finish = hv_sev_es_hcall_finish,
 };
-- 
2.25.1

