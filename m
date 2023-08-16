Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7B777E5D3
	for <lists+linux-arch@lfdr.de>; Wed, 16 Aug 2023 18:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344469AbjHPP7g (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Aug 2023 11:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344505AbjHPP7Q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Aug 2023 11:59:16 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CC42717;
        Wed, 16 Aug 2023 08:58:58 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bdc19b782aso32872805ad.0;
        Wed, 16 Aug 2023 08:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692201538; x=1692806338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D8Cow/VKryneABUkqxkXvlZxe3G46QYofSoSSKW5bFM=;
        b=G7eKQh7xtXM62LiAqJASQfZoG5jSgumdfXMWnAhtVxmpFZ2wPLkfCw0k+uwQJB+k0G
         c7A1Ysek1A+pM2SS2a0AWEqX50LyFYsUqrgVIBS6tCjfXJsNwGQ1i3m2PSzDyoy05Fm/
         /ZsvDdP/LJ76o/v5Db4Kg0E+L2HaW7zf8Wzy8Z8p9pS//Hdp6dxTOuGKRTfes5fIpy9s
         I4PyBkVfb7WweUKSPFcRag+Tah9Ry2+B7mpz8aSc2QH/PD9n4rk4LO9WhA/8V+JCCd7a
         DbLDpGEaeCsyzG8tTfSIe0wFlsXeV9EFVQNf9H0oGRaIYj/RfqX/D9puFEkI4K06qfLc
         1wlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692201538; x=1692806338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D8Cow/VKryneABUkqxkXvlZxe3G46QYofSoSSKW5bFM=;
        b=Am/2FXimYAn1+4M6+mr/i7FFilvzgN7USnBYEgdQnSpKzt+ZAToYVQa6aLyH3fSK1R
         l2EF/g4aXf5Fr5+6ItWjkpIqaLdOonOFouGRz75HbkGG7LJpCIY89VJ8IcwbFT4QRe9W
         SAfgQW0/4lqVRLQ4ZSalKYXU+8UJ4oeUuUynviwdi5zBP5EIOzFeXNE8CCwJKzSLvUj7
         fm+6buYeRcZTbmmuoUKo61y9POHXfvL2acOpJyyUfIZi4GGYvlKjcTjqQYLW+jh7gCJE
         irhMqMmN4t1BMTZWwpN7hwyAtouqPLy+om5gE3fV50iwMpRcLqX9KB7ZAKPPM1h/uMvS
         Ieqw==
X-Gm-Message-State: AOJu0Yx8XZOE9npb6L3+AqoyWwVU+4OQ6GyAMaB83ALKvBxMXVp28OJV
        9+nbuESm01gdltAqlwURaeg=
X-Google-Smtp-Source: AGHT+IHQNILK0hkTXfdKdRQ4CH96ZFM1SSHRHGFyyr3VKQSehqNh/sgzWEn/bB/JZSCgOxFInLmLdg==
X-Received: by 2002:a17:902:ec8f:b0:1bd:f378:b1a8 with SMTP id x15-20020a170902ec8f00b001bdf378b1a8mr2449747plg.11.1692201538138;
        Wed, 16 Aug 2023 08:58:58 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:0:e588:8d80:9ae5:5adc])
        by smtp.gmail.com with ESMTPSA id h17-20020a170902f7d100b001bc930d4517sm13366973plw.42.2023.08.16.08.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 08:58:57 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH v6 3/8] x86/hyperv: Mark Hyper-V vp assist page unencrypted in SEV-SNP enlightened guest
Date:   Wed, 16 Aug 2023 11:58:44 -0400
Message-Id: <20230816155850.1216996-4-ltykernel@gmail.com>
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

hv vp assist page needs to be shared between SEV-SNP guest and Hyper-V.
So mark the page unencrypted in the SEV-SNP guest.

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
 arch/x86/hyperv/hv_init.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index f62ca3f6e9b2..8bd2603c5fc1 100644
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

