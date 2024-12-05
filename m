Return-Path: <linux-arch+bounces-9247-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E36B69E4CB4
	for <lists+linux-arch@lfdr.de>; Thu,  5 Dec 2024 04:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AB10168F4F
	for <lists+linux-arch@lfdr.de>; Thu,  5 Dec 2024 03:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA63196D9A;
	Thu,  5 Dec 2024 03:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QXGf+Rfn"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D79195808;
	Thu,  5 Dec 2024 03:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733369433; cv=none; b=iVEIPE1kksytvRd8bjJSRKY0ITs5yfG33hgSYEF8phtPQR5CfX8W/wyPuetKu2syajzDSy5VUcXyDx9Un9rj8fi8tUAjdU1za17+9KHVZu2/WgMWFXiMqXlJJS5vKehhwSDdTrp0kJ1df0EM9IlgBx+C2/YtyvPXu4sTkhSrf4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733369433; c=relaxed/simple;
	bh=Aa2GA4zhNr+oEjhTpq81GxsJ6mHPH7Unii4uCLAeVwI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=anPxtE9+q/OMbp8uKWQHKIHqvzlXyyhIGUJK3xzUB5fSQd0C35XAwf3ynOVh0HJAccBib8x4LANV+jZvOEWEYK3wccsfO3PyJQZngbW1R/jhQQhixkHBCRVFGvJ5t13n5hlH2lHMYgqfxXM5sYL1aQtPk73sUNXorPw+asIw87M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QXGf+Rfn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A084FC4CEE0;
	Thu,  5 Dec 2024 03:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733369432;
	bh=Aa2GA4zhNr+oEjhTpq81GxsJ6mHPH7Unii4uCLAeVwI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QXGf+RfneS13dJ0kYfhi4aVX4IbnxiRDI+81LrMGiUXrRHhTmOXloSvq0zhBVpTEc
	 O3UTqtUZ8IdNCsMCblpPhzumPQMxZCl+7pNJQnpwsHIKUeT92GXzdxDhpk2tPr1BQa
	 3NCCF843YAVh4Z7DgJ+SqYB7hx2/8CdwDhGMH+wh8+CxyvFcsDZtdDaEW70rHkNIT5
	 lKfAhUgNz1JxiQlFYijeX7VOpbbabrH+iPmg9BBBj4QPXIJlRXkIWutqjoaqO1OqTz
	 QHCTnHRNHYtr4U8sLqoQX7eFc4ZQ0i0omtm1V8eihHo1kRQTZpyD+thVQIwckmcwmu
	 Grv5az+OUWz7Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EFF380A94C;
	Thu,  5 Dec 2024 03:30:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] selftests/net: call sendmmsg via udpgso_bench.sh
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173336944700.1431012.17616394394227408933.git-patchwork-notify@kernel.org>
Date: Thu, 05 Dec 2024 03:30:47 +0000
References: <20241203222843.26983-1-nakayamakenjiro@gmail.com>
In-Reply-To: <20241203222843.26983-1-nakayamakenjiro@gmail.com>
To: Kenjiro Nakayama <nakayamakenjiro@gmail.com>
Cc: pablo@netfilter.org, kadlec@netfilter.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
 peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
 dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
 paulmck@kernel.org, akiyks@gmail.com, dlustig@nvidia.com,
 joel@joelfernandes.org, shuah@kernel.org, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arch@vger.kernel.org, lkmm@lists.linux.dev,
 linux-kselftest@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  4 Dec 2024 07:28:44 +0900 you wrote:
> Currently, sendmmsg is implemented in udpgso_bench_tx.c,
> but it is not called by any test script.
> 
> This patch adds a test for sendmmsg in udpgso_bench.sh.
> This allows for basic API testing and benchmarking
> comparisons with GSO.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] selftests/net: call sendmmsg via udpgso_bench.sh
    https://git.kernel.org/netdev/net-next/c/ac98b3132402

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



