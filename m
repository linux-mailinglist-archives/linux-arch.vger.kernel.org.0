Return-Path: <linux-arch+bounces-7015-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0BC396C261
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 17:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43DA31F26011
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 15:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A991DEFFB;
	Wed,  4 Sep 2024 15:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nsn6UIaJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941631DEFE5
	for <linux-arch@vger.kernel.org>; Wed,  4 Sep 2024 15:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725463803; cv=none; b=kb2pwPHScxUOZt/+/9w1KNOEJOS5hh0cpDW6Kfstm19tRLdpCot2f8NFxkOLDRwuV7g0jbH7a2enEDY9pzHFAcbe73GkyR8vhDYh/vyniUSorx38VIqW0mwESjG7TkdrTx2/VzULZCuxaZoo8/PokkcjzzDAhV9idTFfqgH6c18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725463803; c=relaxed/simple;
	bh=gYYY8FNVkypzbtVX8GFJXnTswLqhKBDH6rOvo639VDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oUls4PKa5i3HWdH7QAj4WxyqpG0srdmriiYWCN54x6pIiIeAafuHspAVDNLWVZubsc4gv+xjV2Wg4D3+CkYoEgO6+He0b1AYmzn5/N8euh0QZOCBejcVKbOQ2g/KhfljdwMO99OFCe6AU/GJPeke6oSRN4mtEAF0O/0aY9HK5TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nsn6UIaJ; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c09fd20eddso6494910a12.3
        for <linux-arch@vger.kernel.org>; Wed, 04 Sep 2024 08:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725463800; x=1726068600; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PLhhMPuctYpfIPSQyulh9sZF48oPEhyg3gJ/+naRY0c=;
        b=Nsn6UIaJ8cBOere7dXrX7QJzr3PUi5gC8awflmfdEufX9Y4AUoY8PtXSAv2R8wLCOB
         iSkFtxYqPfwj8WsRPkL3z7su36Pe72k6LXRjv9N/uHE2F9V/ltOs5BanUASmZ1ysBFaT
         nkwJOYFsUhK6KT1/20UTVJFpAiuc0i2APmhHN39DeGes4vdGWusRrvpZNx04KI746RFI
         3/rFGxrJA/3S6Y02/GQKxMQCQ6hjVyak8XzQf2ru9bvZbeCkSB7jwU5aMvHsio8XfyDi
         wiRQ4Dxu7eGf1WD599L2lER/SPQh0Vbr6Ah8LRLMpM6yIuIzQkORktpyoJeDfjnQEUEf
         ccTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725463800; x=1726068600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PLhhMPuctYpfIPSQyulh9sZF48oPEhyg3gJ/+naRY0c=;
        b=nDiPP2TFO36eQicOcu14rjp+BrGHitfOen8gpH1Si1wAhnme1XwifuemER+nXPWGTs
         yqvEKjV9Ib4hQeSLLk6mnf6Q/6lDx2ObSvkSGQ9W+e3L1UWG0NlmT6w9doCW+vXFBNwL
         Fok8Jtfy47xWY/Hm79IGKAu6uW9/+GAPOww5r9Qf9cMK2xjr9YKY00szJDZ25Llu+LR6
         ktipc8kusYAnbiURWc6oF4zkMMZa6/9DFNYYvcTueIBkXbqEj2lKuVW+J1NgisVKE5Kk
         /At0GbXYIPViSa8BubGPQVVjqEc0V31Q+ZC8lffjFBI2WEGI4HY2VsdOYn7cm0rOGOx7
         mlTg==
X-Forwarded-Encrypted: i=1; AJvYcCVlxDzdGMTbfXYAIYUWgqxVAtFlpkCy8ZLxz+A1BcVuUGgVtKgXwr4t8c/ZeVoRBowGmmArmfyovrzV@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmu/QQCBk9bH5b5BUBlRJFVS1nTLYZ/QufeGKsFiyITs5RzBUK
	dog5nEm+vG323zM1UTw/fIWDRFbhkv+wbwJvYdxKVSVAMm8aVXqj4XCoZJLYm6SAyXfeDq7yCJ/
	bxDng3Jq2NW8qplJxdeIxvGptTbsL0NXXkdN8
X-Google-Smtp-Source: AGHT+IFg6rOi18H1toa3LkpzEJnnBMcFXZAacqahmY1gZmTK9rv5lw/xaEow9UneXHrr7DZX8isa3vZhOIIu0S2ULN0=
X-Received: by 2002:a17:906:8903:b0:a8a:43bd:a9e8 with SMTP id
 a640c23a62f3a-a8a43bdabe5mr117170866b.65.1725463799009; Wed, 04 Sep 2024
 08:29:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240831004313.3713467-1-almasrymina@google.com>
 <20240831004313.3713467-9-almasrymina@google.com> <20240903144011.3e7135f9@kernel.org>
 <CAHS8izPN8cDVhAzdedr7zb9zmDaiOMqkaDqB07QwVKKEJ62HzQ@mail.gmail.com>
In-Reply-To: <CAHS8izPN8cDVhAzdedr7zb9zmDaiOMqkaDqB07QwVKKEJ62HzQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 4 Sep 2024 17:29:44 +0200
Message-ID: <CANn89i+iXXUjOJCOF1nodjVH4eX8P-B26Kg+Uu-iM2_Hc=5D5g@mail.gmail.com>
Subject: Re: [PATCH net-next v24 08/13] net: add support for skbs with
 unreadable frags
To: Mina Almasry <almasrymina@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Donald Hunter <donald.hunter@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Richard Henderson <richard.henderson@linaro.org>, 
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Arnd Bergmann <arnd@arndb.de>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Taehee Yoo <ap420073@gmail.com>, 
	Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 5:18=E2=80=AFPM Mina Almasry <almasrymina@google.com=
> wrote:
>
> On Tue, Sep 3, 2024 at 2:40=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
> >
> > On Sat, 31 Aug 2024 00:43:08 +0000 Mina Almasry wrote:
> > >  static inline bool tcp_skb_can_collapse_to(const struct sk_buff *skb=
)
> > >  {
> > > -     return likely(!TCP_SKB_CB(skb)->eor);
> > > +     return likely(!TCP_SKB_CB(skb)->eor && skb_frags_readable(skb))=
;
> >
> > Do you remember why this is here?
>
> Yeah, to be honest, when I first implemented some of these checks I
> erred on the side of caution, and added checks around anything that
> looked concerning, some of these unnecessary checks got removed, but
> looks like this one didn't.
>
> > Both for Rx and Tx what should matter
> > is whether the "readability" matches, right? We can merge two unreadabl=
e
> > messages.
>
> Yes, you're right, only 'readability matches' should be the criteria
> here. `tcp_skb_can_collapse` already checks readability is matching
> correctly, so no issue there. The `tcp_skb_can_collapse_to` check
> you're commenting on here looks unnecessary. I will remove it and run
> that through some testing.
>
> As an aside, it looks to me like that tcp_skb_can_collapse_to
> callsites don't seem to be doing any collapsing. Unless I misread the
> code. It looks like tcp_skb_can_collapse_to is used as an eor check. I
> can rename the function to tcp_skb_is_eor() or something if that makes
> sense (in a separate patch). I think the name of the function confused
> me slightly and made me think I need to do a readability check.
>

Please do not use tcp_skb_is_eor()

tcp_skb_can_collapse_to() could be renamed to tcp_skb_can_aggregate_to()
or tcp_skb_can_append_to(), but EOR would not help at all.

