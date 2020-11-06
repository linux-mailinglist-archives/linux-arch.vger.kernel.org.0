Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEF652A99E7
	for <lists+linux-arch@lfdr.de>; Fri,  6 Nov 2020 17:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbgKFQ5U (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Nov 2020 11:57:20 -0500
Received: from netrider.rowland.org ([192.131.102.5]:51731 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726075AbgKFQ5U (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 6 Nov 2020 11:57:20 -0500
Received: (qmail 47225 invoked by uid 1000); 6 Nov 2020 11:56:54 -0500
Date:   Fri, 6 Nov 2020 11:56:54 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, parri.andrea@gmail.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Subject: Re: [PATCH memory-model 3/8] tools/memory-model: Document categories
 of ordering primitives
Message-ID: <20201106165654.GB47039@rowland.harvard.edu>
References: <20201105215953.GA15309@paulmck-ThinkPad-P72>
 <20201105220017.15410-3-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105220017.15410-3-paulmck@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Nov 05, 2020 at 02:00:12PM -0800, paulmck@kernel.org wrote:
> From: "Paul E. McKenney" <paulmck@kernel.org>
> 
> The Linux kernel has a number of categories of ordering primitives, which
> are recorded in the LKMM implementation and hinted at by cheatsheet.txt.
> But there is no overview of these categories, and such an overview
> is needed in order to understand multithreaded LKMM litmus tests.
> This commit therefore adds an ordering.txt as well as extracting a
> control-dependencies.txt from memory-barriers.txt.  It also updates the
> README file.
> 
> [ paulmck:  Apply Akira Yokosawa file-placement feedback. ]
> [ paulmck:  Apply Alan Stern feedback. ]
> [ paulmck:  Apply self-review feedback. ]
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
> diff --git a/tools/memory-model/Documentation/README b/tools/memory-model/Documentation/README
> index 2d9539f..a50ea81 100644
> --- a/tools/memory-model/Documentation/README
> +++ b/tools/memory-model/Documentation/README

> @@ -41,13 +50,21 @@ README
>  cheatsheet.txt
>  	Quick-reference guide to the Linux-kernel memory model.
>  
> +control-dependencies.txt
> +	Guide to preventing compiler optimizations from destroying
> +	your control dependencies.
> +
>  explanation.txt
> -	Detailed description of the memory model.
> +	Detailed description of the memory model in detail.

A redundantly redundant change.

Alan
