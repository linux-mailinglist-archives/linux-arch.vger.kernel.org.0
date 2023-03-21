Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088166C26CB
	for <lists+linux-arch@lfdr.de>; Tue, 21 Mar 2023 02:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjCUBG2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Mar 2023 21:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjCUBGZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Mar 2023 21:06:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCBA1B2E7;
        Mon, 20 Mar 2023 18:05:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51038618F8;
        Tue, 21 Mar 2023 01:05:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0137C433EF;
        Tue, 21 Mar 2023 01:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679360743;
        bh=NoXGpa8z+g9n+4FfA7OMotchusPIbaT3UCLGesYto7U=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=RVcjbL4pvLipobi6JniSH1Cliwfp23ob47iXgjRYK1HgqkGUR4jt3Snr1VCxDH+Et
         Ur9ConCGSW12XD2ltHg1yCHdi9KZN+Tcans8H0ZrVTQpgFkRRIQrq/RfOp5V5+lYzb
         WscXGh21B96KgyZDvmu50fsLvNiJy77IoMM8zI3ic63F4s/emAHXiH/voWIqiLapWl
         i1bn7pf8D1A1vMZO5dCIEhWO7GylyeQJFGQTvPUesy6K1YAXtT3IjvaBAnB55efoyU
         QqGyMEMZ+1y5MCwN4G7moAwnxnTlDnbPHIvGa6wTNbMv+lCmY8ut5fRmcdf0hxNwAX
         HIVLCEk7Mreww==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 4E7441540395; Mon, 20 Mar 2023 18:05:43 -0700 (PDT)
Date:   Mon, 20 Mar 2023 18:05:43 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com
Subject: [PATCH memory-model 0/31] LKMM scripting updates for v6.4
Message-ID: <4e5839bb-e980-4931-a550-3548d025a32a@paulmck-laptop>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello!

This series provides scripting updates that ease validating
the effects of changes to LKMM:

1.	tools/memory-model:  Document locking corner cases.

2.	tools/memory-model: Make judgelitmus.sh note timeouts.

3.	tools/memory-model: Make cmplitmushist.sh note timeouts.

4.	tools/memory-model: Make judgelitmus.sh identify bad macros.

5.	tools/memory-model: Make judgelitmus.sh detect hard deadlocks.

6.	tools/memory-model: Fix paulmck email address on pre-existing
	scripts.

7.	tools/memory-model: Update parseargs.sh for hardware verification.

8.	tools/memory-model: Make judgelitmus.sh handle hardware
	verifications.

9.	tools/memory-model: Add simpletest.sh to check locking, RCU,
	and SRCU.

10.	tools/memory-model: Fix checkalllitmus.sh comment.

11.	tools/memory-model: Hardware checking for check{,all}litmus.sh.

12.	tools/memory-model: Make judgelitmus.sh ransack .litmus.out files.

13.	tools/memory-model: Split runlitmus.sh out of checklitmus.sh.

14.	tools/memory-model: Make runlitmus.sh generate .litmus.out
	for --hw.

15.	tools/memory-model: Move from .AArch64.litmus.out to
	.litmus.AArch.out.

16.	tools/memory-model: Keep assembly-language litmus tests.

17.	tools/memory-model: Allow herd to deduce CPU type.

18.	tools/memory-model: Make runlitmus.sh check for jingle errors.

19.	tools/memory-model: Add -v flag to jingle7 runs.

20.	tools/memory-model: Implement --hw support for checkghlitmus.sh.

21.	tools/memory-model: Fix scripting --jobs argument.

22.	tools/memory-model: Make checkghlitmus.sh use mselect7.

23.	tools/memory-model: Make history-check scripts use mselect7.

24.	tools/memory-model:  Add "--" to parseargs.sh for additional
	arguments.

25.	tools/memory-model: Repair parseargs.sh header comment.

26.	tools/memory-model: Add checktheselitmus.sh to run specified
	litmus tests.

27.	tools/memory-model: Add data-race capabilities to judgelitmus.sh.

28.	tools/memory-model: Make judgelitmus.sh handle scripted Result:
	tag.

29.	tools/memory-model: Use "-unroll 0" to keep --hw runs finite.

30.	tools/memory-model: Use "grep -E" instead of "egrep", courtesy
	of Tiezhu Yang.

31.	tools/memory-model: Document LKMM test procedure.

						Thanx, Paul

------------------------------------------------------------------------

 b/Documentation/litmus-tests/locking/DCL-broken.litmus |   55 ++
 b/Documentation/litmus-tests/locking/DCL-fixed.litmus  |   56 ++
 b/Documentation/litmus-tests/locking/RM-broken.litmus  |   42 ++
 b/Documentation/litmus-tests/locking/RM-fixed.litmus   |   42 ++
 b/tools/memory-model/Documentation/locking.txt         |  320 +++++++++++++++++
 b/tools/memory-model/litmus-tests/.gitignore           |    2 
 b/tools/memory-model/scripts/README                    |    8 
 b/tools/memory-model/scripts/checkalllitmus.sh         |    2 
 b/tools/memory-model/scripts/checkghlitmus.sh          |    9 
 b/tools/memory-model/scripts/checklitmus.sh            |    2 
 b/tools/memory-model/scripts/checklitmushist.sh        |    2 
 b/tools/memory-model/scripts/checktheselitmus.sh       |   43 ++
 b/tools/memory-model/scripts/cmplitmushist.sh          |   22 +
 b/tools/memory-model/scripts/hwfnseg.sh                |   20 +
 b/tools/memory-model/scripts/initlitmushist.sh         |    2 
 b/tools/memory-model/scripts/judgelitmus.sh            |    8 
 b/tools/memory-model/scripts/newlitmushist.sh          |    2 
 b/tools/memory-model/scripts/parseargs.sh              |    2 
 b/tools/memory-model/scripts/runlitmus.sh              |   69 +++
 b/tools/memory-model/scripts/runlitmushist.sh          |    2 
 b/tools/memory-model/scripts/simpletest.sh             |   35 +
 tools/memory-model/litmus-tests/.gitignore             |    2 
 tools/memory-model/scripts/README                      |   40 ++
 tools/memory-model/scripts/checkalllitmus.sh           |   27 -
 tools/memory-model/scripts/checkghlitmus.sh            |    6 
 tools/memory-model/scripts/checklitmus.sh              |   99 ++---
 tools/memory-model/scripts/cmplitmushist.sh            |   31 +
 tools/memory-model/scripts/judgelitmus.sh              |  156 ++++++--
 tools/memory-model/scripts/newlitmushist.sh            |    2 
 tools/memory-model/scripts/parseargs.sh                |   19 -
 tools/memory-model/scripts/runlitmus.sh                |   75 ++-
 tools/memory-model/scripts/runlitmushist.sh            |   27 -
 32 files changed, 1044 insertions(+), 185 deletions(-)
