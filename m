Return-Path: <linux-arch+bounces-2074-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1759F848BDC
	for <lists+linux-arch@lfdr.de>; Sun,  4 Feb 2024 08:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E477284000
	for <lists+linux-arch@lfdr.de>; Sun,  4 Feb 2024 07:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4D3B65E;
	Sun,  4 Feb 2024 07:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bfK1lW3V"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C178F47
	for <linux-arch@vger.kernel.org>; Sun,  4 Feb 2024 07:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707032523; cv=none; b=MUCYiOgYccvnbsw3f0zYhzR2kVypI4b7KO9d20PvE0iGnx8LAp50L/jgHUzSUjc9pi4GgD9FoDs6Pejg5Rqc1CBB12WajeYtcBcbFy7d8LyQavzJpPOo+eACyEt/yDMTj60tURQwMvF/jdAQF9QZvV+TD1yuWDXrzqQoKhSr1O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707032523; c=relaxed/simple;
	bh=ivawquPkjq89vuGPt9zRK+PP8y8ZqNfCeHnU8NAATS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mzrFCBowvIf2cOQ+T2+DRoKCjX0BKIIt/raouvBk8xE3thiTBhRHiSwbE13mLTy9Hmij1+q+eC/zvN9+EmjEFu/VRb+Fpaz2cw6xH3hOGB0nbeTm3ihZRGXjdzBm0bFyAcNcr7H1AMeIPmFJYaHLnULoPQRfMqbUYMrERqCZav8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bfK1lW3V; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56003c97d98so1737624a12.3
        for <linux-arch@vger.kernel.org>; Sat, 03 Feb 2024 23:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1707032519; x=1707637319; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fuvlxA+anJtkOMreE35KRYFx2Wh10b5WLrE1tllolU0=;
        b=bfK1lW3VHfDbBdeN+4LDQLRmB1iZQKOL2JeXNXGBObluO3uetnw6Z1j+caLBn8Y9Qg
         oNlGWftvS9uq4ZT/BF7+xS5q6I0JLvyMIyEzZxHVfoEatay8tCpcYpsV9QTTjzqNRJRC
         qQR+HI/D9jYXlLLssRKljeXbQBxC8/YXO2Esk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707032519; x=1707637319;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fuvlxA+anJtkOMreE35KRYFx2Wh10b5WLrE1tllolU0=;
        b=OGS39WmGiMfrOcRnMZ738YWHWrPp+ywpP9eyTvAYdduGD5PmmZnippnIdxzgxGy2VZ
         GpA+ZN5+IltXtecKEsasyK4D/dAhYi73WTPzBRfyfN7ypmxNnGDcw3QLzU9j9CYKzaww
         B7/CetnMDkjuusQt8to33D4bCQEb4228z3Z1IcMbmstXABJPeZ408iZWB0xKxxsk8pam
         oRLBrKXyv8DocNSsko2NREYnImZmWwJIyTzpGJVyO0M3L57eUUxEifIIItuUCHLhkrpM
         62+PJiBK6PjAIwUdqU8bFyYVaKW2G5ihBaPW2z9Y8Pg4sLRdgAkgszpEVK4vn1i4r6/k
         2Ftw==
X-Gm-Message-State: AOJu0YxV6UMVZbaWMWc9h78Y3BtSl+0Dmdg6oiKFtgWlmS/8VwrPt+Vt
	RzkqGgCzzGOoVBASQw7YY2f/p8K/zyWWiwp+ENRB6TdmOAa1WKIgeBShUBtzdJ3EmeXi9RGAttj
	T7UYG1Q==
X-Google-Smtp-Source: AGHT+IE+nJz+u+97wCmv0J9/g+WPR1iot9FJW03LDlz2LRsCT2QhmcGhbEM3I9QPLTbHXpiojDxAMw==
X-Received: by 2002:a17:906:3196:b0:a37:22a5:50d5 with SMTP id 22-20020a170906319600b00a3722a550d5mr4095289ejy.54.1707032519582;
        Sat, 03 Feb 2024 23:41:59 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUbcRN+OZ8BgNuVzxdv79b8apo8i8Czt/FSXy4nf2aLrEXeuMIbt1FpJK6gA4aBCiF1FSmuGFvUzJUO07E/bDX/m9IKhAMDh+wW4A==
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id un1-20020a170907cb8100b00a35de0619dbsm2840341ejc.200.2024.02.03.23.41.58
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Feb 2024 23:41:58 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55a8fd60af0so4576813a12.1
        for <linux-arch@vger.kernel.org>; Sat, 03 Feb 2024 23:41:58 -0800 (PST)
X-Received: by 2002:a05:6402:1507:b0:55f:f73d:c63b with SMTP id
 f7-20020a056402150700b0055ff73dc63bmr2660980edw.20.1707032517833; Sat, 03 Feb
 2024 23:41:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202-exception_ip-v2-0-e6894d5ce705@flygoat.com>
 <CAHk-=wiaSjYApqmUYCdCyYfr_bRsfVKDkwU6r6FMmoZzrxHrKQ@mail.gmail.com> <eeb92d70-44d6-47f4-a059-66546be5f62a@flygoat.com>
In-Reply-To: <eeb92d70-44d6-47f4-a059-66546be5f62a@flygoat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 4 Feb 2024 07:41:41 +0000
X-Gmail-Original-Message-ID: <CAHk-=wiUb1oKMHqrxZ6pA7OjNmtgw6giTKWiagUC2kt-ePCakg@mail.gmail.com>
Message-ID: <CAHk-=wiUb1oKMHqrxZ6pA7OjNmtgw6giTKWiagUC2kt-ePCakg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Handle delay slot for extable lookup
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Ben Hutchings <ben@decadent.org.uk>, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	Xi Ruoyao <xry111@xry111.site>
Content-Type: text/plain; charset="UTF-8"

On Sat, 3 Feb 2024 at 13:56, Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>
> Given that exception_ip is guarded by !user_mode(regs), EPC must points
> to a kernel text address. There is no way accessing kernel text will generate such
> exception..

Sadly, that's not actually likely true.

The thing is, the only reason for the code in
get_mmap_lock_carefully() is for kernel bugs. IOW, some kernel bug
with a wild pointer, and we do not want to deadlock on the mm
semaphore, we want to get back to the fault handler and it should
report an oops.

... and one of the "wild pointers" might in fact be the instruction
pointer, in case we've branched through a NULL function pointer or
similar. IOW, the exception *source* might be the instruction pointer
itself.

So I realy think that MIPS needs to have some kind of "safe kernel
exception pointer" helper. One that is guaranteed not to fault when
evaluating the exception pointer.

Assuming the kernel itself is never built with MIPS16e instructions,
maybe that's a safe assumption thanks to the "get_isa16_mode()" check
of EPC. But all of this makes me nervous.

              Linus

