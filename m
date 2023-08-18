Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C227780A18
	for <lists+linux-arch@lfdr.de>; Fri, 18 Aug 2023 12:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359734AbjHRKaA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Aug 2023 06:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359618AbjHRK33 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Aug 2023 06:29:29 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F77026A8;
        Fri, 18 Aug 2023 03:29:28 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1bdbbede5d4so6037485ad.2;
        Fri, 18 Aug 2023 03:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692354568; x=1692959368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pvSAuyt/NrMOTkfJms1m8PkJx0KwhqwmDNJRjHSleGc=;
        b=Oz3rKM1lWvWy+AIVc9/yDP1ZjuE+F3I5CsucO0ID3/0mwy4DsPkFQYpbHUoHye+8aM
         2NxWw2xWYYVNuEjYiNE7DXrjh4MC6wnT9WDeqBN04+QeuuHRYbalXj87B5LhQcXaMWhp
         JzwXoCIG528tEQX79umhpHD+6C9u9jrs7rv5Wn7et/ZXNIBcuEOb0aq+Y8iCI1MxYxhO
         PB6JfVv9TZG9asx3LNmB8WfINN4Tu6NN7Keb1OIEtGArViwSe1s9cG+HRE9hVfmfS1QD
         XMmKhvMBUSeoVFHXQDHFNwrN1EjcXKMWR9XtVlR6H1jXtBDi0Jo1gGl54dMowNixq51o
         D3iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692354568; x=1692959368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pvSAuyt/NrMOTkfJms1m8PkJx0KwhqwmDNJRjHSleGc=;
        b=BmSMR79T02sZHgzXHuBGRkmWUWRhB7HAon26+6s8oycUW/pDbeyzzt+4yadGwy9myj
         7DD/GSsHTNqBBVWHXuQIFbWYCl7AGDSYARMw9bMeCPNJesJkST4V1q8Ki7rn77cEs/8c
         264FH0qmSR8PFzXS3Uf8Q4LzuhISjHAmgPLhY8fo2Q2SPYj/FIit3Kj9DSHefiNi0MiX
         JW4KjfI1ihslF/pFDK1HCCs5YMORcIVFBdSDYgR0MhpBQdFmnpjjnVH58rWPzJr9Ozs9
         nHCU+wvqftHmXACc402zXKwLhxM01smSoimRD36Bwdkwxpru+jrfOhdUm0G2oyqReuUQ
         2Hfg==
X-Gm-Message-State: AOJu0Yx2k2Fx+RKB9EJO93M1hUhvyyxUduWRMarlO3VEwh3HFKS4wYWl
        HdDjhwFRx9PFqdKrZ9m8l5oViUnb5rBhfijH
X-Google-Smtp-Source: AGHT+IHAkOwWF9WSnHVQ9FkpQWycpjwO4WCI2N6V/cm0vEBNFRbNHsf3BeqLlr6n/eN5KhYVRKd8Gg==
X-Received: by 2002:a17:902:d38d:b0:1bc:16bc:9f66 with SMTP id e13-20020a170902d38d00b001bc16bc9f66mr2157093pld.12.1692354567685;
        Fri, 18 Aug 2023 03:29:27 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:7:4545:4938:97f0:2e1f])
        by smtp.gmail.com with ESMTPSA id f1-20020a17090274c100b001b9be79729csm1386766plt.165.2023.08.18.03.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 03:29:27 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH v7 3/8] x86/hyperv: Mark Hyper-V vp assist page unencrypted in SEV-SNP enlightened guest
Date:   Fri, 18 Aug 2023 06:29:13 -0400
Message-Id: <20230818102919.1318039-4-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230818102919.1318039-1-ltykernel@gmail.com>
References: <20230818102919.1318039-1-ltykernel@gmail.com>
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

hv vp assist page needs to be shared between SEV-SNP guest and Hyper-V.
So mark the page unencrypted in the SEV-SNP guest.

Reviewed-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
 arch/x86/hyperv/hv_init.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 318010eb9f9e..bcfbcda8b050 100644
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
@@ -106,8 +107,21 @@ static int hv_cpu_init(unsigned int cpu)
 		 * in hv_cpu_die(), otherwise a CPU may not be stopped in the
 		 * case of CPU offlining and the VM will hang.
 		 */
-		if (!*hvp)
+		if (!*hvp) {
 			*hvp = __vmalloc(PAGE_SIZE, GFP_KERNEL | __GFP_ZERO);
+
+			/*
+			 * Hyper-V should never specify a VM that is a Confidential
+			 * VM and also running in the root partition. Root partition
+			 * is blocked to run in Confidential VM. So only decrypt assist
+			 * page in non-root partition here.
+			 */
+			if (*hvp && hv_isolation_type_en_snp()) {
+				WARN_ON_ONCE(set_memory_decrypted((unsigned long)(*hvp), 1));
+				memset(*hvp, 0, PAGE_SIZE);
+			}
+		}
+
 		if (*hvp)
 			msr.pfn = vmalloc_to_pfn(*hvp);
 
-- 
2.25.1

