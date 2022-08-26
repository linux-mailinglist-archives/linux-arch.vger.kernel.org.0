Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E565A27F4
	for <lists+linux-arch@lfdr.de>; Fri, 26 Aug 2022 14:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343540AbiHZMsQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Aug 2022 08:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbiHZMsP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Aug 2022 08:48:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D79DC6FF8;
        Fri, 26 Aug 2022 05:48:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE7DE61D07;
        Fri, 26 Aug 2022 12:48:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F4BCC433D6;
        Fri, 26 Aug 2022 12:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661518093;
        bh=MobuG4jMIn9bpIc0n67GLnZfMcL4pik8R1v8//dhajk=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=OxzGPE+3x3FRELKe1EyF9bv2Iat2Av+t1aB4a4RI7dWoL+h3mjk4TVCJbhiQ7XL7t
         DDnuHcTMYZ4K1ykj1rGBREu+HkaQG1hzOdmbUWLNsc7bIh5ja69jTKsS71+NLtjO5n
         g8pY+0h1vRDtMCJSj9fmVg9FDdn9NpEUhMziH4lZOxtuo3iFYF0jteZMgdYZmexhKb
         hFej0gHPBAqxrwRXxKrYjF+P7ZocGypc0hxJqIV61IfMCKDT0xZR03IQPS38gZBwCX
         TYCA3Jw9Lpl1Iej43pl3TQ/GW3bdt9kK1CpKHjmUG03dX+CedNKNlT16emYwXHh3Fm
         jHu4XS9S3tY/Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 929175C055A; Fri, 26 Aug 2022 05:48:12 -0700 (PDT)
Date:   Fri, 26 Aug 2022 05:48:12 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: "Verifying and Optimizing Compact NUMA-Aware Locks on Weak Memory
 Models"
Message-ID: <20220826124812.GA3007435@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello!

I have not yet done more than glance at this one, but figured I should
send it along sooner rather than later.

"Verifying and Optimizing Compact NUMA-Aware Locks on Weak
Memory Models", Antonio Paolillo, Hernán Ponce-de-León, Thomas
Haas, Diogo Behrens, Rafael Chehab, Ming Fu, and Roland Meyer.
https://arxiv.org/abs/2111.15240

The claim is that the queued spinlocks implementation with CNA violates
LKMM but actually works on all architectures having a formal hardware
memory model.

Thoughts?

							Thanx, Paul
