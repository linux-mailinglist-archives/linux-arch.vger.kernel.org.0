Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88B76D4F4D
	for <lists+linux-arch@lfdr.de>; Mon,  3 Apr 2023 19:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbjDCRoZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Apr 2023 13:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbjDCRoS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Apr 2023 13:44:18 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471212724;
        Mon,  3 Apr 2023 10:44:17 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id q102so27956633pjq.3;
        Mon, 03 Apr 2023 10:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680543857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d3G8RfDk2f7ftR+C1v/a0axqypneBk1zP9Qtg1LVHyA=;
        b=SisYW1Wmi4AST8NFhRKGsWMC2QoBuJyIC6l0wgsxsWGUzBwalQyzNsNoNyrf+WpDQ3
         ggZLvMbvLgyuFj+SndN/CoKaBgJPjep6f5wHqIvP7c3K2UmrixL4u85HRFQeAD+M7Uct
         TcdRxdDlVJ8I1D9DJCnUe1SvQN+eMf9JUthe1j4dXLBNE/KyIixu6DninY+hKb80p/GK
         HTndq1yh4aVsXmWk1pMhT2Ht2DT45loXXhAM47JXJqy5V/GE8TYcGdg8RwM9Q4wPfmQt
         djx1k1hPi6YhzK6lCCJfj62KPsp1agf2ZWjRLxFS1cefgv59aGxGN6SRjw9gtw5DXt+b
         6dqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680543857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d3G8RfDk2f7ftR+C1v/a0axqypneBk1zP9Qtg1LVHyA=;
        b=3LUvJQNdaIcNvYAxuJwuy0mD/NUD8Yhi1wL8r91s42il6W+QINTzJc68ByCB7bpjzW
         psCtiOfDnQp98PN6xH2qETTyhe/nABR0ti+OVmEy9zvJyLJIPEVg4rsp8STeR0HjCe56
         HtE6wjG4dfHzlHiLNhs1m8qeRZNCn/S4/KDjKAZ9IpE933kg6c7zmgr+SC7dFVKlyG5Y
         8czEyZwwc5mbzoRZL981tQgLU/S3f5m1VP3HgNqV3LCYcexgtTBN6KkWaeWwwPCp+P2z
         Gz7UzTSkN/FCjV66+n9Zq7w5Nra9b88TaKfp5S/6Jpn7MfCyHjoVFPWhWSaTtndFiSkj
         Pwig==
X-Gm-Message-State: AAQBX9fQauoHqNKcaAkPzcdrjmA89l1o4JCBZuoYek4K0vMWiJYbVSQ7
        TGzQ4YVYGOq7nOZfQSsVVL8=
X-Google-Smtp-Source: AKy350ZDL0d0QwCZQluEybHBjQnkyvlYmiXMNtLiPXZIizX8eaYVsaZeFAonglLEHSkaIAqZUE5l2A==
X-Received: by 2002:a17:902:cecb:b0:1a1:c82d:dcf3 with SMTP id d11-20020a170902cecb00b001a1c82ddcf3mr21052092plg.12.1680543856749;
        Mon, 03 Apr 2023 10:44:16 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:2:8635:6e96:35c1:c560])
        by smtp.gmail.com with ESMTPSA id jj21-20020a170903049500b001a19196af48sm6883803plb.64.2023.04.03.10.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 10:44:16 -0700 (PDT)
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
Subject: [RFC PATCH V4 05/17] clocksource/drivers/hyper-v: decrypt hyperv tsc page in sev-snp enlightened guest
Date:   Mon,  3 Apr 2023 13:43:53 -0400
Message-Id: <20230403174406.4180472-6-ltykernel@gmail.com>
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

