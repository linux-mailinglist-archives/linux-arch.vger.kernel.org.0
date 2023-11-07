Return-Path: <linux-arch+bounces-9-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CA97E31E8
	for <lists+linux-arch@lfdr.de>; Tue,  7 Nov 2023 01:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D7D5280DF3
	for <lists+linux-arch@lfdr.de>; Tue,  7 Nov 2023 00:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA04F80E;
	Tue,  7 Nov 2023 00:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KoRSF3+Z"
X-Original-To: linux-arch@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D96624;
	Tue,  7 Nov 2023 00:03:25 +0000 (UTC)
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE9E11A;
	Mon,  6 Nov 2023 16:03:23 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id a1e0cc1a2514c-7bb2e625165so632147241.1;
        Mon, 06 Nov 2023 16:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699315403; x=1699920203; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cjOyMk9SzKBIBazjv/h8e6iW+SY3zc4TCme29hNVYak=;
        b=KoRSF3+ZxadCHgrHpofSKtDQJUXJuI4iTbGW8AHEfBOSc1204zme4yK4IrF9rxBnCy
         ZEbcbHHOpi2w3AsEFt2DcUOC/TyQ3aO6vtFLkh204JFPZT9aywz11SfIQzezuBeqFZeo
         JRcQzZQWxagg0iNzVlBb3/zs7uqtNgOwjgeyRDAayMjnqTlnklMKLD+zqDseRDeV+MaE
         1J05i6sFd1m6TiXWum9lbXgyYZZzqvsU98Yb7OLxMlWzDKWmprtd0Cr79KuNy7aCasP8
         u9uAX5N4UIzJ9Fg4kDsitQFuW0fF0gh3ZFnUnOWTc1T/AbG0es3wZUtWtDdMcSKoSugp
         F6Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699315403; x=1699920203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cjOyMk9SzKBIBazjv/h8e6iW+SY3zc4TCme29hNVYak=;
        b=hLyceBjHMf5YkECS5DTTVrjU99KzTIWPZ4RlBZgzPIdQLzXcNVa9cu0YRL9yqG/7rW
         DfRYLOlcZiwB8ZgbcBcZKw72oBOBJC3PvNWmquZ2OpRUBiJNTKpWtYSmQDx2XlSQZIo7
         f77NX2vFjnMNsQCS9orWpDf/r8Ss7sfOqua2YnEO/t7I6Q175futhiap9+Hqp6hG6aGy
         5VMokfBP3UIEO5QkoAyLWZcPAP0AmpZ+KZkZTp+w5Slk9QEeoououRabgPliJvUt0prg
         NeXiszIK0QWMGri7YgRElhetqPZ/6MY83dYFJHu0MZzhVcI+l7Y2EJieizk3lRVgbI5+
         TrKA==
X-Gm-Message-State: AOJu0YwRbO073momWwlI5+Zy5jtuwa+nChiBJkVW1r7Eat0RX9t3oyVS
	uNaCiwjCMuDqiPyU206qZrEibVGapbNZZ6Fqdtc=
X-Google-Smtp-Source: AGHT+IEbiDtM5YXu/PhpE4XQuotEwU4Ndp88Nl6MwVDyldKJxTkPcynL5M6yfEk9QmT6fckOqnpR4Bj4udSwGIkYfHs=
X-Received: by 2002:a67:e1cd:0:b0:45d:9e9e:6183 with SMTP id
 p13-20020a67e1cd000000b0045d9e9e6183mr7172136vsl.7.1699315402987; Mon, 06 Nov
 2023 16:03:22 -0800 (PST)
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
 <CAKH8qBueYgpxQTvTwngOs6RNjy9yvLF92s1p5nFrobw_UprNMQ@mail.gmail.com> <93eb6a2b-a991-40ca-8f26-f520c986729a@kernel.org>
In-Reply-To: <93eb6a2b-a991-40ca-8f26-f520c986729a@kernel.org>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Mon, 6 Nov 2023 16:02:42 -0800
Message-ID: <CAF=yD-Ln4v8orUne8E7D2_eHu39PWPCrMR3Qtuh312pCu=erng@mail.gmail.com>
Subject: Re: [RFC PATCH v3 10/12] tcp: RX path for devmem TCP
To: David Ahern <dsahern@kernel.org>
Cc: Stanislav Fomichev <sdf@google.com>, Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org, 
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

On Mon, Nov 6, 2023 at 3:55=E2=80=AFPM David Ahern <dsahern@kernel.org> wro=
te:
>
> On 11/6/23 4:32 PM, Stanislav Fomichev wrote:
> >> The concise notification API returns tokens as a range for
> >> compression, encoding as two 32-bit unsigned integers start + length.
> >> It allows for even further batching by returning multiple such ranges
> >> in a single call.
> >
> > Tangential: should tokens be u64? Otherwise we can't have more than
> > 4gb unacknowledged. Or that's a reasonable constraint?
> >
>
> Was thinking the same and with bits reserved for a dmabuf id to allow
> multiple dmabufs in a single rx queue (future extension, but build the
> capability in now). e.g., something like a 37b offset (128GB dmabuf
> size), 19b length (large GRO), 8b dmabuf id (lots of dmabufs to a queue).

Agreed. Converting to 64b now sounds like a good forward looking revision.

