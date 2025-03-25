Return-Path: <linux-arch+bounces-11117-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D9EA70717
	for <lists+linux-arch@lfdr.de>; Tue, 25 Mar 2025 17:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5583818949C4
	for <lists+linux-arch@lfdr.de>; Tue, 25 Mar 2025 16:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6E01F4C95;
	Tue, 25 Mar 2025 16:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OpkHJfnS"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321AF19066D
	for <linux-arch@vger.kernel.org>; Tue, 25 Mar 2025 16:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742920625; cv=none; b=C4YiFAvjTdSEoQ7kjxQo/nK1C/+z29/GgA2n5CScuHAmr2rzt8+ivGXPgHH7WgvLR/NqvFUQxc608/02v9SrPxuFa+UPVbvQVoIXWm2qidhHtt2BnV2Fk2UZu+49aYWbqGl4DM+x8Q5he/RUcVYRjxlMCwJSD8jLdDjDwqU2io0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742920625; c=relaxed/simple;
	bh=cdtKBuwq8KD1n7kXxsXZzrCM7kAgY9mfaSLYLssvPX0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ww0RsvR8FRz3YceiyDosVxUG6usVjZ2dUU6phpxGsVL4Vpf05YXlCOhBUezMtueND493i1YCIZv7XoZ7rtVY1bOE02MZq0ggHWebuKRIy6BOgx6tdHvbIx/ZhMs9zlB6CksywL6GWxyUfAUfK2g2kf+/92mpfteHU0T7Sh2TuTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OpkHJfnS; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5e789411187so11702a12.1
        for <linux-arch@vger.kernel.org>; Tue, 25 Mar 2025 09:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742920622; x=1743525422; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cdtKBuwq8KD1n7kXxsXZzrCM7kAgY9mfaSLYLssvPX0=;
        b=OpkHJfnS0IIAT0vf0aMAo4BUOJUo0Gq8OsDgyMa3/urmO+q99LFNy9pd1DWfYjWsRr
         fwKl4w5zmbyrCRY1y6/CMujBt2MO6SnDAoK0L/HQKPB9AmnMXsvRWERL0gkuuYnM+BiC
         V7F9Up6QkAE9tw6XJOOGuvXklZD61C+TCyEYbOD6iCy8KTiFnz7ucDBDDvaPklgYtMLy
         oNMg1DPQEXNJPj18Ldh0lmfNAqaanqVq0fwrH3wBKrkBfx3bSfXmOndRWM90tPF0cEaT
         4jf2riM6frqvgWoi67Dq2qfjbpfqthx/pyJ/LCnBkRu6U3IYphMvMFtStL+RFVG2u6Ei
         51JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742920622; x=1743525422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cdtKBuwq8KD1n7kXxsXZzrCM7kAgY9mfaSLYLssvPX0=;
        b=hRCs/Ve5E/fdWcfZCTD6BBuBLb46HwLiSOKxq6WeyXSGMBUNB8vQQU8ZxxpGJZOwNP
         8BNUF9NCcKHOzVwHCu2JSdlEOZ73LsIpJE0qUcoasVRS61bWChZMqzL9Ow1XCcmxX22o
         04uWwJYxOTHzW652vSHOlYCtce30O5AzcHzoQtsqj4eP6OqpjrdZLK6lLyU7EjinlK/Z
         2xe2YJpDgLF0/T2b1IpLEg3IcJ2Wmj9/xcQSZb3kiPl/csMo3R6lcakTtUh/wd7jn4bN
         I1nTUVHbqhbeiI7mHdava6jVI7NAo5TJC5BvO95l4Qm9fgGzP6KnTVoD3otJapq574DL
         yR/w==
X-Forwarded-Encrypted: i=1; AJvYcCXmyppo6u9hfs5a5Xbxtm6vWf3n/tpenHA3wSS1Yum3BCtx0WJmpZTlZwN3X2G09h+Z33fNBmt8VqZB@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf4/VQDF4aCq7BFcyjt1KdvTk5ZZXSPErkB7awrkNVh/99g5YS
	y4bwczEChqOYsDqvjb22a7cl6Nj1bYlrKtv3p+pfYdsjWJuKwMu2ZGOgGz0cZddq7CYmiaeT5NF
	ZkSTdguWzLo2D+tlUfA5/e+8aPazGQJPs/U8h
X-Gm-Gg: ASbGnct0OSBfEO3t51c1eEBM5iulxUH6fGAjCXFIYdhLkCgAQbt2siOOPSox0DXr4f8
	HAo9dXmWYC9FHbV3btD06PauAy1mZ+ES53VhQx0U7i9j/Rqv782YiqS5sgZphCmD9tpc12QM7z7
	868ZNlnUI0LS9llAI/A6u8wWBEL76ALMO9LIzZXRoTY2XgtjLcY7iNEQ==
X-Google-Smtp-Source: AGHT+IHPUGHREqco1DTnfO/F+aCYz8cAJ5qYMao8+1Nj74JN/TypPJxBO7NjUrPuX7a2MaW7apzLRdIsTLYZoT/21N0=
X-Received: by 2002:a05:6402:2058:b0:5eb:5d50:4fec with SMTP id
 4fb4d7f45d1cf-5ec1d8fcf0dmr312539a12.0.1742920622152; Tue, 25 Mar 2025
 09:37:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325-kcsan-rwonce-v1-1-36b3833a66ae@google.com>
 <26df580c-b2cc-4bb0-b15b-4e9b74897ff0@app.fastmail.com> <CANpmjNMGr8-r_uPRMhwBGX42hbV+pavL7n1+zyBK167ZT7=nmA@mail.gmail.com>
In-Reply-To: <CANpmjNMGr8-r_uPRMhwBGX42hbV+pavL7n1+zyBK167ZT7=nmA@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 25 Mar 2025 17:36:26 +0100
X-Gm-Features: AQ5f1Jp1Xe_G-CxRRO6kwph46Q35uuQWx_DCrGXZTFNG3il-9h0KD0k1zhEGxuE
Message-ID: <CAG48ez2eECk+iU759BhPLrDJrGcBPT2dkAZg_O_c1fdD+HsifQ@mail.gmail.com>
Subject: Re: [PATCH] rwonce: handle KCSAN like KASAN in read_word_at_a_time()
To: Arnd Bergmann <arnd@arndb.de>, Marco Elver <elver@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
	Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 5:31=E2=80=AFPM Marco Elver <elver@google.com> wrot=
e:
> On Tue, 25 Mar 2025 at 17:06, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tue, Mar 25, 2025, at 17:01, Jann Horn wrote:
> > > Fixes: dfd402a4c4ba ("kcsan: Add Kernel Concurrency Sanitizer infrast=
ructure")
> > > Signed-off-by: Jann Horn <jannh@google.com>
[...]
> I have nothing pending yet. Unless you're very certain there'll be
> more KCSAN patches,

No, I don't know yet whether I'll have more KCSAN patches for 6.15.

> I'd suggest that Arnd can take it. I'm fine with
> KCSAN-related patches that aren't strongly dependent on each other
> outside kernel/kcsan to go through whichever tree is closest.

Sounds good to me.

