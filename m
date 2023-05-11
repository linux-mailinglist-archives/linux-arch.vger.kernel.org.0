Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9536FFA2C
	for <lists+linux-arch@lfdr.de>; Thu, 11 May 2023 21:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239159AbjEKTeg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 11 May 2023 15:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232629AbjEKTef (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 11 May 2023 15:34:35 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C1F59D0;
        Thu, 11 May 2023 12:34:34 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-619be7d7211so42158626d6.3;
        Thu, 11 May 2023 12:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683833674; x=1686425674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OkRg4aBIGd+Ujeyjhqn0VJEzJVlq0iY77Z11k0mAFFM=;
        b=D8VOr21Fczrl0K1COf0x4Ck7WHMsRogiYEEbrY2VpNny+n3MR+tJuDH09I9YAsS652
         swT6GvFknXTnMBZPWlOxHk2u05+SeKUhRFMH/ZtDMNfuFTmqhV28jtrPoFuIwQ/bqAzu
         JEHJCZ22+ejNPu9sQ5B4mFAObz8laeWoYTSRIa0MiOnPq0OszLg5zmMrWPnpqMS2qlwN
         5gjqnyxgdjPUMVEd0f/03my+5DYNfTma/sJ3vnrs+cTqKEwezFl9LOtEmPAD5vfhXfNX
         JrpZrTJ+uj1uIfEyrp6lAwR5J8sidiziH5Wld/lDfUFxzbjgvyiL15VatExShfnoJdEm
         /ImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683833674; x=1686425674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OkRg4aBIGd+Ujeyjhqn0VJEzJVlq0iY77Z11k0mAFFM=;
        b=I+e0iSK5LM2XRHfR9+c8Jb9mN0NXDz/nBDRNymh9Jue2t28UrKxRqYi2LAE/un8HXU
         l/OOq8L0LY8OQVbmwAoWH/BaM0Ae7AY9L0YOjjmHDWt730qnBQmLmnym9oZ0iBbXqNd4
         gVWJ/+zsy+LxKr+tRpoHswUe1SZbbfIEoedYAQpdDDuJhDQ9bPUD+tQZOHpUrKSAnejI
         9u0b9DBVMJn0eyhNC8EAk9eFmoxMjQNvibNIGd9h2L1Z5YH86xENlUi8nWwFAHrkiOJK
         PSsMWFQ6fFXlQaVDIh+PXUezizXqkF3zz0KM+XkAcsoqlQlFCMJuRs4XbetYVKblN/5h
         jOmQ==
X-Gm-Message-State: AC+VfDzTm74CQfiyLWsMkFQ3vTps7tfH1fUU0rEwsZ8jQoJJSlcyDrj/
        Q3nS9z5o1ebkDUsZdHKTVKEx7Y1ZNHkeOKrul8Y=
X-Google-Smtp-Source: ACHHUZ6FKXu0op+KxzAVHeFuNCXe2D1xFAp09jFVR7D1aeGdyycJWyp3G5ZLoEExaajX1pb4elh/5/+JF1DIDbKGBFc=
X-Received: by 2002:ad4:5dec:0:b0:5a1:6212:93be with SMTP id
 jn12-20020ad45dec000000b005a1621293bemr33993641qvb.29.1683833673901; Thu, 11
 May 2023 12:34:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230510195806.2902878-1-nphamcs@gmail.com> <874joja6vz.fsf@mail.lhotse>
In-Reply-To: <874joja6vz.fsf@mail.lhotse>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Thu, 11 May 2023 12:34:23 -0700
Message-ID: <CAKEwX=OHMaUzEG9hoMz20m9DnyFD4xC78KiNV1Qu0bUhkrYhAA@mail.gmail.com>
Subject: Re: [PATCH] cachestat: wire up cachestat for other architectures
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org, kernel-team@meta.com,
        linux-arch@vger.kernel.org, hannes@cmpxchg.org,
        richard.henderson@linaro.org, ink@jurassic.park.msu.ru,
        mattst88@gmail.com, linux@armlinux.org.uk, geert@linux-m68k.org,
        monstr@monstr.eu, tsbogend@alpha.franken.de,
        James.Bottomley@hansenpartnership.com, deller@gmx.de,
        npiggin@gmail.com, christophe.leroy@csgroup.eu, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        ysato@users.sourceforge.jp, dalias@libc.org,
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 10, 2023 at 8:23=E2=80=AFPM Michael Ellerman <mpe@ellerman.id.a=
u> wrote:
>
> Nhat Pham <nphamcs@gmail.com> writes:
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
> >  arch/ia64/kernel/syscalls/syscall.tbl       | 1 +
> >  arch/m68k/kernel/syscalls/syscall.tbl       | 1 +
> >  arch/microblaze/kernel/syscalls/syscall.tbl | 1 +
> >  arch/mips/kernel/syscalls/syscall_n32.tbl   | 1 +
> >  arch/mips/kernel/syscalls/syscall_n64.tbl   | 1 +
> >  arch/mips/kernel/syscalls/syscall_o32.tbl   | 1 +
> >  arch/parisc/kernel/syscalls/syscall.tbl     | 1 +
> >  arch/powerpc/kernel/syscalls/syscall.tbl    | 1 +
>
> With the change to the selftest (see my other mail), I tested this on
> powerpc and all tests pass.

Saw the change you proposed, Michael! It looks good to me.
Thanks for helping me make the selftest suite more robust :)

>
> Tested-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
>
>
> cheers
