Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8EEC74798B
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jul 2023 23:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjGDVZM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Jul 2023 17:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjGDVZL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Jul 2023 17:25:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6C318B;
        Tue,  4 Jul 2023 14:25:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8196861281;
        Tue,  4 Jul 2023 21:25:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E04F5C433C7;
        Tue,  4 Jul 2023 21:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688505909;
        bh=qc56JTBHGohk1G3UBHSzdTOuW9NcRbtT8225a+8pH5Q=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=emtK38XlrYPJvK7UxLe0VHhghuLKeQeRWePjA6wNBBOj1orrQ4WKXP0zh1qDSfs/X
         dt1Z+Zi/mi6s9iVRg+51zLHKddCU/OAd/H0TKxYaO11JosTLjcx0/eMzvZOMH6RFVG
         zxCWgQn5rkYEJgfACQxzGz5C+dh48ltQeTxlPfTIwvzCzelcL35jIXmfPOn8izeKZd
         s2mt441asHp+men5mUbS3CcW5B2JrH1kUXrytQ8Lkr8pG4/p8evSADchqrLnhxTYFk
         72W0GgjMcy0qoiTiVIFbCRPCJfsGi/XT9DVw3djQjRumGduewmom3KfKs0UYPM4I2F
         0/Q4/FkK9i+7w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7E9CFCE0CC2; Tue,  4 Jul 2023 14:25:09 -0700 (PDT)
Date:   Tue, 4 Jul 2023 14:25:09 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Olivier Dion <odion@efficios.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rnk@google.com, Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, gcc@gcc.gnu.org, llvm@lists.linux.dev
Subject: Re: [RFC] Bridging the gap between the Linux Kernel Memory
 Consistency Model (LKMM) and C11/C++11 atomics
Message-ID: <3f740262-821b-4f39-8f1a-c6d02253986c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <87ttukdcow.fsf@laura>
 <feb9c2c0-24ce-40bf-a865-5898ffad3005@rowland.harvard.edu>
 <87ilazd278.fsf@laura>
 <bcdd09ec-b98f-42d6-b59d-64db953076f6@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bcdd09ec-b98f-42d6-b59d-64db953076f6@rowland.harvard.edu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 04, 2023 at 04:25:45PM -0400, Alan Stern wrote:
> On Tue, Jul 04, 2023 at 01:19:23PM -0400, Olivier Dion wrote:

[ . . . ]

> > I am puzzled by this.  Initialization of a shared variable does not need
> > to be atomic until its publication.  Could you expand on this?
> 
> In the kernel, I believe it sometimes happens that an atomic variable 
> may be published before it is initialized.  (If that's wrong, Paul or 
> Peter can correct me.)  But since this doesn't apply to the situations 
> you're concerned with, you can forget I mentioned it.

Both use cases exist.

A global atomic is implicitly published at compile time.  If the desired
initial value is not known until multiple threads are running, then it
is necessary to be careful.  Hence double-check locking and its various
replacements.  (Clearly, if you can determine the initial value before
going multithreaded, life is simpler.)

And dynamically allocated or on-stack storage is the other case, where
there is a point in time when the storage is private even after multiple
threads are running.

Or am I missing the point?

							Thanx, Paul
