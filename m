Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0206B28D24A
	for <lists+linux-arch@lfdr.de>; Tue, 13 Oct 2020 18:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbgJMQdz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Oct 2020 12:33:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:58102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbgJMQdz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 13 Oct 2020 12:33:55 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AA59252A0;
        Tue, 13 Oct 2020 16:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602606834;
        bh=7hRcmCxHpd8KknNwfV3ePJpOrQ+Pc1Ly5aJ34DD3pqI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=XTwEJeZDHDZ5iVBjLiXPEpI7R4yiZlvWyE0FVEswlrnRwHKi5OJ2sbv7mbqm/Bazz
         LAao1Wid9Ky3Kh2tMrLBOMzbbtY6cztVseNiXDpRvXmAyo5uEKML0Rf3tngqiI0TAq
         i12/tq68YFuP+N/+wkR3IqVJo44/GzM+JGHeuzhg=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 337EF3522A36; Tue, 13 Oct 2020 09:33:54 -0700 (PDT)
Date:   Tue, 13 Oct 2020 09:33:54 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Akira Yokosawa <akiyks@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Joel Fernandes <joel@joelfernandes.org>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/24] tools: docs: memory-model: fix references for
 some files
Message-ID: <20201013163354.GO3249@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <cover.1602590106.git.mchehab+huawei@kernel.org>
 <44baab3643aeefdb68f1682d89672fad44aa2c67.1602590106.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44baab3643aeefdb68f1682d89672fad44aa2c67.1602590106.git.mchehab+huawei@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 13, 2020 at 02:14:29PM +0200, Mauro Carvalho Chehab wrote:
> - The sysfs.txt file was converted to ReST and renamed;
> - The control-dependencies.txt is not at
>   Documentation/control-dependencies.txt. As it is at the
>   same dir as the README file, which mentions it, just
>   remove Documentation/.
> 
> With that, ./scripts/documentation-file-ref-check script
> is now happy again for files under tools/.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Queued for review and testing, likely target v5.11.

							Thanx, Paul

> ---
>  tools/memory-model/Documentation/README       | 2 +-
>  tools/memory-model/Documentation/ordering.txt | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/memory-model/Documentation/README b/tools/memory-model/Documentation/README
> index 16177aaa9752..004969992bac 100644
> --- a/tools/memory-model/Documentation/README
> +++ b/tools/memory-model/Documentation/README
> @@ -55,7 +55,7 @@ README
>  Documentation/cheatsheet.txt
>  	Quick-reference guide to the Linux-kernel memory model.
>  
> -Documentation/control-dependencies.txt
> +control-dependencies.txt
>  	A guide to preventing compiler optimizations from destroying
>  	your control dependencies.
>  
> diff --git a/tools/memory-model/Documentation/ordering.txt b/tools/memory-model/Documentation/ordering.txt
> index 3d020bed8585..629b19ae64a6 100644
> --- a/tools/memory-model/Documentation/ordering.txt
> +++ b/tools/memory-model/Documentation/ordering.txt
> @@ -346,7 +346,7 @@ o	Accessing RCU-protected pointers via rcu_dereference()
>  
>  	If there is any significant processing of the pointer value
>  	between the rcu_dereference() that returned it and a later
> -	dereference(), please read Documentation/RCU/rcu_dereference.txt.
> +	dereference(), please read Documentation/RCU/rcu_dereference.rst.
>  
>  It can also be quite helpful to review uses in the Linux kernel.
>  
> -- 
> 2.26.2
> 
