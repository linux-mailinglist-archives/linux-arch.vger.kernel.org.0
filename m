Return-Path: <linux-arch+bounces-4840-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B009045B7
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jun 2024 22:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EDF11F23F1C
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jun 2024 20:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FE382490;
	Tue, 11 Jun 2024 20:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cd0nQ7H7"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D319A7350E
	for <linux-arch@vger.kernel.org>; Tue, 11 Jun 2024 20:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718137621; cv=none; b=TIHKdE/UCYYhcC/k6ti6AW3c3R9pfdZBLK8NRrU9DIHmev1g9xi1yJDUqurRd5NI8NKISUCtf3YgguYG9FY7C5C5wqhlVhJhgqprNtFbZmedorpVLCgXiypcYISGQ4X08OV0NrxAv9E2vRimbZJmluP0TrJFPg5M8Ml/d8rc230=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718137621; c=relaxed/simple;
	bh=m6u0TEW+to/kS5lz7pac+0GlCH2b5cvGTQl95Wz9HHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SmHJx0bAo8GtZ9rVc3KrSjx5UyavS+MEY3TbCu/GePgXH/YHnhc9k1N+Bvtsdlw8EqQb+F+/b3+tijcm5hVjDJzbANMALKNk8oCxD2EdmHTs6D81pNF4NhfOttJKvYTKDgqzgfnmuGu+atdHmM3Ym0OqfZ7gCp9oxCfbuhI6jvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cd0nQ7H7; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ebeefb9a7fso27053431fa.0
        for <linux-arch@vger.kernel.org>; Tue, 11 Jun 2024 13:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718137618; x=1718742418; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fwLXpsWWWKNNMe2wfaY/7uDw2Z9xjWpxzliXTIklXvE=;
        b=cd0nQ7H7JbhmUgWVkcDjzJ7JTA13XhoCmern7cYCwG8/s7dObmEonhahA9jaSMx4tE
         o5qXl0CAfYV0FXLOarXH2ZuhzOge3eSjznKzt5Lq0KvpXaeSCNWIsYzgSj+IY3DTu7mb
         ZDzfEe2oI0h3O0TP10tXcQWSdSPe8ad/KKk5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718137618; x=1718742418;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fwLXpsWWWKNNMe2wfaY/7uDw2Z9xjWpxzliXTIklXvE=;
        b=tepg0MeSKG3kX5peh/WJEf7oZHqTX6+VUrVYngiuDuFR1twX8OStR4rR+EnKxJYrlh
         xUo2xUU4Sj6c+1zXwjiqqrSLfOVqwzft+DdcapP4sMxyzS77n8PpfFmHvWuVgXk29fBp
         L50VCOkKQUYqq4rn00x+Wib14ogk7X9sfE+S8lUKsNnGRl1FaQSvOpqzKmzoWZ2nlRHS
         CXXP2pXMzpN4rJCfj2NWXNAHCBLehQMMpQaglN/otCMnZgiwEi/dXyTQaAhJhXD13VFG
         h3h0cJBATMlkje0bPNNCZEgV8Wb7zEvMmrvfIZ8trej9omcUsE4IgPONw2aYQxmzimLH
         qSBg==
X-Forwarded-Encrypted: i=1; AJvYcCWh/egFX3+HllfsWp/cOfjhEHI5TI3naktFBY2mvhIy2YhN1hORYj/5O2bU0SZpYGKWoJALl0m5o9LpNoQS3/US8frcmXhVl+h7lg==
X-Gm-Message-State: AOJu0YwURaGRJ94L/3+UYtgNZ7dU89r5+o7+Zqk3VDodm9f4ITUttu2h
	jqRI/loGE2i8dNbpmC109hLehSDR+L5IdY/tnwslh4L62HnSX0cbI/L9f7ltglRTYuqESMZIJgp
	ZiLeMsA==
X-Google-Smtp-Source: AGHT+IFotecWY5maJYssm6caHcYWi+ouhy5bOK3YODJx9MEV17jUGBG6R6TfMdTp3x5mR/nAil5+ag==
X-Received: by 2002:a05:6512:3d1f:b0:52c:80f6:d384 with SMTP id 2adb3069b0e04-52c80f6d4c9mr7453738e87.3.1718137617622;
        Tue, 11 Jun 2024 13:26:57 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52bbe916be0sm1901569e87.102.2024.06.11.13.26.57
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 13:26:57 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52c7fbad011so4133994e87.0
        for <linux-arch@vger.kernel.org>; Tue, 11 Jun 2024 13:26:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVOxQ3uYOyMQRmkgdDHXDlKU+i2QuL4fD1BGrLNYQpbI/LscAImlpcRSLG8b/AyB4EXFQH4O/wiozoxRfq+wSOkxLMA6qBUagG+mg==
X-Received: by 2002:a05:6512:b9f:b0:52c:785f:ae23 with SMTP id
 2adb3069b0e04-52c785faf05mr7126558e87.24.1718137616651; Tue, 11 Jun 2024
 13:26:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608193504.429644-2-torvalds@linux-foundation.org>
 <20240610104352.GT8774@noisy.programming.kicks-ass.net> <f967d835-d26e-47af-af35-c3c79746f7d9@rasmusvillemoes.dk>
 <8eb5960f-17f9-4d94-9b52-dea8b475e9dc@zytor.com> <BFD0AF77-C95E-4B8B-B475-DCBD808CA5C0@zytor.com>
In-Reply-To: <BFD0AF77-C95E-4B8B-B475-DCBD808CA5C0@zytor.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 11 Jun 2024 13:26:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj+1kOrg3H7wDBEVG2nw2xeB0F_YBqrw=bMBo0nRNtCKw@mail.gmail.com>
Message-ID: <CAHk-=wj+1kOrg3H7wDBEVG2nw2xeB0F_YBqrw=bMBo0nRNtCKw@mail.gmail.com>
Subject: Re: [PATCH] x86: add 'runtime constant' infrastructure
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "the arch/x86 maintainers" <x86@kernel.org>, 
	linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Jun 2024 at 13:16, H. Peter Anvin <hpa@zytor.com> wrote:
>
> I just had an idea how to clearly make this type-safe as a benefit.

You mean exactly like my patch already is, because I use the section name?

Christ people. I am throwing down the gauntlet: if you can't make a
patch that actually *improves* on what I already posted, don't even
bother.

The whole "it doesn't scale" is crazy talk. We don't want hundreds -
much less thousands - of these things. Using one named section for
each individual constant is a *good* thing.

So really: take a good hard look at that final

  [PATCH 3/7] x86: add 'runtime constant' support

at

  https://lore.kernel.org/lkml/20240610204821.230388-4-torvalds@linux-foundation.org/

and only if you can *improve* on it by making it smaller or somehow
actually better.

Seriously. There's one line in that patch that really says it all:

 2 files changed, 64 insertions(+)

and that's with basically optimal code generation. Improve on *THAT*.

No more of this pointless bikeshedding with arguments that make no
actual technical sense.

             Linus

