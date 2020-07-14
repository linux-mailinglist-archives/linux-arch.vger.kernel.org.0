Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1AE21EE7D
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jul 2020 12:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbgGNK5Z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Jul 2020 06:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbgGNK5Z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Jul 2020 06:57:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F32C061755;
        Tue, 14 Jul 2020 03:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=QjLbdVL2r17ekhZyVULwOjBowlYS4Ek6fmzcrzp6+qM=; b=ckXveiKAmxhqd2uG+mC3yk5NdZ
        1CaPppiRhZQ44Z943jG5+27ZkyVawPXW34uCC20nz/d8LwO1IiItolK1wDTb3YI1xiIShyF8CnXE4
        hEHT0lqKgAM+SkJ3I8CMIlK4Hco8jqS1bZIS8D+gCenKpI/sPD9BcKxBZw4iexdYXPui6xyJUPsRN
        JPm6W+pmqYK9s02ucbyswztOwQl52ysQ9zbjYBlDCYE5naq6+sywq3wasRid1iTUCcejTEUO93o/P
        gjN8PbaKJYba7pEXm6ybtvmBhE4rcvAdP0jIj5KBbtPNx94p6SjYZtq+iA1Ifxl9zBP4Ug2yuf36y
        eziHGzJA==;
Received: from 089144201169.atnat0010.highway.a1.net ([89.144.201.169] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvIcf-0005s3-G7; Tue, 14 Jul 2020 10:57:17 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: clean up address limit helpers v2
Date:   Tue, 14 Jul 2020 12:54:59 +0200
Message-Id: <20200714105505.935079-1-hch@lst.de>
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


Changes since v1:
 - drop to incorrect hunks
 - fix a commit log typo

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
 arch/m68k/include/asm/tlbflush.h      |    6 +++---
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
 arch/sh/kernel/traps_32.c             |   12 +++++-------
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
 39 files changed, 99 insertions(+), 92 deletions(-)
