Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C967E780A1C
	for <lists+linux-arch@lfdr.de>; Fri, 18 Aug 2023 12:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376284AbjHRKaD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Aug 2023 06:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359870AbjHRK3d (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Aug 2023 06:29:33 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BFA13E;
        Fri, 18 Aug 2023 03:29:32 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bf078d5f33so6045475ad.3;
        Fri, 18 Aug 2023 03:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692354572; x=1692959372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jL7XByUAkxNxzGhhDsJfMYj8T25ntV2u1YZ6jozY7u0=;
        b=l6zq5Uwb8hpOqAjwNnFLwNt/w3QOUcDIxu+hWJsWs9/+ImbGg5c9oH1F9hnaLLkno1
         3fmeB2MLrp14R8eCTT1Y8iO4NsH0/UDezrvMj/q5rSyGTQIh+aKGqgvztrmMQpqFdJtM
         M6Bn6EDdGDE1sa/RMumu6DNziGW8rjGoZCZyHGJHBod8jX7QGK9YtXsSCZ8OC/Hd3Vle
         5KcQG6NIkPC2sCGoeNUqdNzooL4VFhaMfN93CZaSwrY1hwsrjzhgFnnxiTwe74BR3p46
         +mrDet9RrNeMP4G8CSeTOZP8ya6tT/27050TXjXZbNojLgpEWtmHPtXfIZutNNQCNolP
         +8gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692354572; x=1692959372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jL7XByUAkxNxzGhhDsJfMYj8T25ntV2u1YZ6jozY7u0=;
        b=NrJfgEPQdEgxwetqzIxZ6OvnbaqB83Jfj4AE5RHgZHzbWmvaZqHY1oJ1fWYaMcZyDs
         84sxCIDZ6gIz3S5loGitatl5gV8FzMRJhB1HHWcQGw1qwcYNezBQgq3Fz7Bi3acIMxVk
         d+n5qGVnnPw9/JtVQBlgsxF5xV1pYYfTXqh7qiD5cDpHsOeh3E1B2m/iTcfFnLIEBJUl
         YJnDCcmNibjNSD/W46YyLJUSEIcPwbe9t56wnxhslFHqvO9DhRxe6m0VOqbTlinPUJ/e
         yABytc+zRB3Ae7Bug2yTojisHOfIRGXpE0G5jMSXeR56dVWlV3vfdKalDJNEsQiaNHyw
         tm3Q==
X-Gm-Message-State: AOJu0YyOQi5b5sddpJ4O+GrB7dNcvyoVeb3Rq5h9xwm/u95XU+EE6fPv
        pAk4NEW2EBUPIFvykNAy17k=
X-Google-Smtp-Source: AGHT+IFsJ1auTisyGk/0oOyzXEodqEiFJJTgACFHAReX+myJkECiLn2QEQCSVnCX5JnE1SR08bHtmw==
X-Received: by 2002:a17:902:ce83:b0:1bb:ffcc:8eba with SMTP id f3-20020a170902ce8300b001bbffcc8ebamr2574028plg.58.1692354571775;
        Fri, 18 Aug 2023 03:29:31 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:7:4545:4938:97f0:2e1f])
        by smtp.gmail.com with ESMTPSA id f1-20020a17090274c100b001b9be79729csm1386766plt.165.2023.08.18.03.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 03:29:31 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH v7 6/8] clocksource: hyper-v: Mark hyperv tsc page unencrypted in sev-snp enlightened guest
Date:   Fri, 18 Aug 2023 06:29:16 -0400
Message-Id: <20230818102919.1318039-7-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230818102919.1318039-1-ltykernel@gmail.com>
References: <20230818102919.1318039-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <tiala@microsoft.com>

Hyper-V tsc page is shared with hypervisor and mark the page
unencrypted in sev-snp enlightened guest when it's used.

Reviewed-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
 drivers/clocksource/hyperv_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index e56307a81f4d..8ff7cd4e20bb 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -390,7 +390,7 @@ static __always_inline u64 read_hv_clock_msr(void)
 static union {
 	struct ms_hyperv_tsc_page page;
 	u8 reserved[PAGE_SIZE];
-} tsc_pg __aligned(PAGE_SIZE);
+} tsc_pg __bss_decrypted __aligned(PAGE_SIZE);
 
 static struct ms_hyperv_tsc_page *tsc_page = &tsc_pg.page;
 static unsigned long tsc_pfn;
-- 
2.25.1

