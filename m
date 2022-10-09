Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E34B5F8D3E
	for <lists+linux-arch@lfdr.de>; Sun,  9 Oct 2022 20:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbiJISh3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 9 Oct 2022 14:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbiJISh1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 9 Oct 2022 14:37:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CCC425C53;
        Sun,  9 Oct 2022 11:37:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A526460C4E;
        Sun,  9 Oct 2022 18:37:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83DC8C433D6;
        Sun,  9 Oct 2022 18:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665340646;
        bh=M0mi6LfeSn8FwBMP19KWbu57PYG5br5TQcEO1ena5k0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pSA3vwpcaowqE4AZasllzneNUD3fOtths/0Gjy3og9D25SOeCcssgw4Vflzq3yhdw
         C+yLMRl1hKGas6R4ijMMJd1ScRykqtmn4h4KWe35FkSe0R3A5mkn5BU5/i5iuYMMRQ
         lfpGpkHcFR65TO9JqT5ZyCM09kpaU4jU7u0nmwms1ciF6D3nFu54HHOJ8HUn9SreXo
         rfg72LR62xM7zPDMygve/JFAQpzyTsSuELt17w8MGejp6qmwFOD9iS1xf7Cpkc+7TS
         ka+EAs/cQWfv6AaLl3wEE2+RDV264Qx4pws4qSGEjTP+2wRdWqD8gPyXK2+PXk9kFM
         sjEeY/lM1feJg==
From:   SeongJae Park <sj@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     SeongJae Park <sj@kernel.org>, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] docs/memory-barriers.txt: Add a missed closing parenthesis
Date:   Sun,  9 Oct 2022 18:37:23 +0000
Message-Id: <20221009183723.52037-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221009111000.GQ4196@paulmck-ThinkPad-P17-Gen-1>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Paul,

On Sun, 9 Oct 2022 04:10:00 -0700 "Paul E. McKenney" <paulmck@kernel.org> wrote:

> On Sat, Oct 08, 2022 at 10:49:25AM -0700, SeongJae Park wrote:
> > Description of io_stop_wc(), which added by commit d5624bb29f49
> > ("asm-generic: introduce io_stop_wc() and add implementation for
> > ARM64"), have unclosed parenthesis.  This commit closes it.
> > 
> > Fixes: d5624bb29f49 ("asm-generic: introduce io_stop_wc() and add implementation for ARM64")
> > Signed-off-by: SeongJae Park <sj@kernel.org>
> 
> I have pulled this in, good eyes, and thank you!

Thank you for quick reply :)

> 
> On the other three, we have traditionally asked for an ack from a
> Korean speaker.  Do we still feel the need to do this?

I have asked review of the patches to my friend.  I'm unsure if my friend could
do that in a timely manner, as my friend could also be busy.  Let's wait and
see.

IMHO, such review is not essential for this kind of incremental document
updates, as I'd prefer making the doc up-to-date even if it contains some
trivial errors, as long as the history is well manged and therefore such errors
could be fixed later with good explanations.


Thanks,
SJ

[...]
