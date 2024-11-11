Return-Path: <linux-arch+bounces-9021-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D975C9C48BC
	for <lists+linux-arch@lfdr.de>; Mon, 11 Nov 2024 23:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6E89B22776
	for <lists+linux-arch@lfdr.de>; Mon, 11 Nov 2024 22:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38C3156228;
	Mon, 11 Nov 2024 22:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Z6/HQC1g"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2EB13E3F5
	for <linux-arch@vger.kernel.org>; Mon, 11 Nov 2024 22:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731362466; cv=none; b=A2gRsTLaf9D/kfd9cc98rvA9VNm4s4e1S6v8TyRsVRdflmwgmnvwNdjCKciRfe7yD78UkyOOxdYO5LuMeBfQ9O4WlEXlRCSpWyBzZoUjNZZJfdM5cuosGfpS+XgX5B7lZJe4RU6rgbEB324/vYOtJRQ9Ua0Is/G4w+g03nqjuZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731362466; c=relaxed/simple;
	bh=o1ZuquSTxhS5616xdtKNJOYl87d15TuDgoYPTqWYoEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GN8/4ljQnla7JyAnEg859U9ZVoYKOrRGW0RrVWyLaumhGtClJBmiSeNd/ZGWMHorwbIi8PNzK1XWZ7AF2JVKf09+KbL3CVqe3qr+SiAIVyyCbNc/xXe8xtWeqjvRJ98aRPeF4cvrCrfpx+pm5aMei49tDc0xlLBi1vGYSsZNLQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Z6/HQC1g; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5cefc36c5d4so6928079a12.0
        for <linux-arch@vger.kernel.org>; Mon, 11 Nov 2024 14:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731362461; x=1731967261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nw7jmBqAAuw6PQ4Oic9brWgvBuX8kaVtKrs+xC4V9TI=;
        b=Z6/HQC1gkqw/K1FeTYyWJIesd0Aoll10cz/3TpnTV2nped1Xk/xh8rKQhh2loIr+4N
         AO2dlTMWD4+VlHrP9sAN/rI9/Jju4byyvSYvW3FfY7V9JqCRGQxfidBPbHNqBsHBkV2i
         Q967Pmw3YDbi287XvK94HeKvn5svv1YKi3rfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731362461; x=1731967261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nw7jmBqAAuw6PQ4Oic9brWgvBuX8kaVtKrs+xC4V9TI=;
        b=bmgRLHgzNRjrJ2K1HWzF8J7A4TmdVFJS1vG5ewhV0NqQED7YGQJAiS7Qk3Xw+lXFE1
         9nEhqmzFL3mos07Rn8dSORbwrPv3Varf/XJpLhGShOCfaAKhgTykQBrF8rSjU8YtC2ep
         hj1iYb8cDoc+uyDboXPjYyx58679YGTibuXNfiE2Y24n+IAjsj5jZyKAplHBHwcOvseA
         SRq5cEzWCWfAl3uUEIv6l3u48p7tanUDdIu6g9gjyuFNh/izKuSDmmQ5N9IDSjSvRfOy
         p0ovpOgH3TRwyY9LkNWLAwzR7EBuLsgtu0UKfSCaCr0yhofIIEGMQllQ+snaal9U2OgH
         WIWA==
X-Forwarded-Encrypted: i=1; AJvYcCUXXe3bvqYheAEifwavAPUmUOjeES5ly5eIw+utLm8tgnhTjZX2GoQhTGHdNt7eUoDCe1a7qvZrDY3d@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7RY6xwpxeri2+dRgEq2FHhB0tcnhbGY3IvqCQ28DCvg/A6kh9
	Q8p28mzFtTatFqsC45BdWF/oojUj2lJlw/ALYbReWq5llEXJz7nbqmpcKpfXF98/MdSdAaoN4WK
	+b0M=
X-Google-Smtp-Source: AGHT+IGr4P40rUNGFrOkYBS9NsVmc2hWT3gWTYZwZbKGvCr3Pq3hwp0u15seMOe+EYKyH7LdvTv+Ow==
X-Received: by 2002:a05:6402:26c1:b0:5cf:466f:d442 with SMTP id 4fb4d7f45d1cf-5cf4670c86amr2777294a12.18.1731362461153;
        Mon, 11 Nov 2024 14:01:01 -0800 (PST)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03b5d77csm5251401a12.5.2024.11.11.14.00.58
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 14:00:59 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9a628b68a7so899513566b.2
        for <linux-arch@vger.kernel.org>; Mon, 11 Nov 2024 14:00:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW91mUUIiKjXG+p28+Yt9nKWuqostg4Z/5xfO2OVHC/6491m8Dli68SJS2+L10ZUYihrZgH/hoZXY43@vger.kernel.org
X-Received: by 2002:a17:907:7e8f:b0:a9a:3c90:60c5 with SMTP id
 a640c23a62f3a-a9eeff38583mr1475828766b.28.1731362458220; Mon, 11 Nov 2024
 14:00:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111164248.1060-1-egyszeregy@freemail.hu> <69be42c9-331f-4fb5-a6ae-c2932ada0a47@paulmck-laptop>
 <8925322d-1983-4e35-82f9-d8b86d32e6a6@freemail.hu> <1a6342c9-e316-4c78-9a07-84f45cbebb54@paulmck-laptop>
 <ec6e297b-02fb-4f57-9fc1-47751106a7d2@freemail.hu> <5acaaaa0-7c17-4991-aff6-8ea293667654@paulmck-laptop>
 <a42da186-195c-40af-b4ee-0eaf6672cf2c@freemail.hu>
In-Reply-To: <a42da186-195c-40af-b4ee-0eaf6672cf2c@freemail.hu>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 11 Nov 2024 14:00:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiEuh613GjBefTRe-_Eha1X1GoU=1nLt65uccSBC8Ne=A@mail.gmail.com>
Message-ID: <CAHk-=wiEuh613GjBefTRe-_Eha1X1GoU=1nLt65uccSBC8Ne=A@mail.gmail.com>
Subject: Re: [PATCH] tools/memory-model: Fix litmus-tests's file names for
 case-insensitive filesystem.
To: =?UTF-8?Q?Sz=C5=91ke_Benjamin?= <egyszeregy@freemail.hu>
Cc: paulmck@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, 
	will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, 
	npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, 
	luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com, 
	joel@joelfernandes.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, lkmm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 11 Nov 2024 at 13:15, Sz=C5=91ke Benjamin <egyszeregy@freemail.hu> =
wrote:
>
> There is a technical issue in the Linux kernel source tree's file naming/=
styles
> in git clone command on case-insensitive filesystem.

No.

This is entirely your problem.

The kernel build does not work, and is not intended to work on broken setup=
s.

If you have a case-insensitive filesystem, you get to keep both broken part=
s.

I actively hate case-insensitive filesystems. It's a broken model in
so many ways. I will not lift a finger to try to help that
braindamaged setup.

"Here's a nickel, Kid. Go buy yourself a real computer"

             Linus

