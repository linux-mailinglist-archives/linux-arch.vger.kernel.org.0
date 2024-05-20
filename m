Return-Path: <linux-arch+bounces-4468-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D1F8C9D8F
	for <lists+linux-arch@lfdr.de>; Mon, 20 May 2024 14:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFE221C22A18
	for <lists+linux-arch@lfdr.de>; Mon, 20 May 2024 12:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5670355C29;
	Mon, 20 May 2024 12:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NqdltHSL"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6AF50275;
	Mon, 20 May 2024 12:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716208943; cv=none; b=MZ2u8HK3+UneT1sOzNE+QcyxtvM6f1rSnedFGzWRGMQNKwtNXD6OY57Yhyc+ybuh4T+vniJiRdbI5/R2bTgKFmaG99HAAoL0F0DLbSh+5mHVC+Ft44bEb2P2h+lLI9erOxU9h+h/WL8fyT2ASFonDwZu44KrMkhUjRfQQc5IQaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716208943; c=relaxed/simple;
	bh=M2LPrcBN4NRW7Bx1q8rRWAVSx74u4Qc/i9qC/K/q/5c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DF+utaLFUtV6l/N94aQ0TvVlEBWF2/C21FgsrSxt49aUQs0nJwD5tUDkB/JpmaL+XHytUh1sDAr7rgeEvqTgsSifvDBtDT2Jazbq93JSKz5mCU8gw3u2DsbORMCY8aKll3G74RJhGyft280zIkxe4/CrxmRviOjyZwt1qHvHtdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NqdltHSL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 468F5C2BD10;
	Mon, 20 May 2024 12:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716208942;
	bh=M2LPrcBN4NRW7Bx1q8rRWAVSx74u4Qc/i9qC/K/q/5c=;
	h=From:To:Cc:Subject:Date:From;
	b=NqdltHSLo7ZT69cnfHuZC6cInm8E/0Jd7BSNm+b9t8FGt/c8SXyYhaBn97jAOevDZ
	 n1xVRBhovATeBA3Lac0JTcoP84ymeSNpJBQQtigRsBF5+i5Ar/ZNzhvfrOGG9+p7+d
	 K+9Ba9tmHezqhXMB9Ko2T4rSfEFu9Zpmf/bVPupKwX3uKb62sgcBRTXJ+xAko0gOdR
	 cnl1Zfy2MLKRYDg1LieR4g+2VGSjCMivkxdGpYbVemytJUXS4/HDsXGcXGk7lvdRXm
	 24l1Pw5Pu7RbeTbkywS/j+gPQvv6TzVjFRuHAJNnp29hRxZmdZzgiYvPwB0Qz/24cc
	 R6iUtg/W3CTQQ==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
	linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Kees Cook <keescook@chromium.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-arch@vger.kernel.org
Subject: [PATCH 0/4] kbuild: fix and clean-up after avoiding kallsyms weak reference
Date: Mon, 20 May 2024 21:42:08 +0900
Message-Id: <20240520124212.2351033-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


I noticed a compile-time regression after commit 951bcae6c5a0
("kallsyms: Avoid weak references for kallsyms symbols").

1/4 fixes the unneeded kallsyms step 3.

2/4, 3/4, and 4/4 are follow-up cleanups.



Masahiro Yamada (4):
  kbuild: avoid unneeded kallsyms step 3
  kbuild: change scripts/mksysmap into sed script
  kbuild: fix shortlog for AS in link-vmlinux.sh
  kbuild: remove PROVIDE() for kallsyms symbols

 include/asm-generic/vmlinux.lds.h | 19 ------------
 kernel/kallsyms_internal.h        |  5 ----
 scripts/kallsyms.c                |  6 ----
 scripts/link-vmlinux.sh           | 49 ++++++++++++++++---------------
 scripts/mksysmap                  | 28 ++++--------------
 5 files changed, 32 insertions(+), 75 deletions(-)

-- 
2.40.1


