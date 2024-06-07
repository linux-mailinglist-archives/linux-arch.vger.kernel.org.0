Return-Path: <linux-arch+bounces-4748-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 064DE900560
	for <lists+linux-arch@lfdr.de>; Fri,  7 Jun 2024 15:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97ACB28C370
	for <lists+linux-arch@lfdr.de>; Fri,  7 Jun 2024 13:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADCF194AC7;
	Fri,  7 Jun 2024 13:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOc6YHPj"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301EFDDA3;
	Fri,  7 Jun 2024 13:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717767956; cv=none; b=EpQwOt2btgxW2d51hqHBqA8w63EASkQ7ifkf/RLY1SlkVfdyC87+q/z1pWFjOk/CupEBl1lx8tSsgSDEAGGRoVYaoHYIixWfCUlxPwSwT6xryS0ypZGGbnF7Bg8uC1YZitUZUa24K1Mg4peAWlTktNT/Zcz4kyWuy711SDovxXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717767956; c=relaxed/simple;
	bh=F8fSHuVPu9oovEd3fXldo8wtdCaVHB0Pd8MF0o9QeIs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e863ZhSiPEQcs5r5jFFfD7O7Cz1jTs0N2gyNaEJCT/IowVrUv1/1Tqfi0loARFmO/6LmPXjHmxbWJpIzQrU1ifqGN6f72qC3GmEJUVJ1IS3WotMDGAjf4kCKXG/yLgtjcO3goDmnCIL0+xLgqcDAVpaJQra/RERqOCn/LmgSXbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gOc6YHPj; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-578517c7ae9so2420479a12.3;
        Fri, 07 Jun 2024 06:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717767953; x=1718372753; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F/r/t9G5Ibm8rqPv9khaLM6u/j/EOl3KKmdgoUFwllc=;
        b=gOc6YHPjNaJMFISiYLXeURTbWReLuE+WlZJvHtrNfXLwlRrSLiao0qSR6nZjlLxyDy
         qWcWuQR4lYbf2Z+x3qhUilK3aW+64x4q992civc09z2n5XJQsyDLOWsqPIy3o/juiJLS
         pLHl4QOuxbAJuCPNpHAozwplUHLsMD6kKqzjQPQ2GObK/krAj+cKhcn+sipgMR4pvQJv
         06R8Vo6QUEN+nlry/sCg7cWUlwv4jfLKW+OqBFGrN/bpfK9FSuJ+HfXGiprMeg1VnhDf
         xn+grXeRIdjps92aFbACoolgei9k5RiU9TLtXWBVkig4XguIuvQtV4M3LvBWI9NCBuXs
         Bokw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717767953; x=1718372753;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F/r/t9G5Ibm8rqPv9khaLM6u/j/EOl3KKmdgoUFwllc=;
        b=aevlbsprYcrv3Y9uatHnVkgpjyaIVYZGreafpiWBErI/nHDyqWCAmaM8IIQRdC/ZsU
         MXGfeLU4i5kSe8eGxRAh6SQ8WTxbJyCQA2vISTF2R0Kpr5wIwalj6z/ZVdVW0V2MSgxo
         Iw5rJTcUD+3WcCEtq41E7HU/w9ZVoTjxTmwDZUJAPoBPcWwaquABsb1LsRqDAj0/z/DV
         fGSO1OUgAyBosG0n82ReDUUZCYnv+jgBeprPyQO70oEBuUczLI9F6ucgAozHA/VuwvDU
         WWSP2dM4OUb7jhWSLxbFPJVJ/cv/ehDMFP4j99QHl2MSnMnmeEwL5LQCerZ0WIeSwZNm
         I+8g==
X-Forwarded-Encrypted: i=1; AJvYcCWpJIKq+5W/yW5+11vRxaBd2fG9sDY+G3JiCt4v8T/R4NFwaN3iyLLT4lR3YJ3r1Un5YNvplz8vvzh1otYiUbuxW6Wg3RzT0zLy8QzOvHBJiR1/CtDOiwiBgkCkDGxRbYKrOTh/26/WHhR7ca0/YO/kcgXo3yVLyp19fyDpeCKxZiKFC6Jlz78+SXBAWiNmDBUjEcDyNaWHZHbsjM5Nz8ZaTNUUwi5PTB5Sd7EQv1/xxbjDDxWS2Bt1AJo9mjLFg27PneRXqq2oTN5lEE3m/OcTvPo9IDRdL26A2drMJTAFwG1WDlCTASvGmtgyFZyPbJAdmObbd4goLZWaDhrpH/EMBgx00MOw5G1Q70o33b778a+4Oh6U4YsIQzsZAa9id1hR7Vc1b09osWtlZHitU9aOjPajZXikOMd3rA/rmHa4Vanh5igwDP+yZ9exbaI0LJAYuM3axaIt7V4yHSkNRn4re8IJkkR2Fy4fM05VkhpO67F+7PY+JtMFr2rWK9ty6pEhNO44+w==
X-Gm-Message-State: AOJu0YwFLZUAlh3XLlV/m7Q7f7u0j1/Ba8MQ6jwExFfVl2+cRXgYd2ew
	CAOAwf0qcxCxnuSfMiXI0S9sc1zRar8ezi+48g7QhvPCBfPuHNqy
X-Google-Smtp-Source: AGHT+IFVOACJ8jhSl4BQSkTV7VPNec/iQ97B361R1DBH0V33lAwuXw0dKze57MI6+rDcTkZyQ3kqqw==
X-Received: by 2002:a50:bac6:0:b0:57a:4c22:bd with SMTP id 4fb4d7f45d1cf-57c508292e9mr1554431a12.7.1717767953444;
        Fri, 07 Jun 2024 06:45:53 -0700 (PDT)
Received: from [192.168.42.51] ([163.114.131.193])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae1412absm2766177a12.57.2024.06.07.06.45.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 06:45:53 -0700 (PDT)
Message-ID: <ee9a55cd-7541-4865-ab2a-9e860b88c9e4@gmail.com>
Date: Fri, 7 Jun 2024 14:45:55 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 02/14] net: page_pool: create hooks for
 custom page providers
To: Christoph Hellwig <hch@infradead.org>
Cc: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
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
 David Ahern <dsahern@kernel.org>,
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
 <ZmAgszZpSrcdHtyl@infradead.org>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <ZmAgszZpSrcdHtyl@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/5/24 09:24, Christoph Hellwig wrote:
> On Mon, Jun 03, 2024 at 03:52:32PM +0100, Pavel Begunkov wrote:
>> The question for Christoph is what exactly is the objection here? Why we
>> would not be using well defined ops when we know there will be more
>> users?
> 
> The point is that there should be no more users.  If you need another

Does that "No more" stops after devmem tcp? Or after io_uring
proposal? For the latter I explained why io_uring has to do it
for good design and that's it's not even related to the memory
type used.

> case you are doing something very wrong.

That's not a very illuminating answer

-- 
Pavel Begunkov

