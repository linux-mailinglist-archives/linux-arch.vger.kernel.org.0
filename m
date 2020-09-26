Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBCE279A4E
	for <lists+linux-arch@lfdr.de>; Sat, 26 Sep 2020 17:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbgIZPPG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 26 Sep 2020 11:15:06 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:60301 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgIZPPG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 26 Sep 2020 11:15:06 -0400
Received: from mail-qk1-f182.google.com ([209.85.222.182]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MsqIi-1kbeKl3Scy-00tFjC; Sat, 26 Sep 2020 17:15:04 +0200
Received: by mail-qk1-f182.google.com with SMTP id w12so6069660qki.6;
        Sat, 26 Sep 2020 08:15:03 -0700 (PDT)
X-Gm-Message-State: AOAM530eqXv9zB1vGgLFwHUcD8vx+oIR7H5zJwOx8jxIGiGutbBrZKM6
        Cet6nbvgY16w/JYIjcRHk/0+jX4I5GlSUUu8i0Y=
X-Google-Smtp-Source: ABdhPJxIHOGw51eNdlrbfPrNtvt9GZ0CRQoQPFIS6KxakNFDuy5nl7xrMMdye3IxBDCV7cgDteqr7U576hmGd6fdR7g=
X-Received: by 2002:ae9:c30d:: with SMTP id n13mr5026781qkg.138.1601133302598;
 Sat, 26 Sep 2020 08:15:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200918132439.1475479-1-arnd@arndb.de> <20200918132439.1475479-5-arnd@arndb.de>
 <20200919054148.GL30063@infradead.org>
In-Reply-To: <20200919054148.GL30063@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 26 Sep 2020 17:14:46 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0VKObd8BR0x-+fHKizEwhYJ-8YwEN6rKhTHU34G=ADbg@mail.gmail.com>
Message-ID: <CAK8P3a0VKObd8BR0x-+fHKizEwhYJ-8YwEN6rKhTHU34G=ADbg@mail.gmail.com>
Subject: Re: [PATCH 4/4] mm: remove compat numa syscalls
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Wlmaw6PiSTzXpXvV6f+4eARGE7yf05ZGz6+SR1x5QM7est/yLiL
 amRB6pOLleH+hHd8GQONGcBDf5YVJcTMDoFcUzxXY0NLrzpG5dnO482o0bdU7NK72YzeY38
 b6K435/4UgKAkRkI8QCXmiw6NPFUONMxxDZUoqk/kCoOkzLA9CZCQo13fGl1j4wrmP3Geg8
 xuJrzKMpYVgwkARri/3jg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ql+KTAtFLqY=:LospJZPxo0oCkNMAQa8kOx
 IvvKYCgIZOVcun3QQdOQEi4nyuz4pv7d4kNVf0xlQwc6lVa3uJYDD9bmAtzn3vKprHTj+gFuz
 tIkREpAMsaKmINnlgF2gaSYHTeGiBbyEk4/zntVgSBGkkf54QK2Q9u8+UMcxQcFJxuedEyM07
 SHuRXou9duxVH/OBZPR9FtdfOy6YQr2xIcxtYDNFKbzyDWs0F8m+9dtWClc7xFMu/LBa+nJpu
 rXVIvRR74YRRCruB+QOu1uyp/CtBBTjYRwRSUPKloifAkd7UWkZNVeLCyqogA31FkM8bpUmge
 c/VL3vWH2liR0/wvnuPDOTaauuBo4+yrRUng3Qt8/swu003Epm3SwbDDS5sNpiK2bX7ZdZGqD
 dUcTJXAxhVcBsmdm2JbOS2yaRxGFTXk/Dlx6TS1WUd3t/q9A3zOc4o73cEfsLVFqsWFA+Hz4Z
 48jzoX3G/U6QfaXCR7gDqG/qPFKCTLmbvGTJsBfUHeVSSO6KZPchf59l/c/+9QQlVI12cjdja
 6NS5cL1qKD4yIspGoMGfxXQA9qYpGCGvCnPK4Jg3Pmf4C9gbgknRszyvqifYDKAQp4c7SZgyG
 lCPBUGvEcoCENK53wqJ6EudwPBqY0pLiS9UlPc52BRMNMwXjNOi9S1E5vIMH7bkeu7eAzP+aD
 JMIW+h83gJai7QAkRX2wk5nTsvIrSHEH7ZU/gVdtwa1LIOBBeIXC39fb5mYIpplUAGlWUikLw
 ymVMSiFkFMGCqMWrrhPtCIGaQJep/AMCuFo1TYed6jYfXXMBvaZI2xEcwYDkheL8vutqFBCnH
 9dDwN/8q83yRJgXhhvtp1eFsQKhJrLi9P7QfY24rGbbTG3YfPwC2EQM8iAXbN8BY/QMGxz+
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Sep 19, 2020 at 7:41 AM Christoph Hellwig <hch@infradead.org> wrote:
> On Fri, Sep 18, 2020 at 03:24:39PM +0200, Arnd Bergmann wrote:

> > +static int get_bitmap(unsigned long *mask, const unsigned long __user *nmask,
> > +                   unsigned long maxnode)
> > +{
> > +     unsigned long nlongs = BITS_TO_LONGS(maxnode);
> > +     int ret;
> > +
> > +     if (in_compat_syscall())
> > +             ret = compat_get_bitmap(mask, (void __user *)nmask, maxnode);
>
> I'd either pass void __user all the way, or do an explicit case from
> the native to the compat version in the compat handler.

Changed to

        if (in_compat_syscall())
                ret = compat_get_bitmap(mask,
                                (const compat_ulong_t __user *)nmask,
                                maxnode);

> > +     else
> > +             ret = copy_from_user(mask, nmask, nlongs*sizeof(unsigned long));
>
> That whole BITS_TO_LONGS(b) * sizeof(unsigned long) pattern is
> duplicated in various places including the checking of compat vs native
> and probably want a helper that includes the in_compat_syscall() check.

I don't see what you mean here. I can see how having the helper would
simplify copy_nodes_to_user(), but not how it can be shared with the
use in get_bitmap()/get_nodes().

      Arnd
