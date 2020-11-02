Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C51C2A2AB8
	for <lists+linux-arch@lfdr.de>; Mon,  2 Nov 2020 13:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbgKBMcO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 Nov 2020 07:32:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:43388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728359AbgKBMcO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 2 Nov 2020 07:32:14 -0500
Received: from localhost.localdomain (unknown [192.30.34.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D84E2076E;
        Mon,  2 Nov 2020 12:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604320333;
        bh=lLXuGY/nGSqNrbsjk3YhWViLi2X0XYWjraAqnjfRDAc=;
        h=From:To:Cc:Subject:Date:From;
        b=xj2CopuKaGXkMg2sipuEiU3iuJEEmdGxEzbxBvMQkkUEUqrhHMqAJsqqYBYeKHrTy
         mAt1qNFbZPz26kGNMcz5w22t0LIY5Gt08nabXpweNBi/9lwYBznFti6g1OtqxRclH8
         GJc5vaCul4npegEcPz3/CW6YydqTd5i0rSUacZJk=
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arch@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kexec@lists.infradead.org
Subject: [PATCH v2 0/4] syscalls: remove compat_alloc_user_space callers
Date:   Mon,  2 Nov 2020 13:31:47 +0100
Message-Id: <20201102123151.2860165-1-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Going through compat_alloc_user_space() to convert indirect system call
arguments tends to add complexity compared to handling the native and
compat logic in the same code.

I have patches for all other uses of compat_alloc_user_space() as well,
and would expect that we can subsequently remove the interface itself.

Changes in v2:

- address review comments from Christoph Hellwig
- split syscall removal into a separate patch
- replace __X32_COND_SYSCALL() with individual macros for x32

Arnd Bergmann (4):
  kexec: simplify compat_sys_kexec_load
  mm: simplify compat_sys_move_pages
  mm: simplify compat numa syscalls
  compat: remove some compat entry points

 arch/arm64/include/asm/unistd32.h         |  12 +-
 arch/mips/kernel/syscalls/syscall_n32.tbl |  12 +-
 arch/mips/kernel/syscalls/syscall_o32.tbl |  12 +-
 arch/parisc/kernel/syscalls/syscall.tbl   |  10 +-
 arch/powerpc/kernel/syscalls/syscall.tbl  |  12 +-
 arch/s390/kernel/syscalls/syscall.tbl     |  12 +-
 arch/sparc/kernel/syscalls/syscall.tbl    |  12 +-
 arch/x86/entry/syscall_x32.c              |   2 +
 arch/x86/entry/syscalls/syscall_32.tbl    |   6 +-
 arch/x86/entry/syscalls/syscall_64.tbl    |   4 +-
 include/linux/compat.h                    |  26 ---
 include/linux/kexec.h                     |   2 -
 include/uapi/asm-generic/unistd.h         |  12 +-
 kernel/kexec.c                            |  90 ++++------
 kernel/sys_ni.c                           |   5 -
 mm/mempolicy.c                            | 195 +++++-----------------
 mm/migrate.c                              |  50 +++---
 17 files changed, 155 insertions(+), 319 deletions(-)

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: kexec@lists.infradead.org
-- 
2.27.0

