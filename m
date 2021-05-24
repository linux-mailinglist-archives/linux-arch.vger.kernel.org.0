Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F333038F5BC
	for <lists+linux-arch@lfdr.de>; Tue, 25 May 2021 00:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbhEXWn0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 May 2021 18:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhEXWn0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 May 2021 18:43:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CC9C061574;
        Mon, 24 May 2021 15:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=KZXb/tLr9YFiA/T3KrJSdP6LyxwsCT3QXewBPoMTKsE=; b=g5bGXx5OXeTJgLIdaHL7wrYzDy
        ug/SzbkUytOW/Wo6NIcbnStWecwnmqr0wzFJgh1JKVyg2CvdKXQMLVAr3ZSQpzCmP8U4B8N9iUNKG
        kGqziSr/xYr+DVSVKoi1VGlmJEnjJhj7etjnNpoE4cNUfB47DRJjyy1JaEeWAHc91Qx2CZK8xJ5fa
        1PJyhf6SEb8drQ9c0fHHbknMOabnz7HMJXtnWfB+F+zlctGQEvpgv+1kng5rwvSRvQco5a6yMdOpZ
        rsAJ3mf28iuhTS72wpjoQ+CGKg9cP6eLb1ZMNtHw+pJeB28VL60CaJSCc/HdJCK71HKsTiUIPdNDg
        ayQYdgHA==;
Received: from [2601:1c0:6280:3f0::7376] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1llJGi-002B2q-Cf; Mon, 24 May 2021 22:41:52 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org, Julian Braha <julianbraha@gmail.com>,
        linux-arch@vger.kernel.org
Subject: [PATCH v2] LOCKDEP: reduce LOCKDEP dependency list
Date:   Mon, 24 May 2021 15:41:50 -0700
Message-Id: <20210524224150.8009-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Some arches (um, sparc64, riscv, xtensa) cause a Kconfig warning for
LOCKDEP.
These arch-es select LOCKDEP_SUPPORT but they are not listed as one
of the arch-es that LOCKDEP depends on.

Since (16) arch-es define the Kconfig symbol LOCKDEP_SUPPORT if they
intend to have LOCKDEP support, replace the awkward list of
arch-es that LOCKDEP depends on with the LOCKDEP_SUPPORT symbol.

But wait. LOCKDEP_SUPPORT is included in LOCK_DEBUGGING_SUPPORT,
which is already a dependency here, so LOCKDEP_SUPPORT is redundant
and not needed.
That leaves the FRAME_POINTER dependency, but it is part of an
expression like this:
	depends on (A && B) && (FRAME_POINTER || B')
where B' is a dependency of B so if B is true then B' is true
and the value of FRAME_POINTER does not matter.
Thus we can also delete the FRAME_POINTER dependency.

Fixes this kconfig warning: (for um, sparc64, riscv, xtensa)

WARNING: unmet direct dependencies detected for LOCKDEP
  Depends on [n]: DEBUG_KERNEL [=y] && LOCK_DEBUGGING_SUPPORT [=y] && (FRAME_POINTER [=n] || MIPS || PPC || S390 || MICROBLAZE || ARM || ARC || X86)
  Selected by [y]:
  - PROVE_LOCKING [=y] && DEBUG_KERNEL [=y] && LOCK_DEBUGGING_SUPPORT [=y]
  - LOCK_STAT [=y] && DEBUG_KERNEL [=y] && LOCK_DEBUGGING_SUPPORT [=y]
  - DEBUG_LOCK_ALLOC [=y] && DEBUG_KERNEL [=y] && LOCK_DEBUGGING_SUPPORT [=y]

Link to v1: https://lore.kernel.org/lkml/20210517034430.9569-1-rdunlap@infradead.org/

Fixes: 7d37cb2c912d ("lib: fix kconfig dependency on ARCH_WANT_FRAME_POINTERS")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: linux-xtensa@linux-xtensa.org
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: linux-um@lists.infradead.org
Cc: Julian Braha <julianbraha@gmail.com>
Cc: linux-arch@vger.kernel.org
---
@Julian: please take a look. I'm a little concerned about the
  FRAME_POINTER dependency going away when our 2 patches are combined.

v2: drop depends on LOCKDEP_SUPPORT for LOCKDEP; the use of
    LOCK_DEBUGGING_SUPPORT already covers that dependency;
    drop FRAME_POINTER dependency (thanks to Waiman Long
    for both of these suggestions)
v2: add CC: to linux-arch

 lib/Kconfig.debug |    1 -
 1 file changed, 1 deletion(-)

--- linux-next-20210524.orig/lib/Kconfig.debug
+++ linux-next-20210524/lib/Kconfig.debug
@@ -1383,7 +1383,6 @@ config LOCKDEP
 	bool
 	depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
 	select STACKTRACE
-	depends on FRAME_POINTER || MIPS || PPC || S390 || MICROBLAZE || ARM || ARC || X86
 	select KALLSYMS
 	select KALLSYMS_ALL
 
