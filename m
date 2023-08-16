Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF7977E5DA
	for <lists+linux-arch@lfdr.de>; Wed, 16 Aug 2023 18:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344475AbjHPP7h (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Aug 2023 11:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344509AbjHPP7R (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Aug 2023 11:59:17 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FFB2D48;
        Wed, 16 Aug 2023 08:59:02 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bdc19b782aso32873365ad.0;
        Wed, 16 Aug 2023 08:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692201542; x=1692806342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lxyPRx65GPTmM7WIGpMjts/akUWiTXqh+ZFAndUPdXI=;
        b=PC0/lR53+VCicJ9H0/SQ3Bei+7+HxUxknUVy7UJmPjgmjLSDquQ65V6tGIcPRaKQCO
         QDZb09dimioLQkIkBApGvGGvk3eZXiaAPVjBZwpII0VC74gluV0vg4+X2SJ94a80rc7G
         NjEW1utnzuowK+lcRO/310nYDeh3K0dVL2lpCz47eW0PjmFyEU2aiRfxxDFBVwiAFyoz
         RRDic5t6n7tqZCsAG/vU5bQZ7ebgA4Wega15/5HM5eNNurSLt22hucbNTpkkWSkKhxno
         N2d0Pou79KaxzT9OU6Zd3PhsnF81/cxtu+kNFwUUX1oeDruVtcFnA9Lj1EsZVyz/mojc
         bhWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692201542; x=1692806342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lxyPRx65GPTmM7WIGpMjts/akUWiTXqh+ZFAndUPdXI=;
        b=B9HIhvw+WmElbvytRNYJsZXPyH9jhZy6NYm3T1PcwgxTspBNNfoln7kXSdzT+72b0z
         mfc5bzEK8f6A3MoEgYtFKTjyyJuajDQSr9XUcCDnkdVvk209rh/L7vP7G7W0b3+aR+ug
         t0Y9HzlMIoBJzoUszsx09IBEmfoNstvVRZ0zo0ZIHzQvfNCNbhmb56df5DokFnaUdTl1
         IUF3yi+iea9IpdEBFWB51a5FNqn+fzxw6KEbfNK86aLA3LUPpbS4QXNaarv+85Nf/5hC
         xECT1dy9gWH9conzES0fH3uR+VGEZ+UvnzDgeTcKPOyPwv+6PTyy/IL2hZrHphxOQjgj
         Twtw==
X-Gm-Message-State: AOJu0Ywbb5Kl07v1m5MIbEiIs0n4Fm0eFbYQa17iyGUU1sqSy27ZgPOn
        3duF1szf8kntIMVe3a2Cz9c=
X-Google-Smtp-Source: AGHT+IFyowF8kY/XG+zGsI3RvPoJeXwJ7mX+0CbWQJkqmr7Arxd7sKHrnFy+Y5qLuMR6bsgIZX76ZA==
X-Received: by 2002:a17:902:d481:b0:1b8:a3a0:d9b3 with SMTP id c1-20020a170902d48100b001b8a3a0d9b3mr2107724plg.47.1692201541988;
        Wed, 16 Aug 2023 08:59:01 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:0:e588:8d80:9ae5:5adc])
        by smtp.gmail.com with ESMTPSA id h17-20020a170902f7d100b001bc930d4517sm13366973plw.42.2023.08.16.08.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 08:59:01 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH v6 6/8] clocksource: hyper-v: Mark hyperv tsc page unencrypted in sev-snp enlightened guest
Date:   Wed, 16 Aug 2023 11:58:47 -0400
Message-Id: <20230816155850.1216996-7-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230816155850.1216996-1-ltykernel@gmail.com>
References: <20230816155850.1216996-1-ltykernel@gmail.com>
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

