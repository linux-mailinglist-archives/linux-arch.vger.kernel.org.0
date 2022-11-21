Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531726318E2
	for <lists+linux-arch@lfdr.de>; Mon, 21 Nov 2022 04:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiKUDZy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 20 Nov 2022 22:25:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiKUDZw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 20 Nov 2022 22:25:52 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7ECE626AD6;
        Sun, 20 Nov 2022 19:25:49 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8AxHLa873pjlQkJAA--.13173S3;
        Mon, 21 Nov 2022 11:25:48 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxBle473pjzGoXAA--.43158S2;
        Mon, 21 Nov 2022 11:25:45 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] tools/memory-model: Use "grep -E" instead of "egrep"
Date:   Mon, 21 Nov 2022 11:25:38 +0800
Message-Id: <1669001138-12302-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf8AxBle473pjzGoXAA--.43158S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7uFWUCFy3Kw17CF4ftw4UCFg_yoW8ZF1rpF
        WUA34UKwsIyFyUZr4vkF4rXFnrKan3JFWxWrZFyan8Xrn8GF4YvrySqF4YyFnFqFWDJw4r
        CFWqvFyxWr45AaUanT9S1TB71UUUUjJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bSxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        n4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E
        87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxV
        Aaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxY
        O2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
        WUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
        JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rV
        WUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4U
        JbIYCTnIWIevJa73UjIFyTuYvjxU4SoGDUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

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
---

v2: rebase on linux-rcu.git dev

 tools/memory-model/scripts/checkghlitmus.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/memory-model/scripts/checkghlitmus.sh b/tools/memory-model/scripts/checkghlitmus.sh
index cedd029..d3dfb32 100755
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
2.1.0

