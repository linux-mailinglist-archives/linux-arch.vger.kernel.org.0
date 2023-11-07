Return-Path: <linux-arch+bounces-10-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 113457E31EE
	for <lists+linux-arch@lfdr.de>; Tue,  7 Nov 2023 01:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41F5F1C20A02
	for <lists+linux-arch@lfdr.de>; Tue,  7 Nov 2023 00:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7129F810;
	Tue,  7 Nov 2023 00:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OZBThTfY"
X-Original-To: linux-arch@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C720610F0
	for <linux-arch@vger.kernel.org>; Tue,  7 Nov 2023 00:03:56 +0000 (UTC)
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A161125
	for <linux-arch@vger.kernel.org>; Mon,  6 Nov 2023 16:03:54 -0800 (PST)
Received: by mail-vk1-xa2e.google.com with SMTP id 71dfb90a1353d-495d687b138so1947875e0c.3
        for <linux-arch@vger.kernel.org>; Mon, 06 Nov 2023 16:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699315433; x=1699920233; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+k7O7fPsM7i2kvbi4Eehiz4lx1hbxjBD0ACtWEdTidQ=;
        b=OZBThTfYmWxjCXnpuw2f2eRdmCYyE/P+WRlpe1p4GtgPA5fNDqSqa1H7L1OTB1PPaQ
         7+Cy7JEETq/OMLB9KpyCUobSuBGZEx5aOa/tyaPJp3gOyNo0Y1kZhoEb/2sV1LITQfwB
         467bQmWbHLHfklXvl7Sso4iArASp3nRBHKryyLSYe/KU5et1kEy/KWEoTGUBS8gy5Nu6
         hYBDA+n/7J7tFHj9W3oBO6FSievmSXBYLa7w6I2r29MK2mbwOo6aaoIxgtoPpoH3dUH3
         2lAOJF9nuWzIb0kh9o0kKP+GZgbx+JZ1aJSk7iRFWvOowcpFzzJN9ghzRcYPvmz3Lu0Q
         dlkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699315433; x=1699920233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+k7O7fPsM7i2kvbi4Eehiz4lx1hbxjBD0ACtWEdTidQ=;
        b=Pnaim0YgYCUJUenBOCk059NrvuZZVpqE7XHXY8fGeOpxQYNSc59Y8QqOUVOiTEG+NF
         imUdKq96s/nEvyfAo4jm3zvTB6yDOZF1iTkMr++jitNGJ7nd90FP9cCkjiMCyIlvLnyK
         y2wb8bQ33YJ58cucg0NfyEe5yFSiLRztVuQfG/m3QelWEhxwB6eItqb9IAVq6KhmdZtt
         1GATwZz4vw0unYo3Ee1HhznoRybvkIFNii/Ko0spGENLL9TFoSTpCzPKNQv/u2yoEdf2
         XY7fqZk8J+WAs6swjaprD7Oyn0ZSA6151FKu+s1mMWdOU7nTl+Ycm2yhcbI1aFO85dmv
         MREA==
X-Gm-Message-State: AOJu0Yy0IMR6WbBECnIzJ2VGTtdQDYlMwrb7cmpQ5ms35Pwo/Ne6F5P0
	MowacD5DdPipuw3v4PFIpDeT5gamzZRRIAXbnlmW6A==
X-Google-Smtp-Source: AGHT+IEtcpOYvpwzR5ghgo79gr1DGe6ofXaayePQzxg8gI82zeZvTQdm2jCfdPUEIBnZJalKkVVzL1oy5qF5cdYsa+A=
X-Received: by 2002:a1f:aa15:0:b0:4a8:4218:7b90 with SMTP id
 t21-20020a1faa15000000b004a842187b90mr19912346vke.9.1699315433224; Mon, 06
 Nov 2023 16:03:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231106024413.2801438-1-almasrymina@google.com>
 <20231106024413.2801438-10-almasrymina@google.com> <ZUk03DhWxV-bOFJL@google.com>
 <19129763-6f74-4b04-8a5f-441255b76d34@kernel.org> <CAHS8izMrnVUfbbS=OcJ6JT9SZRRfZ2MC7UnggthpZT=zf2BGLA@mail.gmail.com>
 <ZUlhu4hlTaqR3CTh@google.com> <CAHS8izMaAhoae5ChnzO4gny1cYYnqV1cB8MC2cAF3eoyt+Sf4A@mail.gmail.com>
 <00883386-0c4b-4ba7-84c6-553f468304e6@kernel.org>
In-Reply-To: <00883386-0c4b-4ba7-84c6-553f468304e6@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 6 Nov 2023 16:03:39 -0800
Message-ID: <CAHS8izN3k+x4W19cRv=DyEuJewGKUxVwobQgSZOLEDh3wDcyVQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 09/12] net: add support for skbs with unreadable frags
To: David Ahern <dsahern@kernel.org>
Cc: Stanislav Fomichev <sdf@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Shakeel Butt <shakeelb@google.com>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Willem de Bruijn <willemb@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 6, 2023 at 3:37=E2=80=AFPM David Ahern <dsahern@kernel.org> wro=
te:
>
> On 11/6/23 3:18 PM, Mina Almasry wrote:
> >>>>>> @@ -991,7 +993,7 @@ struct sk_buff {
> >>>>>>  #if IS_ENABLED(CONFIG_IP_SCTP)
> >>>>>>      __u8                    csum_not_inet:1;
> >>>>>>  #endif
> >>>>>> -
> >>>>>> +    __u8                    devmem:1;
> >>>>>>  #if defined(CONFIG_NET_SCHED) || defined(CONFIG_NET_XGRESS)
> >>>>>>      __u16                   tc_index;       /* traffic control in=
dex */
> >>>>>>  #endif
> >>>>>> @@ -1766,6 +1768,12 @@ static inline void skb_zcopy_downgrade_mana=
ged(struct sk_buff *skb)
> >>>>>>              __skb_zcopy_downgrade_managed(skb);
> >>>>>>  }
> >>>>>>
> >>>>>> +/* Return true if frags in this skb are not readable by the host.=
 */
> >>>>>> +static inline bool skb_frags_not_readable(const struct sk_buff *s=
kb)
> >>>>>> +{
> >>>>>> +    return skb->devmem;
> >>>>>
> >>>>> bikeshedding: should we also rename 'devmem' sk_buff flag to 'not_r=
eadable'?
> >>>>> It better communicates the fact that the stack shouldn't dereferenc=
e the
> >>>>> frags (because it has 'devmem' fragments or for some other potentia=
l
> >>>>> future reason).
> >>>>
> >>>> +1.
> >>>>
> >>>> Also, the flag on the skb is an optimization - a high level signal t=
hat
> >>>> one or more frags is in unreadable memory. There is no requirement t=
hat
> >>>> all of the frags are in the same memory type.
> >>
> >> David: maybe there should be such a requirement (that they all are
> >> unreadable)? Might be easier to support initially; we can relax later
> >> on.
> >>
> >
> > Currently devmem =3D=3D not_readable, and the restriction is that all t=
he
> > frags in the same skb must be either all readable or all unreadable
> > (all devmem or all non-devmem).
>
> What requires that restriction? In all of the uses of skb->devmem and
> skb_frags_not_readable() what matters is if any frag is not readable,
> then frag list walk or collapse is avoided.
>
>

Currently only tcp_recvmsg_devmem(), I think. tcp_recvmsg_locked()
delegates to tcp_recvmsg_devmem() if skb->devmem, and
tcp_recvmsg_devmem() net_err's if it finds a non-iov frag in the skb.
This is done for some simplicity, because iov's are given to the user
via cmsg, but pages are copied into the linear buffer. I think it
would be confusing for the user if we simultaneously copied some data
to the linear buffer and gave them a devmem cmsgs in the same
recvmsg() call.

So, my simplicity is:

1. in a single skb, all frags must be devmem or non-devmem, no mixing.
2. In a single recvmsg() call, we only process devmem or non-devmem
skbs, no mixing.

--=20
Thanks,
Mina

