Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2B2366A45
	for <lists+linux-arch@lfdr.de>; Wed, 21 Apr 2021 13:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239405AbhDUL6j (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Apr 2021 07:58:39 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:56435 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239446AbhDUL61 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Apr 2021 07:58:27 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MoeU5-1lFp7Y1LxZ-00p4iR; Wed, 21 Apr 2021 13:57:53 +0200
Received: by mail-wr1-f41.google.com with SMTP id h4so32048630wrt.12;
        Wed, 21 Apr 2021 04:57:53 -0700 (PDT)
X-Gm-Message-State: AOAM5304dWFga/AWz4PhZR4VLhfiqVH+uOFx6PN6Mk2Pek2moeu/Rgsu
        FilXl3LJcq70vSj5NXKvjafXD46Ng4WZu6Hd4bI=
X-Google-Smtp-Source: ABdhPJxxLHU622QUTxVLT5JG28FXBqbMwoP9QmuTk81YvLLEEGjqqeD8jwt159GM0E527X3eKOyaGZAiRaJowXbS4kU=
X-Received: by 2002:adf:c70b:: with SMTP id k11mr27161191wrg.165.1619006273000;
 Wed, 21 Apr 2021 04:57:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210421111759.2059976-1-schnelle@linux.ibm.com>
 <20210421111759.2059976-4-schnelle@linux.ibm.com> <bb21141706d7477794453f7f52f6bc98@AcuMS.aculab.com>
 <aac9ac52de09ff7162fc7caa6e817258d9dd313d.camel@linux.ibm.com>
In-Reply-To: <aac9ac52de09ff7162fc7caa6e817258d9dd313d.camel@linux.ibm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 21 Apr 2021 13:57:34 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0uXo+CLs2emsXE=-Zr+FjxV5k7AWNdGrN0fa37gwub8w@mail.gmail.com>
Message-ID: <CAK8P3a0uXo+CLs2emsXE=-Zr+FjxV5k7AWNdGrN0fa37gwub8w@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] asm-generic/io.h: Silence -Wnull-pointer-arithmetic
 warning on PCI_IOBASE
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     David Laight <David.Laight@aculab.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Nbszmafly6zxXrw+94wUB1T+SrE3e9eolGVJfdlUZiokV/c1+8m
 CimfvAj3d5UIr6dLA0IRpbAbQGb3vJgRPMh12ywCzuFZpcM4QHBJqL28DG1U1EUk4dByT/v
 eVLCmYcOWamGkF5STsm6rVry8lrkh3NlmKEqWOTYInJuFgqeLzOykJ0Jx8y+LQJnDuvrQz5
 439hOoDiHo9RJ9gdeyMog==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:CJnzMup/cT4=:S8V6aP8Nog3aZiaZ06islw
 niTrTQphyCwqy5rb/QJy/ZXtB+5qOxrZkjP+dTjHDW3kSF/RfXjBkj3YP1EqYmLpw6G5Wqf/r
 jppch8xRq3+8lEvYVBqLlmLHZApJqRYOOjnvG5l8hMDAyYqOtp0HYwUzWMxRdlNBV9UpRTTp6
 ogb3PqosO73F3bzZ0O00CXrdjMr2P1toixZUNwxI6xonKpTVr05h7m5MYCbqfkkI7eDCksVVl
 0ZV5T1Cr5XQeVHgczldHRpq37SuWFjd5JQ4yrkaEUSw12YGA1GyYQx9DXyhON1X2MQ+yR3Wc7
 C/ndOMcV8br5fvHniVyr3THSxkg1ve/TTHO+wqSG8cOE90vzc4a4e3aKInq0bJfg/cgxaUU7n
 ZG+bs+vy0CKcMtaP3t9V6tPx9ntMGyqAHW13kvmNq+4pg8xhD9N1fn2AXFrktCurBv0h7y3uI
 jGkNrB7VaAAKF69n7XgfBigpN2P+aOspngj1R15Br5ARnz4zkmNAZQuve+76eSZWOA8wOtTjD
 d0Bez6ejpre9rwOkovyBy8=
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 21, 2021 at 1:50 PM Niklas Schnelle <schnelle@linux.ibm.com> wrote:
> On Wed, 2021-04-21 at 11:24 +0000, David Laight wrote:
> >
> > I suspect that this might be better not inlined
> > when PCI_IOBASE is undefined.
> >
> > Otherwise you get quite a lot of bloat from all the
> > WARN_ONCE() calls.
>
> Hmm, I was wondering if we should rather have a large ifdef block of
> all these functions stubbed to WARN_ONCE rather than in each function.
> As I understand it this would be necessary if we want the inline gone.
> They would still be static though so we still get a copy per
> compilation unit that uses it or am I misunderstanding?

I wouldn't worry too much about the size of known broken drivers during
compile testing. Also, since the functions are marked 'inline' and not
'__always_inline', the compiler is free to decide not to inline them if
the contents are excessively big, and since the strings are all identical,
they should be constant-folded.

If you want to make this a little smaller, using pr_warn_once()
would be a little smaller, but also give less information.

      Arnd
