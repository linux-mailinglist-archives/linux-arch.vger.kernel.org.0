Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3CF36F2F7C
	for <lists+linux-arch@lfdr.de>; Mon,  1 May 2023 10:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjEAI5m (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 1 May 2023 04:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbjEAI5j (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 1 May 2023 04:57:39 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7B410CE;
        Mon,  1 May 2023 01:57:38 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1a6762fd23cso18593745ad.3;
        Mon, 01 May 2023 01:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682931457; x=1685523457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eA3U8GDAlLCUNajUiT+ES1YkLuAsDmmQOi6ciH1zXUo=;
        b=nL7GT1DJwB2fN84yYmnsZxyPvh44uMIF7H9efWalaPCl3LTd5Vx/Rrsp2YGOL+1wtm
         zqpg8+U3hMLOeyWusj8btTUT+dQuWxyKk1Bq8TGrmTuQ4rK9QpN80xdf/AL/WfvABCWW
         F3NIF9Am4AqLaQpF9tCGwGvDs23UfC/oICUGbqsSQOXD/4v/oBNO5Zb1QtCwPUyuheG5
         yNTeLk8Mbx1CjpPUv3DHu7edZ3d7BoWbl48ETjzhZjQEG7R3vqPi38+CckMUtpzskEYg
         ISXu1pFwAaCrWtXlNyLMNMPdrXL85cHxrA6nPNsOHO8JvFvrahqy9M6W1nR90YO5ymw/
         gEPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682931457; x=1685523457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eA3U8GDAlLCUNajUiT+ES1YkLuAsDmmQOi6ciH1zXUo=;
        b=YTJaD9hRlVqs+oLXxevkkT7j5DQsK7quJwCFsJGwSIxlpyS64v+9XW1ovjEnIha45U
         XeuSv2Q7ML/ZBdeeYSfJKbYe05wfpxe1fMOj3ppEhGichKOpF6Tb/yBIsEvUji7rKKFo
         9oxWH/Q81asp64uUbwwxSDzMZncLvM43l0MhHPadpmASRBReS1L2NGFJ5TY2FJsH9HCW
         MayvTpjhCbZA7fm15GuMzzbNp92accKB8daZH85nyWmax9rTyqEYGqsCxJlZR6nYRN2f
         RWPJzWnSEMOsMEv4rPVmr4fEAFRY2B+t+wO865Xd0OA1NRo9hKyKxhR7P7YhXPFmL5nq
         zdBA==
X-Gm-Message-State: AC+VfDxagd0wPhITMEXr3G/tZLngDR7uear/JTz5BLgIhlWOCCUYDZfH
        mns5ZIAnR1QdeNWpFcyo0xc=
X-Google-Smtp-Source: ACHHUZ48b4LOmBqkfMz2MT+3hlFv3HvN27uWK8AgwoSgWBPNkQJxyUWi0++/xDltX+MBtg7sXJyCVA==
X-Received: by 2002:a17:902:db0b:b0:1aa:e5cd:6478 with SMTP id m11-20020a170902db0b00b001aae5cd6478mr5770890plx.58.1682931456993;
        Mon, 01 May 2023 01:57:36 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:b:e11b:15ea:ad44:bde7])
        by smtp.gmail.com with ESMTPSA id t13-20020a1709028c8d00b001a4fe00a8d4sm17407070plo.90.2023.05.01.01.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 01:57:36 -0700 (PDT)
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
Subject: [RFC PATCH V5 05/15] clocksource/drivers/hyper-v: decrypt hyperv tsc page in sev-snp enlightened guest
Date:   Mon,  1 May 2023 04:57:15 -0400
Message-Id: <20230501085726.544209-6-ltykernel@gmail.com>
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
index bcd9042a0c9f..66e29a19770b 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -376,7 +376,7 @@ EXPORT_SYMBOL_GPL(hv_stimer_global_cleanup);
 static union {
 	struct ms_hyperv_tsc_page page;
 	u8 reserved[PAGE_SIZE];
-} tsc_pg __aligned(PAGE_SIZE);
+} tsc_pg __bss_decrypted __aligned(PAGE_SIZE);
 
 static struct ms_hyperv_tsc_page *tsc_page = &tsc_pg.page;
 static unsigned long tsc_pfn;
-- 
2.25.1

