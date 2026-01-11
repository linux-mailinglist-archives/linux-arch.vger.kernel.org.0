Return-Path: <linux-arch+bounces-15747-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 769B8D0F9EA
	for <lists+linux-arch@lfdr.de>; Sun, 11 Jan 2026 20:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31208302C13C
	for <lists+linux-arch@lfdr.de>; Sun, 11 Jan 2026 19:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B3C352C40;
	Sun, 11 Jan 2026 19:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YwZEnLcV"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E5421ABBB
	for <linux-arch@vger.kernel.org>; Sun, 11 Jan 2026 19:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768158878; cv=pass; b=hI58hCU3srjydMSlEfAf6TJuQNuFhVu9VhGiQc6jtdh0SyI7LTqybqrNHEMbZUF19mN1VQSuT7TSY4tFGdacC99OSqz+VPBZKhs/aFbL7dDP3r/FweWGaoTmkc6noxdBkcYfQe4KBTHhb9k30OrCC8Kw5aScRJEDiOLRACSPC64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768158878; c=relaxed/simple;
	bh=k6AlMVy9ciJTJpdV8gMWZ1nSB+n2ZPly1UT3btHq6go=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JyjpXPhzq8AvIsThtTEZWfh9bc9QFQXDLP4FJFNI0wawldbY+LK2+lKnW/QICypJpxO7XwRAK48txcqSXov7y9utCeEBOOHGfGYXwLDuktr/rysGNwmrtoGR+HAfI/frHYjiP7XaP1CIAkMdSdSFRAzWnXVS737t2Tu6MrGAyZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YwZEnLcV; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-59b30269328so4752e87.0
        for <linux-arch@vger.kernel.org>; Sun, 11 Jan 2026 11:14:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768158875; cv=none;
        d=google.com; s=arc-20240605;
        b=QmtVhrNiTZRlDQZJCN4aMlYaLhrzIJ7z2ABroy/wXr4gT7y3WJIwEy74TlIKzhx3q3
         j3BXdXKAUegKUHH0Jj9EMf5I3SnLnbTwkSYA4shVI+z5mgBtOxg6zxI4qVQydjGEqAly
         FoSLSLYZBPZ8cNpMv+Bxws48d3jkOQmoaT1N/RpRqYuhz7ARWXYwvduXh0DGA+UdpKnv
         eLxiwD7hfApbFydu543YTDChlLjVhibq70OGl3UBrMydA5W2ti9JF1lyEIgG0xq1Z8DI
         BpJU3mer7lp944OW5cbpBmMamvgtGhfYetXfeBtJUPwycogDXIBCT4SCLdfaHqZ5SLWD
         8HJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k6AlMVy9ciJTJpdV8gMWZ1nSB+n2ZPly1UT3btHq6go=;
        fh=OYaS3BEXWOYjf0Iz5IzWQqKR3wbzAweQWGin0CWCnLE=;
        b=VVvZjZQ+C8EpFLGn/pCGWDPnbZgpRw6v1DaZs+168H3XzyaQdVsPOAOJPMznd7OBBL
         NxBuY5noAdnobfONhSV2YRSBryAGNGd9fyWsBVYVsJesHgHuRJoVopU3JgJirbSJH0F7
         3TMiDrfe9/VbIAk29YjeCHbSRWLsROKolzJhkjFl8wgp9x8xNh2fuoZq12k4vJa0+gvb
         DhC/60CDCgdWhILcY4ypkrZkN3cU9H0y96zn7RtM21rIDgL60JWnCJ84ZOM0T+w+j1QG
         lA+Zh701NIlEtdEMKOkQXDIpSAm74XI9wJ0abD+hNKg+hGXRhmvILZEzkDAoY7oZA2Ae
         knjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768158875; x=1768763675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k6AlMVy9ciJTJpdV8gMWZ1nSB+n2ZPly1UT3btHq6go=;
        b=YwZEnLcVqIzSeKspGBMgiQsamdY9J47OeszZkd17u2WGJZ2R3NDdnM1klKlKJ2hXCE
         dPl6Ja0ECKfJjKRjJCffz3Elfr1InkHly4OLGUNy5JQZoFDnHx5dqyDZckTk6S5co+tJ
         KunFm1p6UejfZGc/Mo+sXI8QO7UFESS9QVbkBgn0PsfnHG7vSWMjSpdTm/yuTPv1S22q
         yAOaG46N94oZrqFUPi8G41iiyr98rN5EDw7/sMKzBdWb3lhV4xOv/N4nTm3QEBg1T96B
         hkbOF+ukA7Lpg2ISpyXm9zR/eM2RqZIzhDy6r6UhK9ONN5oRQbW+RXDgZvZFelre5jve
         0fLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768158875; x=1768763675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k6AlMVy9ciJTJpdV8gMWZ1nSB+n2ZPly1UT3btHq6go=;
        b=pPLdxcOpk0RV3YW4+f7dDJmnvUmuZfErp6fPKwz1ccvSkx8JcEDGZ7a/9/pvsYoDLb
         eHwc+FnLMxLHrbbcpGXVFvg3ezCkWuRftP5kJzzmP5fj+eQmefMCZOvj+YFgpC7uW0DN
         cOJ8OymltZwdLc+oaXEHjZWf4Gx2ZVzmNeAg4sZmkKsABrSEzom81ih/QZ0xqNl7vsQH
         eTLECDt8jOWspZJuBeGVudRI/kr1sZ3hPdTJk+ooUimZwOGMP538owR2p08bPRRIBMe2
         OrW9+4c1qkI5lybzol8FE83sQ4Niod4sCbC1rh0AEJSPQ6bJ++dq6iZsvjWSqUSkKs2W
         FOBA==
X-Forwarded-Encrypted: i=1; AJvYcCUJi2u+vnqitK7uJ3Gw7bx0aRWVrh3hmgyAbH2ErsluUPLIFwlQAqQEFpznlHK8qgRCUU5KhCvj92mR@vger.kernel.org
X-Gm-Message-State: AOJu0YwHwlEO3im7FKUelJsLQ6s0T6siq0fT8N7RLvdVUrAMiU8WuANJ
	m8Lc30jAL8bgNt7i0lCD3ODPuu34OG0Lag1Q2tbVq37Nz1BbEReKYAfwq7SA2MBK9Ntvz9qJjhl
	Yo0CzfdyI0AVf6JegAC6NOqVJJw0818POmZOIYSX7
X-Gm-Gg: AY/fxX5WByq2sTUpLSLjwmBBoT43HfR3evhrdIpcBvsU0DCFeDXnJ17f2mjIIhNOr33
	T9U50iRaRAKxek6PbQw/ngzHcZ3vfubWk2hzTlT6j4AZLwJgPALw59AM0vyULtS7JvvX0qLCHEC
	vGEZqaB2Z/JpNXAzHHMzOTCCRVql7fEXk++DiRyVt6JtMUqnXkb2KVw2EWjpq5bzHmOsckJJgyo
	8xVM3N81DhBMeKfxh9Uw7/g7KOlB4HOHlLdr0z/QUMo23Bb3vYAWDQzkXqUOv34F+t69To3i9LD
	RHpZeg==
X-Received: by 2002:ac2:5392:0:b0:59b:9403:c67f with SMTP id
 2adb3069b0e04-59b9403c7fdmr1298e87.14.1768158874137; Sun, 11 Jan 2026
 11:14:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109-scratch-bobbyeshleman-devmem-tcp-token-upstream-v9-0-8042930d00d7@meta.com>
 <20260109-scratch-bobbyeshleman-devmem-tcp-token-upstream-v9-4-8042930d00d7@meta.com>
In-Reply-To: <20260109-scratch-bobbyeshleman-devmem-tcp-token-upstream-v9-4-8042930d00d7@meta.com>
From: Mina Almasry <almasrymina@google.com>
Date: Sun, 11 Jan 2026 11:14:21 -0800
X-Gm-Features: AZwV_Qjc9N7obQhSR7tfjDnibSqsWsISSF4YswjnxYBiVBax_pCtfSgtAahmfw0
Message-ID: <CAHS8izP=udLS2E2ZCvY4dGu3=L+SnPVQePsh=hNaM=3gy=YtHw@mail.gmail.com>
Subject: Re: [PATCH net-next v9 4/5] net: devmem: document NETDEV_A_DMABUF_AUTORELEASE
 netlink attribute
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, 
	Neal Cardwell <ncardwell@google.com>, David Ahern <dsahern@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, 
	Donald Hunter <donald.hunter@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	asml.silence@gmail.com, matttbe@kernel.org, skhawaja@google.com, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 6:19=E2=80=AFPM Bobby Eshleman <bobbyeshleman@gmail.=
com> wrote:
>
> From: Bobby Eshleman <bobbyeshleman@meta.com>
>
> Update devmem.rst documentation to describe the autorelease netlink
> attribute used during RX dmabuf binding.
>
> The autorelease attribute is specified at bind-time via the netlink API
> (NETDEV_CMD_BIND_RX) and controls what happens to outstanding tokens
> when the socket closes.
>
> Document the two token release modes (automatic vs manual), how to
> configure the binding for autorelease, the perf benefits, new caveats
> and restrictions, and the way the mode is enforced system-wide.
>
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

