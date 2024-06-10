Return-Path: <linux-arch+bounces-4806-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF2D902957
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jun 2024 21:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D047428510B
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jun 2024 19:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9BE14EC41;
	Mon, 10 Jun 2024 19:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WE9/dnSq"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913591487C5;
	Mon, 10 Jun 2024 19:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718047942; cv=none; b=PftlkzNw6h8FnEx13fzNUKrHavKxCTKIU3ee/jwCzCrszjmbNS/uhq9nt5yIN5AzsgYScaZyR996X8+shssLI1UMjYvc7eItbMf5vTyx5cfGWUSw8aN0Q3Xrzv7hwvc1e991rmZsUse7CfSz1DdXSxnfxSEfneFdIvoL7PsG+bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718047942; c=relaxed/simple;
	bh=VuTq4b10N4/opfBKMwzqFtKLSskXYPKPtG7BtOveSas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wtb1jzJaLjVAYasbna/MzyXPYIKM8dLI3PyhDLmEOzOxRQLYb22erO+vqXO7z3tR162menWUaGdCbosQWRIXVyBuv6dY7SoqUkB4Um3DejmA7F0NB2JA07BK++HGrg7Znsu1g2Fcyk41PWQTHzs8cv1WomMVP0CAdoaNsOT6OiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WE9/dnSq; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-35dc9cef36dso309382f8f.3;
        Mon, 10 Jun 2024 12:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718047939; x=1718652739; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cH6LVxT06plsrA1ReD8cM9W1acWe7q6EhO7RV1s6Td4=;
        b=WE9/dnSqN3r8tM5kG9pDm5UEpCR/364ome8tT2CGY6rbwmhnleWIOAyPzxMO4ldTDX
         Ss37g6/L61ssC5UDmjRYsrE+751vN09Lyn02fhZUPn6kOrOYF3E3Qqd1KBSjK+dq7Gui
         0CuZ6kUCxOugmj3L23bipe5Rf/U+9FGtj8kp3mJj4Uc7ZzFTab5zgTuCOsRQQQuEVNml
         +WRzvgwNpa3rYdpF51y954J9/8llhR1iVRE3Kt7+6+vFpAUZrk38qWYnZzHGhWxPdkQW
         qZCC6tjjtaAbxcjQGL0q1pfX/uaGOwj0lcx0q8CSgyy2+3NKcrRBcaBP9PFK+jksN1Vf
         s4Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718047939; x=1718652739;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cH6LVxT06plsrA1ReD8cM9W1acWe7q6EhO7RV1s6Td4=;
        b=MKO9J27OBZfKIbygAP9ZmyelmIHgN+UnCbusxJEbK7ab+GBqsQKTu8kLods2RnzbDX
         WI9J2qBB76LUL1TThUtVLJkyxVh08+1FINkbBpwKuSyx27WTIQj5xAyJTIssscjQFLcC
         YBq3XJnzhcdInuYTznclWCvPIojGLgmuXf1wbU8HisoVi31RWsR68hgtZKIXPhpr/TBp
         kqjMyd1FlTYWJxp0KigeRzdMcR33r5/kP4cKmx1lowQDXxVwB1dTlUyiRC8XWVOQ8dr+
         iZ3EfcYhzEtVoDsyVTot5jvYjnA/g84iZV1h0tRQa9Y/S9mx47qziIj7ET6nRmPYxbfU
         DMpg==
X-Forwarded-Encrypted: i=1; AJvYcCUzTHz/qeWe79ekn6RsiOx+cT9VGRorUrRKukY+ehv7rm/+yEw2i14al1f05aM72KhvcKzu2dVssIE9SLutIbcMuGvGKsR4ov4fxtyG73ewI1eNQTT4koxBemXfdUE57M8oEzQJ1ZDTekxf7R73GpmpnvoLGD5Rc3smEhNZBMB47uBhMA3MABZtPBexVzvpxDcvOkfD89hhFSgVYe4dtur61T09TzkO+UPq7z+NgBfdpjwyyGTLnPRmClQ65EkLn97B4eHobxDHfaZzoA3g9m4fke7MtELOjFXAK1DoOysu4lsURkapdghr18+PSBJi0DLigZbgTPkMK/CoiZPZ0OpiLa+JMBWEIR6K7Mym6yqd/KwCy5jMqPvlrzN/U4hvDZAgaa3alvdvQhyhl4l9pBS4Ln5Bc1KBsqrpa7kgakADUZYBEtmC75ndZepR3fpVePiOFRfhPLfYSkZ0wWba1RIzEh8nULNDI4S5UWbN07SurDNe444F1WzZpLcugLI8Lh1wQYrh9g==
X-Gm-Message-State: AOJu0YwutSUG3RfUji42u2rH72AZykuAlmwGGcog9uFD9FBcfk7tzGGl
	X7e+ULr8iBIex08koXtdO3/5uAywhBX/4lQmMCHH/ekAtzHlhx4w
X-Google-Smtp-Source: AGHT+IHyebdJqoC8N9cFVipCugkjo2s6jygXE3iaN8ED6lgnlN+5ynOFecePOgT3p/WcNF0ptUpPjg==
X-Received: by 2002:a05:600c:1551:b0:421:4786:eb0c with SMTP id 5b1f17b1804b1-42164a44b35mr87551775e9.33.1718047938725;
        Mon, 10 Jun 2024 12:32:18 -0700 (PDT)
Received: from [192.168.42.64] ([148.252.129.53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421cd1fdec7sm47319585e9.25.2024.06.10.12.32.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 12:32:18 -0700 (PDT)
Message-ID: <4c4739df-c2fc-4e9a-a27e-aec00a5667da@gmail.com>
Date: Mon, 10 Jun 2024 20:32:16 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 02/14] net: page_pool: create hooks for
 custom page providers
To: Mina Almasry <almasrymina@google.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, David Wei <dw@davidwei.uk>,
 David Ahern <dsahern@kernel.org>, Christoph Hellwig <hch@infradead.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner
 <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>, Andreas Larsson <andreas@gaisler.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Steffen Klassert
 <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Yunsheng Lin <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst
 <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>
References: <20240530201616.1316526-3-almasrymina@google.com>
 <ZlqzER_ufrhlB28v@infradead.org>
 <CAHS8izMU_nMEr04J9kXiX6rJqK4nQKA+W-enKLhNxvK7=H2pgA@mail.gmail.com>
 <5aee4bba-ca65-443c-bd78-e5599b814a13@gmail.com>
 <CAHS8izNmT_NzgCu1pY1RKgJh+kP2rCL_90Gqau2Pkd3-48Q1_w@mail.gmail.com>
 <eb237e6e-3626-4435-8af5-11ed3931b0ac@gmail.com>
 <be2d140f-db0f-4d15-967c-972ea6586b5c@kernel.org>
 <20240607145247.GG791043@ziepe.ca>
 <45803740-442c-4298-b47e-2d87ae5a6012@davidwei.uk>
 <54975459-7a5a-46ff-a9ae-dc16ceffbab4@gmail.com>
 <20240610121625.GI791043@ziepe.ca>
 <cdbc0d5f-bfbc-4f58-a6dd-c13b0bb5ff1c@amd.com>
 <CAHS8izNwmXQTLc9VADpushYKyeJ4ZY4G9aV47W2-1St65-tKUg@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAHS8izNwmXQTLc9VADpushYKyeJ4ZY4G9aV47W2-1St65-tKUg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/10/24 16:41, Mina Almasry wrote:
> On Mon, Jun 10, 2024 at 5:38 AM Christian König
> <christian.koenig@amd.com> wrote:
>>
>> Am 10.06.24 um 14:16 schrieb Jason Gunthorpe:
>>> On Mon, Jun 10, 2024 at 02:07:01AM +0100, Pavel Begunkov wrote:
>>>> On 6/10/24 01:37, David Wei wrote:
>>>>> On 2024-06-07 17:52, Jason Gunthorpe wrote:
>>>>>> IMHO it seems to compose poorly if you can only use the io_uring
>>>>>> lifecycle model with io_uring registered memory, and not with DMABUF
>>>>>> memory registered through Mina's mechanism.
>>>>> By this, do you mean io_uring must be exclusively used to use this
>>>>> feature?
>>>>>
>>>>> And you'd rather see the two decoupled, so userspace can register w/ say
>>>>> dmabuf then pass it to io_uring?
>>>> Personally, I have no clue what Jason means. You can just as
>>>> well say that it's poorly composable that write(2) to a disk
>>>> cannot post a completion into a XDP ring, or a netlink socket,
>>>> or io_uring's main completion queue, or name any other API.
>>> There is no reason you shouldn't be able to use your fast io_uring
>>> completion and lifecycle flow with DMABUF backed memory. Those are not
>>> widly different things and there is good reason they should work
>>> together.
>>
>> Well there is the fundamental problem that you can't use io_uring to
>> implement the semantics necessary for a dma_fence.
>>
>> That's why we had to reject the io_uring work on DMA-buf sharing from
>> Google a few years ago.
>>
> 
> Any chance someone can link me to this? io_uring, as far as my
> primitive understanding goes, is not yet very adopted at Google, and
> I'm curious what this effort is.
I'm curious as well, I don't remember it floating anywhere in mailing
lists. The only discussion I recall was about
DRM_IOCTL_SYNCOBJ_TIMELINE_WAIT, but it didn't get through only because
someone pushed for evenfds.

-- 
Pavel Begunkov

