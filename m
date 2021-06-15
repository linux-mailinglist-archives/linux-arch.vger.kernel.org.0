Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 710EC3A7FBA
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jun 2021 15:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbhFONbg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Jun 2021 09:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbhFONbO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Jun 2021 09:31:14 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB1EC061280;
        Tue, 15 Jun 2021 06:29:09 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id g142so20483590ybf.9;
        Tue, 15 Jun 2021 06:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uvjvHvAC/emezf1TT8TfW7bzk39CSLbZo6cMbFR9jDI=;
        b=mVr3XPLyY1LqPXdMCn+rHB4K8fx6/BnrIVCx2eaNBm8ttnquM5GKIKMDL8I4L1+DGZ
         nE/4JYSDg5sNcbsUiX3jbBg+7BjhVuX0Twjc3ZP4bRZs7AB/dLiE7LcKQuC8Af5eKh+Z
         5u2Q0RmpcAG7Ol0Ih7HWYOsCohHR3JwtfF71oNU2Sq/EW3PvvtOQVGcwlHhUzkeV2d0E
         r27zrbmgCIVajOI8HXEQSXeKgtDaZfW4qtYhe2S/sVDDvEGwqIMNAFy4CbJrywaG3tVs
         iUbJrFcERWaSjyDGYzSQ9y8s2Jjsh9pAKDj17sLmwMJJdFQRrfw2W3AFmMCudsZ0+hFb
         P5Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uvjvHvAC/emezf1TT8TfW7bzk39CSLbZo6cMbFR9jDI=;
        b=m6u/HEoarnF83toNKkwh6Lv+r/oQyAps9fH+KNOvvl0jjoNTPEunRmxYBCm2H05huP
         pA9djm1XtkSFTjVONkXkc7F+9PZjchqxjW7g7dB9kGX/btHnx1MlN4TyKnhsAtqvvZAF
         b6435dubz4KyGwfnAfSVRdrXJKZMy1ZeMcFB76WQCC3aHrvnTZTn4+b2p9vdwXOn9Z9y
         PAfxLzB5/i+H7vBs81bdXb9LXOFeROGb9LRk7TsCi6ajRsWwP8FTIgUMwtRHLNYSrkE3
         3rPeqidLpFPuaeohjWf6UFowU2xIOJ8+juis6uG32Rst0iw45MtkjO+xqY8Q5VL/m0l2
         Px2g==
X-Gm-Message-State: AOAM531II8m1PdCH8jrSnjhqM1Hip7vGMItGBoQemGY+lfFIXkNVZmhS
        cczeNtdSfyt5kaTG907F+UuU4loWVyI1ZHbhBtdRLFOgEsQ=
X-Google-Smtp-Source: ABdhPJyyKHVrbq5KlrhfgrkkDasvvPgFn72PU15jH6AkKfoZVVyCAspKXNCIcJy7sG/A62WQlhBQF10CHMnzLvFUJWI=
X-Received: by 2002:a25:389:: with SMTP id 131mr33218309ybd.306.1623763748567;
 Tue, 15 Jun 2021 06:29:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210615023812.50885-1-mcroce@linux.microsoft.com>
 <20210615023812.50885-2-mcroce@linux.microsoft.com> <6cff2a895db94e6fadd4ddffb8906a73@AcuMS.aculab.com>
 <CAEUhbmV+Vi0Ssyzq1B2RTkbjMpE21xjdj2MSKdLydgW6WuCKtA@mail.gmail.com> <1632006872b04c64be828fa0c4e4eae0@AcuMS.aculab.com>
In-Reply-To: <1632006872b04c64be828fa0c4e4eae0@AcuMS.aculab.com>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Tue, 15 Jun 2021 21:28:57 +0800
Message-ID: <CAEUhbmU0cPkawmFfDd_sPQnc9V-cfYd32BCQo4Cis3uBKZDpXw@mail.gmail.com>
Subject: Re: [PATCH 1/3] riscv: optimized memcpy
To:     David Laight <David.Laight@aculab.com>, Gary Guo <gary@garyguo.net>
Cc:     Matteo Croce <mcroce@linux.microsoft.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Akira Tsukamoto <akira.tsukamoto@gmail.com>,
        Drew Fustini <drew@beagleboard.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 15, 2021 at 9:18 PM David Laight <David.Laight@aculab.com> wrote:
>
> From: Bin Meng
> > Sent: 15 June 2021 14:09
> >
> > On Tue, Jun 15, 2021 at 4:57 PM David Laight <David.Laight@aculab.com> wrote:
> > >
> ...
> > > I'm surprised that the C loop:
> > >
> > > > +             for (; count >= bytes_long; count -= bytes_long)
> > > > +                     *d.ulong++ = *s.ulong++;
> > >
> > > ends up being faster than the ASM 'read lots' - 'write lots' loop.
> >
> > I believe that's because the assembly version has some unaligned
> > access cases, which end up being trap-n-emulated in the OpenSBI
> > firmware, and that is a big overhead.
>
> Ah, that would make sense since the asm user copy code
> was broken for misaligned copies.
> I suspect memcpy() was broken the same way.
>

Yes, Gary Guo sent one patch long time ago against the broken assembly
version, but that patch was still not applied as of today.
https://patchwork.kernel.org/project/linux-riscv/patch/20210216225555.4976-1-gary@garyguo.net/

I suggest Matteo re-test using Gary's version.

> I'm surprised IP_NET_ALIGN isn't set to 2 to try to
> avoid all these misaligned copies in the network stack.
> Although avoiding 8n+4 aligned data is rather harder.
>
> Misaligned copies are just best avoided - really even on x86.
> The 'real fun' is when the access crosses TLB boundaries.

Regards,
Bin
