Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37A651DDC40
	for <lists+linux-arch@lfdr.de>; Fri, 22 May 2020 02:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgEVAiv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 May 2020 20:38:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:38974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726650AbgEVAiv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 21 May 2020 20:38:51 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7461207D8;
        Fri, 22 May 2020 00:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590107930;
        bh=3h8Qn+1ZHpVeahuSd6+R1zr7dTCLNVMAgzYYzw6rsEo=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=btURzFMvrRsvv8+ZuqT3XUdzRbGmqrdSwu+Gpf2MxXuV4TysKuzigxbhFDr0PRv9Y
         E6ncvlvSkBXa/rpUeO62JMtL0bOEG7dqgBxPT9OM5NL35WXcVmYsPhhJ226xoz/SuJ
         LMYZTHdftGpa+9PKh5LXBc8hqC+/t1z0AGm3NMBU=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 759133522FEB; Thu, 21 May 2020 17:38:50 -0700 (PDT)
Date:   Thu, 21 May 2020 17:38:50 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        andriin@fb.com
Subject: Some -serious- BPF-related litmus tests
Message-ID: <20200522003850.GA32698@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello!

Just wanted to call your attention to some pretty cool and pretty serious
litmus tests that Andrii did as part of his BPF ring-buffer work:

https://lore.kernel.org/bpf/20200517195727.279322-3-andriin@fb.com/

Thoughts?

							Thanx, Paul
