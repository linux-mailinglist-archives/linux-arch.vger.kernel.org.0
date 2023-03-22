Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF60F6C3F75
	for <lists+linux-arch@lfdr.de>; Wed, 22 Mar 2023 02:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjCVBN0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Mar 2023 21:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjCVBNZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Mar 2023 21:13:25 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 0E639222D0
        for <linux-arch@vger.kernel.org>; Tue, 21 Mar 2023 18:13:23 -0700 (PDT)
Received: (qmail 1086787 invoked by uid 1000); 21 Mar 2023 21:13:23 -0400
Date:   Tue, 21 Mar 2023 21:13:23 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com,
        Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Subject: Re: [PATCH memory-model 5/8] tools/memory-model: Provide exact SRCU
 semantics
Message-ID: <ceaa37af-407f-4612-807a-6a6c5a1edda5@rowland.harvard.edu>
References: <778147e4-ccab-40cf-b6ef-31abe4e3f6b7@paulmck-laptop>
 <20230321010246.50960-5-paulmck@kernel.org>
 <ZBpU3BAqmTQHxEyN@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBpU3BAqmTQHxEyN@andrea>
X-Spam-Status: No, score=0.2 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 22, 2023 at 02:07:40AM +0100, Andrea Parri wrote:
> > +let carry-srcu-data = (data ; [~ Srcu-unlock] ; rf)*
> 
> > +let carry-dep = (data ; [~ Srcu-unlock] ; rfi)*
> 
> Nit: we use "~M" (no space after the unary operator) in this file, is
> there a reason for the different styles?

No reason that I know of, just lack of thought (as far as 
carry-srcu-data is concerned).  Feel free to change it.

Alan
