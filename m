Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE1EA282EFB
	for <lists+linux-arch@lfdr.de>; Mon,  5 Oct 2020 04:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725863AbgJEC53 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 4 Oct 2020 22:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbgJEC52 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 4 Oct 2020 22:57:28 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0FFC0613CE
        for <linux-arch@vger.kernel.org>; Sun,  4 Oct 2020 19:57:28 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id k8so5851355pfk.2
        for <linux-arch@vger.kernel.org>; Sun, 04 Oct 2020 19:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OGtLendMkx3eeiJ6VgZEb6Gt3GGRj2yTJFPvPu5CLd4=;
        b=RaF15Fd9rYMAFtanTSuiLem9OplLh2MzO6PBjm+lngJx9STARKCibEd3b0xHsunTvN
         7kiUTbR2+wm8WuBfQQO0XldpTAfbxT0hTaAQeAESh0fziqtK7T9vf4nwlgsOSi2UA8zb
         9kKQF2KzC/o+KXmnclK6xjAISy50b9I5axX18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OGtLendMkx3eeiJ6VgZEb6Gt3GGRj2yTJFPvPu5CLd4=;
        b=kOuY2ihztifJzeHC08oOW9lUdCgqZqesA6SJMOTpf8svbhbd5jzZDS8mypx/5dFuD7
         PDY4Z9pjxPp5WsJv84oznaYo/GszeM4IVj+tb/E5evleARK1OLTMEL6bpVHvIgG+JFvo
         3/w6rIzv9qMmMgLaXx6VypxW0upmCX8XOs4ga04fvzqi5YAtJ3z7OROBNYwQ+SQpOuqB
         7br+kL0BXTbPyVksZMfUUp8Y7k3gJ43o2rF1NTUTUUysS4AUNwoGk03FuZvtFv7LmMD2
         Dsx1hif9TOevMKnxfE1fCQeojeZEabMhjEYImJA9jmd1nlF4sdE3xoRhbq4FJZ+8rjVt
         tdfg==
X-Gm-Message-State: AOAM532DlCclHv4ltA9cUmAezJXhEs94axROyN9EqfGRM11pV349bfs7
        ADvvRyDbSTxsOf3cKLIqYvzsLQ==
X-Google-Smtp-Source: ABdhPJzYZsOniKAdLpOGV0sZrQgSDI//LpzB3EcBLlQs0cCuAinuv387ORUReuh/aVhXmGOCp/qyJw==
X-Received: by 2002:a62:2985:0:b029:142:2501:34d6 with SMTP id p127-20020a6229850000b0290142250134d6mr14273789pfp.47.1601866648452;
        Sun, 04 Oct 2020 19:57:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g126sm9476727pfb.32.2020.10.04.19.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2020 19:57:27 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] vmlinux.lds.h: Keep .ctors.* with .ctors
Date:   Sun,  4 Oct 2020 19:57:20 -0700
Message-Id: <20201005025720.2599682-1-keescook@chromium.org>
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
Tested-by: Stephen Rothwell <sfr@canb.auug.org.au>
Fixes: 83109d5d5fba ("x86/build: Warn on orphan section placement")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v2: brown paper bag version: fix whitespace for proper backslash alignment
---
 include/asm-generic/vmlinux.lds.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 5430febd34be..b83c00c63997 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -684,6 +684,7 @@
 #ifdef CONFIG_CONSTRUCTORS
 #define KERNEL_CTORS()	. = ALIGN(8);			   \
 			__ctors_start = .;		   \
+			KEEP(*(SORT(.ctors.*)))		   \
 			KEEP(*(.ctors))			   \
 			KEEP(*(SORT(.init_array.*)))	   \
 			KEEP(*(.init_array))		   \
-- 
2.25.1

