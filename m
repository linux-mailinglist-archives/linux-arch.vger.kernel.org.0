Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F8075722B
	for <lists+linux-arch@lfdr.de>; Tue, 18 Jul 2023 05:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbjGRDXb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Jul 2023 23:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjGRDXQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Jul 2023 23:23:16 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071C810DF;
        Mon, 17 Jul 2023 20:23:15 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-55bac17b442so3946028a12.3;
        Mon, 17 Jul 2023 20:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689650594; x=1692242594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hJBdL12ty40lO6lWuXeIofQP11zU97c0ieetMiyqTqA=;
        b=G2OpQEpHahGv794djr3EpTFtQzRrPzwIkV2s5d4wkJMqkx/f+PTDDHW3TY4l1NQDIm
         jI1yj+qMvgU5TKcY0hZieVLTTZpFbeabs3vi+xKt9C3OTe/N3Cfas9jLXLR91zBVX568
         u2nuFlMlI66+br4R/vF/AeyveRzlPBru1G11xqHPi0WfZsw9DCTrprd98OtUmAZKf4Dv
         9+Jg2NvgVztQV8X9B4RpCVzlOzCxTj6hLJT+WpbFVU88a29p7AYQArQqSWeTuEZNLx/4
         fT54sRlCRVglV4UoBleyXQffSPm6dJ5YJjPdahGk58dLmajDSc7htUQAFRGV36GWJNaG
         KKdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689650594; x=1692242594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hJBdL12ty40lO6lWuXeIofQP11zU97c0ieetMiyqTqA=;
        b=DN4jpCQI9pYvHIKlkZQuvF/HgS0cGHBpqpptNYbWHppYR5CyvEIfJGCzOO0pXKoUla
         L3yLQhoso4UTrhgGzAGEsTihySDhoKvLK+aCejmi8amWfHuCG8K1KvkUIOEQmn6UHFJW
         P7M2NXeOsyQrYhm5I4BJg/pG/N5X8787+K/tIfH+G4cP9iW6VZo5NjdyHOOaSKMnIKEw
         sMEiQ9lTNBOrQboGsfTLrRQuWOxjwD71tSwEafr7NQqK4RGDLYWeiM//RUwkfdCiC0hn
         HHNjYnnYL7fw5CQYydWZAS68uS4HB1KDLkBmCW+RrsWAy7JmFnFVMbyUEtIRwBpKfXEp
         RHEw==
X-Gm-Message-State: ABy/qLZqADaQ7kjcr+gn4xW4uoitAUhO/1we/PRhbqIRqRabT8Mw5/Iq
        PWZDb7FqZbI+0HDELNvc1tM=
X-Google-Smtp-Source: APBJJlEc0lsaWLGzW+vxY2KA0KlUneQf1A0YGxHK81bylNRJwkhc9voimBJSGj+UsLkME+v0RTuN6w==
X-Received: by 2002:a17:90b:1488:b0:262:f06d:c0fc with SMTP id js8-20020a17090b148800b00262f06dc0fcmr12522774pjb.7.1689650594382;
        Mon, 17 Jul 2023 20:23:14 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:37:c5e9:2003:6c97:8057])
        by smtp.gmail.com with ESMTPSA id s92-20020a17090a2f6500b00263f41a655esm504040pjd.43.2023.07.17.20.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 20:23:13 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH V3 3/9] x86/hyperv: Mark Hyper-V vp assist page unencrypted in SEV-SNP enlightened guest
Date:   Mon, 17 Jul 2023 23:22:57 -0400
Message-Id: <20230718032304.136888-4-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230718032304.136888-1-ltykernel@gmail.com>
References: <20230718032304.136888-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

