Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8152D588E
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2019 00:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729629AbfJMWO2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 13 Oct 2019 18:14:28 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:35348 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728848AbfJMWO2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Sun, 13 Oct 2019 18:14:28 -0400
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Chamillionaire.breakpoint.cc with esmtp (Exim 4.92)
        (envelope-from <sebastian@breakpoint.cc>)
        id 1iJm7a-00089S-Qc; Mon, 14 Oct 2019 00:13:52 +0200
From:   Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>,
        Sebastian Andrzej Siewior <sebastian@breakpoint.cc>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH 1/6] sh: Move cmpxchg-xchg.h to asm-generic
Date:   Mon, 14 Oct 2019 00:13:05 +0200
Message-Id: <20191013221310.30748-2-sebastian@breakpoint.cc>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191013221310.30748-1-sebastian@breakpoint.cc>
References: <20191013221310.30748-1-sebastian@breakpoint.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Breakpoint-Spam-Score: -1.0
X-Breakpoint-Spam-Level: -
X-Breakpoint-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The header file is very generic and could be reused by other
architectures as long as they provide __cmpxchg_u32().

Move sh's cmpxchg-xchg.h to asm-generic.

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-sh@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
---
 arch/sh/include/asm/Kbuild                                  | 1 +
 {arch/sh/include/asm =3D> include/asm-generic}/cmpxchg-xchg.h | 0
 2 files changed, 1 insertion(+)
 rename {arch/sh/include/asm =3D> include/asm-generic}/cmpxchg-xchg.h (100%)

diff --git a/arch/sh/include/asm/Kbuild b/arch/sh/include/asm/Kbuild
index 51a54df22c110..08c1d96286d9d 100644
--- a/arch/sh/include/asm/Kbuild
+++ b/arch/sh/include/asm/Kbuild
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 generated-y +=3D syscall_table.h
+generic-y +=3D cmpxchg-xchg.h
 generic-y +=3D compat.h
 generic-y +=3D current.h
 generic-y +=3D delay.h
diff --git a/arch/sh/include/asm/cmpxchg-xchg.h b/include/asm-generic/cmpxc=
hg-xchg.h
similarity index 100%
rename from arch/sh/include/asm/cmpxchg-xchg.h
rename to include/asm-generic/cmpxchg-xchg.h
--=20
2.23.0

