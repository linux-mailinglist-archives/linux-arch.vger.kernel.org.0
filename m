Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1DD648C3BC
	for <lists+linux-arch@lfdr.de>; Wed, 12 Jan 2022 13:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240529AbiALMJC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Jan 2022 07:09:02 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:56117 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240542AbiALMIo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Jan 2022 07:08:44 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MkIAB-1mfCZU14Ez-00kk8u; Wed, 12 Jan 2022 13:08:41 +0100
Received: by mail-wr1-f45.google.com with SMTP id a5so3831115wrh.5;
        Wed, 12 Jan 2022 04:08:40 -0800 (PST)
X-Gm-Message-State: AOAM533ZGm3cRekLXjcMkTt3kd79hTYQqO/O+VRMRfE1xWRbCfRjQg4P
        RUg1ZFX1oAJWrabX/rccC9bU6GEQxiIMMBRMisA=
X-Google-Smtp-Source: ABdhPJyNUKzidEWwkYa+wfOUEohIKCR5feZK5S3WXkq+SYeCBRFZTq1mqc61Ubm+2cYuonDIFIyFwZ5WRZ3fGi7ACRI=
X-Received: by 2002:adf:fd46:: with SMTP id h6mr7767440wrs.192.1641989320742;
 Wed, 12 Jan 2022 04:08:40 -0800 (PST)
MIME-Version: 1.0
References: <20220111083515.502308-1-hch@lst.de> <20220111083515.502308-5-hch@lst.de>
 <CAK8P3a0mHC5=OOGV=sGnC9JqZWxzsJyZbTefnCtryQU3o3PY_g@mail.gmail.com>
 <20220112075609.GA4854@lst.de> <CAK8P3a1ONn=FiPU3669MjBMntS-1K5bgX4pHforUsYJ7yhwZ-g@mail.gmail.com>
 <f86483fca8b0dc68ce243ba47998ff3296a3b6f8.camel@kernel.org>
In-Reply-To: <f86483fca8b0dc68ce243ba47998ff3296a3b6f8.camel@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 12 Jan 2022 13:08:24 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3FgHQ+w+Sj00yOERRLWfVhx7NYsGJ1NBAXQ0=is3G=Kg@mail.gmail.com>
Message-ID: <CAK8P3a3FgHQ+w+Sj00yOERRLWfVhx7NYsGJ1NBAXQ0=is3G=Kg@mail.gmail.com>
Subject: Re: [PATCH 4/5] uapi: always define F_GETLK64/F_SETLK64/F_SETLKW64 in fcntl.h
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Guo Ren <guoren@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:FxPxwUrWV4XP7ogjVSXFtyLQ/37PlsmMmUro1QU4xiHMbn0HF84
 G8In2DCCe6NgV9Dn1VApj2AHduGRQcXwBnEEmCXxvbdDdUtTN55Im7sax+K9wu38i/0THSt
 qwS61rSk6GqdhzFFLBwpooyB0yjUSYE4pe42qAX6VnGYLAIhan1CNvWQ1cG0QiBaOzsQWfz
 o2XQo87qWwB2sSNPGQvwA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:BtxbLJaYFLs=:XysORES34srxkFt4ots9C8
 qAYJ006SFkwIPnIkshHXoJ1BgxSd/2XSnwtBKCqhTNr+O2WRJdSnXJCjl19Sd0pPrt3E5KxR/
 Jey7f+WpuXB7yq3xok4V0KMQPPgepNx8BYfhogiX7IURcJYF3S5UIs74ppyqOrdevXk6UGF+Q
 zK9qS+Lkd5tk1zKvNRKvKam2kXkDXg9/ZpYRMrc246SEp2aWNuylQyt64t+pnk3AFOhHG2Gu4
 /ZPhWIaifVS5QE5MC5G+odlnYblVp+Yc1W3gX/gGZFuf0hPUULb7/xZayvu9ReVwzNr0SyWQW
 bRVNskdvJBBobymu2iB+DkIhw+daP34dHhR6NbcGoR6A4fTGmaoQj5GbxnSPE0ImU5e1+NK8T
 pdFk2ZxibwNiehBhu2umOFlsjlXmgrVcwufZnQRgjDeXjZLBtlfxJr9Bv2sYQBxFx7F/9r3jP
 oWypQf1zICYTc8xsqd8xz5z3CYT2tSZaKyHH4a/agXWUxRwCJhycoTjk7VpQJlmvWnTkCQmc2
 sBLSiEJ0yHn2a4e4kabwKDUzO1VWgpB3nYrF/Vdy5KutC4m2TXlsNpN7FdJMqMAsuTc3mqSTB
 MIipeeA9qUOqFHjTJChWhs1hd5f9dXAXab5LKgBWUg1fRw+geqTaRztHSh+M6SsktD1vB9RD/
 5k+UdCH3MLk3Oqblmlc1njfSCnMgQygiM6+Gh8sWXQUIy540MEZcRUtbrNy4THYzBMdk=
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jan 12, 2022 at 12:15 PM Jeff Layton <jlayton@kernel.org> wrote:
> On Wed, 2022-01-12 at 09:28 +0100, Arnd Bergmann wrote:
> > On Wed, Jan 12, 2022 at 8:56 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > Exactly, that is the tradeoff, which is why I'd like the flock maintainers
> > to say which way they prefer. We can either do it more correctly (hiding
> > the constants from user space when they are not usable), or with less
> > change (removing the incorrect #ifdef). Either way sounds reasonable
> > to me, I mainly care that this is explained in the changelog and that the
> > maintainers are aware of the two options.
> >
>
> I don't have a strong opinion here. If we were taking symbols away that
> were previously visible to userland it would be one thing, but since
> we're just adding symbols that may not have been there before, this
> seems less likely to break anything.

Changing

#ifndef CONFIG_64BIT

to

#if __BITS_PER_LONG==32 || defined(__KERNEL__),

would take symbols away, since the CONFIG_64BIT macro is never
set in user space.

> I probably lean toward Christoph's original solution instead of keeping
> the conditional definitions. It's hard to imagine there are many
> programs that care whether these other symbols are defined or not.
>
> You can add this to the original patch:
>
> Acked-by: Jeff Layton <jlayton@kernel.org>

Sounds good, thanks

         Arnd
