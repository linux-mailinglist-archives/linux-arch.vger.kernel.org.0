Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 771512CDC27
	for <lists+linux-arch@lfdr.de>; Thu,  3 Dec 2020 18:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731487AbgLCRPF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Dec 2020 12:15:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731388AbgLCRPF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Dec 2020 12:15:05 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13EC3C061A4E
        for <linux-arch@vger.kernel.org>; Thu,  3 Dec 2020 09:14:25 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id 4so1498468plk.5
        for <linux-arch@vger.kernel.org>; Thu, 03 Dec 2020 09:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=jpxIDRJby02bDSmzqib9oh8ZXDBqI+2pH5k0P2lzdWM=;
        b=aRJu1HO4xnNzb8jocw95sh/+CjsELYLpn2jhaJctdiBvV0Fo/IKe2d9DUjnFTVLurX
         Zz5jY6puhccVi4/XYJcF7M1WWjBZ/WYrYvOH0BlxpJnlRQ5Gv20I5Qa54qDavxIpMqu7
         46YMj6QXtaEh429/CwE53Heyk8rCED0kC2GVSiksY3g51x/NcNUwhV8nC9XoV+cO/mxt
         4h3T5yaHfoFjomEoJs048LrdfUJhUseSC4iy7RdIuoRUVb60jBp4vPTph+8LXJR4h17K
         q4oZzEwHYNz5a1MVWTTRm26Dfo5pZpVJIp2icQJRZ7CVgm0Yy3vM/31Kuj9RXfgsUNyL
         FvEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=jpxIDRJby02bDSmzqib9oh8ZXDBqI+2pH5k0P2lzdWM=;
        b=AYe2Pn6J5ZxBy6TUOMqA7WwXrxd78u+JJ8aN5dPbzINb6KkKJ3tScBkXr/nLrfC2lt
         hNAZS2xEv7Zs8+1rBdX3xYc0+YUsbKJU7ulAus3MKk4GuP/M769hS9nOnhB/PnRjy5Xp
         eJs+gxoYrRhV53C4P/U9RjXTW3KpfHsFRjbJo2vqYoNEJZWTI4el09QnbfRX6cqypgTp
         R9tog0tP645P5N7DCbrGwPL2zS87eUyOUFMqjZ1iSqhZyE7nQ0iD8Bw5+FeIHQL4HfRM
         BJf+9OWd2rnUoE0q68qDqNdduFm935ykyRVOn2sd0lVfu7ytjy0G6fmNyHS1lZwH0Qjn
         JqQg==
X-Gm-Message-State: AOAM533PGUGXa73uzXgaYhMt3nDmgWbvJD3lLh1WJzvo1A9yOmsbT6Yo
        3EZWH2KYuVBXhU2d/anc8HFQfA==
X-Google-Smtp-Source: ABdhPJwE4etOoyGMx9UOKs7yAhw7hgOhsifHtas0tGfE12clfk9l2UH+s+JZSLZnFMT+6hGUVEc2Aw==
X-Received: by 2002:a17:90a:5988:: with SMTP id l8mr120805pji.82.1607015664612;
        Thu, 03 Dec 2020 09:14:24 -0800 (PST)
Received: from ?IPv6:2600:1010:b02c:6432:59d6:b4ed:32aa:4315? ([2600:1010:b02c:6432:59d6:b4ed:32aa:4315])
        by smtp.gmail.com with ESMTPSA id t9sm30146pjq.46.2020.12.03.09.14.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Dec 2020 09:14:23 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 6/8] lazy tlb: shoot lazies, a non-refcounting lazy tlb option
Date:   Thu, 3 Dec 2020 09:14:22 -0800
Message-Id: <E6BC2596-6087-49F2-8758-CA5598998BBE@amacapital.net>
References: <20201203170332.GA27195@oc3871087118.ibm.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux-MM <linux-mm@kvack.org>, Anton Blanchard <anton@ozlabs.org>
In-Reply-To: <20201203170332.GA27195@oc3871087118.ibm.com>
To:     Alexander Gordeev <agordeev@linux.ibm.com>
X-Mailer: iPhone Mail (18B121)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



> On Dec 3, 2020, at 9:09 AM, Alexander Gordeev <agordeev@linux.ibm.com> wro=
te:
>=20
> =EF=BB=BFOn Mon, Nov 30, 2020 at 10:31:51AM -0800, Andy Lutomirski wrote:
>> other arch folk: there's some background here:

>=20
>>=20
>> power: Ridiculously complicated, seems to vary by system and kernel confi=
g.
>>=20
>> So, Nick, your unconditional IPI scheme is apparently a big
>> improvement for power, and it should be an improvement and have low
>> cost for x86.  On arm64 and s390x it will add more IPIs on process
>> exit but reduce contention on context switching depending on how lazy
>=20
> s390 does not invalidate TLBs per-CPU explicitly - we have special
> instructions for that. Those in turn initiate signalling to other
> CPUs, completely transparent to OS.

Just to make sure I understand: this means that you broadcast flushes to all=
 CPUs, not just a subset?

>=20
> Apart from mm_count, I am struggling to realize how the suggested
> scheme could change the the contention on s390 in connection with
> TLB. Could you clarify a bit here, please?

I=E2=80=99m just talking about mm_count. Maintaining mm_count is quite expen=
sive on some workloads.

>=20
>> TLB works.  I suppose we could try it for all architectures without
>> any further optimizations.  Or we could try one of the perhaps
>> excessively clever improvements I linked above.  arm64, s390x people,
>> what do you think?
>=20
> I do not immediately see anything in the series that would harm
> performance on s390.
>=20
> We however use mm_cpumask to distinguish between local and global TLB
> flushes. With this series it looks like mm_cpumask is *required* to
> be consistent with lazy users. And that is something quite diffucult
> for us to adhere (at least in the foreseeable future).

You don=E2=80=99t actually need to maintain mm_cpumask =E2=80=94 we could sc=
an all CPUs instead.

>=20
> But actually keeping track of lazy users in a cpumask is something
> the generic code would rather do AFAICT.

The problem is that arches don=E2=80=99t agree on what the contents of mm_cp=
umask should be.  Tracking a mask of exactly what the arch wants in generic c=
ode is a nontrivial operation.
