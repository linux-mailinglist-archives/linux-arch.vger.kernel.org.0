Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF196C2700
	for <lists+linux-arch@lfdr.de>; Tue, 21 Mar 2023 02:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjCUBJi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Mar 2023 21:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjCUBIw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Mar 2023 21:08:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01AA538B60;
        Mon, 20 Mar 2023 18:07:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 247E061909;
        Tue, 21 Mar 2023 01:05:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B078C433A8;
        Tue, 21 Mar 2023 01:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679360751;
        bh=KkPUBBLg+ligW+yx5AbfVzthM2h8Gkqfjs4qM6K8Bgo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hUWitpbJYmNgf53mUcNVEq8XVEx7YGRmxfziFNoo8aDxb04wa8cb9caPpva8NWFnC
         tWvtTM2xckwxP5b4p3jE6I7YN9KobRANvi8eFx5sJLuCSpBUecFVmC9nxS1Smsyyrw
         SuzYCl1nWs//5lzeV8g/6qtt/vdTadoadY9FuxqvXsuWGzO9FNrVpSPLGs4eZNh0Pj
         VfWOeMVQ0DofMK4EnnR2pBmbhuovPjP+ORlkwXiTm38ZujUMcHVTWF5AvSjYPVEEx0
         UPUtq1gQDYb/hpPjYW/ga3yUGlTjhsGXc3M1SLa5dHK7bcJlPbFHumZDNTZAewS5xf
         0c0s/5ZHWX1+A==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 8680415403AB; Mon, 20 Mar 2023 18:05:50 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH memory-model scripts 10/31] tools/memory-model: Fix checkalllitmus.sh comment
Date:   Mon, 20 Mar 2023 18:05:28 -0700
Message-Id: <20230321010549.51296-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.0.rc2
In-Reply-To: <4e5839bb-e980-4931-a550-3548d025a32a@paulmck-laptop>
References: <4e5839bb-e980-4931-a550-3548d025a32a@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The checkalllitmus.sh runs litmus tests in the litmus-tests directory,
not those in the github archive, so this commit updates the comment to
reflect this reality.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/scripts/checkalllitmus.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/memory-model/scripts/checkalllitmus.sh b/tools/memory-model/scripts/checkalllitmus.sh
index 10e14d94acee..54d8da8c338e 100755
--- a/tools/memory-model/scripts/checkalllitmus.sh
+++ b/tools/memory-model/scripts/checkalllitmus.sh
@@ -30,8 +30,8 @@ else
 	exit 255
 fi
 
-# Create any new directories that have appeared in the github litmus
-# repo since the last run.
+# Create any new directories that have appeared in the litmus-tests
+# directory since the last run.
 if test "$LKMM_DESTDIR" != "."
 then
 	find $litmusdir -type d -print |
-- 
2.40.0.rc2

