Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18CE92A8423
	for <lists+linux-arch@lfdr.de>; Thu,  5 Nov 2020 17:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgKEQ6U (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 Nov 2020 11:58:20 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52053 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbgKEQ6U (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 Nov 2020 11:58:20 -0500
Received: by mail-wm1-f66.google.com with SMTP id v5so2293513wmh.1;
        Thu, 05 Nov 2020 08:58:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WkfHYu6VFyajw5WpXwEkCq0cVnpjzGJSXx+/xipV4v8=;
        b=MkyqTk15rYnYBnGgGEdrh25q/YOn1aHRA1T2076hANvIBc3l/q3cncwBjinm1ferHi
         1IiIoaVomCXTKfAglTsE0jIhntKvsKkQzv4sehAR1zqD99xMxRGxx2+A4PK5T8XIDEJW
         TJHUzlbirVfZ5TbSbgFp5VN2bqWeqBXPJS21jpZ9B5GbP98WE0lnAbMSWhXdjDCk1Jo/
         XL+AGbzZ1VN5/oUY/aUYS4xYJ/RZdydq7YOZk4ulH9VoY5c2Csk6wcLT3AQQMvRKUkhm
         abH0avd//tV++Cz/gcEjOQK+4tVS3r4zugcRiPFq26D/kFvThZXZxInjsaFmYIS/oWji
         Cc4w==
X-Gm-Message-State: AOAM53198v6DgVFLOSqpnn6csl4tee47Sca04Amx9sLFe5VYbSN61Kya
        NshUi8XAu7iy4vradhZ+8wRD950gYAI=
X-Google-Smtp-Source: ABdhPJwgAiyLEaiqDhRSl6kBYfnenPKv9pqZSG/OLB29Xn0FKny8t1hmWLsFTHnpfrUcwl228XplxQ==
X-Received: by 2002:a05:600c:219a:: with SMTP id e26mr4013747wme.168.1604595498317;
        Thu, 05 Nov 2020 08:58:18 -0800 (PST)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id z5sm3350729wrw.87.2020.11.05.08.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 08:58:17 -0800 (PST)
From:   Wei Liu <wei.liu@kernel.org>
To:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org (open list:GENERIC INCLUDE/ASM HEADER FILES)
Subject: [PATCH v2 01/17] asm-generic/hyperv: change HV_CPU_POWER_MANAGEMENT to HV_CPU_MANAGEMENT
Date:   Thu,  5 Nov 2020 16:57:58 +0000
Message-Id: <20201105165814.29233-2-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201105165814.29233-1-wei.liu@kernel.org>
References: <20201105165814.29233-1-wei.liu@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This makes the name match Hyper-V TLFS.

Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
 include/asm-generic/hyperv-tlfs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
index e73a11850055..e6903589a82a 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -88,7 +88,7 @@
 #define HV_CONNECT_PORT				BIT(7)
 #define HV_ACCESS_STATS				BIT(8)
 #define HV_DEBUGGING				BIT(11)
-#define HV_CPU_POWER_MANAGEMENT			BIT(12)
+#define HV_CPU_MANAGEMENT			BIT(12)
 
 
 /*
-- 
2.20.1

