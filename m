Return-Path: <linux-arch+bounces-4817-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F18902DC1
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jun 2024 02:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3E7228427A
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jun 2024 00:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94EB2AD2D;
	Tue, 11 Jun 2024 00:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YObn1hNP"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9B7AD21
	for <linux-arch@vger.kernel.org>; Tue, 11 Jun 2024 00:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718067055; cv=none; b=QD81zqM0gHGCCcHW/R0nKDBIwAZ8sgly24KtepSoPCWFvbxR2datzWwWNiJ//g2bA4XMFzL+fn9t2lh2aiz3IS+EN3d2HMsidjK9qKbMHuRwTZ72aPHU6py5Y1QTqTV73E4yHxfLiYqu6ij5iQuYAzmxQoawyDPDSGfgGFwa7KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718067055; c=relaxed/simple;
	bh=xW/JsFrvvdxfv6EVqr7rZU4s6vm7IMnNTV0x4eaBiKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DfnJvbau/SgCYLrq6gBIyNJb5XKRTYqmCPLE/rWHnMcM2wglN01F3Tcv8SY8wjbfnUqJNw/OEmQ0clDV5dfl+ztwds1Ax6Xr3vhNG5IwUXvQTrK0JyJpFwNauImVO/iY+InT7xTZnClO0XN/2jdhjqroVsaEXIY9oidIHhxSJos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YObn1hNP; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4217d451f69so5237285e9.0
        for <linux-arch@vger.kernel.org>; Mon, 10 Jun 2024 17:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718067051; x=1718671851; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WEyzkTSmfTg9rMLE5THHkOuiUGT58uE3ZSUkLeaSyYQ=;
        b=YObn1hNPAtZxYJlFwS8SZwElvg8IaIJnCV1QqW+gCIbLhxwI9W+pFieGKSizUTgkym
         r2WP7pILYrTsekvgpxSweRp9g6uWzyv1UPIS5hJyuv/IDqZxqqqkAP7as+4G7O+IDhb0
         4/5PM1GjTlel2epSK+ZVBE3+g2s4dMGu8ZqpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718067051; x=1718671851;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WEyzkTSmfTg9rMLE5THHkOuiUGT58uE3ZSUkLeaSyYQ=;
        b=rOA18mMOi+SC3cM3BHx2iONhYhHuErC2QM8sYMspvUKDzQMwyRIYvRufFjuUEET4M1
         Y1qGJ5Hz7R2n8XhBEUpBWUd90QLR2X30q2I8cbqrvCDjM8rOM3Dsc/D2LsvZzSAvDJIz
         Z81QtUklOBMuVwMH3kzN/E8JnVE29KIUxVOYwPvSTmA0YwutfU6d33PuY/TuDF0RiN41
         FBdUT6coO/rbWjBdmR8RP+w4ogPLzv8U5SSuCQ4/dIoUhDkqh+vQA9IMQJS23DwjDyfC
         wuvPc2g80nJGQ6KWlL2zhh29jfr2dgo8Uwy5eJ6fc4why/XbzQAVXrUfKGzdWvm81nHi
         zleQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJE5E69VO3J0bqFIPaCbFGj8qwOkbJgdTtVP3QUwmzSXJdzO/cx5qYFBkU60gtOd/fnnpVs3pl7m9LqJiOW/PWZn3xZf+MJ4f9uA==
X-Gm-Message-State: AOJu0YxPUvgUQpb2J/Tn+Cap/uRAkExM4zdsQkz3XEbaBy1TJhCqWbrx
	SgFE8Wj5MChi/qnxFY1THhbmJzrpxK8fbDvm1PZ8cZ8xFdUXmGiiXdxmGyH8ejjke75vrqQ/rm5
	LVjA=
X-Google-Smtp-Source: AGHT+IGAEn+dCIpBuGXdKHfXfAeGq77DbkwPeLzouhra4Tkv2dgVD3TZ/hOrjzv6GNyFOkyb3juu1Q==
X-Received: by 2002:a05:600c:350f:b0:422:1163:44b2 with SMTP id 5b1f17b1804b1-422116354d0mr20960965e9.7.1718067051464;
        Mon, 10 Jun 2024 17:50:51 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57c92901b05sm501126a12.73.2024.06.10.17.50.48
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 17:50:48 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a6f0dc80ab9so56844866b.2
        for <linux-arch@vger.kernel.org>; Mon, 10 Jun 2024 17:50:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUPn7fhJsXHqGr2HLDJgq+XCZUEIEZxvTz2sesSVt7jb++L4iyXwBoeSmuE++Nxub/VbKynZamKGgY+mQVk9mmLWsej4g2QNIPP6Q==
X-Received: by 2002:a17:906:17c3:b0:a6f:2b19:e82f with SMTP id
 a640c23a62f3a-a6f2b19e99dmr137168366b.28.1718067047933; Mon, 10 Jun 2024
 17:50:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608193504.429644-2-torvalds@linux-foundation.org>
 <20240610104352.GT8774@noisy.programming.kicks-ass.net> <20240610120201.GAZmbrOYmcA21kD8NB@fat_crate.local>
 <CAHk-=wgb98nSCvJ-gL42mt+jt6Eyp-0QSMJLovmAoJOkQ_G3gQ@mail.gmail.com> <71FE7A14-62F6-45D3-9BC4-BE09E06F7863@zytor.com>
In-Reply-To: <71FE7A14-62F6-45D3-9BC4-BE09E06F7863@zytor.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 10 Jun 2024 17:50:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjLytEj0Ccs1CsVPxmbLavf8Wk4ciDskhwy47rgyq7Oig@mail.gmail.com>
Message-ID: <CAHk-=wjLytEj0Ccs1CsVPxmbLavf8Wk4ciDskhwy47rgyq7Oig@mail.gmail.com>
Subject: Re: [PATCH] x86: add 'runtime constant' infrastructure
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "the arch/x86 maintainers" <x86@kernel.org>, 
	linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 10 Jun 2024 at 16:35, H. Peter Anvin <hpa@zytor.com> wrote:
>
> ... which can be compacted down to a single instruction:
>
>     addq $bimm,%rax

We'll burn that bridge when  we get to it. I'm not actually seeing any
obvious for 32-bit immediates, except as part of some actual operation
sequence (ie you might have a similar hash lookup to the d_hash() one,
except using a mask rather than a shift).

When would you ever add a constant, except when that constant is an
address?  And those kinds of runtime constant addresses would always
be the full 64-bit - I don't think 32-bit is interesting enough to
spend any effort on.

(Yes, you can get 32-bit rip-address constants if you start doing
things like conditional link addresses, but that's what things like
static_call() is for - not this runtime constant code)

                Linus

