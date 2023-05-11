Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5008D6FEE38
	for <lists+linux-arch@lfdr.de>; Thu, 11 May 2023 11:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236207AbjEKJBw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 11 May 2023 05:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235696AbjEKJBv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 11 May 2023 05:01:51 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA6E270E;
        Thu, 11 May 2023 02:01:49 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-61cd6191a62so37795906d6.3;
        Thu, 11 May 2023 02:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683795709; x=1686387709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KATKL5c9hHw7borFknSpolyvbkYiWwqKIKb81BIcugs=;
        b=LiA5aCThzGnNp7E+Ta+DAvVEwiclZpF791zLAUwx+Als8erWN8Yl7PpwtloKY7vfA7
         +VTsnl2KSlBmbyAImxRU3lG+IUT2Wqb5hUFCcAsZyEs/D1k9iAGqD79kt7aecJ/Cxj9r
         eR6nzEnIzjucsN/6A+1hNPz8FvRo+Kuj2ketbPBiwSj1JqzajAiKbzNVkW/c2RJBCR3k
         MZC8rrsOEhbdZrX91ntkakGdeHJHeYwEVqGe6cUOqDaw42N8TysvScbiMKu+APTP9eCY
         3fchxaSfDDqrX5GvKxMc/O6qbvizbF/orFqeAlT1EFH85PiOL82QGmIN8EQXMGf+kfzf
         4sBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683795709; x=1686387709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KATKL5c9hHw7borFknSpolyvbkYiWwqKIKb81BIcugs=;
        b=Jm/KMUODbh3xfPvkr3EYAuyjraxkpSRfZkRQWRGd5Ni7IbcADn0Gmc1VLLk98s3z9m
         EJiGkpqjUQ0tC5HxHf5YZV60s6UtPPlkQVdvm1h5pJJfRPKiEimnTlRB++OjkWSIbF1u
         Otn7mvfa886ruINYOtyRdbugYpAEWTVDfBlwLVsI/hr6ywsN1DPKMkLXjOMOAxk0bjQI
         BReSDiab4UPJnzoyBDJF/InErcCr4JvBpVbZtqVsXUCilmTZdMG/tIE+WNT/sUn3melK
         AwkghZc3Z2AqjhrL9anBDdH2kmoFl5puCzyT3onzJXq4BvaJliEsaRKyGpK3Vl9CYXB2
         A1bg==
X-Gm-Message-State: AC+VfDyzC7lf57fXKzBy/EGTdDQtdzE/qz8MHkRSvRizewlVNRHhKu+W
        W+53RpRqW6fi3BHHecNDevm8P/xI+BC0LyHZF2Q=
X-Google-Smtp-Source: ACHHUZ5zRYnTHqc+5jEp+WommdN4iUlzGKKD+R//mFSlux2Z635gESR+gw4QOQ+7Eia9GPcOqFZAyzIfjtGm1Vv4yks=
X-Received: by 2002:a05:6214:4018:b0:5ef:3b9a:b01d with SMTP id
 kd24-20020a056214401800b005ef3b9ab01dmr25843220qvb.1.1683795708608; Thu, 11
 May 2023 02:01:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230510195806.2902878-1-nphamcs@gmail.com> <CAMuHMdV=PNCb1VYfUkEb9rPwGVB=1tkwvm-XBqECyhHR4SNGKg@mail.gmail.com>
In-Reply-To: <CAMuHMdV=PNCb1VYfUkEb9rPwGVB=1tkwvm-XBqECyhHR4SNGKg@mail.gmail.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Thu, 11 May 2023 02:01:37 -0700
Message-ID: <CAKEwX=Pty0V0m+_00F1uWR1EXt8Gt35PYh-yUZEd-LQRSKgfGQ@mail.gmail.com>
Subject: Re: [PATCH] cachestat: wire up cachestat for other architectures
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org, kernel-team@meta.com,
        linux-arch@vger.kernel.org, hannes@cmpxchg.org,
        richard.henderson@linaro.org, ink@jurassic.park.msu.ru,
        mattst88@gmail.com, linux@armlinux.org.uk, monstr@monstr.eu,
        tsbogend@alpha.franken.de, James.Bottomley@hansenpartnership.com,
        deller@gmx.de, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, ysato@users.sourceforge.jp, dalias@libc.org,
        glaubitz@physik.fu-berlin.de, davem@davemloft.net,
        chris@zankel.net, jcmvbkbc@gmail.com, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 11, 2023 at 12:01=E2=80=AFAM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Nat,
>
> On Wed, May 10, 2023 at 9:58=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wro=
te:
> > cachestat is previously only wired in for x86 (and architectures using
> > the generic unistd.h table):
> >
> > https://lore.kernel.org/lkml/20230503013608.2431726-1-nphamcs@gmail.com=
/
> >
> > This patch wires cachestat in for all the other architectures.
> >
> > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> > ---
> >  arch/alpha/kernel/syscalls/syscall.tbl      | 1 +
> >  arch/arm/tools/syscall.tbl                  | 1 +
>
> Looking at the last addition of a syscall (commit 21b084fdf2a49ca1
> ("mm/mempolicy: wire up syscall set_mempolicy_home_node"), it looks
> like you forgot to update arm64 in compat mode? Or is that not needed?

It does look like I missed that! Thanks for the reminder. I'll send a fixle=
t
shortly...

Best,
Nhat

>
> >  arch/ia64/kernel/syscalls/syscall.tbl       | 1 +
> >  arch/m68k/kernel/syscalls/syscall.tbl       | 1 +
>
> For m68k:
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
> >  arch/microblaze/kernel/syscalls/syscall.tbl | 1 +
> >  arch/mips/kernel/syscalls/syscall_n32.tbl   | 1 +
> >  arch/mips/kernel/syscalls/syscall_n64.tbl   | 1 +
> >  arch/mips/kernel/syscalls/syscall_o32.tbl   | 1 +
> >  arch/parisc/kernel/syscalls/syscall.tbl     | 1 +
> >  arch/powerpc/kernel/syscalls/syscall.tbl    | 1 +
> >  arch/s390/kernel/syscalls/syscall.tbl       | 1 +
> >  arch/sh/kernel/syscalls/syscall.tbl         | 1 +
> >  arch/sparc/kernel/syscalls/syscall.tbl      | 1 +
> >  arch/xtensa/kernel/syscalls/syscall.tbl     | 1 +
> >  14 files changed, 14 insertions(+)
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds
