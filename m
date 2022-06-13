Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8025F547D6D
	for <lists+linux-arch@lfdr.de>; Mon, 13 Jun 2022 03:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbiFMBbR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 12 Jun 2022 21:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbiFMBbR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 12 Jun 2022 21:31:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48E61C13C;
        Sun, 12 Jun 2022 18:31:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 61A16B80D22;
        Mon, 13 Jun 2022 01:31:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E3C4C34115;
        Mon, 13 Jun 2022 01:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655083873;
        bh=RVAyZuqlwM/hDCOHKUQEWUEw9mlKJE2gEK5yaIsZ4to=;
        h=From:To:Cc:Subject:Date:From;
        b=oHdlufOHxW6XFaMV+oOWi8IucAsP/2KBIE4/fnDJ4fRoVSM6PUMW/Xkdu8sUZUhMo
         I7gYwme3y+XPuoSGxp65UkpNt1yuR7v/mdBPVWBy5TZiqyFcutWKvSS/l/T5vyRVdB
         48FYnZvyfimqbWKMgQwckbae+NwbP3rxIkcDBX0ArXbtyCBUeymYa+YgXKkxD5e0dw
         2MDJiDLn9TkZgh5zvFRbGs61JqmQ5zcyF49vYljd0xrvgihhn8DRYgDyN9V4uFfV21
         /OLc3yGJvY2vmE/DNFUFW9k1Gza7wrPkg6dIoI9qfHThWZ/X0rTWeaObP+Xi17zAy2
         79FEsvSEiYQeg==
From:   guoren@kernel.org
To:     palmer@rivosinc.com, arnd@arndb.de, linux@roeck-us.net,
        palmer@dabbelt.com, heiko@sntech.de
Cc:     linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH] uapi: Fixup strace compile error
Date:   Sun, 12 Jun 2022 21:30:51 -0400
Message-Id: <20220613013051.1741434-1-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

There is no CONFIG_64BIT in userspace, we shouldn't limit it with
__BITS_PER_LONG == 32 to break the compatibility. Just export F_*64
definitions to userspace permanently.

gcc-11 -DHAVE_CONFIG_H   -I./linux/x86_64 -I../../../src/linux/x86_64
-I./linux/generic -I../../../src/linux/generic -I. -I../../../src
-DIN_STRACE=1      -isystem /opt/kernel/include -Wall -Wextra
-Wno-missing-field-initializers -Wno-unused-parameter -Wdate-time
-Wformat-security -Wimplicit-fallthrough=5 -Winit-self -Wlogical-op
-Wmissing-prototypes -Wnested-externs -Wold-style-definition
-Wtrampolines -Wundef -Wwrite-strings -Werror   -g -O2 -c -o
libstrace_a-fetch_bpf_fprog.o `test -f 'fetch_bpf_fprog.c' || echo
'../../../src/'`fetch_bpf_fprog.c
In file included from ../../../src/defs.h:404,
                 from ../../../src/fcntl.c:12:
../../../src/xlat/fcntlcmds.h:54:7: error: ‘F_GETLK64’ undeclared here
(not in a function); did you mean ‘F_GETLK’?
   54 |  XLAT(F_GETLK64),
      |       ^~~~~~~~~
../../../src/xlat.h:64:54: note: in definition of macro ‘XLAT’
   64 | # define XLAT(val)                      { (unsigned)(val), #val
      }
      |                                                      ^~~
../../../src/xlat/fcntlcmds.h:57:7: error: ‘F_SETLK64’ undeclared here
(not in a function); did you mean ‘F_SETLK’?
   57 |  XLAT(F_SETLK64),
      |       ^~~~~~~~~
../../../src/xlat.h:64:54: note: in definition of macro ‘XLAT’
   64 | # define XLAT(val)                      { (unsigned)(val), #val
      }
      |                                                      ^~~
../../../src/xlat/fcntlcmds.h:60:7: error: ‘F_SETLKW64’ undeclared here
(not in a function); did you mean ‘F_SETLKW’?
   60 |  XLAT(F_SETLKW64),
      |       ^~~~~~~~~~
../../../src/xlat.h:64:54: note: in definition of macro ‘XLAT’
   64 | # define XLAT(val)                      { (unsigned)(val), #val
      }
      |                                                      ^~~
make[4]: *** [Makefile:5017: libstrace_a-fcntl.o] Error 1

comment by Eugene:
Actually, it's quite the opposite: "ifndef" usage made it vailable at all
times to the userspace, and this change has actually broken building strace
with the latest kernel headers[1][2].  There could be some debate whether
having these F_*64 definitions exposed to the user space 64-bit
applications, but it seems that were no harm (as they were exposed already
for quite some time), and they are useful at least for strace for compat
application tracing purposes.

Fixes: 306f7cc1e9061 "uapi: always define F_GETLK64/F_SETLK64/F_SETLKW64 in fcntl.h"
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Reported-by: Eugene Syromiatnikov <esyr@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Palmer Dabbelt <palmer@rivosinc.com>
---
 include/uapi/asm-generic/fcntl.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
index f13d37b60775..cd6bd65ec25d 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -116,13 +116,11 @@
 #define F_GETSIG	11	/* for sockets. */
 #endif
 
-#if __BITS_PER_LONG == 32 || defined(__KERNEL__)
 #ifndef F_GETLK64
 #define F_GETLK64	12	/*  using 'struct flock64' */
 #define F_SETLK64	13
 #define F_SETLKW64	14
 #endif
-#endif /* __BITS_PER_LONG == 32 || defined(__KERNEL__) */
 
 #ifndef F_SETOWN_EX
 #define F_SETOWN_EX	15
-- 
2.36.1

