Return-Path: <linux-arch+bounces-6036-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C930948F39
	for <lists+linux-arch@lfdr.de>; Tue,  6 Aug 2024 14:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FFAD1C2366A
	for <lists+linux-arch@lfdr.de>; Tue,  6 Aug 2024 12:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968031C68BE;
	Tue,  6 Aug 2024 12:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKlxrqan"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EFC1C57BD;
	Tue,  6 Aug 2024 12:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722947978; cv=none; b=B7IWww1Fg6972u4BDApPUB8xMKPbdGTTLWK8zv/Rcz78+M8yuv4Ntqf4OSP4zzQD6co6C/q4OW0ygKWL4t2PzzLpTOpoagQ5sQUbSt3TkfMYQlIE0luURcExN6BblQPmSn+oWPIIDBAWg/OA8FKse0wrkXTVoZ/ZxJ4wlkZpLGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722947978; c=relaxed/simple;
	bh=pRGjwMQFuXx8nS2LCderaOx79LtJsbSQjU6aMaxd08o=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=TKK2KnVVy1rJbTHObhoK3/wKw5taAyFPyFvVG0RZpbtLNHUJ15pfoX+fEnYFWkkgCrkj90LaHHeTPz54ahzTFBBpb37lZQ0b8fuEUtGvgLQ5Nr/krMquGBR8NuPLanCWQsQY0Hmwqb/6qIDGrktMHds0OUcA0ut4GWUxNQP1NTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VKlxrqan; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-4f50dd3eab9so240273e0c.1;
        Tue, 06 Aug 2024 05:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722947976; x=1723552776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zrdmTtiXVmTM/1NHHOYdmmDXOI3jR7XQcOI+pwOJhWY=;
        b=VKlxrqanIheS9Sd5XzmNfv9ScS8GGE/obB6rli6JcQfzv8OQyH1ms5LfzyftBPJlAw
         sfZMoNB7fMIUVJbfSp28rtM1yLUdMdnW27USd+yevM4WhMxcn2tC0kCwT21BzrtIUUHR
         Gs3J1wl0qryBTZV4pStD26pH1HB09vV81qeXzTdRPH8cT7SCJpF5PsIvdPYcQcoZb/bU
         lS+DuGbMun0iJwWow8q9nb7YSa1fpQ79XatO8EdXq8FWVvnWo4atP4i/rHxrlW27fHfJ
         SUpp7IX8Dh3JdPkm8lpi4n5ypupMKNxoU+XW+rEQCrGBXD5UQfBs/vy59JIZ6bD1Fmo1
         zdgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722947976; x=1723552776;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zrdmTtiXVmTM/1NHHOYdmmDXOI3jR7XQcOI+pwOJhWY=;
        b=YwoX+XXfHLFESv4nU6ef39maHkPDlzto+lpgxBYhmTJEGyg2MbrBTQuBRLzRIMetp7
         MQo8C31NtC9IZUGo9PHUc9W5l2dFksMlgvi0QohkNNrkdg4xQrtwhhuVJp8AE+/6ZwsQ
         18SRSbZ2kcflIWn99kpghh+EsNMIKy603tqnS5oZtciShQj7G1+LyGSVb1bWbmQlC4s6
         zOFuUMxal+8Y4F6zIsS88V3ZjSIHwj26kh2J0B93/ye4/Pfxq7mRdnBEDbepUUVUF+Un
         E/8H1bwvmgq3UU6gjegXYWuZJmcJeH8x9s01MRCBTsNyyPGs315OJchwwKbtfo1ePb8w
         FjPg==
X-Forwarded-Encrypted: i=1; AJvYcCUCTL3GifOoTkGotVQKHsht3DH11hDZibW61aSUOHYmvH8IO2m8nbbHB4vV63n+wNxBJfCcxiS88C2+z1upzJbLrWmIu6BvineuFcHLv+zQRkbWwJ5woYB0Rp6z1J9OsObiq0BDbZy8aUaI/o8DoCpcfiIn5M4NjWpUVOucS89c+cCJYuFy3hblNRb+aS9l7uNxbvPYmIqIO/SKZa//lBNIJmEfQGAWGB6KOX6w4lu0PECsvwrDEIHRoSypUvkwoM6wr8nbiwptxAlGu0Q2nfri3ivhFPaQ0a58BZ3JjhgHBkMZ+ZxRbGFJjExm9gtw7Q6DN/0jI/infzNnGKupNyYRy9ob9tkjzf4Giii2kSAGYdSkDzMcMup97D6whg1Arys+dL0HfUhjVC2cdmgR+NzVZX2Dcq6rmsYNH42+t182nBhSh2GY21ecMPVrx3+rk6rROHyUGoWoVjbrnX1mVY8JOfgyEYZALUMv2CcFUQDww0dClYG9XRp3hPYyliKGX6G+v7PhjQ==
X-Gm-Message-State: AOJu0YwpsNYteLdDFoX1IKaNFFCuUC+P89kqXZcyX2ui47QVOzUubQGf
	/7ZVPgtJdbk9sA4CS5+NFrTN9dPmJbKUl6w6X+olQ2zL47KdPisM
X-Google-Smtp-Source: AGHT+IEzF8kEieTvm400vGSAD/FxkfKWUdB+Qp9zmFjvlH9NnaUdLi1L0Oe0+UqgMX4/h+bhgaOPVA==
X-Received: by 2002:a05:6122:4584:b0:4eb:5cb9:f219 with SMTP id 71dfb90a1353d-4f89fe84d6fmr18355377e0c.0.1722947975581;
        Tue, 06 Aug 2024 05:39:35 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a34f6dce75sm450350985a.14.2024.08.06.05.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 05:39:34 -0700 (PDT)
Date: Tue, 06 Aug 2024 08:39:34 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>, 
 Mina Almasry <almasrymina@google.com>, 
 netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, 
 Kaiyuan Zhang <kaiyuanz@google.com>, 
 Pavel Begunkov <asml.silence@gmail.com>, 
 Willem de Bruijn <willemb@google.com>, 
 linux-alpha@vger.kernel.org, 
 linux-mips@vger.kernel.org, 
 linux-parisc@vger.kernel.org, 
 sparclinux@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 bpf@vger.kernel.org, 
 linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, 
 LKML <linux-kernel@vger.kernel.org>, 
 Andreas Larsson <andreas@gaisler.com>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Bagas Sanjaya <bagasdotme@gmail.com>, 
 =?UTF-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>, 
 Christoph Hellwig <hch@infradead.org>, 
 David Ahern <dsahern@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 David Wei <dw@davidwei.uk>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Eric Dumazet <edumazet@google.com>, 
 Harshitha Ramamurthy <hramamurthy@google.com>, 
 Helge Deller <deller@gmx.de>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
 Jakub Kicinski <kuba@kernel.org>, 
 "James E. J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, 
 Jeroen de Borst <jeroendb@google.com>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Matt Turner <mattst88@gmail.com>, 
 Nikolay Aleksandrov <razor@blackwall.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Praveen Kaligineedi <pkaligineedi@google.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Shailend Chand <shailend@google.com>, 
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Shuah Khan <shuah@kernel.org>, 
 Steffen Klassert <steffen.klassert@secunet.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Taehee Yoo <ap420073@gmail.com>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <66b2198686b91_3206cf29453@willemb.c.googlers.com.notmuch>
In-Reply-To: <9aad36fe-cd4c-4ce5-b4d8-6c8619d10c46@web.de>
References: <20240730022623.98909-4-almasrymina@google.com>
 <5d3c74da-7d44-4b88-8961-60f21f84f0ac@web.de>
 <CAHS8izPxfCv1VMFBK1FahGTjVmUSSfrabgY5y6V+XtaszoHQ4w@mail.gmail.com>
 <9aad36fe-cd4c-4ce5-b4d8-6c8619d10c46@web.de>
Subject: Re: [PATCH net-next v17 03/14] netdev: support binding dma-buf to
 netdevice
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Markus Elfring wrote:
> >> =E2=80=A6
> >>> +++ b/include/net/devmem.h
> >>> @@ -0,0 +1,115 @@
> >> =E2=80=A6
> >>> +#ifndef _NET_DEVMEM_H
> >>> +#define _NET_DEVMEM_H
> >> =E2=80=A6
> >>
> >> I suggest to omit leading underscores from such identifiers.
> >> https://wiki.sei.cmu.edu/confluence/display/c/DCL37-C.+Do+not+declar=
e+or+define+a+reserved+identifier
> >>
> >
> > I was gonna apply this change, but I ack'd existing files and I find
> > that all of them include leading underscores, including some very
> > recently added files like net/core/page_pool_priv.h.
> >
> > I would prefer to stick to existing conventions if that's OK, unless
> > there is widespread agreement to the contrary.
> =

> Under which circumstances would you become interested to reduce develop=
ment risks
> also according to undefined behaviour?
> https://wiki.sei.cmu.edu/confluence/display/c/CC.+Undefined+Behavior#CC=
.UndefinedBehavior-ub_106

This series is following established practice in kernel networking.

If that conflicts with a C standard, then perhaps that needs to be
resolved project wide.

Forcing an individual feature to diverge just brings inconsistency.
That said, this appears to be inconsistent already.

Main question is whether this is worth respinning a series already at
v17 with no more fundamental feedback.

For reference:

$ grep -nrI '^#ifndef\ _\+NET[_A-Z]\+H' include/  | wc -l
149

$ grep -nrI '^#ifndef\ NET[_A-Z]\+H' include/  | wc -l
4

$ grep -nrI '^#ifndef\ [_]\+[A-Z][_A-Z]\+H' include/  | wc -l
3805

$ grep -nrI '^#ifndef\ [A-Z][_A-Z]\+H' include/  | wc -l
583

