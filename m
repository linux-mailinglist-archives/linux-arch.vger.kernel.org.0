Return-Path: <linux-arch+bounces-13816-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE46BAEE10
	for <lists+linux-arch@lfdr.de>; Wed, 01 Oct 2025 02:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4484A1C79CE
	for <lists+linux-arch@lfdr.de>; Wed,  1 Oct 2025 00:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944021DF97C;
	Wed,  1 Oct 2025 00:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ggMZxZvA"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577C01DF25C;
	Wed,  1 Oct 2025 00:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759278626; cv=none; b=JMZenIK4Lm2hd26t1owvZNk1AlzIpNduHSkAmkS/k5hZFh3gibjoKLjyT9xQbFw0/VH1KhbrHDu3XmJRajZ30RROj0o2kkczHrWCGcElEOmD0FNr0wVL2ADn8ZXM4/pqxjzCHMu+VwAK+yvT1t985cOyTswqXN9v0vBDrDxTx24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759278626; c=relaxed/simple;
	bh=0fQVWwUWkMLw33UpF2OAmId1Q2Rfqf5COyBi7cgwMjk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BV6urRKehuCUb5qmS6PhCmCjGkIYjEwrJ94hNbKlzlCpHUbg3XKy7j9QErQUK5Zg1Xlrg9OyVGqVVaJeTzZSGQGz2AAoUOjl+LoRDwzM8YHxuYvKBJQnAmsllkF+JkoVRNp3r4tGPkckluRLIgVvyBXvcvwdPqkPYcHrzLAwwvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ggMZxZvA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D725DC116C6;
	Wed,  1 Oct 2025 00:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759278625;
	bh=0fQVWwUWkMLw33UpF2OAmId1Q2Rfqf5COyBi7cgwMjk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ggMZxZvAdqGwXcKzbUBeVmq6kYQUo6N6wv4YaBXSVcZkd0PWTE7TFXLcN41hQ5u62
	 eIbMgt8c6zAH0elSzu62Yr7Re+vHbOzVk4ABqKmbyuvdnIvPwEf9BWx6AtJeobox1m
	 C+L2GM3/rh2zzwmY/Avrl5o4a8njn8Ymvl7GBKPY5qQWdXHOXbDQJOrrEvebLZjR1o
	 VYj8KTa/+28xLsMy4gYmcFG4HdE+bqYMC+LJq+GD5x6aVLlI55gzJhnJuXht3rtc7q
	 BGtdsQZoXifnHkeGnT6QLk1Ol0aI4ZpERr5X379G5hQEzWM18+8MCugodLaKBw7eMy
	 iGXPwOfa0jxHw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACAB39D0C1A;
	Wed,  1 Oct 2025 00:30:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next V6] net/mlx5: Improve write-combining test
 reliability for ARM64 Grace CPUs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175927861849.2249992.11585338388238905826.git-patchwork-notify@kernel.org>
Date: Wed, 01 Oct 2025 00:30:18 +0000
References: <1759093688-841357-1-git-send-email-tariqt@nvidia.com>
In-Reply-To: <1759093688-841357-1-git-send-email-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: catalin.marinas@arm.com, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 saeedm@nvidia.com, leon@kernel.org, mbloch@nvidia.com,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, gal@nvidia.com, leonro@nvidia.com,
 jgg@nvidia.com, michaelgur@nvidia.com, moshe@nvidia.com, will@kernel.org,
 agordeev@linux.ibm.com, akpm@linux-foundation.org, borntraeger@linux.ibm.com,
 bp@alien8.de, dave.hansen@linux.intel.com, gerald.schaefer@linux.ibm.com,
 gor@linux.ibm.com, hca@linux.ibm.com, hpa@zytor.com, justinstitt@google.com,
 linux-s390@vger.kernel.org, llvm@lists.linux.dev, mingo@redhat.com,
 morbo@google.com, nathan@kernel.org, ndesaulniers@google.com,
 salil.mehta@huawei.com, svens@linux.ibm.com, tglx@linutronix.de,
 x86@kernel.org, yisen.zhuang@huawei.com, arnd@arndb.de, leonro@mellanox.com,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 mark.rutland@arm.com, michaelgur@mellanox.com, patches@lists.linux.dev,
 schnelle@linux.ibm.com, shaojijie@huawei.com, horms@kernel.org,
 phaddad@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 29 Sep 2025 00:08:08 +0300 you wrote:
> From: Patrisious Haddad <phaddad@nvidia.com>
> 
> Write combining is an optimization feature in CPUs that is frequently
> used by modern devices to generate 32 or 64 byte TLPs at the PCIe level.
> These large TLPs allow certain optimizations in the driver to HW
> communication that improve performance. As WC is unpredictable and
> optional the HW designs all tolerate cases where combining doesn't
> happen and simply experience a performance degradation.
> 
> [...]

Here is the summary with links:
  - [net-next,V6] net/mlx5: Improve write-combining test reliability for ARM64 Grace CPUs
    https://git.kernel.org/netdev/net-next/c/fd8c8216648c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



