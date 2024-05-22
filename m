Return-Path: <linux-arch+bounces-4486-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D128CC08C
	for <lists+linux-arch@lfdr.de>; Wed, 22 May 2024 13:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 169B4B21162
	for <lists+linux-arch@lfdr.de>; Wed, 22 May 2024 11:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F7513D526;
	Wed, 22 May 2024 11:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uz/hrVa2"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415FA7E765;
	Wed, 22 May 2024 11:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716378485; cv=none; b=j+IvIXMHRgZiNsBrrZwNnuoRfJVxM9D+dC493lqi9ujQC7ALsChOiSPmywrapngVw7xSfSIm4AXc7RYFuGbS/+06jBkFPlmhe5I+RQ18GpvmQHTxYv5ToJXDx7ld7nnaJYks1W7fmF7Cx7gti90ZEh6UmocMEP8ZQ47h6w9Ar3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716378485; c=relaxed/simple;
	bh=D9GU2oEZ+MO6Z/F1dykmdDtuO+LLYvTayhZZTswjnyk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cufVCe7uCL74QJaZ5+7zmdfOngjKluMI3q9Q+MnDBBr7Sau1zPPOOyZ/72leMDyEYvzzZU7rupeSccfF7zmOgXeqCr0JoY2lLQDtChKgU4gssx5CHRcsO3RYzlGhYRROocaw/1NSy/ggpzZjdGA4OsDnhlwvPgq/oac2kfkBvyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uz/hrVa2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EA28C2BD11;
	Wed, 22 May 2024 11:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716378484;
	bh=D9GU2oEZ+MO6Z/F1dykmdDtuO+LLYvTayhZZTswjnyk=;
	h=From:To:Cc:Subject:Date:From;
	b=Uz/hrVa21BzwAvZzMQkhLeTq6QGj80Y61mqTHXlYeZQcEAYAxfBXtrJKisg05yaif
	 SKf6amn2ov5wsKxE5eh7nKA25o8IQV7nE0kf9FlguOhpbfkuZISTr2C9xSEFp3LXP7
	 cK0U0n4E8CXolAyFYG0Nuur6wS9/yfFM1xP3wYc3jR9R7PHtuT+AHMTxnHBMMit7jm
	 MtefE5TPgpiZ6aM8cG4tZiNFT91BpjdKh+VWUiowA84kHU2vW+59hNFLKl8u2C7pvt
	 dJ/7VvKIy22bx5ER6ZxnL0T1uyDthaBXaTVJdSLQ0kXlURhHkrPNG47XdvvaSngQI3
	 zTzr8PZB+Ezpw==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-arch@vger.kernel.org
Subject: [PATCH 0/3] kbuild: remove PROVIDE() and refactor vmlinux_link steps
Date: Wed, 22 May 2024 20:47:52 +0900
Message-Id: <20240522114755.318238-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


 - Remove PROVIDE() in the linker script
 - Merge temporary vmlinux link steps for BTF and kallsyms



Masahiro Yamada (3):
  kbuild: refactor variables in scripts/link-vmlinux.sh
  kbuild: remove PROVIDE() for kallsyms symbols
  kbuild: merge temp vmlinux for CONFIG_DEBUG_INFO_BTF and
    CONFIG_KALLSYMS

 include/asm-generic/vmlinux.lds.h | 19 -------
 kernel/kallsyms_internal.h        |  5 --
 scripts/kallsyms.c                |  6 ---
 scripts/link-vmlinux.sh           | 87 ++++++++++++++++---------------
 4 files changed, 45 insertions(+), 72 deletions(-)

-- 
2.40.1


