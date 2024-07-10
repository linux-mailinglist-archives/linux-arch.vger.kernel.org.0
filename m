Return-Path: <linux-arch+bounces-5345-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8806F92CF97
	for <lists+linux-arch@lfdr.de>; Wed, 10 Jul 2024 12:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41DB72886A6
	for <lists+linux-arch@lfdr.de>; Wed, 10 Jul 2024 10:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB90196D9E;
	Wed, 10 Jul 2024 10:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZAFLShHr"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11E5192481;
	Wed, 10 Jul 2024 10:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720607839; cv=none; b=aNayA8N5++uzQ3TVWFUhliDL4UVbaoNcrnA3Esr9aB8PMJkoN5M9L6PVU7JZSeiOzWYpt9XyNAf7jqmhXOl4cjr/jt37q3JZaQeV0ZLHaWNz9zH4QwpdRUeltRCKPN5hI10P6u9fetZbQP2+aP7AZDvSiM7Jg6DhhiqoAbUc9AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720607839; c=relaxed/simple;
	bh=jUv1TKKjUHthOG7mdtMKuqVjyWEdEs5skCdldKg/BLA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=kMZukcaJddbIiqTOmIFZ6suSUMjOkyAlvhgHEVSGB1jbJlFlRyo/EsNOhym7/Tht2xZUr6f5Hc+nZ+AFrYEzGM+gXsbD/r3zNpGcE6afSl/Jn39lEuUCOmGJOFvt6/WG/HLMSghsR/TQyKdAnqwUaBg73/DVqTfPuMRWQ7mOyX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZAFLShHr; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52ea33671ffso5696090e87.3;
        Wed, 10 Jul 2024 03:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720607836; x=1721212636; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jUv1TKKjUHthOG7mdtMKuqVjyWEdEs5skCdldKg/BLA=;
        b=ZAFLShHrIPyDf9U9i1IcFoO9MUKQpzxDncyp7DVrvbXnDtj7tPW5MbBA/JfsGM31Mz
         pSyVrkf+x3awC5bEkSWdhzl2/FwmVsvbtITxmLakw+VL0Hrxi/FFYhLKUR1UGDFf+ccJ
         QwcWpXdvZbMAx3BNTzrWivW6vT5kwkOaNE7azBt/rf/DM78ZlxMrgcXOotKANa7cvt7M
         fd61Smmo9Wrae22TbF0+qU1yvMmUKuN1hrBr2v+xXUO7+slgFrSHGx9/JI5bptSpfvoY
         78SlWU+GwRJjqvLa+EOFFkbZeI/0naZVYq6CBzt02lNhdCdoOy+6xgJtrIYLVmt3AFPJ
         8RwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720607836; x=1721212636;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jUv1TKKjUHthOG7mdtMKuqVjyWEdEs5skCdldKg/BLA=;
        b=B1dA1BCsGKQt8tAIExuk+Xd13+y22ITgRcfME70CjDkBU3mkFikVurAkc5gpto+9+F
         AlaQ6BmXiv5DtLDiFFJDvtkz41SJnMOs+tewHL2kG+JO+W6gS0RoMpGDQjB9c6w5b42Y
         7aYJMOtHL9NphNlrNbTkeMqlqk2CjxuAqaxLI61HtvoSFawPDQqAGrMrqquPCb1RpQE2
         DzrUu7Nchr9J9I88BaAnMX0PBhZpcUPAme9ko8CYppfFHDw/oXpADTuAXj47MJixJPu9
         fOFpjv6/VF5nJWGquLhKR6mvsJEbcZ87V+cJq/Ew2mUoU2JQO5QAUiTcdTRoilloYHsz
         4CSg==
X-Forwarded-Encrypted: i=1; AJvYcCXPWIs8UcPggDr++kvOteVGb3nOU9S9xE0gmjIwwiwSVMKnpGac+D0zORHrW2kiw8wtCvG5+MgnGRiCSUWoi529PBvBL30rAFZwCF0IToDhZk6AcDiwporh81MSOqFnyhsP4SqOZJ9UkdpH9VrEoHSDzIbe9Ab8M5piVTO9yMZkq/o967he919fj/PhlXacGSWGF7DQWvIE/OtM5KbYngR4VvD0ekdy/keYMP3xSJRweeXUihoNouSpqX11OntlWYpY9YEw2U/LMNcI38hv4xl5AJgibxfBKyE/1DIk2Kt/RmOmPwXaxqPK6X589vfvQTu+psilLV50lVzhBUjBSOjpjAPIsEBufWev8lFmtqUD7I7eVQuuEKUC2c4mubEpYIFWinfYDD9NxkLoClH+/nBMFHG9F0OEr9e8FZs9beZpTC6jqYlW9CyMskh38d85dLAm16EhH99GZbOUvaffmxoKiPUWZAzsW6qIBOa2wQ==
X-Gm-Message-State: AOJu0YzlO+PVpqSihBnDiVJsw9GeVK85phwyRsC/NsmI7iS0rTeYbTSB
	dU32UsLWj1lokMtsFNF6QvzO6ggAEiKz0GjA/djCtzaqtQRKsA1Y
X-Google-Smtp-Source: AGHT+IEYBZWIZpjV7C9ssz+2I4yf8GPHbR8l+2RYZAsApi0hWbugWj4h9Cu7wWaqd85eKzfkNy/N7w==
X-Received: by 2002:a05:6512:3e19:b0:52c:e17c:3753 with SMTP id 2adb3069b0e04-52eb9991919mr3752798e87.5.1720607835793;
        Wed, 10 Jul 2024 03:37:15 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:d1a7:2644:c75e:c5ee])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266ac156easm114146345e9.38.2024.07.10.03.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 03:37:15 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-doc@vger.kernel.org,  linux-alpha@vger.kernel.org,
  linux-mips@vger.kernel.org,  linux-parisc@vger.kernel.org,
  sparclinux@vger.kernel.org,  linux-trace-kernel@vger.kernel.org,
  linux-arch@vger.kernel.org,  linux-kselftest@vger.kernel.org,
  bpf@vger.kernel.org,  linux-media@vger.kernel.org,
  dri-devel@lists.freedesktop.org,  Jakub Kicinski <kuba@kernel.org>,
  "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Jonathan Corbet
 <corbet@lwn.net>,  Richard Henderson <richard.henderson@linaro.org>,  Ivan
 Kokshaysky <ink@jurassic.park.msu.ru>,  Matt Turner <mattst88@gmail.com>,
  Thomas Bogendoerfer <tsbogend@alpha.franken.de>,  "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>,  Helge Deller <deller@gmx.de>,
  Andreas Larsson <andreas@gaisler.com>,  Jesper Dangaard Brouer
 <hawk@kernel.org>,  Ilias Apalodimas <ilias.apalodimas@linaro.org>,
  Steven Rostedt <rostedt@goodmis.org>,  Masami Hiramatsu
 <mhiramat@kernel.org>,  Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>,  Arnd Bergmann <arnd@arndb.de>,  Steffen
 Klassert <steffen.klassert@secunet.com>,  Herbert Xu
 <herbert@gondor.apana.org.au>,  David Ahern <dsahern@kernel.org>,  Willem
 de Bruijn <willemdebruijn.kernel@gmail.com>,  Shuah Khan
 <shuah@kernel.org>,  Sumit Semwal <sumit.semwal@linaro.org>,  =?utf-8?Q?C?=
 =?utf-8?Q?hristian_K=C3=B6nig?= <christian.koenig@amd.com>,  Bagas Sanjaya
 <bagasdotme@gmail.com>,
  Christoph Hellwig <hch@infradead.org>,  Nikolay Aleksandrov
 <razor@blackwall.org>,  Taehee Yoo <ap420073@gmail.com>,  Pavel Begunkov
 <asml.silence@gmail.com>,  David Wei <dw@davidwei.uk>,  Jason Gunthorpe
 <jgg@ziepe.ca>,  Yunsheng Lin <linyunsheng@huawei.com>,  Shailend Chand
 <shailend@google.com>,  Harshitha Ramamurthy <hramamurthy@google.com>,
  Shakeel Butt <shakeel.butt@linux.dev>,  Jeroen de Borst
 <jeroendb@google.com>,  Praveen Kaligineedi <pkaligineedi@google.com>
Subject: Re: [PATCH net-next v16 11/13] net: add devmem TCP documentation
In-Reply-To: <20240710001749.1388631-12-almasrymina@google.com> (Mina
	Almasry's message of "Wed, 10 Jul 2024 00:17:44 +0000")
Date: Wed, 10 Jul 2024 11:28:37 +0100
Message-ID: <m2a5ip1qy2.fsf@gmail.com>
References: <20240710001749.1388631-1-almasrymina@google.com>
	<20240710001749.1388631-12-almasrymina@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mina Almasry <almasrymina@google.com> writes:

> Add documentation outlining the usage and details of devmem TCP.
>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

