Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFF219F947
	for <lists+linux-arch@lfdr.de>; Mon,  6 Apr 2020 17:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbgDFPx7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Apr 2020 11:53:59 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40801 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729096AbgDFPxk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Apr 2020 11:53:40 -0400
Received: by mail-pf1-f193.google.com with SMTP id c20so7707444pfi.7;
        Mon, 06 Apr 2020 08:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Na/v0irVLYQsjNl5nmhjbVuy9Yt5MvPLH09q3k0nLYQ=;
        b=i3lSsu51p5sBK63NoD7muU1MYIuHpcJubPzgfIJi7Ds29t4pZKhqpPz0/t4y8UYdpj
         XIaZMOFXoUCVKdhX/tNIMWQSRBB9aTyZNhprPlviRwQs4xjKJKmky6MMErfFZzC4V6//
         ltkuLkxvHFXiPdTjYwWSmi4D4Yfgce7AoxbDprntMabqyE/8kIrgkL8O4RANhVoD0KGS
         AdfuXjvJUZrNLD/DAWza72p6mzUm9xRCl4O5Lq0Y2q2CZgqDQ9fPc5ATa/swLQKFVmZD
         MQ1i8V/QpNkFLoLh3qI8pkKmNCyAHxi5LwKnfQRE4mK7XS3a0v3j6P6F5fgdfZzvVWsm
         Ve8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Na/v0irVLYQsjNl5nmhjbVuy9Yt5MvPLH09q3k0nLYQ=;
        b=lRqaQP4bD4SJ8YF4ZH70SVgkUylFTan/TWZusVFoiMgD9imK4CSEcvptGnCW3/eR55
         SVCEQM5yYCuge8d6RorEz8DBu+NGxnpu98T+YdOEE5VtrXXMVNof05sLcsdFitXJVyJj
         iHOsjtp/s1mxvFvnVrpuYGjJe6shLoMue9k0ZuHUq7nrmlW5I27gLUCm/jSKUjhZoVtr
         FvV/kxAemaDfywF+U+FJ6q9sxuMhMWyXDJrhA24GSOMao+p3fBX3mzJCmUPP6/yuJzFM
         TfxCN7N6VEZLfZm/nBQJPEjQNyLZVZBw/hDCGlwhssJFwtWewyLwPKlCdou07mUOkkmG
         i1SQ==
X-Gm-Message-State: AGi0PuZIvLdJc8gIxAduS9AWlhGay/SdfZCMHI1JXzno1n4DaNP9d5pm
        GqBOuVi4/qaW82KKt99yCEk=
X-Google-Smtp-Source: APiQypJvVD9I+nkPIKkx/bxKJnsC6OpJfvchBYKvXjonNu1SH63EWZ+yVVQny+FGWPnVfdoSSVFi9g==
X-Received: by 2002:a62:ae05:: with SMTP id q5mr89914pff.307.1586188416897;
        Mon, 06 Apr 2020 08:53:36 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([131.107.160.210])
        by smtp.googlemail.com with ESMTPSA id 79sm11823275pfz.23.2020.04.06.08.53.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Apr 2020 08:53:36 -0700 (PDT)
From:   ltykernel@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        liuwe@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, vkuznets@redhat.com
Subject: [PATCH V4 2/6] x86/Hyper-V: Free hv_panic_page when fail to register kmsg dump
Date:   Mon,  6 Apr 2020 08:53:27 -0700
Message-Id: <20200406155331.2105-3-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20200406155331.2105-1-Tianyu.Lan@microsoft.com>
References: <20200406155331.2105-1-Tianyu.Lan@microsoft.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

If kmsg_dump_register() fails, hv_panic_page will not be used
anywhere.  So free and reset it.

Fixes: 81b18bce48af ("Drivers: HV: Send one page worth of kmsg dump over Hyper-V during panic")
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
Change since v1:
	- Update commit log
	- Remove hv_free_hyperv_page() in the error path
Change since v3:
        - Add fix commit in the change log.	
---
 drivers/hv/vmbus_drv.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 6478240d11ab..00a511f15926 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1385,9 +1385,13 @@ static int vmbus_bus_init(void)
 			hv_panic_page = (void *)hv_alloc_hyperv_zeroed_page();
 			if (hv_panic_page) {
 				ret = kmsg_dump_register(&hv_kmsg_dumper);
-				if (ret)
+				if (ret) {
 					pr_err("Hyper-V: kmsg dump register "
 						"error 0x%x\n", ret);
+					hv_free_hyperv_page(
+					    (unsigned long)hv_panic_page);
+					hv_panic_page = NULL;
+				}
 			} else
 				pr_err("Hyper-V: panic message page memory "
 					"allocation failed");
@@ -1416,7 +1420,6 @@ static int vmbus_bus_init(void)
 	hv_remove_vmbus_irq();
 
 	bus_unregister(&hv_bus);
-	hv_free_hyperv_page((unsigned long)hv_panic_page);
 	unregister_sysctl_table(hv_ctl_table_hdr);
 	hv_ctl_table_hdr = NULL;
 	return ret;
-- 
2.14.5

