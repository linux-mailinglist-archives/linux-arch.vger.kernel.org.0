Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 359C748B12C
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jan 2022 16:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243216AbiAKPql (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 Jan 2022 10:46:41 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:44707 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240010AbiAKPqk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Jan 2022 10:46:40 -0500
Received: from mail-wm1-f48.google.com ([209.85.128.48]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N79q6-1mHX7K2h9o-017WVg; Tue, 11 Jan 2022 16:46:38 +0100
Received: by mail-wm1-f48.google.com with SMTP id e5so11364324wmq.1;
        Tue, 11 Jan 2022 07:46:38 -0800 (PST)
X-Gm-Message-State: AOAM533QG5EGLvNOjqRhv+pSIHPRQ6LL9SkCwSpGuII0dprxoZkRRsZY
        uCLnTmo9kwRzf3sMlp2u7+BmmeT0kpDNOnHX5mA=
X-Google-Smtp-Source: ABdhPJwB2xKozQuCORkKSCQAL8ClRXdu0xcIO+JF0MBbhis3uIel6aCgUYRUOftHzuYWMBNA7fgNkNtxR2C9Ihxf1Yo=
X-Received: by 2002:a05:600c:5c1:: with SMTP id p1mr2988726wmd.1.1641915998117;
 Tue, 11 Jan 2022 07:46:38 -0800 (PST)
MIME-Version: 1.0
References: <20220111083515.502308-1-hch@lst.de>
In-Reply-To: <20220111083515.502308-1-hch@lst.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 11 Jan 2022 16:46:21 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2nY60Pgz1Q0YJ-bMsJdJfFNw8q6R7R2WzPCj+tVdA=+g@mail.gmail.com>
Message-ID: <CAK8P3a2nY60Pgz1Q0YJ-bMsJdJfFNw8q6R7R2WzPCj+tVdA=+g@mail.gmail.com>
Subject: Re: consolidate the compat fcntl definitions
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
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:OhqwhpDN2ksPKZsBYhrIQ0Jy/a2mcdyEzEvgvAilHeQi8HUC6D0
 XD3UZZXtkDC0wz9zAmXZILu0SRnEkV2TvA+Vna+RRAegFesdETytq27fHjaAFrM4ZomTVQS
 rYChRPOGjQFxEom9Vc9ua/N0ZsgoDA1Rx/25h8VslivCKlCcQY8h/v/3+/hqbvZz+Ce1yBE
 kq5hRM/4IHzmUlqDdvJrg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:u7BSYyK0FWg=:tUu0i99KWoFD2LamSf60D6
 ZfBcp6W7ZmDOTFCGr3jRBrAHuAb1Sh9ZKoTTQoAmEeFARn6cQPagUSlAqB4jUFSqFQ++UTbHY
 LU9tjpaZSbIweC9XIXkSjykSpPVIX9RuHNymMLfbXxHXlUxGQCSMdaEuNkGJFAKOr5kRCwRiq
 r9I9Sufz5PUbcgYGSXaiIXWA6AZc/E75RfLScTdMr18xmZF70D4bmj2bV5tn+rP2GKoi+4oCu
 7wIH+j5jcFyVswAd5f18r/Jz/JOxBZ5lkBcy3GoWL7dvNcoHK3XanVFMzO8R4SDB4Krj3bDOl
 fKqA7lhDu/FUYGj4Ulr5MZn03yxAThWc5KX7jJXPNsXSmSq05tkAR2pQMw2ctWu1I5hh+U7h/
 K71JhtYAC69vfQLd3FFKxFD9xdaIzVJPTfWLpFg4kaFC6Of/eAEm9Ui9eCbgGIuBdIeGtqOyp
 ZKo0vt3Wp9att8c8puUYa4cKzUPaBVL/Cu6LFD4SZ1mo6RXyh9SFXNPmXVbITukts0rCX5RSn
 iFaP25llRgorIrihPDUr6N10ZPbqg22OASy/Aa7VS5wDHUMVXMCxQTZEGrco44OLUsPIRomN/
 X3fjkXh+dbD0OiDkTkNJpf24hYgMsBn4/QW8+apGMpHlrim3k6framygL7ZOO58Xd4kl95W4r
 FbIUZjsVuIsVZ9ML1wcDNVa1qjBqRChEIvnqKUKgdG0SVWJMAXezCKMkXDP9MwPNGwvkuvn16
 w+4oXbWxYkVPuNKUiDMbZSXj2z9Abc7+w5KlZxSEsgaQrqSjTwxEGLR+SrRaWX6lBGFNsdYhG
 uODMcaoBEAfUpM0BObiDS3o/GJrFrfOj/3614xE4UnHN/QU3oE=
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jan 11, 2022 at 9:35 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Hi all,
>
> currenty the compat fcnt definitions are duplicate for all compat
> architectures, and the native fcntl64 definitions aren't even usable
> from userspace due to a bogus CONFIG_64BIT ifdef.  This series tries
> to sort out all that.

The changes look good, but I have the same comment on your last patch that
I had for Guo Ren's version. Once we have resolved that, I can apply the
series in the asm-generic tree, or provide an Ack to have it all merged
along with the compat mode changes in the risc-v tree.

       Arnd
