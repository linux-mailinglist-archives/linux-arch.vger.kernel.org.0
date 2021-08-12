Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 699CB3E9B9E
	for <lists+linux-arch@lfdr.de>; Thu, 12 Aug 2021 02:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbhHLA0D (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 11 Aug 2021 20:26:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:58696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230072AbhHLA0A (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 11 Aug 2021 20:26:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 325886104F;
        Thu, 12 Aug 2021 00:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628727936;
        bh=nalF53ncdHbhwNRz2ufsd/JwJEBSeVGXufbQHvjVoOE=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=KS5TpNYDP+iA/LTGm+t8Wv35iUgSiurp+K92vjb99xKVsl5mqvpSzdQIvfGFRDHrq
         xbDp3jLMOg6wOyu+kXZq1HJUrjH2ILIK2PY7VmXDQ08p0HFy0pE7PtErtApFPLh22i
         bm+biFUfLkMPXJbL3CRmHBbPFaX6BL7qR3He+SyEQE1T6754Q7IVk+XbhPQaIIibNY
         ZsUuE5DABfbmopLCLmH8Koa+2sxb9X/4oZiLTjoPYirT6teDBPSWbcvhA51RDG3uKy
         xpEDlArMltW2XrRAIHW+gIFxaPFDCaK3/Dkh0QaRtBpMAMUNd/TiFsPcLntkC4LgaD
         cKHnmn4d0Im3w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id EC1A95C048D; Wed, 11 Aug 2021 17:25:35 -0700 (PDT)
Date:   Wed, 11 Aug 2021 17:25:35 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     mingo@kernel.org
Cc:     manfred@colorfullife.com, stern@rowland.harvard.edu,
        parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        dlustig@nvidia.com, joel@joelfernandes.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com
Subject: [GIT PULL lkmm] LKMM commits for v5.15
Message-ID: <20210812002535.GA405507@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello, Ingo!

This pull request contains changes for the Linux-kernel memory model
(LKMM).  These changes focus on documentation, providing additional
examples and use cases.  These have been posted to LKML:

https://lore.kernel.org/lkml/20210721211003.869892-1-paulmck@kernel.org/
https://lore.kernel.org/lkml/20210721211003.869892-2-paulmck@kernel.org/
https://lore.kernel.org/lkml/20210721211003.869892-3-paulmck@kernel.org/
https://lore.kernel.org/lkml/20210721211003.869892-4-paulmck@kernel.org/

They have been exposed to -next and the kernel test robot, not that these
services do all that much for documentation changes.

The following changes since commit 2734d6c1b1a089fb593ef6a23d4b70903526fe0c:

  Linux 5.14-rc2 (2021-07-18 14:13:49 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git lkmm

for you to fetch changes up to 87859a8e3f083bd57b34e6a962544d775a76b15f:

  tools/memory-model: Document data_race(READ_ONCE()) (2021-07-27 11:48:55 -0700)

----------------------------------------------------------------
Manfred Spraul (1):
      tools/memory-model: Heuristics using data_race() must handle all values

Paul E. McKenney (3):
      tools/memory-model: Make read_foo_diagnostic() more clearly diagnostic
      tools/memory-model: Add example for heuristic lockless reads
      tools/memory-model: Document data_race(READ_ONCE())

 .../memory-model/Documentation/access-marking.txt  | 151 ++++++++++++++++++---
 1 file changed, 135 insertions(+), 16 deletions(-)
