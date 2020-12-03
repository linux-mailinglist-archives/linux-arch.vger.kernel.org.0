Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2139C2CE172
	for <lists+linux-arch@lfdr.de>; Thu,  3 Dec 2020 23:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbgLCWOa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Dec 2020 17:14:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727990AbgLCWOa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Dec 2020 17:14:30 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B015C061A51;
        Thu,  3 Dec 2020 14:13:50 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id o7so1958988pjj.2;
        Thu, 03 Dec 2020 14:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=eEmxf4uLm5+F9e4VAD5l7evhNTpueoEKmJf7NHBSgF8=;
        b=UPHGqln5b2MVwkQJ9DPW4W+c/WOYPO4pDdYgSkuUBuPAEool6k1o9tCh15tbT9uHrK
         Att6CPPLElr2Kizx6k8SBYlHiYybik+D2pHNYrEi6lvIa/OVMCqcofSbjZiFQCWNagWm
         gpfCcQKaP4yJ2ZfKAd6w0i3b/1ey0c1DO4esRuIh3lZT4EjH/cz8VKCKfqyuShuaeYhd
         x0YLD40CLwN02ITpU2TIn1dchmgPuXgxg9Hw3uQ8i6iktCUFcnDMyR1iVOdnAXdjnV9J
         dlREfCYAI47ZTNuw4m686ZqB4sYG5SbZx+ElCOdLB971GcExKVCtR58og1IlVpDkeiRG
         GVzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=eEmxf4uLm5+F9e4VAD5l7evhNTpueoEKmJf7NHBSgF8=;
        b=FlNZE4b7yFP1PfUPA3ekk+GiwxBmDE118Ls7F0vMiP528wUfo4cjDJ6fm1CjSO3EPk
         MBglHtPIi9TOx9yf4cFy23CgSfjdamvux5rzG+ameVYQhUveu0fYdS5cHBkhbMcOB2JS
         ZpXXqibHveSV7orjuqOkvCYCOy0TdpV9D58xQfk5ZKNHfoNVGoVin4OXaQoQb3Btnu4B
         0JrJ85C0Cu7fct3Aa8a2E9IVi1sSjtRSz5cOMTUvSnizpUk2cY3MtCq4AiFqJNxrGqCT
         +lXuII9YQYEUxpsKDqDHyMrC1188UG0Ii0xjMfbUmCCm0WtWDmNcZpe3Hva3MG14MKNS
         eOpw==
X-Gm-Message-State: AOAM531YGhfHr/4Tzs/Wwok9GxO/I0T2YqWyjMupQUBdIxOOJQfpXuiX
        jSgjSlq5RLOjHE+UjJbuqjQ=
X-Google-Smtp-Source: ABdhPJz9kr0b40p8QhJurdR1DemR7fcJ+w7w3vdRbJJ4sHZwhGLmJpARUd3RcgIEF27oxEAuC/OzQg==
X-Received: by 2002:a17:90a:d308:: with SMTP id p8mr1145716pju.110.1607033630047;
        Thu, 03 Dec 2020 14:13:50 -0800 (PST)
Received: from localhost ([2001:8004:1480:55d9:df22:9c5d:bdf7:7c2b])
        by smtp.gmail.com with ESMTPSA id kb12sm318120pjb.2.2020.12.03.14.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 14:13:49 -0800 (PST)
Date:   Fri, 04 Dec 2020 08:13:40 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [MOCKUP] x86/mm: Lightweight lazy mm refcounting
To:     Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Anton Blanchard <anton@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Rik van Riel <riel@surriel.com>,
        Will Deacon <will@kernel.org>, X86 ML <x86@kernel.org>
References: <7c4bcc0a464ca60be1e0aeba805a192be0ee81e5.1606972194.git.luto@kernel.org>
        <20201203084448.GF2414@hirez.programming.kicks-ass.net>
In-Reply-To: <20201203084448.GF2414@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-Id: <1607033145.hcppy9ndl4.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Peter Zijlstra's message of December 3, 2020 6:44 pm:
> On Wed, Dec 02, 2020 at 09:25:51PM -0800, Andy Lutomirski wrote:
>=20
>> power: same as ARM, except that the loop may be rather larger since
>> the systems are bigger.  But I imagine it's still faster than Nick's
>> approach -- a cmpxchg to a remote cacheline should still be faster than
>> an IPI shootdown.=20
>=20
> While a single atomic might be cheaper than an IPI, the comparison
> doesn't work out nicely. You do the xchg() on every unlazy, while the
> IPI would be once per process exit.
>=20
> So over the life of the process, it might do very many unlazies, adding
> up to a total cost far in excess of what the single IPI would've been.

Yeah this is the concern, I looked at things that add cost to the
idle switch code and it gets hard to justify the scalability improvement
when you slow these fundmaental things down even a bit.

I still think working on the assumption that IPIs =3D scary expensive=20
might not be correct. An IPI itself is, but you only issue them when=20
you've left a lazy mm on another CPU which just isn't that often.

Thanks,
Nick
