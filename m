Return-Path: <linux-arch+bounces-1024-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 191B381245C
	for <lists+linux-arch@lfdr.de>; Thu, 14 Dec 2023 02:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93E4CB20E4C
	for <lists+linux-arch@lfdr.de>; Thu, 14 Dec 2023 01:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E651563D;
	Thu, 14 Dec 2023 01:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ot/Mr1P8"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9B7EA3;
	Thu, 14 Dec 2023 01:15:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26BC1C433C7;
	Thu, 14 Dec 2023 01:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702516540;
	bh=t0rU34tq8DhzkLBkFxn7ambC0hASa1O0GjSgzQkryC8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ot/Mr1P8szCrNFm0hJ5f4gZjqkAYiPwfrzCNxDCw9eE3Tj8W7JjdlpUDBDsgugHu/
	 byFf0jmPC0QT6DYooDZBa7TFhilvS5PqbAxbeveAlzb6IskUdxsdU0qbnALISkxT3E
	 8LaENIaxborpvBH4Xq6FmVOJ2TqiIIiXx2b45387wfpu6oDF+1d0YaVbkAQ4V9YnY8
	 JbXgZWzOAf/iAWSoUZw7b6BOBgUV1h4M7EHkiteQthq74DtjeXUr9DjH5DA8Kd8vgN
	 3hk5WYLKXg9U3ZPPHHf8m2W4H1ZGik9cIDED+aV//wHrF2u7hBFmTsUASIc9VgVjBj
	 l540ij+i/09FA==
Date: Wed, 13 Dec 2023 17:15:38 -0800
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
 <shakeelb@google.com>
Subject: Re: [net-next v1 03/16] queue_api: define queue api
Message-ID: <20231213171538.04847459@kernel.org>
In-Reply-To: <20231208005250.2910004-4-almasrymina@google.com>
References: <20231208005250.2910004-1-almasrymina@google.com>
	<20231208005250.2910004-4-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  7 Dec 2023 16:52:34 -0800 Mina Almasry wrote:
> This API enables the net stack to reset the queues used for devmem.

Nice, thanks for moving this forward. FWIW when I started hacking on it
the API looked more like:
https://github.com/kuba-moo/linux/commit/7af8abfa4fdff248e21fc76aecc334004a0f322f
which passes the config objects to the queue callbacks as an argument.
Storing in struct netdev_rx_queue makes implementing prepare / swap
harder. But that's just FYI, we can refactor later. The queue config
rabbit hole is pretty deep.

