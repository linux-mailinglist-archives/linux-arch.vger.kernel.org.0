Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6B5630EC9C
	for <lists+linux-arch@lfdr.de>; Thu,  4 Feb 2021 07:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232947AbhBDGlh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Feb 2021 01:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232799AbhBDGlh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Feb 2021 01:41:37 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC957C06178A
        for <linux-arch@vger.kernel.org>; Wed,  3 Feb 2021 22:40:46 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id g14so1824286qtu.13
        for <linux-arch@vger.kernel.org>; Wed, 03 Feb 2021 22:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=iFigka3JXPbuBeHUARia6t3bp5DpIh0Lh5S9mG4lTkc=;
        b=jXOhuAtQmp2iBB4CXNhILgsBGuonno1OECxXMZX9iyxNm02XOPTxc17MqMTbwqaPqF
         udTnSMcPmoRk4K6U2d6DxWMSN7g4ndN7nep1DRz8Ch/APFdzZ3oNPeN7deIoM84Ky4XM
         ijatQ6u3zl4OQG+WD873YWEdjgVilT3rEGIMemu5bqWNi8o2HYjmgLvx3dGpMjnEqXq+
         ttQYfWrlK0WjfJu+grCRHxhwNdJblJBw/ntTLE6LD7cKcqh1jZ0z92Fz45dHwpFmZFzj
         hGctfUAdgO3nTnGL14Rvxk+GUd2Iassm97SjjdNrkEjj0g1SLO5G6tfm3R3aG2sruZG6
         MZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iFigka3JXPbuBeHUARia6t3bp5DpIh0Lh5S9mG4lTkc=;
        b=ih3lLkg0KN6G27T8/1HOe0yCnzmb8lXHyyoUlqBEiH/mZJTsPycscsLvKB2jmL70OB
         mcPwysd03DIjsC87bLIEuX0Htg3Tffml2CXpdXj5q6MeHtTH+RVD2bL3iq+3o9TGmjsv
         y6YiZDg64lSKlC3sJPmtPaZC6gLDywdWDgw2dEdwMJC+NRzZvfhFAcPmvZ0pyZKQix7M
         dFD9xWpBMX3Xej1gBVe7lBptiaa0m4IhynN/RLFStAsp4IZOu2RfiKIhWQHazV3+sAZB
         tDmygDfdIKFhJPcVkCeipRf4uBduLp4IhANuMo1rj8DPtsqPMe2CqVSeJvHuAxY0JkpE
         WsRw==
X-Gm-Message-State: AOAM533dgz/9TX92K3qYG+mwnLcnJ9liOUwxmdfQoWZNgM4/Kc1Td91o
        r54RDnx+70FU5mVXW+15kpYVEoMd/IBvw1WbEjM=
X-Google-Smtp-Source: ABdhPJxvSiVjhRNEbyS9ZOTjE3ThjkTruIefIL1DvVqTcqkWnCLGNAOlSfGIlmXetQe7g0Hf8AxkOepCVJnOzV1gtAs=
Sender: "ndesaulniers via sendgmr" 
        <ndesaulniers@ndesaulniers1.mtv.corp.google.com>
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:e070:bc84:c4fd:eb02])
 (user=ndesaulniers job=sendgmr) by 2002:a05:6214:18cb:: with SMTP id
 cy11mr6069393qvb.61.1612420846028; Wed, 03 Feb 2021 22:40:46 -0800 (PST)
Date:   Wed,  3 Feb 2021 22:40:36 -0800
In-Reply-To: <20210204064037.1281726-1-ndesaulniers@google.com>
Message-Id: <20210204064037.1281726-2-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20210204064037.1281726-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v8 1/2] Kbuild: make DWARF version a choice
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
        Arvind Sankar <nivedita@alum.mit.edu>,
        Chris Murphy <bugzilla@colorremedies.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Modifies CONFIG_DEBUG_INFO_DWARF4 to be a member of a choice which is
the default. Does so in a way that's forward compatible with existing
configs, and makes adding future versions more straightforward.

GCC since ~4.8 has defaulted to this DWARF version implicitly.

Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Suggested-by: Arvind Sankar <nivedita@alum.mit.edu>
Suggested-by: Fangrui Song <maskray@google.com>
Suggested-by: Nathan Chancellor <nathan@kernel.org>
Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 Makefile          |  5 ++---
 lib/Kconfig.debug | 16 +++++++++++-----
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index 407816375983..bed5cc150009 100644
--- a/Makefile
+++ b/Makefile
@@ -830,9 +830,8 @@ ifneq ($(LLVM_IAS),1)
 KBUILD_AFLAGS	+= -Wa,-gdwarf-2
 endif
 
-ifdef CONFIG_DEBUG_INFO_DWARF4
-DEBUG_CFLAGS	+= -gdwarf-4
-endif
+dwarf-version-$(CONFIG_DEBUG_INFO_DWARF4) := 4
+DEBUG_CFLAGS	+= -gdwarf-$(dwarf-version-y)
 
 ifdef CONFIG_DEBUG_INFO_REDUCED
 DEBUG_CFLAGS	+= $(call cc-option, -femit-struct-debug-baseonly) \
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index e906ea906cb7..94c1a7ed6306 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -256,13 +256,19 @@ config DEBUG_INFO_SPLIT
 	  to know about the .dwo files and include them.
 	  Incompatible with older versions of ccache.
 
+choice
+	prompt "DWARF version"
+	help
+	  Which version of DWARF debug info to emit.
+
 config DEBUG_INFO_DWARF4
-	bool "Generate dwarf4 debuginfo"
+	bool "Generate DWARF Version 4 debuginfo"
 	help
-	  Generate dwarf4 debug info. This requires recent versions
-	  of gcc and gdb. It makes the debug information larger.
-	  But it significantly improves the success of resolving
-	  variables in gdb on optimized code.
+	  Generate DWARF v4 debug info. This requires gcc 4.5+ and gdb 7.0+.
+	  It makes the debug information larger, but it significantly
+	  improves the success of resolving variables in gdb on optimized code.
+
+endchoice # "DWARF version"
 
 config DEBUG_INFO_BTF
 	bool "Generate BTF typeinfo"
-- 
2.30.0.365.g02bc693789-goog

