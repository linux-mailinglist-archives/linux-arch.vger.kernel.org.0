Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9322FD0DD
	for <lists+linux-arch@lfdr.de>; Wed, 20 Jan 2021 14:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388747AbhATM6P (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Jan 2021 07:58:15 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51]:50874 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389312AbhATML5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Jan 2021 07:11:57 -0500
Received: by mail-wm1-f51.google.com with SMTP id 190so2669029wmz.0;
        Wed, 20 Jan 2021 04:11:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+I7gc45xFJIk2c97apTvkR8acQbtMFTm1lgQrn5j0J4=;
        b=Y/9V0nY1bXWeHoa+peSU4ps3VkvRfgOObvKcq9rWpF06A/sdx4krI51A7LRFHFQI4X
         iAApm8fiyvwNNyTtrd09TwsSyHf01ANzDYItqjZqkj7CbIWynp3X2EXMDnfBxZ/+AA1l
         DY5sS0yu1HAcVF81EbFscdIb96YrMAYQJN9DcUmbtxlCMbTr8G68yHMgkShena7ebu+p
         eyctDJt6T7v3N85HXmxktsOHRZrgdKAv8+3t89FFhZXVPnylmIO722VRciWoviN43SLC
         g/XGWyIIWoRVRML0mywS5d9zlcW+/FCyR0CD5wy6AdT5ERSdlgSIvGFdhlUuf2xor3oV
         boZw==
X-Gm-Message-State: AOAM531Z+NvnUZ1uSvlBNPtDdQdO2M20rN1POsKAq5DfcRzYX6LDqDKk
        HVWOEGpqvwsUKZf0oHGSLY8Qvezs8qs=
X-Google-Smtp-Source: ABdhPJwOtLh3i30qS8UIHprE6HaVcYPLbuYLi648Wm0I8iypqUdEDDC4RmIdv2pwlCQgGE5q+8r5eQ==
X-Received: by 2002:a7b:ce92:: with SMTP id q18mr1599037wmj.113.1611144062899;
        Wed, 20 Jan 2021 04:01:02 -0800 (PST)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id x17sm3747671wro.40.2021.01.20.04.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 04:01:01 -0800 (PST)
From:   Wei Liu <wei.liu@kernel.org>
To:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        pasha.tatashin@soleen.com, Wei Liu <wei.liu@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org (open list:GENERIC INCLUDE/ASM HEADER FILES)
Subject: [PATCH v5 01/16] asm-generic/hyperv: change HV_CPU_POWER_MANAGEMENT to HV_CPU_MANAGEMENT
Date:   Wed, 20 Jan 2021 12:00:43 +0000
Message-Id: <20210120120058.29138-2-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210120120058.29138-1-wei.liu@kernel.org>
References: <20210120120058.29138-1-wei.liu@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This makes the name match Hyper-V TLFS.

Signed-off-by: Wei Liu <wei.liu@kernel.org>
Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
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

