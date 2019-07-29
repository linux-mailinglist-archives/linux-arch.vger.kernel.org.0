Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18C09786B6
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jul 2019 09:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbfG2HxA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jul 2019 03:53:00 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44674 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbfG2HxA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jul 2019 03:53:00 -0400
Received: by mail-pl1-f194.google.com with SMTP id t14so27151099plr.11;
        Mon, 29 Jul 2019 00:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VQvg278xLnvrixVzlc/S1rWJWmcHHlcW7PsOHYftZN4=;
        b=Rg2y00l5ZSnbQZKqivcDQgHR16UXSx0vsHcUZ1p9FI+n5aol/G30OmcN+0Jpg/tU9q
         rwLMad1pgNsXSdc280fK3mb+A3pyjxO9aJSH3gnHjQC3JbcGrUoTCzUQFiV0Bj8qqOL7
         Foq76wzv7zfK6fQzcJz+sSm8+IWKrmX4ocDUlRhhX9hJmFxsAPnY12PIjNVlj37mJfIh
         aQh+hcLJJF9YyaPE4Fss/hByQmC7oA6czkEIg4jB42+59c6Tvj2udvFQ3YbyZSauiRfd
         Oe6LssEMZytOSjp8WueIXAGyy5Lt36FKkW7w9Fsl5refHNjJclJa5ynbr2BPxJO2LeOw
         6hNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VQvg278xLnvrixVzlc/S1rWJWmcHHlcW7PsOHYftZN4=;
        b=VqVs1TVRaG0AWkTRmBhoakvZfI6h8B0kZmjiwyCUvr9uMUtljHBTNa2RPj0rLqq/sG
         MoW6Rd1fiKN+MVtLxJmUur1Y8TwiNrR/nKJq3J95hJ8OFiOQWSG3h3+UMaADsWXjet9x
         DTXlTMg+4dA278qQOr9HNyR9VCF/sX3lQv8wrHLiQWLy1yxO2Bc/QP3EcsRqHyD3eWLe
         HDliER6IacxrIbxLbX1TYIk8sOwMgovna/eTQ0xe6J2u0OD4LrTUUEkXlE2/UdP6/SZI
         Ew5hVIoto5j2tjrBrKLG159dHPfMLIQ2Eh/q9zeeoQYRYPCCHHow4iLe5+8aSrT7KyEL
         wdxg==
X-Gm-Message-State: APjAAAUARPBnvA61xdfC4cMmoOJqzG9MXXw7saDYsls4iasljWIQp3JS
        YD3HzH4INUThGObE0BV833t+73lJYbA=
X-Google-Smtp-Source: APXvYqz/mwbUQbTM/4MKWXR410Qqrnc6lfzjMRgkLEfCOHiffHnqzH6QOTsLt6rph0S7BeLyelIgDQ==
X-Received: by 2002:a17:902:244:: with SMTP id 62mr14951689plc.243.1564386779347;
        Mon, 29 Jul 2019 00:52:59 -0700 (PDT)
Received: from SAW-L7607608QSA.guest.corp.microsoft.com ([167.220.255.91])
        by smtp.googlemail.com with ESMTPSA id s5sm40878033pfm.97.2019.07.29.00.52.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jul 2019 00:52:58 -0700 (PDT)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To:     luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, sashal@kernel.org,
        daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com, ashal@kernel.org
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH 1/2] clocksource/Hyper-v: Allocate Hyper-V tsc page statically
Date:   Mon, 29 Jul 2019 15:52:42 +0800
Message-Id: <20190729075243.22745-2-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190729075243.22745-1-Tianyu.Lan@microsoft.com>
References: <20190729075243.22745-1-Tianyu.Lan@microsoft.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

This is to prepare to add Hyper-V sched clock callback and move
Hyper-V reference TSC initialization much earlier in the boot
process when timestamp is 0. So no discontinuity is observed
when pv_ops.time.sched_clock to calculate its offset. This earlier
initialization requires that the Hyper-V TSC page be allocated
statically instead of with vmalloc(), so fixup the references
to the TSC page and the method of getting its physical address.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
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
index ba2c79e6a0ee..86764ec9a854 100644
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
+	phys_addr = virt_to_phys(&tsc_pg) & PAGE_MASK;
 
 	/*
 	 * The Hyper-V TLFS specifies to preserve the value of reserved
-- 
2.14.5

