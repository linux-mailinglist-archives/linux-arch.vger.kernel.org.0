Return-Path: <linux-arch+bounces-5234-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE99E925211
	for <lists+linux-arch@lfdr.de>; Wed,  3 Jul 2024 06:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C3FA1F23263
	for <lists+linux-arch@lfdr.de>; Wed,  3 Jul 2024 04:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819EF61FFB;
	Wed,  3 Jul 2024 04:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cUBrMKDu"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332DE61FDF;
	Wed,  3 Jul 2024 04:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719980430; cv=none; b=pT3/PPYOvbk1ScE4GCaM84ERtaVltiqLIRcbVSwoUoDtFmDOGLamR3iT4H23+FcL7/gT8msbDYCPpv/hROEI6ZpBzPF02z1/ilGIva0NJLa/xVgXUoxiNIuC5OE+rmkpQ0FLPqvzqYEQziRI5djJbxeo+svig9QFoCRG84KIQtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719980430; c=relaxed/simple;
	bh=7tQ5DdUsAmsK80QqEziD7LvBBaCh71k7AGhTaH0Y/38=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XunHJAjUCyUkOlD4DrmEugdZyOkMfQI9L0UKfw2qlDMYueLWuwoUVXUsXXof1dGVPpaNnnAi367ufSMqNRs1QlDgfNzeklKuY+PCFTmicEaDS1TC+7RWcMBMdJJU0jGABefsSaVocfDXxtrmfpNxTWCvGQELVmJAItQqsXYaQR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cUBrMKDu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B81C3C4AF0A;
	Wed,  3 Jul 2024 04:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719980429;
	bh=7tQ5DdUsAmsK80QqEziD7LvBBaCh71k7AGhTaH0Y/38=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cUBrMKDudMtKU7fLylCIzX419wYJo1pg5HK6TOjByeXAaK+Iu9MB36YZ/JOwT9btt
	 TW7uzotImCielBB9ZnjBfupBNdVNyd7Or8vKHUkKdIFgGxYzZPQ7dk0qjdjSxwb4Rp
	 F/rMa7aLBslRu+qPTQ8XJDbadjFZxXq4OgWd9JMrq8WJzwiZVFYD/vVvbFwe+xy565
	 Vz+M5IbfIIdgKv/Xn4OTGbQzcrwDFQfWNBk+vfQsUkHdumQ29dKV4EmtbBcNf/dbqG
	 c42fYAdxunJw+w6thOmBVcroXRlFUa5+niTYgcDUeg0q0PWoqoNHEXFH28n9hMe0k2
	 8XqAG78rRlr5w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 945A6C54BB7;
	Wed,  3 Jul 2024 04:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v15 00/14] Device Memory TCP
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171998042959.21654.14959154340779220111.git-patchwork-notify@kernel.org>
Date: Wed, 03 Jul 2024 04:20:29 +0000
References: <20240628003253.1694510-1-almasrymina@google.com>
In-Reply-To: <20240628003253.1694510-1-almasrymina@google.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, donald.hunter@gmail.com, corbet@lwn.net,
 richard.henderson@linaro.org, ink@jurassic.park.msu.ru, mattst88@gmail.com,
 tsbogend@alpha.franken.de, James.Bottomley@HansenPartnership.com,
 deller@gmx.de, andreas@gaisler.com, hawk@kernel.org,
 ilias.apalodimas@linaro.org, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, arnd@arndb.de, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, steffen.klassert@secunet.com,
 herbert@gondor.apana.org.au, dsahern@kernel.org,
 willemdebruijn.kernel@gmail.com, shuah@kernel.org, sumit.semwal@linaro.org,
 christian.koenig@amd.com, bagasdotme@gmail.com, hch@infradead.org,
 razor@blackwall.org, asml.silence@gmail.com, dw@davidwei.uk, jgg@ziepe.ca,
 linyunsheng@huawei.com, shailend@google.com, hramamurthy@google.com,
 shakeel.butt@linux.dev, jeroendb@google.com, pkaligineedi@google.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 28 Jun 2024 00:32:37 +0000 you wrote:
> v15: https://patchwork.kernel.org/project/netdevbpf/list/?series=865481&state=*
> ====
> 
> No material changes in this version, only a fix to linking against
> libynl.a from the last version. Per Jakub's instructions I've pulled one
> of his patches into this series, and now use the new libynl.a correctly,
> I hope.
> 
> [...]

Here is the summary with links:
  - [net-next,v15,01/14] netdev: add netdev_rx_queue_restart()
    (no matching commit)
  - [net-next,v15,02/14] net: netdev netlink api to bind dma-buf to a net device
    (no matching commit)
  - [net-next,v15,03/14] netdev: support binding dma-buf to netdevice
    (no matching commit)
  - [net-next,v15,04/14] netdev: netdevice devmem allocator
    (no matching commit)
  - [net-next,v15,05/14] page_pool: convert to use netmem
    https://git.kernel.org/netdev/net-next/c/4dec64c52e24
  - [net-next,v15,06/14] page_pool: devmem support
    (no matching commit)
  - [net-next,v15,07/14] memory-provider: dmabuf devmem memory provider
    (no matching commit)
  - [net-next,v15,08/14] net: support non paged skb frags
    (no matching commit)
  - [net-next,v15,09/14] net: add support for skbs with unreadable frags
    (no matching commit)
  - [net-next,v15,10/14] tcp: RX path for devmem TCP
    (no matching commit)
  - [net-next,v15,11/14] net: add SO_DEVMEM_DONTNEED setsockopt to release RX frags
    (no matching commit)
  - [net-next,v15,12/14] net: add devmem TCP documentation
    (no matching commit)
  - [net-next,v15,13/14] tools: net: package libynl for use in selftests
    https://git.kernel.org/netdev/net-next/c/07c3cc51a085
  - [net-next,v15,14/14] selftests: add ncdevmem, netcat for devmem TCP
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



