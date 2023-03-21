Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429426C26F2
	for <lists+linux-arch@lfdr.de>; Tue, 21 Mar 2023 02:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjCUBIw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Mar 2023 21:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbjCUBIY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Mar 2023 21:08:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3569737F19;
        Mon, 20 Mar 2023 18:07:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DA5F61922;
        Tue, 21 Mar 2023 01:05:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B352AC43322;
        Tue, 21 Mar 2023 01:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679360751;
        bh=WB00CrRRLxEmj0pXgFp/Ju7EoygRhiityPvhygsGO3s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u95EU6ZDWRY1JXEc/8UjfNrdzNUVMjdjhCix7mzdYRbNfxFm1LJPjcXyuiJsw5llQ
         nnM+2OrOLX1TUPXd9wqCen2xMvZLUm2eR0nS0pbA6i9U1UKdqJIkf8EgCIAWOIRaw/
         KvmvQVdWMfScVJxZTph8OhTE38TEMPmZCXg1S5GQ9UDWbRE27A1hDS/7T3EM0YlpPS
         l7umhGhf89hKIy2IC46wdg+YBLLUtaB2y/YOFx65R9HpYKSeo3iU7FKyZXPWBBNWxw
         S3Z0sbEFx1kE30YIopJFadLpO01pZ+4LVxoBiCCC+hbauUU/IpZuGUNaR06mKs9v1u
         /iZi0tnGOfzVg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id E30C715403D1; Mon, 20 Mar 2023 18:05:50 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, Tiezhu Yang <yangtiezhu@loongson.cn>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH memory-model scripts 30/31] tools/memory-model: Use "grep -E" instead of "egrep"
Date:   Mon, 20 Mar 2023 18:05:48 -0700
Message-Id: <20230321010549.51296-30-paulmck@kernel.org>
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

From: Tiezhu Yang <yangtiezhu@loongson.cn>

The latest version of grep claims the egrep is now obsolete so the build
now contains warnings that look like:
	egrep: warning: egrep is obsolescent; using grep -E
fix this up by moving the related file to use "grep -E" instead.

  sed -i "s/egrep/grep -E/g" `grep egrep -rwl tools/memory-model`

Here are the steps to install the latest grep:

  wget http://ftp.gnu.org/gnu/grep/grep-3.8.tar.gz
  tar xf grep-3.8.tar.gz
  cd grep-3.8 && ./configure && make
  sudo make install
  export PATH=/usr/local/bin:$PATH

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Reviewed-by: Akira Yokosawa <akiyks@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/scripts/checkghlitmus.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/memory-model/scripts/checkghlitmus.sh b/tools/memory-model/scripts/checkghlitmus.sh
index cedd0290b73f..d3dfb321259f 100755
--- a/tools/memory-model/scripts/checkghlitmus.sh
+++ b/tools/memory-model/scripts/checkghlitmus.sh
@@ -36,13 +36,13 @@ fi
 # Create a list of the specified litmus tests previously run.
 ( cd $LKMM_DESTDIR; find litmus -name "*.litmus${hwfnseg}.out" -print ) |
 	sed -e "s/${hwfnseg}"'\.out$//' |
-	xargs -r egrep -l '^ \* Result: (Never|Sometimes|Always|DEADLOCK)' |
+	xargs -r grep -E -l '^ \* Result: (Never|Sometimes|Always|DEADLOCK)' |
 	xargs -r grep -L "^P${LKMM_PROCS}"> $T/list-C-already
 
 # Create a list of C-language litmus tests with "Result:" commands and
 # no more than the specified number of processes.
 find litmus -name '*.litmus' -print | mselect7 -arch C > $T/list-C
-xargs < $T/list-C -r egrep -l '^ \* Result: (Never|Sometimes|Always|DEADLOCK)' > $T/list-C-result
+xargs < $T/list-C -r grep -E -l '^ \* Result: (Never|Sometimes|Always|DEADLOCK)' > $T/list-C-result
 xargs < $T/list-C-result -r grep -L "^P${LKMM_PROCS}" > $T/list-C-result-short
 
 # Form list of tests without corresponding .out files
-- 
2.40.0.rc2

