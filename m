Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69B8B77C73
	for <lists+linux-arch@lfdr.de>; Sun, 28 Jul 2019 02:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbfG1AAs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 27 Jul 2019 20:00:48 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34062 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727356AbfG1AAr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 27 Jul 2019 20:00:47 -0400
Received: by mail-pg1-f195.google.com with SMTP id n9so20220019pgc.1
        for <linux-arch@vger.kernel.org>; Sat, 27 Jul 2019 17:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5J+lD5ch8vXzDJuyJtECfbLzKiPriUkT07c6KSz94ZM=;
        b=T2o1krj4j0LVp1ELAOPb3Xh8vljPGm838t4cE023O8kfUYUlIWvOPMl9I+iKUwIbsO
         6hgWJDFBQ/5H0J/B+LwPJlcz+TAqoTzkiF4gdMAXBmxZohnCwJQi6BsgiPLQE5bz3+BJ
         S55Dn8azPOsOJ1FUVJUyKX1r++VF8Gtjo2FC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5J+lD5ch8vXzDJuyJtECfbLzKiPriUkT07c6KSz94ZM=;
        b=jkbZ/oBR3Voblg/Qvpe93Ohujd5v3KCxCgDnMpdOLFHp6YmChbxabECYpw3j6CPi45
         zTuEhlbtjDLTWhg2443Wv252Neckn+xiklTbZccnap77VbqKHyXbEGn1IGiN/AXCgHcQ
         uJsH3OnvOeryGM4wzfwl/tIVBak+622uNrEqL4/xf9+YcdznIiSm50ePpZEoFA+hpdjg
         fCREy2VpGtk+pYy9Urx6E5qKcLQH27kEX5sjfUysy3/EpK01rOmivajTjNjgn9XcpQ1F
         lBKkrtLjniv14bwXqw+DuCk3z6PjT0ZQ+POHwWedNaLiwEmadWLNlccf4umZCEuKd6aC
         GRyw==
X-Gm-Message-State: APjAAAXQhUBUtq3orp8oRyOJVpnCkyBkH1Oe60+bzBS3QxG6UC/29nWr
        j1vgeKTwTCRz6zpsy8bkLZI=
X-Google-Smtp-Source: APXvYqyLroMYlxBAPXzFUeS4Uxboe0o24sx8eEri37appOnHQW6cQU17GM/J/N8v2d6kGkxHRdeCSw==
X-Received: by 2002:a63:df06:: with SMTP id u6mr43778549pgg.96.1564272046916;
        Sat, 27 Jul 2019 17:00:46 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id b36sm88051384pjc.16.2019.07.27.17.00.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 27 Jul 2019 17:00:46 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>, linux-arch@vger.kernel.org,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: [PATCH] docs/lkmm: Correct ->prop example with additional rfe link
Date:   Sat, 27 Jul 2019 20:00:31 -0400
Message-Id: <20190728000031.112364-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This lkmm example should describe an additional rfe link between P1's
store to y and P2's load of y, which should be critical to establishing
the ordering resulting in the ->prop ordering on P0. IOW, there are 2 rfe
links, not one.

Correct these in the docs to make the ->prop ordering in P0 more clear.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 tools/memory-model/Documentation/explanation.txt | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
index 68caa9a976d0..6c0dfaac7f04 100644
--- a/tools/memory-model/Documentation/explanation.txt
+++ b/tools/memory-model/Documentation/explanation.txt
@@ -1302,8 +1302,8 @@ followed by an arbitrary number of cumul-fence links, ending with an
 rfe link.  You can concoct more exotic examples, containing more than
 one fence, although this quickly leads to diminishing returns in terms
 of complexity.  For instance, here's an example containing a coe link
-followed by two fences and an rfe link, utilizing the fact that
-release fences are A-cumulative:
+followed by a fence, an rfe link, another fence and and a final rfe link,
+utilizing the fact that release fences are A-cumulative:
 
 	int x, y, z;
 
@@ -1334,11 +1334,13 @@ If x = 2, r0 = 1, and r2 = 1 after this code runs then there is a prop
 link from P0's store to its load.  This is because P0's store gets
 overwritten by P1's store since x = 2 at the end (a coe link), the
 smp_wmb() ensures that P1's store to x propagates to P2 before the
-store to y does (the first fence), the store to y propagates to P2
-before P2's load and store execute, P2's smp_store_release()
-guarantees that the stores to x and y both propagate to P0 before the
-store to z does (the second fence), and P0's load executes after the
-store to z has propagated to P0 (an rfe link).
+store to y does (the first fence), P2's store to y happens before P2's
+load of y (rfe link), P2's smp_store_release() ensures that P2's load
+of y executes before P2's store of z (second fence), which also would
+imply that stores to x and y happen before the smp_store_release(), which
+means that P2's smp_store_release() will propagate stores to x and y to all
+CPUs before the store to z does (A-cumulative property of this fence).
+Finally P0's load executes after store to z has propagated to P0 (rfe link).
 
 In summary, the fact that the hb relation links memory access events
 in the order they execute means that it must not have cycles.  This
-- 
2.22.0.709.g102302147b-goog

