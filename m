Return-Path: <linux-arch+bounces-7014-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 182BF96C20A
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 17:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 664C02829AE
	for <lists+linux-arch@lfdr.de>; Wed,  4 Sep 2024 15:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A851DFE1A;
	Wed,  4 Sep 2024 15:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jtu6fplo"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33E71DEFED
	for <linux-arch@vger.kernel.org>; Wed,  4 Sep 2024 15:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725463107; cv=none; b=pIRerA+py/Uuu2T2LtczTRcoOWIuUYxdRCOV5WfskiBnwZpRR0ttR4RFfxoPFT3LJxUtmb2BcRhlisfemDAgRuxcyHiaf90lPNibQ7G+/Zd4QX8HOwHnhTItmbtFpiek32Upj8+1fYO3SmdoNBd29iKbyWGyHCF4l7em4vbmn1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725463107; c=relaxed/simple;
	bh=sXtLgXQzVV2KYM3glPRuxYC/5hs3yMDkVUdSwXrs2JI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LFFhmiusY56SmYYtkHyPV08k7MpsARVm/4Dxb+O3UEvROa1GgPLDLmH3cB1vAtJx+CxgzD35KB3Rt6LKBedyq0X9Xucr9ics3xP9FFj0IEWz0bghRE496CxtuwH5cZCL3dxHEVJ/Pt5+WE29dQpZnNGtzML/935Nw4QcW4bwUaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jtu6fplo; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-457c6389a3aso267091cf.1
        for <linux-arch@vger.kernel.org>; Wed, 04 Sep 2024 08:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725463105; x=1726067905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LD/VB3T6PK6SWkzZ0xkGr8kbW+Sx4WeUFngHFhxmWFU=;
        b=jtu6fplo1EwDPApGNAcMv77ohhFeLh4VheMMrgCIQr/HxgXOCom31HIY9dHgl+Yags
         CX4ugkPSHfPKAMLaMnWetadC75u3xU243A39AynmHCr9PuGWtBi472Y7fuMnnaAiqbz0
         Aqm6Dqk5oEuVB1GxzWQhsDCmBMbelKhmuWkrhJeHLcFEb4hSfHZHRzA3ZZx2uq8BmbsV
         TQzYXA0O2cc1bI+hAGxAOlSss1ajW07jMykWMPtz92MDS128Mjf2J21DnhKtXaw6FH9s
         FyqrSgkqBYsc4yZ4XakxSQfhyj1Vafbv/2dtFeYTfR4tE9ki2wCOgkCUkrGU0CT3i7CI
         4vPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725463105; x=1726067905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LD/VB3T6PK6SWkzZ0xkGr8kbW+Sx4WeUFngHFhxmWFU=;
        b=v4SswMZvg7u1T1BQ/yQxSvZGr7EGicIQ+Cb+Ilsy1yPfpOoafj1GmNsVnCgpRxSrp+
         sccUEgacWgibqYtckYkEoAauPohVHG8o8tbNRqK0eIboyAZHiJEt+s9Y3JF19+dmT+wH
         bGbc3ocCwYyA2NlZvbTvUMd9MX7npQGRjTdoHue6ftLUgEHGBE1JfpU26NPNDYsza5gB
         CwsQXhgcm2dHQ61TQfHOtK2v9HPuyVVNF//Q9JpElCjj+lJrxSPMSdmv2xsIE4U3ndqo
         EmKu2tedsIyVyRVJLQwFiZ3MXSD0cLuSwYx+bCsnplES1f5i4zLGj6eaBb2aNTdcBwXQ
         qknQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoZfBe5yWfia1znEJMOUSNaWqyjBEhBZteI9rAonWf9wd274C4KyPiM1ebWLbJ7WDZN99TZSdg+vmK@vger.kernel.org
X-Gm-Message-State: AOJu0YyYQS1CLlQ8kO1sPqcT99EAZY+5+GtAJ0lORfdrCGcgjkWe0ART
	MHbyBEyYFHX4wX2SAlKp07y3xWBsrS7KyQ/uv+Hdn8w/yiDFtTP3ahg+ASk/f+tp8CwMBrphKYJ
	GQWkWeEXQSl1P3fUQIFVROjhli0ZZaFeeQY2C
X-Google-Smtp-Source: AGHT+IFUx/o9LJkME5WyEg785HOWYMcUA5VsWIPNTEqlhEzpir/bmFgy1UHj7/XRd4GdWuFH4iylG23RG+gVAR1iVpU=
X-Received: by 2002:ac8:7d07:0:b0:456:7cc9:be15 with SMTP id
 d75a77b69052e-457f7b38578mr3074581cf.29.1725463104431; Wed, 04 Sep 2024
 08:18:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240831004313.3713467-1-almasrymina@google.com>
 <20240831004313.3713467-9-almasrymina@google.com> <20240903144011.3e7135f9@kernel.org>
In-Reply-To: <20240903144011.3e7135f9@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 4 Sep 2024 08:18:12 -0700
Message-ID: <CAHS8izPN8cDVhAzdedr7zb9zmDaiOMqkaDqB07QwVKKEJ62HzQ@mail.gmail.com>
Subject: Re: [PATCH net-next v24 08/13] net: add support for skbs with
 unreadable frags
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Donald Hunter <donald.hunter@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
	Matt Turner <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
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

On Tue, Sep 3, 2024 at 2:40=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Sat, 31 Aug 2024 00:43:08 +0000 Mina Almasry wrote:
> >  static inline bool tcp_skb_can_collapse_to(const struct sk_buff *skb)
> >  {
> > -     return likely(!TCP_SKB_CB(skb)->eor);
> > +     return likely(!TCP_SKB_CB(skb)->eor && skb_frags_readable(skb));
>
> Do you remember why this is here?

Yeah, to be honest, when I first implemented some of these checks I
erred on the side of caution, and added checks around anything that
looked concerning, some of these unnecessary checks got removed, but
looks like this one didn't.

> Both for Rx and Tx what should matter
> is whether the "readability" matches, right? We can merge two unreadable
> messages.

Yes, you're right, only 'readability matches' should be the criteria
here. `tcp_skb_can_collapse` already checks readability is matching
correctly, so no issue there. The `tcp_skb_can_collapse_to` check
you're commenting on here looks unnecessary. I will remove it and run
that through some testing.

As an aside, it looks to me like that tcp_skb_can_collapse_to
callsites don't seem to be doing any collapsing. Unless I misread the
code. It looks like tcp_skb_can_collapse_to is used as an eor check. I
can rename the function to tcp_skb_is_eor() or something if that makes
sense (in a separate patch). I think the name of the function confused
me slightly and made me think I need to do a readability check.

--
Thanks,
Mina

