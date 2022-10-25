Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2162E60C101
	for <lists+linux-arch@lfdr.de>; Tue, 25 Oct 2022 03:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiJYB3Q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Oct 2022 21:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbiJYB2p (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Oct 2022 21:28:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF08AB1B84;
        Mon, 24 Oct 2022 18:05:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18F7F616EA;
        Tue, 25 Oct 2022 01:05:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AB76C433C1;
        Tue, 25 Oct 2022 01:05:24 +0000 (UTC)
Date:   Mon, 24 Oct 2022 21:05:35 -0400
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
Message-ID: <20221024210535.61174928@gandalf.local.home>
In-Reply-To: <CAHk-=wj_jxetFqMB8VWcJdtOt+CU0r_isyGV4AhEYFxA7YsU7Q@mail.gmail.com>
References: <20221024190311.65b89ecb@gandalf.local.home>
        <CAHk-=wji4q7rGUWDLonnEnxq0ykNCcYGpMrNnZg89rAwOgyRKg@mail.gmail.com>
        <20221024202133.38e0913e@gandalf.local.home>
        <CAHk-=wj_jxetFqMB8VWcJdtOt+CU0r_isyGV4AhEYFxA7YsU7Q@mail.gmail.com>
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

On Mon, 24 Oct 2022 18:02:32 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, Oct 24, 2022 at 5:21 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > It's all about updating read only pages that are executable with a shadow mm.  
> 
> Right. And it doesn't actually need the mm at all, all it wants is the
> kernel page tables. Which is why all the "dup_mmap()" stuff seems so
> wrong.
> 
> I suspect mm_alloc() does everything that VM actually needs.
> 
> IOW, it shouldn't have used the fork() helper, it should have used the
> execve() helper that actually starts out from a clean slate. Because a
> clean slate is exactly what that code wants.
> 
> No?
> 

Something to look into. But I'm guessing that's best for the next merge
window, and not for the -rc releases?

-- Steve
