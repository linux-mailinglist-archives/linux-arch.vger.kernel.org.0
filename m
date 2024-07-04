Return-Path: <linux-arch+bounces-5251-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7744A9278A2
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jul 2024 16:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21FF01F24C20
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jul 2024 14:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FE01DA58;
	Thu,  4 Jul 2024 14:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jCJ5MSRg"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C349F1B0115;
	Thu,  4 Jul 2024 14:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720103830; cv=none; b=tZ2Gi/9yyc/92UXJeOrEvT+vFA5mXc3UskUZ2IP/riDgozC5FwUzOw7KFZPQQ9xp2BGHwNIFo+6Yq9c+yPBVVdIjlRSBmha/CHe73kG7m5a8i5DzJvSYcAEt3E1R0MchPBkv2yxRz4POOTg7cUHfycIKmKl6ALoGNKHg+E1SqTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720103830; c=relaxed/simple;
	bh=yu+0Yh/Zm5ePXyQSzCJDqob9b5xLVBd50xsCUlcp+Tg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ls2FM2Nr1RIysarclS1Gh7zLd+vSr0S3csJS8D6dSM78ldts6hOAnQ7hctAiAXR1N2gSwLsMPW6e83yuajzWNoR8kn2rrTNdgw7J/29WLKSZFEFs7sboUFrMhxHJGOi36LPRlULa4Adr5V4ezva7/m0JZZYgmp8BmEiS+UjZPrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jCJ5MSRg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D7EDC4AF0A;
	Thu,  4 Jul 2024 14:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720103830;
	bh=yu+0Yh/Zm5ePXyQSzCJDqob9b5xLVBd50xsCUlcp+Tg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jCJ5MSRg/EfhLOKompm72xYCQpKFpCkF1CZUzoHMuQZ0QaeislAVx6vtv3Q/ex6Kx
	 U64M0sGfsRjq+uGzHeKJb6ExfZvsLQ1XDmrF9Vi2rDq4W/FWos3MnyA9KeUqWE/XFN
	 Zs+gjpBRB22YkZdsgGczZFfH286xWqocMP+eZ3ApM5abcFClHdWutCPIjsVHXBFn69
	 Ujnp33IRJUiOLjib+qRov9/pMXR3Jx+0PTaAnvyq55vtDAd2kwPHDkXCqI5xlavxIR
	 OtOV7z11cYDscnHB+DYPyNCMVrmrWjhEwH1OFwFmcJ4fw6YkDmmYeYspLmtqfWg2cM
	 Co1Xpmt76CttQ==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Brian Cain <bcain@quicinc.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Christian Brauner <brauner@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-openrisc@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH 04/17] loongarch: avoid generating extra header files
Date: Thu,  4 Jul 2024 16:35:58 +0200
Message-Id: <20240704143611.2979589-5-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240704143611.2979589-1-arnd@kernel.org>
References: <20240704143611.2979589-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The list of generated headers is rather outdated, some of these no longer
exist, while others are already listed in include/asm-generic/Kbuild
so there is no need to list them here.

As we start validating the list of headers against the files that exist,
the outdated ones now cause a warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/loongarch/include/asm/Kbuild | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/arch/loongarch/include/asm/Kbuild b/arch/loongarch/include/asm/Kbuild
index c862672ed953..0db5ad14f014 100644
--- a/arch/loongarch/include/asm/Kbuild
+++ b/arch/loongarch/include/asm/Kbuild
@@ -1,28 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0
 generated-y += orc_hash.h
 
-generic-y += dma-contiguous.h
 generic-y += mcs_spinlock.h
 generic-y += parport.h
 generic-y += early_ioremap.h
 generic-y += qrwlock.h
 generic-y += qspinlock.h
-generic-y += rwsem.h
-generic-y += segment.h
 generic-y += user.h
-generic-y += stat.h
-generic-y += fcntl.h
 generic-y += ioctl.h
-generic-y += ioctls.h
-generic-y += mman.h
-generic-y += msgbuf.h
-generic-y += sembuf.h
-generic-y += shmbuf.h
 generic-y += statfs.h
-generic-y += socket.h
-generic-y += sockios.h
-generic-y += termbits.h
-generic-y += poll.h
 generic-y += param.h
-generic-y += posix_types.h
-generic-y += resource.h
-- 
2.39.2


