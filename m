Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCB960C09E
	for <lists+linux-arch@lfdr.de>; Tue, 25 Oct 2022 03:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbiJYBLZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Oct 2022 21:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbiJYBKu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Oct 2022 21:10:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3AB77C1F1;
        Mon, 24 Oct 2022 17:21:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EBBD1B80EDF;
        Tue, 25 Oct 2022 00:21:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DE27C433D6;
        Tue, 25 Oct 2022 00:21:23 +0000 (UTC)
Date:   Mon, 24 Oct 2022 20:21:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH] text_poke/ftrace/x86: Allow text_poke() to be
 called in early boot
Message-ID: <20221024202133.38e0913e@gandalf.local.home>
In-Reply-To: <CAHk-=wji4q7rGUWDLonnEnxq0ykNCcYGpMrNnZg89rAwOgyRKg@mail.gmail.com>
References: <20221024190311.65b89ecb@gandalf.local.home>
        <CAHk-=wji4q7rGUWDLonnEnxq0ykNCcYGpMrNnZg89rAwOgyRKg@mail.gmail.com>
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

On Mon, 24 Oct 2022 17:11:13 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, Oct 24, 2022 at 4:03 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > This required some updates to fork and the maple_tree code to allow it to
> > be called with enabling interrupts in the time when interrupts must remain
> > disabled.  
> 
> Yeah, moving special cases from one place to another doesn't really
> help. Particularly to something as core as dup_mm().
> 
> All of this comes from "poking_init()" being a steaming pile of bovine
> excrement, doing random odd things, and having that special
> "copy_init_mm()" helper that just makes things even worse. Nothing
> else uses that, and it shouldn't have called "dup_mm()" in the first
> place.
> 
> At this point, there is no actual user VM to even copy, so 99% of
> everything that duip_mm() does is not just pointless, but actively
> wrong, like the mmap_write_lock_nested() when we're in early boot.
> 
> I'm not even sure why "poking_mm" exists at all, and why it has
> created a whole new copy of "init_mm", and why this code isn't just
> using '&init_mm' like everything else that wants to just walk the
> kernel page tables.

It's not just walking the page tables, it's creating one that nobody else
is using. Since we want to keep all executable code read only, the way
text_poke() works is to create a new memory mapping where the pages it has
isn't visible by anyone else (which is why it doesn't use init_mm). And
then makes a mapping to the executable address as non executable and
writable. Makes the update, and then removes the mapping.

> 
> Yes, I see that commit 4fc19708b165 ("x86/alternatives: Initialize
> temporary mm for patching"), and no, none of that makes any sense to
> me. It seems just (mis-)designed to fail.
> 

It's all about updating read only pages that are executable with a shadow mm.

-- Steve
