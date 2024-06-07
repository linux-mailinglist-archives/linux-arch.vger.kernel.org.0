Return-Path: <linux-arch+bounces-4752-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91ED2900983
	for <lists+linux-arch@lfdr.de>; Fri,  7 Jun 2024 17:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 853DE1C21F23
	for <lists+linux-arch@lfdr.de>; Fri,  7 Jun 2024 15:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A83C198E86;
	Fri,  7 Jun 2024 15:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bV2l9gTf"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9B842069;
	Fri,  7 Jun 2024 15:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717775219; cv=none; b=n1zCCoJMFhb2IzzDdKl1WIWubf2DLr8lx1E8RYRBYhTHJM2p7YHBoBoymAoxnovgiL+cLo1XF4FY9WBBZIMmHiTDm7WYd/kzEEqwgW6n3k3ad92s/4bRlRH2CRRqWKM4k+4A1LoO3qq/k6C/hdt5O1l5pewwYEPloNgX0hKtPOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717775219; c=relaxed/simple;
	bh=pUi1jj8tXmg0xRXcCvgfXTh7VkciCJG7Z7ish9eOnAo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=a15CKSxesoL3OBmU2xR4I+2TZCTthl7cGDXecyI7vUI5AhqzjbJtVl0vFg8ha1QQh69rxtzpkh8NuyqRsD33KQdWCdGdiIPKoXo9uIzzn4ZToPCLL3dmiK/QaqHHUyZ4RXB7h76O/+YED+H4FOXAoAWFQ5iAqwMy1wjrUvPPMHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bV2l9gTf; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a6ef64b092cso46989966b.1;
        Fri, 07 Jun 2024 08:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717775216; x=1718380016; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lbfQPuUVQZ6LzSSvTAQFunm5UA6lBQ6TlzjmJiAR6E0=;
        b=bV2l9gTfTRJLJ8xpY1NfA0XIAY+8EAV8XU6woD1sSp+nB+vJ0X0M0VBKU0Klc0AY9f
         bj9Ir9abN/mmbsQBOEtnpYJi48TwW11uQhPWjEohDOl3uNTeFhKHydpcJVlmvl6Tx/+S
         BrIRdXFywHnRGRUgM4fi5QThOORoq+PZDeR007peFY4kklToZdovyDy8JHiWu3baSimO
         gNDZfUsZrCup0mswgrZZKqLlSVlmOLA6ohcEIF2N7TDmYIJat923az4bm9LTk7XPaAXV
         xc/cVnItzWarC5edv8KMkMIYdNNoa3OXviqStOfntpuH/wCH4mUTEj6Azzq1HKWEeq1U
         dc9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717775216; x=1718380016;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lbfQPuUVQZ6LzSSvTAQFunm5UA6lBQ6TlzjmJiAR6E0=;
        b=JydQ4DNmt7X0dq3R1AtPDRjEVRTKHm5ku4kBphloBAuqOOjqdtzmLhhc9xnKTQv0pi
         jlJSQ52OPHvdDFOaEQxegu8Ob1rOcEwCdWtyJ7UEdGh2b+OQP/vJHjZCOLyxcEJ3WRpS
         x8Jon9u8zdd/5onBxvZdddHQlvy2o72wEfO0BHbqn/VOszVFfXxQVNLIZcn+rHKxUEX/
         K3wYZ0B+/JSEVsukndrAbXL4XhF2Asm3SIxaKOqs6aAk0KXa4b/1i21jqiRCBr/vSIAQ
         HqrNFq89lqYcJxLRjDsCHCovJShlJ0fiqnpSsRx/NGvPd4c3mnox1MaR4ybD8k1Ua57m
         QLeg==
X-Forwarded-Encrypted: i=1; AJvYcCWGorgzCKdgSgRIcZ2EG7gZl5moGn36PrkjloHuYqyCxte2voXP5LWrwuPwxY8nMbVsU47HM52DTJAU5Mxea1RBcPjEVJX3V9nDNcyB+bTxySWOuJIYJw7uir5nC97eIYQerpzEfx0m3cjXoQrp+gvavTMWuBGuoHI3IMO8N+U4kUHgG2h78cffUtxcuAOVQ9D9RwGz2OatLZ0XMWzMpiLTBDcgQq9sGU3HHntUtr+lpXbFoDIH15KkLXi+f+cVLvQGsAP5MLb/kweCFYzGY87ZX2/hTQpUxcM9bVhCc29GZjBBVHwtEypfOUmLlJ23Qch7OiFHYhuDEyGTEtZIyLY7Wqg0YE494sOc9B1hOV1u2Hh8km1Tx8btMu7aflzhgVRbryYadtvnjaEM2KRBW3YD/Z0fSfm5bda1mKbztTCCF7MddWa0a2yFY6TC80zuJtSecTjqag6hBNXhKdPFFKX7/Ia4npXBYGcWKHPgzJU1pzyepJh8JuVYfbC2iOl+84z+i/BySg==
X-Gm-Message-State: AOJu0YzJZxEXgcZ+2Jn/jkW/HEcbDsfYPa4mw7LxZ5fhkrIVdPSXSS/E
	JzVWn7HGO5208uIFFki1B3beEZE7GB92C2qmr/Vav4MyIHyKz+ex
X-Google-Smtp-Source: AGHT+IHNLBWp/XVpBOD9TpyXIo6UVwaGICDFe79d2rsv63T1VIQg3s8h/O/cdVr7crD9nPvkteKRtg==
X-Received: by 2002:a17:906:398:b0:a66:414c:2abf with SMTP id a640c23a62f3a-a6cd60a189emr204889166b.26.1717775215622;
        Fri, 07 Jun 2024 08:46:55 -0700 (PDT)
Received: from [192.168.42.206] ([163.114.131.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c806eb099sm263561666b.102.2024.06.07.08.46.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 08:46:55 -0700 (PDT)
Message-ID: <a8df4459-30bf-4414-aeca-2f67c461adc4@gmail.com>
Date: Fri, 7 Jun 2024 16:46:57 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 02/14] net: page_pool: create hooks for
 custom page providers
From: Pavel Begunkov <asml.silence@gmail.com>
To: David Ahern <dsahern@kernel.org>, Mina Almasry <almasrymina@google.com>
Cc: Christoph Hellwig <hch@infradead.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
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
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>,
 Yunsheng Lin <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst
 <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>
References: <20240530201616.1316526-1-almasrymina@google.com>
 <20240530201616.1316526-3-almasrymina@google.com>
 <ZlqzER_ufrhlB28v@infradead.org>
 <CAHS8izMU_nMEr04J9kXiX6rJqK4nQKA+W-enKLhNxvK7=H2pgA@mail.gmail.com>
 <5aee4bba-ca65-443c-bd78-e5599b814a13@gmail.com>
 <CAHS8izNmT_NzgCu1pY1RKgJh+kP2rCL_90Gqau2Pkd3-48Q1_w@mail.gmail.com>
 <eb237e6e-3626-4435-8af5-11ed3931b0ac@gmail.com>
 <be2d140f-db0f-4d15-967c-972ea6586b5c@kernel.org>
 <8f44ca2a-8910-418f-b4a6-ca1e051484ba@gmail.com>
Content-Language: en-US
In-Reply-To: <8f44ca2a-8910-418f-b4a6-ca1e051484ba@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/7/24 16:42, Pavel Begunkov wrote:
> On 6/7/24 15:27, David Ahern wrote:
>> On 6/7/24 7:42 AM, Pavel Begunkov wrote:
>>> I haven't seen any arguments against from the (net) maintainers so
>>> far. Nor I see any objection against callbacks from them (considering
>>> that either option adds an if).
>>
>> I have said before I do not understand why the dmabuf paradigm is not
>> sufficient for both device memory and host memory. A less than ideal
>> control path to put hostmem in a dmabuf wrapper vs extra checks and
>> changes in the datapath. The former should always be preferred.
> 
> If we're talking about types of memory specifically, I'm not strictly
> against wrapping into dmabuf in kernel, but that just doesn't give
> anything.

And the reason I don't have too strong of an opinion on that is
mainly because it's just setup/cleanup path.

> But the main reason for allocations there is the difference in
> approaches to the api. With io_uring the allocation callback is
> responsible for getting buffers back from the user (via a shared
> ring). No locking for the ring, and buffers are already in the
> context (napi) where they would be consumed from. Removes some
> headaches for the user (like batching before returning buffers),
> and should go better with smaller buffers and such.
> 
>> I also do not understand why the ifq cache 
> 
> I'm not sure what you mean by ifq cache. Can you elaborate?
> 
>> and overloading xdp functions
> 
> Assuming it's about setup via xdp, it was marked for remaking in
> RFCs for longer than desired but it's gone now in our tree (but
> maybe not in the latest series).
> 
>> have stuck around; I always thought both were added by Jonathan to
>> simplify kernel ports during early POC days.
> 

-- 
Pavel Begunkov

