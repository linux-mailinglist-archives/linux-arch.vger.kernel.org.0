Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72593770455
	for <lists+linux-arch@lfdr.de>; Fri,  4 Aug 2023 17:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbjHDPXK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Aug 2023 11:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbjHDPXE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Aug 2023 11:23:04 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B9649D7;
        Fri,  4 Aug 2023 08:23:03 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b8b4748fe4so15977835ad.1;
        Fri, 04 Aug 2023 08:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691162583; x=1691767383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hJBdL12ty40lO6lWuXeIofQP11zU97c0ieetMiyqTqA=;
        b=W2T5pP2EJN5zqF8Z+DKcufI9AsnQKXIGa8KQQHYomVq+l/owylgAIbgpNvvAKhJcx4
         gID+37L9h5GRh5H212epPftUmDJgZDx5+jyk+ouIa8tLWKpcxOF7HaM5Bn5G/Av1qbbu
         gGptNRIJcc3Vbj/Gq4oxgbJrnhn/hAfxrooUyw/rVq5an1ZfPq1glKnLtli4YRhhBpWl
         +JwlvYr524fPv6iEh++V/FAIoxph1khScslRIrTdHuFk2NHbMuseUSMe2nl8xc/bq2s4
         +rCFJhQ6hrt9oquXyT0hQMy4aKrglGIpQl4o77WG7LeUrX9WgUkULxDP+6yQGoh3sTh6
         3xhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691162583; x=1691767383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hJBdL12ty40lO6lWuXeIofQP11zU97c0ieetMiyqTqA=;
        b=WKG72EyDZEiV8Af7RIIdJA1NSK+1vCHhXE3QZyueEAu5tdV834Sk4PQb3MnN7hcuA3
         M+QHPMwIiZUs28EFdwa6Gt0MKmKvkYcSb+konxvrwIYic2Gz8k/tzzpJu9iUmQNlY4qb
         B0GnizoR20/i3czMlI0RDH7mqs6LbkGzbG1fpahgm+ZFevHL21fPp5jxDkYhvVcqDYu2
         sVOqfM5D4E88sMYWvKkJNlKCOzvfAliYGgV7PSKDDkxZfRHKwYeLZ8Fr1ux0fsu7VnK3
         fveZkSkN5ww4COBuieL7KetF5DbsKSm3LJJgnyVmD9dsRXWzADgn0uX7TSVV6z3zBz0+
         OyMg==
X-Gm-Message-State: AOJu0Yy/OVLzx1RZ8rxc89Bh1xfi04iaz8R1HJYWYUQiBV7SJ031Cqfq
        GbqaCfl/Hywtm+PXhMedzlI=
X-Google-Smtp-Source: AGHT+IH8C1J9BKwLaaDSu1KAghAZTNXOVszccT4zk/7p7mjDz3vi4iYeDX1qtOo/LjkbIkZoY5fxHg==
X-Received: by 2002:a17:903:1247:b0:1bb:a6de:8e49 with SMTP id u7-20020a170903124700b001bba6de8e49mr2210844plh.9.1691162583111;
        Fri, 04 Aug 2023 08:23:03 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:f:a0bf:7946:90be:721b])
        by smtp.gmail.com with ESMTPSA id s21-20020a170902989500b001aaf2e8b1eesm1891325plp.248.2023.08.04.08.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 08:23:02 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH V4 3/9] x86/hyperv: Mark Hyper-V vp assist page unencrypted in SEV-SNP enlightened guest
Date:   Fri,  4 Aug 2023 11:22:47 -0400
Message-Id: <20230804152254.686317-4-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230804152254.686317-1-ltykernel@gmail.com>
References: <20230804152254.686317-1-ltykernel@gmail.com>
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
index 1ba367a9686e..b004370d3b01 100644
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

