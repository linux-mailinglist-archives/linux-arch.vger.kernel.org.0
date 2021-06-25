Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF1923B4B19
	for <lists+linux-arch@lfdr.de>; Sat, 26 Jun 2021 01:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhFYXtO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 25 Jun 2021 19:49:14 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:57673 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229826AbhFYXtO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 25 Jun 2021 19:49:14 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4GBYZ30Gk2z9sTD;
        Sat, 26 Jun 2021 09:46:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1624664811;
        bh=mqjtE2ltdfXhC7NObFmQQYR+R0sNSDV94cZ9C2sgJWE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=LotHKufoVc972Qccm3q9JON0ByoiUAiSMVe5SwPkRZJDpTsdVD4cw+v/nY/gkR8v2
         QJNiSgqIiURMw9S1b23S//wFYWf/NEd5LsAPc+rUtf4P2+dr6mXZwPdnvSBmGyu3CY
         YXQ8Kg9+i4EmilyMjUDOWaVwLB3lpjG7rnQMr0gvN3WxVGUMpMnSAuJt+oVbk9ciPh
         RL0+3YcIUfM6V1l/gTtnbZRchDGQ0guwYpa7zskCrtrZljUZuLtfmI/9olnNjRsYk/
         EU/uxByT8/fsTMz9VgeQUGEGCiiN4ipVhN9rbDj2/tZtSh/cXw5CEvayeXs8EuELwe
         Z/qQlfPPksi5Q==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        akpm@linux-foundation.org
Cc:     linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Oliver O'Halloran <oohall@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Paul Mackerras <paulus@samba.org>, dja@axtens.net,
        Steven Price <steven.price@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2 1/4] mm: pagewalk: Fix walk for hugepage tables
In-Reply-To: <217a6b38-a6ac-84d5-e3dc-257331431bb2@csgroup.eu>
References: <cover.1618828806.git.christophe.leroy@csgroup.eu>
 <db6981c69f96a8c9c6dcf688b7f485e15993ddef.1618828806.git.christophe.leroy@csgroup.eu>
 <d22d196a-45ea-0960-b748-caab0e996c7c@csgroup.eu>
 <874kdm1rim.fsf@mpe.ellerman.id.au>
 <217a6b38-a6ac-84d5-e3dc-257331431bb2@csgroup.eu>
Date:   Sat, 26 Jun 2021 09:46:47 +1000
Message-ID: <87pmw9zevs.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 25/06/2021 =C3=A0 06:45, Michael Ellerman a =C3=A9crit=C2=A0:
>> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
>>> Hi Michael,
>>>
>>> Le 19/04/2021 =C3=A0 12:47, Christophe Leroy a =C3=A9crit=C2=A0:
>>>> Pagewalk ignores hugepd entries and walk down the tables
>>>> as if it was traditionnal entries, leading to crazy result.
>>>>
>>>> Add walk_hugepd_range() and use it to walk hugepage tables.
>>>
>>> I see you took patch 2 and 3 of the series.
>>=20
>> Yeah I decided those were bug fixes so could be taken separately.
>>=20
>>> Do you expect Andrew to take patch 1 via mm tree, and then you'll take
>>> patch 4 once mm tree is merged ?
>>=20
>> I didn't feel I could take patch 1 via the powerpc tree without risking
>> conflicts.
>>=20
>> Andrew could take patch 1 and 4 via mm, though he might not want to pick
>> them up this late.
>
> Patch 4 needs patches 2 and 3 and doesn't apply without them so it is not=
 that easy.

Ah duh, sorry.

> Maybe Andrew you can take patch 1 now and then Michael you can take patch=
 4 at anytime during 5.15=20
> preparation without any conflict risk ?

Yeah that would work.

>> I guess step one would be to repost 1 and 4 as a new series. Either they
>> can go via mm, or for 5.15 I could probably take them both as long as I
>> pick them up early enough.
>>=20
>
> I'll first repost patch 1 as standalone and see what happens.

Thanks.

cheers
