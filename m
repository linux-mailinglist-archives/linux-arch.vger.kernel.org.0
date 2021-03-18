Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFA53340B38
	for <lists+linux-arch@lfdr.de>; Thu, 18 Mar 2021 18:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbhCRRLj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Mar 2021 13:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbhCRRL1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Mar 2021 13:11:27 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F58C06175F
        for <linux-arch@vger.kernel.org>; Thu, 18 Mar 2021 10:11:27 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id g62so8752473qkf.18
        for <linux-arch@vger.kernel.org>; Thu, 18 Mar 2021 10:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EKy6eSpRty5bSmZbwR30NkKAGzsTESRLoXrAS0NLKzs=;
        b=eNY2GRuACJ4olOGkjStJnYo4+tvS1eI09T9df2gayih2kTUfZntYqA2LC07oyFHHKx
         LoRKGFl7PNJPDMcGsA8HHxwkyKD6TQ3Wyj2RgmLIE+s/HvtuXPx+5I6hrckpZS+oErY5
         ogDFVfGdaqDnTuF18CVV+DDQ8LdUflseecN9bGTeT6a8+SxjHM098eZm7PBLmXf4op3n
         1t24cup0GDg+RjbPgKZcdfUEVEtSdq/swYay65YLQskI16wdRli58LFrBk46rbgMuGYq
         R1K0+s+6Qx3mqwk/4Tw3ukG0C8TFEkEBMu8Kfwp5nFQHghNI828VgANtKDjrPt40E0UW
         Zliw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EKy6eSpRty5bSmZbwR30NkKAGzsTESRLoXrAS0NLKzs=;
        b=ip7NK0c29mChGm9hHV/tVrxwjruS6Fgw86zs+5223sXt8TxusCngdJoCnGSTJtnZWh
         Tc7SKVWo0BUl333guYboxCTiHajdvYU4ua4dSkMHS72llu8tFj8z87WbWGXGxQJ7vyjR
         RY6OAWxlamPECGEpzO3HPJ8tULQJRT8c+K2q0CKmmnzqg12ypn36W5oShQGnC3Kk/Tnt
         6hqqXTqoekK4OcNF/NaBtUJreVbC371ZUFlNzuJfLPPxyE5wpN+kJpMq3J4ZdyNPi9ab
         1YtALxeZyFpgujtNRyUftFLIdSYtLY+5kZQUQFz3s+AuYEK8lh5xVJTgQ2zJ6JFTTUs/
         XkEw==
X-Gm-Message-State: AOAM532SXIHPDisLrjoGd6k4QEhz1+OwVMt7CmxkbuMCjpUcXMyMblOd
        vM+BsSYtGzdfL0H0sxxHeF1xDj4+K/LdQRMpzIU=
X-Google-Smtp-Source: ABdhPJwiIw/nT2sORQEJv0I4VRlDkF+rVz6Bmu3Ni9Zp0LOjbRn8BFtuq/bsl/qFKL5zfw7XxQ6J44Hw6n3oVZm4Gio=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:c0d7:a7ba:fb41:a35a])
 (user=samitolvanen job=sendgmr) by 2002:ad4:4ae9:: with SMTP id
 cp9mr5359453qvb.20.1616087486617; Thu, 18 Mar 2021 10:11:26 -0700 (PDT)
Date:   Thu, 18 Mar 2021 10:10:59 -0700
In-Reply-To: <20210318171111.706303-1-samitolvanen@google.com>
Message-Id: <20210318171111.706303-6-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210318171111.706303-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v2 05/17] workqueue: use WARN_ON_FUNCTION_MISMATCH
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

With CONFIG_CFI_CLANG, a callback function passed to
__queue_delayed_work from a module points to a jump table entry
defined in the module instead of the one used in the core kernel,
which breaks function address equality in this check:

  WARN_ON_ONCE(timer->function != delayed_work_timer_fn);

Use WARN_ON_FUNCTION_MISMATCH() instead to disable the warning
when CFI and modules are both enabled.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 kernel/workqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 0d150da252e8..03fe07d2f39f 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1630,7 +1630,7 @@ static void __queue_delayed_work(int cpu, struct workqueue_struct *wq,
 	struct work_struct *work = &dwork->work;
 
 	WARN_ON_ONCE(!wq);
-	WARN_ON_ONCE(timer->function != delayed_work_timer_fn);
+	WARN_ON_FUNCTION_MISMATCH(timer->function, delayed_work_timer_fn);
 	WARN_ON_ONCE(timer_pending(timer));
 	WARN_ON_ONCE(!list_empty(&work->entry));
 
-- 
2.31.0.291.g576ba9dcdaf-goog

