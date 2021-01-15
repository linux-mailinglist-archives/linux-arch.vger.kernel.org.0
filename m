Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD6F2F7BDC
	for <lists+linux-arch@lfdr.de>; Fri, 15 Jan 2021 14:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387410AbhAONGo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Jan 2021 08:06:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:36468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732571AbhAOMbU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 15 Jan 2021 07:31:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1A3DF23359;
        Fri, 15 Jan 2021 12:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610713852;
        bh=zMvVyCvwo/EX6UZN4/MyQq2opcAvoCJ188svsQtvNys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2eCUBtZXJNMp/aCG/8rpzNtKxDzkg+uKuxN6qbBr13WH+bsKqlFDEPNVG6hvlbU/9
         MDGHvO5at0RTxj+VRAS40SxsDbiy5hYgP1gGUujOR8KYck9GcUrSr39SbtDzJMURPh
         rmK61ngnLVri5Xn29KtX2ASk0ulE6/yCOKvKnilE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jian Cai <jiancai@google.com>,
        =?UTF-8?q?F=C4=81ng-ru=C3=AC=20S=C3=B2ng?= <maskray@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Luis Lozano <llozano@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        linux-arch@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 4.9 10/25] vmlinux.lds.h: Add PGO and AutoFDO input sections
Date:   Fri, 15 Jan 2021 13:27:41 +0100
Message-Id: <20210115121957.192486980@linuxfoundation.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210115121956.679956165@linuxfoundation.org>
References: <20210115121956.679956165@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Nick Desaulniers <ndesaulniers@google.com>

commit eff8728fe69880d3f7983bec3fb6cea4c306261f upstream.

Basically, consider .text.{hot|unlikely|unknown}.* part of .text, too.

When compiling with profiling information (collected via PGO
instrumentations or AutoFDO sampling), Clang will separate code into
.text.hot, .text.unlikely, or .text.unknown sections based on profiling
information. After D79600 (clang-11), these sections will have a
trailing `.` suffix, ie.  .text.hot., .text.unlikely., .text.unknown..

When using -ffunction-sections together with profiling infomation,
either explicitly (FGKASLR) or implicitly (LTO), code may be placed in
sections following the convention:
.text.hot.<foo>, .text.unlikely.<bar>, .text.unknown.<baz>
where <foo>, <bar>, and <baz> are functions.  (This produces one section
per function; we generally try to merge these all back via linker script
so that we don't have 50k sections).

For the above cases, we need to teach our linker scripts that such
sections might exist and that we'd explicitly like them grouped
together, otherwise we can wind up with code outside of the
_stext/_etext boundaries that might not be mapped properly for some
architectures, resulting in boot failures.

If the linker script is not told about possible input sections, then
where the section is placed as output is a heuristic-laiden mess that's
non-portable between linkers (ie. BFD and LLD), and has resulted in many
hard to debug bugs.  Kees Cook is working on cleaning this up by adding
--orphan-handling=warn linker flag used in ARCH=powerpc to additional
architectures. In the case of linker scripts, borrowing from the Zen of
Python: explicit is better than implicit.

Also, ld.bfd's internal linker script considers .text.hot AND
.text.hot.* to be part of .text, as well as .text.unlikely and
.text.unlikely.*. I didn't see support for .text.unknown.*, and didn't
see Clang producing such code in our kernel builds, but I see code in
LLVM that can produce such section names if profiling information is
missing. That may point to a larger issue with generating or collecting
profiles, but I would much rather be safe and explicit than have to
debug yet another issue related to orphan section placement.

Reported-by: Jian Cai <jiancai@google.com>
Suggested-by: Fāng-ruì Sòng <maskray@google.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Luis Lozano <llozano@google.com>
Tested-by: Manoj Gupta <manojgupta@google.com>
Acked-by: Kees Cook <keescook@chromium.org>
Cc: linux-arch@vger.kernel.org
Cc: stable@vger.kernel.org
Link: https://sourceware.org/git/?p=binutils-gdb.git;a=commitdiff;h=add44f8d5c5c05e08b11e033127a744d61c26aee
Link: https://sourceware.org/git/?p=binutils-gdb.git;a=commitdiff;h=1de778ed23ce7492c523d5850c6c6dbb34152655
Link: https://reviews.llvm.org/D79600
Link: https://bugs.chromium.org/p/chromium/issues/detail?id=1084760
Link: https://lore.kernel.org/r/20200821194310.3089815-7-keescook@chromium.org

Debugged-by: Luis Lozano <llozano@google.com>
[nc: Fix small conflict around lack of NOINSTR_TEXT and .text..refcount]
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/asm-generic/vmlinux.lds.h |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -460,7 +460,10 @@
  */
 #define TEXT_TEXT							\
 		ALIGN_FUNCTION();					\
-		*(.text.hot TEXT_MAIN .text.fixup .text.unlikely)	\
+		*(.text.hot .text.hot.*)				\
+		*(TEXT_MAIN .text.fixup)				\
+		*(.text.unlikely .text.unlikely.*)			\
+		*(.text.unknown .text.unknown.*)			\
 		*(.ref.text)						\
 	MEM_KEEP(init.text)						\
 	MEM_KEEP(exit.text)						\


