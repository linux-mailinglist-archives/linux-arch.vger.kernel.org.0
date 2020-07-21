Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15A78227D06
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jul 2020 12:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729216AbgGUKam (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jul 2020 06:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729164AbgGUKag (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 06:30:36 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A96CC061794
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2020 03:30:36 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id e81so25057470ybb.3
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2020 03:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cPjmWgpWaY+rWzHjnAp20s8iFiM+s5JoLN5MYOTYnFA=;
        b=aftcNk8G6lu8fp6r5Y9h/eIuz+ESZ+QLzM95HKYPu/yD3X2lSvc9rOwiS7ZKhAing4
         yWp6omCuSFKxvk9F/F2V+0kpOCtCZqpDNonEFobTdTCwxCvTd/iKYAfClTBxOO3ukwvI
         puoGl4ZhkEpWNKr0YYQYrfO9Ej6kldPpIZx1BURFXJhJH0yT7oDSyrcyDQ5WES7/sq5m
         +jgb/bDUVdoByDvVqKTQH7jqFyjJYhOAoEU0onxFfDouwvAp+ZzJxoFKYcxFhWPNITpQ
         pGh/hZOFElKkGtGavdtJ+hcnhIqEW2vqFqzKklLa2WS1+R6pprVkk1eueJlX3o4ct3Zo
         Pw6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cPjmWgpWaY+rWzHjnAp20s8iFiM+s5JoLN5MYOTYnFA=;
        b=GMHRmDnZttoKk9q+loYLAlLtdGO/bRuwMrFXQO8YaVhzCFr7aqH12dPf4rIwKJ/pXg
         fjA96mn9Yg+PYLB9HXReOBQjbjip/y2wFazkMec5c6llxMet3nvfZJTUNPNOHcHZlrc1
         V3tkHVPvu5EZ+tKhAAWVrsMkXsy6sNZITRVaquxeV1jex7i7VL7+Wjp56fG68279WiX8
         HrOnEF6W8tl17NhbyZm9pBYqyeMbegSO9bX3P2mhJJulCc13oNNr5ZkTXUWrRYKtQMNp
         cZECOGoyANHcLoIEita1QegvZwqO0hbYmoKDzTB/1t+NQN3wW4kxKL+nV28lT5IMVw8s
         y77w==
X-Gm-Message-State: AOAM531D0E1Ce3PDhZowVe5w+YTYdLJjVAM3qumqFZUsfXqG+gGC+LNP
        pcfu9O9PxGf5zCqzixr7Bna+yhb78Q==
X-Google-Smtp-Source: ABdhPJycd+24DGl11kCvcTJxpCv+cod2nuTGCYXZlnMMqzBV6OdnBQaaHt2pvLcJWUMkw/5HJwrTrZv2dA==
X-Received: by 2002:a25:a088:: with SMTP id y8mr29898149ybh.253.1595327435352;
 Tue, 21 Jul 2020 03:30:35 -0700 (PDT)
Date:   Tue, 21 Jul 2020 12:30:10 +0200
In-Reply-To: <20200721103016.3287832-1-elver@google.com>
Message-Id: <20200721103016.3287832-3-elver@google.com>
Mime-Version: 1.0
References: <20200721103016.3287832-1-elver@google.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH 2/8] objtool, kcsan: Add __tsan_read_write to uaccess whitelist
From:   Marco Elver <elver@google.com>
To:     elver@google.com, paulmck@kernel.org
Cc:     will@kernel.org, peterz@infradead.org, arnd@arndb.de,
        mark.rutland@arm.com, dvyukov@google.com, glider@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Adds the new __tsan_read_write compound instrumentation to objtool's
uaccess whitelist.

Signed-off-by: Marco Elver <elver@google.com>
---
 tools/objtool/check.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 63d8b630c67a..38d82e705c93 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -528,6 +528,11 @@ static const char *uaccess_safe_builtin[] = {
 	"__tsan_write4",
 	"__tsan_write8",
 	"__tsan_write16",
+	"__tsan_read_write1",
+	"__tsan_read_write2",
+	"__tsan_read_write4",
+	"__tsan_read_write8",
+	"__tsan_read_write16",
 	"__tsan_atomic8_load",
 	"__tsan_atomic16_load",
 	"__tsan_atomic32_load",
-- 
2.28.0.rc0.105.gf9edc3c819-goog

