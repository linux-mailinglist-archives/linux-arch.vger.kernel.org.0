Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C323C269410
	for <lists+linux-arch@lfdr.de>; Mon, 14 Sep 2020 19:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbgINRun (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Sep 2020 13:50:43 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36525 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbgINL2N (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Sep 2020 07:28:13 -0400
Received: by mail-wm1-f66.google.com with SMTP id z9so10869136wmk.1;
        Mon, 14 Sep 2020 04:28:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WkfHYu6VFyajw5WpXwEkCq0cVnpjzGJSXx+/xipV4v8=;
        b=M3eYuJpXza5gD0kIK5gL1W3KrJyPZu+4s8YRqJHwUkWlZaHj+5w+gMibYXllQUGzcj
         83AlnVadwCwT5etlESgLsd8TyfaeHuKJg9nWjg8NDCnXbzIGAhhcSH3cp+qWYkpP6Oy5
         40laBXMqhoHa2+DX16pBBvMccUavhOWFAXqDD4MB/dPFEkaL6UZfJKbyRQ2wAmKTsa32
         3t3Z2uwVDmOOROtkoRDSslquppt1TP0BdXxYRWdK2PPBfH4cu5kdzVDWY9n3sQ32419M
         RsrBKHgxhbzu4CdU+P7pRiNUwFUJUONi1524MPJqFjbg/aIu8+EqOBjQX/HeEzrF3S4E
         u9/g==
X-Gm-Message-State: AOAM533xmEjRpWMmZkBxLxV26rasANwd71HnaMMvc+TqP6RKJ1nFRvT/
        du68WpxZ/BIcnCGPLjtxwW+UgDGCPGI=
X-Google-Smtp-Source: ABdhPJzLuElp65R6p44tUHfmz7EuYN+7QWxYPI9EYrKSjiq0pLpakmMPkIlFBus8Mdcki7oqQechWA==
X-Received: by 2002:a1c:2441:: with SMTP id k62mr10781497wmk.178.1600082892013;
        Mon, 14 Sep 2020 04:28:12 -0700 (PDT)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id s12sm12024606wmd.20.2020.09.14.04.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 04:28:11 -0700 (PDT)
From:   Wei Liu <wei.liu@kernel.org>
To:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nudasnev@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org (open list:GENERIC INCLUDE/ASM HEADER FILES)
Subject: [PATCH RFC v1 01/18] asm-generic/hyperv: change HV_CPU_POWER_MANAGEMENT to HV_CPU_MANAGEMENT
Date:   Mon, 14 Sep 2020 11:27:45 +0000
Message-Id: <20200914112802.80611-2-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200914112802.80611-1-wei.liu@kernel.org>
References: <20200914112802.80611-1-wei.liu@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
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

