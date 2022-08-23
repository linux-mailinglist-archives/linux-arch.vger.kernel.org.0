Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA5259DC48
	for <lists+linux-arch@lfdr.de>; Tue, 23 Aug 2022 14:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352582AbiHWKMh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 Aug 2022 06:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353260AbiHWKLI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Aug 2022 06:11:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8E87E829;
        Tue, 23 Aug 2022 01:56:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0507B81C28;
        Tue, 23 Aug 2022 08:56:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8700C433D7;
        Tue, 23 Aug 2022 08:56:12 +0000 (UTC)
Date:   Tue, 23 Aug 2022 09:56:12 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: strlcpy() notes (was Re: [GIT PULL] smb3 client fixes)
Message-ID: <YwSWLH4Wp6yDMeKf@arm.com>
References: <CAH2r5mtDFpaAWeGCtrfm_WPM6j-Gkt_O80=nKfp6y39aXaBr6w@mail.gmail.com>
 <CAHk-=wi+xbVq++uqW9YgWpHjyBHNB8a-xad+Xp23-B+eodLCEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi+xbVq++uqW9YgWpHjyBHNB8a-xad+Xp23-B+eodLCEA@mail.gmail.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Aug 21, 2022 at 11:13:28AM -0700, Linus Torvalds wrote:
> It's also worth pointing out that the kernel implementation of
> 'strscpy()' will not do the chunk-sized accesses across an unaligned
> page boundary. So it won't actually take a page fault past the
> terminating NUL character, but if you pass it an 'N' that is bigger
> than the source buffer, and you have sub-page faults in the kernel, we
> might need to do some further work in this are. Catalin?

We can probably hit sub-page faults if the function reads past the end
of a string. Strange that we haven't hit any so far (well, it needs
KASAN_HW_TAGS enabled, it doesn't get as much coverage).

With load_unaligned_zeropad(), the arm64 implementation disables tag
checking temporarily. We could do the same with read_word_at_a_time()
(there is a kasan_check_read() in this function but it wrongly uses a
size of 1).

I'll send a patch but most likely next week (I'm still on holiday).

-- 
Catalin
