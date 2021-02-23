Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5422132298E
	for <lists+linux-arch@lfdr.de>; Tue, 23 Feb 2021 12:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbhBWLhR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 Feb 2021 06:37:17 -0500
Received: from mail-40133.protonmail.ch ([185.70.40.133]:33581 "EHLO
        mail-40133.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbhBWLhP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Feb 2021 06:37:15 -0500
Date:   Tue, 23 Feb 2021 11:36:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=protonmail;
        t=1614080193; bh=LDXrE7sDxyCpuz5Jas1c16xbqsT/JI3J42ibOHIRvzo=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=Ji7fa0uVySwgDiZq2C6IUPQ4Vra+iq5A5BxvtsuyTYMVKGO1iu/VoaLYE7NSfHXGq
         0KkdXBNXPkR4fy6Hzip7m4ieCLGqRRt2eewCtVBqhZbRLEa3owAJPfvN9emp3pEyfX
         n+OtksuWJbRuwhPPpd/d9rrxdi2+I14dOhoY/k5t1Y/sPiXbGUEbSZEGhKgh1zkV4F
         pmIScTlXKqMy3Mzygm7a7Ax4OTynklBEIJkUs0mMSy+l6ktZBOOzW8YEHd0l9VpUK/
         bYe5F5akM9xVRbIW8h19pk6pGsJu/6LuhvnvdosfICZL6M5rwkzWjtE1Za+bUA96Ld
         +rA0Eno7YCEwA==
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
From:   Alexander Lobakin <alobakin@pm.me>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Pei Huang <huangpei@loongson.cn>,
        Kees Cook <keescook@chromium.org>,
        Alexander Lobakin <alobakin@pm.me>,
        Fangrui Song <maskray@google.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Corey Minyard <cminyard@mvista.com>,
        kernel test robot <lkp@intel.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Reply-To: Alexander Lobakin <alobakin@pm.me>
Subject: [PATCH mips-fixes] vmlinux.lds.h: catch even more instrumentation symbols into .data
Message-ID: <20210223113600.7009-1-alobakin@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

LKP caught another bunch of orphaned instrumentation symbols [0]:

mipsel-linux-ld: warning: orphan section `.data.$LPBX1' from
`init/main.o' being placed in section `.data.$LPBX1'
mipsel-linux-ld: warning: orphan section `.data.$LPBX0' from
`init/main.o' being placed in section `.data.$LPBX0'
mipsel-linux-ld: warning: orphan section `.data.$LPBX1' from
`init/do_mounts.o' being placed in section `.data.$LPBX1'
mipsel-linux-ld: warning: orphan section `.data.$LPBX0' from
`init/do_mounts.o' being placed in section `.data.$LPBX0'
mipsel-linux-ld: warning: orphan section `.data.$LPBX1' from
`init/do_mounts_initrd.o' being placed in section `.data.$LPBX1'
mipsel-linux-ld: warning: orphan section `.data.$LPBX0' from
`init/do_mounts_initrd.o' being placed in section `.data.$LPBX0'
mipsel-linux-ld: warning: orphan section `.data.$LPBX1' from
`init/initramfs.o' being placed in section `.data.$LPBX1'
mipsel-linux-ld: warning: orphan section `.data.$LPBX0' from
`init/initramfs.o' being placed in section `.data.$LPBX0'
mipsel-linux-ld: warning: orphan section `.data.$LPBX1' from
`init/calibrate.o' being placed in section `.data.$LPBX1'
mipsel-linux-ld: warning: orphan section `.data.$LPBX0' from
`init/calibrate.o' being placed in section `.data.$LPBX0'

[...]

Soften the wildcard to .data.$L* to grab these ones into .data too.

[0] https://lore.kernel.org/lkml/202102231519.lWPLPveV-lkp@intel.com

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Alexander Lobakin <alobakin@pm.me>
---
 include/asm-generic/vmlinux.lds.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinu=
x.lds.h
index 01a3fd6a64d2..c887ac36c1b4 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -95,7 +95,7 @@
  */
 #ifdef CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
 #define TEXT_MAIN .text .text.[0-9a-zA-Z_]*
-#define DATA_MAIN .data .data.[0-9a-zA-Z_]* .data..L* .data..compoundliter=
al* .data.$__unnamed_* .data.$Lubsan_*
+#define DATA_MAIN .data .data.[0-9a-zA-Z_]* .data..L* .data..compoundliter=
al* .data.$__unnamed_* .data.$L*
 #define SDATA_MAIN .sdata .sdata.[0-9a-zA-Z_]*
 #define RODATA_MAIN .rodata .rodata.[0-9a-zA-Z_]* .rodata..L*
 #define BSS_MAIN .bss .bss.[0-9a-zA-Z_]* .bss..compoundliteral*
--
2.30.1


