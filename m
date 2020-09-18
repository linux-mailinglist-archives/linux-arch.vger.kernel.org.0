Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44F0C27062C
	for <lists+linux-arch@lfdr.de>; Fri, 18 Sep 2020 22:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgIRUO5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Sep 2020 16:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbgIRUOr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Sep 2020 16:14:47 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E0DC0613D6
        for <linux-arch@vger.kernel.org>; Fri, 18 Sep 2020 13:14:45 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id y6so6663210ybi.11
        for <linux-arch@vger.kernel.org>; Fri, 18 Sep 2020 13:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=QG37uO1d4USzrK2i79mol19BZHF3voEs5YXCH0vFDXg=;
        b=kS9nJccCRITkbrAyCK9Hc7v1LETkgjrZzbCI78fOJk9GspwsE0lD6AsMWWG9e/Ya6w
         kQ7OAgO+NsJbiNEURN/xqwJc+nMm2JlmzicPoqTkbkTgYLChVmHJmFrbVcTMgiIM1LfM
         AMIn2fwD4sdTg9b5RFBa3v7hPzAOv72tQhHG2zedzbaGOgS5AllQnoGhiut1jy6gfUPb
         IHOl5kVpEYZmlx3J300NFEalCTngIq2wdGL7A0LMMidJtwteLyUB84t3JQdj/BGr11/r
         XP03Hd7VXorIrHoqHnVpAgFdqejQhRQlU/QiTZkkxeCP6z2bKBR11111wx5Cdsjef2hw
         h1Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QG37uO1d4USzrK2i79mol19BZHF3voEs5YXCH0vFDXg=;
        b=eXJ6Sfnb91B9O+cQE9vD84RBVLY6280ekb9Rg8JkABbx57DcAzHiA5CRnvrqBSADDX
         FME0dAfzRHB3uX32G/6grpkINL3yeHKKkCE2+ms5EBetPJyPedehc8f89izZHMHct0dr
         baRx5Md7e6lyOib/CSnLt8e1PbOzXW7PyRyDgyXjEbccp6f+zf+9TSvezy40IWOQW8YN
         a3Kj245xeNdSidOpOagB1r+bIP5g9TBiTZZK9RbvQfIz7/yoMmmbEg6/8eN2ExXAB+uB
         PADvdLonBoi6X81Nhox7LeMg12XJw589qVsbhzTn7XtMsyEi2zDWBfpkHsrKi/7d27IT
         eSpw==
X-Gm-Message-State: AOAM5335EFeCaeOfbD5/AynqapQpf/5GZV9FN3HDfzfzoaxboel53jxe
        Ib+TIpivqgQm4rrt9Y4VWldNaJL3n/tlbAbGaxU=
X-Google-Smtp-Source: ABdhPJxOIBe5IUGDSTHVDRZfdndNloI1irNa0De5LGLJBg+ujXNg2cTfcMKCeIjDmjymnjpy+o5CvxVSn10XK63j+fc=
Sender: "samitolvanen via sendgmr" 
        <samitolvanen@samitolvanen1.mtv.corp.google.com>
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a25:3744:: with SMTP id
 e65mr19951166yba.275.1600460085079; Fri, 18 Sep 2020 13:14:45 -0700 (PDT)
Date:   Fri, 18 Sep 2020 13:14:09 -0700
In-Reply-To: <20200918201436.2932360-1-samitolvanen@google.com>
Message-Id: <20200918201436.2932360-4-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200918201436.2932360-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH v3 03/30] x86/boot/compressed: Disable relocation relaxation
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, Arvind Sankar <nivedita@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Arvind Sankar <nivedita@alum.mit.edu>

The x86-64 psABI [0] specifies special relocation types
(R_X86_64_[REX_]GOTPCRELX) for indirection through the Global Offset
Table, semantically equivalent to R_X86_64_GOTPCREL, which the linker
can take advantage of for optimization (relaxation) at link time. This
is supported by LLD and binutils versions 2.26 onwards.

The compressed kernel is position-independent code, however, when using
LLD or binutils versions before 2.27, it must be linked without the -pie
option. In this case, the linker may optimize certain instructions into
a non-position-independent form, by converting foo@GOTPCREL(%rip) to $foo.

This potential issue has been present with LLD and binutils-2.26 for a
long time, but it has never manifested itself before now:
- LLD and binutils-2.26 only relax
	movq	foo@GOTPCREL(%rip), %reg
  to
	leaq	foo(%rip), %reg
  which is still position-independent, rather than
	mov	$foo, %reg
  which is permitted by the psABI when -pie is not enabled.
- gcc happens to only generate GOTPCREL relocations on mov instructions.
- clang does generate GOTPCREL relocations on non-mov instructions, but
  when building the compressed kernel, it uses its integrated assembler
  (due to the redefinition of KBUILD_CFLAGS dropping -no-integrated-as),
  which has so far defaulted to not generating the GOTPCRELX
  relocations.

Nick Desaulniers reports [1,2]:
  A recent change [3] to a default value of configuration variable
  (ENABLE_X86_RELAX_RELOCATIONS OFF -> ON) in LLVM now causes Clang's
  integrated assembler to emit R_X86_64_GOTPCRELX/R_X86_64_REX_GOTPCRELX
  relocations. LLD will relax instructions with these relocations based
  on whether the image is being linked as position independent or not.
  When not, then LLD will relax these instructions to use absolute
  addressing mode (R_RELAX_GOT_PC_NOPIC). This causes kernels built with
  Clang and linked with LLD to fail to boot.

Patch series [4] is a solution to allow the compressed kernel to be
linked with -pie unconditionally, but even if merged is unlikely to be
backported. As a simple solution that can be applied to stable as well,
prevent the assembler from generating the relaxed relocation types using
the -mrelax-relocations=no option. For ease of backporting, do this
unconditionally.

[0] https://gitlab.com/x86-psABIs/x86-64-ABI/-/blob/master/x86-64-ABI/linker-optimization.tex#L65
[1] https://lore.kernel.org/lkml/20200807194100.3570838-1-ndesaulniers@google.com/
[2] https://github.com/ClangBuiltLinux/linux/issues/1121
[3] https://reviews.llvm.org/rGc41a18cf61790fc898dcda1055c3efbf442c14c0
[4] https://lore.kernel.org/lkml/20200731202738.2577854-1-nivedita@alum.mit.edu/

Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Cc: stable@vger.kernel.org
---
 arch/x86/boot/compressed/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 3962f592633d..ff7894f39e0e 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -43,6 +43,8 @@ KBUILD_CFLAGS += -Wno-pointer-sign
 KBUILD_CFLAGS += $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
 KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
 KBUILD_CFLAGS += -D__DISABLE_EXPORTS
+# Disable relocation relaxation in case the link is not PIE.
+KBUILD_CFLAGS += $(call as-option,-Wa$(comma)-mrelax-relocations=no)
 
 KBUILD_AFLAGS  := $(KBUILD_CFLAGS) -D__ASSEMBLY__
 GCOV_PROFILE := n
-- 
2.28.0.681.g6f77f65b4e-goog

