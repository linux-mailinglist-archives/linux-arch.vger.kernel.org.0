Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF644358C59
	for <lists+linux-arch@lfdr.de>; Thu,  8 Apr 2021 20:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbhDHS3f (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Apr 2021 14:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232858AbhDHS3Q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Apr 2021 14:29:16 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12488C061761
        for <linux-arch@vger.kernel.org>; Thu,  8 Apr 2021 11:28:58 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id f18so2887713ybq.3
        for <linux-arch@vger.kernel.org>; Thu, 08 Apr 2021 11:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XFW9qholLJYCDGcPvjKxLTh4yh23AN7VnxadLfVAIAk=;
        b=W7hV9mrblZmrwi9KsES41PXGzLvMgVDFfTIcMVF3q6gtiQ/o3QEJ+5+xML4ri4RlnP
         YAE11csD2Nkom6m6I0y5v3LjqQhzUd93l2pfiWw5fUTCHSqUHS6TSelFFC3w/jGuFhcQ
         d6tNqZL51YbPm7Ri6SBgAW0e7qXBVf0IAVO97LLF5rs6UKu0WXrVId0DaDL1XL/gU8Bx
         WG5Ezaen4l8AI+oNjoTDTAisG2+vW2KB5rDCwzvnU50FwmsR3zNpcOscJZfvcmSuLJUP
         zIFNnB730D0q3yL2ScU2b9X1VZytTiCgmRAGFn0NDaR0fHtpwA8TZKeVWurwNgQevhXF
         OxOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XFW9qholLJYCDGcPvjKxLTh4yh23AN7VnxadLfVAIAk=;
        b=oGNxEEzGOyEYb/xm0aFYK8v5WUJjr3XBi4dlumHm/ZuFP069CqDwppaSSyGl9XvFSW
         GsW/QmJgbP4yJom/UEl8fvqJQr9qul6gKVap4BcoSVpVRDNnvlrkeW1ZH97XcFzOueCg
         rrSBiF5majr9Xfb30RCeGieUoq+FXOmBCUrePinEPPDwf3i/wFu1gZGNKZUaDS6alqXq
         WxUSJ1CJlm18qQ4hsGXpbRBlMEH10OUYusBl/f/5OAsOvEJ3pm/2dBa6rXl2Ilu8/aCf
         +IoK817EFT4/TnRk8Pm3LfSS+11D3HDFIOR4trEhRaPyslnOnbjHbHxw/4ZR8PzkbCTL
         knHg==
X-Gm-Message-State: AOAM533GDD5yzP88wngZ28eT90NJ8dQ0unpvNn7tspilf1ir7BqEwbAn
        UBu2ZnUCs6GfAlbYu7QNIB0nBR2MeHaANeYVDN8=
X-Google-Smtp-Source: ABdhPJy7ksTXDyXgVRFCS8wPoe5BOfA/cFt4wKucNqs3gOI61ZzsQG9rvvWETXTeYmtmmNK12rXYVPUJyObbOk1yBQY=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:3560:8505:40a2:e021])
 (user=samitolvanen job=sendgmr) by 2002:a25:c750:: with SMTP id
 w77mr12752632ybe.340.1617906537243; Thu, 08 Apr 2021 11:28:57 -0700 (PDT)
Date:   Thu,  8 Apr 2021 11:28:31 -0700
In-Reply-To: <20210408182843.1754385-1-samitolvanen@google.com>
Message-Id: <20210408182843.1754385-7-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210408182843.1754385-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH v6 06/18] kthread: use WARN_ON_FUNCTION_MISMATCH
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
        Sedat Dilek <sedat.dilek@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>, bpf@vger.kernel.org,
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
Tested-by: Nathan Chancellor <nathan@kernel.org>
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
2.31.1.295.g9ea45b61b8-goog

