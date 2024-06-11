Return-Path: <linux-arch+bounces-4818-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E032902DE1
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jun 2024 03:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D817E1F22590
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jun 2024 01:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2CE6138;
	Tue, 11 Jun 2024 01:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GvVxFgF2"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2680B5661
	for <linux-arch@vger.kernel.org>; Tue, 11 Jun 2024 01:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718068192; cv=none; b=TpKCM3OKyxrW1vYgDt+y98QeWOdYY5QUwcq4zeXUJIgh0S624Te+P+a+H02/IQmtXwNNeMmhT2MO/pdVAgeT76JUZjPEl/WiU908knZW7uuI8C1gKCW1DUh1bJ9b09CHpXtayyZHwsJeogDWQsee4ar7BqDSTTSaTxWURl2p2Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718068192; c=relaxed/simple;
	bh=ISwR3L/+vG1MP+uku//9GZeeAXnWRoG3eGy94sqfYJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t7331urCLE0x1ErH/naxrs/9WUjYKH8cZnqMpXP5Q6iIUY7jbNlQfEl+4O7eY/oqalJYxeLd6/oSpEWrlqcpTwBdC4H2q9xvaBQTVoaVbmZX47KUrQk6HQQN009JuwAv7jl3wup32twB0gJ+80ZcCwfZR2FNmAHl9AFU5A42YCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GvVxFgF2; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a6ef8e62935so55423466b.3
        for <linux-arch@vger.kernel.org>; Mon, 10 Jun 2024 18:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718068188; x=1718672988; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CwfbM40EYyuUQKmQd1ErLsOSkNp0fbZk7Synz5+L9UY=;
        b=GvVxFgF2aoEEMvkl/klxpsn8sA7lV8kvv+6qySPwqs8ttAKXdRUVWj9oawuPn4BVJp
         uVOWiwfIXfxCXXv7G3/MqHOw6cBYzTPP20CWuA9rvZvz33TUTW/7+CHD+g7Xi3aNf/ai
         R/bum4zSTuszo5djb5zF9ZVUzLut7vSAm9AJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718068188; x=1718672988;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CwfbM40EYyuUQKmQd1ErLsOSkNp0fbZk7Synz5+L9UY=;
        b=cbqQEsCgZ5CgdrpRD/hUVJdY/s17gBA/DITwGGBjYw1BNQeD0OcwKWA7iX84fyI/k/
         wzzHZc+hI2RS1rmoR6Nd5ZzvSLaNEgRCdmj+F5RN7RPXpRk7hE4Okyxyv/jXomE7+tVt
         NNyeCCM9hEiE4UjW3krVd5FW9apvg+mp5lDyxY20HEbOX5CTzqMxj+DRDLRxMWrVvMOV
         GzNIhh5PZim1waEGvYYKIWuVB13APzS0ZJdbYqtWwA0ZxmqudEamP+MQRuzbYdmuvRv5
         l24Bx6BHV2QNIN9+nTsamR7OnTF/sClalYRAurMARPGdfq8X3vRQGAWoVy617/qZobDS
         jypQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqty7iYFknWi0XEfl0bS0yOvUENaBj2KwxucHb7AXQN/w7OHqPnRSwc5HHqwMYdgnM2CYaII/JsPmca8/oonFxWKXX1gEoar93Uw==
X-Gm-Message-State: AOJu0YzWWOvHCf5yR+2FegsBVSAXx3iMb7SYS2D/fP8GxHObXZ2Nv0Ts
	/yOhTjTFzbTDYHPo3CEQ+mQSbm4B/VDkDFAHGGri/kRHRk3g4v+G++LUGMpO4LzoFiFccwTHuEs
	gdrw=
X-Google-Smtp-Source: AGHT+IEGgTU3k0Bu82YXQStHHTpWwmHbIYLD3+ZYMJRJNPOpMl9m557TzHEAaIk7xId71LeWPNOgCQ==
X-Received: by 2002:a17:906:eece:b0:a68:ecd5:6083 with SMTP id a640c23a62f3a-a6cd637e1f0mr1034312266b.27.1718068188256;
        Mon, 10 Jun 2024 18:09:48 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6ef5ae2ce3sm478797166b.200.2024.06.10.18.09.47
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 18:09:47 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57c5c51cb89so594327a12.2
        for <linux-arch@vger.kernel.org>; Mon, 10 Jun 2024 18:09:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVfOxBYrhW/YQvkYemg5kG3lJzsq/LV0sMunClLaqA5JmV/DIjIqUQSDakyhPYEjpWfSiGsuSWQZgMO0jz++6RkaqvKW9tmqkPfqg==
X-Received: by 2002:a50:aad8:0:b0:57c:738c:2c84 with SMTP id
 4fb4d7f45d1cf-57c738c3299mr5316366a12.10.1718068187113; Mon, 10 Jun 2024
 18:09:47 -0700 (PDT)
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
Date: Mon, 10 Jun 2024 18:09:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjTzFYo2+eQJpb56Df8sNDW7JEV=_6Di2v-M5x2kv06_g@mail.gmail.com>
Message-ID: <CAHk-=wjTzFYo2+eQJpb56Df8sNDW7JEV=_6Di2v-M5x2kv06_g@mail.gmail.com>
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
> So I would also strongly suggest that we make the code fault if it is executed unpatched if there is no fallback.

It effectively does that already, just because the address won't be a
valid address before patching.

Doing it in general is actually very very painful. Feel free to try -
but I can almost guarantee that you will throw out the "Keep It Simple
Stupid" approach and your patch will be twice the size if you do some
"rewrite the whole instruction" stuff.

I really think there's a fundamental advantage to keeping things simple.

                Linus

