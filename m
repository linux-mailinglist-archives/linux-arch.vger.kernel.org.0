Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91D8931C7A5
	for <lists+linux-arch@lfdr.de>; Tue, 16 Feb 2021 09:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbhBPI41 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Feb 2021 03:56:27 -0500
Received: from mail-40136.protonmail.ch ([185.70.40.136]:16247 "EHLO
        mail-40136.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbhBPI41 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Feb 2021 03:56:27 -0500
Date:   Tue, 16 Feb 2021 08:55:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=protonmail;
        t=1613465743; bh=Z1B3dJxurktF44XrKPp/L6aM/W1WYsFcVWu3eznTvaw=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=XoH45ZIlE9KmzLuba90pWudggzbMSyC/rqULk0uCPZXV91Qj4Nkx45usHN1gE3m9e
         XnUyQp2RXSVRhiPrrdzDIzTGRQzeof3nTw2deqUyZ2A3mc9H9RcnITfzsGy+3AawHh
         RwKxVATRQsTcOWC25zFl+UdlexCfH8zgHmjhPpxPa7stDs6FcNjsmkhKul5s2XBjvg
         /7VvXCn1U9gQtpKtkgJxbaUIwOtj8FoPSKQHm3yUlF5Zwsd4+VY0K2IG702UYztvKW
         PrNsDvZbU4BHCabfjSB43UlkMrnc3ihEC+Og4ignXhSnP+E35f0y87AY7NE3wAWgRc
         icxXlzsRVboHw==
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
From:   Alexander Lobakin <alobakin@pm.me>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Pei Huang <huangpei@loongson.cn>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Alexander Lobakin <alobakin@pm.me>,
        Fangrui Song <maskray@google.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Corey Minyard <cminyard@mvista.com>,
        kernel test robot <lkp@intel.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, clang-built-linux@googlegroups.com
Reply-To: Alexander Lobakin <alobakin@pm.me>
Subject: [PATCH mips-next] vmlinux.lds.h: catch more UBSAN symbols into .data
Message-ID: <20210216085442.2967-1-alobakin@pm.me>
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

LKP triggered lots of LD orphan warnings [0]:

mipsel-linux-ld: warning: orphan section `.data.$Lubsan_data299' from
`init/do_mounts_rd.o' being placed in section `.data.$Lubsan_data299'
mipsel-linux-ld: warning: orphan section `.data.$Lubsan_data183' from
`init/do_mounts_rd.o' being placed in section `.data.$Lubsan_data183'
mipsel-linux-ld: warning: orphan section `.data.$Lubsan_type3' from
`init/do_mounts_rd.o' being placed in section `.data.$Lubsan_type3'
mipsel-linux-ld: warning: orphan section `.data.$Lubsan_type2' from
`init/do_mounts_rd.o' being placed in section `.data.$Lubsan_type2'
mipsel-linux-ld: warning: orphan section `.data.$Lubsan_type0' from
`init/do_mounts_rd.o' being placed in section `.data.$Lubsan_type0'

[...]

Seems like "unnamed data" isn't the only type of symbols that UBSAN
instrumentation can emit.
Catch these into .data with the wildcard as well.

[0] https://lore.kernel.org/linux-mm/202102160741.k57GCNSR-lkp@intel.com

Fixes: f41b233de0ae ("vmlinux.lds.h: catch UBSAN's "unnamed data" into data=
")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Alexander Lobakin <alobakin@pm.me>
---
 include/asm-generic/vmlinux.lds.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinu=
x.lds.h
index cc659e77fcb0..83537e5ee78f 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -95,7 +95,7 @@
  */
 #ifdef CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
 #define TEXT_MAIN .text .text.[0-9a-zA-Z_]*
-#define DATA_MAIN .data .data.[0-9a-zA-Z_]* .data..L* .data..compoundliter=
al* .data.$__unnamed_*
+#define DATA_MAIN .data .data.[0-9a-zA-Z_]* .data..L* .data..compoundliter=
al* .data.$__unnamed_* .data.$Lubsan_*
 #define SDATA_MAIN .sdata .sdata.[0-9a-zA-Z_]*
 #define RODATA_MAIN .rodata .rodata.[0-9a-zA-Z_]* .rodata..L*
 #define BSS_MAIN .bss .bss.[0-9a-zA-Z_]* .bss..compoundliteral*
--=20
2.30.1


