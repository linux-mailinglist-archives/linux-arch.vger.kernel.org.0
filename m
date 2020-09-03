Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C64E25CB4C
	for <lists+linux-arch@lfdr.de>; Thu,  3 Sep 2020 22:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbgICUka (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Sep 2020 16:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728678AbgICUbF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Sep 2020 16:31:05 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF7DC061263
        for <linux-arch@vger.kernel.org>; Thu,  3 Sep 2020 13:30:57 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id y187so2296693qka.10
        for <linux-arch@vger.kernel.org>; Thu, 03 Sep 2020 13:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=mDVvkNnwHRt+Li8nefuHvmgwU3VCsthhxmclA+Biet0=;
        b=BAqToBhePk+irZIVVLAwecMp1XW9+Ks/f/sHbDKoGAGhsn6UE+3DQRUDeqOb8say/o
         QxpBeEZ6aAX0zEfibyHBFmhzl0Vw+o0mHntVCknw3JFLb1KRs5PinJ6tHxAOk5MN5EYA
         AfgwLGhevAbhgMH2td9x/PyO+G3DTP7s1GxaKtrd39cb0JzoBHskqiAq/LJEw/gMn8iA
         XT4V4BL0iYhatzNnu1bXuTQZJGInDJpEfjNk2sRcKcORI1v3DBYhfh8RDI2LHTVrDtsI
         V29No/TKC195kYLq9pmO7w16CLGuBlaDY8z5c/lcwnflHFClTnlapgui3DYxttVqDUEE
         tSLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mDVvkNnwHRt+Li8nefuHvmgwU3VCsthhxmclA+Biet0=;
        b=A3AlubSspunTuYrXI3WVGs+Exe2ZXLjBgVrpYoSChapYAIm/Zkmg7cZNG/bdM7jujT
         hHocQLBXY+HnVwE5JiFT7jY3drgCURYETe8B82niSMgzlQ296v9E3IvT0heOkVtRQpdp
         ohgihi8cowkudgVw6T5BqdG/pc8EaEPGGBL29JC10HsdmAzzjxGPDcmQiu1oovkI/4FG
         4dfMaBWGDqAc7Ftd5mBPXK84wdeee0NPgOKHjaVPk5dSaM3itdrowopxXkCsiV5NtPuX
         SvhG9/dizkhsHLvj5UaItm4ggmPYo/468Xle1KqGF/41tEcA6rK3qR414OidHj/t/FEm
         kLnQ==
X-Gm-Message-State: AOAM533UVt8ZkJz//Aqne6zfMXXhd+J/0Pou0V1xcDLjistocG2jtYEM
        jg6aAay7rOm59KKtG3Rhq+i7gEyTWIGvoAF19Ds=
X-Google-Smtp-Source: ABdhPJyUnW2qSfmEzLjPskwcMhWUurVS5skiaBz/vWVhXl7N7pyUdqZoSu6Ssyc74PFkWqrXo2ggCEF9Y0h+Jfi/JHo=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
 (user=samitolvanen job=sendgmr) by 2002:a05:6214:292:: with SMTP id
 l18mr3616010qvv.3.1599165056576; Thu, 03 Sep 2020 13:30:56 -0700 (PDT)
Date:   Thu,  3 Sep 2020 13:30:26 -0700
In-Reply-To: <20200903203053.3411268-1-samitolvanen@google.com>
Message-Id: <20200903203053.3411268-2-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com> <20200903203053.3411268-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH v2 01/28] x86/boot/compressed: Disable relocation relaxation
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
Sender: linux-arch-owner@vger.kernel.org
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
2.28.0.402.g5ffc5be6b7-goog

