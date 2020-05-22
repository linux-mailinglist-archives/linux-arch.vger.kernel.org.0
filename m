Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD6F81DE372
	for <lists+linux-arch@lfdr.de>; Fri, 22 May 2020 11:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728545AbgEVJoq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 22 May 2020 05:44:46 -0400
Received: from merlin.infradead.org ([205.233.59.134]:40512 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728212AbgEVJop (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 May 2020 05:44:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GOPKud88OPaH4A20/+O8fxq1AaAngE7PqgDEZCOAn3I=; b=2Mxc8VJzybe5xRTMJ8Rxntxzng
        KlPBX7vn55ZvUFsiPEORsC2YKopZVg/ZPKl6PRF7/vcFjTqg8jW2z91stWvSncS3qE8I6ZGQJivSs
        FSdCwyRo3nUmEvUKBk46BTTGNYFNC3QgvTgMwoWWPFXobrzkeEOBtpjYC2TafAwcY0Z8XdHVPUjVx
        vaSafW2HHgLwqSDrv6ZRc3dYXl0gpdkI3/0BXoghNyxuNmnKRj476RqNZQKCY+jJ3fcM+r2Jr6ffZ
        WU4qJxwdAf/U4T+fjYggEPlGcGuNphhv/hX6VCLSYs74cZsgPdj2TVws/wokke/agGYZpuPpi8ZmM
        y8RKxa2g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jc4Dp-0005Dq-RF; Fri, 22 May 2020 09:44:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 07A1C306089;
        Fri, 22 May 2020 11:44:08 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E2B9A2B7348E8; Fri, 22 May 2020 11:44:07 +0200 (CEST)
Date:   Fri, 22 May 2020 11:44:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        dlustig@nvidia.com, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        andriin@fb.com
Subject: Re: Some -serious- BPF-related litmus tests
Message-ID: <20200522094407.GK325280@hirez.programming.kicks-ass.net>
References: <20200522003850.GA32698@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200522003850.GA32698@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 21, 2020 at 05:38:50PM -0700, Paul E. McKenney wrote:
> Hello!
> 
> Just wanted to call your attention to some pretty cool and pretty serious
> litmus tests that Andrii did as part of his BPF ring-buffer work:
> 
> https://lore.kernel.org/bpf/20200517195727.279322-3-andriin@fb.com/
> 
> Thoughts?

I find:

	smp_wmb()
	smp_store_release()

a _very_ weird construct. What is that supposed to even do?
