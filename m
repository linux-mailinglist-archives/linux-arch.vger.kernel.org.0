Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE8A03DBD6B
	for <lists+linux-arch@lfdr.de>; Fri, 30 Jul 2021 18:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbhG3Q6y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Jul 2021 12:58:54 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:50313 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbhG3Q6y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Jul 2021 12:58:54 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M6pck-1mFZ3e0yLO-008Nfc; Fri, 30 Jul 2021 18:58:48 +0200
Received: by mail-wr1-f42.google.com with SMTP id b7so12136097wri.8;
        Fri, 30 Jul 2021 09:58:48 -0700 (PDT)
X-Gm-Message-State: AOAM531eDRfgJ9BBXaIbDQLO2Evo2TLnrpEfmoPMr2lKTg0J977jgO78
        +z0h01Gt5LpjsmREt/VrloDnTIUZngehcqmF9/o=
X-Google-Smtp-Source: ABdhPJy7kIRftgcOsUIvubT/kY0wdhrkgHsA1t4CJ1qrkDveMapXnbRVLdeEXDe+NNubpO7E0EuS3D437a9Fe6JXjf4=
X-Received: by 2002:adf:f7c5:: with SMTP id a5mr4082182wrq.99.1627664327852;
 Fri, 30 Jul 2021 09:58:47 -0700 (PDT)
MIME-Version: 1.0
References: <YQQr+twAYHk2jXs6@boqun-archlinux>
In-Reply-To: <YQQr+twAYHk2jXs6@boqun-archlinux>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 30 Jul 2021 18:58:30 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0w09Ga_OXAqhA0JcgR-LBc32a296dZhpTyPDwVSgaNkw@mail.gmail.com>
Message-ID: <CAK8P3a0w09Ga_OXAqhA0JcgR-LBc32a296dZhpTyPDwVSgaNkw@mail.gmail.com>
Subject: Re: [Question] Alignment requirement for readX() and writeX()
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Gary Guo <gary@garyguo.net>, Hector Martin <marcan@marcan.st>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:6ZwEwgrZqBzI62Thl/IRhZ6eSXn1rpmVuqEgDWhwBimD7/Ipl8P
 m6saedJonejXDUwssT7FIXdyNKor4WftKz1mBoS3dJnldexXo9KIi8VjTPDIiRuw//rHkVj
 QiKaTAdOCDpZuBhSMVXTrQe4/F0o7BrHIZL3BUYByAbc5RkhgEw0UI+RNQJbUVzTBKExZZ0
 zL588YzlU7ms8D5C19fgQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9x3rCfk/btE=:StU2yG4DZub69SFxY30ReF
 kB4KACEetFB5An8/E/agqNO4L+IpyqgsO1JObv9w9xFa/KTFk6ujcFA6yTNiXGaoZZK9FHmFr
 gTa1vkVj5hi4Vk8O1uBscC/ijbiL4i450a34cTbPTN1AAvIcOGLp1AWsX/YT0cFmx2wKyn4Gu
 J8Ab24tRJSd1xFRZYPi7SdeVlbJE2PN9L4LRmZ4Lrp2YYS6wcbVcGYRerGsMROQfbJyueMXE0
 /hcZI9O307+79UgUM7Q2LJQJY3DlB9OCnscy7P+NLXYaZ4bXz6NTl8BtpUxUozMs0MNw4pnhH
 oCGYdl1Z4PmNMY9kwaDPjzkrQR+9V0MteorIMFCni9l/EygFjgLAO829lfkzHh/kZMbz+3UP7
 dFHETWzGBnTQRwjBslIL4aRcwxonw6poQ25FGZpvqxyz44SOokFQ0IzBG2vdewPLQQ6Yx5+Mm
 iDzVPsJAumpPOlajixKLiJ4BmpDW2+fxQ+CZmmPmI4sotDXGAjuJcmGwQ9J0YS6X70fa0na3Y
 0IPfpOlLgKY8/PtWOjXkPVkOj0JZUtIUMN66hiMtPwAwTQ3br/Za0rGikdace9ZACt5EcrMhK
 ZR5hg35dDGuBU9qMZi0SoDmj2US6lkEks1j20XKlhVtVeTfCwwaWRPguosdp3e2m4+s9DHN/y
 Dcurbh5dvC02gPVdJRj+mHaob20bApao/INI3AlXr5THTvHJ/Gy4lIgQWirA9/Qi1auFHyT87
 U9l4Kjb9SpwRCcUCZQNKgLvIdGgDaMSzFv9ttvAF++Sdjyj32On/dGw3JI05BWqLTdtJbUTJU
 17u4LDcepWEjfRtewTSxEchF1xWvo1uOtUz1WOk7kxOeAbzOC7zYEdUOLdLZDy1OcYL935Ppg
 4QbKI/oaZ1CW3jU6z6IMDtBTca942K+KdWv6I9aaIJVEsTQlEIbK3VpxuND86/C6MCZQuJBei
 hZLqwy67VdaxnpwIXLVWIG9wPofaDIzwJyw5QhOav5ma9f+XdThZE
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 30, 2021 at 6:43 PM Boqun Feng <boqun.feng@gmail.com> wrote:
>
> Hi,
>
> The background is that I'm reviewing Wedson's PR on IoMem for
> Rust-for-Linux project:
>
>         https://github.com/Rust-for-Linux/linux/pull/462
>
> readX() and writeX() are used to provide Rust code to read/write IO
> memory. And I want to find whether we need to check the alignment of the
> pointer. I wonder whether the addresses passed to readX() and writeX()
> need to be aligned to the size of the accesses (e.g. the parameter of
> readl() has to be a 4-byte aligned pointer).
>
> The only related information I get so far is the following quote in
> Documentation/driver-io/device-io.rst:
>
>         On many platforms, I/O accesses must be aligned with respect to
>         the access size; failure to do so will result in an exception or
>         unpredictable results.
>
> Does it mean all readX() and writeX() need to use aligned addresses?
> Or the alignment requirement is arch-dependent, i.e. if the architecture
> supports and has enabled misalignment load and store, no alignment
> requirement on readX() and writeX(), otherwise still need to use aligned
> addresses.
>
> I know different archs have their own alignment requirement on memory
> accesses, just want to make sure the requirement of the readX() and
> writeX() APIs.

I am not aware of any driver that requires unaligned access on __iomem
pointers, and since it definitely doesn't work on most architectures, I think
having an unconditional alignment check makes sense.

What would the alignment check look like? Is there a way to annotate
a pointer that is 'void __iomem *' in C as having a minimum alignment
when it gets passed into a function that uses readl()/writel() on it?

       Arnd
