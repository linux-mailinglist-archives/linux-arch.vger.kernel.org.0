Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3917932B4EC
	for <lists+linux-arch@lfdr.de>; Wed,  3 Mar 2021 06:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1450183AbhCCFbH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Mar 2021 00:31:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234141AbhCCDO1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 Mar 2021 22:14:27 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B67C061788;
        Tue,  2 Mar 2021 19:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AbVQqJrc95rcwV/qi2U2Kvapd0uuifNLEOzInOb6NXY=; b=JivACTLmdK8rcu89+3VS8/UA9c
        yDsTVOhwLBtpBrh9so65URBwm6trCQTrxc/+idd0h6aTAfSG2GvsDuMH3ZkN3Dt1rzN9t+HhP5zq7
        2mnYL4imtP1o5By8UyCfZfuj1oW4kdJg4uj2A/VOnUU2l/AiqkC+WabriKKCfpdMr0Nuv89LY2NLe
        sa5KfeVABMPzUxmYVSlx6xbouQnmdEX0t1uPMqDT4vgWqN0CqRnTJzrclk8yor6YGa2kJnWj6J2t7
        2gN66hIYJE6/YKxt0PGNxvJGREjqc0DEmxsX3cNVk5gUUXXbV9+j3LQKaz4x0flmtlN7YAPys7P67
        h+X9UqIQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lHHut-0014tQ-EV; Wed, 03 Mar 2021 03:11:18 +0000
Date:   Wed, 3 Mar 2021 03:11:15 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     menglong8.dong@gmail.com
Cc:     will@kernel.org, aneesh.kumar@linux.ibm.com,
        akpm@linux-foundation.org, npiggin@gmail.com, peterz@infradead.org,
        arnd@arndb.de, linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Zhang Yunkai <zhang.yunkai@zte.com.cn>
Subject: Re: [PATCH] module: remove extra spaces in include/asm-generic/tlb.h
Message-ID: <20210303031115.GA2723601@casper.infradead.org>
References: <20210303030443.176174-1-zhang.yunkai@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303030443.176174-1-zhang.yunkai@zte.com.cn>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 02, 2021 at 07:04:43PM -0800, menglong8.dong@gmail.com wrote:
> From: Zhang Yunkai <zhang.yunkai@zte.com.cn>
> 
> Some typos are found out by codespell tool:
> 
> "# define" should be "#define".

Your tool is broken.  This is a style used by some to indicate nesting.
