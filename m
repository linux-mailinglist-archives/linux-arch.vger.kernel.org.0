Return-Path: <linux-arch+bounces-15748-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A42C0D0F9F9
	for <lists+linux-arch@lfdr.de>; Sun, 11 Jan 2026 20:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16F203029233
	for <lists+linux-arch@lfdr.de>; Sun, 11 Jan 2026 19:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E416352C44;
	Sun, 11 Jan 2026 19:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s3nGd6dM"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44932D7D42
	for <linux-arch@vger.kernel.org>; Sun, 11 Jan 2026 19:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768159014; cv=pass; b=PD9lRS1gno8JnOPHfIEVb6N7mvKM8vIe/ot9akDi+F1Ic01T39TgMbG9AthRn2sP6XnU0vltifCFCsC2XaUUTycYkjFlsPeCuDyazKXBKfmveofPgwT+cO8slzUCjbh3oag9A9GUCnxZGstEZSqDnmNZZwbKyUkhBYhYfqBjOoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768159014; c=relaxed/simple;
	bh=GK10uFFBfJnUN7pJIA3veOdTRXwgC+DVFIf9jpvuer8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uq8zxXXdB9xgXQtF6RmO/l9zgdpCfnngmB4v6uYH9c+DhudHmuykmp42AaJ9z3uj8JTXvgoscv0kA8X5rBviO4Jx1bJXnEctrpgocm9/QJ1UAQ4T7p3G/Jr2Byi9Vf96PbBmi7KTq4GTHe/bMoSPEUXUkdvwpWUtojq/XnW06hA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s3nGd6dM; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-59b6935a784so3681e87.1
        for <linux-arch@vger.kernel.org>; Sun, 11 Jan 2026 11:16:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768159011; cv=none;
        d=google.com; s=arc-20240605;
        b=RQLuLQm6FObUmQhVFUnkohItmWg4+p4zZfhKPbyvmGfusvyAunHubQ/2jexSAhZFN2
         B9KQcN5bdSxjl6Fgn9gbX8DW5WnO7y/5ngDWrdJXKZJVuZwmPaKOnDvSzo0+YJ6s95HO
         TETrLp7mDaDKTGlSOXvHlsFk+VnyB2To/e0Dy/ZeAA7Dwb7VXbQl+XPJ5qs/Dsu+6IS/
         n0Lc0cJovu3QvoOeQ3pSWw1EFteoLlQi8gf7Ph1pCXLh/5GetTVkxgUOUsSIqe7yzLoX
         eCYNqUX6CJMgmJUEoy5WtRurdc4+r1GDZs+1In2sdV4wHUgSs8obviDsPZpr2TFKMwVJ
         c83A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tpRMXwgaiw/um96I4NIndMS1doXfO5B972oFPSt2YCc=;
        fh=L81bNmFu2vVF+SI1zr7JsJsUfpN/C2N/0hqaMFaiTak=;
        b=Gyj1mR7xyZXnK2lLas0tvJ3X2QM/jbjE/hIO/9woFWbXnycn2mN0J4X/+FOcfQZ84o
         JVi1YMylOLygLGZ4o00qANt61CFFFqoOvP/pE+dQGzCtiDmVY9+uHWvIgkvROqTsMKee
         w0u/xpJ2xAabwXojL8mCq00+rANRsknmtuD9c3mnqH0NTcK89Jj2/s1UU2v0s6zuez4K
         SbiY5ugwXiT3ZC3qTOpPdp8GmRBImQNamhvjdpWKjj2+AdP5hlmEgzrZkkxCkH/oDm55
         j7Ck5VuQs7SR2n/a7VFCwAAWwcKufBS2mEg92wmYGyys4/3C6Fel5Mj8rbbuaC8UFWeY
         pLEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768159011; x=1768763811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tpRMXwgaiw/um96I4NIndMS1doXfO5B972oFPSt2YCc=;
        b=s3nGd6dMyfhoMdv06lXdfkER/JtrT4HoSJ3vBu4za87ymCF/PBLC5nvDIxAuN6vsVi
         zKQpw38gzADgTLZm1Hfp3800313WuCaiBz/opRLKThuXvyl1duLUOnfbN+aYVRvWEknR
         ETxVCM0Sr5bJnX0r293bgI2EEK669HhP9l+g8D3KvulVWa3/Xm6JEcvmGemId3A6bKBW
         356/bxF6No6IkFZKkcsySU++qElgUj50YuSPYHcGcaEiOv4IhJgtznkk/7LiPUmB1wLg
         QBRFi/hOeRKW9RocG2pnUZIsR5IlMf0v/okY5q3UHifrBjDGUcrYcqyiMoxaQVTRHtEQ
         WL7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768159011; x=1768763811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tpRMXwgaiw/um96I4NIndMS1doXfO5B972oFPSt2YCc=;
        b=HX4x5tWD3mo4PVSiscblgtMZbtHge6j6B3PpmGfAQGFKm6rQZj4Cb3eOO0S06JU5lF
         ECCbpcTSWHMXgGChe1Fl4nfjO55yTzkVGRgwVGuZi5nnlGZHw06N61Xk0gll7kuE1/7O
         08rzLkGP3hPFZYRNtFSOmF/psrsK5eY6FBwur6f4gtDFGpmLs6a8VyppQxyy51OMgtWQ
         x5Hjai9rH8RMGid+ji0WcD30lGFzZox5ozm84N9swirO3ZruEFMQsmPlsjogTog4JwHR
         uNJycdpKalPIn6FDQ8nAOp+lu4Iz18yjm7Lkl16mqI2g+Q4X/Wv0RmVa5UlzsY+ZIixy
         Hudw==
X-Forwarded-Encrypted: i=1; AJvYcCVig4+s1WmKQ0LbSKS9RnBSWD8lHFOmQmVt9SIAWtOCU186fbAWz65MVII0JURc49o2dKPPXP0d5/A0@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2qrXTj7pP9mwsLnjFDWhh8gRg9ox3ig/p/LWaNR3bSGMNnqsy
	rDVr6pRVirQyn1m94XPLO9XY5nNjwIrDeb5AKypESpnRbvkLOI9f3TNdIoz0vZGlykpTYSX1cZi
	+4SrZAWzAsH8YNTxkM5GqAChAAUNB4vp/mgPthP9K
X-Gm-Gg: AY/fxX7REHef+uhZ1Wc10mRj2YeEwcGDK75qlVCRd+cZbFkH47qYd6DD9VuuEXDcfj7
	6Q9IrgjkyIeXslvHQYJKGPfMNwVOUiZrzD5TlUI2HrWiBKK9mtNylu5yIa7FyzXZv//CVvhWITy
	WPbsmL8v28vAwpP/tWi+kHeZt7SeXXUmGiiCz2Y0l6vPtRvmkgzOJ8lt7YDBY5flApg298ohmIy
	BADjBdpbuMvDOttwdPTbaO5zq8OeGBk35rQwnIauOdq1A3EJXOk970osV2AtHncT6P8ZiI=
X-Received: by 2002:a05:6512:1288:b0:597:d606:5b38 with SMTP id
 2adb3069b0e04-59b85911648mr136353e87.6.1768159010781; Sun, 11 Jan 2026
 11:16:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109-scratch-bobbyeshleman-devmem-tcp-token-upstream-v9-0-8042930d00d7@meta.com>
 <20260109-scratch-bobbyeshleman-devmem-tcp-token-upstream-v9-5-8042930d00d7@meta.com>
In-Reply-To: <20260109-scratch-bobbyeshleman-devmem-tcp-token-upstream-v9-5-8042930d00d7@meta.com>
From: Mina Almasry <almasrymina@google.com>
Date: Sun, 11 Jan 2026 11:16:37 -0800
X-Gm-Features: AZwV_Qir-cv-IZVpPXwaBdmvkArrdmGky4-Qr_YMN1JPM7e8jq7epyBCPXxohO0
Message-ID: <CAHS8izMy_CPHRhzwGMV57hgNnp70Niwvru2WMENPmEJaRfRq5Q@mail.gmail.com>
Subject: Re: [PATCH net-next v9 5/5] selftests: drv-net: devmem: add
 autorelease test
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
> Add test case for autorelease.
>
> The test case is the same as the RX test, but enables autorelease.  The
> original RX test is changed to use the -a 0 flag to disable autorelease.
>
> TAP version 13
> 1..4
> ok 1 devmem.check_rx
> ok 2 devmem.check_rx_autorelease
> ok 3 devmem.check_tx
> ok 4 devmem.check_tx_chunks
>
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

Can you add a test for the problematic/weird scenario I comment on patch 3?

1. User does bind (autorelease on or off)
2. Data is received.
3. User does unbind.
4. User calls recevmsg()
5. User calls dontneed on the frags obtained in 4.

This should work with autorelease=3Don or off, or at least emit a clean
error message (kernel must not splat).

I realize a made a suggestion in patch 3 that may make this hard to
test (i.e. put the kernel in autorelease on/off mode for the boot
session on the first unbind). If we can add a test while making that
simplification great, if not, lets not make the simplification I
guess.

