Return-Path: <linux-arch+bounces-928-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BE880F64F
	for <lists+linux-arch@lfdr.de>; Tue, 12 Dec 2023 20:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C0371F2181C
	for <lists+linux-arch@lfdr.de>; Tue, 12 Dec 2023 19:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18AD181E2E;
	Tue, 12 Dec 2023 19:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u9gl44nT"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4A280059;
	Tue, 12 Dec 2023 19:14:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B19FC433C7;
	Tue, 12 Dec 2023 19:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702408452;
	bh=jfJ0OG1jhC1TwOyrhyKpWYMGrNHXhy6qAspQp8BrzWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u9gl44nTCJgaqnzRkDIohjT3NlWPJJa/xDes26AfFQfmtNc2cfCuCd70WURIpsEls
	 vTZdu0MOZxt7XB2RoDt3NiKq0uZ0e5XZ9uNAJvt20SeYNL3Xnev1VOWhSDgT1cLHKO
	 UzAbw2cpbggtF8AKB+xIzHnQW+N3E8y0VN03Sx8xuf6xSXbWBlqTx0DkvlJGiyTCHv
	 Pn9XBi+4REFO/1aggIX1ADNZxAcOPZjzUtdYPvmGKd9kwXCW92/oirZULVxo77Eat3
	 6uRKCSS5S1kMdmbIvOp4MFWEThbL6iJKtUsHbQc5uHQLX7S+inbhcpAYL5tX1R7y0R
	 68pLVmdZZ2tDg==
Date: Tue, 12 Dec 2023 19:14:04 +0000
From: Simon Horman <horms@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: Shailend Chand <shailend@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Jeroen de Borst <jeroendb@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>, David Ahern <dsahern@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Shakeel Butt <shakeelb@google.com>
Subject: Re: [net-next v1 15/16] net: add devmem TCP documentation
Message-ID: <20231212191404.GC5817@kernel.org>
References: <20231208005250.2910004-1-almasrymina@google.com>
 <20231208005250.2910004-16-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208005250.2910004-16-almasrymina@google.com>

On Thu, Dec 07, 2023 at 04:52:46PM -0800, Mina Almasry wrote:
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> ---
>  Documentation/networking/devmem.rst | 270 ++++++++++++++++++++++++++++
>  1 file changed, 270 insertions(+)
>  create mode 100644 Documentation/networking/devmem.rst
> 
> diff --git a/Documentation/networking/devmem.rst b/Documentation/networking/devmem.rst
> new file mode 100644
> index 000000000000..ed0d9c88b708
> --- /dev/null
> +++ b/Documentation/networking/devmem.rst
> @@ -0,0 +1,270 @@

Hi Mina,

Please consider adding an SPDX header here.

And please consider adding devmem to index.rxt,
as make htmldocs currently warns:

  .../devmem.rst: WARNING: document isn't included in any toctree

....

