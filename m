Return-Path: <linux-arch+bounces-15073-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AB3C86220
	for <lists+linux-arch@lfdr.de>; Tue, 25 Nov 2025 18:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7C2514EA9B9
	for <lists+linux-arch@lfdr.de>; Tue, 25 Nov 2025 17:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE19329E77;
	Tue, 25 Nov 2025 17:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="en8zfJWZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from sender3-of-o54.zoho.com (sender3-of-o54.zoho.com [136.143.184.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35A0329E46;
	Tue, 25 Nov 2025 17:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764090146; cv=pass; b=Twvk2OxJtyLBIeyOBULl1xmgxXeSaLt+fgE1NAxyxteYqZq8IAwaOsvcg4JvnAUYlwfxw02H/7Us1LHCbh3yrVIZxdY4v8rf85q+P3AzEvsYTcaZJzcvtW3mwnT19NgMBPh5yDZW/odiFRM8t3wJO+KXinU5i0pkJVevTF15kME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764090146; c=relaxed/simple;
	bh=lwIklGoZpJVhiZiIBBusfUHsBjlLdeS+pm2t8JIhVnk=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=Q3mihKC7UQH0yTLiVVLtFNnDT48UOmYEpkvxHc0PpZyaHvq6S81WxRP8+rTacaK9X7hISe6zHvwcu5emIwyeLhD2PLbDdqoSaHu3DzhxN1+YxCuZNJyZK6uD0c1fwlwqgZrzJoH4e7AAX02ASi/kinI/qZ4Xfi0c8mnKK2L6ge0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=en8zfJWZ; arc=pass smtp.client-ip=136.143.184.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1764090103; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FoOTnr9zX436nWi32XEE3wJpQnQ76UKdU6WKriPe+/mNgZK67S21zO6RAh6mRfBKvbTwz6WJ00i7LGR+W1D5dyzcw+1gw1KFDyBRqYfrTtigE6+AqQf1KfeDN3M4AoYTdkU0rCmbhmjjZ4+8LYSwc+BiIq6lt4eVLUd9/e4IZJc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1764090103; h=Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=QpnzL4BKVIPxAPzUtv1iNJAYHMrRnj7MsnxPep+htdY=; 
	b=S8K8SvmUeDFgZQHQeFR4P/XLQ/bLQG9FWLiWA9bAsklKgvqonJM4cZbG7CcdmU/8u2/9UVXZ7uSmfG89UkPJRfhMk01vnB2+/1G7mY48I/Jp6gBMnTXvYX5yzEoG+VMDa2C4xrTMIBTfukquga/zwnWOBAyBgUIGn/AbtGBzSWw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764090103;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To:Cc;
	bh=QpnzL4BKVIPxAPzUtv1iNJAYHMrRnj7MsnxPep+htdY=;
	b=en8zfJWZRFXv4RTvzvj1JXuUoz3cjd+JtkWAYpbhChXfJGz0242MwtK+3mVy57cb
	w79NbBli6x/8v/yGlsbLBfhRGZMrFBfgrQCsbKnY4TOAcwn3PGDS1Jhd5217VzLvexr
	6gQrJqGoQrVkw9KatgnW+utjZvTlZFlaz1M0jax8=
Received: by mx.zohomail.com with SMTPS id 176409010041736.77905415459679;
	Tue, 25 Nov 2025 09:01:40 -0800 (PST)
From: Anirudh Raybharam <anirudh@anirudhrb.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	maz@kernel.org,
	tglx@linutronix.de,
	Arnd Bergmann <arnd@arndb.de>,
	akpm@linux-foundation.org,
	anirudh@anirudhrb.com,
	agordeev@linux.ibm.com,
	guoweikang.kernel@gmail.com,
	osandov@fb.com,
	bsz@amazon.de,
	linux-hyperv@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: [PATCH 0/3] MSHV intercepts support on arm64
Date: Tue, 25 Nov 2025 17:01:21 +0000
Message-Id: <20251125170124.2443340-1-anirudh@anirudhrb.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

From: Anirudh Rayabharam <anirudh@anirudhrb.com>

To receive hypervisor intercept interrupts on arm64 under MSHV, the parent
partition must allocate an interrupt in the SGI or PPI range and program it
into the SYNIC. Currently, Linux provides no mechanism for drivers to
dynamically allocate either SGIs or PPIs. SGIs are allocated exclusively by
the GIC driver for use by the SMP subsystem as IPIs, while PPIs must be
described in firmware (DT or ACPI), leaving the OS unable to allocate new
ones at runtime.

This series introduces support for MSHV by extending the GICv3 driver to
reserve one additional SGI specifically for use by the MSHV driver. The
reserved SGI is then used by the MSHV driver to program the SYNIC and
receive hypervisor intercept notifications.

This mechanism allows the MSHV driver to function correctly on arm64
without requiring firmware changes or altering the semantics of PPIs, while
keeping the SGI allocation model self-contained within the GIC driver.

Anirudh Rayabharam (Microsoft) (3):
  arm64: hyperv: move hyperv detection earlier in boot
  irqchip/gic-v3: allocate one SGI for MSHV
  mshv: add support for VMEXIT interrupts on aarch64

 arch/arm64/hyperv/mshyperv.c      | 31 +++++++++++++---
 arch/arm64/include/asm/mshyperv.h | 10 ++++++
 arch/arm64/kernel/setup.c         |  6 ++++
 drivers/hv/mshv_root_main.c       | 59 +++++++++++++++++++++++++++++++
 drivers/hv/mshv_synic.c           | 15 ++++----
 drivers/irqchip/irq-gic-v3.c      | 29 +++++++++++++--
 include/asm-generic/mshyperv.h    |  3 ++
 7 files changed, 139 insertions(+), 14 deletions(-)

-- 
2.34.1


