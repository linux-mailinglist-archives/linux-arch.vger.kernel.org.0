Return-Path: <linux-arch+bounces-7354-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D21F397BE8C
	for <lists+linux-arch@lfdr.de>; Wed, 18 Sep 2024 17:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5578D1F2256D
	for <lists+linux-arch@lfdr.de>; Wed, 18 Sep 2024 15:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0D91C984C;
	Wed, 18 Sep 2024 15:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AM1AHmAG"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6371C8FD0
	for <linux-arch@vger.kernel.org>; Wed, 18 Sep 2024 15:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726672977; cv=none; b=ptQB+1NI4WLBd4MzrYIG57a5hGqOgGj64t1cW0iq7PF4vJh+J2vsPkOBW0Iq4AldlFtmoeNODjTOwDm4Xm2fvvdTcmxCzICGc7pXV3kfJTMKLYVRod8pavVlyiloAmFguzWcYhLVmP9FkDO13krg4jclfXXCC0owrCaw2tYpfwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726672977; c=relaxed/simple;
	bh=JAusi96IOkOeOaqTiWtroBN0znKUXRz5D4lIj3kmqzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o8F68lD2g5BY0JtGS6x9MAJ9Z60ey/yml00GltxGf//8xSFTIb4I3jgnFU2WblqPfF6BIuEqQWEppr++TocVpvqgo4K2idU5q6ju8I9EiUPRnRGFTlBnFPzL1aPS8G+TyE3oN0FMO9zIXwhO47OgzX+hsCGxA0j36F9si0qocsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AM1AHmAG; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-50108b3749aso1496153e0c.2
        for <linux-arch@vger.kernel.org>; Wed, 18 Sep 2024 08:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1726672974; x=1727277774; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lCft1bt8+wTXWG4Mppm6Hwf7BdZO6lyQJ2NgHw2gpEM=;
        b=AM1AHmAGC128n6peOYF/CJytx1P/Gjyr208sNPhrgFxvC3nC2oNjNkH64NN2BtU2eg
         Hddwhy3iTeglfJLholo725KTxiOYpepwkVtLk3OUALrz1rat/emWEVi1Gz+60kuvrCHi
         e4xg29gfhz5/fz6nnZrX9+ZE27Xkr0V+FaocM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726672974; x=1727277774;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lCft1bt8+wTXWG4Mppm6Hwf7BdZO6lyQJ2NgHw2gpEM=;
        b=UpWH9MmW8HANHwNIDI01gkWbWLUDLgZVogi6NGzVHIonfnIZho8Pc1ibc8PffOJ9iw
         TEVskd4InehPY8cxPzWJZrHHhP5/3v62HTO7ExnjLP9qhdcZ9XDuJs1UbOe1U7wR1Ixo
         LG/RpAITMNXPnrZcYIjLbNFsJO9okvFBv5Bfhn/I9TZpJJHam109e6N+stW5M+NAYpMw
         FEGcssmhAM5ewWM+m5WTM3AsvavDOTcmYxxaRMTIvsGN1JuwrXtVEE7GUdNMchbcxQ9g
         Evw2uymZ6pujZxvYTjICTPNPrWCdlx8YBDFpZ4N6xkDf1SafbCq3G6n4CfCGiLnb23Jx
         JKrw==
X-Forwarded-Encrypted: i=1; AJvYcCUhb0W1FTGQKg5zaG3SqO9M6qPQx1cWZuVhD5+iHt8JgJzig3/zhuRJY5T2vZd7SJ0wmM+WsMNZMXs5@vger.kernel.org
X-Gm-Message-State: AOJu0YwDVkIvCuehRvYEKxLN6vt5uPxkwoas65LV277u98gGuBwsfApo
	ecSZjGyzptz3VuvD8N4vR6O25jsZwcAATRZzIVQBHfdJ4yOAthp8enNVgUU641X5yA7+DH9hei9
	fwEoQ7Q==
X-Google-Smtp-Source: AGHT+IGSj1SdCIW0VkHdHY+kW/TPgDGhxnlKPdtXxx9eBMcRoMu44c9ujjolmAsulyGNF21zrc/7VA==
X-Received: by 2002:a05:6122:32cc:b0:4f5:23e4:b7c with SMTP id 71dfb90a1353d-503449dc2d8mr12689016e0c.0.1726672974258;
        Wed, 18 Sep 2024 08:22:54 -0700 (PDT)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com. [209.85.221.173])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5035b955284sm968386e0c.13.2024.09.18.08.22.52
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2024 08:22:53 -0700 (PDT)
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-50108b3749aso1496144e0c.2
        for <linux-arch@vger.kernel.org>; Wed, 18 Sep 2024 08:22:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWFpCCHLLHLA1svqOQlq8EdlyPdEcUBoZ4bEc9GYXBDzvgzDahPCbXkhi6kghmlWPCNoqBIj6UhkdEp@vger.kernel.org
X-Received: by 2002:a05:6122:310c:b0:501:be30:2abf with SMTP id
 71dfb90a1353d-50344b63a4dmr13070691e0c.1.1726672972559; Wed, 18 Sep 2024
 08:22:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912-seq_optimize-v3-1-8ee25e04dffa@gentwo.org>
 <20240917071246.GA27290@willie-the-truck> <4b546151-d5e1-22a3-a6d5-167a82c5724d@gentwo.org>
In-Reply-To: <4b546151-d5e1-22a3-a6d5-167a82c5724d@gentwo.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 18 Sep 2024 17:22:17 +0200
X-Gmail-Original-Message-ID: <CAHk-=wgw3UErQuBuUOOfjzejGek6Cao1sSW4AosR9WPZ1dfyZg@mail.gmail.com>
Message-ID: <CAHk-=wgw3UErQuBuUOOfjzejGek6Cao1sSW4AosR9WPZ1dfyZg@mail.gmail.com>
Subject: Re: [PATCH v3] Avoid memory barrier in read_seqcount() through load acquire
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Catalin Marinas <catalin.marinas@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 18 Sept 2024 at 13:15, Christoph Lameter (Ampere) <cl@gentwo.org> wrote:
>
> Other arches do not have acquire / release and will create additional
> barriers in the fallback implementation of smp_load_acquire. So it needs
> to be an arch config option.

Actually, I looked at a few cases, and it doesn't really seem to be true.

For example, powerpc doesn't have a "native" acquire model, but both
smp_load_acquire() and smp_rmb() end up being  LWSYNC after the load
(which in the good case is a "lwsync" instruction, in bad case it's a
heavier "sync" instruction on older cores, but the point is that it's
the same thing for smp_rmb() and for smp_load_acquire()).

So on powerpc, smp_load_acquire() isn't any better than
"READ_ONCE()+smp_rmb()", but it also isn't any worse.

And at least alpha is the same - it doesn't have smp_load_acquire(),
and it falls back on a full memory barrier for that case - but that's
what smp_rmb() is too. However, because READ_ONCE() on alpha already
contains a smp_mb(), it turns out that on alpha having "READ_ONCE +
smp_rmb()" actually results in *two* barriers, while a
"smp_load_acquire()" is just one.

And obviously technically x86 doesn't have explicit acquire, but with
every load being an acquire, it's a no-op either way.

So on at least three very different architectures, smp_load_acquire()
is at least no worse than READ_ONCE() followed by a smp_rmb(). And on
alpha and arm64, it's better.

So it does look like making it conditional doesn't actually buy us
anything. We might as well just unconditionally use the
smp_load_acquire() over "READ_ONCE+smp_rmb".

Other random architectures from a quick look:

RISC-V technically turns smp_rmb() into a "fence r,r", while a
smp_load_acquire() ends up being a "fence r,rw", so technically the
fences are different. But honestly, any microarchitecture that makes
those two be different is just crazy garbage (there's never any valid
reason to move later writes up before earlier reads).

Loongarch has acquire and is better off with it.

parisc has acquire and is better off with it.

s390 and sparc64 are like x86, in that it's just a build barrier either way.

End result: let's just simplify the patch and make it entirely unconditional.

                 Linus

