Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF3F63C2228
	for <lists+linux-arch@lfdr.de>; Fri,  9 Jul 2021 12:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbhGIKZn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Jul 2021 06:25:43 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:37361 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbhGIKZn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Jul 2021 06:25:43 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MoNyA-1lM8CI4Bi4-00opbI for <linux-arch@vger.kernel.org>; Fri, 09 Jul
 2021 12:22:59 +0200
Received: by mail-wm1-f52.google.com with SMTP id k32so2797397wms.4
        for <linux-arch@vger.kernel.org>; Fri, 09 Jul 2021 03:22:58 -0700 (PDT)
X-Gm-Message-State: AOAM532ydG4Q3B/+vjU+YExlQst2gNeRhysyHzzifVAPFvYTLJmqdqwv
        XpI7OmXaugPtIGB92MisqZv8/yFxqg3/jKb40LU=
X-Google-Smtp-Source: ABdhPJx4+aQtONxzb/Vu+XN+PBRSKSNWdTgF2lV1xLHDemvKvP0JNwHnGaWHG0i0yRayDxCM+dvBzH9IW1j5HJnPCec=
X-Received: by 2002:a1c:c90f:: with SMTP id f15mr10895252wmb.142.1625826178678;
 Fri, 09 Jul 2021 03:22:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-11-chenhuacai@loongson.cn> <CAK8P3a0zkiFrn9K14Hg8C-rfCk-GbyTGMnq_DFBd8o28q99tRg@mail.gmail.com>
 <CAAhV-H4WtGqgYF_zDhaS9+Ja7k=Zs8O2qWo5GqHDDf5cKw-zow@mail.gmail.com>
 <CAK8P3a1GQ=P-kNB5+wUkyqV0uD11uHCJZSQ7gbkwjev0GhuJTQ@mail.gmail.com> <CAAhV-H4Yqo090vmy0Y7hGzguP9Q_C+EuZvsq7D43dA=J0f_1qA@mail.gmail.com>
In-Reply-To: <CAAhV-H4Yqo090vmy0Y7hGzguP9Q_C+EuZvsq7D43dA=J0f_1qA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 9 Jul 2021 12:22:42 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0QYcKaCSt9gfvDxDYOhBywihba+wWozspzytssmkx3tw@mail.gmail.com>
Message-ID: <CAK8P3a0QYcKaCSt9gfvDxDYOhBywihba+wWozspzytssmkx3tw@mail.gmail.com>
Subject: Re: [PATCH 10/19] LoongArch: Add signal handling support
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     yili0568@gmail.com, Huacai Chen <chenhuacai@loongson.cn>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:2BoSbUTSHsntT+n9pDGMLhHiT9fwFgwJvk8PcIAQH9K2iY2CltM
 wVSs4xreg6ldONT5DzUHMpoVl5O2Q//OvqigORy+MW0Cnw+ew63XuuKAlWpDIDweYXHAFRb
 jFmUOWscaKlzmzLzXPylR9pJSAqsCRuCGATmHfUpJXvGe5bDINC6aamFO+BuvOQnQwqwxfW
 J0/oSylslfDokxQIPWvZA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Hl2XLrbPQp4=:xs6xNyuEkUhBNORLWLz6BE
 ht6KiucUCpj+3qBIUL9lwG+CuY+t+mYpbFPap5+y5UDLjR2sbIRdDCIph1EDhWEKjZWk+38d/
 WFelZpOcvvGVox8eZ24z6BPn0FL5Fiur6AOe0aSBOK9wBaJ6EBEbvo+HdSRvsKPFeLPGXxgKV
 wNod9moy62jBGtyogzpcz3Y4vp5gPg9niCGd85LakgzMd9rveFC7GWDMuW8fupd2gHsMdnmUM
 a7PcRCzsctXU0faCj9K7vl6PUO22faHbSpjlWOgEydByqmjhdqLbKClaejoHcCDcYB3PQqCV6
 4M+1gNlzD/5ohuGQXYqM9DQNsuftde3jx+u3HmH6VrK/SvX5IjvbwL+LhQJ68oTzAdCaxYRqR
 XgsPRsDOLCdqT8BTiudivBbCouVVBmAL7qmDrxjrQ6f3WGLr1Rdux/b+/m0V50KLHFL3eV+IY
 YQzRcJNsYrtE34bLSWsVsKpWfAZhVeSZSw9w2vaibli2swDciqukfexkUJ0bxxIEBPZ7cyuVv
 ChKrQ+aVgIqVE2sxFM+mRnlbJNW0l7bsbmB9n5NT9eaPDeYAgV3jat1LIlYYvRxR+kLcBx8TB
 6184/61tkSFXJJsAdl7XtQqeIqiUn0YP25ALP13BVVGWTbmQLc3q1oCaCVR19deOYovPnIzok
 hg5ll2bPzierAlGX7pSem4O/EO6UUAhfVGOMmS12nod2ZRMyalpKoycratoTdWnueKIOALAr0
 58RcdxKQyABCRXIOuDPJSV4k9JAyX+CS6bhmWA/1E0szpO8Edn1ZOlE+aS67fCLCWXCxBoJO3
 OIhFvOm9V1TnXWbo4TCBosdcar7Q0C8AvaKOXrIEfov5IFC5Ke1nIgs8GgF1GcztCmL/vCu
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 9, 2021 at 11:24 AM Huacai Chen <chenhuacai@gmail.com> wrote:
> On Thu, Jul 8, 2021 at 9:30 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Thu, Jul 8, 2021 at 3:04 PM Huacai Chen <chenhuacai@gmail.com> wrote:
> > > On Tue, Jul 6, 2021 at 6:17 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > On Tue, Jul 6, 2021 at 6:18 AM Huacai Chen <chenhuacai@loongson.cn> wrote:
> > > > > +
> > > > > +#ifndef _NSIG
> > > > > +#define _NSIG          128
> > > > > +#endif
> > > >
> > > > Everything else uses 64 here, except for MIPS.
> > >
> > > Once before we also wanted to use 64, but we also want to use LBT to
> > > execute X86/MIPS/ARM binaries, so we chose the largest value (128).
> > > Some applications, such as sighold02 in LTP, will fail if _NSIG is not
> > > big enough.
> >
> > Have you tried separating the in-kernel _NSIG from the number used
> > in the loongarch ABI? This may require a few changes to architecture
> > independent signal handling code, but I think it would be a cleaner
> > solution, and make it easier to port existing software without having
> > to special-case loongarch along with mips.
>
> Jun Yi (yili0568@gmail.com) is my colleague who develops LBT software,
> he has some questions about how to "separate the in-kernel _NSIG from
> the number used in the LoongArch ABI".

This ties in with how the foreign syscall implementation is done for LBT,
and I don't know what you have today, on that side, since it is not part
of the initial submission.

I think what this means in the end is that any system call that takes
a sigset_t argument will have to behave differently based on the
architecture. At the moment, we have

- compat_old_sigset_t (always 32-bit)
- old_sigset_t (always word size: 32 or 64)
- sigset_t (always 64, except on mips)

The code dealing with old_sigset_t/compat_old_sigset_t shows how
a kernel can deal with having different sigset sizes in user space, but
now we need the same thing for sigset_t as well, if you have a kernel
that needs to deal with both 128-bit and 64-bit masks in user space.

Most such system calls currently go through set_user_sigmask or
set_compat_user_sigmask, which only differ on big-endian.
I would actually like to see these merged together and have a single
helper checking for in_compat_syscall() to decide whether to do
the word-swap for 32-bit bit-endian tasks or not, but that's a separate
discussion (and I suspect that Eric won't like that version, based on
other discussions we've had).

What I think you need for loongarch though is to change
set_user_sigmask(), get_compat_sigset() and similar functions to
behave differently depending on the user space execution context,
converting the 64-bit masks for loongarch/x86/arm64 tasks into
128-bit in-kernel masks, while copying the 128-bit mips masks
as-is. This also requires changing the sigset_t and _NSIG
definitions so you get a 64-bit mask in user space, but a 128-bit
mask in kernel space.

There are multiple ways of achieving this, either by generalizing
the common code, or by providing an architecture specific
implementation to replace it for loongarch only. I think you need to
try out which of those is the most maintainable.

        Arnd
