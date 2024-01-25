Return-Path: <linux-arch+bounces-1697-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 830CE83CEA2
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 22:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B6AB299E3D
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 21:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BA313A266;
	Thu, 25 Jan 2024 21:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCk0fJ1k"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF6E1386AD;
	Thu, 25 Jan 2024 21:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706218229; cv=none; b=Ha0rb97tYvid02btQcwGW6DU5m27r0OfQBHgRnFt1Ux+s0kGYs4D/6DyUkLstL35ctVw2OBVSBPd52IA552hRB4z0eJZ8AdbHA0FIcJ9pYB8JV4vzzYgRH9Kb1WmShrRQQxTuTiuju30OsZeHok22FwqqSKtbBZLF5wuxdEoEgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706218229; c=relaxed/simple;
	bh=DU2aKLt1gDJPFPkXs014yUzizTB2XryAG05PwCdQcMU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=df0DZLd4rAPZrvASAvEkA5FVVHzR3lJkoEy6SupX58YCyyjpZ0pzZkmzl1kVwSPwD83jxr2uGpaDujmt6PqaC+NTwHEfXxa3aTTIebUGQ0E6dohHylT2Wjmg2EdDxHKxEbIetyPJdB6J+vLWZMX+kp9km96al2i5JQ/871A6l+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCk0fJ1k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 567C0C433A6;
	Thu, 25 Jan 2024 21:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706218229;
	bh=DU2aKLt1gDJPFPkXs014yUzizTB2XryAG05PwCdQcMU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OCk0fJ1km2f4qcwwOqVN9rN3xFh6DvAwQwI+eiNur43sI9ERsQfnRTVxkqZiqz80e
	 c1DQ4U4k/gQHMQm1bcp5Io+ugoJYCmX+t2awn2ujGQqUH6mBpDt1Qtp+8kvPGPwg54
	 0jO/H0FCHxTW0Gh2mvBLEc6b06GfE4AxLtgvxsHrM4mBbmIwzKEmmNfw/WO2M21Tiu
	 3mqQRRq371QDxIIO39ljhxj18xBGU6kMvYJxdTnomaEbr5EMIm2vILmoS4IKQqp6KO
	 IWehxvkNo+aN5DwBIEfrd7ifICA9fLYX60LP5g6krKvpbONpvGetKosjHjIPzfmpE1
	 1OyD1J5sDwOMw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 406E9D8C961;
	Thu, 25 Jan 2024 21:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: Avoid code duplication with generic bitops
 implementation
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <170621822925.6239.5198530018567200745.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jan 2024 21:30:29 +0000
References: <20231112094421.4014931-1-xiao.w.wang@intel.com>
In-Reply-To: <20231112094421.4014931-1-xiao.w.wang@intel.com>
To: Wang@codeaurora.org, Xiao W <xiao.w.wang@intel.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, arnd@arndb.de,
 geert@linux-m68k.org, haicheng.li@intel.com, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Sun, 12 Nov 2023 17:44:21 +0800 you wrote:
> There's code duplication between the fallback implementation for bitops
> __ffs/__fls/ffs/fls API and the generic C implementation in
> include/asm-generic/bitops/. To avoid this duplication, this patch renames
> the generic C implementation by adding a "generic_" prefix to them, then we
> can use these generic APIs as fallback.
> 
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
> 
> [...]

Here is the summary with links:
  - riscv: Avoid code duplication with generic bitops implementation
    https://git.kernel.org/riscv/c/cb4ede926134

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



