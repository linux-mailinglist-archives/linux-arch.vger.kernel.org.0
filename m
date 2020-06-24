Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4A85207D56
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jun 2020 22:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406597AbgFXUdg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jun 2020 16:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406593AbgFXUdf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Jun 2020 16:33:35 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF17C061795
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 13:33:35 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id e4so2429575qtd.13
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 13:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=39oSk63TLcybcU14SgKvCDK3H6XzHtEtduXPCr/44ss=;
        b=ZOpDZdrGdHh1ZJonf0E/5dDbHERSe6TbCFmdB2U6jPIiwcNANMbLkyJvmpov2k2xOy
         UVWsqBFfeytL+Hgc/oR6FsAd9G11hUgAXJsCWawlND5MVBWd0mWD5Dc0EmC9ABVsRrwk
         SuNrnMuN7GhuqelKUl2otkPK4jEY0L0Bm6whau77q3fZbpcyNGO1mB7+EOqkQJEsefdW
         zLLLl7cpOUj8LxrFN5V51O7w7SPh0uXELCQRumvXzfHQsZ4xwEEn1hGOm5BLrbAhkADT
         mOeNJdhYt+ZgbwtN0PEW0MGrw4iretwo3Lq6tyaoaAFryjr8t8wGNBEOp88gmFSQ4dk6
         T0OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=39oSk63TLcybcU14SgKvCDK3H6XzHtEtduXPCr/44ss=;
        b=Hs73wJBRyEiX8ffS/fYA7yjKHotQCvg2Y57pOoXO+OPl1yCrU/dDv3wExysHqTITmm
         TOirMf4Z2qW0ivuKtX+yb8XaHnCYYA8Ndtz7vePhcRKo6CC9XSMe504b282MF5bnbYtX
         /62QLnjx5GqQR5zn2gsNpym9zt6T6ahoc8n8QzF8+8oxz9Uk0k9S5AXy70aBeipwcO5h
         y5hlMf7bY5v5++VYud/ILObtpor1CkQ3vGeriBQZ2XiUytxuN6H1fQiG2GG0KUCr3V81
         q6OerUvEFGYStuPAjHWmj30YXebcUuJaevW6vcMiyERv66Jm77Prdp0L4PeffpLSLObF
         BGAQ==
X-Gm-Message-State: AOAM5317WLNhI5BdMdprKUUyddvgDKLJfWoU5XUV9iHiUqs0UgXL/TSB
        AFTpePyJ3JGGQlahjaufHwh1Rl7emdjBCes5xlg=
X-Google-Smtp-Source: ABdhPJzI2BesdcUkxRPNmsNayE+wa07nV1TDxi5hKxZeEiEV2jo0nWBCJ/1Nmj0kWHXA23yigO5wL2sAexNblZcBJws=
X-Received: by 2002:ad4:52e2:: with SMTP id p2mr33679309qvu.100.1593030814530;
 Wed, 24 Jun 2020 13:33:34 -0700 (PDT)
Date:   Wed, 24 Jun 2020 13:31:58 -0700
In-Reply-To: <20200624203200.78870-1-samitolvanen@google.com>
Message-Id: <20200624203200.78870-21-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH 20/22] x86, ftrace: disable recordmcount for ftrace_make_nop
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Ignore mcount relocations in ftrace_make_nop.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/kernel/ftrace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 51504566b3a6..c3b28b81277b 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -121,6 +121,7 @@ ftrace_modify_code_direct(unsigned long ip, const char *old_code,
 	return 0;
 }
 
+__nomcount
 int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec, unsigned long addr)
 {
 	unsigned long ip = rec->ip;
-- 
2.27.0.212.ge8ba1cc988-goog

