Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E2B4E239B
	for <lists+linux-arch@lfdr.de>; Mon, 21 Mar 2022 10:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343533AbiCUJtf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Mar 2022 05:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345420AbiCUJtd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Mar 2022 05:49:33 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127D92BF9
        for <linux-arch@vger.kernel.org>; Mon, 21 Mar 2022 02:48:06 -0700 (PDT)
Received: from mail-wr1-f49.google.com ([209.85.221.49]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N3sRi-1oEKov1NR2-00znun for <linux-arch@vger.kernel.org>; Mon, 21 Mar
 2022 10:48:05 +0100
Received: by mail-wr1-f49.google.com with SMTP id p9so19820556wra.12;
        Mon, 21 Mar 2022 02:48:05 -0700 (PDT)
X-Gm-Message-State: AOAM533yupXPAWH0ngzUsh4f+vj2wbbz0wR6UdCxMlaRIQN0eALLWP3R
        z+LAKAZS7OKtmu2e2q0TnmxY96yD2ozbBl5INF8=
X-Google-Smtp-Source: ABdhPJwXz+ToNHL4TpOoh+HdlcxuOPou7dXTvfzP0iFHuBYr3vtjBj/zXXognFOzrqzkSJ6ZJ2iZfEfVsapaC/m5OFY=
X-Received: by 2002:adf:d081:0:b0:1ef:9378:b7cc with SMTP id
 y1-20020adfd081000000b001ef9378b7ccmr17934085wrh.407.1647856084986; Mon, 21
 Mar 2022 02:48:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220319142759.1026237-1-chenhuacai@loongson.cn>
 <20220319143817.1026708-1-chenhuacai@loongson.cn> <20220319143817.1026708-6-chenhuacai@loongson.cn>
 <CAK8P3a2kroHVN3fTabuFVMz08SXytz-SC8X11BxxszsUCksJ4g@mail.gmail.com> <CAAhV-H6zE7p6Tq8rg1Fq5cK5L38z-VHjxsZ+qm8+Cp5x=u_bUQ@mail.gmail.com>
In-Reply-To: <CAAhV-H6zE7p6Tq8rg1Fq5cK5L38z-VHjxsZ+qm8+Cp5x=u_bUQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 21 Mar 2022 10:47:49 +0100
X-Gmail-Original-Message-ID: <CAK8P3a38nUyAt8gGEYregqivdP7NsXS0RuU1NX4_EAVvwGQBWA@mail.gmail.com>
Message-ID: <CAK8P3a38nUyAt8gGEYregqivdP7NsXS0RuU1NX4_EAVvwGQBWA@mail.gmail.com>
Subject: Re: [PATCH V8 13/22] LoongArch: Add system call support
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:N/tE4lL/H/yyEAycNERWNTSI0BOiXfvH7d85Ael9bEHajHyRbyv
 TjMiaM0LdSt0kfbH4J80j5SIKwofgWPegSY4RC9Oekp39F+3HMbE9L7u6cINLYlFvzabzJj
 biTfD+xwULv8H8+iNaK/+VXb71JfoxlgmLbWPAaXjHgfuEXuk2GnofWFpRgHlDsK++m4JqR
 k5bNWXisTn3QRU7ndz2uA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Tk4MELvBfG0=:Ae0yRRa6PpVoQ468AdT2aE
 +Y+Aq+8qda1hPf8YNXoxeIyrKvpfy3L4CKndYtFY34lMkV9pccG7H6thZze6oAa2NMyxDI983
 fPgSRmx5n86TRKqBkJw+kYKEghaTzpPI4aX68Tgig/HUzU5Hf5K4qCpyLCW2vE+Z4qRtYUI7S
 DNpkM/NZupawjLejJQt4tBYTCupt7pd9oL3ISsPEgRC195trcrpysD15Re0EruaAJuB/H8t63
 2EwffdgWJVC5Enp2c5xBsXvvnnpJw1/Z37CxfhgEXI76XvdQcxHoqAnbhqCiSWdAeyjUwVY6o
 SULXhSioue3Ci/W7oNDQjGzY0N/E5WlAPXpQNma99UGIJA9dScTqO7PFy366+56EpVc82ij7E
 e7jOjY+RQ4PkOA6xNQBd7Vp4/atbyXfKvDo4RkCtDRkWeSbU0WGXc5VCkf164N5fZxE7jUP/j
 VWXm3eCG889LRtbH+Q5wBfmYT7ixrNJWWS1mB96ImMlNGgdXDpGh9pTej5BCSE/XsU929SRxc
 lep65bsyYDV5Sd5OB3XQmeYCdvKUA02anUTcf7bL+zasLqL1ixnmAy2M4pqXKSOc0Pl4ORmpE
 6q6Naj/ckGcykpQK0YubaXDIC6Y4ew1EzCVBM6IhQd4GDHkXzjRWiaS+fuwWupvCWWmkXk73S
 Ej5RavedRDwPbKt3GpOBdRQJP51WiYE0laTpHyb6GsI5EFr9JzTapZ0/dYAxLcVoSK0g9PEuM
 B8E6KuHnsqzPYLEFXrKXpexwrLmGyS9eYo/QdQVT+XmvT5hWdVzyZ2aKCvEq2JBPuY5RVAHSs
 jRGPuiF5xH7p40J141VT2kkyvlyasRZqtNI2R6lh/xVInkv+uE=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Mar 21, 2022 at 10:41 AM Huacai Chen <chenhuacai@kernel.org> wrote:
> On Mon, Mar 21, 2022 at 5:01 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Sat, Mar 19, 2022 at 3:38 PM Huacai Chen <chenhuacai@kernel.org> wrote:
> > >
> > > This patch adds system call support and related uaccess.h for LoongArch.
> > >
> > > Q: Why keep __ARCH_WANT_NEW_STAT definition while there is statx:
> > > A: Until the latest glibc release (2.34), statx is only used for 32-bit
> > >    platforms, or 64-bit platforms with 32-bit timestamp. I.e., Most 64-
> > >    bit platforms still use newstat now.
> > >
> > > Q: Why keep _ARCH_WANT_SYS_CLONE definition while there is clone3:
> > > A: The latest glibc release (2.34) has some basic support for clone3 but
> > >    it isn't complete. E.g., pthread_create() and spawni() have converted
> > >    to use clone3 but fork() will still use clone. Moreover, some seccomp
> > >    related applications can still not work perfectly with clone3.
> >
> > Please leave those out of the mainline kernel support though: Any users
> > of existing glibc binaries can keep using patched kernels for the moment,
> > and then later drop those pages when the proper glibc support gets
> > merged.
> The glibc commit d8ea0d0168b190bdf138a20358293c939509367f ("Add an
> internal wrapper for clone, clone2 and clone3") modified nearly
> everything in order to move to clone3(), except arch_fork() which used
> by fork(). And I cannot find any submitted patches to solve it. So I
> don't think this is just a forget, maybe there are other fundamental
> problems?

I don't think there are fundamental issues, they probably did not consider
it necessary because so far all architectures supported clone().

Adding Christian Brauner and H.J. Lu for clarificatoin.

> > > +#define __get_user(x, ptr) \
> > > +({                                                                     \
> > > +       int __gu_err = 0;                                               \
> > > +                                                                       \
> > > +       __chk_user_ptr(ptr);                                            \
> > > +       __get_user_common((x), sizeof(*(ptr)), ptr);                    \
> > > +       __gu_err;                                                       \
> > > +})
> >
> > It would be good to also provide a
> > __kernel_kernel_nofault()/__put_kernel_nofault()
> > implementation, as the default based on __get_user()/__put_user is not
> > ideal.
> They are provided in this file below.

Ok, I see them now, not sure what I did wrong when I looked earlier.

        Arnd
