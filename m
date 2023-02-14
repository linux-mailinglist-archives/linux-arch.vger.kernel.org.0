Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5CF9695639
	for <lists+linux-arch@lfdr.de>; Tue, 14 Feb 2023 02:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjBNB5e (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 13 Feb 2023 20:57:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjBNB5d (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Feb 2023 20:57:33 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 3F84018B25
        for <linux-arch@vger.kernel.org>; Mon, 13 Feb 2023 17:57:32 -0800 (PST)
Received: (qmail 930035 invoked by uid 1000); 13 Feb 2023 20:57:31 -0500
Date:   Mon, 13 Feb 2023 20:57:31 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org, parri.andrea@gmail.com,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com
Subject: Re: Current LKMM patch disposition
Message-ID: <Y+rqi1avpv7obhrg@rowland.harvard.edu>
References: <20230204222411.GC2948950@paulmck-ThinkPad-P17-Gen-1>
 <Y9+41ctA54pjm/KG@google.com>
 <Y+FJSzUoGTgReLPB@rowland.harvard.edu>
 <Y+fN2fvUjGDWBYrv@google.com>
 <Y+f4TYZ9BPlt8y8B@rowland.harvard.edu>
 <CAEXW_YRuTfjc=5OAskTV0Qt_zSJTPP3-01=Y=SypMdPsF_weAQ@mail.gmail.com>
 <Y+hWAksfk4C0M2gB@rowland.harvard.edu>
 <CAEXW_YQUOgYxYUNkQ9W6PS-JPwPSOFU5B=COV7Vf+qNF1jFC7g@mail.gmail.com>
 <Y+ppzKlvzQIE18Hu@rowland.harvard.edu>
 <CAEXW_YRc0qtan5hbTFUeP7B8f-q5BQJS_d2TpKqZ8_aX5A=b2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YRc0qtan5hbTFUeP7B8f-q5BQJS_d2TpKqZ8_aX5A=b2g@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 13, 2023 at 07:36:42PM -0500, Joel Fernandes wrote:
> Thanks, I agree with most of your last email, just replying to one thing:
> 
> > > ->rf does because of data flow causality, ->ppo does because of
> > > program structure, so that makes sense to be ->hb.
> > >
> > > IMHO, ->rfi should as well, because it is embodying a flow of data, so
> > > that is a bit confusing. It would be great to clarify more perhaps
> > > with an example about why ->rfi cannot be ->hb, in the
> > > "happens-before" section.
> >
> > Maybe.  We do talk about store forwarding, and in fact the ppo section
> > already says:
> >
> > ------------------------------------------------------------------------
> >         R ->dep W ->rfi R',
> >
> > where the dep link can be either an address or a data dependency.  In
> > this situation we know it is possible for the CPU to execute R' before
> > W, because it can forward the value that W will store to R'.
> > ------------------------------------------------------------------------
> 
> Thank you for pointing this out! In the text that follows this, in
> this paragraph:
> 
> <quote>
> where the dep link can be either an address or a data dependency.  In
> this situation we know it is possible for the CPU to execute R' before
> W, because it can forward the value that W will store to R'.  But it
> cannot execute R' before R, because it cannot forward the value before
> it knows what that value is, or that W and R' do access the same
> location.
> </quote>
> 
> The "in this situation" should be clarified that the "situation" is a
> data-dependency. Only in the case of data-dependency,  the ->rfi
> cannot cause misordering if I understand it correctly. However, that
> sentence does not mention data-dependency explicitly. Or let me know
> if I missed something?

The text explicitly says that the dep link can be either an address or a 
data dependency.  In either case, R' cannot be reordered before R.

In theory this doesn't have to be true for address dependencies, because 
the CPU might realize that W and R' access the same address without 
knowing what that address is.  However, I've been reliably informed that 
no existing architectures do this sort of optimization.

The case of a control dependency is different, because the CPU can 
speculate that W will be executed and can speculatively forward the 
value from W to R' before it knows what value R will read.

Alan
