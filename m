Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0D7137439
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jan 2020 17:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbgAJQ4t (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Jan 2020 11:56:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:60006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728594AbgAJQ4s (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 10 Jan 2020 11:56:48 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C8C22072A;
        Fri, 10 Jan 2020 16:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578675407;
        bh=/lYMq0JqP8OeZRaU/WM90KSExsE7RBJ5EeIQqcP4Pmw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J+NQubrDjXRMazgVYGd2Z2R1HoFewGZPtMFIoLRcRKltYVXrKIvC+6jrp6sYIagLi
         WZOQ+9H7XO2q1t3BdG7aVMj43ttWZLdbKnVH+JcAI4p8L1iabHzteiV1G7BvKlsEOv
         AAfnohVloSVDEQvGgCd19odi8uDbEHspigNkyGgg=
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
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>
Subject: [RFC PATCH 2/8] netfilter: Avoid assigning 'const' pointer to non-const pointer
Date:   Fri, 10 Jan 2020 16:56:30 +0000
Message-Id: <20200110165636.28035-3-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200110165636.28035-1-will@kernel.org>
References: <20200110165636.28035-1-will@kernel.org>
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
2.25.0.rc1.283.g88dfdc4193-goog

