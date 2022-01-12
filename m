Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE98C48BFDF
	for <lists+linux-arch@lfdr.de>; Wed, 12 Jan 2022 09:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351616AbiALI2q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Jan 2022 03:28:46 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:57099 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351621AbiALI2q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Jan 2022 03:28:46 -0500
Received: from mail-wr1-f49.google.com ([209.85.221.49]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MOAmt-1mjhPp0ATh-00OTvi; Wed, 12 Jan 2022 09:28:44 +0100
Received: by mail-wr1-f49.google.com with SMTP id e9so2773286wra.2;
        Wed, 12 Jan 2022 00:28:43 -0800 (PST)
X-Gm-Message-State: AOAM532WPRCdfBOA6lx0jSM2auWD4YvIb6sNEYEjCRnPciRNY2RlRucS
        LGN61U51nHvP8VdAeEsVM9jAVdu8r3Q4e0vOF4Q=
X-Google-Smtp-Source: ABdhPJzCQAXjKL7v7gwqeNOizFH7EmO4xK5MJG/Z0khXPuJErSXk+hZMQMifsbbqaAU9IP9YduLhizzW87q9+u/zsmI=
X-Received: by 2002:a05:6000:16c7:: with SMTP id h7mr6863134wrf.317.1641976123587;
 Wed, 12 Jan 2022 00:28:43 -0800 (PST)
MIME-Version: 1.0
References: <20220111083515.502308-1-hch@lst.de> <20220111083515.502308-5-hch@lst.de>
 <CAK8P3a0mHC5=OOGV=sGnC9JqZWxzsJyZbTefnCtryQU3o3PY_g@mail.gmail.com> <20220112075609.GA4854@lst.de>
In-Reply-To: <20220112075609.GA4854@lst.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 12 Jan 2022 09:28:26 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1ONn=FiPU3669MjBMntS-1K5bgX4pHforUsYJ7yhwZ-g@mail.gmail.com>
Message-ID: <CAK8P3a1ONn=FiPU3669MjBMntS-1K5bgX4pHforUsYJ7yhwZ-g@mail.gmail.com>
Subject: Re: [PATCH 4/5] uapi: always define F_GETLK64/F_SETLK64/F_SETLKW64 in fcntl.h
To:     Christoph Hellwig <hch@lst.de>
Cc:     Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:ojcfELcF0YhMWzD8LtY6EPxZUyJuORY5IzRKjV/HhlgohnKtGQC
 JYo7XAz+MKsQSQ3TLKX8hri/6/1LRTr9TE+jgWvumLMvIVrSagHY8afKFXVyaM+gwTtA5L7
 K2hR7zo5U76QjJrILF4+3yVBZkjyGp/9ilUvCcE8mrEytVC6oCeBL57t7sMPxGm19ojw2lq
 WvHgi92ARXqenTHycu6mg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4WpxcbWvK9k=:cmU54THCfxUt1DIjRLEBmK
 ntIBIIIf40mn7QF4658v9FvbNc5y6Z83xf7+TgrpNnglg2cCc1vlLzEgYO8oJ5YBmdgs1WD/h
 uErrUSxPnLVluANaztVmx065Zxse75GKIOfdI8IJC5kq6yJ/UIoukxJOQnF2urHAwLDlFcqPA
 SraFMF3IvQWcBZB2cYRpi2khAb932HFH64eG9GaosPaND0b1VdfDZEE2cdxSk56Uj+emIqm4a
 RkJryuUJlUeDq8yAPK0t2cHOeYUm8pVX7semLTpTvl7wBQBdp+tnFNajO8LRsPrn5rKP3UEor
 m4nbd8lBrkgRYzH9Vv/N9rJVtrGs//0PVjEpXq36oLOBO5UDFt4t37Vibv330SB2AWAu/Kc1d
 P7LfP6Wi10FW05lilDquVoXxJJJFe+VDR8Il6wuFUraA1oozdE6Gbq3xvaYW6pTvUVAq/gAgv
 iroaVGYYt/YBidzZOxzmZQpLAxmpJgGG/1JynWbsUP6oe5bZ+CphzUUkpd1V9Z/mjwyFgR7Zf
 Skl4z6LCwhaJuksvSHFP9ZrDdP5XtjtNW1Actx+/iBwo2VvGh7eME/f8vAVPqQxfw0DDe/pgm
 kMluiZXKMFxte8IAVB/ApTl8gupGr0M90OQjEFpiTiydctm3uCfPEctDytkg9fkBhe9Z02RLC
 MDfEwEKWqki/Y7mEwlu2J7fsIRfhp6RfxhIzBfmEYg5f6tFqqfpsJIc1oN8w8twkpcm8=
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jan 12, 2022 at 8:56 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Jan 11, 2022 at 04:33:30PM +0100, Arnd Bergmann wrote:
> > This is a very subtle change to the exported UAPI header contents:
> > On 64-bit architectures, the three unusable numbers are now always
> > shown, rather than depending on a user-controlled symbol.
>
> Well, the change is bigger and less subtle.  Before this change the
> constants were never visible to userspace at all (except on mips),
> because the #ifdef CONFIG_64BIT it never set for userspace builds.

I suppose you mean /always/ visible here, with that ifndef.

> > This is probably what we want here for compatibility reasons, but I think
> > it should be explained in the changelog text, and I'd like Jeff or Bruce
> > to comment on it as well: the alternative here would be to make the
> > uapi definition depend on __BITS_PER_LONG==32, which is
> > technically the right thing to do but more a of a change.
>
> I can change this to #if __BITS_PER_LONG==32 || defined(__KERNEL__),
> but it will still be change in what userspace sees.

Exactly, that is the tradeoff, which is why I'd like the flock maintainers
to say which way they prefer. We can either do it more correctly (hiding
the constants from user space when they are not usable), or with less
change (removing the incorrect #ifdef). Either way sounds reasonable
to me, I mainly care that this is explained in the changelog and that the
maintainers are aware of the two options.

        Arnd
