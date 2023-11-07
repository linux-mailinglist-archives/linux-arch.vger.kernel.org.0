Return-Path: <linux-arch+bounces-67-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B32017E4BA5
	for <lists+linux-arch@lfdr.de>; Tue,  7 Nov 2023 23:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DEB92813FF
	for <lists+linux-arch@lfdr.de>; Tue,  7 Nov 2023 22:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940192A8C0;
	Tue,  7 Nov 2023 22:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="izoEPk39"
X-Original-To: linux-arch@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2397C2A1AA
	for <linux-arch@vger.kernel.org>; Tue,  7 Nov 2023 22:23:22 +0000 (UTC)
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8010B11C
	for <linux-arch@vger.kernel.org>; Tue,  7 Nov 2023 14:23:22 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5b7fb057153so4975173a12.1
        for <linux-arch@vger.kernel.org>; Tue, 07 Nov 2023 14:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699395802; x=1700000602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Pmozh0ybI7SbfNg64kEULMiwr3zKJkFxXH8jQ6gCVM=;
        b=izoEPk39tqUfOifZkL9mKfl1YAU7GCXRX/ZXJXZRdlk+1UH2+aWafH+4gnT8MnBwdC
         +ASbrpYY5N55torcG421dxWhTV7MlYXPxEh5e+e3Ws3IWrtjPKS3pC9wqWJudPuRD6Nx
         sl0ICx5rQ2VCQVdIuEQ6IUatHJE7zHCE14Sw0o3nSIqyHaGQSkhrm2zMd9edZUqxqPTc
         23p/J4VlnYYqkYtx1bfuffQ9KG/gcdhsPsH1hsSA1e5f/FMDubp992lKv0HoI1ZivSJW
         QZNieQvsuMR9zN4pa/mES1gpDpL9xCyKp2xy6AXbpfHOtIwz57BYwQUGaxDsn2tBTCRz
         azow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699395802; x=1700000602;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0Pmozh0ybI7SbfNg64kEULMiwr3zKJkFxXH8jQ6gCVM=;
        b=cAUBflQNDyIo9vMCFHhMM3hgE6bUGITpUp49Dp2OKNaWp2r8xIjllSDqkUXSot5Vzu
         Qv72rPUO+rSJimizPVZVgfuXUCboFvpAlN6Phh3Vot+vyKqQmPyL91lqZTmJ211/sWus
         1F4vdjflb0Vzxw0XgB5y04mCjnIK4ZwBHA3Ji2kr5Rij63wYxloKxZZVWKV1DvB37Kll
         YvGxtuyROZMlKLOlKt1zuwz1FbltmKq/Xvcnt358zaqFe/igt4hiWY79qNb9EW9Y1yHj
         CLYMy9jC4cYYFsA0A3yKAjXq67kMi9UTFFn1oHTzQOPDNnXuZxWVdm5kFOl4vOW3ftYK
         ImHQ==
X-Gm-Message-State: AOJu0Yxr91xWggex9xgBpfW+Uw5OUTmaV9blNAY7mzsx7dxn1ftwAuK3
	bSkNTiW+JVPHImwIHtLI6Ku3OCU=
X-Google-Smtp-Source: AGHT+IH1xKdg+nrZdYHc/L2SejfqkQOSdqRffH8LAz7J5HMiZt1d8BbpMO2b6yTqmZzIZmhgTiZbQUk=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:903:3244:b0:1cc:bb7f:bd60 with SMTP id
 ji4-20020a170903324400b001ccbb7fbd60mr6825plb.6.1699395801930; Tue, 07 Nov
 2023 14:23:21 -0800 (PST)
Date: Tue, 7 Nov 2023 14:23:20 -0800
In-Reply-To: <CANn89iJNR8bYYBO92=f5_2hFoTK8+giH11o-7NHURoahwvV11w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAHS8izMaAhoae5ChnzO4gny1cYYnqV1cB8MC2cAF3eoyt+Sf4A@mail.gmail.com>
 <ZUlvzm24SA3YjirV@google.com> <CAHS8izMQ5Um_ScY0VgAjaEaT-hRh4tFoTgc6Xr9Tj5rEj0fijA@mail.gmail.com>
 <CAKH8qBsbh8qYxNHZ6111RQFFpNWbWZtg0LDXkn15xcsbAq4R6w@mail.gmail.com>
 <CAF=yD-+BuKXoVL8UF+No1s0TsHSzBTz7UrB1Djt_BrM74uLLcg@mail.gmail.com>
 <CAHS8izNxKHhW5uCqmfau6n3c18=hE3RXzA+ng5LEGiKj12nGcg@mail.gmail.com>
 <ZUmNk98LyO_Ntcy7@google.com> <CAHS8izNTDsHTahkd17zQVQnjzniZAk-dKNs-Mq0E4shdrXOJbg@mail.gmail.com>
 <ZUqms8QzQpfPQWyy@google.com> <CANn89iJNR8bYYBO92=f5_2hFoTK8+giH11o-7NHURoahwvV11w@mail.gmail.com>
Message-ID: <ZUq42Po1Pn-9QxrM@google.com>
Subject: Re: [RFC PATCH v3 09/12] net: add support for skbs with unreadable frags
From: Stanislav Fomichev <sdf@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Mina Almasry <almasrymina@google.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	"Christian =?utf-8?B?S8O2bmln?=" <christian.koenig@amd.com>, Shakeel Butt <shakeelb@google.com>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 11/07, Eric Dumazet wrote:
> On Tue, Nov 7, 2023 at 10:05=E2=80=AFPM Stanislav Fomichev <sdf@google.co=
m> wrote:
>=20
> >
> > I don't understand. We require an elaborate setup to receive devmem cms=
gs,
> > why would some random application receive those?
>=20
>=20
> A TCP socket can receive 'valid TCP packets' from many different sources,
> especially with BPF hooks...
>=20
> Think of a bonding setup, packets being mirrored by some switches or
> even from tc.
>=20
> Better double check than be sorry.
>=20
> We have not added a 5th component in the 4-tuple lookups, being "is
> this socket a devmem one".
>=20
> A mix of regular/devmem skb is supported.

Can we mark a socket as devmem-only? Do we have any use-case for those
hybrid setups? Or, let me put it that way: do we expect API callers
to handle both linear and non-linear cases correctly?
As a consumer of the previous versions of these apis internally,
I find all those corner cases confusing :-( Hence trying to understand
whether we can make it a bit more rigid and properly defined upstream.

But going back to that MSG_SOCK_DEVMEM flag. If the application is
supposed to handle both linear and devmem chucks, why do we need
this extra MSG_SOCK_DEVMEM opt-in to signal that it's able to process
it? From Mina's reply, it seemed like MSG_SOCK_DEVMEM is there to
protect random applications that get misrouted devmem skb. I don't
see how returning EFAULT helps in that case.

