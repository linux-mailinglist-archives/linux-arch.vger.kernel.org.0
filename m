Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC8260CA11
	for <lists+linux-arch@lfdr.de>; Tue, 25 Oct 2022 12:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbiJYKaF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 Oct 2022 06:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbiJYK3j (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Oct 2022 06:29:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1AAD6DF88;
        Tue, 25 Oct 2022 03:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=D/s8Mn3OZZreLwrO44Z3hxnh6P05RlWt/64fV0S8T78=; b=O7gPuYxYMhiiUSwpaMpT741mhG
        JJ0PsBnILrhtc1Q+bqy0cFyTqDHOQjxPrvXCDO/4hySiss1hoUR/JxbubAOqny7ig3hqJifPZOFvl
        r+pDAcJOuTQIB9wtw33Pph4PG5d/s2Rfzqq0NqcurYB6i30/iHn4UsIMIjU9Y4oUn8w7FE4ftN/4f
        Oo9TqB32R6GGWnP1+3vu8cnsbyKyRLYJpfGC9KJ7vvEfChOxe1GQnX4gwZHtCbidqd/C+OwFnoHgu
        n10uN35j1VePUIYesqnKrHPizQAhvLqhYv/X5tFUMNXA1pGjM2aMO0Mh81K0nMTMEovOP/2/iA2jJ
        zHKe4Eow==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1onHB7-00GBKE-Vo; Tue, 25 Oct 2022 10:29:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D15DD30008D;
        Tue, 25 Oct 2022 12:28:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BB7972C431FA7; Tue, 25 Oct 2022 12:28:56 +0200 (CEST)
Date:   Tue, 25 Oct 2022 12:28:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH] text_poke/ftrace/x86: Allow text_poke() to be called
 in early boot
Message-ID: <Y1e6aOmOfXrSOB/u@hirez.programming.kicks-ass.net>
References: <20221024190311.65b89ecb@gandalf.local.home>
 <CAHk-=wji4q7rGUWDLonnEnxq0ykNCcYGpMrNnZg89rAwOgyRKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wji4q7rGUWDLonnEnxq0ykNCcYGpMrNnZg89rAwOgyRKg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 24, 2022 at 05:11:13PM -0700, Linus Torvalds wrote:

> All of this comes from "poking_init()" being a steaming pile of bovine
> excrement, doing random odd things, and having that special
> "copy_init_mm()" helper that just makes things even worse. Nothing
> else uses that, and it shouldn't have called "dup_mm()" in the first
> place.

Agreed; dup_mm() makes no sense and it is easily removed, see my earlier
patch. Perhaps it can be simplified further to:

	__poking_mm = init_mm

omitting the mm_init() I retained, but I need to stare harder at all
that.

> I'm not even sure why "poking_mm" exists at all, and why it has
> created a whole new copy of "init_mm", and why this code isn't just
> using '&init_mm' like everything else that wants to just walk the
> kernel page tables.

Because it instantiates user-space page-tables in it, you really don't
want those in init_mm.

The whole (and sole) purpose of poking_mm is to contain the writable
aliases. Only the CPU that has the poking_mm active has access to them.
