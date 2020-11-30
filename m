Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B863A2C810A
	for <lists+linux-arch@lfdr.de>; Mon, 30 Nov 2020 10:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgK3Jav (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Nov 2020 04:30:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727628AbgK3Jav (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 30 Nov 2020 04:30:51 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8C4C0613CF;
        Mon, 30 Nov 2020 01:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Qm+mEK06jeIylWH4CfquOTPlX9S20bRHRY0l3x6+Qik=; b=AenMzpFaJkqNGAxuS8hKwAiMgA
        4ISTolEMS6eong2QZUaJjw2leQiObEK1qwozGsZ4f+nZbatk0DJ2MX5ZWdkZ0Xb9n5e0iQZ+gVZVf
        eduxONkowfOwtFnYMslTOdP38vvcJ+wHngenPmoWUE5LACtwPElVRB3eJHFvkLEtmeX64ZILYX2fs
        eHv2D5HfAxa5r8rZV4MPuyD5rfqFkGcfBTfvefdL52q0ZeC3nQk3fC50qcXi8GxYh8O+orGpTG+QN
        8MQjbdH3TcGu4sRFR61XMC4uzyQDW4KEW079MA7FTJjpU/yJLSwla0Ci/q3yyLpIiK+tKyiKBad2e
        zcHfSNyg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kjfVQ-0007lb-Ue; Mon, 30 Nov 2020 09:30:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3B1F9305815;
        Mon, 30 Nov 2020 10:30:00 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 26073203EEFB6; Mon, 30 Nov 2020 10:30:00 +0100 (CET)
Date:   Mon, 30 Nov 2020 10:30:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux-MM <linux-mm@kvack.org>, Anton Blanchard <anton@ozlabs.org>
Subject: Re: [PATCH 6/8] lazy tlb: shoot lazies, a non-refcounting lazy tlb
 option
Message-ID: <20201130093000.GM2414@hirez.programming.kicks-ass.net>
References: <20201128160141.1003903-1-npiggin@gmail.com>
 <20201128160141.1003903-7-npiggin@gmail.com>
 <CALCETrVXUbe8LfNn-Qs+DzrOQaiw+sFUg1J047yByV31SaTOZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrVXUbe8LfNn-Qs+DzrOQaiw+sFUg1J047yByV31SaTOZw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Nov 28, 2020 at 07:54:57PM -0800, Andy Lutomirski wrote:
> This means that mm_cpumask operations won't need to be full barriers
> forever, and we might not want to take the implied full barriers in
> set_bit() and clear_bit() for granted.

There is no implied full barrier for those ops.
