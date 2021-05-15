Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B45438178C
	for <lists+linux-arch@lfdr.de>; Sat, 15 May 2021 12:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234783AbhEOKUN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 15 May 2021 06:20:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:47466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231222AbhEOKUN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 15 May 2021 06:20:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2FED6613ED;
        Sat, 15 May 2021 10:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621073940;
        bh=IpDqq3tGZovUUgcolTosWSkNN0zOGEGLOzuZ4zntl2M=;
        h=From:To:Cc:Subject:Date:From;
        b=mPn1OjVomxs7Tu/J0zC+FtbvaOsr6yQtXpoEj9sOi4LdXTcbto5qJ96l5zGrlpywO
         S9h/yllV/A7xG4K2EqluCEN+iU8aMWSWgvByBTJiljpi+sS3kiNXEDaRAWkE1e7SKM
         sxKRPsWhTYLl3eTQWbxjjYc5gYDjylTk+ySJih9CK9j6ccvN98Y6VtRlIgLO5VL8+8
         1QeSFO1LDLs8iguwhOAyXJFeodhvDZp8PXLkMitx7yPyKl0bGUmVhJjLazb7iS4leT
         cYyRbNnN88rAws6za+S3f2nl8YyuPZ0+1JIwQRAsVrcvD6dvU/aeGd/unrmM2Ofwwi
         8sCIbzxalbdtQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arch@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Vineet Gupta <vgupta@synopsys.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Brian Cain <bcain@codeaurora.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Sid Manning <sidneym@codeaurora.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-riscv@lists.infradead.org, linux-um@lists.infradead.org
Subject: [PATCH 0/6] [v2] asm-generic: strncpy_from_user/strnlen_user cleanup
Date:   Sat, 15 May 2021 12:17:57 +0200
Message-Id: <20210515101803.924427-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

As I've queued up some patches for asm-generic, I remembered an
older series that I created but never submitted.

These two functions appear to be unnecessarily different between
architectures, and the asm-generic version is a bit questionable,
even for NOMMU architectures.

Clean this up to just use the generic library version for anything
that uses the generic version today. I've expanded on the patch
descriptions a little, as suggested by Christoph Hellwig, but I
suspect a more detailed review would uncover additional problems
with the custom versions that are getting removed.

       Arnd

Arnd Bergmann (6):
  [v2] asm-generic/uaccess.h: remove __strncpy_from_user/__strnlen_user
  [v2] h8300: remove stale strncpy_from_user
  [v2] hexagon: use generic strncpy/strnlen from_user
  [v2] arc: use generic strncpy/strnlen from_user
  [v2] asm-generic: uaccess: remove inline
    strncpy_from_user/strnlen_user
  [v2] asm-generic: remove extra strn{cpy_from,len}_user declarations

 arch/arc/Kconfig                    |   2 +
 arch/arc/include/asm/uaccess.h      |  72 ----------------
 arch/arc/mm/extable.c               |  12 ---
 arch/h8300/Kconfig                  |   2 +
 arch/h8300/kernel/h8300_ksyms.c     |   2 -
 arch/h8300/lib/Makefile             |   2 +-
 arch/h8300/lib/strncpy.S            |  35 --------
 arch/hexagon/Kconfig                |   2 +
 arch/hexagon/include/asm/uaccess.h  |  31 -------
 arch/hexagon/kernel/hexagon_ksyms.c |   1 -
 arch/hexagon/mm/Makefile            |   2 +-
 arch/hexagon/mm/strnlen_user.S      | 126 ----------------------------
 arch/m68k/Kconfig                   |   4 +-
 arch/riscv/Kconfig                  |   4 +-
 arch/um/include/asm/uaccess.h       |   5 +-
 arch/um/kernel/skas/uaccess.c       |   5 +-
 include/asm-generic/uaccess.h       |  52 ++----------
 17 files changed, 25 insertions(+), 334 deletions(-)
 delete mode 100644 arch/h8300/lib/strncpy.S
 delete mode 100644 arch/hexagon/mm/strnlen_user.S

-- 
2.29.2

Cc: Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Brian Cain <bcain@codeaurora.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Sid Manning <sidneym@codeaurora.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: linux-snps-arc@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: uclinux-h8-devel@lists.sourceforge.jp
Cc: linux-hexagon@vger.kernel.org
Cc: linux-m68k@lists.linux-m68k.org
Cc: linux-riscv@lists.infradead.org
Cc: linux-um@lists.infradead.org
Cc: linux-arch@vger.kernel.org

