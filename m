Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 961CF2B8764
	for <lists+linux-arch@lfdr.de>; Wed, 18 Nov 2020 23:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbgKRWIP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 Nov 2020 17:08:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbgKRWIP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 Nov 2020 17:08:15 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE05AC0613D4
        for <linux-arch@vger.kernel.org>; Wed, 18 Nov 2020 14:08:13 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id v13so4470041ybe.18
        for <linux-arch@vger.kernel.org>; Wed, 18 Nov 2020 14:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=zNEbBbUjVUwNrqsw9c+UpkNEFF7VA0EYfHLp5cIzntw=;
        b=n0bp9cJvxDsjt7xTCOt5iMFW1d/2tTomLx5U5GAiKgRUC31U0PGdIlVksp+a0VVrdY
         g5/MehVGAk5dAFkfZ/0D3/kc0qKP/5ghMg0SX2rzCLQrn7ZzkYIMJRTQA4tAkeENX90q
         zMfWfxpHMr797C3+ufNsF8n5E2EarI0M+SxfmyYFrfheXFRY/USHp0McDL2ojl4Lgr9c
         ZSVHHwyxFBuJf6EQIB49Tm2/Idyx3u+mRdPPOBh4ppAaY5/pZ300gTIMAOc0hbNqctmz
         NshfWwPYJRHHUsUv7bRZJJIdOYMWpv3CBbpJoRLYa/A5uDpHU91hRb4ca8tn+CBC/z2v
         7wmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zNEbBbUjVUwNrqsw9c+UpkNEFF7VA0EYfHLp5cIzntw=;
        b=t+NIUMAcOvBGQ21kvc6nKzb5mzbw9vrp8i431oknbBdP1n/XkMPC45Jd/kmguIHHyS
         gRLDxACC2VtcN1CCSThrpFsjRHZa1n7zTtifud0xkSmCY83jzayHC6IAYL0F5aW7DcVW
         mW5AbEXWr26dU7h6SpV32zk4ybu9vzD5t16xm/cL19Uq8j24PNDH8x6WLZoRnGH+Npys
         M3BPJytgk+QgVH2ls1uDds7IP27GSTgHVBT0WpLyJfvu1vQ7Ccs/C0bxj1FEGfhY2k51
         sYh4y7PShO32hsvNT75TWBkEEVIA6mlZLDt4J/p/3FOoi3CfyJTIM6tfgbygU84+BO2s
         yKIg==
X-Gm-Message-State: AOAM531AmcocC9Uj0ejCIsg2IaoeRRISxxtWCRaj/baYOqRfAN2sfKAf
        5IT6L41Ksbl4LRf2uC4HzYqOYsSszNhA6VzqZnQ=
X-Google-Smtp-Source: ABdhPJwWbtiTp58G6aNpNqEPufDWDe2zDs+IKNE1XLpICWlrRQN8YWmIrp5YpIBo0gnH6aOzErytNSLLgd+pskDj6ew=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a25:aa04:: with SMTP id
 s4mr8172287ybi.285.1605737293084; Wed, 18 Nov 2020 14:08:13 -0800 (PST)
Date:   Wed, 18 Nov 2020 14:07:31 -0800
In-Reply-To: <20201118220731.925424-1-samitolvanen@google.com>
Message-Id: <20201118220731.925424-18-samitolvanen@google.com>
Mime-Version: 1.0
References: <20201118220731.925424-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v7 17/17] arm64: allow LTO_CLANG and THINLTO to be selected
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Allow CONFIG_LTO_CLANG and CONFIG_THINLTO to be enabled.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index c7f07978f5b6..56bd83a764f4 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -73,6 +73,8 @@ config ARM64
 	select ARCH_USE_SYM_ANNOTATIONS
 	select ARCH_SUPPORTS_MEMORY_FAILURE
 	select ARCH_SUPPORTS_SHADOW_CALL_STACK if CC_HAVE_SHADOW_CALL_STACK
+	select ARCH_SUPPORTS_LTO_CLANG
+	select ARCH_SUPPORTS_THINLTO
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128 && (GCC_VERSION >= 50000 || CC_IS_CLANG)
 	select ARCH_SUPPORTS_NUMA_BALANCING
-- 
2.29.2.299.gdc1121823c-goog

