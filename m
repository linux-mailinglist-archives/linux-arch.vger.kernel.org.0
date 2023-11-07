Return-Path: <linux-arch+bounces-61-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D39C47E4A45
	for <lists+linux-arch@lfdr.de>; Tue,  7 Nov 2023 22:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 034CC1C2092E
	for <lists+linux-arch@lfdr.de>; Tue,  7 Nov 2023 21:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4653C6AA;
	Tue,  7 Nov 2023 21:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CLrc7Vs/"
X-Original-To: linux-arch@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A763321BB
	for <linux-arch@vger.kernel.org>; Tue,  7 Nov 2023 21:05:58 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4E711F
	for <linux-arch@vger.kernel.org>; Tue,  7 Nov 2023 13:05:57 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a9012ab0adso83362357b3.1
        for <linux-arch@vger.kernel.org>; Tue, 07 Nov 2023 13:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699391157; x=1699995957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JeYrzwOr78xPwcpsKE4mhPZUV4HYgKXqTY0m7zX5WN8=;
        b=CLrc7Vs/1PCELHyGusVoDCPf/52uCjYwq6cI2ser3URI83cqD1/t2QsbqpK5DNa3zx
         PRu9K0gZTWpt8b27n97Bi4vWIxaaMlxJnIhqAgxQxXUmTDNgROTHOTDvz6vsRnQBW8kd
         iMAG2TYBabVgWWCXYY43noeUEA3P4v5OcByvPUgHM5PacDJw0bwsJYCON+w6GUXHLsEZ
         Iu0IMsJKN4msjEdymno0rhKDwXebRmdyr/NVJLVdVR+Kz6nzuSWAVqEwtFh02xC8hKxm
         zCPGqkCz2ENS2Y+/X0D92XvNPCJICf5Hkn0E/djFFMUgumX3IIoV8rU1okD1hg95vWtE
         zLNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699391157; x=1699995957;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JeYrzwOr78xPwcpsKE4mhPZUV4HYgKXqTY0m7zX5WN8=;
        b=ogZK5i1MyiY+2QdGX4usOT41fuZdRNpd8p2rk8Ts51IRMFQfO0MON/HpF/27TUHMWJ
         KqyNUYawBz8FHFd/YNl4vP24sJo9HO2FdCenFbxj/i3yUPJHFdoNR9ucsQ6txidcM69s
         iIEYfxQb2hLsl4uXDh8ns5jrLWpEWAY+3MRpuDqSsXs+QSvyYAo2xddSNecP5VXEEsHs
         +QvsYJPiFQmY/29q3oYDpC/j4O/qfP9a/5sGILXQ7aSDX3cozkDQmQ413XidXrA0xfED
         Z5sINLb2CA5tlNkl9qUvkg5d+G0H04gIf8bGWviDY/sRrhimD6shtwKlwwDNrF7XBqTZ
         EGQg==
X-Gm-Message-State: AOJu0YxOfamsAwy+B+wccVxKdeDT63uUBGR/zPhTs7aybTQBc8ehLRI4
	ufmiU/O1at0g8viLfButuId++do=
X-Google-Smtp-Source: AGHT+IE4UIBdCOBSahaHbXIaAM3E3QwhCi94Cvn3aJLHOo+p0gLkdCty9bKUvZY7uZa3X7IxK0NG/CQ=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a81:830d:0:b0:5a8:6162:b69 with SMTP id
 t13-20020a81830d000000b005a861620b69mr287016ywf.3.1699391156928; Tue, 07 Nov
 2023 13:05:56 -0800 (PST)
Date: Tue, 7 Nov 2023 13:05:55 -0800
In-Reply-To: <CAHS8izNTDsHTahkd17zQVQnjzniZAk-dKNs-Mq0E4shdrXOJbg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAHS8izMrnVUfbbS=OcJ6JT9SZRRfZ2MC7UnggthpZT=zf2BGLA@mail.gmail.com>
 <ZUlhu4hlTaqR3CTh@google.com> <CAHS8izMaAhoae5ChnzO4gny1cYYnqV1cB8MC2cAF3eoyt+Sf4A@mail.gmail.com>
 <ZUlvzm24SA3YjirV@google.com> <CAHS8izMQ5Um_ScY0VgAjaEaT-hRh4tFoTgc6Xr9Tj5rEj0fijA@mail.gmail.com>
 <CAKH8qBsbh8qYxNHZ6111RQFFpNWbWZtg0LDXkn15xcsbAq4R6w@mail.gmail.com>
 <CAF=yD-+BuKXoVL8UF+No1s0TsHSzBTz7UrB1Djt_BrM74uLLcg@mail.gmail.com>
 <CAHS8izNxKHhW5uCqmfau6n3c18=hE3RXzA+ng5LEGiKj12nGcg@mail.gmail.com>
 <ZUmNk98LyO_Ntcy7@google.com> <CAHS8izNTDsHTahkd17zQVQnjzniZAk-dKNs-Mq0E4shdrXOJbg@mail.gmail.com>
Message-ID: <ZUqms8QzQpfPQWyy@google.com>
Subject: Re: [RFC PATCH v3 09/12] net: add support for skbs with unreadable frags
From: Stanislav Fomichev <sdf@google.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	"Christian =?utf-8?B?S8O2bmln?=" <christian.koenig@amd.com>, Shakeel Butt <shakeelb@google.com>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 11/07, Mina Almasry wrote:
> On Mon, Nov 6, 2023 at 5:06=E2=80=AFPM Stanislav Fomichev <sdf@google.com=
> wrote:
> [..]
> > > > > And the socket has to know this association; otherwise those toke=
ns
> > > > > are useless since they don't carry anything to identify the dmabu=
f.
> > > > >
> > > > > I think my other issue with MSG_SOCK_DEVMEM being on recvmsg is t=
hat
> > > > > it somehow implies that I have an option of passing or not passin=
g it
> > > > > for an individual system call.
> > >
> > > You do have the option of passing it or not passing it per system
> > > call. The MSG_SOCK_DEVMEM says the application is willing to receive
> > > devmem cmsgs - that's all. The application doesn't get to decide
> > > whether it's actually going to receive a devmem cmsg or not, because
> > > that's dictated by the type of skb that is present in the receive
> > > queue, and not up to the application. I should explain this in the
> > > commit message...
> >
> > What would be the case of passing it or not passing it? Some fallback t=
o
> > the host memory after flow steering update? Yeah, would be useful to
> > document those constrains. I'd lean on starting stricter and relaxing
> > those conditions if we find the use-cases.
> >
>=20
> MSG_SOCK_DEVMEM (or its replacement SOCK_DEVMEM or SO_SOCK_DEVMEM),
> just says that the application is able to receive devmem cmsgs and
> will parse them. The use case for not setting that flag is existing
> applications that are not aware of devmem cmsgs. I don't want those
> applications to think they're receiving data in the linear buffer only
> to find out that the data is in devmem and they ignored the devmem
> cmsg.
>=20
> So, what happens:
>=20
> - MSG_SOCK_DEVMEM provided and next skb in the queue is devmem:
> application receives cmsgs.
> - MSG_SOCK_DEVMEM provided and next skb in the queue is non-devmem:
> application receives in the linear buffer.
> - MSG_SOCK_DEVMEM not provided and net skb is devmem: application
> receives EFAULT.
> - MSG_SOCK_DEVMEM not provided and next skb is non-devmem: application
> receives in the linear buffer.
>=20
> My bad on not including some docs about this. The next version should
> have the commit message beefed up to explain all this, or a docs
> patch.

I don't understand. We require an elaborate setup to receive devmem cmsgs,
why would some random application receive those?

