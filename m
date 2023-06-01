Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6F071A233
	for <lists+linux-arch@lfdr.de>; Thu,  1 Jun 2023 17:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234716AbjFAPQk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Jun 2023 11:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233742AbjFAPQd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Jun 2023 11:16:33 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC0DE2;
        Thu,  1 Jun 2023 08:16:32 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-64d24136685so819854b3a.1;
        Thu, 01 Jun 2023 08:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685632592; x=1688224592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZ1tAgcHb7gMFhBpYgj4F/XcDbeqYB3zwGiF2Oyroow=;
        b=DkBCDSqSP+wa8f/vVeVEvYMom0upaLv1kFHxNE4GX/RQCsu8DIB3Z8gJ0iYnMHqK7r
         uyKFuT4jQWAqhLzu8PgeGtq67dMF7Lp0elvu6y3CLZ8vLpSLVFquWGzHsRLgYRO3fuON
         tubEJuSthulCTWPTuSl/gZcRxyCN74LviGiz+Go9BQFR9P6qwrASUYS8ubn6F3kiujwf
         TB+wJNs+yMjnW5FVTHrtbOZIHlTTIs4KyaeRu/ku+gi5gAljPMFw8FplQXxtPZWxpc7p
         zbY9JbyB6XeliI1riT8yyyvA1mPv2QWAw++boM9BisobHrVhCRs717qrB1/H9+Vt0BiA
         6DkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685632592; x=1688224592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hZ1tAgcHb7gMFhBpYgj4F/XcDbeqYB3zwGiF2Oyroow=;
        b=ZX7YOPE3TmAvUNgr6Dj0/odKDk60MkR84zeBYt/vJHN+0Rs4YgZtp+hAWmLQee/pe0
         ZhrfufLc6BxfgoVmfPLLWOC+XiBKzQPQ9jWyXM2sKWjsOSvdcKTNvfvNQltYQ7XS1TuN
         GckpWLYGQeR1+EGn/148ngCoEdYb7XfUr+rzj5V3P4ZJxkOlGT4X4qL9AZLThpK1Xj1J
         1QpTM9/VqGuI8OscSHAz/MD1OTdx6pkLh7oh3IxjvneLgcaFit5BRKtLUGrHBie2Fh5g
         EgF+2fvKTVux92KLpojogInQqRzHBhhLCJTpg6efqmgsHeyUOBWLPK0WsN9I4X4yG7kf
         nvMw==
X-Gm-Message-State: AC+VfDyrx1JVt3Hkj7gkjXG0Vl9TJ7LZe4TJB1l1W96mqGf4Xa/9Nzmu
        +xduFKrlUyU25YEuIaJlouY=
X-Google-Smtp-Source: ACHHUZ5CbjJ4MSKmQgKYrkmSrHMVw4Zal9TnXYaBY9FJYr8d5P+4eTaHy0Vyp5ozjnVNQNyM/n0NMw==
X-Received: by 2002:a05:6a20:3d29:b0:10a:dd79:65bd with SMTP id y41-20020a056a203d2900b0010add7965bdmr2473192pzi.27.1685632591660;
        Thu, 01 Jun 2023 08:16:31 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:9:e0c3:5ec1:4a35:2168])
        by smtp.gmail.com with ESMTPSA id f3-20020a635543000000b0051b460fd90fsm3282639pgm.8.2023.06.01.08.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 08:16:31 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com
Subject: [PATCH 3/9] x86/hyperv: Mark Hyper-V vp assist page unencrypted in SEV-SNP enlightened guest
Date:   Thu,  1 Jun 2023 11:16:16 -0400
Message-Id: <20230601151624.1757616-4-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230601151624.1757616-1-ltykernel@gmail.com>
References: <20230601151624.1757616-1-ltykernel@gmail.com>
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
 arch/x86/hyperv/hv_init.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index b4a2327c823b..331b855314b7 100644
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

