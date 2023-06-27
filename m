Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28F2973F2B0
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jun 2023 05:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjF0D27 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Jun 2023 23:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjF0D2U (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Jun 2023 23:28:20 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CB92109;
        Mon, 26 Jun 2023 20:22:56 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-54fbcfe65caso3376673a12.1;
        Mon, 26 Jun 2023 20:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687836176; x=1690428176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JlZUHIVX+pLdqy3tdQrgw8rCrC0s3HRsxT6pRIRlNIE=;
        b=DB0Z17X6Lpl4T2saaSH+rXYHxawtqP5dN2yw0s7VS0VB99q80xDbUEkg4AgWUSp0iK
         sPVnb26Pf7zvgT1qOIje7gXwd9JGrquTTCLwmr1qc4b0XvCZeLqkW0RxOWmROKrCBLJv
         bFaIxteNjNfoQV+A1fRL4dRRSDDQek8OkHjYVk3Eo9Wc6SVqgrBxZQUZG9euvk/ny+7l
         WbxOANGYP0nWiPQUFKsGMieNM85vcXr1QUmyRxiUxOmeFp78gwNtVDI9fGw77CskuUkl
         aLNuWxAwMaME/ttN6S1Xz+r+0sb1/mRHSCu6TmAh3isumIwCo34SySN5cYPvb4zQi6LA
         cEqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687836176; x=1690428176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JlZUHIVX+pLdqy3tdQrgw8rCrC0s3HRsxT6pRIRlNIE=;
        b=ZZbzzynPRMvUEUd8zFu/YB71QU8ChsCajxw80Xx0xK6vueHrAQafLK4/J0Jjr+Cbhs
         f6eUgGP2dol3LZ54IPKwJAAVgsIFeLmOfBx+mPxjhWScJGFQkXXm022BpXNHdgbIhWQ+
         cilifdiVTeBSu5Jv5+v4CgBW6s5V5l6DHYuTbYz6H2/SiiCXWhxpn0dfeMCB44zBmb0Y
         I6rwoe5M2VkyLHFSemAst3t6TibgtTDd4xH43mVz+sXnWfPbYo3/hf/OTLQZfT8zD/HR
         sIPjsLZWe809XHlnM152cyh4kEixH4EhPhszvJuYHjOSWxjolBlr4NekIeCQ1Ky8/CJa
         zNQw==
X-Gm-Message-State: AC+VfDw9FCxcDd+KAdmnqZyRY3ScGAflOjC3heHi3YCQBUMjuV9U2Gx9
        WZ7C8TNxoTfRdzflk+ZNGZc=
X-Google-Smtp-Source: ACHHUZ77gvLwNNqt8tVeeNeOyVQr0v27R+P+nvuNlP7G9bF/btL8Y8w4fKE7CJZlnG6+st9m8HiJFA==
X-Received: by 2002:a17:90a:4e:b0:261:a75:928d with SMTP id 14-20020a17090a004e00b002610a75928dmr22135434pjb.18.1687836176324;
        Mon, 26 Jun 2023 20:22:56 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:37:c5e9:2003:6c97:8057])
        by smtp.gmail.com with ESMTPSA id mm12-20020a17090b358c00b0025ec54be16asm618756pjb.2.2023.06.26.20.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 20:22:55 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com
Subject: [PATCH V2 3/9] x86/hyperv: Mark Hyper-V vp assist page unencrypted in SEV-SNP enlightened guest
Date:   Mon, 26 Jun 2023 23:22:41 -0400
Message-Id: <20230627032248.2170007-4-ltykernel@gmail.com>
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

hv vp assist page needs to be shared between SEV-SNP guest and Hyper-V.
So mark the page unencrypted in the SEV-SNP guest.

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

