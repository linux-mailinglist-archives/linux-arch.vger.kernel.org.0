Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4906C2762
	for <lists+linux-arch@lfdr.de>; Tue, 21 Mar 2023 02:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjCUBV2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Mar 2023 21:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjCUBV0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Mar 2023 21:21:26 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A77230F2;
        Mon, 20 Mar 2023 18:20:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DDB72CE1742;
        Tue, 21 Mar 2023 01:05:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F089C43446;
        Tue, 21 Mar 2023 01:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679360751;
        bh=dTl9j0kLFz79+DRz2r2NTYGvZ0TA7ESPIKqeRybBfzE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ICLcFajJjU4lafzH2MN39Hm7EJA/qpGtwdKnPpyx9Tzo+X6AaNaCyKe8Ka3SWTqAM
         KjBHkbq6JzXpi4xl340zifEfc1pJtgnS0NsImElUne/YUHXEPJBl5exjyP30adp1vo
         OLY32WGsrx1ljIN6fyhB6jpMqXHS9BV9hM/YZsp0JRhUDWz8cg6QuRyowTdgwuaoat
         E9XgeLZwanbTWdfQL+1nv1CXJ2qV8mkDbUJ4jxHnNltKeK6n/NnZzKAk+IwcTBgQqL
         YrP/YOoNoQpHNLr6Dedl0MTiWHj2dmAPP2SrMi9iiSeGmQ1ne6/RCE7PTtqkPKPzSM
         /RZGRsFCU5R6A==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C31B815403C5; Mon, 20 Mar 2023 18:05:50 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH memory-model scripts 23/31] tools/memory-model: Make history-check scripts use mselect7
Date:   Mon, 20 Mar 2023 18:05:41 -0700
Message-Id: <20230321010549.51296-23-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.0.rc2
In-Reply-To: <4e5839bb-e980-4931-a550-3548d025a32a@paulmck-laptop>
References: <4e5839bb-e980-4931-a550-3548d025a32a@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The history-check scripts currently use grep to ignore non-C-language
litmus tests, which is a bit fragile.  This commit therefore enlists the
aid of "mselect7 -arch C", given Luc Maraget's recent modifications that
allow mselect7 to operate in filter mode.

This change requires herdtools 7.52-32-g1da3e0e50977 or later.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/scripts/initlitmushist.sh | 2 +-
 tools/memory-model/scripts/newlitmushist.sh  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/memory-model/scripts/initlitmushist.sh b/tools/memory-model/scripts/initlitmushist.sh
index 956b6957484d..31ea782955d3 100755
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
index 3f4b06e29988..25235e2049cf 100755
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
2.40.0.rc2

