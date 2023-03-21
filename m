Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587396C26B4
	for <lists+linux-arch@lfdr.de>; Tue, 21 Mar 2023 02:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjCUBDa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Mar 2023 21:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjCUBDZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Mar 2023 21:03:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD0230E9A;
        Mon, 20 Mar 2023 18:02:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9F0D3B811BD;
        Tue, 21 Mar 2023 01:02:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F3E7C433A0;
        Tue, 21 Mar 2023 01:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679360568;
        bh=Gt3XpPSB3ySvhPWXjtcOvUQMKgRg79fVOLRl2xXo2AM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WmMRp1zvPLOOAET9ARQLarM8Un0UWuP+RWngaMu+U9SIOvlrNfHi6JnrPrO8JX5d2
         ir2brAZPqyWNdfzwMg9ReNIwr8Q9coxnpnYOB8PSWqqScVPaZTYeBQMfWTINy557fE
         4lkA+0pjujw8ty3sSXuHGca15SKuzMn7JGXo5LcC/Sf/GD3GyFtXQRob/IOSfydSBe
         JvL2ugmkqOhhcNJNPWKX3A1IgiPFQmVi8mfxu0Zd2b+7xl6LuvlHGqxpGVlmSwF89P
         AYwWo2zhLjUMX3rwEvfAk+sWJVMimdqN85o+eq+dt0FBdfttc2IWtSQKN7nt11yr3w
         WMI5v97sM5yqw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 89A0215403A7; Mon, 20 Mar 2023 18:02:47 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, Randy Dunlap <rdunlap@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH memory-model 8/8] Documentation: litmus-tests: Correct spelling
Date:   Mon, 20 Mar 2023 18:02:46 -0700
Message-Id: <20230321010246.50960-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.0.rc2
In-Reply-To: <778147e4-ccab-40cf-b6ef-31abe4e3f6b7@paulmck-laptop>
References: <778147e4-ccab-40cf-b6ef-31abe4e3f6b7@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Correct spelling problems for Documentation/litmus-tests/ as reported
by codespell.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrea Parri <parri.andrea@gmail.com>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jade Alglave <j.alglave@ucl.ac.uk>
Cc: Luc Maranget <luc.maranget@inria.fr>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-arch@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/litmus-tests/README | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/litmus-tests/README b/Documentation/litmus-tests/README
index 7f5c6c3ed6c3..658d37860d39 100644
--- a/Documentation/litmus-tests/README
+++ b/Documentation/litmus-tests/README
@@ -9,7 +9,7 @@ a kernel test module based on a litmus test, please see
 tools/memory-model/README.
 
 
-atomic (/atomic derectory)
+atomic (/atomic directory)
 --------------------------
 
 Atomic-RMW+mb__after_atomic-is-stronger-than-acquire.litmus
-- 
2.40.0.rc2

