Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 342C46C7447
	for <lists+linux-arch@lfdr.de>; Fri, 24 Mar 2023 00:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjCWXtm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Mar 2023 19:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjCWXtl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Mar 2023 19:49:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96B9F75F;
        Thu, 23 Mar 2023 16:49:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D198628F0;
        Thu, 23 Mar 2023 23:49:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C09DFC433A0;
        Thu, 23 Mar 2023 23:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679615379;
        bh=QAMYwFTlkBNx7Uzy8bwNabUvsUJwifE27Eycpq5I58A=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=gv9wmPdyqPS2BVuQe1El7EUITWlBqbF1tKaWFDz9XH2wZjxBT7anRPkbl17YyBr5c
         /lpGca41L23mNvDFB41m1vgWW0ObXeSLTj9dtdeSHH+MOKKj30kNuK377i6fSOoVFU
         KcqJYFXsb66EBPRVAGfg63yr/+TtiSbgTRSAYtK1gA3jmy2HN/yMKCPOYgsNBgZ0RX
         tPDh8bP5q+yQtRG/QX98ak05APGqPJw2NECkt84e1TYJ9MSgBNOx3uLs6SCKZaEnL9
         vsCjUsjJiocDz1phZoryzre2AiHAHjp8dlPYqxYGzHPgcK57x4mc5Oqnh9GbKW+vbd
         GBDJrDClHK8qQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 57F881540379; Thu, 23 Mar 2023 16:49:39 -0700 (PDT)
Date:   Thu, 23 Mar 2023 16:49:39 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     parri.andrea@gmail.com, stern@rowland.harvard.edu, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org
Subject: Re: [PATCH memory-model scripts 01/31] tools/memory-model: Document
 locking corner cases
Message-ID: <7f977c87-c2ba-4897-8d03-dc35ef706f9e@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <4e5839bb-e980-4931-a550-3548d025a32a@paulmck-laptop>
 <20230321010549.51296-1-paulmck@kernel.org>
 <f940cb6c-4aa6-41a4-d9d7-330becd5427a@gmail.com>
 <cd356db2-1643-4b01-bb13-16a7f92cf980@paulmck-laptop>
 <2d26aad2-a1d5-649c-86ec-9457c577333f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d26aad2-a1d5-649c-86ec-9457c577333f@gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 24, 2023 at 08:30:38AM +0900, Akira Yokosawa wrote:
> On Thu, 23 Mar 2023 11:52:15 -0700, Paul E. McKenney wrote:
> > On Thu, Mar 23, 2023 at 11:52:57AM +0900, Akira Yokosawa wrote:
> >> Hi Paul,
> >>
> >> On Mon, 20 Mar 2023 18:05:19 -0700, Paul E. McKenney wrote:
> >>> Most Linux-kernel uses of locking are straightforward, but there are
> >>> corner-case uses that rely on less well-known aspects of the lock and
> >>> unlock primitives.  This commit therefore adds a locking.txt and litmus
> >>> tests in Documentation/litmus-tests/locking to explain these corner-case
> >>> uses.
> >>>
> >>> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> >>> ---
> >>>  .../litmus-tests/locking/DCL-broken.litmus    |  55 +++
> >>>  .../litmus-tests/locking/DCL-fixed.litmus     |  56 +++
> >>>  .../litmus-tests/locking/RM-broken.litmus     |  42 +++
> >>>  .../litmus-tests/locking/RM-fixed.litmus      |  42 +++
> >>>  tools/memory-model/Documentation/locking.txt  | 320 ++++++++++++++++++
> >>
> >> I think the documentation needs adjustment to cope with Andrea's change
> >> of litmus tests.
> >>
> >> Also, coding style of code snippets taken from litmus tests look somewhat
> >> inconsistent with other snippets taken from MP+... litmus tests:
> >>
> >>   - Simple function signature such as "void CPU0(void)".
> >>   - No declaration of local variables.
> >>   - Indirection level of global variables.
> >>   - No "locations" clause
> >>
> >> How about applying the diff below?
> > 
> > Good eyes, thank you!  I will fold this in with attribution.
> 
> Feel free to add
> 
> Reviewed-by: Akira Yokosawa <akiyks@gmail.com>

Thank you, I will apply on my next full rebase.

							Thanx, Paul
