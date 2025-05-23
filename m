Return-Path: <linux-arch+bounces-12119-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B16F4AC283B
	for <lists+linux-arch@lfdr.de>; Fri, 23 May 2025 19:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E6E1166623
	for <lists+linux-arch@lfdr.de>; Fri, 23 May 2025 17:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA77D29713D;
	Fri, 23 May 2025 17:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SbFtbpY0"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A14E1FBE83;
	Fri, 23 May 2025 17:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748020199; cv=none; b=V804rQhKkjI+Bq/f9WhqjkkSu4dbwG5Jbk4FXU0oQ+NqbxyIMKxLAEDUnqFNPNd7vCnIeM47PGP6HThvCdNBiyr9yUvwFTWUVQ/bNAwTKg2K8JPd6pnE8EQG6q63NUGe4c3lZJcFR3uNe4yWBDdIhW0WuG7V+sgV/16rywzjTyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748020199; c=relaxed/simple;
	bh=TReTPgN6XdqF5R6qV4spejh7ZdNr9v/N3dBjSngKgoU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YrnQ3iK703/FTFWMqFyGMDd+puQzh1jUoYV2zbTDuLT1xGniOWfzR6okVtCPyvPNeA1dCAy2KXeKVIK+J4Zu7wPxppsehWz1Zoyrx6/xJbJI1BLY+DDflFWuF6RXIYtKjnLPnEJLlC0ULhG3sazCa+RFgflGsLk0ClLyoZ5y688=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SbFtbpY0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0503C4CEE9;
	Fri, 23 May 2025 17:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748020199;
	bh=TReTPgN6XdqF5R6qV4spejh7ZdNr9v/N3dBjSngKgoU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SbFtbpY0mNof+IWbEtTPYybEZR5ziMgAGywQ4eXVpJ7wcHELVNDHghn2/XWFcMNLi
	 AslhbKROHzuwCxq+bbVu6uG5s+FZNB3kl8Zpdzip6SAJY8uJrdGB3hImGR1WE7+oDn
	 +jmnfoCOckBSw4fLQi1TlrdpoCT48/WWoKcH4SruMeqFDiUMA52QN12JjLIGVleHOT
	 2J1Jzz2Qdd1sCIwf1gs7uhfqicAephCcaEgj7/6asN3plvfC/TMGxOCZ8VSAKNPpzD
	 LL2RAFOBoIEN8dACHirZqtJAfIm+q6iYV48kik2bxe19OzpZ/2QFalX0oLA/bAaVMH
	 /l4lvEgw3IuLw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D7C380DBEB;
	Fri, 23 May 2025 17:10:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v5 0/3] Allow mmap of /sys/kernel/btf/vmlinux
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174802023425.3668992.8944556330976835180.git-patchwork-notify@kernel.org>
Date: Fri, 23 May 2025 17:10:34 +0000
References: <20250520-vmlinux-mmap-v5-0-e8c941acc414@isovalent.com>
In-Reply-To: <20250520-vmlinux-mmap-v5-0-e8c941acc414@isovalent.com>
To: Lorenz Bauer <lmb@isovalent.com>
Cc: arnd@arndb.de, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 shuah@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, alan.maguire@oracle.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 20 May 2025 14:01:16 +0100 you wrote:
> I'd like to cut down the memory usage of parsing vmlinux BTF in ebpf-go.
> With some upcoming changes the library is sitting at 5MiB for a parse.
> Most of that memory is simply copying the BTF blob into user space.
> By allowing vmlinux BTF to be mmapped read-only into user space I can
> cut memory usage by about 75%.
> 
> Signed-off-by: Lorenz Bauer <lmb@isovalent.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next,v5,1/3] btf: allow mmap of vmlinux btf
    https://git.kernel.org/bpf/bpf-next/c/a539e2a6d51d
  - [bpf-next,v5,2/3] selftests: bpf: add a test for mmapable vmlinux BTF
    https://git.kernel.org/bpf/bpf-next/c/828226b69ff5
  - [bpf-next,v5,3/3] libbpf: Use mmap to parse vmlinux BTF from sysfs
    https://git.kernel.org/bpf/bpf-next/c/3c0421c93ce4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



