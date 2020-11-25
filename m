Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE732C4273
	for <lists+linux-arch@lfdr.de>; Wed, 25 Nov 2020 15:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbgKYOv2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 25 Nov 2020 09:51:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:43904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgKYOv2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 25 Nov 2020 09:51:28 -0500
Received: from linux-8ccs (p57a232c3.dip0.t-ipconnect.de [87.162.50.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F88F206B5;
        Wed, 25 Nov 2020 14:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606315887;
        bh=N/IosfIbGitpjFvIvBGjanWy43jAdZYMsZ1O1iGVCqs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VuobexrSYNEaJHUs9u8B/SEUrsMEqYnTPlfO+3DgAS7ih1zUglusNmcgifq8bDMyV
         QBlrqLdOO3ztt3E3e0qdvNNZSRe3EVocsttsim8BK4KBLlRz+Zr/oWXp0D169urNyg
         mGDDK+JjsM7HTSxR2N98YJK6Mx0A1w8OV/wAYlL8=
Date:   Wed, 25 Nov 2020 15:51:20 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        David Miller <davem@davemloft.net>,
        Jakub Jelinek <jakub@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Kurtz <djkurtz@chromium.org>,
        linux-arch@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Subject: Re: [PATCH 0/8] linker-section array fix and clean ups
Message-ID: <20201125145118.GA32446@linux-8ccs>
References: <20201103175711.10731-1-johan@kernel.org>
 <20201106160344.GA12184@linux-8ccs.fritz.box>
 <20201106164537.GD4085@localhost>
 <20201111154716.GB5304@linux-8ccs>
 <X66VvI/M4GRDbiWM@localhost>
 <X7uRZUY+2L9Yg9wt@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <X7uRZUY+2L9Yg9wt@localhost>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

+++ Johan Hovold [23/11/20 11:39 +0100]:
>On Fri, Nov 13, 2020 at 03:18:36PM +0100, Johan Hovold wrote:
>> On Wed, Nov 11, 2020 at 04:47:16PM +0100, Jessica Yu wrote:
>>
>> > Thanks for providing the links and references. Your explanation and
>> > this reply from Jakub [1] clarified things for me. I was not aware of
>> > the distinction gcc made between aligned attributes on types vs. on
>> > variables. So from what I understand now, gcc suppresses the
>> > optimization when the alignment is specified in the variable
>> > declaration, but not necessarily when the aligned attribute is just on
>> > the type.
>> >
>> > Even though it's been in use for a long time, I think it would be
>> > really helpful if this gcc quirk was explained just a bit more in the
>> > patch changelogs, especially since this is undocumented behavior.
>> > I found the explanation in [1] (as well as in your cover letter) to be
>> > sufficient. Maybe something like "GCC suppresses any optimizations
>> > increasing alignment when the alignment is specified in the variable
>> > declaration, as opposed to just on the type definition. Therefore,
>> > explicitly specify type alignment when declaring entries to prevent
>> > gcc from increasing alignment."
>>
>> Sure, I can try to expand the commit messages a bit.
>
>I've amended the commit messages of the relevant patches to make it more
>clear that the optimisation can be suppressed by specifying alignment
>when declaring variables, but without making additional claims about the
>type attribute. I hope the result is acceptable to you.
>
>Perhaps you can include a lore link to the patches when applying so that
>this thread can be found easily if needed.

Hi Johan,

Good idea, I've included a link to this thread for each patch.
I've queued up patches 3, 4, 6, 7, 8 for testing before pushing them
out to modules-next.

Thanks!

Jessica
