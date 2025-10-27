Return-Path: <linux-arch+bounces-14361-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A41CC120C7
	for <lists+linux-arch@lfdr.de>; Tue, 28 Oct 2025 00:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 402FA3A97CA
	for <lists+linux-arch@lfdr.de>; Mon, 27 Oct 2025 23:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2644331A4A;
	Mon, 27 Oct 2025 23:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVuJFpex"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71389331A47;
	Mon, 27 Oct 2025 23:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761607409; cv=none; b=ooMUNej0TGnPQdMO0H7tt1QL0pxIUr6IasqD3Aow4HcMXs6meX1cGwJomxloa5I02pRB6K2v4cV3LCkZthLTUv+0xh8jPO8ohtvO0Fv+/mRbpGiWRTA/zRiQBiNYcEMKTwyT4rOr6ALLHRGvu7X8ErXcReQPAHgBmyY11d8dwYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761607409; c=relaxed/simple;
	bh=vtrMXHoNlvkXATR6ZSfjuBP5mynQBqBA+oSOYxvRKBY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Io2X7kzEdmiPuy7hCyDKNzmDZxQnJdRcUPKl8dNXOuLVMEf5Fzgis+oaYFWDzpTh2HILgKk80qnzGEs+AzXJgGPWUiLsgLfy0CiJWi7i8ab4O186auQN01QTe0n3Q81rND5WzIR/rmoFZkTGbYZAaV/a+JcAbU+KO6zlh3U+s7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVuJFpex; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A6EEC4CEF1;
	Mon, 27 Oct 2025 23:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761607409;
	bh=vtrMXHoNlvkXATR6ZSfjuBP5mynQBqBA+oSOYxvRKBY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=SVuJFpexrMZoSxIE+BV6qqrN0HTyO1GYBRzS2ldPVQI/4EMmcj0cpQh0mIQolXIh7
	 gWmDPklR1Y90YWPCfnDEsJcNWv1PboQ+Cd9+5HwKgBxvaUf1ebgtzmtmOYbFoK/6TM
	 zUq0H8n6N1d+PPSkcHf1nnAJZuBbQ+ObfjxTOHW1bHJZFR+fFCMzPjJjNfaWpLuU+E
	 QBh9+aERWbhWHNQQyyvQygHoNM87mJ+ZSZRjIaMjnrLqvSSlo0T7HAdryyDsjOaahu
	 VTB93FljKF5Ddkytm0SnmwYvQWeEcFNpaFcG7L66EhMkxxwpVGhmYy2V7qK4S8slBs
	 rAEu4ahzEuWtw==
From: Nathan Chancellor <nathan@kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
 Dimitri John Ledkov <dimitri.ledkov@surgut.co.uk>
Cc: masahiroy@kernel.org, arnd@arndb.de
In-Reply-To: <20251026202100.679989-1-dimitri.ledkov@surgut.co.uk>
References: <20251026202100.679989-1-dimitri.ledkov@surgut.co.uk>
Subject: Re: [PATCH] kbuild: align modinfo section for Secureboot
 Authenticode EDK2 compat
Message-Id: <176160740777.2230796.18257976954650435988.b4-ty@kernel.org>
Date: Mon, 27 Oct 2025 16:23:27 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev


On Sun, 26 Oct 2025 20:21:00 +0000, Dimitri John Ledkov wrote:
> Previously linker scripts would always generate vmlinuz that has sections
> aligned. And thus padded (correct Authenticode calculation) and unpadded
> calculation would be same. As in https://github.com/rhboot/pesign userspace
> tool would produce the same authenticode digest for both of the following
> commands:
> 
>     pesign --padding --hash --in ./arch/x86_64/boot/bzImage
>     pesign --nopadding --hash --in ./arch/x86_64/boot/bzImage
> 
> [...]

Applied, thanks!

[1/1] kbuild: align modinfo section for Secureboot Authenticode EDK2 compat
      https://git.kernel.org/kbuild/c/d50f21091358b

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


