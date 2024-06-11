Return-Path: <linux-arch+bounces-4819-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B308902DF3
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jun 2024 03:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C62381F2257F
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jun 2024 01:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34359EEAA;
	Tue, 11 Jun 2024 01:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="J0tcoW/K"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480ACDDC7
	for <linux-arch@vger.kernel.org>; Tue, 11 Jun 2024 01:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718069081; cv=none; b=SsZ3K6/1HO7M7H6JKPPeW8SFUFNE9d/LvOV1PLiSOGxQ9S9/r3tHVdFkkV4rR9BCU9gnsqjNBGO1xP7h8n+RLQGD7BW3TWRDa136QauYHixYPVvW+UgCuJmFfuL/9UDNTvVyNWGWGo/5O5YnBhwnGettJD9KzpAu8aefTz6iQNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718069081; c=relaxed/simple;
	bh=D2mY0PxworDetejFBvMMJPM3s8A1YQGEEiK9nq7hZKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nSSbSLBt5GZVz3AvLcTxVV8X0Ljomh+/secsR34n8ZB8VnrKk2QvtztdN+WL0x64cY2ku0fYC5oE5ZPTR529zQtVJqqW6OvGJsNrdMNQHtKJoZLMIsSZxz7TyxoQHFmjkYuhHBmZQU75I51ana7bz8bFr2v3Ecmm9GAqjQoZFNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=J0tcoW/K; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a6f0dc80ab9so58692366b.2
        for <linux-arch@vger.kernel.org>; Mon, 10 Jun 2024 18:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718069077; x=1718673877; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c7ZYubABZSpYrLP7RVmTG2Pj59U8OWIrsQrqs7DlbNY=;
        b=J0tcoW/KBgdMPuLf7Gk4WmnYQAOFKXVunxkAsMJYjh2x36jYBITHxO7+7gOFPqY+l0
         hZ8AClvwKoXmhAmPaLHHcwElxx4ZTnaMN5c89+iapkjfTUwL5EmDlYiIZx9s1G/Doek8
         VUB5QDxbGAEzvn/CXrEXaqBo3El431zCe/3Wo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718069077; x=1718673877;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c7ZYubABZSpYrLP7RVmTG2Pj59U8OWIrsQrqs7DlbNY=;
        b=lpgCubCseav77m41/7oVdCEuVHFQaQg6vE3e/XMq9Ucj3LDE+8LG9GAIe8KuNhjVqQ
         RMAcHrc/H3hh3X3OgaDi+WeintSqEt4D4HlgzK6FkjM21E5W4j0eKdbbBVKZix7pCEO5
         +Em8EInQcR0lIQ++diQ/phgyHRv2tOxBXMipmm0aNXyvAPbBZubaT/s4ZylDGsXHoWwY
         CGoH9U1R9R5Egwwt9I3k5NkEWaNoT6iHAls9b4Cjg/QEUM5ybbChLuoudncCLIZN7MjV
         hDMBlBk3xcaYY8usGBwI/rg+Xnxzu+t7ZcJjc37eS3abHd2p4rhooTL5DRkmjvwM2/5j
         8icg==
X-Forwarded-Encrypted: i=1; AJvYcCU8FA4K9KZ7ILag4Vj/566UpWVyzP2XPlLYFM16QC2HnkHwdwKLGqqY8YsEr8je81WF/avjl+ST25pF1qyof+tr1KQM4KMTWxxVSg==
X-Gm-Message-State: AOJu0Yy3r+Nl3Fgqymk2Jiuf/wQk8G7iUfoW31wGAud5qoUJNNltbCl8
	zMpBRN0VGZwaHy9NlqrvUPEUYhqfHEnmQHvjedKo5bC9lJ2E5/brTotLX3qvvgzIs0/m5ZL+uGi
	vs7Q=
X-Google-Smtp-Source: AGHT+IGDx1Gby2wKXLknAaYsH3UF7JqvyHSOLvScXu+XtneX5hKyilLydvmU5az92Sk1ICjaLMzpZA==
X-Received: by 2002:a17:907:72d3:b0:a6f:1f4a:dfba with SMTP id a640c23a62f3a-a6f1f4ae1eamr277033766b.43.1718069077272;
        Mon, 10 Jun 2024 18:24:37 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f1ad792e8sm245819766b.152.2024.06.10.18.24.36
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 18:24:36 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57c83100c5fso482845a12.3
        for <linux-arch@vger.kernel.org>; Mon, 10 Jun 2024 18:24:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWmT2X9+3BrtY6xGkP3rm7Dn9Fku2ND1YexFhK7pJyX7dYY+rg1We9bCks+LjR+eL2/vKM4nTqxQsojyrQdHOv8fay5TwN4mgGrFg==
X-Received: by 2002:a50:d648:0:b0:57c:8c45:74ff with SMTP id
 4fb4d7f45d1cf-57c8c45751cmr1347189a12.41.1718069076241; Mon, 10 Jun 2024
 18:24:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608193504.429644-2-torvalds@linux-foundation.org>
 <20240610104352.GT8774@noisy.programming.kicks-ass.net> <20240610120201.GAZmbrOYmcA21kD8NB@fat_crate.local>
 <CAHk-=wgb98nSCvJ-gL42mt+jt6Eyp-0QSMJLovmAoJOkQ_G3gQ@mail.gmail.com>
 <71FE7A14-62F6-45D3-9BC4-BE09E06F7863@zytor.com> <CAHk-=wjTzFYo2+eQJpb56Df8sNDW7JEV=_6Di2v-M5x2kv06_g@mail.gmail.com>
In-Reply-To: <CAHk-=wjTzFYo2+eQJpb56Df8sNDW7JEV=_6Di2v-M5x2kv06_g@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 10 Jun 2024 18:24:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjdsN=dH41MO+gASWZkexCgrwK6CGT=NvpA3xsVXEhxBw@mail.gmail.com>
Message-ID: <CAHk-=wjdsN=dH41MO+gASWZkexCgrwK6CGT=NvpA3xsVXEhxBw@mail.gmail.com>
Subject: Re: [PATCH] x86: add 'runtime constant' infrastructure
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "the arch/x86 maintainers" <x86@kernel.org>, 
	linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 10 Jun 2024 at 18:09, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Doing it in general is actually very very painful. Feel free to try -
> but I can almost guarantee that you will throw out the "Keep It Simple
> Stupid" approach and your patch will be twice the size if you do some
> "rewrite the whole instruction" stuff.
>
> I really think there's a fundamental advantage to keeping things simple.

I guess the KISS approach would be to have a debug mode that just adds
an 'int3' instruction *after* the constant. And then the constant
rewriting rewrites the constant and just changes the 'int3' into the
standard single-byte 'nop' instruction.

That wouldn't be complicated, and the cost would be minimal. But I
don't see it being worth it, at least not for the current use where
the unrewritten constant will just cause an oops on use.

                Linus

