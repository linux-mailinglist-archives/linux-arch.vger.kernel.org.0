Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5EB8207079
	for <lists+linux-arch@lfdr.de>; Wed, 24 Jun 2020 11:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389913AbgFXJy7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jun 2020 05:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389015AbgFXJy7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Jun 2020 05:54:59 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C17C061573;
        Wed, 24 Jun 2020 02:54:58 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id m21so1013453eds.13;
        Wed, 24 Jun 2020 02:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=6H5qYMtCo3j532h08vTJqyu1KgDHrrx/sdBMuWK8E0g=;
        b=QVSPGU6LdTKLEEu9/AxrE5nzTi2DV0DstmSWFHmZrZOOeJYfej2noNVmD9cnkAOUGo
         c3IoEdxG2aIo/XyIqjib7efVM4LNVdWD6BqKWjFrfirLjMt2SEF2H3tQrEVvDlZ//+k9
         iktDGAAcMdAMs76SmmBfjCB63O06Sk76AWeo9sG7QCT7kN31BbArk/ijsvuf4z3x2nq2
         cPXiWKai0219BCuFv0SpjYATjNBZyVBdpyvfXsvSkUxtjaXYHGhE6tj2A59SjuvWJB7X
         7re1ze37vzMd7677WDykNQFNsFmpqfpOcxckiiNknDawyooA+wGkImUaQ/mwpBbNr18j
         AdjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=6H5qYMtCo3j532h08vTJqyu1KgDHrrx/sdBMuWK8E0g=;
        b=OLXXO1FaosuPMXVr2mohK03UumYTnSrA8i4kkuMwTGJJYLmejbDlb27Hbq1l6xem5I
         XqT3xO8F9KtnyrjWsWzQ6YJIrddSlDJL1ksjnZ7lKhfCBOipt9ZW4/z4dl4R7hgnTzdg
         9pG24dWrtRGwqdzeDS4TpF4BbGr6sCKp7GUHXpLrrqocGFj0y8a2c8tza+plyEfwtQN0
         4hqYarGBazav2YJ34DIJD44rTGNFk09T1xkYENoIo8E6HYEzMK1H2bWe6tkqgE+6mPw6
         Sxr39pfrVRkGKN6KuC9DYJHOlvvTPp2LFoPvoxSTzLx8xXIw4KSPbwQFIspW6XqNFeIb
         iLfw==
X-Gm-Message-State: AOAM531v+wH1JlRYtzaPey8H0+5c28Fo0jEzEw3on+109L+A6pD0tHjm
        cHPSHUAIy82iHHFvn68cT42uqtEtEwikx845o0fl+g==
X-Google-Smtp-Source: ABdhPJyJoip/kxANYNh48iyyon/dnoEekTGf1XavrA56sqyiYNH85iGl3VDvze8hxcPKC9asvovZ82zDsn9pIgm0Tk8=
X-Received: by 2002:a05:6402:3048:: with SMTP id bu8mr2554110edb.367.1592992496294;
 Wed, 24 Jun 2020 02:54:56 -0700 (PDT)
MIME-Version: 1.0
References: <1590614258-24728-1-git-send-email-Dave.Martin@arm.com>
 <1590614258-24728-7-git-send-email-Dave.Martin@arm.com> <20200609172232.GA63286@C02TF0J2HF1T.local>
 <20200610100641.GF25945@arm.com> <20200610152634.GJ26099@gaia>
 <20200610164209.GH25945@arm.com> <20200610174205.GL26099@gaia> <20200615145115.GL25945@arm.com>
In-Reply-To: <20200615145115.GL25945@arm.com>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Wed, 24 Jun 2020 11:54:45 +0200
Message-ID: <CAKgNAkgnH7f4bNiF8q-GOY_xz1x9gYnDjMTw=vpR7ONxoL=cdw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 6/6] prctl.2: Add tagged address ABI control prctls (arm64)
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-man <linux-man@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Dave

Is there a plan for future work on this patch?

Thanks,

Michael

On Mon, 15 Jun 2020 at 16:51, Dave Martin <Dave.Martin@arm.com> wrote:
>
> On Wed, Jun 10, 2020 at 06:42:05PM +0100, Catalin Marinas wrote:
> > On Wed, Jun 10, 2020 at 05:42:09PM +0100, Dave P Martin wrote:
> > > On Wed, Jun 10, 2020 at 04:26:34PM +0100, Catalin Marinas wrote:
> > > > On Wed, Jun 10, 2020 at 11:06:42AM +0100, Dave P Martin wrote:
> > > > > On Tue, Jun 09, 2020 at 06:22:32PM +0100, Catalin Marinas wrote:
> > > > > > On Wed, May 27, 2020 at 10:17:38PM +0100, Dave P Martin wrote:
> > > > > > > +.IP
> > > > > > > +The level of support is selected by
> > > > > > > +.IR "(unsigned int) arg2" ,
> > > > > >
> > > > > > We use (unsigned long) for arg2.
> > > > >
> > > > > Hmmm, not quite sure how I came up with unsigned int here.  I'll just
> > > > > drop this: the type in the prctl() prototype is unsigned long anyway.
> > > > >
> > > > > The type is actually moot in this case, since the valid values all fit
> > > > > in an unsigned int.
> > > >
> > > > Passing an int doesn't require that the top 32-bit of the long are
> > > > zeroed (in case anyone writes the low-level SVC by hand).
> > >
> > > Fair point, I was forgetting that wrinkle.  Anyway, the convention in
> > > this page seems to be that if the type is unsigned long, we don't
> > > mention it, because the prctl() prototype says that already.
> > >
> > > Question: the glibc prototype for prctl is variadic, so surely any
> > > calls that don't explicitly cast the args to unsigned long are already
> > > theoretically broken?  The #defines (and 0) are all implicitly int.
> > > This probably affects lots of prctls.
> > >
> > > We may get away with it because the compiler is almost certainly going
> > > to favour a mov over a ldr for getting small integers into regs, and mov
> > > <Wd> fortunately zeroes the top bits for us anyway.
> >
> > So does LDR Wd.
> >
> > Anyway, I think glibc (or my reading of it) has something like like:
> >
> >   register long _x1 asm ("x1") = _x1tmp;
> >
> > before invoking the SVC. I assume this would do the right conversion to
> > long. I can't tell about other libraries but I'd say it's their
> > responsibility to convert the args to long before calling the kernel's
> > prctl().
>
> Ignore me.  I was worrying that glibc would propagate junk in the high
> bits of int arguments, due to treating them as longs.  Actually, it
> will, but it doesn't matter where we explicitly cast the argument to int
> inside the kernel (thanks as usual to -fno-strict-overflow).
>
> Cheers
> ---Dave



-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
