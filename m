Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA5D6146CF0
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jan 2020 16:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbgAWPd6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jan 2020 10:33:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:51582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbgAWPd5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 23 Jan 2020 10:33:57 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52F5822464;
        Thu, 23 Jan 2020 15:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579793637;
        bh=DgeBHk4Qi142J8t70WZY/HkMLE2nSKCOiVg2mhluDAA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M6/axnAUs1mhPEjyqMeyg+I5Pj8EQNwg5B+uk4ZfXL5TY2q4jDg+VrcwUWzZLmDT5
         oCXleHNonKqhqcLTy2bExX00I/WM7fyOctbBfwIPbaIFTb1+3ZSW8yXwpyw43FANnk
         IocGwe21GDoaaWvL8ogZPYCmoq3LMlFnEqOoFMvE=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH v2 02/10] netfilter: Avoid assigning 'const' pointer to non-const pointer
Date:   Thu, 23 Jan 2020 15:33:33 +0000
Message-Id: <20200123153341.19947-3-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200123153341.19947-1-will@kernel.org>
References: <20200123153341.19947-1-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

nf_remove_net_hook() uses WRITE_ONCE() to assign a 'const pointer to a
'non-const' pointer. Cleanups to the implementation of WRITE_ONCE() mean
that this will give rise to a compiler warning, just like a plain old
assignment would do:

  | In file included from ./include/linux/export.h:43,
  |                  from ./include/linux/linkage.h:7,
  |                  from ./include/linux/kernel.h:8,
  |                  from net/netfilter/core.c:9:
  | net/netfilter/core.c: In function ‘nf_remove_net_hook’:
  | ./include/linux/compiler.h:216:30: warning: assignment discards ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
  |   *(volatile typeof(x) *)&(x) = (val);  \
  |                               ^
  | net/netfilter/core.c:379:3: note: in expansion of macro ‘WRITE_ONCE’
  |    WRITE_ONCE(orig_ops[i], &dummy_ops);
  |    ^~~~~~~~~~

Follow the pattern used elsewhere in this file and add a cast to 'void *'
to squash the warning.

Cc: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Jozsef Kadlecsik <kadlec@netfilter.org>
Cc: Florian Westphal <fw@strlen.de>
Cc: "David S. Miller" <davem@davemloft.net>
Signed-off-by: Will Deacon <will@kernel.org>
---
 net/netfilter/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/core.c b/net/netfilter/core.c
index 78f046ec506f..3ac7c8c1548d 100644
--- a/net/netfilter/core.c
+++ b/net/netfilter/core.c
@@ -376,7 +376,7 @@ static bool nf_remove_net_hook(struct nf_hook_entries *old,
 		if (orig_ops[i] != unreg)
 			continue;
 		WRITE_ONCE(old->hooks[i].hook, accept_all);
-		WRITE_ONCE(orig_ops[i], &dummy_ops);
+		WRITE_ONCE(orig_ops[i], (void *)&dummy_ops);
 		return true;
 	}
 
-- 
2.25.0.341.g760bfbb309-goog

