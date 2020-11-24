Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB3F12C2E02
	for <lists+linux-arch@lfdr.de>; Tue, 24 Nov 2020 18:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390550AbgKXRHv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Nov 2020 12:07:51 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38099 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390452AbgKXRHv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 24 Nov 2020 12:07:51 -0500
Received: by mail-wm1-f67.google.com with SMTP id 1so3624738wme.3;
        Tue, 24 Nov 2020 09:07:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+I7gc45xFJIk2c97apTvkR8acQbtMFTm1lgQrn5j0J4=;
        b=UsfU6gAEVmFR3VV4VT6DdZFl+fIsp9xD+MYNrqq0P5Fj/Re4y7wt9shWuvGH0+8o9W
         8HtHjRjEJEpKphgPRHr99ZV0+YQ9XyGowH98gA633AjKtQhsBhLrA7XsU5gnUErU6lzP
         JIFPX1ScplUePNo/5pQ60lp0zgbkxC6S9yYXxWzCUXb2Tm8ThGxDQLR0zzdXRi1xkZWV
         ihfS/ktyIJyitQesHb2Zw80dXSjkozae9r6T5a1GUwLqOJgSSo3Y3GKio69OVcG30pcY
         MnUilfAh0izDHiz3D+g1BacUZpBtHXKS720nXRecbUXO/wyVkJ3DaQgkc81isi1FpenI
         N77Q==
X-Gm-Message-State: AOAM533rXQM6Gq/TdpX3IEe0LDL4uBS892ka9brxM85d7JxLOUuU0ryp
        lxTyLj0hi6HeZokekc72S3+KfDGsZfA=
X-Google-Smtp-Source: ABdhPJziu45XA6Aj3ZvrkHT3tD1ps+oa2J+mgCjiiB2+B2M9gaa0WZ7+5RMtbWJyJeJk397CHw0o8A==
X-Received: by 2002:a1c:e289:: with SMTP id z131mr5509541wmg.80.1606237669019;
        Tue, 24 Nov 2020 09:07:49 -0800 (PST)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id v20sm6419874wmh.44.2020.11.24.09.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 09:07:48 -0800 (PST)
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
Subject: [PATCH v3 01/17] asm-generic/hyperv: change HV_CPU_POWER_MANAGEMENT to HV_CPU_MANAGEMENT
Date:   Tue, 24 Nov 2020 17:07:28 +0000
Message-Id: <20201124170744.112180-2-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201124170744.112180-1-wei.liu@kernel.org>
References: <20201124170744.112180-1-wei.liu@kernel.org>
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

