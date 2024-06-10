Return-Path: <linux-arch+bounces-4792-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A300902049
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jun 2024 13:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD2FD282AE9
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jun 2024 11:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723C47C6C1;
	Mon, 10 Jun 2024 11:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yvv3VKFX"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A9EFC01;
	Mon, 10 Jun 2024 11:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718018824; cv=none; b=enSItMmHsmceH8zRWNkq4FKx+SQGmLA0oLu0dv5UBB5iRPcTbyE4pmn/xN8VVDcRs2S3X/+DJw/FByT6mmO2hvokv20OI72hjtSR68OLtZUxCLuDXjeD39qE2y6V2DucFZEdXBQH39/4uNPFTrC7Bzd5C6ZgmGfV6WNEjtNnYQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718018824; c=relaxed/simple;
	bh=Zj7me7gZBaXpkbOCnvwgreuP5Tx8hWvjy2At9j5lGHk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OL7+nWtRlCJjLZf+27EGzA74l8Sl+QhLvBRxoYb7wTw/jSGs/AlkfvnXnIOvjfnZkbLdS/DK+MauV6YEssX2PG6ZXXcRbH1+er3FJF1zPgNAMi8tWuKsO9aamtyYjTaC7wQ8A+8yLrdrGVzO4nFc7O1L4r2fjs3IUeVsskD4wr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yvv3VKFX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2676C2BBFC;
	Mon, 10 Jun 2024 11:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718018823;
	bh=Zj7me7gZBaXpkbOCnvwgreuP5Tx8hWvjy2At9j5lGHk=;
	h=From:To:Cc:Subject:Date:From;
	b=Yvv3VKFXHSY1XZG0ppooSoMDp3H70bNoH74uPMfaQM2cJJ/186kLRBVZCnX0OpVFj
	 EKujvHGV/RANpBc7lzjdwPXveEtJnaRHH+3BN0ePXcbrnblOWGAUH6DEA/E4SjFNjv
	 LXIxZ/Gv3iJENigFnFkFkV5OmjLIvLSOP7oDfx99MhSJgU1dXp41jx5P+tQntPZ5sd
	 yP69TR2JPvOnEqWbcgRWsMDeqtN0WNJ/B2r0RUiSv+UkEuuSECytHUK2DPmz87tEyH
	 nMk/eog8FkQCbMOnoMAA5SGTEGQrX6xUKazBaROlxgWmssJjhmIJ/XTSi6ZIq86LTJ
	 UqO6dT+BKzEcw==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-arch@vger.kernel.org
Subject: [PATCH v3 0/3] kbuild: remove PROVIDE() and refactor vmlinux_link steps
Date: Mon, 10 Jun 2024 20:25:15 +0900
Message-ID: <20240610112657.602958-1-masahiroy@kernel.org>
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


Masahiro Yamada (3):
  kbuild: refactor variables in scripts/link-vmlinux.sh
  kbuild: remove PROVIDE() for kallsyms symbols
  kbuild: merge temporary vmlinux for BTF and kallsyms

 include/asm-generic/vmlinux.lds.h |  19 ------
 kernel/kallsyms_internal.h        |   5 --
 scripts/kallsyms.c                |   6 --
 scripts/link-vmlinux.sh           | 101 +++++++++++++++++-------------
 4 files changed, 58 insertions(+), 73 deletions(-)

-- 
2.43.0


