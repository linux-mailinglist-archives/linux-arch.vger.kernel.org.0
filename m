Return-Path: <linux-arch+bounces-15317-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC81CB0F9C
	for <lists+linux-arch@lfdr.de>; Tue, 09 Dec 2025 20:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 483903064E4F
	for <lists+linux-arch@lfdr.de>; Tue,  9 Dec 2025 19:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC46307AFC;
	Tue,  9 Dec 2025 19:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zrfirogA"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D5030505C
	for <linux-arch@vger.kernel.org>; Tue,  9 Dec 2025 19:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765310123; cv=none; b=NEkTGIikIZi85NXhYOQ9g5xGH8Tzd3tbHjhWi8l1lCJzj44Kra3epl+4mIu4YNyci/A3YkL+enA3QhNpPjw8th6fhiNwmSfTJwPkXMAflqPcqWesO1dzcO4Gwmt2wQEKhPQM4kvUIXhv6CmdOWQkYJzMMGYYOEZ6EW3L3YATZ9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765310123; c=relaxed/simple;
	bh=0eGrB3f7xFqga3zVUes14rwFnowv3DUJ5vt7vr9GRdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wuk+mhlxmtOV/tma8iIwpRGqOnPdlJY6VXcP+fGvYNnAN8CeXPk6PULPqmtDQGrgzTtB1gysKPAl+iOR6pj4Gkm/P4VSROiymNz99UZAOW2EFOCw461vGmP7fUBh0VHnIHWnfdWEybocDfOlWI4zZY1Bv4XBnS13r8myICWqpFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zrfirogA; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5957eeb9d8aso1399e87.1
        for <linux-arch@vger.kernel.org>; Tue, 09 Dec 2025 11:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765310120; x=1765914920; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+RBf8HywqFOs8is8n1gYXR3AwZl2+4K5ckOabIP0pI=;
        b=zrfirogA8aazMPJ6++jdL/wIMZZKiMVvdMrp29NQQAz2kLR8zvLLUJ9hjXwsGY8vzK
         g8pABgqE3N0Q99FvMNHZGBHG5TkORREOHehUZLmM+A4zr8K425RRHe8c8dCQJmJlZbum
         OetkMVCBBEE87PR8Kck4iwDRrzjbzaiAcsPUU+SD6mic/mo9XEBuqWJZiK4mOvWdQZVz
         /yFOtTSb+kXfTKQe02OHNSCin2gdSQJCXuxQSyx1y2BBpHMzfMWMIMPJHoaMZLRoWLsW
         k+jHFfwqdo0c5tr4p4VHwuDuz5XKfQCLJKmyUot9QtNkn7wJ7Du2VBhPANEaShRRL9hH
         nazA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765310120; x=1765914920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X+RBf8HywqFOs8is8n1gYXR3AwZl2+4K5ckOabIP0pI=;
        b=kQAp0IxUo/RMa1Da7vQZN6UsMMgSQrFe+9ZHcmj4hhu16+6EkMZMmUEC9minNcF4xI
         RvWetvqz9lRO/lIVxYb6KcSzVNmrDJX9sy374j9cYopvwgUd+yFp0zmAjwVxUu+tsPTL
         sfDpVXM9Gq7QbhqERqA4YtRstcWmHrp2fDFIkXE6ifIAjJNbt2MxCts40/9IXNgCbgZf
         mIsRIbYlMwKB7l6vJyWHVHzwUzTeuT2h52riCbOagF6rfCIY6g7DHc/mDzf+j5FmUp7s
         3ItGDEiRbiuUxv12Zftwn2tm7oR+bC4hSkd6FlJzguK19NY66imxVzLMHWl2+QUJx7D4
         sJ4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXCBXGWINc2bHV7ATkK9yBhLubHAzv1PpAcWmYUGlg98J12eWknKhGDA1maj+AAOInxdzQbpgxQu+c9@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5QV9F6yKAJVQ9vTUeAdqN9Y4SObpJoIn22AqR2C5gJCVgHy17
	CWr+UB4K4av4Esrk7vRYb+mQjlroxCH4WeuL8g4ioHe6Q7YHlmmW2k7NuMbshCYAGCIisStPFyV
	AdCvGXJikDpHSXQ+vcsCCNwNbwGwcx0MtRl4daith
X-Gm-Gg: ASbGncuWnnhEGuh09YBpvdTHa+JDuqiILscKfpEzA8jbHYdUuL+DD9rtM/RYH7zy3yB
	dPccv6B7x35q2HS3MpRIXipRljk6CLmDhcqoPNSjMkUhEqr5lckT5cnBYiCVg3EBaL40/1qjTnW
	i5odBk1YJBCbocGPBvoj4DRhRpsTtDyGKlw71C/kgrfws9BzDuZwB35srENfRVe1dYzD297XNlm
	dLxch5agz1A0KlHXUN+Ph0dhDam/kbA8Nr3UZIoSxqb61mYGuETEVHX8i5tuOzup2KdJXvZE7C8
	rbFTaiKoy5Z8AVPC7PRthtFdiohtd8FMCwgu
X-Google-Smtp-Source: AGHT+IGuhy2c1WoNaDo9yFzzcMM4wWUTw3FFxFrVQBL+cYcgewzWi0uZXQ3wZXqyYkHB8UE1Pe90fyZ3dkNBjdEdl1s=
X-Received: by 2002:a05:6512:154f:20b0:595:9b2f:1dd4 with SMTP id
 2adb3069b0e04-598ee30927fmr562e87.6.1765310119583; Tue, 09 Dec 2025 11:55:19
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119-scratch-bobbyeshleman-devmem-tcp-token-upstream-v7-0-1abc8467354c@meta.com>
 <aTh9/waV23uRZc9E@devvm11784.nha0.facebook.com>
In-Reply-To: <aTh9/waV23uRZc9E@devvm11784.nha0.facebook.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 9 Dec 2025 11:55:07 -0800
X-Gm-Features: AQt7F2otnRUBenjt4JJtgI3V8rfSk5ICp-r1g2bzqOO9K4G5rKMrxzIjxam7SUE
Message-ID: <CAHS8izPm22VoGCv93q=_nGhqOUR3R0JzVpYW6u0EJVxJJB-5Ag@mail.gmail.com>
Subject: Re: [PATCH net-next v7 0/5] net: devmem: improve cpu cost of RX token management
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, 
	Neal Cardwell <ncardwell@google.com>, David Ahern <dsahern@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, 
	Donald Hunter <donald.hunter@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Stanislav Fomichev <sdf@fomichev.me>, Bobby Eshleman <bobbyeshleman@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 9, 2025 at 11:52=E2=80=AFAM Bobby Eshleman <bobbyeshleman@gmail=
.com> wrote:
>
> On Wed, Nov 19, 2025 at 07:37:07PM -0800, Bobby Eshleman wrote:
> > This series improves the CPU cost of RX token management by adding an
> > attribute to NETDEV_CMD_BIND_RX that configures sockets using the
> > binding to avoid the xarray allocator and instead use a per-binding nio=
v
> > array and a uref field in niov.
> >
> > Improvement is ~13% cpu util per RX user thread.
> >
> > Using kperf, the following results were observed:
> >
> > Before:
> >       Average RX worker idle %: 13.13, flows 4, test runs 11
> > After:
> >       Average RX worker idle %: 26.32, flows 4, test runs 11
> >
> > Two other approaches were tested, but with no improvement. Namely, 1)
> > using a hashmap for tokens and 2) keeping an xarray of atomic counters
> > but using RCU so that the hotpath could be mostly lockless. Neither of
> > these approaches proved better than the simple array in terms of CPU.
> >
> > The attribute NETDEV_A_DMABUF_AUTORELEASE is added to toggle the
> > optimization. It is an optional attribute and defaults to 0 (i.e.,
> > optimization on).
> >
>
> [...]
> >
> > Changes in v7:
> > - use netlink instead of sockopt (Stan)
> > - restrict system to only one mode, dmabuf bindings can not co-exist
> >   with different modes (Stan)
> > - use static branching to enforce single system-wide mode (Stan)
> > - Link to v6: https://lore.kernel.org/r/20251104-scratch-bobbyeshleman-=
devmem-tcp-token-upstream-v6-0-ea98cf4d40b3@meta.com
> >
>
> Mina, I was wondering if you had any feedback on this approach?
>

Sorry for the delay, I'll take a look shortly.


--=20
Thanks,
Mina

