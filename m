Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C572F1FD6AD
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jun 2020 23:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgFQVGZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 Jun 2020 17:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbgFQVGY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 Jun 2020 17:06:24 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829B7C061755
        for <linux-arch@vger.kernel.org>; Wed, 17 Jun 2020 14:06:24 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id e82so4039598ybh.12
        for <linux-arch@vger.kernel.org>; Wed, 17 Jun 2020 14:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=d0+Tzz9YePJeli6i74FfEPDYMLFJV/dTb97VxgPARRM=;
        b=s65S27c/KhuLOWAdWfLs8FLqZHfP5cSau7W+PswhE2Jr9spEw3hA0lbGxcJUfsJDgL
         mAg1ZrtF5oypvB0HM5sogq1N0s+ug/nOQ7/yvOxlCJKtbxguewHBg5KloSP4CbqEmOo/
         CCfvgxIrTsbIgLi7app8Hb6phNzgxKWbo4yQaEraDSljNMKaz1NJi3vx1Inw0SLHgTkj
         Ydvhkhn5cNvUjUH0z+DbN8O+kgn6bq/RF3WHmr0EpT4CuGQ0tZEY8j6N5T+4VDqMnsQ/
         qIPbR2yOvnBShQupKjFVRYYp3QPIG7dYj6mR2rfqMkjJqxnBtGoebDFB75f69nfKfNnR
         NHPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=d0+Tzz9YePJeli6i74FfEPDYMLFJV/dTb97VxgPARRM=;
        b=DA3GLj8j787E+60xZ+CJwWdQg51d5GaEjxXpgksAoabB1kVCXnncxWksrmksuD7Vgz
         coihNq7bY03zB/tGq/HNxeC9gkMXBbCqZMTnUQ21SbzYfHQYBHJAacrSm6m8aDFr2cjN
         SlREebEiRsBI81l9MQHSNtIJQAbeArDLJv8HOVj9T7i/N7SSiLYzmCXsa5mpuxy1fQBI
         nl004Vm5qxXr9W4iE7Vx5jPLhOSHNmOGR7D0+EBVdmHsbZia2ebA2lA5bp6f4HQi9DMx
         naUu/oBTEHyZIf1rrV5JiHjRQ4B56+xbAmg4z/lAsKK8wBozKiUAh4ldz3AwFuXwVnyK
         lulg==
X-Gm-Message-State: AOAM533YRhmkhO1WYVtndaeSMQXa1Ugq41KOEsMKYL1aL+6X/pa0Q0S9
        denibHTG/RHo2YQ7QuJUlZMTM2mLcIPhjf9Szfk=
X-Google-Smtp-Source: ABdhPJz3iUzXFbAwSyuVvZKrE5dzrRwvPcbwlwoM2ZlgX9XqOxcOVvPsjbnvuxuVNelpg9On3Hff/YteVPpHN7/XyRA=
X-Received: by 2002:a25:7086:: with SMTP id l128mr1423806ybc.34.1592427983669;
 Wed, 17 Jun 2020 14:06:23 -0700 (PDT)
Date:   Wed, 17 Jun 2020 14:06:13 -0700
Message-Id: <20200617210613.95432-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
Subject: [PATCH] vmlinux.lds: consider .text.{hot|unlikely}.* part of .text too
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     clang-built-linux@googlegroups.com,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        stable@vger.kernel.org, Jian Cai <jiancai@google.com>,
        Luis Lozano <llozano@google.com>,
        "=?UTF-8?q?F=C4=81ng-ru=C3=AC=20S=C3=B2ng?=" <maskray@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

ld.bfd's internal linker script considers .text.hot AND .text.hot.* to
be part of .text, as well as .text.unlikely and .text.unlikely.*. ld.lld
will produce .text.hot.*/.text.unlikely.* sections. Make sure to group
these together.  Otherwise these orphan sections may be placed outside
of the the _stext/_etext boundaries.

Cc: stable@vger.kernel.org
Link: https://sourceware.org/git/?p=3Dbinutils-gdb.git;a=3Dcommitdiff;h=3Da=
dd44f8d5c5c05e08b11e033127a744d61c26aee
Link: https://sourceware.org/git/?p=3Dbinutils-gdb.git;a=3Dcommitdiff;h=3D1=
de778ed23ce7492c523d5850c6c6dbb34152655
Link: https://reviews.llvm.org/D79600
Reported-by: Jian Cai <jiancai@google.com>
Debugged-by: Luis Lozano <llozano@google.com>
Suggested-by: F=C4=81ng-ru=C3=AC S=C3=B2ng <maskray@google.com>
Tested-by: Luis Lozano <llozano@google.com>
Tested-by: Manoj Gupta <manojgupta@google.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 include/asm-generic/vmlinux.lds.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinu=
x.lds.h
index d7c7c7f36c4a..fe5aaef169e3 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -560,7 +560,9 @@
  */
 #define TEXT_TEXT							\
 		ALIGN_FUNCTION();					\
-		*(.text.hot TEXT_MAIN .text.fixup .text.unlikely)	\
+		*(.text.hot .text.hot.*)				\
+		*(TEXT_MAIN .text.fixup)				\
+		*(.text.unlikely .text.unlikely.*)			\
 		NOINSTR_TEXT						\
 		*(.text..refcount)					\
 		*(.ref.text)						\
--=20
2.27.0.290.gba653c62da-goog

