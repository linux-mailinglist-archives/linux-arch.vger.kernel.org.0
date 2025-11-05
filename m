Return-Path: <linux-arch+bounces-14534-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3934C377CE
	for <lists+linux-arch@lfdr.de>; Wed, 05 Nov 2025 20:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52E313ADD50
	for <lists+linux-arch@lfdr.de>; Wed,  5 Nov 2025 19:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD453191AC;
	Wed,  5 Nov 2025 19:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVHMKpND"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE703346A6
	for <linux-arch@vger.kernel.org>; Wed,  5 Nov 2025 19:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762371104; cv=none; b=t1t/rl6MzkiY0ygnFy38KLcUHpWrofP5k4fJHbIesJIT0yOYlvI+NOzTyj3J4yN5+DpKcuaoR3D2zukrUav5tOX80ZfN9JlJQojmExbNhoxR199aLVR9MgM0XO9fsbPi/yuTkbGL+EC9KDJ/Ak36pslTAvbn5WBVPxNIXH/jx7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762371104; c=relaxed/simple;
	bh=BvZxN+1EqpzRPr7jqFQiw5OdyZE1dX/t2SHsJ7q9zL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T3V181IK1QEItaB0Nc4RIVo9PNCZ8RgNWwZkaEohMFNKmmKcBgADXviqviiEEXnx5JNFNlK3riAPqvNjlq2VwvjBJhFEixSId/XA79jEEjPZdalXHEi2N787TgolMm8cT8DekDzXczQsC06d6375UZg+DUvkvjvsyhaFxOubF88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PVHMKpND; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3402942e79cso305687a91.2
        for <linux-arch@vger.kernel.org>; Wed, 05 Nov 2025 11:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762371102; x=1762975902; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QJvqN/FYXoVwh6qr7l1fAEtmzEXDgIxcL6pBMQi85sc=;
        b=PVHMKpNDXBXBBKh+uN0m3KjZqSa9Uv5n0wx352eXSIOmPP8jzV0iWy4J3fPnJlZoom
         YqazFJ7CfUUqMeWvWPmdEDiUmpmKQ5LL9DiyT/7KP65noPSjIyZy4LTk3qXRr+DP37L5
         68yLirvzehtLIukIWnRKD1FkNqQscweVK86fPUZbDnHawfAuNCuITCGNXmqv7MudiKqd
         VNGlI4ls52+5tuWGSxvW1kXyniycW69hel6krbJa4P/oHuKSQsBkfgEGsppDGs6YQP1g
         JIiXbU5Xh49VE9RpSCeBeZ9Q5xjS7FalXewNIsuQ8JKGSPwh5wm6vioWGiJz6td0WucD
         lUGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762371102; x=1762975902;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QJvqN/FYXoVwh6qr7l1fAEtmzEXDgIxcL6pBMQi85sc=;
        b=o0e5nAGdq9t9WAQ4tuy/vQ9qor409RNMuxUzRJ+Rp+7TdjaV3IiROVep113qy6ts/3
         srSSoKqIIjr5zg7SvknmEexWtnf17BEKedcc+UVEAeOeQ5j8e0qf2VptMdjw0AYTBvZL
         xbBmEyZvBiw6ETJToDEK+F8USwf1KZ1rL6+Ey9XoGqztFu+I+B0NmHJHP8HrtVLbOdfb
         On/a3Zzx8iDUnUTp9xTeXcHyAbEZryr/Ra5nnEm1REL/OXFuVQfoY5GGEFlH093MM4S2
         q03cDnx79RO4Z2VUnx7Mj1GpOjyy51GiuSpfOVLemChoCxcW0k5ocSolFcBdvVvv1mu0
         c/iQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhzKB6hLmIaVT+U1IFLiqHEkv97yjDhEZlLafl+9SPPmyDAvDBXxQko+fpO5/nFRg9ZlanGJpR5LtM@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/m39Ty/aM81Z+a6Dijhsr67GT+qySPn+98IUJiE8Mbf3ipHnl
	uNgL8YWr/QdSx1oL33VH5f1f+Y5a6pNCJv4M8NgxAOu4vyHadFbnYqY=
X-Gm-Gg: ASbGncv8DVXAOfJ6djKuxqEIX32hMTBXIK4ivoTtwV3SQOhA11a7WqbUwLLKFocxfCa
	MUeFV8ZPyYMHN+d+SOOs92ObR0/C8bzdpIIsTbTNL3zc0ddzvdMIafBY54megPghlleITU16biz
	lwWbttGTnGlZ5+M9/VQsuG5WLdoCZHoGQnB4fdOxwg49WK672WtVENOPxsICrzZ/R6SpmTfq73f
	qEbVYNjC7fG7djB0G8YXg9Tlec9t85xNtYZvnS8bh/iOdVIDFWP15Ie1nkoP5EJDu0RI1WPU/cz
	cAfcVjqLG4L5QmytLkD9mj6kOPPi5yrEbVtMJMF13iz/Syobt8VbnxLpLU2mP25pX8SOkZUMHNF
	/t7iuVPDKZfCmHKGwTlzz2Imr5zzXgVX4QMmyoqGkdKvYSZ/i3tDgyvHy7AYfWKhUH2kZf+nxUU
	kXCB38aAwVIFY+q6PLbz97Y4WgeqKMFjglkwntTNgCgHJipYO7lx0XHnfraa5JrGnG4woVa6FuV
	/WUb4bHhWCw/gTckxJQ3z8FTVkTEycbo6uIAGoFKo2o4quLfpvp5VPD
X-Google-Smtp-Source: AGHT+IHEYHxkSKq31loBRy7lG4iYoi42JRRNozm8w4t4415/PWn971C55dwcIWM3pohgDfObZu6u1w==
X-Received: by 2002:a17:90a:c107:b0:340:cb18:922 with SMTP id 98e67ed59e1d1-341a6c428damr5429218a91.14.1762371101999;
        Wed, 05 Nov 2025 11:31:41 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba900eab130sm102335a12.25.2025.11.05.11.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 11:31:41 -0800 (PST)
Date: Wed, 5 Nov 2025 11:31:40 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	David Ahern <dsahern@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Stanislav Fomichev <sdf@fomichev.me>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v6 5/6] net: devmem: document
 SO_DEVMEM_AUTORELEASE socket option
Message-ID: <aQumHEL6GgxsPQEM@mini-arch>
References: <20251104-scratch-bobbyeshleman-devmem-tcp-token-upstream-v6-0-ea98cf4d40b3@meta.com>
 <20251104-scratch-bobbyeshleman-devmem-tcp-token-upstream-v6-5-ea98cf4d40b3@meta.com>
 <aQuKi535hyWMLBX4@mini-arch>
 <CAHS8izNv89OicB7Nv5s-JbZ8nnMEE5R0-B54UiVQPXOQBx9PbQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izNv89OicB7Nv5s-JbZ8nnMEE5R0-B54UiVQPXOQBx9PbQ@mail.gmail.com>

On 11/05, Mina Almasry wrote:
> On Wed, Nov 5, 2025 at 9:34 AM Stanislav Fomichev <stfomichev@gmail.com> wrote:
> >
> > On 11/04, Bobby Eshleman wrote:
> > > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > >
> >
> > [..]
> >
> > > +Autorelease Control
> > > +~~~~~~~~~~~~~~~~~~~
> >
> > Have you considered an option to have this flag on the dmabuf binding
> > itself? This will let us keep everything in ynl and not add a new socket
> > option. I think also semantically, this is a property of the binding
> > and not the socket? (not sure what's gonna happen if we have
> > autorelease=on and autorelease=off sockets receiving to the same
> > dmabuf)
> 
> I think this thread (and maybe other comments on that patch) is the
> context that missed your inbox:
> 
> https://lore.kernel.org/netdev/aQIoxVO3oICd8U8Q@devvm11784.nha0.facebook.com/
> 
> Let us know if you disagree.

Thanks, I did miss that whole v5 because I was OOO, let me take a look!

