Return-Path: <linux-arch+bounces-2348-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2227A854CDB
	for <lists+linux-arch@lfdr.de>; Wed, 14 Feb 2024 16:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 412461C280A7
	for <lists+linux-arch@lfdr.de>; Wed, 14 Feb 2024 15:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0B3604B3;
	Wed, 14 Feb 2024 15:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rdd+gZm8"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FD15D757;
	Wed, 14 Feb 2024 15:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707924713; cv=none; b=J/8FoUxHp7sFV3sCppRGrANXBafQr45+pIhPLsLzpJZejhKzBmbPQuKSSicgVVWbe3hN8AjE9uvov5ls7Mb1ZG/cRVrJDaNJ0Nn78cvEf6Y2a46Kxw9STotg5qO9Ud0PzB/h7sQRHG9sNHBXzoVJiXeqKt8ufnoBG09KcFj1Y7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707924713; c=relaxed/simple;
	bh=L1paFLsmS7WUNRU/qVQfEO1XBs8PZDgIRaP0CUaswrk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oIMKDXgvk1XcrK+IlfYhwDtiAvomgvRB5FANnm3aBN6iuKpeJSc+JdTkfIKSVJ0gcQAkBYbqzNibgxivUhm5DHqu2NtcPVm07rlI7X1HFE+/zyYIBKeb+8k+rB0PAmR0Bm0RdWKj9iWoRDoP3h3N17j5a/Iah/WJ89JZ5nxizv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rdd+gZm8; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5639b00a25cso62513a12.0;
        Wed, 14 Feb 2024 07:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707924710; x=1708529510; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vE8/xX9uxStoXuIsHuY6FjGx2HBrbtcyHjIC0Q0+HAE=;
        b=Rdd+gZm8hPbnQn2r99IHDGjBaUgjMjmLE9rzjbXb3hzFy6mlwvTH/iFqen/TkFx5v7
         Epkrd5s5r2NroHPYZ1B9k0nm7P3zSbUlqhiHoasPVr9DhSk+rZ41OZ+yqC9U/cpotaEv
         YK2ON5r0Z6tvkENvEl2+br+nV+DSZy9iE5tNjD5K757N4BwImcqvCM7jdYhPIFlR22xV
         KZQYbK8NM7yqZupwQpvcC6SP/y5b2Go5VrsKKPgGmwitpTfIa7BRily8mZ8/53rV18j7
         EyA1QG5eWahX3B4JC2xdUs2TAbg8WP8Xo9PFY/DRSGS5u11Bb4lF++zPjtNAKoUFq4yl
         gfzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707924710; x=1708529510;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vE8/xX9uxStoXuIsHuY6FjGx2HBrbtcyHjIC0Q0+HAE=;
        b=PqfYxKxyz8xInCSGBDb4VP963m+nmHw2Rx0eSJbCPyCJ1z7HTEYg1Q1Y0aQcyyhrMK
         44mhVj5W3sa6s2f2oaAQZmeEUq/CS6Nvy/mWs5+73Jm3lcqNZ/5BXGxpsAdPlECCN18V
         TKugOUBwRF3bKNODdIsZ7pADDGU0gyyv5CMtvhoJfiJ0ULnB2daY5sEbh1it5bdWSuZS
         nc3sOlSgpxab9OTlN6lFYp0glyMa1svRF2Sug7o5il9oDp6t5hRJ1c92+qeOCdwZeNN/
         67AUf+bkoWseMkac2+5IRzWVN4L36gBNBVLcT9aUug7dL942tuAGl3wLRjZ5E+3FN0a8
         V99A==
X-Forwarded-Encrypted: i=1; AJvYcCUfgDzfagAW+PmMyiN6rIZnCvSkL+Sm4VhLQJCHEm0oM4p5C9gmLEkhlrXhq9Kdxh083DjHUZalFo+d/IYGkb7g3pDGgjcZD61YgIJx/xPJ35fcQlhlxpZ0xuxkeoruda630RwSt6p4K+Za6W5LAh2BaTZmQiEPG+/n7E0Swcxf9VLQFsTROjsbVy1E2+hVvcJpZXWwbe9XzFCzjY1njyY21g2uELnGbk9dvTQtYi3yxKcVmFqkjQPgFCWRIOz+GiYfYRmyPP1J04K0hscnsuSz7aE6aWs8uG0Sal046N1fiOOgIQ3aldv9snrWw7g8dTuuwXlm3R6iTqMhT2HTxnZ0dlnSdYGHU0KKTwfwB2Oc8xd8cDH5lDIJPXMAxd7EpUY8qiwj2gaDM2yMPZUA6qAYSr8QFwWOhBJETDvq33r7vSdAnbOBWjjkSg8KTDCjXbqNV3794BDuzb1tJxolgHpMgV0ED4pN5V2Z3nBBKyG+KwQ7FbO0G5EDEt9HB9iiCJrN9vItFA==
X-Gm-Message-State: AOJu0Yw+8u/sRlru+9nGWNsXE3UJE4Mz8pkd6IZ1VyS/YXt50ktXNXhX
	FpzAdlHp963s5X5d3MvVqwUJo0Ekj0lpyPVZkYfXCtl45miXWXoE
X-Google-Smtp-Source: AGHT+IFJjeHJkhu4E/5PQL7Dr2d77iKz2i3apIzpMMgqPcQHi77X+UE8B2mD6qzLMtE6+dUYVhK/OA==
X-Received: by 2002:a17:906:4091:b0:a3d:1458:3db9 with SMTP id u17-20020a170906409100b00a3d14583db9mr2033804ejj.18.1707924709571;
        Wed, 14 Feb 2024 07:31:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWIAccAWgK4lRqfWAiTFf2zOmFvQ0cjuzenXB/9W2eZuobq9WyoNFiLAq2+XZEu2KOwhDhUl08prR0TdsNqdt/p3fpS9OUX1dkDg7gMrca8l0pMYcjca3KdKCHAbXzom2/SHjYBQRvzRQOm0yWyInuamEGg2Pd+Tbd0vhH0EK/PYfsXk/0D7tnStMVzl8NvP4nE6Bm9xf0XXnPDt+BWsU+fVlOW0fRFcRJt68nbjiuUymX8Ihykx4Bi5UI7l8MmYHivujIr3jrYd5OmNiULju6LqVQ03h9J2mVBr6Y4kzJq7y0O7Y+ruaIY8dfB3gAotuMx8fmGXmej+7OAM+CcDmS8GZusMWnjhcYnmSN9iEw2XGLFRDv/zEzfWiCb7k33Gf9N+dpzm+tkstNr2Gv3qd/4aII5CgI+apL16oBzPzLR4RdWuDLHRKBFMmbiG2GUg5AnYJrWI/4HkU0G59qJGf1LzoIKp7SoSz2PUuCtBd514aE91bAYOarQ980ubpMjW2voJ2og6U0AJ8p6S/p9Utx56Iv7xID1qdz9xFxK79njnb00TS9bn6KS3ONPx/m481JXuEoeIU8pUzwiaJy1g/stIFY6RBxPgYLb8VfuaxiMjn4lPPr1ide8Wejcsvmcp9yU6ddXzx9BOYhdv+iwf/4gSyB25dMQtXKhMRZFA1hdzaJaynUszbGA5ez1fsjJmuIdeHIos+gF/xdADWxZU8R1eTCy1Vr60X1ySsGcZTeUp/1brqlaxAOH0K5vdvoYlIaU/pfEfOpj9RIc+ecCLcimJczreESQYF2PsecL7g2H5UJ0QiS89kiIaBbSPuyWtmWyWnQxyHtQG+QRb4cc0uiguUzZ/X96gxQWoGE2ogXIEoZ40Q4TB5oqV+RZbOR+phuAGVeDNVyT1JeYVeXZnPaBL+zoE4cNc9MPgLb+7hp5KWodx26/txiDdRRn81u7Y8uOET
 Rnm5a54n8LY+pNVqm5CnENC/aQlazL9whyTZqQDlzTgJJG6l/C7EYlZEweZxiHjDpP/74qNMrYpjA99qdtlWh/2b/hzjZeOXV0OOOU+rocIfsYQxVz8kw91HRewTVN1gKiLDHy/niFZoMQgdxB3ZUmOOvlZljJ4yvu19cGehAMo0FAjoXIzIRqGdjKPnJfcbxadZKphWyKeUSGU9KQueszPKDRdfZDLMzBRofZNCIjKv/CR1jIrVveae6Pd+K86hHHAfU3kEuXlu15R9X+G37gMcknMRcdazHnScHuIkr/IHyyHAvazM8sgkmfz73WoxATV7VXEw5EXn2NrWHl+BIDhc1ZktbbLtUQFQ+M9OA+N8LHBQqZeoUvfGps63MAly944RryRFGlG+qOZsmvZqccm3MissuaLU8rlcmFDT2T80P7vGr2SbUcFMzRDkAKRoQiNLLJkLXXCurYv6LyrF8CuLq3v7mzm2QysNKEfPzeM2agEDFVxXyiKqJOVWP7HnzPQI89geXQUy5CNF1Gte1i7RLyTqi/oV7FtdsN1PxVMr0sZd3ffQmAbB7fRu42ueEjbAcz4ZxfUr1wnFzznCSy/ffFm7dJs9Iu+1t4PzbZwkd8U4TmvDxqWyAyUKavcPnbSX0y7o+iJorMgo79HW+r5LSzwjoroqXVA8lAg7Mt1smJJye8qFRlnTWpKKoiU2zQ8IFaWIC5Ih5sr/Tmaie9syohfdfLfuaeMQrQepLF1JE=
Received: from ?IPV6:2620:10d:c096:310::23d8? ([2620:10d:c092:600::1:1e51])
        by smtp.gmail.com with ESMTPSA id o14-20020a1709061d4e00b00a3d5efc65e8sm403200ejh.221.2024.02.14.07.31.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 07:31:49 -0800 (PST)
Message-ID: <c28e1f66-84c8-40f7-b200-f18bee06cb33@gmail.com>
Date: Wed, 14 Feb 2024 15:30:25 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v5 07/14] page_pool: devmem support
Content-Language: en-US
To: Mina Almasry <almasrymina@google.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner
 <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, David Ahern <dsahern@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>,
 Yunsheng Lin <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Shakeel Butt <shakeelb@google.com>, Jeroen de Borst <jeroendb@google.com>,
 Praveen Kaligineedi <pkaligineedi@google.com>
References: <20231218024024.3516870-1-almasrymina@google.com>
 <20231218024024.3516870-8-almasrymina@google.com>
 <3374356e-5f4b-4a6f-bb19-8cb7c56103bc@gmail.com>
 <CAHS8izO2zARuMovrYU3kdwSXsQAM6+SajQjDT3ckSvVOfHwaCQ@mail.gmail.com>
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAHS8izO2zARuMovrYU3kdwSXsQAM6+SajQjDT3ckSvVOfHwaCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/13/24 21:11, Mina Almasry wrote:
> On Tue, Feb 13, 2024 at 5:28 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>
...
>>
>> A bit of a churn with the padding and nesting net_iov but looks
>> sturdier. No duplication, and you can just check positions of the
>> structure instead of per-field NET_IOV_ASSERT_OFFSET, which you
>> have to not forget to update e.g. when adding a new field. Also,
> 
> Yes, this is nicer. If possible I'll punt it to a minor cleanup as a
> follow up change. Logistically I think if this series need-not touch
> code outside of net/, that's better.

Outside of net it should only be a small change in struct page
layout, but otherwise with struct_group_tagged things like
page->pp_magic would still work. Anyway, I'm not insisting.


>> with the change __netmem_clear_lsb can return a pointer to that
>> structure, casting struct net_iov when it's a page is a bit iffy.
>>
>> And the next question would be whether it'd be a good idea to encode
>> iov vs page not by setting a bit but via one of the fields in the
>> structure, maybe pp_magic.
>>
> 
> I will push back against this, for 2 reasons:
> 
> 1. I think pp_magic's first 2 bits (and maybe more) are used by mm
> code and thus I think extending usage of pp_magic in this series is a
> bit iffy and I would like to avoid it. I just don't want to touch the
> semantics of struct page if I don't have to.
> 2. I think this will be a measurable perf regression. Currently we can
> tell if a pointer is a page or net_iov without dereferencing the
> pointer and dirtying the cache-line. This will cause us to possibly
> dereference the pointer in areas where we don't need to. I think I had
> an earlier version of this code that required a dereference to tell if
> a page was devmem and Eric pointed to me it was a perf regression.

fair enough

> I also don't see any upside of using pp_magic, other than making the
> code slightly more readable, maybe.
> 
>> With that said I'm a bit concerned about the net_iov size. If each
>> represents 4096 bytes and you're registering 10MB, then you need
>> 30 pages worth of memory just for the iov array. Makes kvmalloc
>> a must even for relatively small sizes.
>>
> 
> This I think is an age-old challenge with pages. 1.6% of the machine's
> memory is 'wasted' on every machine because a struct page needs to be
> allocated for each PAGE_SIZE region. We're running into the same issue
> here where if we want to refer to PAGE_SIZE regions of memory we need
> to allocate some reference to it. Note that net_iov can be relatively
> easily extended to support N order pages. Also note that in the devmem
> TCP use case it's not really an issue; the minor increase in mem
> utilization is more than offset by the saving in memory bw as compared
> to using host memory as a bounce buffer.

It's not about memory consumption per se but rather the need
to vmalloc everything because of size.

> All in all I vote this is
> something that can be tuned or improved in the future if someone finds
> the extra memory usage a hurdle to using devmem TCP or this net_iov
> infra.

That's exactly what I was saying about overlaying it with
struct page, where the increase in size came from, but I agree
it's not critical

>> And the final bit, I don't believe the overlay is necessary in
>> this series. Optimisations are great, but this one is a bit more on
>> the controversial side. Unless I missed something and it does make
>> things easier, it might make sense to do it separately later.
>>
> 
> I completely agree, the overlay is not necessary. I implemented the
> overlay in response to Yunsheng's  strong requests for more 'unified'
> processing between page and devmem. This is the most unification I can
> do IMO without violating the requirements from Jason. I'm prepared to
> remove the overlay if it turns out controversial, but so far I haven't
> seen any complaints. Jason, please do take a look if you have not
> already.

Just to be clear, I have no objections to the change but noting
that IMHO it can be removed for now if it'd be dragging down
the set.

-- 
Pavel Begunkov

