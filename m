Return-Path: <linux-arch+bounces-14590-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AC37CC43588
	for <lists+linux-arch@lfdr.de>; Sat, 08 Nov 2025 23:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F065934852E
	for <lists+linux-arch@lfdr.de>; Sat,  8 Nov 2025 22:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DB423A9B3;
	Sat,  8 Nov 2025 22:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="nMyctn4r"
X-Original-To: linux-arch@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502B4221DAD;
	Sat,  8 Nov 2025 22:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762641600; cv=none; b=UG4Ab5noywJ63aZF3cAR2gWTk2qHlvstQqGVIQOvgTaWLxoEbJptMJ+B2T9Vzm+WFmiBXLIjE52ebsY+Dmm6tRyJOtaDjzT6wxayOkjC+cZzVDWRxbeCDglqrDsQ4uJ4A7UkfvLGeXm3ST0d5DKNKmV8rpYDVawjc9wzqfFICcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762641600; c=relaxed/simple;
	bh=zFRJn9mBn75vimPvQpvQwao5dpgjzSCmGkn57mbffTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YT/04JwYeKmUKlQRt+NkMN4fr+sz9Y4dYRvfAmaR9Ih+GLyrUS1ggv2TGdYsWjAjdWc4IqhAisvWS5uvWYhdKTGbyOkM5dRoyjYcx4ZV8q7HqSSrjzAF2YWYacdIDBVAovXSCv+Yn58ACuB4/3kr8lpttSlWooteWzV66nPsoks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=nMyctn4r; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1762641594; x=1763246394; i=deller@gmx.de;
	bh=Qvvcs13dcoL1qoEk1MRQVNSPZzwfBqq3ekTaqGIERIg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=nMyctn4r5i82/XTIUpYU11Rew66F0ea9TLx/4z7pCM6X0iXKZBnXBxEEnqGSxP6m
	 OIVQAbOlaYOOIEm/4PciLG6ha7Xlm1JtV70SmIkfKM7KrbNkn4OZHjLsMjAYNZ3yh
	 Zijz9nPoHPB730aQu0lI7rWGVXh8KhhVlGFUyZphEA8/6i1tYtvhyRH7N0G3EOnMv
	 LOGL5Ucov0Z1cqBkwk9tDJSj9b563Bq25uM0Le78B27x0C2bYXW6rVvuh6EwXwxRL
	 2Ng3Kmti/Hu5S1lKeYXyGTGIYIKS1i10tOexiO+XS/8HcDG3QF5HsUPxdKtuvP6AO
	 69cpAovpvsvQP7xw7Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.50.205]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M8hZJ-1vM0SZ1pQ1-00F0gu; Sat, 08
 Nov 2025 23:39:54 +0100
Message-ID: <4e1ef54d-6a9e-4ff3-a8d7-241742c6d77c@gmx.de>
Date: Sat, 8 Nov 2025 23:39:53 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 2/5] parisc: Drop linux/kernel.h include from asm/bug.h
 header
To: Finn Thain <fthain@linux-m68k.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-m68k@vger.kernel.org, linux-parisc@vger.kernel.org
References: <cover.1760999284.git.fthain@linux-m68k.org>
 <c36756368f0ee942d5a995a603ce290eba06a5b6.1760999284.git.fthain@linux-m68k.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <c36756368f0ee942d5a995a603ce290eba06a5b6.1760999284.git.fthain@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LGqk0CnOt65XNCaTeg3Ri3e7gzzWG7qIu5W7t1ofoiK6Wn82hHr
 /07PnaR3i6LtZRfLHeSQqBT9s99eUXmiHEeegODH2MHeePb2HgVWW0sYyfArnbEE9EJfRUU
 VD8oWjDiGnERSAsUu7cOjY/r9qGRuCpviimeKtz8ZYNoRgYmZrqtKzu5DQl2y1etHamINZL
 bqRjunuMP2CgLcn4DndrQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1XhBuNkf4z4=;0GZIyqxtg3cAni5uT6+masQ6fa1
 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

On 10/21/25 00:28, Finn Thain wrote:
> This patch series will add WARN_ON_ONCE() calls to the header file
> linux/instrumented.h. That requires including linux/bug.h,
> but doing so causes the following compiler error on parisc:
>=20
> In file included from ./include/linux/atomic/atomic-instrumented.h:17,
>                   from ./include/linux/atomic.h:82,
>                   from ./arch/parisc/include/asm/bitops.h:13,
>                   from ./include/linux/bitops.h:67,
>                   from ./include/linux/kernel.h:23,
>                   from ./arch/parisc/include/asm/bug.h:5,
>                   from ./include/linux/bug.h:5,
>                   from ./include/linux/page-flags.h:10,
>                   from kernel/bounds.c:10:
> ./include/linux/instrumented.h: In function 'instrument_atomic_alignment=
_check':
> ./include/linux/instrumented.h:69:9: error: implicit declaration of func=
tion 'WARN_ON_ONCE' [-Werror=3Dimplicit-function-declaration]
>     69 |         WARN_ON_ONCE((unsigned long)v & (size - 1));
>        |         ^~~~~~~~~~~~
> cc1: some warnings being treated as errors
> make[3]: *** [scripts/Makefile.build:182: kernel/bounds.s] Error 1
>=20
> The problem is, asm/bug.h indirectly includes atomic-instrumented.h,
> which means a new cycle appeared in the graph of #includes. And because
> some headers in the cycle can't see all definitions, WARN_ON_ONCE()
> appears to be an undeclared function.
>=20
> This only happens on parisc and it's easy to fix. In the error
> message above, linux/kernel.h is included by asm/bug.h. But it's no
> longer needed there, so remove it.
>=20
> The comment about needing BUGFLAG_TAINT seems to be incorrect as of
> commit 19d436268dde ("debug: Add _ONCE() logic to report_bug()"). Also,
> a comment in linux/kernel.h strongly discourages its use here.
>=20
> Compile-tested only.
> ---
>   arch/parisc/include/asm/bug.h | 2 --
>   1 file changed, 2 deletions(-)

Acked-by: Helge Deller <deller@gmx.de> # parisc

Thanks!
Helge

