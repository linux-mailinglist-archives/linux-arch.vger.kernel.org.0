Return-Path: <linux-arch+bounces-9358-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B955C9ED9DB
	for <lists+linux-arch@lfdr.de>; Wed, 11 Dec 2024 23:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BDC3282EC1
	for <lists+linux-arch@lfdr.de>; Wed, 11 Dec 2024 22:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC771FBEB5;
	Wed, 11 Dec 2024 22:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qv6gvZPd"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FF31FA8FF;
	Wed, 11 Dec 2024 22:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733956349; cv=none; b=VLo7clw6Ql40dWKU/1ZFpIqMTBrTBa6w4fUdcbcKAV/UbtUEoovZojBT5o3anAEPjcGtYF7c6uoodQ4/gEENp/rh0rGedligKeaBsqTY0JekttdToUFddTjM9HJVTtqALH1O9SkLXb7ZtyRHY92tfXpPWBFwTL10KrDjdydl8Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733956349; c=relaxed/simple;
	bh=BsLL13WVfc3NzEKIjd52mjnoMrC/Et1GCt0kRWiLCQo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bPth9QcmsZNdlBbPF7WHBbwtm8uYLNUDlciBjNkTVzk3utk+02KTIJPJEzhisp4M/zntbH7im217JL2FN6IPsvdGHmbOGqs8pApGIs8pLHyXwqBYHzzN0RU7b1Wb/iMM9m2gI2BmwS6PwAzwXjEmdHdotnbk9I+Hd/Bm1LoC7ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qv6gvZPd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2AB6C4CED2;
	Wed, 11 Dec 2024 22:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733956348;
	bh=BsLL13WVfc3NzEKIjd52mjnoMrC/Et1GCt0kRWiLCQo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qv6gvZPdDzbdVPybtFSPx8+F0xql/LHjAUoa61PxHbq7BiNILQmSVN3xV/Fk+jm3l
	 eRj2euKpGQwhzha10D0yvWpJ5jdjr8+V1iYsps4/RL/90xpWyAoPlqxLTgT8H2p1Qr
	 znxHE8HzGGVb3bxCyQgvVT/2hoGKZW56OU+GylgAoSP4eq7TpXB3MZRt3VoyD522af
	 qGwcNNMDDsGqYKHkYodSX7oguHOLk4TTwi/8Q8fATZ6k5VUR9Dw7CkfxIhk8aSQAz0
	 q46lv24Cq5nGqzFQZkxa8IXK7+L/Hgf8e5dM0N1jW5ubxUNiav+to559ZbObo4j7v8
	 24oLtA9z8Jf7w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFBE380A965;
	Wed, 11 Dec 2024 22:32:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] asm-generic: provide generic page_to_phys and
 phys_to_page implementations
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <173395636448.1729195.13128530873311699126.git-patchwork-notify@kernel.org>
Date: Wed, 11 Dec 2024 22:32:44 +0000
References: <20241023053644.311692-2-hch@lst.de>
In-Reply-To: <20241023053644.311692-2-hch@lst.de>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-riscv@lists.infradead.org, arnd@arndb.de,
 linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
 linux-arch@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Arnd Bergmann <arnd@arndb.de>:

On Wed, 23 Oct 2024 07:36:36 +0200 you wrote:
> page_to_phys is duplicated by all architectures, and from some strange
> reason placed in <asm/io.h> where it doesn't fit at all.
> 
> phys_to_page is only provided by a few architectures despite having a lot
> of open coded users.
> 
> Provide generic versions in <asm-generic/memory_model.h> to make these
> helpers more easily usable.
> 
> [...]

Here is the summary with links:
  - [1/2] asm-generic: provide generic page_to_phys and phys_to_page implementations
    https://git.kernel.org/riscv/c/c5c3238d9b8c
  - [2/2] asm-generic: add an optional pfn_valid check to page_to_phys
    https://git.kernel.org/riscv/c/3e25d5a49f99

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



