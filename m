Return-Path: <linux-arch+bounces-5195-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3013891BC57
	for <lists+linux-arch@lfdr.de>; Fri, 28 Jun 2024 12:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53D811C225A2
	for <lists+linux-arch@lfdr.de>; Fri, 28 Jun 2024 10:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9B415746D;
	Fri, 28 Jun 2024 10:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3GYY47T"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E93156C70;
	Fri, 28 Jun 2024 10:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719569438; cv=none; b=s2DrgN/6oTpgStVmVTVYg7J9zi0U+iHqUt97bSwvm0e/Ri0J0WZlCylIWNwFe7/hoF09jdCl0EFm/sGJWjTczX7nq0itmgfJdD+I2Nl1BhOr8suRTL0tHumTUXO/RYItGCDUop1E1D9DljGxdO0wMHM/F0TzRLm4cM7AB7FTlmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719569438; c=relaxed/simple;
	bh=WoG3XUFYpnnYPBYkCiNe37kKCSGW3AfAOh5Ro/F+QME=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=YJU8tlqBOZug9at7dRhBiAlrupXRZkh+PWFQWPJ+oNZc5ZWk4KDYFEEBvhrQNr2YqjGG9+Z7k9uCSv4Ukr/xXtQOCtlOTgvdUzwgp+4MLk1casqLvXak7jQIhXvUCxyuPHHALycOrUbpTJO/3nvP3QCHjxRvnhUM7Ud10drLr7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K3GYY47T; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42564a0d3ceso3271535e9.0;
        Fri, 28 Jun 2024 03:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719569435; x=1720174235; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=djRjxO/ZJBQCrIZgaI6fk/U62O19bgzxywyn0TmHo/A=;
        b=K3GYY47T8BBONpqixXEDRkPDVltUJbuybfgfmgV690AYWrrup3tKYqGQifv2cwzEFE
         LXTHhdiN8lLIxEozAT5w8v8LYi/PlHLVkxUrNFg2QyDTlIAf1Qfm8VZPDbGdIBDZ+yew
         cDtGV7y0GKhn0pZNQOSAdZHxDrLkyFPvFs3fgytHAdby1+QBTFMx6Bj9Sx4mcrn/XeUU
         HlC6fgF5U6DDFTKQEoC4iSQenk608pwKclS961nUK84gsYmMU/oT13Z/zITFgwFFKGO9
         mmvAmseCXjGgkhcU7+baQ3d9LLQoDx9srw1XDhIXZk8Zss21ebYyCH9fjAnZJzu+sx8o
         V7MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719569435; x=1720174235;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=djRjxO/ZJBQCrIZgaI6fk/U62O19bgzxywyn0TmHo/A=;
        b=TpSn1BqE5IexeTOq6OuXUtHdMqUPS+A8XiqLuJoW2zFU3qf39iAJ0ZO+nD5jj0+hY5
         6YD64beVUcPQvSPdApx1KUg5youyb8nbmWGpyJt/cw/JGPb5TQS0ww6FZ40llexwFN9b
         PpWRoD6C4wHB6ucnPchx4SkW4PMPn4Rg0EJ+jjuc7OhSS3EpFnjS6KoApGf1CTZTVAdF
         dE0EcClC0VZvJu/bQHByktU4Q4spFQ50nb+ROWNP40HDqVVWa12kXWN4oIgVE1TaHmhT
         1Z4oYse5uXl7OUZW3GVdD1UyMV7PgQbss9BSWjNTTEE+cUYtJD0JeERkRrUnVAZ2N5Xy
         CW6Q==
X-Forwarded-Encrypted: i=1; AJvYcCW6mp+Qq3gShRha3lOXeB1uwQ8hY9OPWchwqSXBTKrRTMZBoytS+XorvcE7G4IuR0d69mRYt9oPUCmbEEbNvety24bn7kpoBlu1XmduS8Bw3wVTT7S0QdnJSVTMMer4k1O0JA2Vv4RaX1IZjREsqwjUgPsJFcFOP+n3Ywu9R1YByy5NjEC9MgcdIAdToucVyrYY/5S2O6dO+B0T+T2Ogc42D6ThjtBYZjLG/zScoRRy0al+NkFqmyk6V5OvAz8XL3AIZb6jaSs8/6bVb2ghoEtNdPwny0LhTchoHFHrYExPnjp5oG6/5LRaDIc4MoGy3gY9Jr4xZQggicipPcK513xufK9eA/XYLye3QTzOynkSfOqHojCOPAp8qQ5mpjldKiQcNPI4jYrVIVE8ah/eMopFRqm4IRiJcjSokD6qzo9/DDZih/bWiCsG3wM9uasK7kYxvdEqPEl02vzMI1ITKEhC2ofFoyKiIBYOEStcFw==
X-Gm-Message-State: AOJu0YxyvBZz+dDWvjJi+IDafaU+ntkoxZ/Mkzhdtdlt5FQqFjFlv+1G
	xxy5zRbsbcGu4MdBqXZKxI9QMhV17L80B48SQ0zXK5ozO/SSvYqf
X-Google-Smtp-Source: AGHT+IGTbLKuH6+lACoVW6gBGISTlFA2luNgNp0at8l17FynGxoGb7mI7uIhlXYSjVIEoYumxGZPkg==
X-Received: by 2002:a7b:cc16:0:b0:424:8e3a:d020 with SMTP id 5b1f17b1804b1-42498ced472mr80452775e9.29.1719569435211;
        Fri, 28 Jun 2024 03:10:35 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:49ff:2a2d:712c:9944])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b0c15f8sm26999325e9.47.2024.06.28.03.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 03:10:34 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-doc@vger.kernel.org,  linux-alpha@vger.kernel.org,
  linux-mips@vger.kernel.org,  linux-parisc@vger.kernel.org,
  sparclinux@vger.kernel.org,  linux-trace-kernel@vger.kernel.org,
  linux-arch@vger.kernel.org,  bpf@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  linux-media@vger.kernel.org,
  dri-devel@lists.freedesktop.org,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Jonathan
 Corbet <corbet@lwn.net>,  Richard Henderson
 <richard.henderson@linaro.org>,  Ivan Kokshaysky
 <ink@jurassic.park.msu.ru>,  Matt Turner <mattst88@gmail.com>,  Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>,  "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>,  Helge Deller <deller@gmx.de>,
  Andreas Larsson <andreas@gaisler.com>,  Jesper Dangaard Brouer
 <hawk@kernel.org>,  Ilias Apalodimas <ilias.apalodimas@linaro.org>,
  Steven Rostedt <rostedt@goodmis.org>,  Masami Hiramatsu
 <mhiramat@kernel.org>,  Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>,  Arnd Bergmann <arnd@arndb.de>,  Alexei
 Starovoitov <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
  Andrii Nakryiko <andrii@kernel.org>,  Martin KaFai Lau
 <martin.lau@linux.dev>,  Eduard Zingerman <eddyz87@gmail.com>,  Song Liu
 <song@kernel.org>,  Yonghong Song <yonghong.song@linux.dev>,  John
 Fastabend <john.fastabend@gmail.com>,  KP Singh <kpsingh@kernel.org>,
  Stanislav Fomichev <sdf@fomichev.me>,  Hao Luo <haoluo@google.com>,  Jiri
 Olsa <jolsa@kernel.org>,  Steffen Klassert <steffen.klassert@secunet.com>,
  Herbert Xu <herbert@gondor.apana.org.au>,  David Ahern
 <dsahern@kernel.org>,  Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
  Shuah Khan <shuah@kernel.org>,  Sumit Semwal <sumit.semwal@linaro.org>,
  =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,  Bagas
 Sanjaya
 <bagasdotme@gmail.com>,  Christoph Hellwig <hch@infradead.org>,  Nikolay
 Aleksandrov <razor@blackwall.org>,  Pavel Begunkov
 <asml.silence@gmail.com>,  David Wei <dw@davidwei.uk>,  Jason Gunthorpe
 <jgg@ziepe.ca>,  Yunsheng Lin <linyunsheng@huawei.com>,  Shailend Chand
 <shailend@google.com>,  Harshitha Ramamurthy <hramamurthy@google.com>,
  Shakeel Butt <shakeel.butt@linux.dev>,  Jeroen de Borst
 <jeroendb@google.com>,  Praveen Kaligineedi <pkaligineedi@google.com>
Subject: Re: [PATCH net-next v15 12/14] net: add devmem TCP documentation
In-Reply-To: <20240628003253.1694510-13-almasrymina@google.com> (Mina
	Almasry's message of "Fri, 28 Jun 2024 00:32:49 +0000")
Date: Fri, 28 Jun 2024 11:09:28 +0100
Message-ID: <m234oxcraf.fsf@gmail.com>
References: <20240628003253.1694510-1-almasrymina@google.com>
	<20240628003253.1694510-13-almasrymina@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mina Almasry <almasrymina@google.com> writes:
> +
> +The user must bind a dmabuf to any number of RX queues on a given NIC using
> +the netlink API::
> +
> +	/* Bind dmabuf to NIC RX queue 15 */
> +	struct netdev_queue *queues;
> +	queues = malloc(sizeof(*queues) * 1);
> +
> +	queues[0]._present.type = 1;
> +	queues[0]._present.idx = 1;
> +	queues[0].type = NETDEV_RX_QUEUE_TYPE_RX;
> +	queues[0].idx = 15;
> +
> +	*ys = ynl_sock_create(&ynl_netdev_family, &yerr);
> +
> +	req = netdev_bind_rx_req_alloc();
> +	netdev_bind_rx_req_set_ifindex(req, 1 /* ifindex */);
> +	netdev_bind_rx_req_set_dmabuf_fd(req, dmabuf_fd);
> +	__netdev_bind_rx_req_set_queues(req, queues, n_queue_index);
> +
> +	rsp = netdev_bind_rx(*ys, req);
> +
> +	dmabuf_id = rsp->dmabuf_id;
> +
> +
> +The netlink API returns a dmabuf_id: a unique ID that refers to this dmabuf
> +that has been bound.

The docs don't mention the unbinding behaviour. Can you add the text
from the commit message for patch 3 ?

