Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4559B6C26AA
	for <lists+linux-arch@lfdr.de>; Tue, 21 Mar 2023 02:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjCUBCt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Mar 2023 21:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbjCUBCr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Mar 2023 21:02:47 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68BC303F5;
        Mon, 20 Mar 2023 18:02:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9C685CE173A;
        Tue, 21 Mar 2023 01:02:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12367C4339B;
        Tue, 21 Mar 2023 01:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679360556;
        bh=95DXjMgUee3wRAPvJmMFD0uCdzHIg+CYgxAvgg9VHBs=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=Kat63105EgZBBtia0ssjmbGFv5bvB0MTFPbu7DHSIDUL46HDVidY2Qd3jB78nZisO
         rvha3zr3fgDcpWVLFjSM2KsuFS5Q/GKxg9ksxiZaD/lUBzKtv1YY5svE9IibI0XzX6
         rwczc8CDmUfIccVe/aQZ3OvjQWXAire8452gaoobisjvg1HoWDnnGDA+G8mPGH28uj
         xc52nGDNrKrDsd5i91uS8xvgkIV6jjXQooU9MQW03Sfs7NJqFOK5q8+kN3mIcpvYO/
         C+Zm1BMs4PVDbXM3bSSXaOCOP6tpW4OKAm1pRvBVh/q/RA6CSlLx31GnPxUuYJPwqa
         MtTsMQOuRLXeQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 9E5991540395; Mon, 20 Mar 2023 18:02:35 -0700 (PDT)
Date:   Mon, 20 Mar 2023 18:02:35 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com
Subject: [PATCH memory-model 0/8] LKMM updates for v6.4
Message-ID: <778147e4-ccab-40cf-b6ef-31abe4e3f6b7@paulmck-laptop>
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

This series provides LKMM updates:

1.	tools/memory-model: Update some warning labels, courtesy of
	Alan Stern.

2.	tools/memory-model: Unify UNLOCK+LOCK pairings to
	po-unlock-lock-po, courtesy of Jonas Oberhauser.

3.	tools/memory-model: Add smp_mb__after_srcu_read_unlock().

4.	tools/memory-model: Restrict to-r to read-read address dependency,
	courtesy of "Joel Fernandes (Google)".

5.	tools/memory-model: Provide exact SRCU semantics, courtesy of
	Alan Stern.

6.	tools/memory-model: Make ppo a subrelation of po, courtesy of
	Jonas Oberhauser.

7.	tools/memory-model: Add documentation about SRCU read-side
	critical sections, courtesy of Alan Stern.

8.	Documentation: litmus-tests: Correct spelling, courtesy of
	Randy Dunlap.

						Thanx, Paul

------------------------------------------------------------------------

 b/Documentation/litmus-tests/README                |    2 
 b/tools/memory-model/Documentation/explanation.txt |  178 +++++++++++++++++++--
 b/tools/memory-model/linux-kernel.bell             |   10 -
 b/tools/memory-model/linux-kernel.cat              |   15 +
 b/tools/memory-model/linux-kernel.def              |    1 
 b/tools/memory-model/lock.cat                      |    6 
 tools/memory-model/linux-kernel.bell               |   20 --
 tools/memory-model/linux-kernel.cat                |    7 
 tools/memory-model/linux-kernel.def                |    6 
 9 files changed, 205 insertions(+), 40 deletions(-)
