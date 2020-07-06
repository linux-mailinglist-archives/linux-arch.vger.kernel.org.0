Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF0C2160FD
	for <lists+linux-arch@lfdr.de>; Mon,  6 Jul 2020 23:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgGFVgf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Jul 2020 17:36:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:36494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726864AbgGFVge (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 6 Jul 2020 17:36:34 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-111-31.bvtn.or.frontiernet.net [50.39.111.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9A68206B6;
        Mon,  6 Jul 2020 21:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594071394;
        bh=sA/7CXYi0ngP//7JK4jQdpW143pvzFd4LbBtxm/Bwto=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=wcL9Oo6+GRQVlu4lYInBXGnS8fdoH513Ix30eHlAWrkjitwgzj2QYtMplSKu9Ejqp
         3Eyp3iBuZGMqyt+ArDL/u3atI/41gdwQe/4aKCPfiNCuJqc7Ts/6J8ZaJ5GvvM4v3A
         Y7rqyhQ42pmjGjRnAC58RxkeuWNlgNP5SYJRIPS4=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id D2D793522637; Mon,  6 Jul 2020 14:36:33 -0700 (PDT)
Date:   Mon, 6 Jul 2020 14:36:33 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, dlustig@nvidia.com, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: LKMM
Message-ID: <20200706213633.GL9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200706190324.20638-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706190324.20638-1-grandmaster@al2klimov.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jul 06, 2020 at 09:03:24PM +0200, Alexander A. Klimov wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
>           If both the HTTP and HTTPS versions
>           return 200 OK and serve the same content:
>             Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>

Queued, thank you!

						Thanx, Paul

> ---
>  Continuing my work started at 93431e0607e5.
> 
>  If there are any URLs to be removed completely or at least not HTTPSified:
>  Just clearly say so and I'll *undo my change*.
>  See also https://lkml.org/lkml/2020/6/27/64
> 
>  If there are any valid, but yet not changed URLs:
>  See https://lkml.org/lkml/2020/6/26/837
> 
>  tools/memory-model/Documentation/references.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/memory-model/Documentation/references.txt b/tools/memory-model/Documentation/references.txt
> index b177f3e4a614..9b2d7d56e842 100644
> --- a/tools/memory-model/Documentation/references.txt
> +++ b/tools/memory-model/Documentation/references.txt
> @@ -103,7 +103,7 @@ o	Jade Alglave, Luc Maranget, and Michael Tautschnig. 2014. "Herding
>  
>  o	Jade Alglave, Patrick Cousot, and Luc Maranget. 2016. "Syntax and
>  	semantics of the weak consistency model specification language
> -	cat". CoRR abs/1608.07531 (2016). http://arxiv.org/abs/1608.07531
> +	cat". CoRR abs/1608.07531 (2016). https://arxiv.org/abs/1608.07531
>  
>  
>  Memory-model comparisons
> -- 
> 2.27.0
> 
