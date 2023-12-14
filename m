Return-Path: <linux-arch+bounces-1025-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF19812464
	for <lists+linux-arch@lfdr.de>; Thu, 14 Dec 2023 02:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E56DA282678
	for <lists+linux-arch@lfdr.de>; Thu, 14 Dec 2023 01:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1792E642;
	Thu, 14 Dec 2023 01:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ASB0owDz"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D817963D;
	Thu, 14 Dec 2023 01:17:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 435CAC433C7;
	Thu, 14 Dec 2023 01:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702516677;
	bh=zsaG1Z/V6aX7d8f9bjRUYAcyyvlRqu+OVBtKr82ilo8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ASB0owDzSZAjwNqEaZNw5l/tG4f5H9NX+k9wIaQk8aZXmjNXWFA3xs3z4915D3ydm
	 7Ny7vU+2Z7vaKSVVG1qq8axAQ/MCShUSGffVW9XOEwhE7c/wF53+YRFmoEGCRaSXJV
	 xxx5jmq9TTDBawDFV+xQEVsShfQCo7hbn0fdbEXDcJggTLF+nKeQ0DUI/UxbZMIsOO
	 5BjG5ifdnXPja4ZIyPRc+ST7CoXQVV+Yuqp2Ss/x8LSXqj0MPfatQDbKpgwNw8T3UN
	 XTW5ymxEA+Otu6nrG7yjCGi17kV/e48xzniquq3SrjsO19LqX8qx2v133Y2t3Q722V
	 y4VWpmNMV+zfA==
Date: Wed, 13 Dec 2023 17:17:55 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: Shailend Chand <shailend@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
 bpf@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>, Jeroen de Borst <jeroendb@google.com>,
 Praveen Kaligineedi <pkaligineedi@google.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Arnd
 Bergmann <arnd@arndb.de>, David Ahern <dsahern@kernel.org>, Willem de
 Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, "Christian =?UTF-8?B?S8O2bmln?="
 <christian.koenig@amd.com>, Yunsheng Lin <linyunsheng@huawei.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>, Shakeel Butt
 <shakeelb@google.com>, Stanislav Fomichev <sdf@google.com>
Subject: Re: [net-next v1 05/16] net: netdev netlink api to bind dma-buf to
 a net device
Message-ID: <20231213171755.5965e1ec@kernel.org>
In-Reply-To: <20231208005250.2910004-6-almasrymina@google.com>
References: <20231208005250.2910004-1-almasrymina@google.com>
	<20231208005250.2910004-6-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  7 Dec 2023 16:52:36 -0800 Mina Almasry wrote:
> +        name: type
> +        doc: rx or tx queue
> +        type: u8
> +        enum: queue-type

nit: the queue/napi GET was applied to net-next, would be good to stick
to the same types (s/u8/u32)

