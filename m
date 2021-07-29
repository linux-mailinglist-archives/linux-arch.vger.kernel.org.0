Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9F903DA93A
	for <lists+linux-arch@lfdr.de>; Thu, 29 Jul 2021 18:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbhG2Qif (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Jul 2021 12:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbhG2Qie (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Jul 2021 12:38:34 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16789C061765
        for <linux-arch@vger.kernel.org>; Thu, 29 Jul 2021 09:38:29 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id m13so7955682iol.7
        for <linux-arch@vger.kernel.org>; Thu, 29 Jul 2021 09:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1I/PiTIMevDJ5oxZvxPToAqcDbZO5YgQVHEqEdMZu+M=;
        b=F19Mw+/FzBDEZG0WaC02yp3PqSkL3KVX5gjY3EWMU7zbIfXx0GHuPKevlKR8EHTyF3
         9lRxbptXfusHdjv/DJRc3DI9mfpas8at4zciwHCkAAhlG2mh1wFlLfGu7OQP5qMgwgBH
         o80LKrZAdxHTK09IbDU+5RqUrs+BlYZ46OxJ6sD9A4KU4mjgo+P6Ipwe3ZbAgDr/t1mF
         8tJ1J/gy/IfTt+kOIILcaOAw7xcWc2jY0lTwZVyS4h+QRp6NxwgHqVYx1KDNDFaSYJ5z
         cEe06GzLngmbGTVzhIvDDMHB59T62PPf1wL7tKkdSpqo6RPMepF6tK2ayDkItgcf9eoh
         gGdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1I/PiTIMevDJ5oxZvxPToAqcDbZO5YgQVHEqEdMZu+M=;
        b=ZZqrE35APSCj0FHslA7YyT/3TCtx62N6fVFRXiBQ4au32Twc+A72+Wb0uRmktb6wk0
         by6amaW9d694F571ZHde0tW96GcTN1vvlHBj+5fZ+cAL0DxTPOmoT2+p7ZkdVUFMl2JW
         kYvsdUO/ApxBguUsByzC2OQyMB3rRJuOZopIF2126Mx70OkZGcmwXmDAUIjSARDMxIG+
         YC/ICRl3DJAu7fgUaolm/DHmkVP3ffVuXGqggVmhSIazVzXqp74JDV/by17mR1Rdl9eV
         Lub1PE3uLjvYsjd0WxOnlwLZPZ/fJ0nqm4vCqzz8FE9YKmvcxZ/TqggkSPp/WYSBEsrE
         i+Kg==
X-Gm-Message-State: AOAM530yopylxPJn0qGyjclQ+Yl3I2R++/A11VYY/BLKtE0RLybfmb4t
        VUmV0nJDix4jNt8ibKt7K03IUj91Aib+YZVJKPw=
X-Google-Smtp-Source: ABdhPJyM+U9w8FWfsnedsp2Es53GbJIHyT0ZL3cHoZa0clU8C4h6LwPEw0IZ/MFD3e2GnR4glPbdTadtEOp9t8YHu3E=
X-Received: by 2002:a6b:b24e:: with SMTP id b75mr4919009iof.94.1627576708463;
 Thu, 29 Jul 2021 09:38:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAMuHMdU8o2r0Tybz_z3hKLoMyNqL5A_RZ9DnCYR0pHeRMpgvWA@mail.gmail.com>
 <CAAhV-H4aNr2BuG1imx6RcfEQtarjbrUU+-_PbGRg4jX5ygr_iA@mail.gmail.com>
 <YP6Q3s5Kpg2A1NRZ@boqun-archlinux> <CAJF2gTQ98v8H3SYt8K0Mnq73xXtZ-2Ja7jOaP2Uo-fX+ZqYZBw@mail.gmail.com>
 <YP7q5GBweaeWgvcs@boqun-archlinux> <77e83baf-030c-1332-609c-6d3f01bd422a@redhat.com>
 <CAJF2gTQcmN0TdX2dMT5mqKBp2HJ15_7KzDnaM5VyHaCArrnfGA@mail.gmail.com>
 <YP9vp8/acj9TpwyZ@boqun-archlinux> <YP/oYc1A39bMS87H@hirez.programming.kicks-ass.net>
 <CAAhV-H7Jnoa3AOTjG_=+WvxkcjqDxYVU4jAudjnu8WMtAVyPCw@mail.gmail.com> <YQE5B6ecrnIoXhpI@hirez.programming.kicks-ass.net>
In-Reply-To: <YQE5B6ecrnIoXhpI@hirez.programming.kicks-ass.net>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Fri, 30 Jul 2021 00:38:14 +0800
Message-ID: <CAAhV-H6tQyb0o=ZBHp+LKi6LbOXwFD4JzBQjk1KkDhP2t5KmdA@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] arch: Introduce ARCH_HAS_HW_XCHG_SMALL
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Guo Ren <guoren@kernel.org>,
        Waiman Long <llong@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Rui Wang <wangrui@loongson.cn>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Peter,

On Wed, Jul 28, 2021 at 7:02 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Jul 28, 2021 at 06:40:54PM +0800, Huacai Chen wrote:
> > Hi, Peter,
> >
> > On Tue, Jul 27, 2021 at 7:06 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Tue, Jul 27, 2021 at 10:29:59AM +0800, Boqun Feng wrote:
> > >
> > > > > "How to implement xchg_tail" shouldn't force with _Q_PENDING_BITS, but
> > > > > the arch could choose.
> > > >
> > > > I actually agree with this part, but this patchset failed to provide
> > > > enough evidences on why we should choose xchg_tail() implementation
> > > > based on whether hardware has xchg16, more precisely, for an archtecture
> > > > which doesn't have a hardware xchg16, why cmpxchg emulated xchg16() is
> > > > worse than a "load+cmpxchg) implemeneted xchg_tail()? If it's a
> > > > performance reason, please show some numbers.
> > >
> > > Right. Their problem is their broken xchg16() implementation.
> >
> > Please correct me if I'm wrong. Now my understanding is like this:
> > 1, _Q_PENDING_BITS=1 qspinlock can be used by all archs, though it may
> > be not optimized.
>
> Only if your arch has fwd progress guarantees for cmpxchg(). LL/SC based
> cmpxchg() is tricky, and typically needs software based backoff on
> failure.
>
> The qspinlock code is written in generic code, but it very much relies
> on an architecture to audit and vet the resulting code is sane for them.
> Clearly MIPS didn't do a good job of that.
>
> > 2, _Q_PENDING_BITS=8 qspinlock can be used if hardware supports
> > sub-word xchg/cmpxchg, or the software emulation is correctly
> > implemented. But the current MIPS emulation is not correct.
>
> Everything always relies on things being correctly implemented. 1)
> relies on cmpxchg() being correctly implemented. 2) relies on xchg16()
> being correctly implemented.
>
> Of these 2 is actually easier to implement correctly on LL/SC.
>
> > If so, I want to rename ARCH_HAS_HW_XCHG_SMALL to
> > ARCH_HAS_FAST_XCHG_SMALL, and let these archs select it:
> > 1, X86, ARM, ARM64, IA64, M68K, because they have hardware support.
> > 2, Other archs who select qspinlock currently (including MIPS),
> > because their current behavior is use _Q_PENDING_BITS=8 qspinlock and
> > we don't want to change anything in this patch. If their emulation is
> > broken or not as "fast" as expected, we can make new patches to
> > unselect the ARCH_HAS_FAST_XCHG_SMALL option.
>
> I utterly fail to see the point of any of this. If you use qspinlock,
> you had better have audited the whole thing for your architecture. And
> FAST_XCHG_SMALL is completely irrelevant for anything here.
>
Our original goal of this patch is let LoongArch use qspinlock, but
Arnd let us remove xchg_small, so we want to let LoongArch use
_Q_PENDING_BITS=1 lock . :)

Now Rui Wang has a better solution, and xchg_small will be
reimplemented for LoongArch, so I think this patch is no longer
needed.

Huacai
