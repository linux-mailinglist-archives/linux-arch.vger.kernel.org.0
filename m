Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3CEC777D97
	for <lists+linux-arch@lfdr.de>; Thu, 10 Aug 2023 18:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236418AbjHJQGl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Aug 2023 12:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236313AbjHJQFk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Aug 2023 12:05:40 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A003C25;
        Thu, 10 Aug 2023 09:04:36 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bbff6b2679so8285335ad.1;
        Thu, 10 Aug 2023 09:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691683472; x=1692288272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lxyPRx65GPTmM7WIGpMjts/akUWiTXqh+ZFAndUPdXI=;
        b=RCXffTJsDHcffmIPSgUKPLAjuz2B9B5upDilpJKvxXdse+2iU9qMd7XeUioEsL/IIx
         P49mC4Z7C2BWR4jgNtbX/rq5y7v1XSel5TXFTXUok3MrW+MmiJqkH3byV+llrk8HKq6U
         H7CoWlLozmvsDFj0PqumGlemwyQxY//zMB8iQjPFrgkXNtpuXt/bFiVYqYPuOJiI/06R
         vEy0jn5ymAGIXiBbExFCqoQ/R0nqeIBKzln7CVzEzdqsufVa2N2Zm+Ss86+gTrSekJi0
         uz/CuciUxpLsNLDHf/pCvPxUVUSizB3w+dTFkwkyLWm/lFN799wXItMTWoCcb2WAnHyD
         gltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691683472; x=1692288272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lxyPRx65GPTmM7WIGpMjts/akUWiTXqh+ZFAndUPdXI=;
        b=JyK6ut6fatUSWJI4ZuMAM13Uvd8T695aNPaz5djXjN6G13QKoi2HVNbNGIbFRH6B69
         J5HSQ2FK16yh3iwzJeh9bmvEg7fM1oK5+HnFkgiiteJ/38MgtogOw+xEEqXgt7ycTj9H
         lh1+4iUpavoj/bsyIUundvq0ks1OPHVzENApSWQE0GON6AlnKfb/MHWoEiPWIjvb0nu9
         GBljHeYnOEpoeEcwGfQSgbMK0fkswZej51A4X6XjxLIySRBZ4aoBGEYfFawEY7FU9MMm
         +SKC7B23PCk1oedsosSDxffD7v3qi8bN44XH7ov8dClBzkgytJFYsPYOTTdMozBFWTCI
         QdQw==
X-Gm-Message-State: AOJu0Yw6CrUdN22PjUPiuw37/9ieG3WwC7eMzUkzWplRqmSDiBuqGzE5
        3jY50nTmFQajLdbXPFJiDwc=
X-Google-Smtp-Source: AGHT+IGn228hh5T0wdxb8i4lo+ItXMDBJHIJVd/VmpTlE2seN4CkYOeLmKy8Ia5uIRzsczi4E/jOiQ==
X-Received: by 2002:a17:902:b10f:b0:1bc:50f9:8f20 with SMTP id q15-20020a170902b10f00b001bc50f98f20mr2336492plr.23.1691683472544;
        Thu, 10 Aug 2023 09:04:32 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:0:c620:2003:6c97:8057])
        by smtp.gmail.com with ESMTPSA id r4-20020a1709028bc400b001b895a17429sm1948821plo.280.2023.08.10.09.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 09:04:31 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH V5 6/8] clocksource: hyper-v: Mark hyperv tsc page unencrypted in sev-snp enlightened guest
Date:   Thu, 10 Aug 2023 12:04:09 -0400
Message-Id: <20230810160412.820246-7-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230810160412.820246-1-ltykernel@gmail.com>
References: <20230810160412.820246-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <tiala@microsoft.com>

Hyper-V tsc page is shared with hypervisor and mark the page
unencrypted in sev-snp enlightened guest when it's used.

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

