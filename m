Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213E46C26E8
	for <lists+linux-arch@lfdr.de>; Tue, 21 Mar 2023 02:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjCUBI1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Mar 2023 21:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjCUBH3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Mar 2023 21:07:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07BC12F0A;
        Mon, 20 Mar 2023 18:06:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E54A61919;
        Tue, 21 Mar 2023 01:05:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C060C43444;
        Tue, 21 Mar 2023 01:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679360751;
        bh=2FzOW3T+R4HnYsHV7ty3mj5LYS0RHLM9dQ2q3FNSUVY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L0MQ0RLUMwVekUQe0J6/EgE3P3mpfMo5OX1upPRu00H0RzokVcvbmVDcFZ3JCMCTk
         Mx3+hMV6X3UufPWtyV1dWMSHAGlQ7Zw0c37HDbcfSitwNp3uo9uzHP94lJWGdXuKYR
         vLWTAb1mRsw433qRTaZ9M0Ljo9F0Q9sShcZ3j7Kc9oM3ukolRNZtQTGhfnfpyIoQB/
         QJm6jvA3potdsH94t22smTd9pOzqUHcOIv5HPXbMHbWVP/c9vjqZiXKjXFdy2vkHeF
         xrqMoNsc6lIiMGMO+aHskDprSu6ha9k+x8Mh+nLf+vcK94WMsC2DrYX0DJdzjLefhD
         /ffdkrUUAt/4Q==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id BC5FF15403C3; Mon, 20 Mar 2023 18:05:50 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH memory-model scripts 22/31] tools/memory-model: Make checkghlitmus.sh use mselect7
Date:   Mon, 20 Mar 2023 18:05:40 -0700
Message-Id: <20230321010549.51296-22-paulmck@kernel.org>
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

The checkghlitmus.sh script currently uses grep to ignore non-C-language
litmus tests, which is a bit fragile.  This commit therefore enlists the
aid of "mselect7 -arch C", given Luc Maraget's recent modifications that
allow mselect7 to operate in filter mode.

This change requires herdtools 7.52-32-g1da3e0e50977 or later.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/scripts/checkghlitmus.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/memory-model/scripts/checkghlitmus.sh b/tools/memory-model/scripts/checkghlitmus.sh
index 2ea220d2564b..cedd0290b73f 100755
--- a/tools/memory-model/scripts/checkghlitmus.sh
+++ b/tools/memory-model/scripts/checkghlitmus.sh
@@ -41,7 +41,7 @@ fi
 
 # Create a list of C-language litmus tests with "Result:" commands and
 # no more than the specified number of processes.
-find litmus -name '*.litmus' -exec grep -l -m 1 "^C " {} \; > $T/list-C
+find litmus -name '*.litmus' -print | mselect7 -arch C > $T/list-C
 xargs < $T/list-C -r egrep -l '^ \* Result: (Never|Sometimes|Always|DEADLOCK)' > $T/list-C-result
 xargs < $T/list-C-result -r grep -L "^P${LKMM_PROCS}" > $T/list-C-result-short
 
-- 
2.40.0.rc2

