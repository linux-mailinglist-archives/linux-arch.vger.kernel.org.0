Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14D2F30DDD8
	for <lists+linux-arch@lfdr.de>; Wed,  3 Feb 2021 16:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233837AbhBCPPy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Feb 2021 10:15:54 -0500
Received: from mail-wm1-f41.google.com ([209.85.128.41]:54260 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233746AbhBCPFV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Feb 2021 10:05:21 -0500
Received: by mail-wm1-f41.google.com with SMTP id j11so5040157wmi.3;
        Wed, 03 Feb 2021 07:05:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S4bWj31VnBtUXtSIFmjXEb9AYQB1ofFXmwDnSfL9How=;
        b=IyGG7DzSmN3RqUp2FuxJOB0bDc0mxZiNDOS6a3AoUUGk57p8lirwmdSdbtgKB8de78
         wcEGdP47SNxm2GfICcMkiL9hPlhHTqtHRSA+jsk7KCJN2J6QooU4JrOX58mauAPmj6np
         4F9KAaP3Wy0a6zT/c3TnxdOyUvjDZxtm1yViESz5FiaHBN5bAQxJCU99Xh1cCEugpXSj
         yngSjfZycke/evErbqvIUgZ1ZsuY6I9/3h/yzKPnsTcM98dBUMuEjXeemoVh0nsRSxJ8
         U2siUbHN4EQksSGjzygN3w1ZkHnXpUNFhnFNzk6oKDdUPHGs6o57JeuAddy3JP9AHxhq
         xDKA==
X-Gm-Message-State: AOAM530vaSXKwek/qG0srExCWiwH/TdQ1FitLEJgHHF3BdfGE9k/pXqx
        4KExSQrZa1qlkWuHUkx+2waOGBqFG6g=
X-Google-Smtp-Source: ABdhPJzBGOpNNYu6lCn17oaCFjyNxeGXNSqazdUgRY2Ugw8ouE5Mv1tDY51ai6TqX3Oi4iQP93WNWg==
X-Received: by 2002:a05:600c:4f48:: with SMTP id m8mr3286386wmq.12.1612364678770;
        Wed, 03 Feb 2021 07:04:38 -0800 (PST)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id r17sm4051704wro.46.2021.02.03.07.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 07:04:38 -0800 (PST)
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
Subject: [PATCH v6 01/16] asm-generic/hyperv: change HV_CPU_POWER_MANAGEMENT to HV_CPU_MANAGEMENT
Date:   Wed,  3 Feb 2021 15:04:20 +0000
Message-Id: <20210203150435.27941-2-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210203150435.27941-1-wei.liu@kernel.org>
References: <20210203150435.27941-1-wei.liu@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This makes the name match Hyper-V TLFS.

Signed-off-by: Wei Liu <wei.liu@kernel.org>
Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
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

