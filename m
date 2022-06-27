Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22CCF55CE08
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jun 2022 15:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235804AbiF0O4N (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Jun 2022 10:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235478AbiF0O4L (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Jun 2022 10:56:11 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 66F0B167D6
        for <linux-arch@vger.kernel.org>; Mon, 27 Jun 2022 07:56:10 -0700 (PDT)
Received: (qmail 121219 invoked by uid 1000); 27 Jun 2022 10:56:09 -0400
Date:   Mon, 27 Jun 2022 10:56:09 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Paul =?iso-8859-1?Q?Heidekr=FCger?= <Paul.Heidekrueger@in.tum.de>
Cc:     clang-built-linux <llvm@lists.linux.dev>,
        linux-toolchains@vger.kernel.org,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Marco Elver <elver@google.com>,
        Charalampos Mainas <charalampos.mainas@gmail.com>,
        Pramod Bhatotia <pramod.bhatotia@in.tum.de>,
        Soham Chakraborty <s.s.chakraborty@tudelft.nl>,
        Martin Fink <martin.fink@in.tum.de>
Subject: Re: [PATCH RFC] tools/memory-model: Adjust ctrl dependency definition
Message-ID: <YrnFCSjESpeQdciv@rowland.harvard.edu>
References: <20220615114330.2573952-1-paul.heidekrueger@in.tum.de>
 <YqnpshlsAHg7Uf9G@rowland.harvard.edu>
 <50B9D7C1-B11D-4583-9814-BFFF2C80D8CA@in.tum.de>
 <YrHUkfDWsexHRUKj@rowland.harvard.edu>
 <04B4DBD6-1262-4905-9E85-9466FC104895@in.tum.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <04B4DBD6-1262-4905-9E85-9466FC104895@in.tum.de>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 27, 2022 at 11:47:43AM +0200, Paul Heidekrüger wrote:
> 
> > On 21. Jun 2022, at 16:24, Alan Stern <stern@rowland.harvard.edu> wrote:
> > 
> > On Tue, Jun 21, 2022 at 01:59:27PM +0200, Paul Heidekrüger wrote:
> >> OK. So, LKMM limits the scope of control dependencies to its arm(s), hence
> >> there is a control dependency from the last READ_ONCE() before the loop
> >> exists to the WRITE_ONCE().
> >> 
> >> But then what about the following:
> >> 
> >>> int *x, *y;
> >>> 
> >>> int foo()
> >>> {
> >>> 	/* More code */
> >>> 
> >>> 	if(READ_ONCE(x))
> >>> 		return 42;
> >>> 
> >>> 	/* More code */
> >>> 
> >>> 	WRITE_ONCE(y, 42);
> >>> 
> >>> 	/* More code */
> >>> 
> >>> 	return 0;
> >>> }
> >> 
> >> The READ_ONCE() determines whether the WRITE_ONCE() will be executed at all,
> >> but the WRITE_ONCE() doesn't lie in the if condition's arm.
> > 
> > So in this case the LKMM would not recognize that there's a control 
> > dependency, even though it clearly exists.
> 
> Oh, that's unfortunate.
> 
> Then I would still argue that the "at all" definition is misleading. This

I agree, and I would welcome a patch improving the definition.  Perhaps 
something along the lines of what I wrote earlier in this email thread.

> time in the other direction as I had initially proposed though, as the above
> example is a case where "at all" holds true, but LKMM doesn't cover it. Or
> do you think that caveating this in litmus-tests.txt, e.g. via the patch we
> had recently worked out [1], is enough?

No, the explanation should be improved.

Alan
