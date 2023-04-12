Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445EF6DF75E
	for <lists+linux-arch@lfdr.de>; Wed, 12 Apr 2023 15:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjDLNiF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Apr 2023 09:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjDLNiE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Apr 2023 09:38:04 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE2340F2;
        Wed, 12 Apr 2023 06:38:02 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id bj35so4378019qkb.7;
        Wed, 12 Apr 2023 06:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681306682; x=1683898682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WWdLpuhyNb11g+2phf0ujfTe5bokf6y5zMA0DxQiBiA=;
        b=B/jjBNSTypcC+joaCW6KBpHZMJp0zGfpqOXg+zBPIJ4NWlwYrPSMxjdSJy75T7U+3W
         U3p3HotHjbkZlaRKmFC8qc1Afx6oeTJ5uQpH2hG5w6sceSXtWvhwqD0ty4GTJOrTqqUL
         idO/30jacGJYN69+SVScPsn3OHD9k8oRdDeFIGHLcMZu3eu8rF9Xwdo+4T1+slcDtYsU
         YH0NOP8VGLe82rREMYx2QH+7wkX8dWpsJjPbWWLufPzhXmFeBT9DiKG3mgcWZ9nD2lka
         J4Q7aWlsb6BWQEoFbqY6WJkyrIjqnRCGYJf4CUJlNWaYPJ0je3GRhXlmjShv2pC79kPd
         uijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681306682; x=1683898682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WWdLpuhyNb11g+2phf0ujfTe5bokf6y5zMA0DxQiBiA=;
        b=b6gBQOYwn0iv6j28deCPgMLLksHtVWvph94bSzJdnLF+eBjV2wF3XjmJ1prFZrdHYU
         Ac9Fa6HZR3LHWVeJhKeiBG6V1DZ8iBpipYwJVQkgDQPfWcYmKdmIe63FQ28dq99VOFgW
         a3oxs0sgKdKVhxjubS5iuqkBkJmhLG4hgBwNQ38zte8uuroy1kajWTCk+pFqOtgQzm+y
         Yw7sTMLu0XTVzVrjTzav8PlihjuCCwGHu9SWNQs0oL4+UjvJelfxqBwMYlhJBn9uZ74+
         XKFGLGy7nlmcGZHZFvfYZtbWrlVlDifU/zvJaorRO5FrfPeXPMl19toEN4Ut4qiIpZQU
         R7bA==
X-Gm-Message-State: AAQBX9dmLvbkbOCHa4I7kp452wdamYNpIBB1ZuEgl0I08sBI5+YjTpIL
        UuYqCkyVnuicMXHfpa4M+Y11A4uSHw/Pvk9zUYM=
X-Google-Smtp-Source: AKy350bQZX93U7KKOQF4PJTiOvTycKd+ntmsVru9e/foHUOInkoawqILTSPuq4LXHeg8osg4IFMokyT1/kYfdkvFekQ=
X-Received: by 2002:a05:620a:4482:b0:746:83cd:8d1d with SMTP id
 x2-20020a05620a448200b0074683cd8d1dmr2165203qkp.6.1681306681702; Wed, 12 Apr
 2023 06:38:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230405141710.3551-1-ubizjak@gmail.com> <20230405141710.3551-4-ubizjak@gmail.com>
 <20230412113231.GA628377@hirez.programming.kicks-ass.net>
In-Reply-To: <20230412113231.GA628377@hirez.programming.kicks-ass.net>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Wed, 12 Apr 2023 15:37:50 +0200
Message-ID: <CAFULd4aCNNcyQm3Av+KkWVXuU9Cb0G5H5cFmqVR_T5LwCW=YJA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] locking/arch: Wire up local_try_cmpxchg
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-alpha@vger.kernel.org, loongarch@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jun Yi <yijun@loongson.cn>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 12, 2023 at 1:33=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Wed, Apr 05, 2023 at 04:17:08PM +0200, Uros Bizjak wrote:
> > diff --git a/arch/powerpc/include/asm/local.h b/arch/powerpc/include/as=
m/local.h
> > index bc4bd19b7fc2..45492fb5bf22 100644
> > --- a/arch/powerpc/include/asm/local.h
> > +++ b/arch/powerpc/include/asm/local.h
> > @@ -90,6 +90,17 @@ static __inline__ long local_cmpxchg(local_t *l, lon=
g o, long n)
> >       return t;
> >  }
> >
> > +static __inline__ bool local_try_cmpxchg(local_t *l, long *po, long n)
> > +{
> > +     long o =3D *po, r;
> > +
> > +     r =3D local_cmpxchg(l, o, n);
> > +     if (unlikely(r !=3D o))
> > +             *po =3D r;
> > +
> > +     return likely(r =3D=3D o);
> > +}
> > +
>
> Why is the ppc one different from the rest? Why can't it use the
> try_cmpxchg_local() fallback and needs to have it open-coded?

Please note that ppc directly defines local_cmpxchg that bypasses
cmpxchg_local/arch_cmpxchg_local machinery. The patch takes the same
approach for local_try_cmpxchg, because fallbacks are using
arch_cmpxchg_local definitions.

PPC should be converted to use arch_cmpxchg_local (to also enable
instrumentation), but this is not the scope of the proposed patchset.

Uros.
