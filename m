Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B016B25E148
	for <lists+linux-arch@lfdr.de>; Fri,  4 Sep 2020 20:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbgIDSEy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Sep 2020 14:04:54 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:42155 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgIDSEx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Sep 2020 14:04:53 -0400
Received: from mail-qt1-f181.google.com ([209.85.160.181]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MsJXG-1kXRrF2QQc-00tjbC; Fri, 04 Sep 2020 20:04:51 +0200
Received: by mail-qt1-f181.google.com with SMTP id n10so5326328qtv.3;
        Fri, 04 Sep 2020 11:04:51 -0700 (PDT)
X-Gm-Message-State: AOAM532i2Zgortc+jdYp4gwDiE8QCVbgzkrPQCG+qnYdaF4WXF+wdVYf
        xQOEARxvvNoP6rsLv04mk7GyO3xKaUl0PHpKmBI=
X-Google-Smtp-Source: ABdhPJwKzhgqFAMC09LYvzrY70ahhbEpa/CeWyBR83Ccx3AuOB1/vZONwnfNbBWCJD4p/77P5oC/C+vZjOmK8LQVsYA=
X-Received: by 2002:aed:2414:: with SMTP id r20mr9970750qtc.304.1599242690288;
 Fri, 04 Sep 2020 11:04:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200904165216.1799796-1-hch@lst.de> <20200904165216.1799796-4-hch@lst.de>
In-Reply-To: <20200904165216.1799796-4-hch@lst.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 4 Sep 2020 20:04:34 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1=udSEq8kpsmLk-b7ye0p=6eKTvBV74jBoGYmufL2oEw@mail.gmail.com>
Message-ID: <CAK8P3a1=udSEq8kpsmLk-b7ye0p=6eKTvBV74jBoGYmufL2oEw@mail.gmail.com>
Subject: Re: [PATCH 3/8] asm-generic: fix unaligned access hamdling in raw_copy_{from,to}_user
To:     Christoph Hellwig <hch@lst.de>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:6MO0b0CUNaQ6Os9JHibIyRp08mfdhmxnxN+PwfFQq1OASMaeS/b
 rUIIFKjwSIN+o44XTLUutoF2FPDWFHgbMolIT1QCaIx/l2gZKaZRNPHfGOrYhUxtI60i+15
 BkCyH8sDLgLwap3vnyil+H/BBXMSs4oGsLD82ki9o/WViAZKzcD98aa2u3MwJmJgPkTl2IY
 CPqx42KnbipwbyfgxCd9A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:GsVbHphrEDY=:b6qsBZemjP56jcY0o4PEJo
 3IQX/aipeBiKMhSQp3O1VCI5FCWPNmULZu1a8HlGpRdLNwyL/DcDiTFc2i015xNib52Kr4QtA
 YPEOpqZVQpE4rwQ6OiPseq1KWh/ZQOy7dZnEb2rlv67oOTVak+2YKwD4SuJ8UcNfAQ4DvNQ9a
 QRi6DAJ7hBDYqe4PyVfkmM9ND79NwmsHMkxvt0i48gUequNoktUJuGGtnGLIEq3NVAWY3Teea
 dNMi1nUnCQyUoRRkjWyBAWsvyr4qww2yE2syWEMnMaZNjOsZqpKtYSQUW3r74gyrsubzg3Zkt
 UHbeirDDT779TFH2tsZmJ/DI7ZVEC2iKp9CTOidgtLMaByHc/kTpX0kXDwTU60XJPWwhtbgUf
 lNjIliA9pwiJH2eOfQRCjBChv8mJIKsZ8yc/F6rOqpBQCe8UqPY0uIFuiCS3YdPyqYpROGLac
 8d7FLQPS594ocMvihMyHnodv6bx+nZ/TGFJypXiwvl5Buxds/yS5kvb0wN35pKanKIFrlZi2V
 caQ6ZAuUhNsAm7lXzMNNRWe5ZlqcEPdaH35qibUE74IRh1To1/sar22U/zwTl8cafa6axoEVY
 ARjIgt7DCCsWnnz9nnQftcvoC9dP4u+tl/I+9uG1x0dqKtIYiGekEbRWeoH0e7F+XRKH3iqZr
 Scb4IUubHU3i87Wt79EvJohMxS/Nk/S0nw4juAI3Hm+8TakooFpc5YbsqEh073PV6K0vsWKtX
 v/h/GZoOgTrV7LO7tssxjIM8MOcSj8mKuYjl4C51+aQtlrySBX7rmIDn8Iq9XnEOWz7c5FMtq
 hnIJG+Toq7iC3/UQTEjlQ+KwrxDyp3H5hFkMbFvRAPjElV6AfD6VwHSsuzvLzw2dYRyznL3aA
 M26lfUhK/D81SjqGtgSOS2h3zy+un8eelWKxtGoSdrVQHeJnlSRpiwvBJPN+k9k2PokqwYkvb
 3Kk91LnVT+DLeAh3Af0c9z/Hw0YeCmT6p1O0ptJMRNzWPM4jwId03
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 4, 2020 at 6:52 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Use get_unaligned and put_unaligned for the small constant size cases
> in the generic uaccess routines.  This ensures they can be used for
> architectures that do not support unaligned loads and stores, while
> being a no-op for those that do.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/asm-generic/uaccess.h | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
>
> diff --git a/include/asm-generic/uaccess.h b/include/asm-generic/uaccess.h
> index cc3b2c8b68fab4..768502bbfb154e 100644
> --- a/include/asm-generic/uaccess.h
> +++ b/include/asm-generic/uaccess.h
> @@ -36,19 +36,17 @@ raw_copy_from_user(void *to, const void __user * from, unsigned long n)
>         if (__builtin_constant_p(n)) {
>                 switch(n) {
>                 case 1:
> -                       *(u8 *)to = *(u8 __force *)from;
> +                       *(u8 *)to = get_unaligned((u8 __force *)from);
>                         return 0;
>                 case 2:
> -                       *(u16 *)to = *(u16 __force *)from;
> +                       *(u16 *)to = get_unaligned((u16 __force *)from);
>                         return 0;

The change look correct and necessary, but I wonder if this could be done
in a way that is a little easier on the compiler than the nested switch/case.

If I see it right, __put_user() and __get_user() can probably
be reduced to a plain put_unaligned() and get_unaligned() here,
which would simplify these a lot.

In turn it seems that the generic raw_copy_to_user() can just be the
a plain memcpy(), IIRC the optimization for small sizes should also
be done by modern compilers whenever they can.

     Arnd
