Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCD982CEFC4
	for <lists+linux-arch@lfdr.de>; Fri,  4 Dec 2020 15:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729948AbgLDOhs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Dec 2020 09:37:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728857AbgLDOhr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Dec 2020 09:37:47 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3930C0613D1
        for <linux-arch@vger.kernel.org>; Fri,  4 Dec 2020 06:37:07 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id y10so1730223plr.10
        for <linux-arch@vger.kernel.org>; Fri, 04 Dec 2020 06:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=MsPLvGvNf1bS+OcbC87Aqig/sgy85eIEfjyO8YBsPiY=;
        b=UZXXb5QnzDbiUmObhrI5+4AmF8IUYayIuqV+PYOsWzeVumt0pv+hpfTSPujXMvzxsg
         VE98zoWVezLv1/BweG0xNxMjuteXpdMc9E1H0CpA5qAHbUOpRBIDLOXg5xXFwyG4hPJF
         DatgzK3fAgnrUD8VF+DAOOoK+CatjFJtuKKKvrPgfumcFgOlu8FRfoBfzTgWSsL9ybKB
         CY5brTbzShCgh5IoMrRutefrxbAFCKO9JKGM8hYOix2tYmhtiAmxXRDia6kKIJc7rwHM
         vmZdMdrOJRtLdyxJlg9X/kONzYaAwZrajS4LoZEixlH8lMjxYJfzCdpJVXnp0K+Nzg/Q
         6zPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=MsPLvGvNf1bS+OcbC87Aqig/sgy85eIEfjyO8YBsPiY=;
        b=ciAuFVXYqAwdx7IQ2mBtydg41eiTfljUxmKvJZz7rNCqHPrMlD6Ki5/t5956UzljEr
         uiUUFmRRp7bm38EySQeaODbcIuH7+tz4Q3uW1q/T2d0S01/TFn++31ICujNycSJcUMOX
         aMuNrpGl5VCY7ZIHrDWR/azZdtyTPszDXXsTi5xa9hwfaERhgpRFDR6TgDKtXkpL2Dnd
         aZHbrn+wPL59rRQuMyDrqPm4LQ7elVEk723xU7B7ISkj2LyI9rBYmfNf8DFzgLM9Cd+3
         79MNKyxLgNiMtGCfeIQG2MAHhP36BxUevFjXkDXPBNa/96Ev8xs/udPiS2w0+ohyVEqe
         mvmA==
X-Gm-Message-State: AOAM532uLsdaVanMKWr7SOHIje3TZF2xaAbMpr0+EaxLl368RA/3nxKU
        KQBmGxuVpKpH7x23qtEn9gS7Cg==
X-Google-Smtp-Source: ABdhPJyFshwViMl5DvUfYhVdp5U1ntZBiV4Ra0suBVd3IWlDwG2haGuTFka/aH2GIM6E+E1x/nbi3A==
X-Received: by 2002:a17:90a:8582:: with SMTP id m2mr4423222pjn.199.1607092627307;
        Fri, 04 Dec 2020 06:37:07 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:e89d:8a3d:645c:8fa4? ([2601:646:c200:1ef2:e89d:8a3d:645c:8fa4])
        by smtp.gmail.com with ESMTPSA id m3sm4133967pgh.5.2020.12.04.06.37.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Dec 2020 06:37:06 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC v2 2/2] [MOCKUP] sched/mm: Lightweight lazy mm refcounting
Date:   Fri, 4 Dec 2020 06:37:04 -0800
Message-Id: <D9715BFE-744E-49B4-A10B-32735123BE6D@amacapital.net>
References: <1607065599.ecww2w3xq3.astroid@bobo.none>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Anton Blanchard <anton@ozlabs.org>,
        Arnd Bergmann <arnd@arndb.de>,
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
In-Reply-To: <1607065599.ecww2w3xq3.astroid@bobo.none>
To:     Nicholas Piggin <npiggin@gmail.com>
X-Mailer: iPhone Mail (18B121)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



> On Dec 3, 2020, at 11:54 PM, Nicholas Piggin <npiggin@gmail.com> wrote:
>=20
> =EF=BB=BFExcerpts from Andy Lutomirski's message of December 4, 2020 3:26 p=
m:
>> This is a mockup.  It's designed to illustrate the algorithm and how the
>> code might be structured.  There are several things blatantly wrong with
>> it:
>>=20
>> The coding stype is not up to kernel standards.  I have prototypes in the=

>> wrong places and other hacks.
>>=20
>> There's a problem with mm_cpumask() not being reliable.
>=20
> Interesting, this might be a way to reduce those IPIs with fairly=20
> minimal fast path cost. Would be interesting to see how much performance=20=

> advantage it has over my dumb simple shoot-lazies.

My real motivation isn=E2=80=99t really performance per se. I think there=E2=
=80=99s considerable value in keeping the core algorithms the same across al=
l architectures, and I think my approach can manage that with only a single h=
int from the architecture as to which CPUs to scan.

With shoot-lazies, in contrast, enabling it everywhere would either malfunct=
ion or have very poor performance or even DoS issues on arches like arm64 an=
d s390x that don=E2=80=99t track mm_cpumask at all.  I=E2=80=99m sure we cou=
ld come up with some way to mitigate that, but I think that my approach may b=
e better overall for keeping the core code uniform and relatively straightfo=
rward.

>=20
> For powerpc I don't think we'd be inclined to go that way, so don't feel=20=

> the need to add this complexity for us alone -- we'd be more inclined to=20=

> move the exit lazy to the final TLB shootdown path, which we're slowly=20
> getting more infrastructure in place to do.
>=20


>=20
> There's a few nits but I don't think I can see a fundamental problem=20
> yet.

Thanks!

I can polish the patch, but I want to be sure the memory ordering parts are c=
lear.

>=20
> Thanks,
> Nick
