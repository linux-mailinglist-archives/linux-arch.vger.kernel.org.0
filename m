Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39447D7E2D
	for <lists+linux-arch@lfdr.de>; Thu, 26 Oct 2023 10:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344519AbjJZIOh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Oct 2023 04:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344444AbjJZIOg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Oct 2023 04:14:36 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F20B8;
        Thu, 26 Oct 2023 01:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7Ac2lsTLX6oaCFTK+hAgvsoBjk6RrYwjBJWA86xwxA8=; b=PcOA/EqANSQyrrzaA6ZNbON/qw
        2GuUgXTosP7z60vDMEAt/QzqafvyRBZ/yV9b/kaPi23W8blMVIEjNfUphG9iltyG6Qi1mitrUR8Kj
        MRzl05qUDnGaLri4lil6C0/yAGD9swRKnKBjLPu2/B+H1Xg6nwz+Kt/rqUrmkCbKvZG8IffR5pSiK
        FTdf2fs6HmjryxBtpNoHkuMpvY92HNKF6pewQECWNib6WX6dAWjPaEZg3gCHdp+DGRQaVe0VOovTZ
        EA0d8v/nB2omlsg0EDU7ypHQD5oJJG8vnhbC8N/wyXiENErE4Rt/5sD9TXl2vpVIlABQszutn7vPl
        FptwUvjw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qvvUw-00H96Y-0x;
        Thu, 26 Oct 2023 08:13:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id EB2D8300473; Thu, 26 Oct 2023 10:13:45 +0200 (CEST)
Date:   Thu, 26 Oct 2023 10:13:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, llvm@lists.linux.dev,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
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
        Tom Rix <trix@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        kent.overstreet@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        elver@google.com, Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] rust: types: Add read_once and write_once
Message-ID: <20231026081345.GJ31411@noisy.programming.kicks-ass.net>
References: <20231025195339.1431894-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025195339.1431894-1-boqun.feng@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 25, 2023 at 12:53:39PM -0700, Boqun Feng wrote:
> In theory, `read_volatile` and `write_volatile` in Rust can have UB in
> case of the data races [1]. However, kernel uses volatiles to implement
> READ_ONCE() and WRITE_ONCE(), and expects races on these marked accesses
> don't cause UB. And they are proven to have a lot of usages in kernel.
> 
> To close this gap, `read_once` and `write_once` are introduced, they
> have the same semantics as `READ_ONCE` and `WRITE_ONCE` especially
> regarding data races under the assumption that `read_volatile` and
> `write_volatile` have the same behavior as a volatile pointer in C from
> a compiler point of view.
> 
> Longer term solution is to work with Rust language side for a better way
> to implement `read_once` and `write_once`. But so far, it should be good
> enough.

So the whole READ_ONCE()/WRITE_ONCE() thing does two things we care
about (AFAIR):

 - single-copy-atomicy; this can also be achieved using the C11
   __atomic_load_n(.memorder=__ATOMIC_RELAXED) /
   __atomic_store_n(.memorder=__ATOMIC_RELAXED) thingies.

 - the ONCE thing; that is inhibits re-materialization, and here I'm not
   sure C11 atomics help, they might since re-reading an atomic is
   definitely dodgy -- after all it could've changed.

Now, traditionally we've relied on the whole volatile thing simply
because there was no C11, or our oldest compiler didn't do C11. But
these days we actually *could*.

Now, obviously C11 has issues vs LKMM, but perhaps the load/store
semantics are near enough to be useful.  (IIRC this also came up in the
*very* long x86/percpu thread)

So is there any distinction between the volatile load/store and the C11
atomic load/store that we care about and could not Rust use the atomic
load/store to avoid their UB ?
