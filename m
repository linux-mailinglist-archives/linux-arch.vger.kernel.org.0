Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595A770358E
	for <lists+linux-arch@lfdr.de>; Mon, 15 May 2023 19:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243407AbjEORAD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 15 May 2023 13:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243408AbjEOQ7v (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 May 2023 12:59:51 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052337AA6;
        Mon, 15 May 2023 09:59:39 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-24df4ef05d4so11071665a91.2;
        Mon, 15 May 2023 09:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684169978; x=1686761978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eA3U8GDAlLCUNajUiT+ES1YkLuAsDmmQOi6ciH1zXUo=;
        b=lF1M1QxeQyxdmNUHBVMGvIhiHTo7OeoA5hbNZ66wvUYm0QDSFq7Mw/xNo+0FGrRwk/
         BJZZit7M3ipdEovJe5qF/zLCZOTb0d5PXPUMwvnGZ7NOt19pQSMn/a2x3onDS3TlWkdY
         kZqU9QfIQiqjmqza+iFqXzidN34AnrAyliVl4LBxrLVB09GJfuetnzA3VfVZkFWHQdP+
         7znPbkqcOjDpXklvLDzav/YxH2yQVLpzu/Ywj1JDo6FSnuRo26oe/iQJhZ+YhEpEj6Wn
         WuDjisnmQbgN1/LuPOT5wx853n0qiEOsZeF2kLAvIs8BAQEEgHiU88/9nnUe2qoEm1Un
         1agw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684169978; x=1686761978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eA3U8GDAlLCUNajUiT+ES1YkLuAsDmmQOi6ciH1zXUo=;
        b=j3O+R2Flz1HPsHLAp26ugoYwVceQ5ey989RAsvWG+gOlx/oQeDAmVSpcu5G/eqbQtF
         veG2prN84N7XXIqElcSmhWxfWLWuw1zcm9vrp2SjiVrll8xW7uiqB/3XLn+lIisp3pok
         LC+Gc1wZwZ5l5CGAUcYJjISAXaOvRSDHK1kTuoGJXIvKixFjMlr4f/+Ax8dqTaTGa2Mn
         CkTSICdhMiTt4KnlMX6jM2v8CbuwxvgU4QQ9iBoRjVhmyu4XiJV8wHF8+raF7O0o+gU/
         RRpNWiyEyat9T2Ck7GrkWpK/Clt61Xez5tsASC20Zud2ec5wEQw19Z154KL1Oc1pu4gs
         lXQw==
X-Gm-Message-State: AC+VfDzojFmOw7Dr4Oio9h2yjM46Zs86mJ91NQ1+y4x+rtCSagIaAm71
        099DAosDc/2KUmHASEQWa/I=
X-Google-Smtp-Source: ACHHUZ7kJlOT1foMFvTIkfJR4/vKWU2rCR5GnZ8R6nF8cLAaJ7PGEyviGn2reT1wXYBLMBRpVmIy4Q==
X-Received: by 2002:a17:90a:a590:b0:247:eae:1787 with SMTP id b16-20020a17090aa59000b002470eae1787mr34642204pjq.36.1684169978378;
        Mon, 15 May 2023 09:59:38 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:f:85bb:dfc8:391f:ff73])
        by smtp.gmail.com with ESMTPSA id x13-20020a17090aa38d00b0024df6bbf5d8sm2151pjp.30.2023.05.15.09.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 09:59:37 -0700 (PDT)
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
Subject: [RFC PATCH V6 09/14] clocksource/drivers/hyper-v: decrypt hyperv tsc page in sev-snp enlightened guest
Date:   Mon, 15 May 2023 12:59:11 -0400
Message-Id: <20230515165917.1306922-10-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230515165917.1306922-1-ltykernel@gmail.com>
References: <20230515165917.1306922-1-ltykernel@gmail.com>
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

