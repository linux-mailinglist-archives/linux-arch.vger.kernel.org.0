Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F746F2F77
	for <lists+linux-arch@lfdr.de>; Mon,  1 May 2023 10:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbjEAI5k (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 May 2023 04:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbjEAI5e (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 May 2023 04:57:34 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6F1F9;
        Mon,  1 May 2023 01:57:33 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1aaea3909d1so12312135ad.2;
        Mon, 01 May 2023 01:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682931453; x=1685523453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v9VLdJ07x1krlNyXoh03R/V3Urrhl3Ftr0jW7RppoA8=;
        b=OAHWsXjqCza9GGkQIsMltKZ/xNNn2XdUn1BJla878XTHCVVOn9oRSc+7lC75LBscjk
         wTE15QGmJfIP+TH0TOna7U5/mTBvQjvDensIWmWnoY4L77eSS6cLF3HshSexyzAPpT5U
         h2vL27ccj8Sf6VjXU2JfQqd+6Sj94brmV9eJTipjwM6uanceCl2zZZaqsHjMYA/OWAfr
         lE2JW0d+EctJlnIZPm8z4kU2WYkPo6pyX53k2LAJ4HUjrXiG2o3pMHBzPShTeNEjmShy
         ukuMOmeb6OkxSnVOlLjI914zPKTCJnFYBR30m34kPAtq2inn+vvq2Y8kMQuPVAhpe1d3
         vbmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682931453; x=1685523453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v9VLdJ07x1krlNyXoh03R/V3Urrhl3Ftr0jW7RppoA8=;
        b=UhCk59m8StmcoTWc9HypIX7kjmtgwvINJ2acuUq7Z9atvZTsfFMdTXACBmuag4+zOf
         FkAyfuZpjqtf3blxZBW2uLEDYCPiFFfDd/2U0GJ6G1bg1XcBGmM0p5uaH+ZKbERod9CL
         imTn7wxI+zszsirNNzcTaR5H7pEHVSLrvSa7eRvI2NX1j2rJNH8RdfuTw3MatU98nN00
         JBoBpilb7iCbEIJTLQmC7LHQKZLXkLpIqD1+72N16lzLTWJy+LR8U3J7YKvy8ZHkrEBv
         FaXiRa3VtGkzZa/tXnAdmuM0nXOPxkuCa/IRTs2+3/TsIB5EL9FmWP8Ar7N9DwujJ8GR
         k06Q==
X-Gm-Message-State: AC+VfDzgzdzKhZl3z22dje1I8tpftKz4L+FVWMIX7suLGTc6ykv2seXF
        RSii3pcfXI3okRtiCi+qXKE=
X-Google-Smtp-Source: ACHHUZ6+e0MQ/Y769nSf4YpXEqHW9NOhctlQqSJ5uxHaxs6P+3FzTJI0Ai28PLEkCPx4pB89V1Go/g==
X-Received: by 2002:a17:902:d585:b0:1a6:6b9d:5e12 with SMTP id k5-20020a170902d58500b001a66b9d5e12mr13386461plh.8.1682931452761;
        Mon, 01 May 2023 01:57:32 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:b:e11b:15ea:ad44:bde7])
        by smtp.gmail.com with ESMTPSA id t13-20020a1709028c8d00b001a4fe00a8d4sm17407070plo.90.2023.05.01.01.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 01:57:32 -0700 (PDT)
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
Subject: [RFC PATCH V5 02/15] x86/hyperv: Decrypt hv vp assist page in sev-snp enlightened guest
Date:   Mon,  1 May 2023 04:57:12 -0400
Message-Id: <20230501085726.544209-3-ltykernel@gmail.com>
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

hv vp assist page is shared between sev snp guest and hyperv. Decrypt
the page when use it.

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

