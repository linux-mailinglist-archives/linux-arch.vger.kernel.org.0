Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C756A2CF958
	for <lists+linux-arch@lfdr.de>; Sat,  5 Dec 2020 05:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgLEEty (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Dec 2020 23:49:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbgLEEtu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Dec 2020 23:49:50 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9783C061A4F;
        Fri,  4 Dec 2020 20:49:10 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id b5so488028pjl.0;
        Fri, 04 Dec 2020 20:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=8K5w8jDXkKIlAngW/XG7feDMYwmdKQNqo3uNmj5tiHg=;
        b=hYrtKqIDsBey9XtGHSIn0Bg7onNveij1HRFaHy9NAT8RO52Hqr03V26BGscp7X7CN+
         yd8n/Zyn0Umq/3pX7RhQIKWuCYjKZwO48ER0FE07sfBRLKZO8pbMUWpMA6O98+eFyGm+
         RXFHC3/u1Vi82UHwVdkjVhC5qnvJa/xn7RUpM+ytoWsqMa/zo+5rH4A8NXU3H+jrBO2V
         ODKk31Gfzzq4v622z7u+bLuqoFNUe/5RydNnSz3bWku7+Grocps27gRlbTEx6RhCdG6f
         cX1hU41DTIG/zzPiDOHGcoEx5siB5+6BI/RQp/Mw44cS6if02xsNGtcme+Gjq041HeQV
         xf7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=8K5w8jDXkKIlAngW/XG7feDMYwmdKQNqo3uNmj5tiHg=;
        b=K46oyUcCajdVJQdnjqn7SFKuxG0BupI13eB6ChLRSrusnDZ7rnGyLgxdnkirlSnEnD
         4pcE+uxb2GEPAfnyUJ9wB1otpUPqT57fA87vKhyboiIhNcbla7Uz3OSdpwUzM24yhvNF
         S1/dQQzbrU6p2KLgiM2Y1+Licsp/F7zGEMUClkSGxnAkAzUAbfzgK0sll//HhbvbHKGl
         OFekqyKZpKSfBVGjAKGg1pbbtP7EiEXnYIK6IxtZ+u81H1zB3m5HHtejg2mpmEMN6aq1
         sfNmTXvAJK87fozvmmqLdz8dgAgdauTK1r3hk7205VUcLco4zjKciX+tSy19upq4de+s
         pc0w==
X-Gm-Message-State: AOAM530S7uGNjmDhh9UFbdYLMlYidTh3S4lqTxOQd03+3PQkUL97Fj6Y
        oYGbossiUeCv27N+TO70G4k=
X-Google-Smtp-Source: ABdhPJw/E26yjJEohaTP7ApEdDRtaSfWTjVTMQOkzfNuPiHlz5TFw2OnaE0hnGXZ8o7aQSs7ynbtnA==
X-Received: by 2002:a17:90a:9289:: with SMTP id n9mr4238282pjo.67.1607143750294;
        Fri, 04 Dec 2020 20:49:10 -0800 (PST)
Received: from localhost ([1.129.238.242])
        by smtp.gmail.com with ESMTPSA id 126sm5352861pgg.46.2020.12.04.20.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 20:49:09 -0800 (PST)
Date:   Sat, 05 Dec 2020 14:49:04 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC v2 2/2] [MOCKUP] sched/mm: Lightweight lazy mm refcounting
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Anton Blanchard <anton@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jann Horn <jannh@google.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        Will Deacon <will@kernel.org>, X86 ML <x86@kernel.org>
References: <1607065599.ecww2w3xq3.astroid@bobo.none>
        <D9715BFE-744E-49B4-A10B-32735123BE6D@amacapital.net>
In-Reply-To: <D9715BFE-744E-49B4-A10B-32735123BE6D@amacapital.net>
MIME-Version: 1.0
Message-Id: <1607141044.0ibmnpwoeq.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Andy Lutomirski's message of December 5, 2020 12:37 am:
>=20
>=20
>> On Dec 3, 2020, at 11:54 PM, Nicholas Piggin <npiggin@gmail.com> wrote:
>>=20
>> =EF=BB=BFExcerpts from Andy Lutomirski's message of December 4, 2020 3:2=
6 pm:
>>> This is a mockup.  It's designed to illustrate the algorithm and how th=
e
>>> code might be structured.  There are several things blatantly wrong wit=
h
>>> it:
>>>=20
>>> The coding stype is not up to kernel standards.  I have prototypes in t=
he
>>> wrong places and other hacks.
>>>=20
>>> There's a problem with mm_cpumask() not being reliable.
>>=20
>> Interesting, this might be a way to reduce those IPIs with fairly=20
>> minimal fast path cost. Would be interesting to see how much performance=
=20
>> advantage it has over my dumb simple shoot-lazies.
>=20
> My real motivation isn=E2=80=99t really performance per se. I think there=
=E2=80=99s considerable value in keeping the core algorithms the same acros=
s all architectures, and I think my approach can manage that with only a si=
ngle hint from the architecture as to which CPUs to scan.
>=20
> With shoot-lazies, in contrast, enabling it everywhere would either malfu=
nction or have very poor performance or even DoS issues on arches like arm6=
4 and s390x that don=E2=80=99t track mm_cpumask at all.  I=E2=80=99m sure w=
e could come up with some way to mitigate that, but I think that my approac=
h may be better overall for keeping the core code uniform and relatively st=
raightforward.

I'd go the other way. The mm_cpumark, TLB, and lazy maintainence is=20
different between architectures anyway. I'd keep the simple refcount,
and the pretty simple shoot-lazies approaches for now at least until
a bit more is done on other fronts. If x86 is shooting down lazies on=20
the final TLB flush as well, then I might be inclined to think that's
the better way to go in the long term. Shoot-lazies would be a bit of
a bolted on hack for powerpc/hash but it has ~zero impact to core code
really.

Thanks,
Nick
