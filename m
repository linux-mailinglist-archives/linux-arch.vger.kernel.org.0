Return-Path: <linux-arch+bounces-5215-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F058C923A2F
	for <lists+linux-arch@lfdr.de>; Tue,  2 Jul 2024 11:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 259FE1C21291
	for <lists+linux-arch@lfdr.de>; Tue,  2 Jul 2024 09:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4D715250C;
	Tue,  2 Jul 2024 09:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZBQTEMyM"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205AE1534E1;
	Tue,  2 Jul 2024 09:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719912846; cv=none; b=aK+U8WYOuJ7GtRYCq5S4o+VurZ6BZGjzkExImn6D5EO++L/O4sgwUTwC4Qb/aNWTyd3NfajRaVX1p1bs0nkqZJrzFRWaSaXHjCUEDJ+fC+vf/I9bQz0TZcpYQUTUw7N0cABvlNzek2vmYHwXbxPlf5BrI72L6mW0PzOSrT1Xwsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719912846; c=relaxed/simple;
	bh=OHn1ckY1ViIAHvmeaBhl4RVsY7dCnn6nSLzEnFbY7H4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZW/ZWAE8PWBDV7xBcy8wXiZnJUzv/DbGcknm/KLOtczYwYvt2GXZkbuToscH4e1X/la4o8fBdjbVywjk57Rr7CqRIe/KFvWreN07S7xPpPalQhFkTUU2Zo2rr+FI+7EKk0lvxHcqPLucJIHwHgL6RZ0r2DNcnaXDbAXVPy23WV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZBQTEMyM; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7021f23d699so534806a34.3;
        Tue, 02 Jul 2024 02:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719912844; x=1720517644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cWXvodTV40xpsQgD046diOP7NF2BEo3aGKT0Hy04vKs=;
        b=ZBQTEMyMDKJbU7hV744Uytoc4LJt9baatO8fqoptKJc9Z6ro2IBfYXw7pgCyEjNVka
         mQMYMgImdC78+P7u+yYC3VST6hxf3lUHmjA5Ro9iZ6MXzFz7rZmfjNoSQL2OcptYJ2Ra
         m345jFhs+hq4sYbJlbDD13fdtYotW0j4Ikiwyshse+segDtvTmSJDVfP49YT4eX1ka8a
         uRB/VehcZ7UFbpaWhvzQTmvKlLjMfiksmK+4AGW3AmATmJY962ZoEC01yl5U4F+rJpWb
         WI1Lnm975IkRObQjQCT9XdKkysfd6wgwhYoZF2gY22Kf1imTKSuNbW1BtjrOfBJRJ1dm
         zS+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719912844; x=1720517644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cWXvodTV40xpsQgD046diOP7NF2BEo3aGKT0Hy04vKs=;
        b=FMwbeWHAQLjLb1vH4tMak+t6Cb/IfZTUh4W+YH/h3baoGw7wiBN3U/NNief9mfwFab
         bcEvJo8NdLa7aMrHSd8GS26JeV3aqK2clyMjfNUwFqfPLz0GlOCJs9eiq6imrAOM/2UL
         pjw6W7naqQmwQ09zKOwcXW48VCUxuIPapghNZxc8QtuNMjWsLJcGPH4NkqN36q/UUNpO
         wohXuF+kj6GVs6oZH1/O9BNZoIRfWX6JCqYDDyvSrZ+cU7Pn8sFjgNAwHfWpko0OMA1s
         kmB/wkjzxDMvsPoLAZxBVx5C3Cb3f1gKVx+qnP05qyeLnBABUd8o8b15Mk3DM0DfkvsK
         5hxg==
X-Forwarded-Encrypted: i=1; AJvYcCXYuE2OThn+wRxZcttJaMU2LGuhuLsNf7hgO96g7843Q7e/QJqBVzdF3UnVtb0pInbhr1gCmJNYVAfQPJXw+mAXES49dfH5pGPO6VG+k38zEf+Kz8+LRpMtc//pQPgjpwDwmJW9fY4Ub4juKQTgT4vifcjcIpOWJFfX7Vvb/zSFhQ2cQrajr2ElHWRluwQ4uW2118Jt8Z5Qu1cNk0SyCs4WiHMIpH1PTPiQFaf/1VvpZ9pLMq/u9awn72PIqZthT5/wc/jplKmY/9oQqpEFVNrKmFz1UWVw3KPxzREmRQjraLNZYJpkF8NOjXFXrTYUhvr9piGwCWy8DK0dGVYCsf9SjgR4ZA0FoN7apwC+HJl4YmRM2QlMv3npTpowXJJ1fkLq+t8LTqqfCRskCOUF56mPwVD6TqVFYtWZKtgTRipJn84yYmv0XjYJTqq3b1HZYXl01y8+DhDXDPFLsEcuSAZJxs1im0xAuTQlVla1RA==
X-Gm-Message-State: AOJu0YxGHUwcH6dyWfY+L6ZATyv8il+kySKOUoA1Fesao4R5WCL8JVBl
	l+qs9paJIkBuDdraXFZIses39FBPR/+cn7wixwFlAd0dw45okRCKzNoMYAA5w3SmxTJrp1ayET+
	IcFGpvnWL4Lb1bG3iF0gNu7lGCQQ=
X-Google-Smtp-Source: AGHT+IEDzJCkSxic9thzD1A+qXwSy94/OFeuEZqEmxDLENKBg+0OkSwbEdt7g8VxaiGVVFbl4hnPJFDds9/ibJSVDwQ=
X-Received: by 2002:a05:6870:56ab:b0:254:aae8:d822 with SMTP id
 586e51a60fabf-25db3432ec4mr7759858fac.26.1719912844128; Tue, 02 Jul 2024
 02:34:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628003253.1694510-1-almasrymina@google.com>
 <20240628003253.1694510-3-almasrymina@google.com> <m27ce9cris.fsf@gmail.com> <CAHS8izNM8TjJ1DU+7gzq-0kH=tVeM6j-QsaKk=2FHNDF6RLwnA@mail.gmail.com>
In-Reply-To: <CAHS8izNM8TjJ1DU+7gzq-0kH=tVeM6j-QsaKk=2FHNDF6RLwnA@mail.gmail.com>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Tue, 2 Jul 2024 10:33:52 +0100
Message-ID: <CAD4GDZznS=0xG+ms6bLKSwQFNTqxSqi8fdoNM97ymwcnqX3yhg@mail.gmail.com>
Subject: Re: [PATCH net-next v15 02/14] net: netdev netlink api to bind
 dma-buf to a net device
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Richard Henderson <richard.henderson@linaro.org>, 
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Shailend Chand <shailend@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 1 Jul 2024 at 20:05, Mina Almasry <almasrymina@google.com> wrote:
>
> On Fri, Jun 28, 2024 at 3:10=E2=80=AFAM Donald Hunter <donald.hunter@gmai=
l.com> wrote:
> >
> > Mina Almasry <almasrymina@google.com> writes:
> > > +  -
> > > +    name: bind-dmabuf
> > > +    attributes:
> > > +      -
> > > +        name: ifindex
> > > +        doc: netdev ifindex to bind the dma-buf to.
> >
> > Minor nit:
> >
> > The series uses a mix of dmabuf and dma-buf but the doc additions
> > (devmem.rst) consistently uses dmabuf. I think it would be helpful to b=
e
> > consistent here and say 'devmem dmabuf' in the docstring to highlight
> > whos dmabuf it is and keep the generated netdev docs in alignment.
>
> To be honest, even the dmabuf docs mixes 'dma-buf' and 'dmabuf', to my ey=
e:
>
> https://docs.kernel.org/driver-api/dma-buf.html
>
> I can edit these docs I'm adding so these are consistent.
>
> But on 'devmem dmabuf', not sure to be honest. Technically all dmabufs
> are supported, even non-devmem ones. I'm not sure non-devmem dmabufs
> are common at all, the only example I can think of is udmabuf whose
> primary user is qemu and testing, so it's somewhat implied that the
> dmabuf is devmem, and even if it isn't, it would be supported. I
> prefer to keep the docs saying just 'dmabuf' as technically all are
> supported. Maybe I should add a note about this somewhere in the
> dedicated docs.

That's a fair point. If you could mention it in the docs, that would be gre=
at.

Thanks,
Donald.

