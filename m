Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E78B03B6614
	for <lists+linux-arch@lfdr.de>; Mon, 28 Jun 2021 17:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236510AbhF1Pwl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Jun 2021 11:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236354AbhF1Pwe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Jun 2021 11:52:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372CAC0660F7;
        Mon, 28 Jun 2021 08:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+zUrG0KW60jA/qerRDVqmGbgfX8nW7sbtgp5lIy1jqI=; b=WJSm7m6lZ6c+hxbXwJosod7Pwd
        o5xeuLeyLY3iH0v0jO1hj8FM04JuKbS5XwTZZ16UHQ+eyVLqDT/LXc1CZzrCIfa/hKtBMiZO8ltXE
        2HouSun6zicjUhu22LNl9cgEBM+FKkHxn0IAjm+siUhtI+MipfjhXeYzYt+h0KePR2aqo763IBcGz
        bF4ZJT7Ao126QRIcjakkCfFaHR0DsAfnbMAGPT7h5YWtvszOWqJsDvE4AwBWN9UzoyVsh+B1a8ZtN
        SPf9CJOF3Yhbi5ssQ10VNvNnzWoAQu/skrXotNsW7S3mFbDUrWBYKzgCmP9CRHbQPj1QY+/11FWbN
        YAS77lwA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lxtAT-0039g3-Lx; Mon, 28 Jun 2021 15:27:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D49EB300204;
        Mon, 28 Jun 2021 17:27:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BCCB8207D0AF0; Mon, 28 Jun 2021 17:27:24 +0200 (CEST)
Date:   Mon, 28 Jun 2021 17:27:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thiago Macieira <thiago.macieira@intel.com>
Cc:     fweimer@redhat.com,
        "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        hjl.tools@gmail.com, libc-alpha@sourceware.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        x86@kernel.org
Subject: Re: x86 CPU features detection for applications (and AMX)
Message-ID: <YNnqXCSVUhYhzT6T@hirez.programming.kicks-ass.net>
References: <22261946.eFiGugXE7Z@tjmaciei-mobl1>
 <3c5c29e2-1b52-3576-eda2-018fb1e58ff9@metux.net>
 <2379132.fg5cGID6mU@tjmaciei-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2379132.fg5cGID6mU@tjmaciei-mobl1>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 28, 2021 at 08:08:41AM -0700, Thiago Macieira wrote:
> On Monday, 28 June 2021 05:40:32 PDT Enrico Weigelt, metux IT consult wrote:

> > What we SW engineers need is an easy and fast method to act depending on
> > whether some CPU supports some feature (eg. a new opcode). Things like
> > cpuinfo are only a tiny piece of that. What we could really use is a
> > conditional jump/call based on whether feature X is supported - without
> > any kernel intervention. Then the machine code could be easily layed out
> > to support both cases with our without some feature X. Alternatively we
> > could have a fast trapping in useland - hw generated call already would
> > be a big help.
> 
> That's what cpuid is for. With GCC function multi-versioning or equivalent 
> manually-rolled solutions, you can get exactly what you're asking for.

Right, lots of self-modifying code solutions there, some of which can be
linker driven, some not. In the kernel we use alternative() to replace
short code sequences depending on CPUID.

Userspace *could* do the same, rewriting code before first execution is
fairly straight forward.

> Yes, the checking became far more complex with the need to check XCR0 after 
> AVX came along, but since the instruction itself is a slow and serialising, 
> any library will just cache the results. And as a result, the level of CPU 
> features is not expected to change. It never has in the past, so this hasn't 
> been an issue.

Arguably you should be checking XCR0 for any feature there, including
SSE/AVX/AVX512 and now AMX.

Ideally we'd do a prctl() for AVX512 too, except it's too late :-(
