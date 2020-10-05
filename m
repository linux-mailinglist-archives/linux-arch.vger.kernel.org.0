Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A996D282EF6
	for <lists+linux-arch@lfdr.de>; Mon,  5 Oct 2020 04:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbgJECw4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 4 Oct 2020 22:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbgJECw4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 4 Oct 2020 22:52:56 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5037C0613E9
        for <linux-arch@vger.kernel.org>; Sun,  4 Oct 2020 19:52:54 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id o25so5060482pgm.0
        for <linux-arch@vger.kernel.org>; Sun, 04 Oct 2020 19:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6IciHQ57heACOgQ9PC/WQNL2sEIEWQWn+OKT+AO4y60=;
        b=LRvEZ8zpjZa9iws3k1kqhxIuv+LUoqY7rPOE5iQhDSqNQgQA+Wz7eobrYV57c6G7zc
         rz592NrXEpqUGr/8TRoDwOga6VETgAEtksSa0bC8MFrck4LgWBajHHdkkWIo0EoTh9zD
         pb1WPerZkRLrnS9rICIEQBhXS5pEP2vq4OOwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6IciHQ57heACOgQ9PC/WQNL2sEIEWQWn+OKT+AO4y60=;
        b=S/bfrhvT5zfo1SHguemUheVww8axWLKbSgVW/n2SWPj+cOal5tD9n5s39DqAMqVlHn
         Lb58jPJP07FlOA+avo5V6Br9AVbNbPy9uJsfaIgAWfYlFjCcPfSLklMpZMQoEABvqTC+
         4wZta4zt0Qrv9JppTPwXVXGZnDHuGaa0Ul/LLUwAfblMS1T6QBBFJAu+seXpSb+3J9Px
         3JYd9dH59j6yH4UTp7Dr5gcFz6aMiKcbFLyKjzEYTuWgwW1tUTuN4IgXUibry+IVxAkL
         lD9BpXz/7OSrLMoKaG0qA7DVEere8KO3CyfwgO1q4nLAdE5lHw7OOq1vf88wkoMw3tpN
         ePlg==
X-Gm-Message-State: AOAM531v+PMfxV1wi3mFqG5ZKsptJbRYlKDfgm7RBKOy83QsmNJaZrY7
        7C6P9VWKALeIvxBnYEUnUPmiOg==
X-Google-Smtp-Source: ABdhPJwrfDf3JzEwDE2YM9/KbmpWBOTABz2Rs41fp6ejRSjaMIZwttbPkItPcfdn37XRe9FjRs3H2Q==
X-Received: by 2002:a65:51c7:: with SMTP id i7mr12908598pgq.325.1601866374381;
        Sun, 04 Oct 2020 19:52:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t13sm1875164pfc.1.2020.10.04.19.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2020 19:52:53 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] vmlinux.lds.h: Keep .ctors.* with .ctors
Date:   Sun,  4 Oct 2020 19:52:47 -0700
Message-Id: <20201005025247.2599175-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Under some circumstances, the compiler generates .ctors.* sections. This
is seen doing a cross compile of x86_64 from a powerpc64el host:

x86_64-linux-gnu-ld: warning: orphan section `.ctors.65435' from `kernel/trace/trace_clock.o' being
placed in section `.ctors.65435'
x86_64-linux-gnu-ld: warning: orphan section `.ctors.65435' from `kernel/trace/ftrace.o' being
placed in section `.ctors.65435'
x86_64-linux-gnu-ld: warning: orphan section `.ctors.65435' from `kernel/trace/ring_buffer.o' being
placed in section `.ctors.65435'

Include these orphans along with the regular .ctors section.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Link: https://lore.kernel.org/lkml/20200914132249.40c88461@canb.auug.org.au
Tested-by: Stephen Rothwell <sfr@canb.auug.org.au>
Link: https://lore.kernel.org/lkml/20201004210018.5bbc6126@canb.auug.org.au
Fixes: 83109d5d5fba ("x86/build: Warn on orphan section placement")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/asm-generic/vmlinux.lds.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 5430febd34be..45c8b362ca45 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -684,6 +684,7 @@
 #ifdef CONFIG_CONSTRUCTORS
 #define KERNEL_CTORS()	. = ALIGN(8);			   \
 			__ctors_start = .;		   \
+			KEEP(*(SORT(.ctors.*)))	   \
 			KEEP(*(.ctors))			   \
 			KEEP(*(SORT(.init_array.*)))	   \
 			KEEP(*(.init_array))		   \
-- 
2.25.1

