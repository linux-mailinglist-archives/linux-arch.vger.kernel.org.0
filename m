Return-Path: <linux-arch+bounces-9147-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4619D48F0
	for <lists+linux-arch@lfdr.de>; Thu, 21 Nov 2024 09:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 112DE1F22AA4
	for <lists+linux-arch@lfdr.de>; Thu, 21 Nov 2024 08:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670541BC9E2;
	Thu, 21 Nov 2024 08:36:02 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03D31B0109
	for <linux-arch@vger.kernel.org>; Thu, 21 Nov 2024 08:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732178162; cv=none; b=aBYySBb/36Su8OT/D5YACAN4wUVqIGMh1QSgrq2P/BbdkmfnwTxYjwJ4F4eaIz+8GYG1+iu1e1ZpnHrOtPPzMnB1I51k1C69RKinFev9rS8BYdaHO2NlxuE1u1vbO2opx7P30Sb4FGExvQ4YlOEWzKxdxvJoKPF1PQR5P1BbcPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732178162; c=relaxed/simple;
	bh=CxZc5eDjKCStnjWwKxYLlY7t03NL5VaBXTpA0hwkY34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pbgBAN4LsIVdawOOKia9+FItDGjDdDce7uDHLJ5xv6Z0dqqeRKtXpT56wNS4b784MArkBmVUAt9xZBVUE9VWjQg9/qHkJ4voVoFPbwCJ09J23xE1sYQZwn2Dj9Vx0YmPo0kmECmMGMVW/Bj6pICvkS1r19/yXbhbS2mf6m0AM3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6eebb54fc48so5500807b3.1
        for <linux-arch@vger.kernel.org>; Thu, 21 Nov 2024 00:36:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732178159; x=1732782959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d5BSoStO7FvucJJlV6RNgJWlQia+zkFcFYF1xTyTN9A=;
        b=l0teiZctx+iIjZeIkzB1SWV4Je9CY5VFqQbzM+uMiUm+y//X5U7BHsDSbjtX5xGHV5
         yHTc33zP2dAmZkiTCblBZ+ASEqVjPuE13LK4foH2JtTWVP1JTkgPo4d9gF1aYPVnIAR+
         DgzbP+myCn8CskkZZzqVBOY9XZ/GnS/cejLTiAYTd6P5Ozr7TD9JtqE1L56lr6tUCVgl
         OrGvsOHgamV4NIwbY7tsaShWf5tjUVKHJ8M7kMUkuZye+lSbHK8M3+6U5K3gracX3UTz
         Xv0Nx/ilXMTzHGqdJgsqdHCs9Arxc1QDlSuecaCjiqHTpU021Kj/DrB84vg+KPvX/+fl
         krog==
X-Gm-Message-State: AOJu0YzzZ+5y6/vvJnMZZ/PuCVmuLSPef7fRZ6mvkoyftlKVVpQ/evwN
	aIxy99M0cw9ev3MIcdGqXDvKcvwAM4rIo+PZRWg/23K0DFaDc74BUuaOb0F9
X-Google-Smtp-Source: AGHT+IFAnzQxVVx29Rba5C6LQtvQvPjJgPqc1Fsnf8hiKGb6nsUsJZM4zD41KTThzHh70OhdLMDmvA==
X-Received: by 2002:a05:690c:4911:b0:6ea:5da9:34cc with SMTP id 00721157ae682-6eebd141ed6mr55656397b3.7.1732178159318;
        Thu, 21 Nov 2024 00:35:59 -0800 (PST)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ee71342398sm26234747b3.89.2024.11.21.00.35.58
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 00:35:58 -0800 (PST)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6eebb54fc48so5500527b3.1
        for <linux-arch@vger.kernel.org>; Thu, 21 Nov 2024 00:35:58 -0800 (PST)
X-Received: by 2002:a05:690c:9a90:b0:6ee:66d2:e75a with SMTP id
 00721157ae682-6eebd2e4599mr68852927b3.39.1732178157882; Thu, 21 Nov 2024
 00:35:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106060938.GW1350452@ZenIV>
In-Reply-To: <20241106060938.GW1350452@ZenIV>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 21 Nov 2024 09:35:45 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVa9487xtqMzDGo3fB=_DNRe3jebrJhqmyGY1=eJZRpcw@mail.gmail.com>
Message-ID: <CAMuHMdVa9487xtqMzDGo3fB=_DNRe3jebrJhqmyGY1=eJZRpcw@mail.gmail.com>
Subject: Re: [PATCHES][RFC] cleaning up asm/vga.h situation
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Al,

On Wed, Nov 6, 2024 at 7:10=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
>         * powerpc: more than slightly ridiculous - if VGA_CONSOLE or
> MDA_CONSOLE is enabled, same as mips, defaults otherwise.  The ridiculous
> part is that VGA_CONSOLE is actually impossible to enable there, but
> MDA_CONSOLE (that is to say, support of ISA Hercules cards for the second
> monitor) *is* possible.  On the boxen with ISA slots, that is...

Once upon a time, in the previous century, you could enable VGA_CONSOLE,
run an x86 BIOS emulator, and get a VGA text console on a (second)
"PC style" (aka normal) graphics card in a CHRP PPC box...
With CHRP support being removed, there is no point in resurrecting that.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

