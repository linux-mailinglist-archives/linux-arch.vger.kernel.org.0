Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 762003792BA
	for <lists+linux-arch@lfdr.de>; Mon, 10 May 2021 17:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233174AbhEJPbq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 May 2021 11:31:46 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:55965 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234203AbhEJPbG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 May 2021 11:31:06 -0400
Received: from fsav303.sakura.ne.jp (fsav303.sakura.ne.jp [153.120.85.134])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 14AFRtfE007232;
        Tue, 11 May 2021 00:27:56 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav303.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav303.sakura.ne.jp);
 Tue, 11 May 2021 00:27:55 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav303.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 14AFRtnu007228
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 11 May 2021 00:27:55 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: [PATCH 11/12] tools: sync lib/find_bit implementation
To:     Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linux-m68k@lists.linux-m68k.org, linux-arch@vger.kernel.org,
        linux-sh@vger.kernel.org, Alexey Klimov <aklimov@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, David Sterba <dsterba@suse.com>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jianpeng Ma <jianpeng.ma@intel.com>,
        Joe Perches <joe@perches.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Rich Felker <dalias@libc.org>,
        Stefano Brivio <sbrivio@redhat.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>
References: <20210401003153.97325-1-yury.norov@gmail.com>
 <20210401003153.97325-12-yury.norov@gmail.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <1ac7bbc2-45d9-26ed-0b33-bf382b8d858b@I-love.SAKURA.ne.jp>
Date:   Tue, 11 May 2021 00:27:51 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210401003153.97325-12-yury.norov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Commit eaae7841ba83bb42 ("tools: sync lib/find_bit implementation") broke
build of 5.13-rc1 using gcc (GCC) 8.3.1 20190311 (Red Hat 8.3.1-3).

  DESCEND  objtool
  CC       /usr/src/linux/tools/objtool/exec-cmd.o
  CC       /usr/src/linux/tools/objtool/help.o
  CC       /usr/src/linux/tools/objtool/pager.o
  CC       /usr/src/linux/tools/objtool/parse-options.o
  CC       /usr/src/linux/tools/objtool/run-command.o
  CC       /usr/src/linux/tools/objtool/sigchain.o
  CC       /usr/src/linux/tools/objtool/subcmd-config.o
  LD       /usr/src/linux/tools/objtool/libsubcmd-in.o
  AR       /usr/src/linux/tools/objtool/libsubcmd.a
  CC       /usr/src/linux/tools/objtool/arch/x86/special.o
In file included from /usr/src/linux/tools/include/linux/kernel.h:8:0,
                 from /usr/src/linux/tools/include/linux/list.h:7,
                 from /usr/src/linux/tools/objtool/include/objtool/arch.h:10,
                 from /usr/src/linux/tools/objtool/include/objtool/check.h:11,
                 from /usr/src/linux/tools/objtool/include/objtool/special.h:10,
                 from arch/x86/special.c:4:
/usr/src/linux/tools/include/asm-generic/bitops/find.h: In function 'find_next_bit':
/usr/src/linux/tools/include/linux/bits.h:24:21: error: first argument to '__builtin_choose_expr' not a constant
  (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
                     ^
/usr/src/linux/tools/include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
 #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
                                                              ^
/usr/src/linux/tools/include/linux/bits.h:38:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
  (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
   ^
/usr/src/linux/tools/include/asm-generic/bitops/find.h:32:17: note: in expansion of macro 'GENMASK'
   val = *addr & GENMASK(size - 1, offset);
                 ^
/usr/src/linux/tools/include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
 #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
                                                   ^
/usr/src/linux/tools/include/linux/bits.h:24:3: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
  (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
   ^
/usr/src/linux/tools/include/linux/bits.h:38:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
  (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
   ^
/usr/src/linux/tools/include/asm-generic/bitops/find.h:32:17: note: in expansion of macro 'GENMASK'
   val = *addr & GENMASK(size - 1, offset);
                 ^
/usr/src/linux/tools/include/asm-generic/bitops/find.h: In function 'find_next_and_bit':
/usr/src/linux/tools/include/linux/bits.h:24:21: error: first argument to '__builtin_choose_expr' not a constant
  (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
                     ^
/usr/src/linux/tools/include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
 #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
                                                              ^
/usr/src/linux/tools/include/linux/bits.h:38:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
  (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
   ^
/usr/src/linux/tools/include/asm-generic/bitops/find.h:62:27: note: in expansion of macro 'GENMASK'
   val = *addr1 & *addr2 & GENMASK(size - 1, offset);
                           ^
/usr/src/linux/tools/include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
 #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
                                                   ^
/usr/src/linux/tools/include/linux/bits.h:24:3: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
  (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
   ^
/usr/src/linux/tools/include/linux/bits.h:38:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
  (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
   ^
/usr/src/linux/tools/include/asm-generic/bitops/find.h:62:27: note: in expansion of macro 'GENMASK'
   val = *addr1 & *addr2 & GENMASK(size - 1, offset);
                           ^
/usr/src/linux/tools/include/asm-generic/bitops/find.h: In function 'find_next_zero_bit':
/usr/src/linux/tools/include/linux/bits.h:24:21: error: first argument to '__builtin_choose_expr' not a constant
  (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
                     ^
/usr/src/linux/tools/include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
 #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
                                                              ^
/usr/src/linux/tools/include/linux/bits.h:38:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
  (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
   ^
/usr/src/linux/tools/include/asm-generic/bitops/find.h:90:18: note: in expansion of macro 'GENMASK'
   val = *addr | ~GENMASK(size - 1, offset);
                  ^
/usr/src/linux/tools/include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
 #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
                                                   ^
/usr/src/linux/tools/include/linux/bits.h:24:3: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
  (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
   ^
/usr/src/linux/tools/include/linux/bits.h:38:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
  (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
   ^
/usr/src/linux/tools/include/asm-generic/bitops/find.h:90:18: note: in expansion of macro 'GENMASK'
   val = *addr | ~GENMASK(size - 1, offset);
                  ^
make[5]: *** [/usr/src/linux/tools/objtool/arch/x86/special.o] Error 1
make[4]: *** [arch/x86] Error 2
make[3]: *** [/usr/src/linux/tools/objtool/objtool-in.o] Error 2
make[2]: *** [objtool] Error 2
make[1]: *** [tools/objtool] Error 2
make: *** [__sub-make] Error 2



Applying below diff seems to solve the build failure.
Do we need to use BUILD_BUG_ON_ZERO() here?

diff --git a/tools/include/linux/bits.h b/tools/include/linux/bits.h
index 7f475d59a097..0aba9294f29d 100644
--- a/tools/include/linux/bits.h
+++ b/tools/include/linux/bits.h
@@ -21,8 +21,7 @@
 #if !defined(__ASSEMBLY__)
 #include <linux/build_bug.h>
 #define GENMASK_INPUT_CHECK(h, l) \
-	(BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
-		__builtin_constant_p((l) > (h)), (l) > (h), 0)))
+	({ BUILD_BUG_ON(__builtin_constant_p((l) > (h)) && ((l) > (h))); 0; })
 #else
 /*
  * BUILD_BUG_ON_ZERO is not available in h files included from asm files,



Also, why the fast path of find_*_bit() functions does not check
__builtin_constant_p(offset) as well as small_const_nbits(size), for the fast
path fails to catch BUILD_BUG_ON_ZERO() when offset argument is not a constant.

