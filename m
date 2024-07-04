Return-Path: <linux-arch+bounces-5249-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D376927899
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jul 2024 16:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D78DB2227E
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jul 2024 14:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BF01A070D;
	Thu,  4 Jul 2024 14:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCiIyr9L"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B0D1DA58;
	Thu,  4 Jul 2024 14:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720103815; cv=none; b=cANw8XBZT+uCUlidNzkwbQ4W88dhmVg2hq8LeON1xCyv8S8leVa/PmKixiEnj+eaNT1q2HV5oKpK1rcQFLMl3ABZX/offpnCBbQ+FVESrY84lUxgykXKkMOk63T8FtwJat6fM8qfS+1I4qyuwdEoH4R3IDX2vP7jYaqcWZ7zx1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720103815; c=relaxed/simple;
	bh=Hoz6/13PMjczW4hIS2TpZOmnWw/mZHnZjGM4bmj8L1k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WgmE1BntN09m22qfH8Tb3hfaVuS52XRtljUtMPvfyn9RlozcQt4yt72g6TK6K7T12432ufAi1F9p+IwrxDHHomFil7vmPnIH1/FCWTK3okOpUtflocQWSO09J+EFq/yypRf4ZBq37uzjpZnF+RE3UWLof3acTVfsSdOm3bl1mt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCiIyr9L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3F2EC3277B;
	Thu,  4 Jul 2024 14:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720103815;
	bh=Hoz6/13PMjczW4hIS2TpZOmnWw/mZHnZjGM4bmj8L1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nCiIyr9LHjT5gUMAqoc6oHpgAmakmhniho62gRjn0hsAsoOu9+Sc78uaog7gP3Vud
	 j6SMlBVVZkQX2t/Nnq6MTUVEq4TxtyRnuGcjT4TVsdMjoDnx9Rt2tB4l2URlWTDoIp
	 foynXcxXtGpBNWFYhV8RBl4Sba2UQ1RB+Qd5rI775P5uqxVslaCnMOxWNDMX5M2dIU
	 N7L4dnblnsifwD8Zq28c7/BF3A8WZw+iKy8w8p6UQjtEQu42q0gBTZOvrDf3WR3paV
	 a9Ubmkxx5E1NS+6CQBfcBHmUOxKdj6Cak9qg83LEdyoo+Mo87pF1TRBvRS+B3NhvEc
	 quE1rDW6FiEEg==
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
Subject: [PATCH 02/17] csky: drop asm/gpio.h wrapper
Date: Thu,  4 Jul 2024 16:35:56 +0200
Message-Id: <20240704143611.2979589-3-arnd@kernel.org>
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

The asm/gpio.h header is gone now that all architectures just use
gpiolib, and so the redirect is no longer valid.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/csky/include/asm/Kbuild | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/csky/include/asm/Kbuild b/arch/csky/include/asm/Kbuild
index 1117c28cb7e8..13ebc5e34360 100644
--- a/arch/csky/include/asm/Kbuild
+++ b/arch/csky/include/asm/Kbuild
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 generic-y += asm-offsets.h
 generic-y += extable.h
-generic-y += gpio.h
 generic-y += kvm_para.h
 generic-y += mcs_spinlock.h
 generic-y += qrwlock.h
-- 
2.39.2


