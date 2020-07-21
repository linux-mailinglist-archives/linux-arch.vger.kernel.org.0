Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE1922281A1
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jul 2020 16:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgGUOFd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jul 2020 10:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbgGUOFc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 10:05:32 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826C9C061794;
        Tue, 21 Jul 2020 07:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ECmtTwPcomeUswGmRukW4GbqA5iIbD8q9cRC6UN4mms=; b=Kca9vB0Yyw+RmCgPIuI2zi9I7K
        Prt45YiQPU3sC2xyS8lDgTY5ILGPwV4ZrpTCR9hkSwk6EyICV6vgJaa6Ss37sVeA8RnPbD04lprp+
        CWoO13LbzUQDDaYe6okyPo26VAm5+2FGh+EQ2fYpvyLYX1hOY0et1A/xwe6AqX5xTYxFHQmRwcgMP
        W42tPb9t88dVFufbZ5m2FviGAAsrqJRsMoRmYbu4h5eGbcr8J2Te/Cj/KNQHFX4h5i6nBFn/8VyV5
        N0LXzHPqw0cK5/ZdqmT+3bL/7FgH8RW/zjpGi/JqlUmU/gLkyrab18+qg2rhQYjZO0XGSaeKD8ozE
        yZgVzCxQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxstY-0008M4-Ut; Tue, 21 Jul 2020 14:05:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BB6A4304E03;
        Tue, 21 Jul 2020 16:05:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8590720DCCA0B; Tue, 21 Jul 2020 16:05:23 +0200 (CEST)
Date:   Tue, 21 Jul 2020 16:05:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     paulmck@kernel.org, will@kernel.org, arnd@arndb.de,
        mark.rutland@arm.com, dvyukov@google.com, glider@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH 3/8] kcsan: Skew delay to be longer for certain access
 types
Message-ID: <20200721140523.GA10769@hirez.programming.kicks-ass.net>
References: <20200721103016.3287832-1-elver@google.com>
 <20200721103016.3287832-4-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721103016.3287832-4-elver@google.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 21, 2020 at 12:30:11PM +0200, Marco Elver wrote:
> For compound instrumentation and assert accesses, skew the watchpoint
> delay to be longer. We still shouldn't exceed the maximum delays, but it
> is safe to skew the delay for these accesses.

Complete lack of actual justification.. *why* are you doing this, and
*why* is it safe etc..
