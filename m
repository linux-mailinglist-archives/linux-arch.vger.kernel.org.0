Return-Path: <linux-arch+bounces-2-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5137E3176
	for <lists+linux-arch@lfdr.de>; Tue,  7 Nov 2023 00:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3F12280D76
	for <lists+linux-arch@lfdr.de>; Mon,  6 Nov 2023 23:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42EC02FE0C;
	Mon,  6 Nov 2023 23:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0fFLegmb"
X-Original-To: linux-arch@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F292D057
	for <linux-arch@vger.kernel.org>; Mon,  6 Nov 2023 23:32:39 +0000 (UTC)
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43D292
	for <linux-arch@vger.kernel.org>; Mon,  6 Nov 2023 15:32:37 -0800 (PST)
Received: by mail-vk1-xa31.google.com with SMTP id 71dfb90a1353d-4ac71c558baso361210e0c.2
        for <linux-arch@vger.kernel.org>; Mon, 06 Nov 2023 15:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699313557; x=1699918357; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=whIvC0sNba4bFzFOhrMovdRgssWrwgttcPpuIWiql/s=;
        b=0fFLegmbL+Iaw2NnAVRviDlP/OLm9i/CKzG4iU/X2gMdRfz6aMmu5/Lmv0lhbcz6a9
         0cOVzosG3ZULPed5qqIEAS8I0H9UjqEkxU7AS8S6swCnYUA50PMNgBoGjZUVmzJFiVmS
         2LEQAWHf7LI9fv90CLTZVsLzuw4xc84SYwlH3J7mDfWyvLLFVDRB4wG3cTq0PnEt1p3X
         4FoN/GRHBTqkmResJghw2NgA4vvC8Px3oxjqNlNODNHrbB51SdSp/svRZFM4VC7vjTL0
         YLH+BLj6Jh7pGQH83RnksObHNPNrOKBBdERwO3OVaNEZ4Faxb4/lMJo4akEP34zP5SNf
         4x2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699313557; x=1699918357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=whIvC0sNba4bFzFOhrMovdRgssWrwgttcPpuIWiql/s=;
        b=rWNi+e5d1UUSFLWUwk6B/SxBwtv6EnDcUz6+FqQ8DbIs3v4JJHIIUA1ihnrZ+vDEee
         h0TrpUsWlapdWjVIs9cyS9mzr4kCbOHxbgg2iBuTtrDAtZMLQuETf/ht4yuC2RdhSiht
         uUcYiTMwGj6gKxh07/9uvnYQvm7bYst0laGLF20kwueCoQsFEwhV4FAs93+q64Ee8OWR
         sAsR08URFHt0UMEEUZAskdMde5eWxbw8pEyiZbZsvONsMiJAObwh7uJ0zuEFt5WCVhUs
         apEcANOI7fTf88o4E4d8eP2X9AsnlhgN0zTAYFt5s3d0OWKFjPnyCp9AlcoATdpIDXcY
         zG7Q==
X-Gm-Message-State: AOJu0YyVuLs7vQb3Px38hKLki5WHJUgORlixQFGK0HIXRhF7PgTJgwa5
	qF5oI6gHiiuUACAqaWvIsjZphcQYLMnfMVrzlEuvucCQ5qghATRUkVs=
X-Google-Smtp-Source: AGHT+IGmUk3aoWvy+y4mxwNHeg1dbWxOSmuBU86aI53ERZ2BByHAM1yuczTbLq3vsaQkYp3X4vYpf4DlMVyUBfadW3s=
X-Received: by 2002:a1f:9d04:0:b0:4ac:6a9d:c49b with SMTP id
 g4-20020a1f9d04000000b004ac6a9dc49bmr2214430vke.14.1699313556771; Mon, 06 Nov
 2023 15:32:36 -0800 (PST)
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
In-Reply-To: <CAF=yD-JZ88j+44MYgX-=oYJngz4Z0zw6Y0V3nHXisZJtNu7q6A@mail.gmail.com>
From: Stanislav Fomichev <sdf@google.com>
Date: Mon, 6 Nov 2023 15:32:22 -0800
Message-ID: <CAKH8qBueYgpxQTvTwngOs6RNjy9yvLF92s1p5nFrobw_UprNMQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 10/12] tcp: RX path for devmem TCP
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Shakeel Butt <shakeelb@google.com>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Willem de Bruijn <willemb@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 6, 2023 at 2:56=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> On Mon, Nov 6, 2023 at 2:34=E2=80=AFPM Stanislav Fomichev <sdf@google.com=
> wrote:
> >
> > On 11/06, Willem de Bruijn wrote:
> > > > > IMHO, we need a better UAPI to receive the tokens and give them b=
ack to
> > > > > the kernel. CMSG + setsockopt(SO_DEVMEM_DONTNEED) get the job don=
e,
> > > > > but look dated and hacky :-(
> > > > >
> > > > > We should either do some kind of user/kernel shared memory queue =
to
> > > > > receive/return the tokens (similar to what Jonathan was doing in =
his
> > > > > proposal?)
> > > >
> > > > I'll take a look at Jonathan's proposal, sorry, I'm not immediately
> > > > familiar but I wanted to respond :-) But is the suggestion here to
> > > > build a new kernel-user communication channel primitive for the
> > > > purpose of passing the information in the devmem cmsg? IMHO that se=
ems
> > > > like an overkill. Why add 100-200 lines of code to the kernel to ad=
d
> > > > something that can already be done with existing primitives? I don'=
t
> > > > see anything concretely wrong with cmsg & setsockopt approach, and =
if
> > > > we switch to something I'd prefer to switch to an existing primitiv=
e
> > > > for simplicity?
> > > >
> > > > The only other existing primitive to pass data outside of the linea=
r
> > > > buffer is the MSG_ERRQUEUE that is used for zerocopy. Is that
> > > > preferred? Any other suggestions or existing primitives I'm not awa=
re
> > > > of?
> > > >
> > > > > or bite the bullet and switch to io_uring.
> > > > >
> > > >
> > > > IMO io_uring & socket support are orthogonal, and one doesn't precl=
ude
> > > > the other. As you know we like to use sockets and I believe there a=
re
> > > > issues with io_uring adoption at Google that I'm not familiar with
> > > > (and could be wrong). I'm interested in exploring io_uring support =
as
> > > > a follow up but I think David Wei will be interested in io_uring
> > > > support as well anyway.
> > >
> > > I also disagree that we need to replace a standard socket interface
> > > with something "faster", in quotes.
> > >
> > > This interface is not the bottleneck to the target workload.
> > >
> > > Replacing the synchronous sockets interface with something more
> > > performant for workloads where it is, is an orthogonal challenge.
> > > However we do that, I think that traditional sockets should continue
> > > to be supported.
> > >
> > > The feature may already even work with io_uring, as both recvmsg with
> > > cmsg and setsockopt have io_uring support now.
> >
> > I'm not really concerned with faster. I would prefer something cleaner =
:-)
> >
> > Or maybe we should just have it documented. With some kind of path
> > towards beautiful world where we can create dynamic queues..
>
> I suppose we just disagree on the elegance of the API.

Yeah, I might be overly sensitive to the apis that use get/setsockopt
for something more involved than setting a flag.
Probably because I know that bpf will (unnecessarily) trigger on these :-D
I had to implement that bpf "bypass" (or fastpath) for
TCP_ZEROCOPY_RECEIVE and it looks like this token recycle might also
benefit from something similar.

> The concise notification API returns tokens as a range for
> compression, encoding as two 32-bit unsigned integers start + length.
> It allows for even further batching by returning multiple such ranges
> in a single call.

Tangential: should tokens be u64? Otherwise we can't have more than
4gb unacknowledged. Or that's a reasonable constraint?


> This is analogous to the MSG_ZEROCOPY notification mechanism from
> kernel to user.
>
> The synchronous socket syscall interface can be replaced by something
> asynchronous like io_uring. This already works today? Whatever
> asynchronous ring-based API would be selected, io_uring or otherwise,
> I think the concise notification encoding would remain as is.
>
> Since this is an operation on a socket, I find a setsockopt the
> fitting interface.

