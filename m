Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413CC5FAAB9
	for <lists+linux-arch@lfdr.de>; Tue, 11 Oct 2022 04:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbiJKCr6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Oct 2022 22:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiJKCr6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Oct 2022 22:47:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A9E98304A;
        Mon, 10 Oct 2022 19:47:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2FAD4B810D9;
        Tue, 11 Oct 2022 02:47:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC5F9C433C1;
        Tue, 11 Oct 2022 02:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665456474;
        bh=XKiQQSPLSoRP1OB+MswtyNluncEHuM0OAQDxVBUv6MY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=gRo12+acyI7ztJMKgNsECeF1LLbgcswnt9Imp8bm/n3IftknALaRqLs+vK/VTJ3F+
         uPjvxP8S/awUObw34yk3Eb3h9xBHxy09aRmmgph4NTl/PdnVxfkmKs3sGX982gNJWE
         thziDN4BZP+Ugqf2pUndV+6C8oitwMbKFBCg3tlsZ/BenktJlBLqO+1Gf1tN1dGbID
         GoBiIV14NZLhNvmRZEJwaWf71b8ZwDmZzPMlliw8HBQ7VWnNUW0ak2dfVMGp2eOYsy
         lDyYQe/y+GL+FNGqbU0Ju/B5aengEwbezLSa2tGsM6f+nkqPjclXkQDt014WGUxFOy
         IDVBnKW84SMmQ==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] docs/memory-barriers.txt: Add a missed closing parenthesis
Date:   Mon, 10 Oct 2022 19:47:38 -0700
Message-Id: <20221011024738.24510-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221009183723.52037-1-sj@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, 9 Oct 2022 18:37:23 +0000 SeongJae Park <sj@kernel.org> wrote:

> Hi Paul,
> 
> On Sun, 9 Oct 2022 04:10:00 -0700 "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > On Sat, Oct 08, 2022 at 10:49:25AM -0700, SeongJae Park wrote:
> > > Description of io_stop_wc(), which added by commit d5624bb29f49
> > > ("asm-generic: introduce io_stop_wc() and add implementation for
> > > ARM64"), have unclosed parenthesis.  This commit closes it.
> > > 
> > > Fixes: d5624bb29f49 ("asm-generic: introduce io_stop_wc() and add implementation for ARM64")
> > > Signed-off-by: SeongJae Park <sj@kernel.org>
> > 
> > I have pulled this in, good eyes, and thank you!
> 
> Thank you for quick reply :)
> 
> > 
> > On the other three, we have traditionally asked for an ack from a
> > Korean speaker.  Do we still feel the need to do this?
> 
> I have asked review of the patches to my friend.  I'm unsure if my friend could
> do that in a timely manner, as my friend could also be busy.  Let's wait and
> see.

Thankfully, my friend gave me a feedback for improving the patch.  He has some
mailing tools issue, so I'm saying this instead.  I will post next version of
the translations patches soon.


Thanks,
SJ

> 
> IMHO, such review is not essential for this kind of incremental document
> updates, as I'd prefer making the doc up-to-date even if it contains some
> trivial errors, as long as the history is well manged and therefore such errors
> could be fixed later with good explanations.
> 
> 
> Thanks,
> SJ
> 
> [...]
> 
