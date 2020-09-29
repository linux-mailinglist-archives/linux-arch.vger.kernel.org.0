Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2992A27DADC
	for <lists+linux-arch@lfdr.de>; Tue, 29 Sep 2020 23:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbgI2VsB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Sep 2020 17:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728617AbgI2Vqx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 29 Sep 2020 17:46:53 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB94C0613D3
        for <linux-arch@vger.kernel.org>; Tue, 29 Sep 2020 14:46:52 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id t4so3334041qvr.21
        for <linux-arch@vger.kernel.org>; Tue, 29 Sep 2020 14:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Xjrukg6K3IydY/lqqi+bCZNdR5RjdEmABiI8yk+fZMI=;
        b=HdK7XgY20csMFcb+NLyDCXa0Y0BGLZ848JpvtrKXuN4kP13qc7mB9gIo/tOvGsTK0n
         Ji2dtRPOFfuxFcA+duNxDZiijoE33HNw7tWDF5E8m1wqENg9cj6ei3CjwJ0N3MORXBa0
         OiIDsCN2lwWZN36P+HMA0/i6r+hGq8LSRXCmTEW0ezq9gHlvKKSRObpHJBOae/EdWdAU
         32Gd6c/t2yV+iQQ9uWMBg3zEyEcOs6POlcO4VSL93GZziqn82PoJ2cs2fwnaH1D9AfNM
         SAML6VP9UfLTVbfCFJsAI8Lgk3AeE4OjZhWgBqaEtQTo1lOZgisnM8dMNB6pz6Qg5Lay
         cqDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Xjrukg6K3IydY/lqqi+bCZNdR5RjdEmABiI8yk+fZMI=;
        b=J6lEvpjLzrsbSW3kR6W9vK8XMxS7s7SbzaTqZnd+FzhJbhXdBBl8tQq2yqaBHKPSSD
         9cSd6OM6ltYwWiQzoSMQg2LAlxaNiX8ys0smg+e5QqUwhwIfZhgYJoK9/J1iaRNHC2Rp
         ECNnldTzjQtD3kGEKrd3+iMllnUg960kXeYTGISDCgIqE9ApejT4qMf5JzoeM3Jiyz6N
         xP9jR9cwf+AJRO8vH4GgP6En7w0Le+6gooAUW5wPHlN/GfOL/DdzCVrQVLvvcq9BqPCn
         BoDytXlTLLYjLq1Aq133ND7hX20zMWk4+diKe9wxZrAOLu1GXN7ARsRIotaV+RrxcSD2
         hUdQ==
X-Gm-Message-State: AOAM533sEUj9WKmBqiE+AHSA/FvXzSTCMVTktI7QFvktB1C+5cQTi7G2
        4LjwnAd/qMmdgIUzL6LBj5ab+XcJPMCty73aHM8=
X-Google-Smtp-Source: ABdhPJy7cJ63oyWVE3guhSQ8dpAugUL8BOvZOYiTdX/ZOOHGsEKlj0fM6UJAmLz8cRUfCBdDvDQP4efk1c6ZbLA+m7Q=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:ad4:42b3:: with SMTP id
 e19mr6361028qvr.6.1601416011975; Tue, 29 Sep 2020 14:46:51 -0700 (PDT)
Date:   Tue, 29 Sep 2020 14:46:11 -0700
In-Reply-To: <20200929214631.3516445-1-samitolvanen@google.com>
Message-Id: <20200929214631.3516445-10-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200929214631.3516445-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH v4 09/29] arm64: disable recordmcount with DYNAMIC_FTRACE_WITH_REGS
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY to disable
recordmcount when DYNAMIC_FTRACE_WITH_REGS is selected.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 6d232837cbee..ad522b021f35 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -155,6 +155,8 @@ config ARM64
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS \
 		if $(cc-option,-fpatchable-function-entry=2)
+	select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY \
+		if DYNAMIC_FTRACE_WITH_REGS
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
 	select HAVE_FAST_GUP
 	select HAVE_FTRACE_MCOUNT_RECORD
-- 
2.28.0.709.gb0816b6eb0-goog

