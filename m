Return-Path: <linux-arch+bounces-5252-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C0B9278AA
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jul 2024 16:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF9CE1C2367D
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jul 2024 14:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870361B11EF;
	Thu,  4 Jul 2024 14:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tc/9AtSI"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAF91A070D;
	Thu,  4 Jul 2024 14:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720103838; cv=none; b=aj+YoOtqwZGq+eUlTTqbaqvQMZB7FTMLkJMXB79V3tIjoc0m2MD5TQvJ4m/v2eaNofCpdnSs7aKXzrO4o6Xf3jnDFm43m9PYXRCA4aVW4q5kAhhkAAYyTlde7C5FyTjRSd9/cIBDrJXMa9Ps6N4lqldrKulj6oBfobIuOXHkCvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720103838; c=relaxed/simple;
	bh=u4YCGPtZ1hWFRjjAbr/hm2CUFSMfgKe1rJDb2sF1EEc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G7EAoGO8qdingD8521zcXKSApGhibXtEX9ZVlbbNEZ5hfAOVd0XvPNZdNLfzKYkYeeH6swQwEM9GmIXsuLf+B9DMiYaigKVks/Vwb/jtJQ4zMHvnNSJWV1vOpSzr02OnjJgd5lLfjsnOIzqulAT+HS7oHCjXWthz5Buwp2sXYg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tc/9AtSI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAC61C4AF0F;
	Thu,  4 Jul 2024 14:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720103837;
	bh=u4YCGPtZ1hWFRjjAbr/hm2CUFSMfgKe1rJDb2sF1EEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tc/9AtSIv5Qo2uEtjpY5zLOUDy7pcNjquWveACh0n01h2HakOuJc/AssgiwDtzMFG
	 ZgsSyrktW/wag3+XshQJeRGnAyJ4fRLbul8Crgu41615xmDkZ1txy9uJu1kt3ZqCxu
	 9FaXeFUEwzz7/MNoErM4N4ka4k8xk/Mgsav3s+vqiZ38qYs9PbrDAMjpBH85H+Ffkr
	 GD3vABxdXpGiDYO2yweztXzoufQlbvApRhfsFHBib7/8oymLavFV7+s1od7ZxTthJ3
	 bKVfCD2+fNrK8GbFcGmQUA4i1IXn0Ojy+q9dFPs7sF8lEoCiZpiGSPFfjgwFJNUMUM
	 w5Dm3N4kSp2qw==
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
Subject: [PATCH 05/17] kbuild: verify asm-generic header list
Date: Thu,  4 Jul 2024 16:35:59 +0200
Message-Id: <20240704143611.2979589-6-arnd@kernel.org>
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

In order to integrate the system call header generation with generating
the asm-generic wrappers, restrict the generated headers to those that
actually exist in include/asm-generic/.

The path is already known, so add these as a dependency.

The asm-generic/bugs.h header was removed in commit 61235b24b9cb ("init:
Remove check_bugs() leftovers"), which now causes a build failure, so
drop it from the list.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/asm-generic/Kbuild   | 1 -
 scripts/Makefile.asm-generic | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/asm-generic/Kbuild b/include/asm-generic/Kbuild
index b20fa25a7e8d..df7ed81c4589 100644
--- a/include/asm-generic/Kbuild
+++ b/include/asm-generic/Kbuild
@@ -9,7 +9,6 @@ mandatory-y += archrandom.h
 mandatory-y += barrier.h
 mandatory-y += bitops.h
 mandatory-y += bug.h
-mandatory-y += bugs.h
 mandatory-y += cacheflush.h
 mandatory-y += cfi.h
 mandatory-y += checksum.h
diff --git a/scripts/Makefile.asm-generic b/scripts/Makefile.asm-generic
index 1486abf34c7c..69434908930e 100644
--- a/scripts/Makefile.asm-generic
+++ b/scripts/Makefile.asm-generic
@@ -46,7 +46,7 @@ all: $(generic-y)
 	$(if $(unwanted),$(call cmd,remove))
 	@:
 
-$(obj)/%.h:
+$(obj)/%.h: $(srctree)/$(generic)/%.h
 	$(call cmd,wrap)
 
 # Create output directory. Skip it if at least one old header exists
-- 
2.39.2


