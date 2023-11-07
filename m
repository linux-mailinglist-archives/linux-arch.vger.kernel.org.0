Return-Path: <linux-arch+bounces-62-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 868687E4A71
	for <lists+linux-arch@lfdr.de>; Tue,  7 Nov 2023 22:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E321E2813E5
	for <lists+linux-arch@lfdr.de>; Tue,  7 Nov 2023 21:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB402A1CC;
	Tue,  7 Nov 2023 21:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FVocwmGS"
X-Original-To: linux-arch@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D342A1BB
	for <linux-arch@vger.kernel.org>; Tue,  7 Nov 2023 21:17:58 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B076E10C9
	for <linux-arch@vger.kernel.org>; Tue,  7 Nov 2023 13:17:57 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-54366bb1c02so722a12.1
        for <linux-arch@vger.kernel.org>; Tue, 07 Nov 2023 13:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699391876; x=1699996676; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T2QCCZhbNaMLPXpYCBN6556bTQl/R/gNcXFBlSEHr6s=;
        b=FVocwmGSdxHkbrQ7tWTS2XmP+6qZLpKinaIFJ4qZjAwcbkLFjNkDTYVRevnaSQcI+D
         KEXXF+0M7DFvG7E37VvjOb7veyL6IGMckc0T4YI1LOz6PB4DK7q1iZM62wpu5M15C5eF
         lHoCQKjfFO0ovCSbncChNkAu2/mWN0zrFeRJbEVGralItJLVcEEjacT+sk7n2ZiADLHe
         b/DbkrmextfY25yafPa/LV9X6Z6+qdwbztJsZSa3WBMPdEY1eJiM71gF/397W8hJ3h/9
         UctHYR1aMoZkG99fSELZjAiO5TOkOWWHmPyCYH8Oz1eznDe0dm2GI2udZggxipVwamKh
         LwnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699391876; x=1699996676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T2QCCZhbNaMLPXpYCBN6556bTQl/R/gNcXFBlSEHr6s=;
        b=oxpvFVK89IzGU7ddavggEptaG2/o0Mgn5ExpPqF9t4uhQwNIkpqT8UGPS2K6wKrOsV
         9uPhv4m+JzujP15HaBFQO+C516Yr1hglZKbUZSmLDYCgBzzsc7xXf4k+/rxUJ0scS6W3
         Fs65B0QHGm4l5MWJuq0s4auEYuvb5uUmOPA8CWaV+xOHBnGLaQfiD6digZfpgoNAfYB6
         AcAQiF6tOIH7N6eI/Dnv/U/uPMC9mkLwH5wCmBEw5jKFVbcvETvmnPcwtGIIfoMemgCe
         DI/8x2/Nnqap9at/wOEaSgU7B/VoHiQo72p1o6AL3eeuSmOTn/8nKVh3fRrx4h7pRl4d
         lWng==
X-Gm-Message-State: AOJu0Yys0NBSOEUUMqdOiq/yrkLM9w2iRYa3iuUaJTsiKpZ0BEq+w8ND
	Nd8NoQhCY3iV7OpfVIHevWeGeqLrodINPvqisonVgQ==
X-Google-Smtp-Source: AGHT+IE2BJYg2o+RWiBo7zUK8rUJLrxbtosbDGcrLcTm47eDVBdJN7KV0TjFmGvpMtQ446xGBJBrXEpJoAJUwEcp3Q0=
X-Received: by 2002:a05:6402:e84:b0:544:e249:be8f with SMTP id
 h4-20020a0564020e8400b00544e249be8fmr179390eda.1.1699391875922; Tue, 07 Nov
 2023 13:17:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHS8izMrnVUfbbS=OcJ6JT9SZRRfZ2MC7UnggthpZT=zf2BGLA@mail.gmail.com>
 <ZUlhu4hlTaqR3CTh@google.com> <CAHS8izMaAhoae5ChnzO4gny1cYYnqV1cB8MC2cAF3eoyt+Sf4A@mail.gmail.com>
 <ZUlvzm24SA3YjirV@google.com> <CAHS8izMQ5Um_ScY0VgAjaEaT-hRh4tFoTgc6Xr9Tj5rEj0fijA@mail.gmail.com>
 <CAKH8qBsbh8qYxNHZ6111RQFFpNWbWZtg0LDXkn15xcsbAq4R6w@mail.gmail.com>
 <CAF=yD-+BuKXoVL8UF+No1s0TsHSzBTz7UrB1Djt_BrM74uLLcg@mail.gmail.com>
 <CAHS8izNxKHhW5uCqmfau6n3c18=hE3RXzA+ng5LEGiKj12nGcg@mail.gmail.com>
 <ZUmNk98LyO_Ntcy7@google.com> <CAHS8izNTDsHTahkd17zQVQnjzniZAk-dKNs-Mq0E4shdrXOJbg@mail.gmail.com>
 <ZUqms8QzQpfPQWyy@google.com>
In-Reply-To: <ZUqms8QzQpfPQWyy@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 7 Nov 2023 22:17:42 +0100
Message-ID: <CANn89iJNR8bYYBO92=f5_2hFoTK8+giH11o-7NHURoahwvV11w@mail.gmail.com>
Subject: Re: [RFC PATCH v3 09/12] net: add support for skbs with unreadable frags
To: Stanislav Fomichev <sdf@google.com>
Cc: Mina Almasry <almasrymina@google.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Shakeel Butt <shakeelb@google.com>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Willem de Bruijn <willemb@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 7, 2023 at 10:05=E2=80=AFPM Stanislav Fomichev <sdf@google.com>=
 wrote:

>
> I don't understand. We require an elaborate setup to receive devmem cmsgs=
,
> why would some random application receive those?


A TCP socket can receive 'valid TCP packets' from many different sources,
especially with BPF hooks...

Think of a bonding setup, packets being mirrored by some switches or
even from tc.

Better double check than be sorry.

We have not added a 5th component in the 4-tuple lookups, being "is
this socket a devmem one".

A mix of regular/devmem skb is supported.

