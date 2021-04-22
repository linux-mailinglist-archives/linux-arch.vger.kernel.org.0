Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80BD4367A1A
	for <lists+linux-arch@lfdr.de>; Thu, 22 Apr 2021 08:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234923AbhDVGpj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Apr 2021 02:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234890AbhDVGpg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Apr 2021 02:45:36 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC185C06174A
        for <linux-arch@vger.kernel.org>; Wed, 21 Apr 2021 23:45:00 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id 91-20020adf92e40000b029010470a9ebc4so12269305wrn.14
        for <linux-arch@vger.kernel.org>; Wed, 21 Apr 2021 23:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Sugwskr8rXy42pZ1xDG6/Yn9grQzLU2kaW/tniDjvCM=;
        b=rlmZAOT4B8TFqAZfZ08hCQP6c8Lo5iDRtrCmUNvvQfPE2MM8TQVihWTTmzMuSendWu
         yX+RaWI3/1avKzx9airDR9aL48aJWg8GIWMZcHboD9GKsYqKNJkl1Sd8UbVlDroUbRxT
         B6+HRfVChEHZtk9KTA1SSqpw+ZHUQvGm1Uz1fY6Rz2kq/qq6GvJzN/41hCtme7AQ5rsp
         PodsoHWH/gfa1Fbt9QmGwRjIM04KLoBHQpmiECbBz3g+6LRJ4YfkGhpRTe7QZIFbLGH+
         JKqayl8XPz7Stk7eXLPT/KB6A163xlvaydZwEuEw5tln8PZfuCouXuz3CO5LpRH2KTE8
         fKVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Sugwskr8rXy42pZ1xDG6/Yn9grQzLU2kaW/tniDjvCM=;
        b=FhoT8TdA3s0JgLenKd2z06Kzvm5iDI4JCVMRDq/689wObdQTcLbnY8WKFWxzvQ8oe0
         htyXfG+lJWmVnGpvxo1StE9xmXAu+feRrnsXj8IE1wV1A6JNomMaJBH1PTDMw49ocgbh
         aJHpu3T8rjMKvcQSm32c9TAzZXrNoUJY5zsEMrvQYph10152J0biTSm+IIAeKZR/aCjb
         /Bw2gDveTsM1M0A12wLGEoqNoEAEPJzxRipCw81NU4WJuFcuLpmduy1ttB8XOVNmhw8/
         VT+ma42akjv2fHQaa8YUQp9ksW4CPIosBpRtLooto2lSMxP1dCzNRS2CRhrp17ubvpQs
         WH0w==
X-Gm-Message-State: AOAM531q9VkNfzvxEZY/IyKIwdXdhq5y3KfgKFSj6lNpcMJUND22ETAq
        j4UI5NGH523DqzIAPVgzxAgoUkzRSA==
X-Google-Smtp-Source: ABdhPJy+hre1G5RN1jq0nJSfzX61loPh+welwRzkqIFqp7alxaEk/o/Xx49s2TFsWZg2yfvXi5JrJ0YSHg==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:6273:c89a:6562:e1ba])
 (user=elver job=sendgmr) by 2002:a05:600c:35cf:: with SMTP id
 r15mr12248413wmq.183.1619073899334; Wed, 21 Apr 2021 23:44:59 -0700 (PDT)
Date:   Thu, 22 Apr 2021 08:44:37 +0200
In-Reply-To: <20210422064437.3577327-1-elver@google.com>
Message-Id: <20210422064437.3577327-2-elver@google.com>
Mime-Version: 1.0
References: <20210422064437.3577327-1-elver@google.com>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH tip 2/2] signal, perf: Add missing TRAP_PERF case in siginfo_layout()
From:   Marco Elver <elver@google.com>
To:     elver@google.com, peterz@infradead.org, mingo@redhat.com,
        tglx@linutronix.de
Cc:     m.szyprowski@samsung.com, jonathanh@nvidia.com, dvyukov@google.com,
        glider@google.com, arnd@arndb.de, christian@brauner.io,
        axboe@kernel.dk, pcc@google.com, oleg@redhat.com,
        kasan-dev@googlegroups.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add the missing TRAP_PERF case in siginfo_layout() for interpreting the
layout correctly as SIL_PERF_EVENT instead of just SIL_FAULT. This
ensures the si_perf field is copied and not just the si_addr field.

This was caught and tested by running the perf_events/sigtrap_threads
kselftest as a 32-bit binary with a 64-bit kernel.

Fixes: fb6cc127e0b6 ("signal: Introduce TRAP_PERF si_code and si_perf to siginfo")
Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/signal.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/signal.c b/kernel/signal.c
index 9ed81ee4ff17..b354655a0e57 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3251,6 +3251,8 @@ enum siginfo_layout siginfo_layout(unsigned sig, int si_code)
 			else if ((sig == SIGSEGV) && (si_code == SEGV_PKUERR))
 				layout = SIL_FAULT_PKUERR;
 #endif
+			else if ((sig == SIGTRAP) && (si_code == TRAP_PERF))
+				layout = SIL_PERF_EVENT;
 		}
 		else if (si_code <= NSIGPOLL)
 			layout = SIL_POLL;
-- 
2.31.1.498.g6c1eba8ee3d-goog

