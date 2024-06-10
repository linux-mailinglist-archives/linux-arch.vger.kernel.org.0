Return-Path: <linux-arch+bounces-4798-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D24E9022C0
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jun 2024 15:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76E3D1C21AA1
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jun 2024 13:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE0A74048;
	Mon, 10 Jun 2024 13:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="YZfXVTZA"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A1415A8
	for <linux-arch@vger.kernel.org>; Mon, 10 Jun 2024 13:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718026719; cv=none; b=Mxv2JXRYCf0e7ytfK6xnF/0GZgkCc99+Ni9VhBy/QXcyPRQ8g5z2k4gig3TUY/Z5mB2CIN5/iSSjj7jVYPpaiAcSTW7SXg9a8f4oNRL6HaJrGIQ/NoyQPxLFxVpl1ESAfl1CxWrYnZkoRlzh4n+m05Svc6RtJcv559QMwgTrtjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718026719; c=relaxed/simple;
	bh=nNiMFN3UUVyLRK8hNS+Knebs+73HcK7zuHQH11+IUf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AddwhGRmOTpnHiF7CPInXsF+FDRUZVg3ZkpH+UdoVw9go6xEz2wKMZ+AUpIvj0d34afK1fjDekBos3oOZAckBYQak/AOGUxkjg3CmiqGRw9VgK1A41qAO+ghirqyRKM0cwimJ8pDLdQViGwkA4vdjDmfzZ/tlwj0ypD6rX6L6KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk; spf=pass smtp.mailfrom=rasmusvillemoes.dk; dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=YZfXVTZA; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rasmusvillemoes.dk
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52961b77655so4887695e87.2
        for <linux-arch@vger.kernel.org>; Mon, 10 Jun 2024 06:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1718026716; x=1718631516; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6MVOT7ev6J5lLl/iba6yrd0EhvDJDU0eNfpHSBAIuOY=;
        b=YZfXVTZAALZBsckulSZUV7g14E6MmT8NndgV0d2sZnmqeHlfdH/7H+gpxNtIH/E1gI
         GmsnAniYZlJuJZPjObXzgHCDpm2n/97HZQjJAaarmsAHVOoN/iKVTNhyjVoulTRmpCWF
         X2a8EGWQwyRDxzqkJtEzaeMmgJegKGZeBM5Ys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718026716; x=1718631516;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6MVOT7ev6J5lLl/iba6yrd0EhvDJDU0eNfpHSBAIuOY=;
        b=LFbGbDqns0UgCUNepUVWR5uhBiLe+0iuDZHx6r5+xB0cdQ5QStpKOBoAjlqBKQeoHY
         NlYtNi5sGOJvDK6h7um3/Ut9X6Tu8YlJWKSVKWTn93sjL1fzERPkFXLgCY6Oz+axZ+W4
         9Fe77i6APz7XLAeIlmgC7zCz9zbpJ6NLeEAoAvnPSgepNTg4ESydoYlt4Ev9/G/gerp9
         GmiTZ0wrBIwsfeF77j5Yq+pahpPTRKzQ37hxKV9Xq4csu1sYzY628w7mmYZSoHEq/pkM
         0m6MN843jycEuyFcov6SUD+gxpIgzjXBM5y3pa5upreHAq/CuujyNoqRIR9za0LSO5bR
         RN2w==
X-Forwarded-Encrypted: i=1; AJvYcCX9vOSfkbPDu9NIpd+O4XuCnBVshaFu7qClAUyKe3VilPwRVWSi2Ys6JlaOFVfoTBmirZzThuoZY33HOrF8+P1ZW5PfZb7SdaNQJQ==
X-Gm-Message-State: AOJu0Yyc0c2YgH+4LJBfSiT23yVHeqSidNjtm5vm4EtoWCJh8dy7O5LP
	JreRfggAmgjFDbFeyiShMV3IhqEioHmIrsIiCTE9+pIhKf2iZU52iGfrN3J6spc=
X-Google-Smtp-Source: AGHT+IH951ow2F1ZsFqXx5A89eENuF5pKIETipiyl7d5mCQzoHtS+0ARN21s6WcTQmJex2EIY9cvBw==
X-Received: by 2002:a19:641a:0:b0:52b:797d:efd4 with SMTP id 2adb3069b0e04-52bb9f6deafmr5369729e87.16.1718026716105;
        Mon, 10 Jun 2024 06:38:36 -0700 (PDT)
Received: from [172.16.11.116] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52bb41e1bd6sm1668882e87.48.2024.06.10.06.38.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 06:38:35 -0700 (PDT)
Message-ID: <f967d835-d26e-47af-af35-c3c79746f7d9@rasmusvillemoes.dk>
Date: Mon, 10 Jun 2024 15:38:34 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86: add 'runtime constant' infrastructure
To: Peter Zijlstra <peterz@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Anvin <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 the arch/x86 maintainers <x86@kernel.org>,
 linux-arch <linux-arch@vger.kernel.org>
References: <20240608193504.429644-2-torvalds@linux-foundation.org>
 <20240610104352.GT8774@noisy.programming.kicks-ass.net>
Content-Language: en-US, da
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20240610104352.GT8774@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/06/2024 12.43, Peter Zijlstra wrote:
> On Sat, Jun 08, 2024 at 12:35:05PM -0700, Linus Torvalds wrote:

>> Comments?
> 
> It obviously has the constraint of never running the code before the
> corresponding runtime_const_init() has been done, otherwise things will
> go sideways in a hurry, but this also makes the whole thing a *lot*
> simpler.
> 
> The only thing I'm not sure about is it having a section per symbol,
> given how jump_label and static_call took off, this might not be
> scalable.
> 
> Yes, the approach is super simple and straight forward, but imagine
> there being like a 100 symbols soon :/
> 
> The below hackery -- it very much needs cleanup and is only compiled on
> x86_64 and does not support modules, boots for me.

As can be seen in my other reply, yes, I'm also worried about the
scalability and would like to see this applied to more stuff.

But if we do this, surely that's what scripts/sorttable is for, right?

Alternatively, if we just keep emitting to per-symbol
__runtime_const_##sym sections but collect them in one __runtime_const,
just using __runtime_const { *(SORT_BY_NAME(__runtime_const_*)) } in the
linker script should already be enough to allow that binary search to
work (with whatever : AT(ADDR() ... ) magic is also required), with no
post-processing at build or runtime required.

Rasmus


