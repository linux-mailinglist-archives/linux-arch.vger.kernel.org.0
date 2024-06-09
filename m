Return-Path: <linux-arch+bounces-4784-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A659290171A
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jun 2024 19:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D2071F212B8
	for <lists+linux-arch@lfdr.de>; Sun,  9 Jun 2024 17:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4079042ABB;
	Sun,  9 Jun 2024 17:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uhYlEd0K"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143603B182;
	Sun,  9 Jun 2024 17:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717952958; cv=none; b=iTUOzMFe53OX5yVdiPxnQNKLx2NXpy9H+zmmqsPYp6TLn6mX5xppPUDe6YJqSSCbnzPVO8LsDmd3dUdrdRmAoHzQrNB/HNsm+ggsIcF1MQE0RNs84Zh383xAaUEysEdgeyEn7XiQmt5kjdVdVPwYFzuYmBAXnCJpgyChggGwV5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717952958; c=relaxed/simple;
	bh=F9vA5PuzA9S36h7BUGNgKeqUCof3D7xesqHLszYATk8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r/immVXwUR9eK+qkje6hbFzIi3vZAcqnGWrnr/x0fLdM1NXcfLnnBBKA4mcldrXbGbGAjpfy34zameWX6Yrv40cV3pcyocji0i1xdANBQuX+F1XCxO/Gg+ucj8sTuIzL+AiFQVi/9rtUkZ6fiGBXnZ0BP13F7ajNqDK1HhZQYRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uhYlEd0K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F485C2BD10;
	Sun,  9 Jun 2024 17:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717952957;
	bh=F9vA5PuzA9S36h7BUGNgKeqUCof3D7xesqHLszYATk8=;
	h=From:To:Cc:Subject:Date:From;
	b=uhYlEd0K/VdGbSf3TbNrqdIe0T+QvhbabE45lv7RxN8w+cRiUZdUZnV5Yr43E7bd/
	 yWyEFqgf1tBmE4pGXTvCXraOXrUg5mvjwgBmDHYV4mKuwO0fr5Ku/SU6PmtaaaYCG7
	 +bIAJQUtNvDpWOrUIOlZyz/XTAILhDSka/YI2TM3SmmqB2wgfEMSGVRl0OgYHwEogr
	 1UZ8/HwCPpU1iC/nHgIXVRkCBYXTaGxJ0TL5dXj2mLemPWMiK3aWzxbsMjTpzIvfWa
	 k+PTprSr3gKH66xDo9eKpK+dcE8Eu7Id+YVsE0m84+bVAd9jUHIIA9GLVz685KFWAf
	 XXoXDG0KkRaVg==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-arch@vger.kernel.org
Subject: [PATCH v2 0/3] kbuild: remove PROVIDE() and refactor vmlinux_link steps
Date: Mon, 10 Jun 2024 02:04:17 +0900
Message-ID: <20240609170855.1708665-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

 - Remove PROVIDE() in the linker script
 - Merge temporary vmlinux link steps for BTF and kallsyms


Changes in v2:
 - Fix the handling --strip-debug flag

Masahiro Yamada (3):
  kbuild: refactor variables in scripts/link-vmlinux.sh
  kbuild: remove PROVIDE() for kallsyms symbols
  kbuild: merge temporary vmlinux for BTF and kallsyms

 include/asm-generic/vmlinux.lds.h | 19 -------
 kernel/kallsyms_internal.h        |  5 --
 scripts/kallsyms.c                |  6 ---
 scripts/link-vmlinux.sh           | 90 ++++++++++++++++---------------
 4 files changed, 47 insertions(+), 73 deletions(-)

-- 
2.43.0


