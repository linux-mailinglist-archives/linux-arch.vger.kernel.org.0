Return-Path: <linux-arch+bounces-13605-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E09B570F6
	for <lists+linux-arch@lfdr.de>; Mon, 15 Sep 2025 09:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF547162E3B
	for <lists+linux-arch@lfdr.de>; Mon, 15 Sep 2025 07:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC882C3263;
	Mon, 15 Sep 2025 07:13:44 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2DD1DE4F6
	for <linux-arch@vger.kernel.org>; Mon, 15 Sep 2025 07:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757920424; cv=none; b=by9g6ZGLRfstLPgJyqzILupdWY+O5BNYalDSZjJ1GAZWWqaccDL79z5FbKpUxqzqI2b3y7YBDKQL4yB+1bRsqLsMfyP1WpqbTg3yaik6HqQWrBM/4loxAJKAvLi9/nNdMvz9BigUL9S4h8bE8RdAVbijYJmV+oRPA9UKl/78Ir0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757920424; c=relaxed/simple;
	bh=dfvyAXJ+q2P35fAgIjXMmhc4HlVtSk3Mc3VBrceUE6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dlPn8at0nEK3+BV9UmM4hegeUJyoBXlhVt0/3vhYddJQM6pYskV/h6rsp4MbTqyl3AHHvbhUA4KviG7+5nhPWmsi2v5nP7gqq47PNJ4I8+ZHqc3GAS1FgwYtj+Ue6QOITUc/gGbMbNvstybMSoa6xQs7UmO/+DwYk711mdM4dFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-54a30c66258so274560e0c.2
        for <linux-arch@vger.kernel.org>; Mon, 15 Sep 2025 00:13:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757920420; x=1758525220;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RLMuvQvb9Q0HlgP3n0zmCAk2FLf3hZGDFhVwbi0PK4A=;
        b=GQkyebODcTsjH4U/7Nw3oTEwWG0QbNx1GpQ/F2AkWUa6ME8XFM9jYtexYhI4u8/tV+
         evyHm5zDa8IVD5ppj0V0oJWed3nSpe9iiP6GgJ298rizoY2wA292X4vFBo4lAZH9ZSbo
         HoGPxcSqR+ntvFg7gkN3ITAtJgkqetUPTG0H1jgIznpL/vVdVGuupihyv7kZ+76/0uDr
         BqV2BVHA323zuEjZCHm+eALag/uHZ/xCXprXPGPu/nl2S5OoBBkkV26uyY3fpp68loh8
         QfEym62cJqyjjoQBuT6gTFAT9tRq2fTnmYqzdzqbHBB41PQnDEBzXHYm32wr0Hc9+03i
         c+tQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+CN8iliAJFOVguIqc87JzQ3R0DFBIa1/WToAtqRsPJ24zp1qOM7Of06oTPPeqrKLqVMDSs+HhB+nZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwNN2jGhyw9MP3LUYYsiIhYwUqxANaeHbbMMhhRrpRt52o+hcbR
	L8IoIyOh25eDv0QEAHMGuzXqHbOry834lRPFkPdmAY/CkPiLURRYmMmiJ1eofLsx
X-Gm-Gg: ASbGncvWli0mjYK2Oyst4c2W6nGpxC7QvyuQBZSEfAm0LyPjmrfSS3T9TJ7Ufzkge+b
	uL5o5Rre/nQPBskrwyx1L7xxIW7LauTzIRphZYahc0KIIMJNzRO8ELLhdjAKxpOphtsjnhgkm/F
	JT91y8TDJGNAMq9xrRhzv6S3uegFOr4EpjVMA6hlFGPUbW0rK0gtUiEUG2MQn1VFZMS9Lf0Oa+y
	Q/TAOEnxtTDiof5M9alS4/H/sUxVsJmBbfHQzWkAeQpUWZG57RZoeCjCatdumpLUu/twjVzauVe
	RPo0GAlpdu7FkNc3UxD5/GtYJ7O3Rn3bVwea4znp1fzSxhasrFoZDJEECItKCKype/GcG4Yj5iW
	Obswv0/MN2OZPvkiBbYXnqdvf+qOs/UFSLmeo6zGeRcrWxF/XTZjYkRyMYJAC6bk7qcn4szI=
X-Google-Smtp-Source: AGHT+IFvX5Ne781B7A8ZWAGSLYVpz4tdibFjdlbNSo3m7Lzje+smrZQOx6sA/iRJTXkpDM9blGyCOA==
X-Received: by 2002:a05:6122:318f:b0:541:2e11:6738 with SMTP id 71dfb90a1353d-54a16c8ac6amr3008103e0c.9.1757920420633;
        Mon, 15 Sep 2025 00:13:40 -0700 (PDT)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-54a0d1d91casm2077484e0c.8.2025.09.15.00.13.40
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 00:13:40 -0700 (PDT)
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-530cf611a7eso1574935137.1
        for <linux-arch@vger.kernel.org>; Mon, 15 Sep 2025 00:13:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU8WnAG1exJBFzUMSlEf6WW7r8z5OKTjAJOLwPNCYVD7JQa7xQ20OhEJnHILmbQbB3M783RcEBYIN4z@vger.kernel.org
X-Received: by 2002:a05:6102:a53:b0:538:f3d5:fc12 with SMTP id
 ada2fe7eead31-55610dc0d40mr3363566137.32.1757920419553; Mon, 15 Sep 2025
 00:13:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1757810729.git.fthain@linux-m68k.org> <abf2bf114abfc171294895b63cd00af475350dba.1757810729.git.fthain@linux-m68k.org>
In-Reply-To: <abf2bf114abfc171294895b63cd00af475350dba.1757810729.git.fthain@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 15 Sep 2025 09:13:28 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXOnUXJbhifdyYY50fo5zoG=FH6Rvp64mQHBB9yQRyiVA@mail.gmail.com>
X-Gm-Features: AS18NWBvIvDo2gS7rnEu0r9EhvBtLAuRYWpDZeLRfT5zdiYtp2SXSdMjVN81nKo
Message-ID: <CAMuHMdXOnUXJbhifdyYY50fo5zoG=FH6Rvp64mQHBB9yQRyiVA@mail.gmail.com>
Subject: Re: [RFC v2 2/3] atomic: Specify alignment for atomic_t and atomic64_t
To: Finn Thain <fthain@linux-m68k.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-m68k@vger.kernel.org, Lance Yang <lance.yang@linux.dev>
Content-Type: text/plain; charset="UTF-8"

Hi Finn,

Thanks for your patch!

On Sun, 14 Sept 2025 at 02:59, Finn Thain <fthain@linux-m68k.org> wrote:
> Some recent commits incorrectly assumed 4-byte alignment of locks.
> That assumption fails on Linux/m68k (and, interestingly, would have
> failed on Linux/cris also). Specify the minimum alignment of atomic
> variables for fewer surprises and (hopefully) better performance.
>
> Consistent with i386, atomic64_t is not given natural alignment here.

You forgot to drop this line.

>
> Cc: Lance Yang <lance.yang@linux.dev>
> Link: https://lore.kernel.org/lkml/CAMuHMdW7Ab13DdGs2acMQcix5ObJK0O2dG_Fxzr8_g58Rc1_0g@mail.gmail.com/
> ---
> Changed since v1:
>  - atomic64_t now gets an __aligned attribute too.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

