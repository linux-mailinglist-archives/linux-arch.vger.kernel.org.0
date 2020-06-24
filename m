Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49066207D40
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jun 2020 22:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406500AbgFXUdR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jun 2020 16:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406460AbgFXUdN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Jun 2020 16:33:13 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B40C0613ED
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 13:33:13 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id s9so3499894ybj.18
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 13:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RZTReFFMdjgTHNlONDHd9zt1v7eMyKbgxXLu5A5pzj0=;
        b=EWRzLy7ubn55a8LmKy3CDH4ngbdy7XK7KBx2ndgKQ/3d1qkgK3E2e2e0LoML9LtpAP
         te8DFa082g+gVIfEAqVPkw42n2K5N8oZDQPqI2EE+tN42iDW7P8u4zkwFKaeUaEIL3oq
         RsZa2tBkB8ErLDOh0+LYJEGFNduXUPYCZZp6PS5HSeXJMWIblGduZ6jmagNoIsWizsER
         wasijgerBJQ81R7rPMfgWDc43sju3PnN23fU0SKh+4T9fa3wRlwROOUy5biDfDpraPBM
         LfcrqPMgzOl+e9NbqEnHTOdpcfO4/PQ3tkVTmfAbrRs5+l+SSnKRsruNnEenHpqLqPiQ
         nuGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RZTReFFMdjgTHNlONDHd9zt1v7eMyKbgxXLu5A5pzj0=;
        b=Q6XRQyWFpG6sHbc4Y1uNtE5Tti2AuGRXE6JY9QyKwbdgLbb3yxgPTCgSkgmraTL8vD
         bRb+f/3mxVzGzXt9fZ5joqrCVzEZpbe5IlYuwLfg5LpnAH0wWASEDQYLWxl8BCxtLVbH
         C7Qk62nYTBeULXh+h92hCrJozZ2n1bModvXMmEv6V0Ci8WAjhGVHLz6bqwtPx2t7NUic
         JuJFEn+B2SO9DoMHqNo2DqFXlyo/pDIKfYEuF7vgZUy/kPCREtO+YEe9WPgFM3c6Rzq5
         nSTvEzSscZPHBHo8ljUlc7dtKviFMlkfd+2zDy/xNzlGyLnr9ZKIQAnqUokmXheMeyEv
         UMAw==
X-Gm-Message-State: AOAM532iprF5FSfCtGfIzhaEfkdzltOLm2G9PeYTQrjjig5s+kUWbHeI
        tFJ5yyp42RYU0ew/TMD6cYIPc0BgCy5/5M+pZ14=
X-Google-Smtp-Source: ABdhPJyU2t1AXfcgSNz/10D8PjugKl8rMw6I/kYhEGKclSW1I55A11LPtvbV37/K4/NXZ5XrSzlUdSrpZ+Ia6K6teRs=
X-Received: by 2002:a25:4e0a:: with SMTP id c10mr44794280ybb.346.1593030792698;
 Wed, 24 Jun 2020 13:33:12 -0700 (PDT)
Date:   Wed, 24 Jun 2020 13:31:46 -0700
In-Reply-To: <20200624203200.78870-1-samitolvanen@google.com>
Message-Id: <20200624203200.78870-9-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH 08/22] kbuild: lto: remove duplicate dependencies from .mod files
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

With LTO, llvm-nm prints out symbols for each archive member
separately, which results in a lot of duplicate dependencies in the
.mod file when CONFIG_TRIM_UNUSED_SYMS is enabled. When a module
consists of several compilation units, the output can exceed the
default xargs command size limit and split the dependency list to
multiple lines, which results in used symbols getting trimmed.

This change removes duplicate dependencies, which will reduce the
probability of this happening and makes .mod files smaller and
easier to read.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 scripts/Makefile.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 82977350f5a6..82b465ce3ca0 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -291,7 +291,7 @@ endef
 
 # List module undefined symbols (or empty line if not enabled)
 ifdef CONFIG_TRIM_UNUSED_KSYMS
-cmd_undef_syms = $(NM) $< | sed -n 's/^  *U //p' | xargs echo
+cmd_undef_syms = $(NM) $< | sed -n 's/^  *U //p' | sort -u | xargs echo
 else
 cmd_undef_syms = echo
 endif
-- 
2.27.0.212.ge8ba1cc988-goog

