Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 159B48D327
	for <lists+linux-arch@lfdr.de>; Wed, 14 Aug 2019 14:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbfHNMcc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Aug 2019 08:32:32 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35162 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfHNMcb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Aug 2019 08:32:31 -0400
Received: by mail-pg1-f193.google.com with SMTP id n4so11289477pgv.2;
        Wed, 14 Aug 2019 05:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7vaevGfeCiFMhC7cNs8RoTi3ZVjvcOZvfJigQjf8ApI=;
        b=k5momjNxgWCNC2ovxtNwFqS211MyVOTz/4ycmXNfA29Dvlq8I7+u27P/FjpOiAh4LI
         nn3Ju9kg6AZPCwTcPnGB4PKaSQcJv6WkFJBFpzWPGYtLgl9vIttBXCfPWA5hkxmIVo5L
         Os76j/X9eBaZFJx3VfDDYlxEkyMiiEvgl21iNVs+xHkzbHQCA9+jPDYVA4Mrmh+CIOWR
         DMmu8wAOh43laePpvVO4rRh5BHWQd1fTjGVn1Yhj7tIzPB3PjyPWgB7aflZfnHUizIkt
         HIFoJg5V5IQAkd5a4zFyim/jZuHO7HIZVty5WOiVGZ9P4li3n697hVGOM4R20f467lKU
         sX9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7vaevGfeCiFMhC7cNs8RoTi3ZVjvcOZvfJigQjf8ApI=;
        b=IEFOCrNGs4xKow/wadccLEzQKdY5O6bC7zsxyP4Z2EFlqOE1J5uvrI9RsrdTpCUsf/
         H/mfKbgFV0/QAVKUtr4tml6zqj0cpVsN/1Ckipyn593nD7OlQogtGioqc2XZkJXH13Bm
         cbqa4tGyrVFGkrDNQhcBjoaZaadwuKF9HadT1YYbUA/faYivoHwgtmEnguGC0avCERbO
         cVtrxr+EXmLOZuOPrGjOquNzfWz7pI6HH4RiFvAcz7BPp1hK/oN56X1o//Gv7TFasoNB
         VoDAoAb2Db2Rtn0OvAN3Zgi8d73QVkbGBz95E/C5ThmQ1bljmgvjLr1Vsw9gWa69W+Q0
         0fkQ==
X-Gm-Message-State: APjAAAVNv8W+tfX8xMp5aL5+1ho+cH0fBVO5edw9LyKFEdx/wIWiwUQ5
        YsptpSZNQC4txhKFwpLCaC8=
X-Google-Smtp-Source: APXvYqwjhdfZeekDc8MedEHJczaPMYROjEOs0DClCggw4Y+wzZqyl3p4idMnUjlIWlMjl5JMDZh5YA==
X-Received: by 2002:a63:8f55:: with SMTP id r21mr38554952pgn.318.1565785951214;
        Wed, 14 Aug 2019 05:32:31 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([167.220.255.52])
        by smtp.googlemail.com with ESMTPSA id u69sm135276430pgu.77.2019.08.14.05.32.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Aug 2019 05:32:30 -0700 (PDT)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To:     luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, sashal@kernel.org,
        daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH V2 1/2] clocksource/Hyper-v: Allocate Hyper-V tsc page statically
Date:   Wed, 14 Aug 2019 20:32:15 +0800
Message-Id: <20190814123216.32245-2-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190814123216.32245-1-Tianyu.Lan@microsoft.com>
References: <20190814123216.32245-1-Tianyu.Lan@microsoft.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

Prepare to add Hyper-V sched clock callback and move Hyper-V
Reference TSC initialization much earlier in the boot process.  Earlier
initialization is needed so that it happens while the timestamp value
is still 0 and no discontinuity in the timestamp will occur when
pv_ops.time.sched_clock calculates its offset.  The earlier
initialization requires that the Hyper-V TSC page be allocated
statically instead of with vmalloc(), so fixup the references
to the TSC page and the method of getting its physical address.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
    Change since v1:
           - Update commit log
           - Remove and operation of tsc page's va with PAGE_MASK

 arch/x86/entry/vdso/vma.c          |  2 +-
 drivers/clocksource/hyperv_timer.c | 12 ++++--------
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 349a61d8bf34..f5937742b290 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -122,7 +122,7 @@ static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
 
 		if (tsc_pg && vclock_was_used(VCLOCK_HVCLOCK))
 			return vmf_insert_pfn(vma, vmf->address,
-					vmalloc_to_pfn(tsc_pg));
+					virt_to_phys(tsc_pg) >> PAGE_SHIFT);
 	}
 
 	return VM_FAULT_SIGBUS;
diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index ba2c79e6a0ee..432aa331df04 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -214,17 +214,17 @@ EXPORT_SYMBOL_GPL(hyperv_cs);
 
 #ifdef CONFIG_HYPERV_TSCPAGE
 
-static struct ms_hyperv_tsc_page *tsc_pg;
+static struct ms_hyperv_tsc_page tsc_pg __aligned(PAGE_SIZE);
 
 struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
 {
-	return tsc_pg;
+	return &tsc_pg;
 }
 EXPORT_SYMBOL_GPL(hv_get_tsc_page);
 
 static u64 notrace read_hv_sched_clock_tsc(void)
 {
-	u64 current_tick = hv_read_tsc_page(tsc_pg);
+	u64 current_tick = hv_read_tsc_page(&tsc_pg);
 
 	if (current_tick == U64_MAX)
 		hv_get_time_ref_count(current_tick);
@@ -280,12 +280,8 @@ static bool __init hv_init_tsc_clocksource(void)
 	if (!(ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE))
 		return false;
 
-	tsc_pg = vmalloc(PAGE_SIZE);
-	if (!tsc_pg)
-		return false;
-
 	hyperv_cs = &hyperv_cs_tsc;
-	phys_addr = page_to_phys(vmalloc_to_page(tsc_pg));
+	phys_addr = virt_to_phys(&tsc_pg);
 
 	/*
 	 * The Hyper-V TLFS specifies to preserve the value of reserved
-- 
2.14.5

