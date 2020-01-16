Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C14413D939
	for <lists+linux-arch@lfdr.de>; Thu, 16 Jan 2020 12:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbgAPLoA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Jan 2020 06:44:00 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:52119 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgAPLoA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Jan 2020 06:44:00 -0500
Received: from mail-qk1-f180.google.com ([209.85.222.180]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1Mlf8e-1jJBAl3H1u-00inxy; Thu, 16 Jan 2020 12:43:57 +0100
Received: by mail-qk1-f180.google.com with SMTP id z76so18784614qka.2;
        Thu, 16 Jan 2020 03:43:57 -0800 (PST)
X-Gm-Message-State: APjAAAUBgqC4LsIWStm+C58fzLQYocijT5mOwNACoqLSWjIv999eaN06
        IDlHXjCSgAc6K83QPdZj2Q7x9nE6wI3vi2UXIcc=
X-Google-Smtp-Source: APXvYqym5eFiRPKVnv/qyi9spTjJFVaRol3iabOK0ekCyztzIvYdqXhBVKbxN+eRg7ZjVuhAgzjyuhoaOaMqN4MM72c=
X-Received: by 2002:a05:620a:cef:: with SMTP id c15mr33307465qkj.352.1579175036455;
 Thu, 16 Jan 2020 03:43:56 -0800 (PST)
MIME-Version: 1.0
References: <20200114200846.29434-1-vgupta@synopsys.com> <20200114200846.29434-2-vgupta@synopsys.com>
 <CAK8P3a3W0eLK+qypnPwq=PdcF7+ey8OZEhmOoA6Bg7hMGm5hqQ@mail.gmail.com> <6eb7587b-c3bc-691d-9d27-d4e687114a42@synopsys.com>
In-Reply-To: <6eb7587b-c3bc-691d-9d27-d4e687114a42@synopsys.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 16 Jan 2020 12:43:39 +0100
X-Gmail-Original-Message-ID: <CAK8P3a398-ojtETr9A7YsGTHBnmqyiykcC0YmHQSL5Cw1jy=Ew@mail.gmail.com>
Message-ID: <CAK8P3a398-ojtETr9A7YsGTHBnmqyiykcC0YmHQSL5Cw1jy=Ew@mail.gmail.com>
Subject: Re: [RFC 1/4] asm-generic/uaccess: don't define inline functions if
 noinline lib/* in use
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Khalid Aziz <khalid.aziz@oracle.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Q4CixhMFzeFs5qRN0GqZo0A2jmXvoBMYLNempi2pLkd7iXyKdqE
 z0xUosQIFT+YDAZAZ9LSLPodOvupbCk4k3GxnydQPsf4b1yZ8Ad8tiM9jSLJBwSNSIBz6o9
 5EDEOI92pRobI7RR259+4MViV2VkG2lRkbin9rQIkyDdvzB9CQ25uByolcrlbkMeWCmKgt+
 zcXHKUE/S4oJsSgRZJlWA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ocrgz/UodCA=:/SYz91tU7TITsy+8qNZCB9
 RdrtTSUrGTbqqwY8d/aMCAjYnajiXn9sg1gdL+RqNT+ZevEaopxAbZ5E6VDyouI7h/BVNmnw8
 ti/vNsCduh3bH/qvaPihN6Y0B2nBRQfYozcJwkA/sV5hnjX92d89WJclz5BcS3cRAJ/2BJnhH
 Z+JHlZebyZTbhcCqxBjktnq8nvydT3dzeh2aKAJ4i0KjN+GjAwIpBYM/7qAa26mrZfV64ceuX
 gopGpGqG70b04LhAYY6UFSlQuV5DV89hWBOBKYqtGDhpcjYV1MFzuHJ66Zxxvw8swPZagB2oM
 P1QmRmwaWMcwC0aelCPI859ycX7/kcv3f9l7ZEZZyoEd0nyXpWqWRCtY3G3vzk3YvdL/MoSfy
 Hj6B7PJyXKy4WgHiTcTT8RQMQS5XEGmQV6oTSMKOXjpbfdCR8a+L/atES4l9ZqS6Rza8Pmejz
 IdjeEZsyETkKG94x7swwZXeyjcvknr/30vXoUpOtg6uakvqDt80fPQ1KjeIx2GsJyEc9yHe/f
 oiLOWziglWYofoWPHLmuSiT2G0M36nRfz8mYGe9UUiYPObsLbfaFJkWwH9JYNJa2SdAXsin8j
 al3ChQXojlC/1af1AlVs8ZxQefPFiJGHFiRLSYUhV6ot6oiBsfRmLumb/VFeh4NGbtJxLDh/e
 I25sHucnjS11dnucU5894i/7pWXNyY8+LL24bvor7dR8TRS5dAJVLG3H/nNt4AtMiBtiF2PhP
 /02e7UtrlAUbkr3eLhSEVnSJROzUZClHSUjkoFocEKcH9SGE0oiBQ4oJHG0iTka6nc26HSgLA
 VYDaqdJLS0vFfsdZ48OLA5ompDtHzgs4WJByCkZhHFJdbGl3H1m4uGoBloWJVekzYjZB+EPTZ
 pGKjkbU5F+1XZBEVVEOQ==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 16, 2020 at 12:02 AM Vineet Gupta
<Vineet.Gupta1@synopsys.com> wrote:
> On 1/14/20 12:57 PM, Arnd Bergmann wrote:
> > On Tue, Jan 14, 2020 at 9:08 PM Vineet Gupta <Vineet.Gupta1@synopsys.com> wrote:
> >> There are 2 generic varaints of strncpy_from_user() / strnlen_user()
> >>  (1). inline version in asm-generic/uaccess.h
> >>  (2). optimized word-at-a-time version in lib/*
> >>
> >> This patch disables #1 if #2 selected. This allows arches to continue
> >> reusing asm-generic/uaccess.h for rest of code
> >>
> >> This came up when switching ARC to generic word-at-a-time interface
> >>
> >> Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
> > This looks like a useful change, but I think we can do even better: It
> > seems that
> > there are no  callers of __strnlen_user or __strncpy_from_user  in the
> > kernel today, so these should not be defined either when the Kconfig symbols
> > are set. Also, I would suggest moving the 'extern' declaration for the two
> > functions into the #else branch of the conditional so it does not need to be
> > duplicated.
>
> Given where things seem to be heading, do u still want an updated patch for this
> or do u plan to ditch the inline version in short term anyways.

I'm trying to come up with a cleanup series now that I'll send you.
You can base on top of that if you like.

     Arnd
