Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFC632EC520
	for <lists+linux-arch@lfdr.de>; Wed,  6 Jan 2021 21:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbhAFUfr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 Jan 2021 15:35:47 -0500
Received: from mail-wr1-f41.google.com ([209.85.221.41]:42078 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbhAFUeh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Jan 2021 15:34:37 -0500
Received: by mail-wr1-f41.google.com with SMTP id m5so3566792wrx.9;
        Wed, 06 Jan 2021 12:34:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+I7gc45xFJIk2c97apTvkR8acQbtMFTm1lgQrn5j0J4=;
        b=DiN9piZcf8gi22slHb7emMZ5JHieWBfSxDc3q91mipl7zcZjy3V1A8u+oG/TULORPj
         dw2Iwj9Tw/VBBQMPL/yuBCX749bh/TDAUVEkmMNiogH1OhNKEsF5ggUJAGlb5tUTnDkK
         Hqx7aZPYIOVKFgIPr/Y0sUV10hxABhfhbCZCrOR8yaZ2lcRgLT4lSyD6Y1m4mjZyfqpd
         2YSRit34dJKGYd24vpredwdv+1k29WXDmL5nAWWVkESMoDoM1ffU44O/pWMSZ/704QoH
         DS+wnCwQeO0fC+aZ0TTLCEVqdlHi4LHNlaWM1So5P0HVGmm/JvMr1apxWJC8ifyCghb+
         EXtA==
X-Gm-Message-State: AOAM533zuQqOG9/99nPW8ihMp72GRmM0N6QLZNyGYvNSv0UtIQvTGmH/
        z592XPuelRK9iOsQLTdCn/FEQV8BGZ8=
X-Google-Smtp-Source: ABdhPJyHPkFZq8wqygPXVhtD2e9TVYyiuVI/8OvmqjRjWPKCi1cSk0ekLxW6YgVWvQkfb3eoQzAjGQ==
X-Received: by 2002:a05:6000:368:: with SMTP id f8mr5850439wrf.150.1609965234909;
        Wed, 06 Jan 2021 12:33:54 -0800 (PST)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id u9sm4499456wmb.32.2021.01.06.12.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 12:33:54 -0800 (PST)
From:   Wei Liu <wei.liu@kernel.org>
To:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org (open list:GENERIC INCLUDE/ASM HEADER FILES)
Subject: [PATCH v4 01/17] asm-generic/hyperv: change HV_CPU_POWER_MANAGEMENT to HV_CPU_MANAGEMENT
Date:   Wed,  6 Jan 2021 20:33:34 +0000
Message-Id: <20210106203350.14568-2-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210106203350.14568-1-wei.liu@kernel.org>
References: <20210106203350.14568-1-wei.liu@kernel.org>
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

