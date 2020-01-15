Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD18313C5CD
	for <lists+linux-arch@lfdr.de>; Wed, 15 Jan 2020 15:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgAOOWL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Jan 2020 09:22:11 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:59397 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgAOOWL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Jan 2020 09:22:11 -0500
Received: from mail-qk1-f174.google.com ([209.85.222.174]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MGQzj-1isYVr058v-00Gsh0; Wed, 15 Jan 2020 15:22:10 +0100
Received: by mail-qk1-f174.google.com with SMTP id w127so15722566qkb.11;
        Wed, 15 Jan 2020 06:22:09 -0800 (PST)
X-Gm-Message-State: APjAAAXR0i/nw4VXfnZSlejgh4fZ2a2KfRmGN3E0gfmq0ia8/P+hmmF9
        nUgpg7FpHYLLd9n7RfJ6jP2V9rSvBIfoZNJXwig=
X-Google-Smtp-Source: APXvYqxx2a39ERgImZn16gvReU3L59K4NPZ7rVI6r40qbh59bC6C4RPdM9GIKIPaH4dZYMYOAUlFtEAF/+VlIcIk3y8=
X-Received: by 2002:a37:84a:: with SMTP id 71mr26665185qki.138.1579098128765;
 Wed, 15 Jan 2020 06:22:08 -0800 (PST)
MIME-Version: 1.0
References: <20200114200846.29434-1-vgupta@synopsys.com> <20200114200846.29434-2-vgupta@synopsys.com>
 <CAHk-=wjChjfOaDnGygOJpC36R6mtT7=Xf6wWTzD_wLJm=quu0Q@mail.gmail.com>
 <CAK8P3a2ao=xBuy3XHBkdo03KEjpMHGe9ahwj-uogtkZBXsMkGw@mail.gmail.com> <20200115141224.GH8904@ZenIV.linux.org.uk>
In-Reply-To: <20200115141224.GH8904@ZenIV.linux.org.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 15 Jan 2020 15:21:52 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0eu-2ov-Y0EEuv_XSGUTWoyiScf5z5P=kn5S+ORhxF-A@mail.gmail.com>
Message-ID: <CAK8P3a0eu-2ov-Y0EEuv_XSGUTWoyiScf5z5P=kn5S+ORhxF-A@mail.gmail.com>
Subject: Re: [RFC 1/4] asm-generic/uaccess: don't define inline functions if
 noinline lib/* in use
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:lOdPcxVLcqBDEULU954wg+G6L5Re6fTjFN9BhJpfuxlRd4a6lR4
 hSIHFUtdbK3ItxmH/gNZwHTsPniOPTxj8q4g7Sg0TRgVIJ6HXkYStxhPEdlWHRWJx0NTd6E
 OxbYloa5u0vc2cQ6fMPG/0QbTP86Gp5Uos7Lg0pAXCuXVJiKHIMZ3Qg6vGklUWDrQWN2vns
 sBNaMcqUkwpiZFr+TVQyA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:CF8ls0Li9nE=:0MP2x6I/juuYaHyvrvutA8
 koVW/HnYbXl2tpLoFALXNeZfBM5113zZ8Ayl/3ikXDiU/QHlN9J5C5SCxopTPPo6rCXtjZuca
 x8T4cGpQcfaMZZZzCC69/9QnAge+YPkrV+/W6VV9Aw1eReYevymbqxiex9ZpYS4NCB+2Erwed
 f6jpOZ871xncuQ/P8En2WW0rmfMPF5DGO36DlhrCTnnFPm9j6s1E6I7A1Lbv5guEKzT1tHFTJ
 WQksl+GzfN1mJm1pnoYTAFLL986qEAazRPgiNbBnC5vrPxXq3qFpT04ZLHYIkSiixBpjs4e5B
 mv4RwRnFDsS5ttwrri1+T86vzIPkPpD6hgrR/Q4lzJNJ08FR1ATxCmP9qPC2Z2m7RYjUe/MhV
 7/s0ZU7urU6DhTCW+K4nZ3m/y2rWn5cRxFvxiap+gSy2s+Ebo3kkp5h/8ch+q5Tx+oseHxPjZ
 eB1BYo8ZiWiXpRIFQy4dLV1VM5Mzg+6p+XD3qP57OfBPfGu7Qs7Fzi1MWUgqYsw4cCK4Gpdxn
 Kw3jNjW5bUpRqUo/VaoybI+scr5qkj4yWd9KVIPhH7AEfuazB3UjcjlZkjSPCSjvjxcyhK333
 Wa2qeI6A4Q1yUWyTKTk0AeJ81EWpW974NPQ/GvlPcAc9ngeSVqOirIf0b/wT+So7drFt8p5GA
 bxn8mgQoYkMujjGtxtd3+jF+7sai+OMd7U25qSbYiZacNTkjL/yWtz4AOWjD3NmGhve83yENZ
 zOR2K1+0vcO0OodorvBFWrn1RK4aWHHoutumI9F6WcCTxibQBCsxVF9z7RVGs4R7WxRYUsZ9H
 ZsHLQQtCPfUiE/Eth87r5mQBFylEmP78wQ/G1XbvTBnwMpBz6N236SWxlg3NIDdQqyZqzywa3
 ODWOzLDMV5qW2FYUVIqw==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jan 15, 2020 at 3:12 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Wed, Jan 15, 2020 at 10:08:31AM +0100, Arnd Bergmann wrote:
>
> > > I would suggest that anybody who uses asm-generic/uaccess.h needs to
> > > simply use the generic library version.
> >
> > Or possibly just everybody altogether: the remaining architectures that
> > have a custom implementation don't seem to be doing any better either.
>
> No go for s390.  There you really want to access userland memory in
> larger chunks - it's oriented for block transfers.  IIRC, the insn
> they are using has a costly setup phase, independent of the amount
> to copy, followed by reasonably fast transfer more or less linear
> by the size.

Right, I missed that one while looking through the remaining
implementations.

     Arnd
