Return-Path: <linux-arch+bounces-112-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C5357E799D
	for <lists+linux-arch@lfdr.de>; Fri, 10 Nov 2023 07:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF08D2811A2
	for <lists+linux-arch@lfdr.de>; Fri, 10 Nov 2023 06:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C956AB2;
	Fri, 10 Nov 2023 06:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4e5BoRhI"
X-Original-To: linux-arch@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E86B6AB1
	for <linux-arch@vger.kernel.org>; Fri, 10 Nov 2023 06:53:57 +0000 (UTC)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABD87EEB
	for <linux-arch@vger.kernel.org>; Thu,  9 Nov 2023 22:53:56 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-7789cc5c8ccso148303885a.0
        for <linux-arch@vger.kernel.org>; Thu, 09 Nov 2023 22:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699599235; x=1700204035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eHJDdNWZZ4tIwkHZEN1gC9OcT0HCJr1RVppBH6tmUws=;
        b=4e5BoRhI2H4vAa/oZz6RgXvPGcebmjtO54p5v4TsY5n9LtMJ+4Z92mHXZUmlZBdc93
         +WZD5SvaCX9MGl7VRDDhXR8heYXCFH14k/jOSMGY4Nva045GlY3vwzli1zgB6xQP+Vz6
         KKB8JYTTQNpqyV4N5TFnSTaXzTN7nMx1Mh86tUPvyViOvsizxXnCY9cB00iFsYDhwZR5
         BMbGMsL+ZLUh6VZz2st3/Z2GwvlQCR/a7NCkHZwCwrEaq4O9MpOHpfnLJogX+hcxdZu2
         +KK3vW4spqqjLtQJC+8vxSUlCETpSs4C7zkKCmUVgNxgf32CzXlOva1QF4H/3yizCSTx
         iftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699599235; x=1700204035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eHJDdNWZZ4tIwkHZEN1gC9OcT0HCJr1RVppBH6tmUws=;
        b=R/NFLrwuyanuYWlJdQcELgdcgx8NrxPp/Cr/appdyAYmXsYzPawydrORrb5c72mz+k
         SPkDEf46VnXHZ1k5PMfuIAFAR9A7JOEgUFl9BivB4KIIspByx2U9BGQIDeWUnuXLWHdB
         DjqluSz7h1WDMCXQ7hsSOlKD8x1sCDIsayNmDtnCul1rNRdXuMCk4LITRZhLP3ta+2o5
         gPvTeIBMyaU/q5xTIFBQfSJTaKIhuV3Tb/d/xt/J0ecnzafMY0sg9DmCZq2PJjZqYINl
         rTWK7dxD6zH/7W27PX2JWRMo1x09FAh+5nmPQviRcII/hkXQ5Nb8HixPNAmrC2yvAN5N
         LnNw==
X-Gm-Message-State: AOJu0Yw3C93B6F/iCqEiSuU2QRQjvrubC1ILeFdAHQylREkz/Qj8m9uf
	qKexbvUoqOiNGU/U+fRfNiLe+WVvrW5R8LX/Z2wlepovIKdQAdtfrnE=
X-Google-Smtp-Source: AGHT+IHV8+0MFbC/VQpqHkvElGy/RL/z/ISeA+lbF9gB7A+2xFrkzHZehvrtNrke+02jjGbQaJXjvKRk/eDFLYB8QzU=
X-Received: by 2002:a05:6102:3d8b:b0:44d:38d6:5cb8 with SMTP id
 h11-20020a0561023d8b00b0044d38d65cb8mr631035vsv.10.1699589171185; Thu, 09 Nov
 2023 20:06:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231106024413.2801438-1-almasrymina@google.com>
 <20231106024413.2801438-9-almasrymina@google.com> <adde2b31fdd9e7bb4a09f0073580b840bea0bab1.camel@redhat.com>
In-Reply-To: <adde2b31fdd9e7bb4a09f0073580b840bea0bab1.camel@redhat.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 9 Nov 2023 20:06:00 -0800
Message-ID: <CAHS8izMrJVb0ESjFhqUWuxdZ8W5HDmg=yRj1J1sTeGoQjDcJog@mail.gmail.com>
Subject: Re: [RFC PATCH v3 08/12] net: support non paged skb frags
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Shakeel Butt <shakeelb@google.com>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 9, 2023 at 1:15=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On Sun, 2023-11-05 at 18:44 -0800, Mina Almasry wrote:
> [...]
> > @@ -3421,7 +3446,7 @@ static inline struct page *skb_frag_page(const sk=
b_frag_t *frag)
> >   */
> >  static inline void __skb_frag_ref(skb_frag_t *frag)
> >  {
> > -     get_page(skb_frag_page(frag));
> > +     page_pool_page_get_many(frag->bv_page, 1);
>
> I guess the above needs #ifdef CONFIG_PAGE_POOL guards and explicit
> skb_frag_is_page_pool_iov() check ?
>

It doesn't actually. page_pool_page_* helpers are compiled in
regardless of CONFIG_PAGE_POOL, and handle both page_pool_iov* & page*
just fine (the checking happens inside the function).

You may yell at me that it's too confusing... I somewhat agree, but
I'm unsure of what is a better name or location for the helpers. The
helpers handle (page_pool_iov* || page*) gracefully, so they seem to
belong in the page pool for me, but it is indeed surprising/confusing
that these helpers are available even if !CONFIG_PAGE_POOL.

>
> Cheers,
>
> Paolo
>
>


--=20
Thanks,
Mina

