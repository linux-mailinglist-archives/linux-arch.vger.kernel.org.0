Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDA6204236
	for <lists+linux-arch@lfdr.de>; Mon, 22 Jun 2020 22:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730129AbgFVUxt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 22 Jun 2020 16:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728867AbgFVUxs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 Jun 2020 16:53:48 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB4CC061795
        for <linux-arch@vger.kernel.org>; Mon, 22 Jun 2020 13:53:47 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id r18so8772842pgk.11
        for <linux-arch@vger.kernel.org>; Mon, 22 Jun 2020 13:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mDXLfB+PQDLRQ6NmPDmR2JF3Ok4ZVjhNHcZbi8M58JY=;
        b=jPi/b9t/cgTj3qq2Y+w0Tp93JhZufwpflaLmvJiEevWxTi3dExayl9ry4eqVJN/fWa
         o8Dul0iXlzYg6sDsWr+LM+o6q4SVmNEyXDnChNwemh29HXQJQCorReaJsa0EvUAllkee
         p8bfk/EkllHSz3PZVmYDOYLn+iUf/LwJlmHSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mDXLfB+PQDLRQ6NmPDmR2JF3Ok4ZVjhNHcZbi8M58JY=;
        b=oluYWgdZmDVbpnK00P42RzC+mbLZFOon866UyBiQ+4GHEGBmMC1p7JUdNKPhE6h6j9
         683pHIm4sctpYMj0CGg0emwvB3nwc5maG7Qul3wLEg6XbD5je5fIdxcm/jd7ZXwjrd/P
         X9nsyY/AtzHyGWkR6uG/FJj8oi1V1E+i+kSp1ahmFK8wohb/YFHzsQUpvLlbYVNBQxwC
         x24Kk+gSd8Xkb+wtdkt67aSSoRkeAn0DmXO3RDdPGeKfKZx4TVjlahyqud93XVZn4P+6
         txjqqpXLIcujUXwLdSI+fMJ5o4x8595HMQtWvvn3QSNMcoWsoCLTPcmaBqHc73+OjCi4
         G+sA==
X-Gm-Message-State: AOAM5321/OhXOnyfKAB8dAnEGi89THBtPATcoRO6MNIxDWFOCrapA1xM
        PB72jCpTmZe5Lnn6x9CS9+5KJQ==
X-Google-Smtp-Source: ABdhPJzyxPTRZcNzcoXYNKkQYAQPnWOSEGrY4CLCWimk1cAn3PmhaciF3QcwlYv13B0JtnQ3oe6LXg==
X-Received: by 2002:a05:6a00:7c6:: with SMTP id n6mr20534999pfu.120.1592859226960;
        Mon, 22 Jun 2020 13:53:46 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q22sm11005302pgn.91.2020.06.22.13.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 13:53:46 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@suse.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] x86: Warn on orphan section placement
Date:   Mon, 22 Jun 2020 13:53:38 -0700
Message-Id: <20200622205341.2987797-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

v2:
- split by architecture, rebase to v5.8-rc2
v1: https://lore.kernel.org/lkml/20200228002244.15240-1-keescook@chromium.org/

A recent bug[1] was solved for builds linked with ld.lld, and tracking
it down took way longer than it needed to (a year). Ultimately, it
boiled down to differences between ld.bfd and ld.lld's handling of
orphan sections. Similarly, the recent FGKASLR series brough up orphan
section handling too[2]. In both cases, it would have been nice if the
linker was running with --orphan-handling=warn so that surprise sections
wouldn't silently get mapped into the kernel image at locations up to the
whim of the linker's orphan handling logic. Instead, all desired sections
should be explicitly identified in the linker script (to be either kept or
discarded) with any orphans throwing a warning. The powerpc architecture
actually already does this, so this series extends coverage to x86.

Thanks!

-Kees

[1] https://github.com/ClangBuiltLinux/linux/issues/282
[2] https://lore.kernel.org/lkml/202002242122.AA4D1B8@keescook/

Kees Cook (3):
  vmlinux.lds.h: Add .gnu.version* to DISCARDS
  x86/build: Warn on orphan section placement
  x86/boot: Warn on orphan section placement

 arch/x86/Makefile                      |  4 ++++
 arch/x86/boot/compressed/Makefile      |  3 ++-
 arch/x86/boot/compressed/vmlinux.lds.S | 11 +++++++++++
 arch/x86/kernel/vmlinux.lds.S          |  6 ++++++
 include/asm-generic/vmlinux.lds.h      |  1 +
 5 files changed, 24 insertions(+), 1 deletion(-)

-- 
2.25.1

