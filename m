Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C242314728C
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jan 2020 21:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbgAWU0K (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Jan 2020 15:26:10 -0500
Received: from mail.skyhub.de ([5.9.137.197]:40984 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbgAWU0K (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 23 Jan 2020 15:26:10 -0500
Received: from zn.tnic (p200300EC2F095B007058F63913B24194.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:5b00:7058:f639:13b2:4194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 35E531EC027A;
        Thu, 23 Jan 2020 21:26:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1579811169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=9e5q8s9ezZPm2KWvMrhW3LKKbMdfqiNQymQ7YnxMmWo=;
        b=ZnC+lvNP0ACUTWtquqJY+aMTN6/TEgm/fOSYTydwRQwKF7AM+1Av6CH7QQ6JUiLzNb1BGa
        mdfx/BsGGUILqni3j84UPY9fTwsLwTJ4igYQnPmRE/qqQ1yRHLKX/SBd+VZKHIx3YGR/AC
        EqXGtTB022GNbL6Hjb8InvyOGnY+te0=
Date:   Thu, 23 Jan 2020 21:26:00 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Guan Xuetao <gxt@pku.edu.cn>
Subject: Re: [PATCH 0/5] x86: finish the MPX removal process
Message-ID: <20200123202600.GG10328@zn.tnic>
References: <20200123190456.8E05ADE6@viggo.jf.intel.com>
 <CAHk-=wgLR5JnaBgCtg0-AAxtdN3=4=LMp6-0212608=vbmCAxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgLR5JnaBgCtg0-AAxtdN3=4=LMp6-0212608=vbmCAxg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 23, 2020 at 11:26:38AM -0800, Linus Torvalds wrote:
> On Thu, Jan 23, 2020 at 11:23 AM Dave Hansen
> <dave.hansen@linux.intel.com> wrote:
> >
> > I'd _rather_ this go in via the x86 tree, but I'm not picky.

Any particular reason why?

I mean, I don't care a whole lot either - I just don't see the point,
see below.

> I have no strong feelings either way. I'll happily pull this tree for
> the 5.6 merge window directly from you, or get it as part of one of
> the x86 -tip pull requests.
> 
> Up to you and the -tip maintainers, really. Thomas/Ingo/Borislav?

My reasoning to suggest to go directly to you is that there's
practically not a whole lotta sense to add a separate branch to tip,
merge Dave's tree and have a merge commit of the mpx branch only which
you then merge into your master.

Or I can apply each patch separately and then send you that branch so
that there's no pointless merge commit in the history before you merge
it but we get the same if you merge Dave's branch directly...

Oh and btw: I ran a bunch of build smoke tests today of the mpx removal
branch with tip/master merged in and except for a trivial include fix,
there were no issues.

But if someone points out a valid argument why it should go through tip,
I'll gladly do it.

Thx guys.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
