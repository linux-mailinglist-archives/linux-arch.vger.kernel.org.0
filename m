Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24ADB341B16
	for <lists+linux-arch@lfdr.de>; Fri, 19 Mar 2021 12:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbhCSLHG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 Mar 2021 07:07:06 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:15742 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229806AbhCSLGx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 19 Mar 2021 07:06:53 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4F21LL5Lzwz9tx8t;
        Fri, 19 Mar 2021 12:06:50 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id NP4imNnYq17Y; Fri, 19 Mar 2021 12:06:50 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4F21LL4BwLz9tx8s;
        Fri, 19 Mar 2021 12:06:50 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 02D8F8B972;
        Fri, 19 Mar 2021 12:06:50 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Y3ZxVQgPlJNa; Fri, 19 Mar 2021 12:06:50 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 145088B971;
        Fri, 19 Mar 2021 12:06:49 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 7FE3D675FB; Fri, 19 Mar 2021 11:06:49 +0000 (UTC)
Message-Id: <cover.1616151715.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 00/10] Convert signal32 to user read access by block
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, cmr@codefail.de
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arch@vger.kernel.org
Date:   Fri, 19 Mar 2021 11:06:49 +0000 (UTC)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Similarly to the work done earlier with writes, this series
converts signal32 to using user_read_access_begin/end and
unsafe_get_user() and friends.

Applies on to of the signal64 series, ie on merge-test (ca6e327fefb2)

Christophe Leroy (10):
  signal: Add unsafe_get_compat_sigset()
  powerpc/uaccess: Also perform 64 bits copies in
    unsafe_copy_from_user() on ppc32
  powerpc/signal: Add unsafe_copy_ck{fpr/vsx}_from_user
  powerpc/signal32: Rename save_user_regs_unsafe() and
    save_general_regs_unsafe()
  powerpc/signal32: Remove ifdefery in middle of if/else in sigreturn()
  powerpc/signal32: Perform access_ok() inside restore_user_regs()
  powerpc/signal32: Reorder user reads in restore_tm_user_regs()
  powerpc/signal32: Convert restore_[tm]_user_regs() to user access
    block
  powerpc/signal32: Convert do_setcontext[_tm]() to user access block
  powerpc/signal32: Simplify logging in sigreturn()

 arch/powerpc/include/asm/ptrace.h  |   2 +-
 arch/powerpc/include/asm/uaccess.h |   6 +-
 arch/powerpc/kernel/signal.h       |  22 +++
 arch/powerpc/kernel/signal_32.c    | 251 ++++++++++++++++-------------
 include/linux/compat.h             |  35 ++++
 include/linux/uaccess.h            |   1 +
 6 files changed, 205 insertions(+), 112 deletions(-)

-- 
2.25.0

