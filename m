Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A54D676AB5
	for <lists+linux-arch@lfdr.de>; Sun, 22 Jan 2023 03:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjAVCqW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 21 Jan 2023 21:46:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjAVCqU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 21 Jan 2023 21:46:20 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512482364D;
        Sat, 21 Jan 2023 18:46:19 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id e10so6746609pgc.9;
        Sat, 21 Jan 2023 18:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d3G8RfDk2f7ftR+C1v/a0axqypneBk1zP9Qtg1LVHyA=;
        b=c/L7UsrH7nJF/Ia15j9vfArLwatEAS0cENKSOaCkL63FyPz2KLBgsgNBrJuF3kVv5e
         lX19cjuEssChOh2HtV1TWinHCu29U/m2mijoi/VnOf8xM0ekpN5rWjNCn5XssgcVGpC+
         4HkV0zdtKoCv1/bH2N8KTCCHxSKWRgFqY4kg0hZalR4AZRCfaVZQMV29nl77ltEEB3lM
         81QhuHoWStkiljwhbUzgL2GQlMEO5DsAcce+B+BhUauBQ+BlgnMw9mGOXcjD8xDsF60R
         NI+HR41cpVEdZmuyHrvCBuu4VSx9HP0oBzRMH/ovwnuYwS7TF0AwJSDrZYqx7IA1U2sV
         lybQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d3G8RfDk2f7ftR+C1v/a0axqypneBk1zP9Qtg1LVHyA=;
        b=EOAbiGfZVS/daQTqBkv7/3sVsUUAorXnu4x3GY3GlJIWwwE4T4mZX3msMwmLlnZJKb
         IxbyLdMjRV1La1/IOkiq5vRdsyp6e6D6f7u7usyqBKV9FqHZZMTZiqEB7yo4mYXrqgg4
         uZcoOht0lAV1HfcLmN+s+x4+e/Zk23I0c32IrjtI9viWPolJMGIr2cmWoufHwIVeniXi
         6djNBeJfZT8LcZRxidRvayDzjf9UHsFsh0LOO96Y/ay8RGD4cJ7pk4BFE+c+xlWQNtJB
         KjSSWtViOfq/Neu+2iDEH5V5ojYN+DicrwDeshMqF8JdEc9MYCM3dKqp/XCnGtSLh/mq
         MgFg==
X-Gm-Message-State: AFqh2komJDNMe5w0jwcKtwiaG+JLof8mDbFMkFQTCiG57G1Dop4V7psJ
        Z2own4OqZBJG+olb0WiqV7Q=
X-Google-Smtp-Source: AMrXdXu574YjcUE6GVcktAFiPejKqe/c1ubdJquLqtdv6Em10rYn9/lUR8RXw/zYyUH3sKzENwk92Q==
X-Received: by 2002:a62:1488:0:b0:586:b33c:be2 with SMTP id 130-20020a621488000000b00586b33c0be2mr22080547pfu.26.1674355578733;
        Sat, 21 Jan 2023 18:46:18 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:36:d4:8b9d:a9e7:109b])
        by smtp.gmail.com with ESMTPSA id b75-20020a621b4e000000b0058ba53aaa75sm18523094pfb.99.2023.01.21.18.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 18:46:18 -0800 (PST)
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
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [RFC PATCH V3 05/16] clocksource/drivers/hyper-v: decrypt hyperv tsc page in sev-snp enlightened guest
Date:   Sat, 21 Jan 2023 21:45:55 -0500
Message-Id: <20230122024607.788454-6-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230122024607.788454-1-ltykernel@gmail.com>
References: <20230122024607.788454-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <tiala@microsoft.com>

Hyper-V tsc page is shared with hypervisor and it should
be decrypted in sev-snp enlightened guest when it's used.

Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
Change since RFC V2:
       * Change the Subject line prefix
---
 drivers/clocksource/hyperv_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index c0cef92b12b8..44da16ca203c 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -365,7 +365,7 @@ EXPORT_SYMBOL_GPL(hv_stimer_global_cleanup);
 static union {
 	struct ms_hyperv_tsc_page page;
 	u8 reserved[PAGE_SIZE];
-} tsc_pg __aligned(PAGE_SIZE);
+} tsc_pg __bss_decrypted __aligned(PAGE_SIZE);
 
 static struct ms_hyperv_tsc_page *tsc_page = &tsc_pg.page;
 static unsigned long tsc_pfn;
-- 
2.25.1

