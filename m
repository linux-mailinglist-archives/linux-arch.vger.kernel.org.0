Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFA73B3BB9
	for <lists+linux-arch@lfdr.de>; Fri, 25 Jun 2021 06:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhFYEsE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 25 Jun 2021 00:48:04 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:55087 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229458AbhFYEsE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 25 Jun 2021 00:48:04 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4GB4FK3w17z9sW8;
        Fri, 25 Jun 2021 14:45:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1624596343;
        bh=uVkWgUgdzjG7EIytkJ0IMCXeV3RaBwOniskWOKBd278=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=JDhyVLTamP1ZDt17AIQgSDO8ma1v5gjn/ofgmOOsF4J5sDyV1yWXA5F963cwK7sYM
         5IW0BtJI1sHEG8k6TSOcu7N/ZCDWUN0seVheP5ao0lJWwAGcRWbo2KOhcA2S7ji6gW
         yRSsekFuyqKXevNI3PnmcY5dKUmt+c7ukfh0BqQzwzF70U0MwZo1WJkW4Z/TGDxnnG
         S4Hq66yS0g13tjLOxcy5xXMa0TwD6t1Fp4VrGaTUH72ZeI4bAGB1YtIf++f9G0lQkw
         dAd/Qdk8IBfUvZVDV97I6670A0H1AGsl4o+7ItxnsdLMNeiayGnZCXRVjC/WAPqZo4
         fsiwrBIx9ex5w==
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
In-Reply-To: <d22d196a-45ea-0960-b748-caab0e996c7c@csgroup.eu>
References: <cover.1618828806.git.christophe.leroy@csgroup.eu>
 <db6981c69f96a8c9c6dcf688b7f485e15993ddef.1618828806.git.christophe.leroy@csgroup.eu>
 <d22d196a-45ea-0960-b748-caab0e996c7c@csgroup.eu>
Date:   Fri, 25 Jun 2021 14:45:37 +1000
Message-ID: <874kdm1rim.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Hi Michael,
>
> Le 19/04/2021 =C3=A0 12:47, Christophe Leroy a =C3=A9crit=C2=A0:
>> Pagewalk ignores hugepd entries and walk down the tables
>> as if it was traditionnal entries, leading to crazy result.
>>=20
>> Add walk_hugepd_range() and use it to walk hugepage tables.
>
> I see you took patch 2 and 3 of the series.

Yeah I decided those were bug fixes so could be taken separately.

> Do you expect Andrew to take patch 1 via mm tree, and then you'll take
> patch 4 once mm tree is merged ?

I didn't feel I could take patch 1 via the powerpc tree without risking
conflicts.

Andrew could take patch 1 and 4 via mm, though he might not want to pick
them up this late.

I guess step one would be to repost 1 and 4 as a new series. Either they
can go via mm, or for 5.15 I could probably take them both as long as I
pick them up early enough.

cheers
