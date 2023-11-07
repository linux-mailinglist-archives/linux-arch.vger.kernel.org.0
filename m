Return-Path: <linux-arch+bounces-70-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5FC7E4D9B
	for <lists+linux-arch@lfdr.de>; Wed,  8 Nov 2023 00:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 153951C20BF7
	for <lists+linux-arch@lfdr.de>; Tue,  7 Nov 2023 23:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194222A1A4;
	Tue,  7 Nov 2023 23:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w050P916"
X-Original-To: linux-arch@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF4034567
	for <linux-arch@vger.kernel.org>; Tue,  7 Nov 2023 23:55:47 +0000 (UTC)
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29A410E5
	for <linux-arch@vger.kernel.org>; Tue,  7 Nov 2023 15:55:46 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id ada2fe7eead31-45da062101bso1823556137.2
        for <linux-arch@vger.kernel.org>; Tue, 07 Nov 2023 15:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699401345; x=1700006145; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PNu6xIseaeQdGwpUSRstKqA7TEpi7Fwk8Tof0W7Ynro=;
        b=w050P91670V31SiipDnCoZIMevD5IoGEKlyZ/HpxTt0BuhaeLMnpREfCWdCsQk4gdA
         DC9buuUb29GyFREs4BahodE6tyf7272GU96HUZNis/9He1cvt3Wdj9TUJLotU8vMhMuu
         wbQsm6hTFR9ryeWa9TZxItXmkl22WJNZ4ihqK8K4/wffkPI+F8bD3O1x2X3/ZHJYPXbn
         ldiIEydyA80PjPY8DKz5uz44QFilagFQ4XqQDjs8kfQehOK6FabjnRGooj4kEj6K4b+C
         PsxBBVRrZj6TfKbma6TT2W5PmhtksOz2/fn5C4n/MIcKY9sbyGCo73jxOE0W/AniiMqK
         h33Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699401345; x=1700006145;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PNu6xIseaeQdGwpUSRstKqA7TEpi7Fwk8Tof0W7Ynro=;
        b=n8XLbaz2P+tMSXyYiBqK1zHerNA9bRXSCp76jxsWrcE5v9ZVrNvFskct3/HwEoblHD
         kOeSStvO3w0dngv7hngd7Oh31VUvJ40jdgah7GD+JWbuHQsSmrkEB2zz4qR2FSKp+Mn9
         EEnJjLJjPpTsDvtJXxVP1JZLjB7EasJwsttAHNvvmokNhHJ5j9uxxr33Nl+nkbZ98uCc
         4Cz0wHNv4dAKIfXgED79Y2zw+f0FLiZkDYufL9AY/DeISIx02MhTBS11jOqY/3TAf0dc
         e6fiAOLeWaYMgJ8VBm4usp7WFFgqD0uLH3AfNxqJSHH9q76yxBoGT78uvPqw2W803Mx5
         IHWg==
X-Gm-Message-State: AOJu0Yz/eOujQujhttGQi7Bbg5JByrq5lzw94bOTVAQSJv9VOzIymuU/
	xwhlH37E6rfNLRBj92ow9TxDI4rrh3YLIiblXxlq0g==
X-Google-Smtp-Source: AGHT+IGAhMHfijiOgGFQJswkLry8kjZeu/iVYNuDlNtd8WO059Ha5h/GvIFdFrsJHAgrw88t80FpdwX0AhNrgdX2dVY=
X-Received: by 2002:a67:e782:0:b0:45d:9083:f876 with SMTP id
 hx2-20020a67e782000000b0045d9083f876mr265655vsb.6.1699401345241; Tue, 07 Nov
 2023 15:55:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231106024413.2801438-1-almasrymina@google.com>
 <20231106024413.2801438-11-almasrymina@google.com> <ZUk0FGuJ28s1d9OX@google.com>
 <CAHS8izNFv7r6vqYR_TYqcCuDO61F+nnNMhsSu=DrYWSr3sVgrA@mail.gmail.com>
 <CAF=yD-+MFpO5Hdqn+Q9X54SBpgcBeJvKTRD53X2oM4s8uVqnAQ@mail.gmail.com>
 <ZUlp8XutSAScKs_0@google.com> <CAF=yD-JZ88j+44MYgX-=oYJngz4Z0zw6Y0V3nHXisZJtNu7q6A@mail.gmail.com>
 <CAKH8qBueYgpxQTvTwngOs6RNjy9yvLF92s1p5nFrobw_UprNMQ@mail.gmail.com>
 <93eb6a2b-a991-40ca-8f26-f520c986729a@kernel.org> <CAF=yD-Ln4v8orUne8E7D2_eHu39PWPCrMR3Qtuh312pCu=erng@mail.gmail.com>
In-Reply-To: <CAF=yD-Ln4v8orUne8E7D2_eHu39PWPCrMR3Qtuh312pCu=erng@mail.gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 7 Nov 2023 15:55:31 -0800
Message-ID: <CAHS8izOU06ceKyc5oVZhdCKJqmeRdcRyJBFpjGe=u2yh=V52dQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 10/12] tcp: RX path for devmem TCP
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: David Ahern <dsahern@kernel.org>, Stanislav Fomichev <sdf@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Shakeel Butt <shakeelb@google.com>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Willem de Bruijn <willemb@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 6, 2023 at 4:03=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> On Mon, Nov 6, 2023 at 3:55=E2=80=AFPM David Ahern <dsahern@kernel.org> w=
rote:
> >
> > On 11/6/23 4:32 PM, Stanislav Fomichev wrote:
> > >> The concise notification API returns tokens as a range for
> > >> compression, encoding as two 32-bit unsigned integers start + length=
.
> > >> It allows for even further batching by returning multiple such range=
s
> > >> in a single call.
> > >
> > > Tangential: should tokens be u64? Otherwise we can't have more than
> > > 4gb unacknowledged. Or that's a reasonable constraint?
> > >
> >
> > Was thinking the same and with bits reserved for a dmabuf id to allow
> > multiple dmabufs in a single rx queue (future extension, but build the
> > capability in now). e.g., something like a 37b offset (128GB dmabuf
> > size), 19b length (large GRO), 8b dmabuf id (lots of dmabufs to a queue=
).
>
> Agreed. Converting to 64b now sounds like a good forward looking revision=
.

The concept of IDing a dma-buf came up in a couple of different
contexts. First, in the context of us giving the dma-buf ID to the
user on recvmsg() to tell the user the data is in this specific
dma-buf. The second context is here, to bind dma-bufs with multiple
user-visible IDs to an rx queue.

My issue here is that I don't see anything in the struct dma_buf that
can practically serve as an ID:

https://elixir.bootlin.com/linux/v6.6-rc7/source/include/linux/dma-buf.h#L3=
02

Actually, from the userspace, only the name of the dma-buf seems
queryable. That's only unique if the user sets it as such. The dmabuf
FD can't serve as an ID. For our use case we need to support 1 process
doing the dma-buf bind via netlink, sharing the dma-buf FD to another
process, and that process receives the data.  In this case the FDs
shown by the 2 processes may be different. Converting to 64b is a
trivial change I can make now, but I'm not sure how to ID these
dma-bufs. Suggestions welcome. I'm not sure the dma-buf guys will
allow adding a new ID + APIs to query said dma-buf ID.

--
Thanks,
Mina

