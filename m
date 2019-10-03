Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 152E5C95A0
	for <lists+linux-arch@lfdr.de>; Thu,  3 Oct 2019 02:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729699AbfJCA1A (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Oct 2019 20:27:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:56184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729691AbfJCA1A (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 2 Oct 2019 20:27:00 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B06E82246A;
        Thu,  3 Oct 2019 00:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570062419;
        bh=hg9h3CShBmdb/btxxEoCzx3iFm8AQx2sNSv0rjVDChE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pKou6vfKo0bhyaW40Sx9VRxr86Kxf2yU9nqV7ch71rxb1cvVcx2756HW+Jo0HGYXe
         uY6clPIvPr6aBJvMl6uV4SZ/TfE2EPhmt1DJLLNA2kp8t8RmavhmAJkff9Mvp9SfET
         1Vc2aen92tsLn2iclI/0raOOrdHCbBG6uxjQvbZU=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 26/32] tools/memory-model: Make history-check scripts use mselect7
Date:   Wed,  2 Oct 2019 17:26:44 -0700
Message-Id: <20191003002650.11249-26-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191003001039.GA8027@paulmck-ThinkPad-P72>
References: <20191003001039.GA8027@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: "Paul E. McKenney" <paulmck@linux.ibm.com>

The history-check scripts currently use grep to ignore non-C-language
litmus tests, which is a bit fragile.  This commit therefore enlists the
aid of "mselect7 -arch C", given Luc Maraget's recent modifications that
allow mselect7 to operate in filter mode.

This change requires herdtools 7.52-32-g1da3e0e50977 or later.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/memory-model/scripts/initlitmushist.sh | 2 +-
 tools/memory-model/scripts/newlitmushist.sh  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/memory-model/scripts/initlitmushist.sh b/tools/memory-model/scripts/initlitmushist.sh
index 956b695..31ea782 100755
--- a/tools/memory-model/scripts/initlitmushist.sh
+++ b/tools/memory-model/scripts/initlitmushist.sh
@@ -60,7 +60,7 @@ fi
 
 # Create a list of the C-language litmus tests with no more than the
 # specified number of processes (per the --procs argument).
-find litmus -name '*.litmus' -exec grep -l -m 1 "^C " {} \; > $T/list-C
+find litmus -name '*.litmus' -print | mselect7 -arch C > $T/list-C
 xargs < $T/list-C -r grep -L "^P${LKMM_PROCS}" > $T/list-C-short
 
 scripts/runlitmushist.sh < $T/list-C-short
diff --git a/tools/memory-model/scripts/newlitmushist.sh b/tools/memory-model/scripts/newlitmushist.sh
index 3f4b06e2..25235e2 100755
--- a/tools/memory-model/scripts/newlitmushist.sh
+++ b/tools/memory-model/scripts/newlitmushist.sh
@@ -43,7 +43,7 @@ fi
 
 # Form full list of litmus tests with no more than the specified
 # number of processes (per the --procs argument).
-find litmus -name '*.litmus' -exec grep -l -m 1 "^C " {} \; > $T/list-C-all
+find litmus -name '*.litmus' -print | mselect7 -arch C > $T/list-C-all
 xargs < $T/list-C-all -r grep -L "^P${LKMM_PROCS}" > $T/list-C-short
 
 # Form list of new tests.  Note: This does not handle litmus-test deletion!
-- 
2.9.5

