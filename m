Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7973322824E
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jul 2020 16:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgGUOem (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jul 2020 10:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbgGUOel (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jul 2020 10:34:41 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D3CC061794;
        Tue, 21 Jul 2020 07:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=awvO/AxzZMb5RICr1smsNlHEgfMyuxuSrzQI8mKeLw0=; b=QdO/VkrL9Ut3AyXGXc0eOxFwZf
        ydHUDTMC0Sz0h8xQjhpBJVcOhUGVHhOy655jDK/cQtB4ES3xAREo1eJbUmQ5/HyJlPVUtUddajOG7
        NUg5n96enPPuq7Q/+xgrA1/hZ89vAvsqyTGvbmZGLAcaRVflMKjWRy1dfJJ9dpzlpI4MIT55qCuIb
        XVwaqFVRBhNxhDapqdfK9kQV9kEhj/bQkVmNMZa2lKZJM0QpRzIgzfTotGsXnrxSuNt6hlx5zm7B0
        6uyUxL3pDvnjud42NM+WbGO+DV8+X9MV2P/zrTlN37w4desmyvBzjfuBj96iRFWN5IaSY7UZgAiAB
        gszf8JbQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxtLl-0002ZX-ID; Tue, 21 Jul 2020 14:34:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5FE973011C6;
        Tue, 21 Jul 2020 16:34:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 24B9C25E22790; Tue, 21 Jul 2020 16:34:32 +0200 (CEST)
Date:   Tue, 21 Jul 2020 16:34:32 +0200
From:   peterz@infradead.org
To:     Marco Elver <elver@google.com>
Cc:     paulmck@kernel.org, will@kernel.org, arnd@arndb.de,
        mark.rutland@arm.com, dvyukov@google.com, glider@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH 3/8] kcsan: Skew delay to be longer for certain access
 types
Message-ID: <20200721143432.GM119549@hirez.programming.kicks-ass.net>
References: <20200721103016.3287832-1-elver@google.com>
 <20200721103016.3287832-4-elver@google.com>
 <20200721140523.GA10769@hirez.programming.kicks-ass.net>
 <20200721142654.GA3396394@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721142654.GA3396394@elver.google.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 21, 2020 at 04:26:54PM +0200, Marco Elver wrote:

> I'll rewrite the commit message:
> 
> 	For compound instrumentation and assert accesses, skew the
> 	watchpoint delay to be longer if randomized. This is useful to
> 	improve race detection for such accesses.
> 
> 	For compound accesses we should increase the delay as we've
> 	aggregated both read and write instrumentation. By giving up 1
> 	call into the runtime, we're less likely to set up a watchpoint
> 	and thus less likely to detect a race. We can balance this by
> 	increasing the watchpoint delay.

Aah, makes sense now. Thanks!
