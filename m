Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5B6777D8D
	for <lists+linux-arch@lfdr.de>; Thu, 10 Aug 2023 18:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236572AbjHJQGK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Aug 2023 12:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236389AbjHJQFU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Aug 2023 12:05:20 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C263AB5;
        Thu, 10 Aug 2023 09:04:27 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bc6535027aso9464095ad.2;
        Thu, 10 Aug 2023 09:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691683466; x=1692288266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8t2VfLawA9ywP02e+pHf7PaApjxnp0yIluklbdk/jFA=;
        b=Nh56mQoWzqfv+j317jO12KM0T1Osl7MSV0J2qA5WZbPMZWmzNQOlzYGDzuNrR1v1wa
         S2stpUK/8rmn8BD/SKgSRhsbHa7KeAYxMWJnj1IOp75oF+bxYMOd8v10P3W0lCJzuMUs
         /W1ohHneOyTRIiM7hKpxZqpl7zYUVpMbnnqZRMqTFgrs0+y7ZQ1G67zIcR3vU8Z61FEe
         ZdNZlCLCyW+YyH+aP9Vzy8AOS7oz413uXGqmg8XlUb4jzzdQHWbLkpvkawxS3qf6xizi
         n/IlnDUYUt5zVYVtvGujbs4/DBZ2cjT2aG3cWT6KjiF8b4XYyX/fiJLEtHSR4J/q0fOX
         +/jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691683466; x=1692288266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8t2VfLawA9ywP02e+pHf7PaApjxnp0yIluklbdk/jFA=;
        b=RZZf1hs1aTFXkn7LAXo+alwd0RyjxJXUw6UCk89G2ZD5xbLg2Au4ZIExcUlpX1Wg6p
         +dOwaTjGK4emqfCz94OyZMJRZxO14Aali7EykJmN/pPZpBs8V4R0vnT8USHaW5MRbl77
         LD6bhx1Ofe0xParr/Hhoe63nkd1S1rWISTqweeNRdOoYGAawF3MSUUJLtvaEWI5wnegU
         fGlznACdaQuCfJX0PiR4vaGbc1xbJonVavrYzOHBrcvvqL88TSrGWZ/1T8YhJgyBpZKA
         SR7IMrkeK/c1hgb7jR8Qh4d2BpWqFGbat5Q6GxITMmlQnoptyziLMXTQMmarNltgEkdj
         hNOg==
X-Gm-Message-State: AOJu0YzuC1vRhpRV4+q5hgM+DDc3RHWCLqqvjVay/jSk0mrqkYwzrRJE
        Pn+4UXRJfqo8Vfbk1LQ7Me0=
X-Google-Smtp-Source: AGHT+IFXBzf+kdFCbYUkp9r7dbtMlnd6M8F1O0un7ymkvMk+Y4bt2p+RAoc+tNJsE72p6vQxxnEuPQ==
X-Received: by 2002:a17:903:1c5:b0:1b9:e81f:fb08 with SMTP id e5-20020a17090301c500b001b9e81ffb08mr3293438plh.55.1691683465813;
        Thu, 10 Aug 2023 09:04:25 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:0:c620:2003:6c97:8057])
        by smtp.gmail.com with ESMTPSA id r4-20020a1709028bc400b001b895a17429sm1948821plo.280.2023.08.10.09.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 09:04:24 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH V5 3/8] x86/hyperv: Mark Hyper-V vp assist page unencrypted in SEV-SNP enlightened guest
Date:   Thu, 10 Aug 2023 12:04:06 -0400
Message-Id: <20230810160412.820246-4-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230810160412.820246-1-ltykernel@gmail.com>
References: <20230810160412.820246-1-ltykernel@gmail.com>
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

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
 arch/x86/hyperv/hv_init.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 0fd0f82c4f07..547ebf6a03bc 100644
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

