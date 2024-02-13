Return-Path: <linux-arch+bounces-2297-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5AC8531DF
	for <lists+linux-arch@lfdr.de>; Tue, 13 Feb 2024 14:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 909E81F21B1B
	for <lists+linux-arch@lfdr.de>; Tue, 13 Feb 2024 13:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A8B55C3D;
	Tue, 13 Feb 2024 13:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XeAEiydN"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8347D5577C;
	Tue, 13 Feb 2024 13:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707830892; cv=none; b=mM/pD+GVtpov7ewDQPkAFSOBxy7792hYN97dC2M5aRNk2T/ORpTMThquUsL7OoiiOCghW+oRQReqqKvuWsjAfMuGcaSNaUf7HXW8a+yxnGlfJMdtaeSxk7hmC1QNdKojR10UwmP2r2h+oh2I2+yJQXm1A5A/ftWG6vY55uQRK70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707830892; c=relaxed/simple;
	bh=xlX7eJpOuRW8XNNx2jYQwx1E+t05RQkVTbVXEFZi7HM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XpZMaOHMUTdF4Di8sh6o5wcGq5LtE+LeZwF6CsLLCpzazTtDQdGxbOd30WxnVYA7CLGWq9qXXlf+dQ7txvlVsP975Tc5dBMFeQJiWU4XGLNpHkxXZRrLEoyVhmhgJf9K1rZ/DEXroprvz5EQmNboQQQyvu5/rcjt/1XQZk/q47E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XeAEiydN; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a3ce9a33fd8so160682266b.1;
        Tue, 13 Feb 2024 05:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707830889; x=1708435689; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bQyaqxJy1nfKXAe6J9hJAFrL9Ej9vgsdqL3dR2vxAQQ=;
        b=XeAEiydNcvuNz64a1YEXOfwWpspb+GMESCBvgSEk5e+jGTRLbtskO5o87BsxN9Xhg8
         Om/KB3jDg7MAH+WQ928D62xNHFSx9x7b4VpOPfTwLb6t5t+Jt8GgfVX4yVpZBkOt2+v+
         1O3gUetYpyzcUemj00dkKsALcgpYlHxHkkblJ6vLMKtwCyedNyy6BeG1JJTph2F47r/F
         7vWz6l685ylxJG0yYXnUyOLHgBJw9W5izi3xb2A84qTrUav3ihQQEf4HfK+3kwXA4ZG/
         8Z6JIRDfFnTZMwkPaexazyUa+C7gziBjJHjgh68U5qeryqzstVZbkWObR8PwMKRdgMBr
         y+gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707830889; x=1708435689;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bQyaqxJy1nfKXAe6J9hJAFrL9Ej9vgsdqL3dR2vxAQQ=;
        b=fI/WWQcyjeCGxK9vBrrLGYLS/dLziqUFlsJpVvLF6G31mHQc3ZfH4YZDtyGA6YDtVJ
         8okMIOs7ftlFL3AH/TE8bkXlICZLDvLcG/tcDHLV+hPuulxb/77JuA5NN5oXob2IehLx
         jkJRWr1bUkDjES+EW4ftGB4f0yP3jNpXzIey4lJo8vB/L49TjaW7bt2iwnwuxLiy1obj
         wJMJzr1jLwr+uF1hJD9W8WcMN9jqz+cWBiIeotprus9I0q78wJdfPy2F2azr1PY3N+yk
         vIQ+1FTM1Os6dncrbCWbPpp5JnbvcmMc1b9vEeHsGyJ0x7zlQ9d4A76MdRNvUN0iKkRM
         KH+w==
X-Forwarded-Encrypted: i=1; AJvYcCU4+F6i1bn8O6BL8xpG2vB8jIv1SDrs2UrOkAhcJdRCBx9aUALCY9/O2xgC0R6iycR5FogOck1cgUcfBFpYKUwvs1LBUCAbFXpTFIZcQeMbZXWF1RyP+tyuIlr0bSP6rTxSr3dTcxTuY43JPNOAHHLGaZ5TkSvtMdcrXpHCFa9YRXSQJpFRUQoU+m2Sdw91bbNTOCcWGXAQLx7FGeqNPsHvv+24zquybe/a2lh2HdgeuGpPmeKebV6lPnylKD6VCVgXiBc9b9H1Cy1MUPGtLBT7YhS5zP8/9FH+KinPVoX97D9Sswnr+bzo0qXwEJnJOsrhiuXkZ0wWzD++VCx/C6r3VZ9zD9A1wFcrAMV79x+rm3RmNZpoBZcsb7Lz0QNqK9DkV130AXwISIkBq7llMmZBH0kMyqAq/Wu1pS9xcNfDrfr0LMvtwo4Qf9KJDTIXlB95YMDfMOeWTq3N+pQzg6cnUIzTh4jT3tdajMiZf7eqdDFxduN1i0n7A3ygb1yEsVQFr746dg==
X-Gm-Message-State: AOJu0Yw+J7a9GBg0Wj4GS1cGd35BZzY26+ZrPf8myrKIYqkz2Wny0cc3
	VzYb/4tKYrD2/haPqzYPoUUQ8VLxuvUO8zc+qTR9aO5x7fWhVXvF
X-Google-Smtp-Source: AGHT+IGJ/LRBbhCkmFF1FZhsmU9LStqmNAiKYbjKV2sMZZSoc8TNitG6D+S4uiV/cNZktq7MOkKBjQ==
X-Received: by 2002:a17:906:f0d3:b0:a3c:8de7:3add with SMTP id dk19-20020a170906f0d300b00a3c8de73addmr1945447ejb.7.1707830888465;
        Tue, 13 Feb 2024 05:28:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUomhMmji3Wcaq3gX1zwDkRJbw3mKjIMJWfFoj6s2TsVLnWgjcOYJOwy3c8Az9k7RQK1HB6cNTgWD2ScWfiUSy8FcX6rFbkdbawkPLzON8gVmDpU+kJeCFpb7d+LReQJEELjYVUoPym0/FTFAlUHWHUZPOpyLsM6emJ1v8OMji316K3yxHWRMSm7r7hpRasJ982HDCLsQ9ab5h8qLQ2JU+qwp85MZ6CP6ta9OTV4OKm22dgiPHNiznAmnXhykiNpROyoNuzoAWkSG+dBzby2BmWPK5xfs8BnQ48ojyDkaQ+tTCO8IUDTPnNux+PgYFL5Sx6ZOe3S5pORnsEoQGgqZwhfZHEYYmzPjakVylDapH63YwYwQ2KvyfF6IyxlGc9UKOGrNYEYaIPQYMTLJSFKHwk/Eb7bQuOqK0iyxXXk2TScfdk6aEtzSqePvkwkIWpK9U6IQL8HAq5p8D611Rt42ZwlkFXWqJ25LWh7TAb+d4Se3ruWAsFmSPNTT3j7pcaSyESeKhr5v39SQJ38ZSUITKX4J44PdLb6+/MAODd2yaH7b9SocWnTy568eer7cmD8LIy6+s2IQ73YIcasUcE/8gSaM86qpEOzkOL7Wil4rult1Vkrjl1UTs159H5geSa1l8gt/4Az7/bQ7G5/dBMdA3/FhEa55iSbdY2y+fqleX47HlNDetQKBgTor2LtviAkBoc1+QWETlu/T1nMMg8dfkQbFOfpODQ6xWf5feG0iIytoqtb0hmvVMMVALbAK+dAgLeS/DG+s2wYDWPbHiKbPlPwIZ4wUWjgRZvwqZiXQp78cm94zJ8xnRo5gNE6Ybde2E9C8Xr+6FjUHQ12tyX5WMfwUlrLky7w7VYKdqlWMziNdHe8CKIaiznK9q+7z3re8Q0HetxXHAmDsTDKD9Nc9Kq7M1JvFmMOvZlxF3It+Dz3NGc1MM9DrC6rG7rPGtVD2sCVv
 sOyC+cE8jaQoacp45ByqC6b7p1YKSNwYsZn8cMre1hgLZXeOqPGjWwY+j4c1ga/sCO1FyDke4xWD/J6xodIJn0StiN83aOyBW60vYQA5qB/vs/z7wUfSFw5Q4du/k5zLE+R1lQcOVM24zmm8ES7y6aU3XKMte9UdTFB0AhUpnYaqxOkf5TXdOWX31g0lswZJ/53RoaEvWuuyucoCgEZAet+Bpb8Zrh9rTfuTT0PqlkLU48/zQ4tUXcIY7QU8WRNQHvvLGVpP0fXpaIyNGq5G4a7z3XTWIOIkDYEIMN8uSWpjN/c/BUrEXK7RRXEeWM9ZtSg4Rrk2SHWOjL2zrjsvUgo9rQRHwqnScq7Xc2xLTNp9Da/yQTq+bzXKqdsIiRcL2WSS+m1l8BOe2Di/MQA5mqG5MW8eTAny2f2cU98QWVc9wavxZU92JImvu7a2BJe3m396dKesG8uzsHjvjDGbJYQ1kvLi5Ztl3lBqGfTxckzLOI8L1mJll9LjkdvVAxu3aUMijUpdPfDdogbm99UJ5b4O6v735vRHi/Z/CryHTevxeX8/eXMyl5R2maJxukqiUzisNtBrofJhQZ4goBQG+8Z2kFqNbMEKltY0WwRCmnyxU4Hsvyh/kUbqY5yDYhYXLP1+G+ukl33yxz6oT8Bc/i+WTIOkVMo2ykHe8nSS2bpwJMI32u/GXcx57lhXNLwPYkrgOrFaQBgz0ZPcx77kEYv3VlZ6uV88nUw/C8i2WNB+afV0Gsncui85+8FA==
Received: from ?IPV6:2620:10d:c096:310::23d8? ([2620:10d:c092:600::1:a107])
        by smtp.gmail.com with ESMTPSA id ss3-20020a170907c00300b00a3d1c0a3d5dsm221682ejc.63.2024.02.13.05.28.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 05:28:08 -0800 (PST)
Message-ID: <3374356e-5f4b-4a6f-bb19-8cb7c56103bc@gmail.com>
Date: Tue, 13 Feb 2024 13:18:26 +0000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v5 07/14] page_pool: devmem support
Content-Language: en-US
To: Mina Almasry <almasrymina@google.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
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
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner
 <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
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
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20231218024024.3516870-8-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/18/23 02:40, Mina Almasry wrote:
> Convert netmem to be a union of struct page and struct netmem. Overload
> the LSB of struct netmem* to indicate that it's a net_iov, otherwise
> it's a page.
> 
> Currently these entries in struct page are rented by the page_pool and
> used exclusively by the net stack:
> 
> struct {
> 	unsigned long pp_magic;
> 	struct page_pool *pp;
> 	unsigned long _pp_mapping_pad;
> 	unsigned long dma_addr;
> 	atomic_long_t pp_ref_count;
> };
> 
> Mirror these (and only these) entries into struct net_iov and implement
> netmem helpers that can access these common fields regardless of
> whether the underlying type is page or net_iov.
> Implement checks for net_iov in netmem helpers which delegate to mm
> APIs, to ensure net_iov are never passed to the mm stack.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> 
> ---
> 
> RFCv5:
> - Use netmem instead of page* with LSB set.
> - Use pp_ref_count for refcounting net_iov.
> - Removed many of the custom checks for netmem.
> 
> v1:
> - Disable fragmentation support for iov properly.
> - fix napi_pp_put_page() path (Yunsheng).
> - Use pp_frag_count for devmem refcounting.
> 
> ---
>   include/net/netmem.h            | 145 ++++++++++++++++++++++++++++++--
>   include/net/page_pool/helpers.h |  25 +++---
>   net/core/page_pool.c            |  26 +++---
>   net/core/skbuff.c               |   9 +-
>   4 files changed, 164 insertions(+), 41 deletions(-)
> 
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index 31f338f19da0..7557aecc0f78 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -12,11 +12,47 @@
>   
>   /* net_iov */
>   
> +DECLARE_STATIC_KEY_FALSE(page_pool_mem_providers);
> +
> +/*  We overload the LSB of the struct page pointer to indicate whether it's
> + *  a page or net_iov.
> + */
> +#define NET_IOV 0x01UL
> +
>   struct net_iov {
> +	unsigned long __unused_padding;
> +	unsigned long pp_magic;
> +	struct page_pool *pp;
>   	struct dmabuf_genpool_chunk_owner *owner;
>   	unsigned long dma_addr;
> +	atomic_long_t pp_ref_count;
>   };

I wonder if it would be better to extract a common sub-struct
used in struct page, struct_group_tagged can help to avoid
touching old code:

struct page {
	unsigned long flags;
	union {
		...
		struct_group_tagged(<struct_name>, ...,
			/**
			 * @pp_magic: magic value to avoid recycling non
			 * page_pool allocated pages.
			 */
			unsigned long pp_magic;
			struct page_pool *pp;
			unsigned long _pp_mapping_pad;
			unsigned long dma_addr;
			atomic_long_t pp_ref_count;
		);
	};
}

struct net_iov {
	unsigned long pad;
	struct <struct_name> p;
};


A bit of a churn with the padding and nesting net_iov but looks
sturdier. No duplication, and you can just check positions of the
structure instead of per-field NET_IOV_ASSERT_OFFSET, which you
have to not forget to update e.g. when adding a new field. Also,
with the change __netmem_clear_lsb can return a pointer to that
structure, casting struct net_iov when it's a page is a bit iffy.

And the next question would be whether it'd be a good idea to encode
iov vs page not by setting a bit but via one of the fields in the
structure, maybe pp_magic.

With that said I'm a bit concerned about the net_iov size. If each
represents 4096 bytes and you're registering 10MB, then you need
30 pages worth of memory just for the iov array. Makes kvmalloc
a must even for relatively small sizes.

And the final bit, I don't believe the overlay is necessary in
this series. Optimisations are great, but this one is a bit more on
the controversial side. Unless I missed something and it does make
things easier, it might make sense to do it separately later.


> +/* These fields in struct page are used by the page_pool and net stack:
> + *
> + *	struct {
> + *		unsigned long pp_magic;
> + *		struct page_pool *pp;
> + *		unsigned long _pp_mapping_pad;
> + *		unsigned long dma_addr;
> + *		atomic_long_t pp_ref_count;
> + *	};
> + *
> + * We mirror the page_pool fields here so the page_pool can access these fields
> + * without worrying whether the underlying fields belong to a page or net_iov.
> + *
> + * The non-net stack fields of struct page are private to the mm stack and must
> + * never be mirrored to net_iov.
> + */
> +#define NET_IOV_ASSERT_OFFSET(pg, iov)             \
> +	static_assert(offsetof(struct page, pg) == \
> +		      offsetof(struct net_iov, iov))
> +NET_IOV_ASSERT_OFFSET(pp_magic, pp_magic);
> +NET_IOV_ASSERT_OFFSET(pp, pp);
> +NET_IOV_ASSERT_OFFSET(dma_addr, dma_addr);
> +NET_IOV_ASSERT_OFFSET(pp_ref_count, pp_ref_count);
> +#undef NET_IOV_ASSERT_OFFSET
> +
>   static inline struct dmabuf_genpool_chunk_owner *
>   net_iov_owner(const struct net_iov *niov)
>   {
> @@ -47,19 +83,25 @@ net_iov_binding(const struct net_iov *niov)
>   struct netmem {
>   	union {
>   		struct page page;
> -
> -		/* Stub to prevent compiler implicitly converting from page*
> -		 * to netmem_t* and vice versa.
> -		 *
> -		 * Other memory type(s) net stack would like to support
> -		 * can be added to this union.
> -		 */
> -		void *addr;
> +		struct net_iov niov;
>   	};
>   };
>   
...

-- 
Pavel Begunkov

