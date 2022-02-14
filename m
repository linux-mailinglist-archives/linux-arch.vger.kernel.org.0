Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B894B55F6
	for <lists+linux-arch@lfdr.de>; Mon, 14 Feb 2022 17:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233555AbiBNQUh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Feb 2022 11:20:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241001AbiBNQUh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Feb 2022 11:20:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42B34DF73;
        Mon, 14 Feb 2022 08:20:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62DBF614BA;
        Mon, 14 Feb 2022 16:20:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6933C340F6;
        Mon, 14 Feb 2022 16:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644855628;
        bh=0diHmmQT77HOp7spZ5bl7kXENb4/oqBcrfTkEBf0+KE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ltnHtQW8UODVcbRMxfeH0pjfsB6mZbvTWWp0n7uBuix6juCh0Dt0mG4fJgneXn6ds
         77tKZK1oEZvOOmrVURM5yLRhobYSeQPo5wq96H1tG4B1571TaxHXSZ0d8F2H1sByUw
         RqLQc83ug3nKZXLFI3YoHS4PA/VDGtc7OKardneIRkHN5nmYjb2X+6URwyKsyFQa5a
         crNzw9+0hV9u9bJOtQjlyTjzmniJgUNwxR5H0fLaqgMXQ29EIccEYyw+MBI/91Qdnm
         P/DqXod7LbLQk+vzwufsUfX70l3T1TbBpgs/eYwZy9Hbw2E8vXRN4RL8RlUhhQ3/PE
         le+orCl5zwOLA==
Received: by mail-wm1-f51.google.com with SMTP id bg19-20020a05600c3c9300b0034565e837b6so167157wmb.1;
        Mon, 14 Feb 2022 08:20:28 -0800 (PST)
X-Gm-Message-State: AOAM531pGuwcK+uBOrzklt8WDW/pwjT69zZUw3i3vEDZ0TN/AK5ObHrq
        snuovgCjCev0zsgbf7q5/DhrspVb1xuF60sQceY=
X-Google-Smtp-Source: ABdhPJyENkLzu+Qtrc7oNRQvqGS80bfLRIWmUVIZL+pKQ64wDWBb3eizCDmR6JXlU3zwQSpe/2+UZg/mJM5QYn92Gj0=
X-Received: by 2002:a05:600c:19c7:: with SMTP id u7mr9492360wmq.82.1644855626961;
 Mon, 14 Feb 2022 08:20:26 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a0eAv168eepvdZQbYDstTQHc-Hb2_PMS3bseV3caB4oAA@mail.gmail.com>
 <YgoJvSFFTSb6apGl@infradead.org>
In-Reply-To: <YgoJvSFFTSb6apGl@infradead.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 14 Feb 2022 17:20:10 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3WC3dWdXNQPaU4J0EyhUZ6hmvCzO14HdUAQyq5j3s4ww@mail.gmail.com>
Message-ID: <CAK8P3a3WC3dWdXNQPaU4J0EyhUZ6hmvCzO14HdUAQyq5j3s4ww@mail.gmail.com>
Subject: Re: [PATCH] microblaze: remove CONFIG_SET_FS
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Stafford Horne <shorne@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 14, 2022 at 8:50 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> I like the series a lot.
>
> Superficial comments:
>
> for nds32 is there any good reason why __get_user / __set_user check
> the address limit directly?  Maybe we should unify this and make it work
> like the other architectures.

I've done that now, and am glad I did, because I uncovered that
put_user() was actually missing the check that got added to __get_user()
by accident.

> With "uaccess: add generic __{get,put}_kernel_nofault" we should be able
> to remove HAVE_GET_KERNEL_NOFAULT entirely and just check if the helpers
> are already defined in linux/uaccess.h.

Good idea, changed now as well.

> The new generic __access_ok, and the 3 fixed up version early on
> have a whole lot of superflous braces.

I'd prefer to leave those in, the logic is complex enough that I'd
rather make sure this is completely obvious to readers.

I got a few built bot reports about missing __user annotations that were
uncovered by the added type checking in access_ok, fixed those
as well.

I'm doing another test build after the last changes, will send it out in a bit
if there are no further regressions.

        Arnd
