Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51035762B7
	for <lists+linux-arch@lfdr.de>; Fri, 15 Jul 2022 15:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234731AbiGON1c (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 15 Jul 2022 09:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233373AbiGON1b (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 15 Jul 2022 09:27:31 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id B25A47969A
        for <linux-arch@vger.kernel.org>; Fri, 15 Jul 2022 06:27:27 -0700 (PDT)
Received: (qmail 39379 invoked by uid 1000); 15 Jul 2022 09:27:26 -0400
Date:   Fri, 15 Jul 2022 09:27:26 -0400
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
Message-ID: <YtFrPoOARrL/etBu@rowland.harvard.edu>
References: <20220615114330.2573952-1-paul.heidekrueger@in.tum.de>
 <YqnpshlsAHg7Uf9G@rowland.harvard.edu>
 <50B9D7C1-B11D-4583-9814-BFFF2C80D8CA@in.tum.de>
 <YrHUkfDWsexHRUKj@rowland.harvard.edu>
 <04B4DBD6-1262-4905-9E85-9466FC104895@in.tum.de>
 <YrnFCSjESpeQdciv@rowland.harvard.edu>
 <20F4C097-24B4-416B-95EE-AC11F5952B44@in.tum.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20F4C097-24B4-416B-95EE-AC11F5952B44@in.tum.de>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 15, 2022 at 02:27:28PM +0200, Paul Heidekrüger wrote:
> I have just been thinking about how to word this patch; am I correct in
> assuming that the LKMM does not deal with loop conditions? Or in other
> words, there is no way for a loop condition to impose a ctrl dependency on
> any WRITE_ONCE's in the loop body? It are only if and switch statements the
> LKMM is concerned with in the case of ctrl dependencies?

In theory, the LKMM does say that a loop condition imposes a control 
dependency on any memory accesses within the loop body.  However, the 
herd7 tool has only very limited support for looping constructs, so in 
practice it's not possible to create suitable litmus tests with loops.

Alan
