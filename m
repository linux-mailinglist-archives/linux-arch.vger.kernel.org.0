Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB8FE2DF9D
	for <lists+linux-arch@lfdr.de>; Wed, 29 May 2019 16:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfE2OXm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 May 2019 10:23:42 -0400
Received: from mail-yb1-f202.google.com ([209.85.219.202]:46539 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbfE2OXm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 May 2019 10:23:42 -0400
Received: by mail-yb1-f202.google.com with SMTP id v15so2027926ybe.13
        for <linux-arch@vger.kernel.org>; Wed, 29 May 2019 07:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hnwNAJD4/mUkL54igU9we9Ltgm5eIKoyhCAZZdgQs58=;
        b=YKxGQyRUZZMeXdD+5O/+YQ8S5R7eOVZ6kTD5No/AR7rwZ7z06vtDtTsA5SB6eDlc2f
         E2KpoyeE0R7XPJPqXP9mvFk+KK4l7E4JO+8U0EMM44C/XodSHzZK10dB8YhWF+0aCBRo
         10xD9xjQcKooejbvTzCf+VuiKq6KV9TFG7DR+vypS+td8vr+/j4S66GYr81uQIaq6RvU
         4jFJ0MzYenQJ5UIde94C2fBiEQl7uC08nCHiLZ+xDqNzLfLEQIa/L1hDx0g8CQJoXQlN
         VpVHu4wi4d0r79S5Q/w1CPEK4TKmjjKvLWvCmaql3MeHZS1MOYn/SrVopPlMbFMxYC34
         kkKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hnwNAJD4/mUkL54igU9we9Ltgm5eIKoyhCAZZdgQs58=;
        b=sCFsAJRsfktLsnOqOGDFAAWAIhkyionLKAaVP+D2xCPjULaCSidG1iIQN3CRLrahSt
         T3nWlJReEb1SuXtvDMLsbA8SRkcRLOFCbyYyRiozsWFsZfDu+pk2mEbOrUVmTDmjVlUm
         UG37IxeH3Pne0Iu0r72NLKSphO7zgdrM+C2O+1NnRhrqVgkRCIM1H7YR9AXuDviwXNsE
         2wR8C1qNQ1nH/2DVgAmkChgqmkYACTWyR/2Zu8IofBNvUp5EKAFPlUu16l817/vWdcfg
         jRWrVvkzj8tN1xnYrekEI/4qG3cXDJyrE12zSPaoOUKvXna4iXt4T+PNFl2b7MlPtWPy
         5/mg==
X-Gm-Message-State: APjAAAUWeFkJv1FxaBXxb/28zrp3musTmJU/7pqnCmjlSahNa1LPdqGK
        d0rFJdgFBOWn6pa5dzA4hZ7Ltksc9Q==
X-Google-Smtp-Source: APXvYqxPWoe9RlRk/z6kL2jY6+AqJPi9cpOCsqgCyTYg8p3mqnqg2y3MWgDBA9joolHmfQ8GM4azzmSoWA==
X-Received: by 2002:a81:a393:: with SMTP id a141mr11425823ywh.330.1559139821308;
 Wed, 29 May 2019 07:23:41 -0700 (PDT)
Date:   Wed, 29 May 2019 16:15:00 +0200
In-Reply-To: <20190529141500.193390-1-elver@google.com>
Message-Id: <20190529141500.193390-3-elver@google.com>
Mime-Version: 1.0
References: <20190529141500.193390-1-elver@google.com>
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
Subject: [PATCH 2/3] x86: Move CPU feature test out of uaccess region
From:   Marco Elver <elver@google.com>
To:     peterz@infradead.org, aryabinin@virtuozzo.com, dvyukov@google.com,
        glider@google.com, andreyknvl@google.com, mark.rutland@arm.com
Cc:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, arnd@arndb.de, jpoimboe@redhat.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, kasan-dev@googlegroups.com,
        Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This patch is a pre-requisite for enabling KASAN bitops instrumentation:
moves boot_cpu_has feature test out of the uaccess region, as
boot_cpu_has uses test_bit. With instrumentation, the KASAN check would
otherwise be flagged by objtool.

This approach is preferred over adding the explicit kasan_check_*
functions to the uaccess whitelist of objtool, as the case here appears
to be the only one.

Signed-off-by: Marco Elver <elver@google.com>
---
v1:
* This patch replaces patch: 'tools/objtool: add kasan_check_* to
  uaccess whitelist'
---
 arch/x86/ia32/ia32_signal.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
index 629d1ee05599..12264e3c9c43 100644
--- a/arch/x86/ia32/ia32_signal.c
+++ b/arch/x86/ia32/ia32_signal.c
@@ -333,6 +333,7 @@ int ia32_setup_rt_frame(int sig, struct ksignal *ksig,
 	void __user *restorer;
 	int err = 0;
 	void __user *fpstate = NULL;
+	bool has_xsave;
 
 	/* __copy_to_user optimizes that into a single 8 byte store */
 	static const struct {
@@ -352,13 +353,19 @@ int ia32_setup_rt_frame(int sig, struct ksignal *ksig,
 	if (!access_ok(frame, sizeof(*frame)))
 		return -EFAULT;
 
+	/*
+	 * Move non-uaccess accesses out of uaccess region if not strictly
+	 * required; this also helps avoid objtool flagging these accesses with
+	 * instrumentation enabled.
+	 */
+	has_xsave = boot_cpu_has(X86_FEATURE_XSAVE);
 	put_user_try {
 		put_user_ex(sig, &frame->sig);
 		put_user_ex(ptr_to_compat(&frame->info), &frame->pinfo);
 		put_user_ex(ptr_to_compat(&frame->uc), &frame->puc);
 
 		/* Create the ucontext.  */
-		if (boot_cpu_has(X86_FEATURE_XSAVE))
+		if (has_xsave)
 			put_user_ex(UC_FP_XSTATE, &frame->uc.uc_flags);
 		else
 			put_user_ex(0, &frame->uc.uc_flags);
-- 
2.22.0.rc1.257.g3120a18244-goog

