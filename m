Return-Path: <linux-arch+bounces-11150-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 375D7A725AC
	for <lists+linux-arch@lfdr.de>; Wed, 26 Mar 2025 23:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D8C9188E3DF
	for <lists+linux-arch@lfdr.de>; Wed, 26 Mar 2025 22:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E410B1F55FB;
	Wed, 26 Mar 2025 22:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ei6sMFtB"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FD4263F2C
	for <linux-arch@vger.kernel.org>; Wed, 26 Mar 2025 22:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743028915; cv=none; b=GJupkFn2INTqcL5eAACtn7nVwQ4BaedszvUAPdPZN8cEc6YnVRuJSq0WoaMlU6f4Jq8MsicAo4L7V4bHtxu5yRdGxhTXy5U3YzOKMeI4xWS47inQAG1Wrf9/o9vApzICfT1aTsX82rrzx6azBMmAbfhjs/rft1jC49i3EIRd7sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743028915; c=relaxed/simple;
	bh=tmaH+3YPGuLoi/3X44ITjHuWcR3F46JKpcVfWvhcJH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MQbzOU3GBdaEPPXbfVsM8SeCPV0FF6St/lKLHpuk4kHBXuGxSFx13HDl889EO95itusXUlrRl6UMH3aDKYFi0Q9/EheD27SaYeGmXSe8wNfmynn1Ls/SyALycz6fXsg3KRAPeR8P43ak4cANFu26Ug7q+Sp+eMlaOMIrsLjOSOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ei6sMFtB; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac2ab99e16eso71935966b.0
        for <linux-arch@vger.kernel.org>; Wed, 26 Mar 2025 15:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743028912; x=1743633712; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HIsAwdBBYfPSxKw2X4bvTfKKiRWcts7FEK1QYHHkrFs=;
        b=ei6sMFtBCITnJCpgDnYQuiugNkKfzYAHscNOl4PLqWqnYlVVYe8f/+skypQlbLOJ5a
         pdThhZFsgAIkT9KlLQVxq9GsUtXv2O0VpqgoKPLRdniACNg72GBNuz7vfiZU3t3dQx+N
         pbPken2StG9LIOA4LIIBP1MnR5Gg7igp1omcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743028912; x=1743633712;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HIsAwdBBYfPSxKw2X4bvTfKKiRWcts7FEK1QYHHkrFs=;
        b=ZGOQMAAAmozPH8xp0Wy5jxKVwc5jZq/gTWokWCk7OPmyqwQ/XV0VoqeBLGnWYFcfOh
         Ma6YjP5NnVfDPYSk+jxiYM1UPS5b3A8OWakCrgsNEFsgNX/jQSCvdNqCyhhW2WJy9xrW
         gZv7727CDOJu0M9I8o2oTs9CTKyXXRCDmI+CTcTIRkgdd663GGe0rVgVb11JcGNIDhw5
         DuwBSWOkoXOa4dOG71+zfM9Ym4Kd7cJr+Qy+WiEGYZnSEq4JQQv/1U251HqW7SJwq5GX
         LlDev3qrOM5WqFl2Q4iIF7oGDScuVHnlFAFr3uDh3zqJeuhVO6K7xZJ2ltqDfNQCLFG8
         J7Vw==
X-Forwarded-Encrypted: i=1; AJvYcCXqkvE7t7m/5EPlZnq5W45EgiXsDiLW/OMoHmM61twcXWN5zZ/9azeBnTgU1ocbHnvcNR29xHAPPSKE@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6eDlBMosyp2wY/5/LadscE/t89b2anz8cOqetAzHnNHRkEawV
	sOLJwuCa9t1ojc03rYDaFE1IBuF71O7tifJG9eCmakWviKdaRGUD43f7uula/SnXatzwYnNCNeT
	akgY=
X-Gm-Gg: ASbGncuxMpzKxyL3rUkne4RXXeQ7sbh/ta/PrCFpT5uoG0LhMjUjy1iXxt029lhQ7FX
	iQ2xQH1dMUkJ/7Swd/7kYbshujK9EBlpbGN0ctLNUDVxIgTwpeqa1C5rM+JOt9+ORcTTPsjHBav
	mIv0gmhKUoPjP/Tn/Wbk5ZoMXSVlHQwZeA6EnE+GquZky7bvfR9o5dOQ2TxCcuf0U1H2PzpG/IV
	ByaHlUvP2xQ0fiP6+frhdHLqTkcYKMk0pgW8E9e/PM135kqF3EN77+goOHZi3WjbzO82RkW6mRi
	exOTuctmNZ3I9K9EZPhECjI/wBnxI+BEaQpfnP8zJA3dg207jIkWgja9TZ8xNGQ6jpyfkUbq8FY
	IkW60vcvC6aUXYoeIFYQ=
X-Google-Smtp-Source: AGHT+IESvi5TW4A7Ibcub/R+e5kCzcpnyr2FyHw5IV1Nfa272fPbHx0W8BZB4P+KruEJ+1q/kjVfSw==
X-Received: by 2002:a17:906:6a1d:b0:ac2:7d72:c2ab with SMTP id a640c23a62f3a-ac6fb1a73dfmr91615666b.47.1743028911815;
        Wed, 26 Mar 2025 15:41:51 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef86e44dsm1097784666b.31.2025.03.26.15.41.50
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 15:41:51 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so50541066b.3
        for <linux-arch@vger.kernel.org>; Wed, 26 Mar 2025 15:41:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVpgeMj9sPXpm/MQTVQM6rOuwIS/z1vRbBWuPAcPkwkj7hC/DipRv3MP1LUQFcB4pj52dsQyP6CjggH@vger.kernel.org
X-Received: by 2002:a17:907:d1a:b0:ac4:3d4:50b with SMTP id
 a640c23a62f3a-ac6faf4bc92mr92400166b.32.1743028910518; Wed, 26 Mar 2025
 15:41:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250326-rwaat-fix-v1-1-600f411eaf23@google.com> <4b412238-b20a-4346-bf67-f31df0a9f259@app.fastmail.com>
In-Reply-To: <4b412238-b20a-4346-bf67-f31df0a9f259@app.fastmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 26 Mar 2025 15:41:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wikuhxhdSEgqb-Lkb2ibQM_hAHR1Cu7yxg-gHZu1NF+ug@mail.gmail.com>
X-Gm-Features: AQ5f1JrEsmQAOCm7pL6ucQGxLbFedCV1cucSaJ5TtT64ECZtdWuo9mNf3TsYhHg
Message-ID: <CAHk-=wikuhxhdSEgqb-Lkb2ibQM_hAHR1Cu7yxg-gHZu1NF+ug@mail.gmail.com>
Subject: Re: [PATCH] rwonce: fix crash by removing READ_ONCE() for unaligned read
To: Arnd Bergmann <arnd@arndb.de>
Cc: Jann Horn <jannh@google.com>, Marco Elver <elver@google.com>, 
	Nathan Chancellor <nathan@kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Mar 2025 at 14:24, Arnd Bergmann <arnd@arndb.de> wrote:
>
> I've applied this on top of the asm-generic branch, but I just sent
> the pull request with the regression to Linus an hour ago.
>
> I'll try to get a new pull request out tomorrow.

I will ignore that pull request, and wait for your updated one.

That said, this whole thing worries me. The fact that the compiler
magically makes READ_ONCE() require alignment that it normally doesn't
require seems like a bug waiting to happen somewhere else.

Because I do think that we might want READ_ONCE() on unaligned data in
general. Should said places generally use "get_unaligned()"? Sure. And
are unaligned accesses potentially non-atomic anyway because of
hardware? Also sure.

But one reason for READ_ONCE() isn't for some kind of hardware
atomicity, it is to avoid any ToCToU issues due to compilers doing bad
things.

And then this seems to be a serious issue with the whole "READ_ONCE()
now requires alignment that it didn't require before".

Put another way: I wonder what other cases may lurk around this all...

           Linus

