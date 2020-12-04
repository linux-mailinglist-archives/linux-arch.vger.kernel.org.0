Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEDB2CE900
	for <lists+linux-arch@lfdr.de>; Fri,  4 Dec 2020 08:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387507AbgLDHzp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Dec 2020 02:55:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387487AbgLDHzo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Dec 2020 02:55:44 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DE7C061A51;
        Thu,  3 Dec 2020 23:54:48 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id p6so2662378plo.6;
        Thu, 03 Dec 2020 23:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=Zd7vmIfn6mzRaP11y/d7gH60I8gBLNa0mgMkL/toHvQ=;
        b=D7BZBLvP7Hf1hmbzDKHSvvrVMOcvwF3AuA29oTyK7LjSZGu/VvtRnPQYcM5WAhLexX
         7bxa66KLQ1nPLAHY7ASZKpcwj5k4Gj/sH6hD+9zfRuCPL4Lu5Awdy7z/+hdMDs8coD6V
         l8QYpI7vYdOmv55h5fB66u95Ohlgdwe0LaK+5MOxosaBfJT8hPUQpfvR3VXriGDatcPY
         gC/wXJZUtokL+ZYqMSshMZD74n/sJqggisoqq4cqL2SS5depbndddaDAtLka4PdXM3mG
         ge7JlJgFKZL1EYg7DD8hAPDTSPAXEGItK4mF9rjhF/tHePvbjm4v2usCJOMPjNtlHjbc
         kstQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=Zd7vmIfn6mzRaP11y/d7gH60I8gBLNa0mgMkL/toHvQ=;
        b=uaf+Nhw1g5nyUwWq0gP5aMyfBQ+FLtmS36wrdhz6AXYZP8F97OBgQnLF0QZa7HGxdV
         39Vnvz4i4WEbLcD9oprv9rNY/W5HbwoFu2aX7JvSKwAETH2KEI53orVugDZXuJI8JATj
         arIpVEYPED8ORxZ2H/fibP55740z8X4uW6wWT2hkJaoNuU0zigneHdUAIwQ7h4Iz7AoN
         g8jOYJwQ9MGdhfsAHttnwN3PKFO92C5kBStm/CK+xfzexf6Rhtvob3MmdR+nD3nNzyGW
         Q5als/pJ4C7JdAIVg2PWHoAXweNSalsHzMCuOOfvY8zETkRY+RgpInPqbH6NRJecV7Vi
         zeAg==
X-Gm-Message-State: AOAM532OAayMlixlhAxZpLh1gPEDjNb+b6yIHC8CF3Y+mjHawdhx6pDx
        Yulxxu1ym6DZtSXGXKWjzz0=
X-Google-Smtp-Source: ABdhPJxeaLakUaj4UZ6Mhmu/RUCo9vMWAs3X7UoKC0s3gdL5d5oy/Bq+kELLNyqZeAnUbZAiHbipyw==
X-Received: by 2002:a17:902:a388:b029:da:bad:ed3 with SMTP id x8-20020a170902a388b02900da0bad0ed3mr2711686pla.76.1607068487823;
        Thu, 03 Dec 2020 23:54:47 -0800 (PST)
Received: from localhost ([1.129.136.201])
        by smtp.gmail.com with ESMTPSA id f15sm1346786pju.49.2020.12.03.23.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 23:54:47 -0800 (PST)
Date:   Fri, 04 Dec 2020 17:54:40 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC v2 2/2] [MOCKUP] sched/mm: Lightweight lazy mm refcounting
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Anton Blanchard <anton@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jann Horn <jannh@google.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        Will Deacon <will@kernel.org>, X86 ML <x86@kernel.org>
References: <cover.1607059162.git.luto@kernel.org>
        <e69827244c2f1e534aa83a40334ffa00bafe54c2.1607059162.git.luto@kernel.org>
In-Reply-To: <e69827244c2f1e534aa83a40334ffa00bafe54c2.1607059162.git.luto@kernel.org>
MIME-Version: 1.0
Message-Id: <1607065599.ecww2w3xq3.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Andy Lutomirski's message of December 4, 2020 3:26 pm:
> This is a mockup.  It's designed to illustrate the algorithm and how the
> code might be structured.  There are several things blatantly wrong with
> it:
>=20
> The coding stype is not up to kernel standards.  I have prototypes in the
> wrong places and other hacks.
>=20
> There's a problem with mm_cpumask() not being reliable.

Interesting, this might be a way to reduce those IPIs with fairly=20
minimal fast path cost. Would be interesting to see how much performance=20
advantage it has over my dumb simple shoot-lazies.

For powerpc I don't think we'd be inclined to go that way, so don't feel=20
the need to add this complexity for us alone -- we'd be more inclined to=20
move the exit lazy to the final TLB shootdown path, which we're slowly=20
getting more infrastructure in place to do.

(The powerpc hash MMU code which we're slowly moving away from might=20
never get that capability because it's complex there and hard to do with
that virtualisation model so current big systems (and radix MMU until we
finish the TLB flushing stuff) want something here, but for those the
shoot-lazies could quite likely be sufficient)

But if core code was moved over to something like this for the benefit of
others archs we'd probably just as happily do that.

There's a few nits but I don't think I can see a fundamental problem=20
yet.

Thanks,
Nick
