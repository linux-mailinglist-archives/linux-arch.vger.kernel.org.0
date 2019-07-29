Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D74D978BDE
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jul 2019 14:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727625AbfG2MgP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jul 2019 08:36:15 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44444 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727129AbfG2MgP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jul 2019 08:36:15 -0400
Received: by mail-pf1-f193.google.com with SMTP id t16so27945919pfe.11
        for <linux-arch@vger.kernel.org>; Mon, 29 Jul 2019 05:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TSzV7RC0yVMqLiuA9qX0NlSf34xDJD+fWOSh5tvbLJM=;
        b=KzkI7bYi9uaBjj+hagxShH/J9WGeYAAicHOHaZx2+ybUxAfQbLY4B1F49h66Fj9eiy
         5wTxkGxKfBGj2AdJWYTtZc5Z3qBbVFc3wTTrsSufQ6y4KX5LmvnDMis3oatVIishAYpo
         w5WBR2nE9S8W6m771/uw4SRnXlG3pZ4qeTSqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TSzV7RC0yVMqLiuA9qX0NlSf34xDJD+fWOSh5tvbLJM=;
        b=H0xdPMZSEwePHoYu1d3ttwJUDvxGHlNzw1IEflL/Zu7m827q4cIdK0PeC6dKUB7Ajg
         GZDIcSb7ee6RsW+LZgA3/c+MlDEVyTSqU2iE5uPQG1l2k5NZYvHttBk6488u3toAshu0
         6+BRhk5XfPAFcLoMvD14xu3OXLA5euPaZU2Nl5CZ2NVuFP8qvocE1JcLoDV7Ob07Y2wL
         A/WXS/NwJw7H+wqKYvrcG209x3uJSV65d2rxED7iYQZG0jqqsc9sY00JOgEsM3XgrLY8
         /VcQMkYjC1WPwzGlMWHFkRnw1s76TQLmJTMRuVzXI3Hd0RQAF8/9nN3RZQeF970YOYr5
         N9Jg==
X-Gm-Message-State: APjAAAXW1YLRUEICQOq2OFDEx4FYjjP9+OiW+5ahIoSs42QBsPE2ZNgp
        Bk0Z71J9vukl0UWzfAPOGks=
X-Google-Smtp-Source: APXvYqwrluq6n6ipVhMOqpsRgfnzyV9l1pZ68HYGe0lLVMzOGWl8WDb5T8Z0DRVYOYGYVh2pNcUe0w==
X-Received: by 2002:a63:66c5:: with SMTP id a188mr103667702pgc.127.1564403774374;
        Mon, 29 Jul 2019 05:36:14 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id q8sm121732096pjq.20.2019.07.29.05.36.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 05:36:13 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Jade Alglave <j.alglave@ucl.ac.uk>, linux-arch@vger.kernel.org,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: [PATCH] Use term cumul-fence instead of fence in ->prop ordering example
Date:   Mon, 29 Jul 2019 08:36:05 -0400
Message-Id: <20190729123605.150423-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

To reduce ambiguity in the more exotic ->prop ordering example, let us
use the term cumul-fence instead fence for the 2 fences, so that the
implict ->rfe on loads/stores to Y are covered by the description.

Link: https://lore.kernel.org/lkml/20190729121745.GA140682@google.com

Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 tools/memory-model/Documentation/explanation.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
index 68caa9a976d0..634dc6db26c4 100644
--- a/tools/memory-model/Documentation/explanation.txt
+++ b/tools/memory-model/Documentation/explanation.txt
@@ -1302,7 +1302,7 @@ followed by an arbitrary number of cumul-fence links, ending with an
 rfe link.  You can concoct more exotic examples, containing more than
 one fence, although this quickly leads to diminishing returns in terms
 of complexity.  For instance, here's an example containing a coe link
-followed by two fences and an rfe link, utilizing the fact that
+followed by two cumul-fences and an rfe link, utilizing the fact that
 release fences are A-cumulative:
 
 	int x, y, z;
@@ -1334,10 +1334,10 @@ If x = 2, r0 = 1, and r2 = 1 after this code runs then there is a prop
 link from P0's store to its load.  This is because P0's store gets
 overwritten by P1's store since x = 2 at the end (a coe link), the
 smp_wmb() ensures that P1's store to x propagates to P2 before the
-store to y does (the first fence), the store to y propagates to P2
+store to y does (the first cumul-fence), the store to y propagates to P2
 before P2's load and store execute, P2's smp_store_release()
 guarantees that the stores to x and y both propagate to P0 before the
-store to z does (the second fence), and P0's load executes after the
+store to z does (the second cumul-fence), and P0's load executes after the
 store to z has propagated to P0 (an rfe link).
 
 In summary, the fact that the hb relation links memory access events
-- 
2.22.0.709.g102302147b-goog

