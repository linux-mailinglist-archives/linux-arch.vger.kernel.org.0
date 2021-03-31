Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A070835094E
	for <lists+linux-arch@lfdr.de>; Wed, 31 Mar 2021 23:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbhCaV2S (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 Mar 2021 17:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232831AbhCaV1q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 Mar 2021 17:27:46 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C23C061762
        for <linux-arch@vger.kernel.org>; Wed, 31 Mar 2021 14:27:46 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id j3so2118509qvo.1
        for <linux-arch@vger.kernel.org>; Wed, 31 Mar 2021 14:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=u3sb7mCURY4VtmyE6zoVQ18sx7nW16pIZYxJrlMzk+o=;
        b=eMFe9houa2XuN05SOLsaOm1Hewi7pJ9LNis+2l70Pybgv0BDjfh3Tdjx0LeKuDts/8
         5TrWVPttIn2hlb4FWOkPJvsI+3pl4WmXqShOicHoGuBx+x06lTjU0PYmzEkX1eUIZZYm
         2UbSefvKGG4w1T/hAXOi65BNTP7V932xjjIwsFszWbETMcndQAgg2J1lQsmkLEDmJ1uu
         1cOK+xgl4cg4yXyncFGUWYT9T4R4JW24KVZEyJFf3MUxdM4Swj6k/74eJaTzZZDQWuQc
         XORxfZubOGWv8Du+0NlGMiued0fd4ATF8owIEc3jR7W1F5csKMraVh8dIC3NwYQXtmwR
         qYrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=u3sb7mCURY4VtmyE6zoVQ18sx7nW16pIZYxJrlMzk+o=;
        b=FI4Lqj8nS6VBeM7Gv27gHNEj2kpmqB+OvSCX6cFU5BNFBQJjnwdIX3XWqVCKiGBlDN
         qyd0d6glxUwtiCfUhpul/DZUxLPNsFuWRaNlyfMWcgKEc/j0QIaUqYuXwUd7WcHw43tF
         YhApXCkyuhhH+oxPSryqSDi/ICS4rWJY2+OAO3GL8V9vMNXMugSL6q/XM50vqZM0IW/N
         seE/G0UYEMhheK2HxxcCEFL14VobpGnndZU/FO9wm9fLyfV6cbfoLkD6bkhXMjOqVPOs
         u3qxHLdVnzKleslSEVSB9peuyBsIHiAW7+BBWu5tMh34rzOD2AQz9GinQjkBGcTArcUN
         46Fg==
X-Gm-Message-State: AOAM530QU0FIhVcYFmyQ3/np9IfkYpbdi5ZVZlmrY/MWW4zhgNi1+0Ge
        zkzBpNzSI3X+6elawaAcJ/wJkjCBtKpKTiWEwF0=
X-Google-Smtp-Source: ABdhPJzrA9aIb2BbE0lWagI3+XE0XKAg7qn3gSUlNS0HnH2/8JbM1k1enyP7wLr7bRTJVSNLjEIoy9fiEcRhnF0cjM8=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:7933:7015:a5d5:3835])
 (user=samitolvanen job=sendgmr) by 2002:a05:6214:945:: with SMTP id
 dn5mr4904341qvb.3.1617226065111; Wed, 31 Mar 2021 14:27:45 -0700 (PDT)
Date:   Wed, 31 Mar 2021 14:27:15 -0700
In-Reply-To: <20210331212722.2746212-1-samitolvanen@google.com>
Message-Id: <20210331212722.2746212-12-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210331212722.2746212-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v4 11/17] psci: use function_nocfi for cpu_resume
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

With CONFIG_CFI_CLANG, the compiler replaces function pointers with
jump table addresses, which results in __pa_symbol returning the
physical address of the jump table entry. As the jump table contains
an immediate jump to an EL1 virtual address, this typically won't
work as intended. Use function_nocfi to get the actual address of
cpu_resume.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 drivers/firmware/psci/psci.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index f5fc429cae3f..64344e84bd63 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -325,8 +325,9 @@ static int __init psci_features(u32 psci_func_id)
 static int psci_suspend_finisher(unsigned long state)
 {
 	u32 power_state = state;
+	phys_addr_t pa_cpu_resume = __pa_symbol(function_nocfi(cpu_resume));
 
-	return psci_ops.cpu_suspend(power_state, __pa_symbol(cpu_resume));
+	return psci_ops.cpu_suspend(power_state, pa_cpu_resume);
 }
 
 int psci_cpu_suspend_enter(u32 state)
@@ -344,8 +345,10 @@ int psci_cpu_suspend_enter(u32 state)
 
 static int psci_system_suspend(unsigned long unused)
 {
+	phys_addr_t pa_cpu_resume = __pa_symbol(function_nocfi(cpu_resume));
+
 	return invoke_psci_fn(PSCI_FN_NATIVE(1_0, SYSTEM_SUSPEND),
-			      __pa_symbol(cpu_resume), 0, 0);
+			      pa_cpu_resume, 0, 0);
 }
 
 static int psci_system_suspend_enter(suspend_state_t state)
-- 
2.31.0.291.g576ba9dcdaf-goog

