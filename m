Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92AEA2C776B
	for <lists+linux-arch@lfdr.de>; Sun, 29 Nov 2020 04:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725839AbgK2Dd6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 28 Nov 2020 22:33:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:44312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbgK2Dd6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 28 Nov 2020 22:33:58 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3FA82065C;
        Sun, 29 Nov 2020 03:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606620798;
        bh=c+2OdbKbduuehb88A5gHc1LV8eJcBLMOoGx1EaPeJEU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=llP0iKdkTCaCKX7mRMd2cthOvfPgvrtdM8s3J+GJRHb02OrnQtSOD00ilBFUZ8ovv
         A1bxZzzmoHLgZiNS5h3+yaa2MraNZSSHnIN0w4U0E3LTh8bo0CMWUXopFCUT51iUor
         j9WbDSz6A3uqTKGorAjhGb/PY66eFcOItaE1bAMY=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C11633522D27; Sat, 28 Nov 2020 19:33:17 -0800 (PST)
Date:   Sat, 28 Nov 2020 19:33:17 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, stern@rowland.harvard.edu,
        parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr
Subject: Re: [PATCH 2/2] tools/memory-model: Fix typo in klitmus7
 compatibility table
Message-ID: <20201129033317.GA1437@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201105215953.GA15309@paulmck-ThinkPad-P72>
 <20201105220017.15410-6-paulmck@kernel.org>
 <12e0baf4-b1c9-d674-1d4c-310e0a9b6343@gmail.com>
 <20201105225605.GQ3249@paulmck-ThinkPad-P72>
 <2acf8de5-efe9-a205-cb62-04c4774008c0@gmail.com>
 <20201127154652.GU1437@paulmck-ThinkPad-P72>
 <78e1ccaf-9d35-b2a5-1865-fb0a76b3e57e@gmail.com>
 <0f7b4255-cb68-bb1e-6717-3b60a3020c36@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f7b4255-cb68-bb1e-6717-3b60a3020c36@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Nov 28, 2020 at 03:01:49PM +0900, Akira Yokosawa wrote:
> >From 4f577823fa60e14ae58caa2d3c0b2ced64e6eb43 Mon Sep 17 00:00:00 2001
> From: Akira Yokosawa <akiyks@gmail.com>
> Date: Sat, 28 Nov 2020 14:32:15 +0900
> Subject: [PATCH 2/2] tools/memory-model: Fix typo in klitmus7 compatibility table
> 
> klitmus7 of herdtools7 7.48 or earlier depends on ACCESS_ONCE(),
> which was removed in Linux v4.15.
> Fix the obvious typo in the table.
> 
> Fixes: d075a78a5ab1 ("tools/memory-model/README: Expand dependency of klitmus7")
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>

Both queued for review and further testing, thank you!

							Thanx, Paul

> ---
>  tools/memory-model/README | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/memory-model/README b/tools/memory-model/README
> index 39d08d1f0443..9a84c45504ab 100644
> --- a/tools/memory-model/README
> +++ b/tools/memory-model/README
> @@ -51,7 +51,7 @@ klitmus7 Compatibility Table
>  	============  ==========
>  	target Linux  herdtools7
>  	------------  ----------
> -	     -- 4.18  7.48 --
> +	     -- 4.14  7.48 --
>  	4.15 -- 4.19  7.49 --
>  	4.20 -- 5.5   7.54 --
>  	5.6  --       7.56 --
> -- 
> 2.17.1
> 
> 
