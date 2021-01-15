Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BACA2F8736
	for <lists+linux-arch@lfdr.de>; Fri, 15 Jan 2021 22:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbhAOVHl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Jan 2021 16:07:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730479AbhAOVHk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Jan 2021 16:07:40 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DAD0C061795
        for <linux-arch@vger.kernel.org>; Fri, 15 Jan 2021 13:06:22 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id w17so8123473ybl.15
        for <linux-arch@vger.kernel.org>; Fri, 15 Jan 2021 13:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Pk+/3vhHV1xEG9unAxvM2nHFQRHjFNkladeJ1DpyMEQ=;
        b=YtUabltwqDD2huPEgp7ma2Kb1CHzezcUG1cS5/UvjiuFAPFzQDdoE9JAMKMUXs5z/V
         y1hGRaZuErhed9F05vs6PC3pSijJY5G11R0ypaxGDTIpRl9SLQW/lCWWTb/viI6VCc4L
         AjCRaft4wt+zMqUzAkmFXnUer9CEivqFh7rzRRxvP50mx5BIkpaKtWyT0cWIs/ZecbGz
         RFWiJLhTNSHPffS7VTDnAF9cw+50l4UJUPLAmG6UH7eAV3trQooouVIKnNe1nFZtfR1z
         9gdp7tNarMVStL66hFT2ykn+/t9WhQerNa1zUXkTh3CDWn/9wJ7YE8YO9Hs76FOdFptH
         jFzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Pk+/3vhHV1xEG9unAxvM2nHFQRHjFNkladeJ1DpyMEQ=;
        b=HLiSBbA5KSzO9KyN7qfdJipYk9ZbKe9sRCvT51T54jzaRckvoj0VPgx1BPsti03XWV
         3O1UD2mcCuzseP7TfwocyUhEIpYy0JHXIJqR9gECZEJ7uhSdyEIDXzCxpTcR5CLvVdw5
         E8tM8Vn9gj6am10r8L7blCBOV5SIzh5zI+4SsytOFZwSpAQWG4507dMXKzX29ggddDwc
         GeuGygR5uRl6hvosbNsm6cJYqauOv8pTnXGOe+hCvpwJnYZbrzlilHgm1aWGq2BOIx5v
         gw0uDH15VnqtMPxRWXU4uieCTSbEh9cG6PO2UZEhUGI2wiHkanMFv86SsyirOiJl/x9x
         V1rA==
X-Gm-Message-State: AOAM532LM2U/mhzCex/k7zLOcvKCtAgLaJzzaPi+j+w4kN93lpqshliJ
        OwHmKpgrgQnUJkgb5f1OWKtU0a/i2wxf3Q/OlQ4=
X-Google-Smtp-Source: ABdhPJxNlmqZG0cN0XrG1Vi444QhXtFVRO8g6MVBjn01sQ7aOn5TrLTvYRK6BQhRRu0Adrl1XthsKWrvipLT/VRY7xI=
Sender: "ndesaulniers via sendgmr" 
        <ndesaulniers@ndesaulniers1.mtv.corp.google.com>
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:a25:16c5:: with SMTP id
 188mr20566201ybw.62.1610744781522; Fri, 15 Jan 2021 13:06:21 -0800 (PST)
Date:   Fri, 15 Jan 2021 13:06:14 -0800
In-Reply-To: <20210115210616.404156-1-ndesaulniers@google.com>
Message-Id: <20210115210616.404156-2-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20210115210616.404156-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v5 1/3] Remove $(cc-option,-gdwarf-4) dependency from CONFIG_DEBUG_INFO_DWARF4
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        Jakub Jelinek <jakub@redhat.com>,
        Fangrui Song <maskray@google.com>,
        Caroline Tice <cmtice@google.com>,
        Nick Clifton <nickc@redhat.com>, Yonghong Song <yhs@fb.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Masahiro Yamada <masahiroy@kernel.org>

The -gdwarf-4 flag is supported by GCC 4.5+, and also by Clang.

You can see it at https://godbolt.org/z/6ed1oW

  For gcc 4.5.3 pane,    line 37:    .value 0x4
  For clang 10.0.1 pane, line 117:   .short 4

Given Documentation/process/changes.rst stating GCC 4.9 is the minimal
version, this cc-option is unneeded.

Note
----

CONFIG_DEBUG_INFO_DWARF4 controls the DWARF version only for C files.

As you can see in the top Makefile, -gdwarf-4 is only passed to CFLAGS.

  ifdef CONFIG_DEBUG_INFO_DWARF4
  DEBUG_CFLAGS    += -gdwarf-4
  endif

This flag is used when compiling *.c files.

On the other hand, the assembler is always given -gdwarf-2.

  KBUILD_AFLAGS   += -Wa,-gdwarf-2

Hence, the debug info that comes from *.S files is always DWARF v2.
This is simply because GAS supported only -gdwarf-2 for a long time.

Recently, GAS gained the support for --dwarf-[3|4|5] options. [1]
And, also we have Clang integrated assembler. So, the debug info
for *.S files might be improved if we want.

In my understanding, the current code is intentional, not a bug.

[1] https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=31bf18645d98b4d3d7357353be840e320649a67d

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---
 lib/Kconfig.debug | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 78361f0abe3a..dd7d8d35b2a5 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -258,7 +258,6 @@ config DEBUG_INFO_SPLIT
 
 config DEBUG_INFO_DWARF4
 	bool "Generate dwarf4 debuginfo"
-	depends on $(cc-option,-gdwarf-4)
 	help
 	  Generate dwarf4 debug info. This requires recent versions
 	  of gcc and gdb. It makes the debug information larger.
-- 
2.30.0.284.gd98b1dd5eaa7-goog

