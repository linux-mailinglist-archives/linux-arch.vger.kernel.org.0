Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFB2313B36B
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jan 2020 21:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbgANUJH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Jan 2020 15:09:07 -0500
Received: from sv2-smtprelay2.synopsys.com ([149.117.73.133]:53226 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727556AbgANUI5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 14 Jan 2020 15:08:57 -0500
Received: from mailhost.synopsys.com (sv2-mailhost1.synopsys.com [10.205.2.133])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id C556C4049B;
        Tue, 14 Jan 2020 20:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1579032536; bh=f5GlxhH1g7W0d3zEgvx81jnLwcqIiTTmh3wCeGRzGW0=;
        h=From:To:Cc:Subject:Date:From;
        b=fm/TVH0mNkG5VblJWaqvz2mdAEeXboKh6uXtqrQv8g6K4lppyWbpONWze6HfTGsuk
         D2nlY9m6Pj5TuT/CDkL/5sqZREDt6Zglbeh2zl2SeWZnT2t8hTzfTfGOBNL6qjn2ze
         l+6kT7uCoaj6sPfP0fVQF0cAeyMFvxfLBseZ3fZnwnYBiRxvXI19qO5Z2DoBJKZnwh
         OXJ0kTUQXr9X/Q6zhLzEm7kiJ+wGcLkYjxUHfkIx8UvjwO7rnNCDjoGqDi9kudoPcV
         4I1HXDCoIfP3aTmCGr+u+jl1aLHOa6jxn1p9w8TUZ6nT7hprCvrRNupN9xnlctaqnw
         IHOf0LtcpCi1A==
Received: from vineetg-Latitude-E7450.internal.synopsys.com (vineetg-latitude-e7450.internal.synopsys.com [10.10.161.25])
        by mailhost.synopsys.com (Postfix) with ESMTP id 88973A0096;
        Tue, 14 Jan 2020 20:08:51 +0000 (UTC)
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [RFC 0/4] Switching ARC to optimized generic strncpy_from_user
Date:   Tue, 14 Jan 2020 12:08:42 -0800
Message-Id: <20200114200846.29434-1-vgupta@synopsys.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

This came up when trying to move ARC over to generic word-at-a-time
interface.

 - 1/4 is a trivial fix (and needed for ARC switch)
 - 2/4 is mucking with internals hence the RFC. I could very likely be
   overlooking some possible DoS / exploit issues and apologies in advance
   if thats the case but I felt like sharing it anyways to see what
   others think.
 - 3/4, 4/4 are ARC changes to remove the existing ARC version and
   switch to generic (needs 1/4).

Thx,
-Vineet

Vineet Gupta (4):
  asm-generic/uaccess: don't define inline functions if noinline lib/*
    in use
  lib/strncpy_from_user: Remove redundant user space pointer range check
  ARC: uaccess: remove noinline variants of __strncpy_from_user() and
    friends
  ARC: uaccess: use optimized generic __strnlen_user/__strncpy_from_user

 arch/arc/Kconfig                      |  2 +
 arch/arc/include/asm/Kbuild           |  1 -
 arch/arc/include/asm/uaccess.h        | 87 ++-------------------------
 arch/arc/include/asm/word-at-a-time.h | 49 +++++++++++++++
 arch/arc/mm/extable.c                 | 23 -------
 include/asm-generic/uaccess.h         |  4 ++
 lib/strncpy_from_user.c               | 36 ++++-------
 lib/strnlen_user.c                    | 28 +++------
 8 files changed, 79 insertions(+), 151 deletions(-)
 create mode 100644 arch/arc/include/asm/word-at-a-time.h

-- 
2.20.1

