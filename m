Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 491B8147166
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jan 2020 20:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbgAWTF7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jan 2020 14:05:59 -0500
Received: from mga04.intel.com ([192.55.52.120]:46723 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727590AbgAWTF7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 23 Jan 2020 14:05:59 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jan 2020 11:05:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,354,1574150400"; 
   d="scan'208";a="259972421"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by fmsmga002.fm.intel.com with ESMTP; 23 Jan 2020 11:05:57 -0800
Subject: [PATCH 0/5] x86: finish the MPX removal process
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, peterz@infradead.org,
        luto@kernel.org, x86@kernel.org, torvalds@linux-foundation.org,
        linux-arch@vger.kernel.org, benh@kernel.crashing.org,
        paulus@samba.org, mpe@ellerman.id.au, jdike@addtoit.com,
        richard@nod.at, anton.ivanov@cambridgegreys.com, gxt@pku.edu.cn
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Thu, 23 Jan 2020 11:04:56 -0800
Message-Id: <20200123190456.8E05ADE6@viggo.jf.intel.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

MPX requires recompiling applications, which requires compiler support.
Unfortunately, GCC 9.1 is expected to be be released without support for
MPX.  This means that there was only a relatively small window where
folks could have ever used MPX.  It failed to gain wide adoption in the
industry, and Linux was the only mainstream OS to ever support it widely.

Support for the feature may also disappear on future processors.

This set completes the process that we started during the 5.4 merge window.

I'd _rather_ this go in via the x86 tree, but I'm not picky.  I could also
send a pull request directly to Linus.  This series is also available here
(mostly for 0day to chew on):

	https://git.kernel.org/pub/scm/linux/kernel/git/daveh/x86-mpx.git/log/?h=mpx-remove-20200123

This posting is mostly an FYI in case any affected maintainers have any
concerns.

 Documentation/x86/intel_mpx.rst            |  252 -------
 arch/x86/include/asm/mpx.h                 |  116 ---
 arch/x86/include/asm/trace/mpx.h           |  134 ----
 arch/x86/mm/mpx.c                          |  938 -----------------------------
 b/arch/powerpc/include/asm/mmu_context.h   |    5 
 b/arch/um/include/asm/mmu_context.h        |    5 
 b/arch/unicore32/include/asm/mmu_context.h |    5 
 b/arch/x86/Kconfig                         |   28 
 b/arch/x86/include/asm/bugs.h              |    6 
 b/arch/x86/include/asm/disabled-features.h |    8 
 b/arch/x86/include/asm/mmu.h               |    4 
 b/arch/x86/include/asm/mmu_context.h       |   26 
 b/arch/x86/include/asm/processor.h         |   18 
 b/arch/x86/kernel/alternative.c            |    1 
 b/arch/x86/kernel/cpu/common.c             |   18 
 b/arch/x86/kernel/cpu/intel.c              |   36 -
 b/arch/x86/kernel/setup.c                  |    2 
 b/arch/x86/kernel/sys_x86_64.c             |    9 
 b/arch/x86/kernel/traps.c                  |   74 --
 b/arch/x86/mm/Makefile                     |    1 
 b/arch/x86/mm/hugetlbpage.c                |    5 
 b/arch/x86/mm/mmap.c                       |    2 
 b/fs/exec.c                                |    1 
 b/include/asm-generic/mm_hooks.h           |    5 
 24 files changed, 2 insertions(+), 1697 deletions(-)

Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: x86@kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arch@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Guan Xuetao <gxt@pku.edu.cn>
