Return-Path: <linux-arch+bounces-79-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD467E5A27
	for <lists+linux-arch@lfdr.de>; Wed,  8 Nov 2023 16:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 614F628136F
	for <lists+linux-arch@lfdr.de>; Wed,  8 Nov 2023 15:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F3530348;
	Wed,  8 Nov 2023 15:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cgRIo7tF"
X-Original-To: linux-arch@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EEA4C6A;
	Wed,  8 Nov 2023 15:36:06 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD541FD6;
	Wed,  8 Nov 2023 07:36:05 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-4083f613272so59686965e9.1;
        Wed, 08 Nov 2023 07:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699457764; x=1700062564; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LPt/CJC1g4tSFhf5KGS0Ry+DiQk0RfMMoZGIrEp0lNY=;
        b=cgRIo7tFRG51UgAn5hZTT7RzajjyoIuwVkr6SD3Z1Am7HYjnO4rDsIBAoBOQjH4geI
         owMAbU06GvQNwW6L2hUEZ6bnD1idnPdMsr7GLI79cynDGcFKg0oOR93+neMjxoAlaeqi
         Dxj3OCcMjde2I5yWdZ4LqeB7ZtGbIiFrzMu6byJRExBX8wQSWyM9M5hCH0ymZ33+bH/A
         /GqRlYy+iuTdWg9lFEqmBa5zHH2VfuvG8cFcBvKqF7Cs/fNc8/tO21cNpwRAXy3aI3Gi
         qwuPdgT5bn+ZylXocXJUOoAOjDPAZ37cp3IbIrIN0y72MWDXnBNCJtXAKgZAaAgoSWfF
         Ddvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699457764; x=1700062564;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LPt/CJC1g4tSFhf5KGS0Ry+DiQk0RfMMoZGIrEp0lNY=;
        b=rp/DJR0UW9ZSIC4nMkYGgfYm7L36EIWU10QkSod5xdvXBeZ3Sd32mlneDBGrJUWcZX
         0+3XfXOXhlOj0AUd5+VSfvmZLMAuGaR/tszj0lnBVIe8Sv3+nX0CkRZLoUnmtTlKWnfN
         dLNJiFO6pPq7H6jYl+hhtv+wV0Zrzyxv2njIv1LZCXEtwhIFTl0Tj1BdhIUOfDzN5QRC
         THFv+skR2Fsbws8wW282kq2geBDihhkSSBT/MSBUXtP1BPUEk3csDPoEloq8qBtoFuTX
         qoBXCt4hgXQldL+IFPCCPlH5oTkcKWyvCbTrJkdBhvvcfZXlu+zdJK34PfgX7b6pEl4L
         ljwA==
X-Gm-Message-State: AOJu0YxRM1X4ZKli9Yryg2xop4OqJcifnrmjPIzH71bxsIEZp+oQf88v
	d0p+Duby3gNEYm4qw6nnpOg=
X-Google-Smtp-Source: AGHT+IF6+XqFcBsSe+xR2tBlGaQkYvldRjjMgYC5UQUH7LHHSh48/KBJVp9rOPyfhw3iYoFPLS35kA==
X-Received: by 2002:a05:600c:1c92:b0:405:1bbd:aa9c with SMTP id k18-20020a05600c1c9200b004051bbdaa9cmr2058164wms.34.1699457763824;
        Wed, 08 Nov 2023 07:36:03 -0800 (PST)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id v6-20020a05600c444600b0040651505684sm19790325wmn.29.2023.11.08.07.36.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Nov 2023 07:36:03 -0800 (PST)
Subject: Re: [RFC PATCH v3 10/12] tcp: RX path for devmem TCP
To: Stanislav Fomichev <sdf@google.com>, Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Arnd Bergmann
 <arnd@arndb.de>, David Ahern <dsahern@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Shakeel Butt <shakeelb@google.com>, Jeroen de Borst <jeroendb@google.com>,
 Praveen Kaligineedi <pkaligineedi@google.com>,
 Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
References: <20231106024413.2801438-1-almasrymina@google.com>
 <20231106024413.2801438-11-almasrymina@google.com>
 <ZUk0FGuJ28s1d9OX@google.com>
 <CAHS8izNFv7r6vqYR_TYqcCuDO61F+nnNMhsSu=DrYWSr3sVgrA@mail.gmail.com>
 <ZUlYB99GK1Q8is-I@google.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <08a6e65a-92fb-4a94-2627-6c03e65f2509@gmail.com>
Date: Wed, 8 Nov 2023 15:36:01 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZUlYB99GK1Q8is-I@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 06/11/2023 21:17, Stanislav Fomichev wrote:
> I guess I'm just wondering whether other people have any suggestions
> here. Not sure Jonathan's way was better, but we fundamentally
> have two queues between the kernel and the userspace:
> - userspace receiving tokens (recvmsg + magical flag)
> - userspace refilling tokens (setsockopt + magical flag)
> 
> So having some kind of shared memory producer-consumer queue feels natural.
> And using 'classic' socket api here feels like a stretch, idk.

Do 'refilled tokens' (returned memory areas) get used for anything other
 than subsequent RX?  If not then surely the way to return a memory area
 in an io_uring idiom is just to post a new read sqe ('RX descriptor')
 pointing into it, rather than explicitly returning it with setsockopt.
(Being async means you can post lots of these, unlike recvmsg(), so you
 don't need any kernel management to keep the RX queue filled; it can
 just be all handled by the userland thus simplifying APIs overall.)
Or I'm misunderstanding something?

-e

