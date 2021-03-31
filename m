Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5CFB350946
	for <lists+linux-arch@lfdr.de>; Wed, 31 Mar 2021 23:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbhCaV2O (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 Mar 2021 17:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232624AbhCaV1h (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 Mar 2021 17:27:37 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4BAC061763
        for <linux-arch@vger.kernel.org>; Wed, 31 Mar 2021 14:27:36 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id u7so2112673qvf.5
        for <linux-arch@vger.kernel.org>; Wed, 31 Mar 2021 14:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=w0Ob8x2IVOI0uzzuSsD4k6M727ovkcvMuqyZX5oqc8o=;
        b=nI+ENEyWz/rNq3xP8nhiHUSZWps3bzcuJMrVtvPjR+rwBVB/lrPv3BQxv4E6KMlKot
         N2LsEQni14VlVAHF8qnHU7viK/ziWMDnF+LjsDhRC5aIyL3jNfHcFkfBZOz7gp9DHK/O
         0JRF/cYTuekKimF/7nWHkbZejho/mozDnjz14/sUDrLrCY52H9gqZiseo5bvX4tsLE3n
         UInjiRYKcOH12CVIEai20isk8gmvkqMy8DVUqR4KnBFv6jve3oIB8g21fppaRejyMB3V
         etjDn4nUdij5fV9SBqoW9glwdBH2VxhLNg9QBaiZB4SRwbU9iQX2g4S5jS1L/Ej7xHUS
         tYmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=w0Ob8x2IVOI0uzzuSsD4k6M727ovkcvMuqyZX5oqc8o=;
        b=ENCvHP0zdFRg4w/mAceDPBlIbLUrbAIxIOzsxI8X5fmsAvBtUcYerS19rRLHhX9/ID
         Z7M24Hx6FryBGx0iCj8YqGCPSigeYDnOIr/tyIkxrwJGe7cE1kIfWEyK68Ulfh0WEMot
         F7RAhu8NT9S9dNX+KPiffjtNRBU5/0sfejHpl7HwjFF99WzbPamaKkCKMPbkHPvkf2Sr
         jOh+DWNKU8a8bvALbGgb3FqOeHOxZgB79r2WueaFjwp4t8bey400msv8/HshhUYRinnt
         lZ1LxEr/Hoefu2iDYE/RJAM0ZbIG9+Pjh8iXI7gxQmynrI0TKmF7bUD2cdQVPM4WECpk
         6Edg==
X-Gm-Message-State: AOAM5322jZZ0E18U9DVbSbqZkU0o18Uso/dNM9J7xSz8VJqS3e+5nsDu
        1MAYBx/VFach2BstUcpIkJjRZ5TkaiEhhkZyqZ0=
X-Google-Smtp-Source: ABdhPJxyRXN3znqnAe5t9dUQhGAL9s70gMe95fSLJFpd13x9D/1BXHdz4usqL4E5etbu055EIK7g6ge4pYkRTaLFmpw=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:7933:7015:a5d5:3835])
 (user=samitolvanen job=sendgmr) by 2002:a0c:cb0c:: with SMTP id
 o12mr5070670qvk.54.1617226055502; Wed, 31 Mar 2021 14:27:35 -0700 (PDT)
Date:   Wed, 31 Mar 2021 14:27:10 -0700
In-Reply-To: <20210331212722.2746212-1-samitolvanen@google.com>
Message-Id: <20210331212722.2746212-7-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210331212722.2746212-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v4 06/17] kthread: use WARN_ON_FUNCTION_MISMATCH
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sedat Dilek <sedat.dilek@gmail.com>, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

With CONFIG_CFI_CLANG, a callback function passed to
__kthread_queue_delayed_work from a module points to a jump table
entry defined in the module instead of the one used in the core
kernel, which breaks function address equality in this check:

  WARN_ON_ONCE(timer->function != ktead_delayed_work_timer_fn);

Use WARN_ON_FUNCTION_MISMATCH() instead to disable the warning
when CFI and modules are both enabled.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 kernel/kthread.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index 1578973c5740..a1972eba2917 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -963,7 +963,8 @@ static void __kthread_queue_delayed_work(struct kthread_worker *worker,
 	struct timer_list *timer = &dwork->timer;
 	struct kthread_work *work = &dwork->work;
 
-	WARN_ON_ONCE(timer->function != kthread_delayed_work_timer_fn);
+	WARN_ON_FUNCTION_MISMATCH(timer->function,
+				  kthread_delayed_work_timer_fn);
 
 	/*
 	 * If @delay is 0, queue @dwork->work immediately.  This is for
-- 
2.31.0.291.g576ba9dcdaf-goog

