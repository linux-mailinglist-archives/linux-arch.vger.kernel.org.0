Return-Path: <linux-arch+bounces-9413-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F4D9F40C9
	for <lists+linux-arch@lfdr.de>; Tue, 17 Dec 2024 03:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91FA6166C2C
	for <lists+linux-arch@lfdr.de>; Tue, 17 Dec 2024 02:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF909145A17;
	Tue, 17 Dec 2024 02:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lBjYj8M2"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE57F13DB9F;
	Tue, 17 Dec 2024 02:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734402623; cv=none; b=Ez7o9HlYEAFOCbwHLieDIjPtsT5NVGm3hisQDrbG4POl42ifdvPaqCJXMKy4G7RE0aazLJ93vIsXICJJ/WPyV08yS0XPA3ircI+V63Krm3eBX27wlNSs6+2M3oWtlsREEW0jBQkvyx4vXzp5wEYh+K412IQ5k8AQ+2VJ5cABlPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734402623; c=relaxed/simple;
	bh=PJJItmUBMA7watWzhd31oZepc6C+4jp0xsBFYdvlSKI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZRw6vD705b64/1n53zuH6WYe0slJdyRM657AGMplvrIk7hXKoNPFxOEHVTU1ADNlnqe0GHd+SO7XEzv65jJnFi1hh+f1i5OXwWzX+1jfns7U+OZy1HVTJQwwEEPyZ3WLfS2vRcxjL9IwZVW988jtPxjCXmHfA48hoZcx2Y5Fhbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lBjYj8M2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23687C4CED0;
	Tue, 17 Dec 2024 02:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734402623;
	bh=PJJItmUBMA7watWzhd31oZepc6C+4jp0xsBFYdvlSKI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lBjYj8M2mLYK02Qtw2F33S/WNM7xaIQVHPLAzpGW4Ti5wbI9JG+FkgkNXYQuwD2lJ
	 9hnOr1IL2PMeAPGpomjkg7pJSLWLh/avU9ZP7M4qjR767EBFABvWK8WPLVhRyDukOL
	 isv3EwwwUtJjZgf5ALdN45sA7np4dNTNdkUXvK1bfSgE2CZ5nSmPqqd1fIUFqyHEDl
	 y1f0O1p4f8qOhDgitS4Jy7dOwt5wQuyJJZnwb4eWkXe4dVi3hbTj80KGoJ/U+71RRP
	 y7aHvlKoLbH3XVWhbV+yWteAg1900Rge3Om2WMwI9/oy869Sf70qhd4NfHgFQ8XnDc
	 7hHblJft6wfCg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C9C3806656;
	Tue, 17 Dec 2024 02:30:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v7 0/4] Add support for SO_PRIORITY cmsg
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173440263998.420431.1463337451862804620.git-patchwork-notify@kernel.org>
Date: Tue, 17 Dec 2024 02:30:39 +0000
References: <20241213084457.45120-1-annaemesenyiri@gmail.com>
In-Reply-To: <20241213084457.45120-1-annaemesenyiri@gmail.com>
To: Anna Emese Nyiri <annaemesenyiri@gmail.com>
Cc: netdev@vger.kernel.org, fejes@inf.elte.hu, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, willemb@google.com, idosch@idosch.org,
 horms@kernel.org, dsahern@kernel.org, linux-can@vger.kernel.org,
 socketcan@hartkopp.net, mkl@pengutronix.de, linux-kselftest@vger.kernel.org,
 shuah@kernel.org, tsbogend@alpha.franken.de, kaiyuanz@google.com,
 James.Bottomley@HansenPartnership.com, richard.henderson@linaro.org,
 arnd@arndb.de, almasrymina@google.com, asml.silence@gmail.com,
 linux-mips@vger.kernel.org, andreas@gaisler.com, mattst88@gmail.com,
 kerneljasonxing@gmail.com, sparclinux@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org, deller@gmx.de,
 vadim.fedorenko@linux.dev, linux-parisc@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 13 Dec 2024 09:44:53 +0100 you wrote:
> Introduce a new helper function, `sk_set_prio_allowed`,
> to centralize the logic for validating priority settings.
> Add support for the `SO_PRIORITY` control message,
> enabling user-space applications to set socket priority
> via control messages (cmsg).
> 
> Patch Overview:
> 
> [...]

Here is the summary with links:
  - [net-next,v7,1/4] sock: Introduce sk_set_prio_allowed helper function
    https://git.kernel.org/netdev/net-next/c/77ec16be758e
  - [net-next,v7,2/4] sock: support SO_PRIORITY cmsg
    https://git.kernel.org/netdev/net-next/c/a32f3e9d1ed1
  - [net-next,v7,3/4] selftests: net: test SO_PRIORITY ancillary data with cmsg_sender
    https://git.kernel.org/netdev/net-next/c/cda7d5abe089
  - [net-next,v7,4/4] sock: Introduce SO_RCVPRIORITY socket option
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



