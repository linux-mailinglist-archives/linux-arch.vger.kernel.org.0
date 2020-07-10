Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B937D21B73C
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jul 2020 15:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgGJN5O (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Jul 2020 09:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgGJN5N (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Jul 2020 09:57:13 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAA5C08C5CE;
        Fri, 10 Jul 2020 06:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=B7pw9VB6Nltmz3Y300r/gUvA4/r7iQ5LJ7MRpv3euRQ=; b=oTblXaxxdMYgqzyWl/61AZfUDq
        Em+mmsEq18XABkt4HcXcqWCojruqtuYuxz6rz3NBC/ziJ4LGO/7YPle2SpO7EegE2OahG0RJozJDp
        cN2rl1cfIKXl8Mqrz0XeFQSpuKiMgg7sEZHL+zNVeV3nEdwB1msbLjIJefAgheb8Mz2Is7u+e8Xmh
        SVvKocawwCr6ZzS+T1LonpbkoIkdKnLTdtQxjaPg2tM0YXE99YPTrPxXryLHRWA1U3HO4lzRARAzo
        dLxfdpyGiAQP9HpENHCTYu0qkAeSfG2JOl+ysNpFHI5zuJ3oCZeObDLXAQY7MsDBbAST7AwT31I4p
        YvvW2EMg==;
Received: from [2001:4bb8:188:5f50:c70:4a89:bc61:2] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jttWV-0004gQ-6D; Fri, 10 Jul 2020 13:57:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: clean up address limit helpers
Date:   Fri, 10 Jul 2020 15:57:00 +0200
Message-Id: <20200710135706.537715-1-hch@lst.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi all,

in preparation for eventually phasing out direct use of set_fs(), this
series removes the segment_eq() arch helper that is only used to
implement or duplicate the uaccess_kernel() API, and then adds
descriptive helpers to force the kernel address limit.

Diffstat:
 arch/alpha/include/asm/uaccess.h      |    2 +-
 arch/arc/include/asm/segment.h        |    3 +--
 arch/arm/include/asm/uaccess.h        |    4 ++--
 arch/arm64/include/asm/uaccess.h      |    2 +-
 arch/arm64/kernel/sdei.c              |    2 +-
 arch/csky/include/asm/segment.h       |    2 +-
 arch/h8300/include/asm/segment.h      |    2 +-
 arch/ia64/include/asm/uaccess.h       |    2 +-
 arch/m68k/include/asm/segment.h       |    2 +-
 arch/m68k/include/asm/tlbflush.h      |   12 ++++++------
 arch/microblaze/include/asm/uaccess.h |    2 +-
 arch/mips/include/asm/uaccess.h       |    2 +-
 arch/mips/kernel/unaligned.c          |   27 +++++++++++++--------------
 arch/nds32/include/asm/uaccess.h      |    2 +-
 arch/nds32/kernel/process.c           |    2 +-
 arch/nds32/mm/alignment.c             |    7 +++----
 arch/nios2/include/asm/uaccess.h      |    2 +-
 arch/openrisc/include/asm/uaccess.h   |    2 +-
 arch/parisc/include/asm/uaccess.h     |    2 +-
 arch/powerpc/include/asm/uaccess.h    |    3 +--
 arch/riscv/include/asm/uaccess.h      |    6 +++---
 arch/s390/include/asm/uaccess.h       |    2 +-
 arch/sh/include/asm/segment.h         |    3 +--
 arch/sh/kernel/traps_32.c             |   18 ++++++++----------
 arch/sparc/include/asm/uaccess_32.h   |    2 +-
 arch/sparc/include/asm/uaccess_64.h   |    2 +-
 arch/x86/include/asm/uaccess.h        |    2 +-
 arch/xtensa/include/asm/uaccess.h     |    2 +-
 drivers/firmware/arm_sdei.c           |    5 ++---
 fs/exec.c                             |    7 ++++++-
 include/asm-generic/uaccess.h         |    4 ++--
 include/linux/syscalls.h              |    2 +-
 include/linux/uaccess.h               |   20 ++++++++++++++++++--
 kernel/events/callchain.c             |    5 ++---
 kernel/events/core.c                  |    5 ++---
 kernel/exit.c                         |    2 +-
 kernel/kthread.c                      |    5 ++---
 kernel/stacktrace.c                   |    5 ++---
 mm/maccess.c                          |   22 ++++++++++------------
 39 files changed, 105 insertions(+), 98 deletions(-)
