Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD4D6D4F46
	for <lists+linux-arch@lfdr.de>; Mon,  3 Apr 2023 19:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbjDCRoW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Apr 2023 13:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbjDCRoO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Apr 2023 13:44:14 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2D11FFD;
        Mon,  3 Apr 2023 10:44:13 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id gp15-20020a17090adf0f00b0023d1bbd9f9eso33452136pjb.0;
        Mon, 03 Apr 2023 10:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680543853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UgABqQg7Pn/Hzm9HMPl9PubPVqr5Bo74B/K3wOK+7x0=;
        b=m6zyjDNmIujNACAnZPNBH+JtlTQO+NSM+A4PqzZtUsVcOHEUT0butES0y/9K5k88cN
         LbTNdMgXryXLF6Y6EinZ9dGvKjTzNDFQ402y/W/Bdg7TvdoDMs1UWsrGqWamPquMWAry
         xvholwMIbB3nU53gIiO6zqRUylVrWd3AB9plxiWrzk4JY3oUL3SS1q5ivQVM2iwmm/mm
         sYuzfn1UT/P2/irJMcICoXWCiRDc5DHkbZQ7Th75B/I0a2VKr2iqng7wCdvoQDmsOisZ
         Xcx2pmr8kY5D22AELD2kjXvEhT/u+h1qwCKQz+cdfnkUeZ70jkkTaDYh4aF7V5D3CETp
         8F3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680543853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UgABqQg7Pn/Hzm9HMPl9PubPVqr5Bo74B/K3wOK+7x0=;
        b=30WbAIAzbJL5L9HHasXpUL9Etw2KXJKsWR6Pv0id0gTUXFCuUzOCuuM7VY+LH8HxEG
         /55Ye7DOeSJ/w1cZ/ibWD0PTA4mM+R7lCTSU2pVTTZwFEMsgE74lAEHVBvgC+yGGCQDS
         HHPgQaySKi1NdO1u80cZZiejT4iClpw4BMSjoDzq+8luYNdPXcvk5Bjv71bZKowX2Rfi
         F/TybsXlTL+8Z7pxNDqempgctm0sfnvKaEzABaGOJURcr9Gp68DsP/QPQ495OTYMeaZW
         UMQ+kwpmHrxMxmVj2cHSMZC0kDyzYvLPZIkAY8ayd5D/Z1+TwiIYVUDoVLCP0zEWNWgq
         iUnw==
X-Gm-Message-State: AAQBX9dvjZUhBzIFfT643vGm29RJ09wiE80YABmZz9sjZaI8UPEJwqXH
        sODkldbqWcr8/MbByoqm1Fs=
X-Google-Smtp-Source: AKy350Z3mjEvpKV3whhnvT+S8Tg91v6ztFgOOYeKgpBXCLwcP5Ii/xxB1iaXadF2QcOQAtEZdo/hGg==
X-Received: by 2002:a17:902:d411:b0:1a1:c8b3:3fe1 with SMTP id b17-20020a170902d41100b001a1c8b33fe1mr29560905ple.31.1680543852787;
        Mon, 03 Apr 2023 10:44:12 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:2:8635:6e96:35c1:c560])
        by smtp.gmail.com with ESMTPSA id jj21-20020a170903049500b001a19196af48sm6883803plb.64.2023.04.03.10.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 10:44:12 -0700 (PDT)
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
Subject: [RFC PATCH V4 02/17] Drivers: hv: vmbus: Decrypt vmbus ring buffer
Date:   Mon,  3 Apr 2023 13:43:50 -0400
Message-Id: <20230403174406.4180472-3-ltykernel@gmail.com>
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

The ring buffer is remapped in the hv_ringbuffer_init()
and it should be with decrypt flag in order to share it
with hypervisor in sev-snp enlightened guest.

Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
 arch/x86/hyperv/hv_init.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index a5f9474f08e1..9f3e2d71d015 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -18,6 +18,7 @@
 #include <asm/hyperv-tlfs.h>
 #include <asm/mshyperv.h>
 #include <asm/idtentry.h>
+#include <asm/set_memory.h>
 #include <linux/kexec.h>
 #include <linux/version.h>
 #include <linux/vmalloc.h>
@@ -113,6 +114,11 @@ static int hv_cpu_init(unsigned int cpu)
 
 	}
 	if (!WARN_ON(!(*hvp))) {
+		if (hv_isolation_type_en_snp()) {
+			WARN_ON_ONCE(set_memory_decrypted((unsigned long)(*hvp), 1));
+			memset(*hvp, 0, PAGE_SIZE);
+		}
+
 		msr.enable = 1;
 		wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, msr.as_uint64);
 	}
-- 
2.25.1

