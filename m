Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9239725F494
	for <lists+linux-arch@lfdr.de>; Mon,  7 Sep 2020 10:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgIGIIy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Sep 2020 04:08:54 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:54229 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbgIGIIK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Sep 2020 04:08:10 -0400
Received: from mail-qk1-f178.google.com ([209.85.222.178]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MCKSA-1kOVaG32kE-009TDD; Mon, 07 Sep 2020 10:08:06 +0200
Received: by mail-qk1-f178.google.com with SMTP id w12so12034242qki.6;
        Mon, 07 Sep 2020 01:08:06 -0700 (PDT)
X-Gm-Message-State: AOAM530Lt7Ge8htALiNSodmS8PmTmh+BjoiE+8cA1UYLOrBOl8V5RJDV
        IeC1Y6UTU5iN0SxqcKFYEYToMMuuMzbI4QV+hPo=
X-Google-Smtp-Source: ABdhPJyqFRCsrEeyEM7bZdvSSTo4jU+m6vlP8peN5tbIXRsYf0JCy1F91ON0vW5MemSI01VaMJ40x2L3jNNufU0/pXE=
X-Received: by 2002:a05:620a:15a7:: with SMTP id f7mr11286689qkk.3.1599466085512;
 Mon, 07 Sep 2020 01:08:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200904165216.1799796-1-hch@lst.de> <20200904165216.1799796-4-hch@lst.de>
 <20200904180617.GQ1236603@ZenIV.linux.org.uk> <20200904223518.GR1236603@ZenIV.linux.org.uk>
In-Reply-To: <20200904223518.GR1236603@ZenIV.linux.org.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 7 Sep 2020 10:07:49 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1doHskr=8uPrGetCAtD7QTRS5r=cfy6VJSoDsnE0=Aaw@mail.gmail.com>
Message-ID: <CAK8P3a1doHskr=8uPrGetCAtD7QTRS5r=cfy6VJSoDsnE0=Aaw@mail.gmail.com>
Subject: Re: [PATCH 3/8] asm-generic: fix unaligned access hamdling in raw_copy_{from,to}_user
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Ik2qRdFlVdhAn6JlAoBbd2pfoR4wBUPqIA0T58RvXJbcT3gJL0+
 hEP0ai5JoiDyDAneCWS5Wcpic55XLbv81dv/XriuW8y9Xqz7991iEBQfpj854vci6JeFoO5
 vgrdMPMfvqsVIZfZqiD7ogeFAuaD8di4aqRPCXiEdd6f1u9oCxB9rU0c1suNZn4gcXav2Xx
 whITIG/sSh8P4PMRti/aw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:SG9aYn68QoU=:/KyAVZouWZ2+3T5gAQXNRv
 gQNtxkxQ2YXy1Cdo5nSPRo8RslAqziUMSvKIGqBzIZb7vPWSZRx2i5v6Pa3ln87Ujyx9+k8rz
 YA4m9O76XmjPRAq7GLBHGshuWEEj062safYzLeIvu4/StAUQX19jSlghhMXf515cVzjhQcg1a
 f8Oe+4Jcq4SxLpoUAHT3YIlgwXCxk/G3LB//UOsS8D2KfbUXdvI32UUB2FU7SWy8yaS2UGEsZ
 n5gR9SakYDn8D1Pi3CDiNjWrZsebRxZH2P8auLne+Wt+lNdJD3v8jL/YJUN0scCituqGoPG/H
 LWfPeYxLcNVOGfE800WgA7qXVrwDskgEW0GuM9hP2PagRtbxtdI38HcclKiwuFQWX/5dOV1r6
 V+lIaazes8oPupL+VI8JMuHDgkJZC509ISun8nOcv7ShDnUYqHX5leXxh2u+NLcyA4Ljhb/1Y
 vP1pqGoj1ePAoTIvg4By2m2TGNR/GMCfUyEqkou9ehT/TDyvZd9w9GXdCiaBcSLpn1sexbIyB
 l0sIxn1qr7igUjRzj4r85sIMcJFjl7nRgOUpCEp2SjckG64BqWepef8hGv7W4/i+HYGqnkWtn
 rFRMnosE11RGe9Vxq4Q5pbAL1b423CTnKq7GkC/lqzx/+muDHwmcJpZ6+NvvNk9oYPFq7d8RE
 s4cUcTm4AdqXkHmTeucYc6xKehXzBjQix22I9i9mhFiJrGhl7+IFfhP1PHuZgry+FIlz/wSwD
 ex3JVwJOpxp1lReUjw5GudvQf56UG+xRo5Yk0G7WTTIpdZyCPZV+2ZoWgdjs50jojjNWvw+v7
 MSRnc7Gd+zD8IYOPRgxS1wIVVSZ3SxpIa6GsqDcwZqsp/WQJK45TZ0CuEZ63wYFWI0F6geQ
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Sep 5, 2020 at 12:35 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Fri, Sep 04, 2020 at 07:06:17PM +0100, Al Viro wrote:
> > On Fri, Sep 04, 2020 at 06:52:11PM +0200, Christoph Hellwig wrote:
> > > Use get_unaligned and put_unaligned for the small constant size cases
> > > in the generic uaccess routines.  This ensures they can be used for
> > > architectures that do not support unaligned loads and stores, while
> > > being a no-op for those that do.
> >
> > Frankly, I would rather get rid of those constant-sized cases entirely;
> > sure, we'd need to adjust asm-generic/uaccess.h defaults for __get_user(),
> > but there that kind of stuff would make sense; in raw_copy_from_user()
> > it really doesn't.

Right. When I originally wrote that part of asm-generic/uaccess.h, the
idea was that its __get_user()/__put_user() would end up being used
across most architectures, which then would only have to implement
custom __copy_from_user()/__copy_to_user() with those special cases
to get the optimum behavior. It didn't work out in the end, since
copy_from_user() also has to deal with unaligned or partial copies
that prevent it from degrading into a single instruction on anything
other than the simplest NOMMU architectures.

I'd still hope we can eventually come up with a generic
__get_user()/__put_user() helper that avoids all the common
architecture specific bugs in them, with a simpler way for
an architecture to hook into with a set of inline functions
while leaving the macros to common code, but that can be
done another time.

> IOW, there's a scattering of potentially valid uses that might be better
> off with get_user().  And there's generic non-MMU variant that gets
> used in get_user()/__get_user() on h8300 and riscv.  This one *is*
> valid, but I don't think that raw_copy_from_user() is the right layer
> for that.
>
> For raw_copy_to_user() the picture is similar.  And I'd like to get
> rid of that magical crap.  Let's not make it harder...

Agreed

         Arnd
