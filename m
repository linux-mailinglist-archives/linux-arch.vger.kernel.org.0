Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A44AC2F4023
	for <lists+linux-arch@lfdr.de>; Wed, 13 Jan 2021 01:47:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392371AbhAMAnQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 Jan 2021 19:43:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392415AbhAMAeI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Jan 2021 19:34:08 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F00FC0617A2
        for <linux-arch@vger.kernel.org>; Tue, 12 Jan 2021 16:32:49 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id u14so76651pjl.2
        for <linux-arch@vger.kernel.org>; Tue, 12 Jan 2021 16:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=dP6j6wcQj1tq0vOLcWGfFHo7iRnRUUl3C2I4O7J7Ozg=;
        b=HZ1OdG3AUYYjnfuIgSl2h48zf8Lc8TWv0B1ET6Q23GEo4BkJjbddMItpDsuFBvKrjp
         V9Lybk1v5NoyoXQzjgPuD0Ee1SNw1OxfZtUOc8wKcVYm4W1/MwBB6QvZHbqNoY/5YpPI
         Rs52mOOCneWpnNsEPyrAYvG5JiqK8UYr0BMxT4NCHNiMeH1Q/JCt2u64AbB/Hgo/+8gO
         0zySVBzWlPqREI+U/ri2WS5YZBEC6gtegTnMcwfo1ee7cyJe3m5EMt1llZJ6L1XQMULn
         VXuv6CbDtvOq/NBp8KrxjW2cxl8BIqo5o+XRXSPs48u4akZ1PtV6XAaWUyupqa7rX0wb
         3cMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dP6j6wcQj1tq0vOLcWGfFHo7iRnRUUl3C2I4O7J7Ozg=;
        b=a28PLi2ESJv8hwfE5S8M47LQynvr+NulGpqnUyE5wPN6SPHeQxSmh+sRfkVAuOpcnL
         IrqYY73TJm8TrG1Ia2CzWjAQrkaa0Una+ciFeX/ZMyMIuh+TCCddCbFw9eFBz6U9jqLB
         b4qP6C5pW8blVpRfG6pIRxa5yd4XFVzvzm+/yCSHVKik/1cQTg7FbwEB6dDI3a8QPzSw
         2mpELW4MLUxKhSgJ2X/swLdp2lH5QBFk1p8cIzo1SjvrPVQdT71gTyOBePuQVtbrvu/c
         OdyMhRr6T52cwSW392eOu4TBHAqiPUu/A8KNppBKqz7m2ewWAjFLFrN8M474gH9fhOiW
         B7DQ==
X-Gm-Message-State: AOAM533VFivCZITlgERQkECQfS52JoOEWS+ASxR8a342Lt2OhDVBlqC/
        BP1brPTHhx7cD2TyK8wtyrBUJ0RiLZEhJyKores=
X-Google-Smtp-Source: ABdhPJwq5fbkvZctrZiF7pXQ41VncnRxpB/+3veDd4p8cC9GtOVC+KE7VsOZMV/3VwRTIIjPqQle1f8xxEWkHZ/9bMw=
Sender: "ndesaulniers via sendgmr" 
        <ndesaulniers@ndesaulniers1.mtv.corp.google.com>
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:a17:90a:ce0c:: with SMTP id
 f12mr301315pju.89.1610497969060; Tue, 12 Jan 2021 16:32:49 -0800 (PST)
Date:   Tue, 12 Jan 2021 16:32:33 -0800
In-Reply-To: <20210113003235.716547-1-ndesaulniers@google.com>
Message-Id: <20210113003235.716547-2-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20210113003235.716547-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v4 1/3] Remove $(cc-option,-gdwarf-4) dependency from CONFIG_DEBUG_INFO_DWARF4
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
        Nick Clifton <nickc@redhat.com>,
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

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
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

