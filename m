Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46885634822
	for <lists+linux-arch@lfdr.de>; Tue, 22 Nov 2022 21:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234580AbiKVU2R (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Nov 2022 15:28:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234079AbiKVU2M (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Nov 2022 15:28:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F78193F0;
        Tue, 22 Nov 2022 12:28:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4ED1B81D8F;
        Tue, 22 Nov 2022 20:28:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A07EEC433D6;
        Tue, 22 Nov 2022 20:28:06 +0000 (UTC)
Date:   Tue, 22 Nov 2022 15:28:05 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Arnd Bergmann" <arnd@arndb.de>
Cc:     "Nadav Amit" <nadav.amit@gmail.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-um@lists.infradead.org,
        Linux-Arch <linux-arch@vger.kernel.org>, linux-mm@kvack.org,
        "Andy Lutomirski" <luto@kernel.org>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
        "Richard Weinberger" <richard@nod.at>,
        "Anton Ivanov" <anton.ivanov@cambridgegreys.com>,
        "Johannes Berg" <johannes@sipsolutions.net>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Nadav Amit" <namit@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 3/3] compiler: inline does not imply notrace
Message-ID: <20221122152805.6d16afc8@gandalf.local.home>
In-Reply-To: <de999ab8-78ff-44f7-aacc-68561897c6e2@app.fastmail.com>
References: <20221122195329.252654-1-namit@vmware.com>
        <20221122195329.252654-4-namit@vmware.com>
        <de999ab8-78ff-44f7-aacc-68561897c6e2@app.fastmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 22 Nov 2022 21:09:08 +0100
"Arnd Bergmann" <arnd@arndb.de> wrote:

> On Tue, Nov 22, 2022, at 20:53, Nadav Amit wrote:
> > From: Nadav Amit <namit@vmware.com>
> >
> > Functions that are marked as "inline" are currently also not tracable.
> > Apparently, this has been done to prevent differences between different
> > configs that caused different functions to be tracable on different
> > platforms.
> >
> > Anyhow, this consideration is not very strong, and tying "inline" and
> > "notrace" does not seem very beneficial. The "inline" keyword is just a
> > hint, and many functions are currently not tracable due to this reason.  
> 
> The original reason was listed in 93b3cca1ccd3 ("ftrace: Make all
> inline tags also include notrace"), which describes
> 
>     Commit 5963e317b1e9d2a ("ftrace/x86: Do not change stacks in DEBUG when
>     calling lockdep") prevented lockdep calls from the int3 breakpoint handler
>     from reseting the stack if a function that was called was in the process
>     of being converted for tracing and had a breakpoint on it. The idea is,
>     before calling the lockdep code, do a load_idt() to the special IDT that
>     kept the breakpoint stack from reseting. This worked well as a quick fix
>     for this kernel release, until a certain config caused a lockup in the
>     function tracer start up tests.
>     
>     Investigating it, I found that the load_idt that was used to prevent
>     the int3 from changing stacks was itself being traced!
> 
> and this sounds like a much stronger reason than what you describe,
> and I would expect your change to cause regressions in similar places.
> 
> It's possible that the right answer is that the affected functions
> should be marked as __always_inline. 

Actually, this requirement may not be as needed as much today. There's been
a lot of work in the last 10 years (when that commit was added) to make
ftrace much more robust.

We could remove the notrace from inline and then see where it breaks ;-)

But I'm guessing that it's probably not as much of an issue as it was
before. Although, it may cause some splats with noinstr but I think that
will be caught at compile time.

-- Steve
