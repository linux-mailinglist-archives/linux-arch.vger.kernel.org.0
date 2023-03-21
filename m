Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAA66C26CF
	for <lists+linux-arch@lfdr.de>; Tue, 21 Mar 2023 02:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjCUBGo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Mar 2023 21:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjCUBGc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Mar 2023 21:06:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E6EDBC0;
        Mon, 20 Mar 2023 18:06:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5CF6C618E3;
        Tue, 21 Mar 2023 01:05:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B602AC4339B;
        Tue, 21 Mar 2023 01:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679360750;
        bh=lk/kT012gMcqhkSfCDoJ/8R/uLReOUozKnZewytvK6U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jtvV3f1JLKk4RXV6K0u7U3wjsCM49QblcAgGsuHAmEia2LtkbvAaCFdc8rUnQMTND
         okDgNsORp49VfndQ+/7p5+SkzabtEECuBGEWevdn1ep4dXxo/S4FEDhKPfDMaMBXdx
         wrES8JPHFhX4qHI2T4IRFASrEVP7fArJXrWdaxseIPG2UKJIeQ/7PGc79AiEWslKGJ
         3kKRJXpQ/aMrfDbqAZp5NcHNccwSgbs6YzFRDetFJbh0w3/fJH8E5ylDInTFHXUIY2
         VWMa1KEWNkApY7ge10cZqx+93iMtvl+Ye1/bdT9R17Ewy9Tfj/pTeDYxCL1af1WX7x
         CX09fm4qO3V3A==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 64F1A154039B; Mon, 20 Mar 2023 18:05:50 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH memory-model scripts 02/31] tools/memory-model: Make judgelitmus.sh note timeouts
Date:   Mon, 20 Mar 2023 18:05:20 -0700
Message-Id: <20230321010549.51296-2-paulmck@kernel.org>
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

Currently, judgelitmus.sh treats timeouts (as in the "--timeout" argument)
as "!!! Verification error".  This can be misleading because it is quite
possible that running the test longer would have produced a verification.
This commit therefore changes judgelitmus.sh to check for timeouts and
to report them with "!!! Timeout".

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/scripts/judgelitmus.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/memory-model/scripts/judgelitmus.sh b/tools/memory-model/scripts/judgelitmus.sh
index 0cc63875e395..d3c313b9a458 100755
--- a/tools/memory-model/scripts/judgelitmus.sh
+++ b/tools/memory-model/scripts/judgelitmus.sh
@@ -42,6 +42,14 @@ grep '^Observation' $LKMM_DESTDIR/$litmus.out
 if grep -q '^Observation' $LKMM_DESTDIR/$litmus.out
 then
 	:
+elif grep '^Command exited with non-zero status 124' $LKMM_DESTDIR/$litmus.out
+then
+	echo ' !!! Timeout' $litmus
+	if ! grep -q '!!!' $LKMM_DESTDIR/$litmus.out
+	then
+		echo ' !!! Timeout' >> $LKMM_DESTDIR/$litmus.out 2>&1
+	fi
+	exit 124
 else
 	echo ' !!! Verification error' $litmus
 	if ! grep -q '!!!' $LKMM_DESTDIR/$litmus.out
-- 
2.40.0.rc2

