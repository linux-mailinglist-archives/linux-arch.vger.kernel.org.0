Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 748B219F93A
	for <lists+linux-arch@lfdr.de>; Mon,  6 Apr 2020 17:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729128AbgDFPxm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Apr 2020 11:53:42 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46103 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729118AbgDFPxl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Apr 2020 11:53:41 -0400
Received: by mail-pf1-f193.google.com with SMTP id q3so7690274pff.13;
        Mon, 06 Apr 2020 08:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JOdtzdnnmad/Wdl1KcR4OtWl2QzBvVS5vHN6ckHY/5o=;
        b=j4FkMrO6qcS5FreIFpVHyuw0A7eYKdb+hjsIGJ5vYGUmNnjpkcaX8wL1smr1eLf5eP
         8kiw5sw3Fg6uMqQVwvrw580/pKUaDy3htxXqazL/mI90iC33lzZyKoTFDO1g4OXgq0PC
         OCl7C0JvQZ1WMPETUAqOktZ4EGkKCc40ZhzV+9h6gkhNoQKDUzNZ8CuG/2KxbEEucjTs
         TcOmVVbdIwLR8NBx0kDd8nWS2E5YbFGzXfEOk4uOcV0KhHyh+ssrBew6Mrctu0oXWt4V
         wt9yN5cu4DaCbe5nQcO6HEHyV9BJfLhXzQv64KW1DNIRoMSZ72NPqzc25+nMD1vILzOo
         cBDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JOdtzdnnmad/Wdl1KcR4OtWl2QzBvVS5vHN6ckHY/5o=;
        b=Do8vz10aDkHCjKXJTseh16S81lhCFfJFNr/zI5sEH66WHjpy1DTwEv9D1wz4HxRqUB
         1kJR1n4qa2eHkOgaU8Ag70HQE+3nTrznql85/QujsNShPbUGfdIB43JN8WRTu9V3CWBq
         /R7TH+ZQNN75NvAE2dkTI0hGkJ/oX6QIDDiCtdG4lA1W8lmtFmVOnKYzc9WWx5SzsUyL
         Dn58BgCFfnrYQrvGXnvg9uoELyCA4hKUnGgcpxE/2ts+oPyxCM75GnbBPB0fUjmcqXqn
         9vDSAqsHM7RaFIVgnK3QGlOf5w8iNlom+0tIi9jKTgtfOXdPrbEJeN5JtgNtZ1u34QwU
         AbRA==
X-Gm-Message-State: AGi0PuYL9fNus1kRziWtHg2R5ddAxVi7wkUqL2SO2qkWZieO1B/3sXdA
        hV2Zi6jFG3IMIswyWGcV5uM=
X-Google-Smtp-Source: APiQypJM4CyZ4KvQcH0D4+3j4klbrijx7sBt+/Q06gPB9JAEM3q9WJsrRsOkIQ2BjK0eNUM3vzjuGw==
X-Received: by 2002:a63:258:: with SMTP id 85mr11021906pgc.38.1586188418827;
        Mon, 06 Apr 2020 08:53:38 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([131.107.160.210])
        by smtp.googlemail.com with ESMTPSA id 79sm11823275pfz.23.2020.04.06.08.53.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Apr 2020 08:53:38 -0700 (PDT)
From:   ltykernel@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        liuwe@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, vkuznets@redhat.com
Subject: [PATCH V4 4/6] x86/Hyper-V: Report crash register data or kmsg before running crash kernel
Date:   Mon,  6 Apr 2020 08:53:29 -0700
Message-Id: <20200406155331.2105-5-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20200406155331.2105-1-Tianyu.Lan@microsoft.com>
References: <20200406155331.2105-1-Tianyu.Lan@microsoft.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

We want to notify Hyper-V when a Linux guest VM crash occurs, so
there is a record of the crash even when kdump is enabled.   But
crash_kexec_post_notifiers defaults to "false", so the kdump kernel
runs before the notifiers and Hyper-V never gets notified.  Fix this by
always setting crash_kexec_post_notifiers to be true for Hyper-V VMs.

Fixes: 81b18bce48af ("Drivers: HV: Send one page worth of kmsg dump over Hyper-V during panic")
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
Change since v1:
       Update commit log
Change since v3:
        - Add fix commit in the change log.
---
 arch/x86/kernel/cpu/mshyperv.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index caa032ce3fe3..5e296a7e6036 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -263,6 +263,16 @@ static void __init ms_hyperv_init_platform(void)
 			cpuid_eax(HYPERV_CPUID_NESTED_FEATURES);
 	}
 
+	/*
+	 * Hyper-V expects to get crash register data or kmsg when
+	 * crash enlightment is available and system crashes. Set
+	 * crash_kexec_post_notifiers to be true to make sure that
+	 * calling crash enlightment interface before running kdump
+	 * kernel.
+	 */
+	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE)
+		crash_kexec_post_notifiers = true;
+
 #ifdef CONFIG_X86_LOCAL_APIC
 	if (ms_hyperv.features & HV_X64_ACCESS_FREQUENCY_MSRS &&
 	    ms_hyperv.misc_features & HV_FEATURE_FREQUENCY_MSRS_AVAILABLE) {
-- 
2.14.5

