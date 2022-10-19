Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD596053BE
	for <lists+linux-arch@lfdr.de>; Thu, 20 Oct 2022 01:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbiJSXHL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Oct 2022 19:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbiJSXHD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Oct 2022 19:07:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7235196B59;
        Wed, 19 Oct 2022 16:06:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B2456B82565;
        Wed, 19 Oct 2022 23:06:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CE27C433B5;
        Wed, 19 Oct 2022 23:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666220813;
        bh=i/mtiZVNxsKmg5CpmqiYpBpNTzKIIRWA+SoU5xFjYIk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DxLhslq+V0uHOuFse/WHl9mJhLVmg65yIFeHYBi66BAnNfOVbTPYMs9vzONNpfGjO
         Wp+9BjHg4j4yRi9LV9f0WVbzY9Q3yK0O8zH5ml2nsP0lwUnuWNbnLCyrihzvKD4HdO
         JlWjWz+upf9pXQlmSE4bvD7FD+gj6eO1zc0qZbaGywLYj3WlEJq6pjRE0++doKeTnZ
         wILqL5v5pkgpJKtGrYvJlb/r0BACpm07EfWIq5cvvjUVOtySYV/9gmjBw5I8sF+7J+
         BrG24q99wj7AnyElTehkpOzNw1/2CU9IZg2DtHSoYU5D3a3ysIWg/sUTPhCkZr+HH2
         2wPuReMArrfZQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id F3F555C0879; Wed, 19 Oct 2022 16:06:52 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, SeongJae Park <sj@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH memory-model 2/5] docs/memory-barriers.txt: Add a missed closing parenthesis
Date:   Wed, 19 Oct 2022 16:06:48 -0700
Message-Id: <20221019230651.2502538-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20221019230640.GA2502305@paulmck-ThinkPad-P17-Gen-1>
References: <20221019230640.GA2502305@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: SeongJae Park <sj@kernel.org>

The description of io_stop_wc(), which was added by commit d5624bb29f49
("asm-generic: introduce io_stop_wc() and add implementation for ARM64"),
has an unclosed parenthesis.  This commit closes it.

Fixes: d5624bb29f49 ("asm-generic: introduce io_stop_wc() and add implementation for ARM64")
Signed-off-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/memory-barriers.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 06f80e3785c5d..cc621decd9439 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -1966,7 +1966,7 @@ There are some more advanced barrier functions:
  (*) io_stop_wc();
 
      For memory accesses with write-combining attributes (e.g. those returned
-     by ioremap_wc(), the CPU may wait for prior accesses to be merged with
+     by ioremap_wc()), the CPU may wait for prior accesses to be merged with
      subsequent ones. io_stop_wc() can be used to prevent the merging of
      write-combining memory accesses before this macro with those after it when
      such wait has performance implications.
-- 
2.31.1.189.g2e36527f23

