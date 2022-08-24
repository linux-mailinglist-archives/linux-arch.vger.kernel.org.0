Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02305A0394
	for <lists+linux-arch@lfdr.de>; Thu, 25 Aug 2022 00:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239989AbiHXWCg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Aug 2022 18:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbiHXWCf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Aug 2022 18:02:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F61875CC3;
        Wed, 24 Aug 2022 15:02:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC6E561920;
        Wed, 24 Aug 2022 22:02:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F56CC433C1;
        Wed, 24 Aug 2022 22:02:32 +0000 (UTC)
Date:   Wed, 24 Aug 2022 23:02:36 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: strlcpy() notes (was Re: [GIT PULL] smb3 client fixes)
Message-ID: <Ywaf/CWYzmPx1lxa@arm.com>
References: <CAH2r5mtDFpaAWeGCtrfm_WPM6j-Gkt_O80=nKfp6y39aXaBr6w@mail.gmail.com>
 <CAHk-=wi+xbVq++uqW9YgWpHjyBHNB8a-xad+Xp23-B+eodLCEA@mail.gmail.com>
 <YwSWLH4Wp6yDMeKf@arm.com>
 <CAHk-=whU7QiwWeO81Rf+KGh0rGS9CEfKUXc5eik+Z0GaVJgu4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whU7QiwWeO81Rf+KGh0rGS9CEfKUXc5eik+Z0GaVJgu4A@mail.gmail.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 23, 2022 at 10:37:38AM -0700, Linus Torvalds wrote:
> On Tue, Aug 23, 2022 at 1:56 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > With load_unaligned_zeropad(), the arm64 implementation disables tag
> > checking temporarily. We could do the same with read_word_at_a_time()
> > (there is a kasan_check_read() in this function but it wrongly uses a
> > size of 1).
> 
> The "size of 1" is not wrong, it's intentional, exactly because people
> do things like
> 
>     strscpy(dst, "string", sizeof(dst));
> 
> which is a bit unfortunate, but very understandable and intended to
> work. So that thing may over-read the string by up to a word. And
> KASAN ends up being unhappy.

Good point. We could attempt a single-byte checked read on arm64 as well
and then disable tag checking (the arm64 load_unaligned_zeropad()
doesn't bother with this).

For KASAN, if we want to be more precise, we could move the
kasan_check_read() (or add a new one) in the strscpy() implementation
that actually takes into account how much was copied (non-zero bytes).
Not sure it's worth it though. The check would be post-read though.

-- 
Catalin
