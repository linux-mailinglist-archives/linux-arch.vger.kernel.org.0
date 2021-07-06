Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D13D3BD750
	for <lists+linux-arch@lfdr.de>; Tue,  6 Jul 2021 14:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbhGFNCV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Jul 2021 09:02:21 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:36915 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbhGFNCT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Jul 2021 09:02:19 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M1YpJ-1m3mXh2ArT-0032dq for <linux-arch@vger.kernel.org>; Tue, 06 Jul
 2021 14:59:38 +0200
Received: by mail-wr1-f49.google.com with SMTP id t15so22622892wry.11
        for <linux-arch@vger.kernel.org>; Tue, 06 Jul 2021 05:59:38 -0700 (PDT)
X-Gm-Message-State: AOAM5320jCXbwKodJyK6WlrlgdSQRxecrKPzwpnkkwJH8y16ZR2TG4Qf
        c1OUml+SczUO64d2isBzfwaE9uZqtBneviP2p7Q=
X-Google-Smtp-Source: ABdhPJxzjDAAnw+w5vV3zC/gA7SFoPpwwlaMExT6OQvnYM3y3QZK/zELczlijXF40jjM1asj/U9nCTr3YFgcgjZIA4Q=
X-Received: by 2002:a5d:448c:: with SMTP id j12mr22616146wrq.105.1625576378223;
 Tue, 06 Jul 2021 05:59:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-5-chenhuacai@loongson.cn> <YOQ9MGbTrPKWl1N/@hirez.programming.kicks-ass.net>
In-Reply-To: <YOQ9MGbTrPKWl1N/@hirez.programming.kicks-ass.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 6 Jul 2021 14:59:22 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1wCYB6KgHP_ZbmEyPcoNkEzXD_RbNuuy13nA1pVP+Tqg@mail.gmail.com>
Message-ID: <CAK8P3a1wCYB6KgHP_ZbmEyPcoNkEzXD_RbNuuy13nA1pVP+Tqg@mail.gmail.com>
Subject: Re: [PATCH 04/19] LoongArch: Add common headers
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:O8Aq+mJfq1gp/rVnFzYXjlL569NAw8lWYDcQbF2744BdaDS3aV4
 4E5MBge9a1Y8Fr0iCbnfVHgCRGbhfvghSN7zDyG25V8C8W7POUamLP9TYI1ZclkvqJGWkYg
 Zzts6fOYZH5nInWsbHmooCsyhEeS+k6aZ6CyGyjo+jdxuYIChiA8zvHs2XmXsKcZY3WtATj
 ByL8hiqlOfg48NxcInrwg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:yFwEOSt+x1Q=:j9osSiTux/pXOLfH4rbr/q
 BCcJGhS/VU1/2p4xDr9HnN+COYUFmeQYiUD7abPhEp8M0G/PXlKroh4ARuDc6k3x4VDqpQMdz
 cYL1u8QLbo68ssOeQV6JCgYbce0IwiaCuiE9PIGsf1U1eniQZksyn5WbDPOauDPJUNWKpJ3BZ
 A/hcO0P2lnW0QqOr2zBxW6r0jnkZExmb1K11MPSMaP5gyjbbEuj1YLphSYCGSsYSJLwBre0Yf
 4hnsgsJGlrpxuKyxXPMkV68VPosQZtKiXoxKgX3jIbY4ZbyaSmAkQbHO/brMIQDV4UYl/62YY
 b+WpqYXSt543SKPYFDVe66s1RYARb+dKEGKjnsrLWwnB5NKOqkmE/xTSc0liigouRwVMthe+x
 ZTf6UxddEKekas4dRgRVo0uLFan3m0CbUalhe6Ij19Bk0sinNoCLyODfqNeDLeOuyg3FnCEEI
 y62mDWi/ulyxyBS62o+9Zyga2hVzIvM7wPkdyaU+VeMcmsAnN2v8T0zIr7ECFaU8T+dUFCD9z
 9dn/zx55jRYRzfMPs2wfcVsb4aIK1czVja33NpvWDCehe2dY8fbyYnlL8EQ+qE1qBWQCnagoC
 OEENGiSB7UFwHAykccY3Zw5fsMQhzSNpu6uudHS7LXS6eA2gM8+SHOFQ7EVXFsZFWdLT4/4Mt
 XUFGdBDKQs0t5df8pS5t9cE8fr1hV4ahU9ONTFtn1ffG6YkydT4uxl5/I7JsJ1yf3vlwYsuvf
 QWJ/YyGf+uEn815oF2l7XhyfEdoxyg6dPDYPVBCTEDwOQfHa0icaup3RyYdjOVeNZVuhTiVlI
 Tgb6V2Asar+67zp3FYlqVuOnjCHD1aJQHt9dN3lzVGj6DNZ/k6B7dYidpxVt9ebdKJ6p7m7Hp
 TzQGHhj4QaKH28dejKiVNq5M0ChO5aSBbroRPUOA1u83cPB6wjPAaGAz2u+5pJ0j7tL+CBKRa
 zfBgF32t5SKYpu5OO5kMAruVwmJ4PS7fBNZEueoDYBm/1m+thWBmN
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 6, 2021 at 1:23 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Jul 06, 2021 at 12:18:05PM +0800, Huacai Chen wrote:

> > +
> > +static inline u32 csr_xchgl(u32 val, u32 mask, u32 reg)
> > +{
> > +     return __csrxchg(val, mask, reg);
> > +}
> > +
> > +static inline u64 csr_xchgq(u64 val, u64 mask, u32 reg)
> > +{
> > +     return __dcsrxchg(val, mask, reg);
> > +}
>
> What are these __csrfoo() things, I cannot seem to find a definition of
> them anywhere..

It seems that those are provided as compiler intrinsics in <larchintrin.h>,
based on an architecture specific __builtin_loongarch_csrxchg() etc.

The specific registers are documented at
https://loongson.github.io/LoongArch-Documentation/LoongArch-Vol1-EN#control-and-status-registers

    Arnd
