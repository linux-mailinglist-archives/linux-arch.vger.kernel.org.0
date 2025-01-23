Return-Path: <linux-arch+bounces-9863-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 014E3A19C8A
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jan 2025 02:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A88F188B67F
	for <lists+linux-arch@lfdr.de>; Thu, 23 Jan 2025 01:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E2435950;
	Thu, 23 Jan 2025 01:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XQ1bX/Rk"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BFF328B6;
	Thu, 23 Jan 2025 01:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737596859; cv=none; b=He+9eV6mr/EjK4sLnFxiJKnfAllzh/Ao4NK17UABQGclgsoQGFqxPgKEcEWjFr1tB/Ei74b3K1ZTqybE067mq+7PMVe3n91WtmECmiDOoBClhNSI5EagxSKmrYp1LldubED9cWz3BNyfBO1T/mACnZYGwj1i3ThQlcFmb7n1pak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737596859; c=relaxed/simple;
	bh=+HfD0lC/0le9jqcmZMsCocI+Wb9eOMDEX7VWRL86cqY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=r65LgNOnpGPF/5rx+zqpFhf2NCU4RprSDzEW0XfSE9HHAh2XEYt4f7vAYG/YkCJvKY0445083bUdBb+A9FzZiONMuGFE2nPN+0QcFaGDyQtKVM1N+ZTsI/856qNLWk6musQRWZdV9F8l8kuyNC8h82MkDNqjcAzDkPiR0HCj1OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XQ1bX/Rk; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id A074B204608D;
	Wed, 22 Jan 2025 17:47:37 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A074B204608D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1737596857;
	bh=/AgXN5KjTnN4GZLmYoXIn9AvgzsPCE77QNdzB5vhL4c=;
	h=From:To:Cc:Subject:Date:From;
	b=XQ1bX/Rk/xz8YWValTiiIbsu1Jp4sp5TYA8tMyWhZREOMFS0OKyawOUDaOO9Zcvq/
	 BCJ4jSq2qUfTFVy/8Ur80p5Q3P7AIOrBZFxEcvr0I+b9hhl4gNKdA9bldJG1no6csv
	 GPdIKUqNggnJ5iZFe8RIh2mHY0JUdzkhgy4VW8VE=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	wei.liu@kernel.org,
	mhklinux@outlook.com
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	decui@microsoft.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	arnd@arndb.de,
	jinankjain@linux.microsoft.com,
	muminulrussell@gmail.com,
	skinsburskii@linux.microsoft.com,
	mukeshrathor@microsoft.com
Subject: [PATCH v2 0/2] hyperv: Move some features to common code
Date: Wed, 22 Jan 2025 17:47:29 -0800
Message-Id: <1737596851-29555-1-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

There are several bits of Hyper-V-related code that today live in
arch/x86 but are not really specific to x86_64 and will work on arm64
too.

Some of these will be needed in the upcoming mshv driver code (for
Linux as root partition on Hyper-V). So this is a good time to move
them to drivers/hv.

Signed-off-by: Nuno Das Neves <nudasnev@microsoft.com>
---
Changes in v2:
* Fix dependence on percpu output page by using a stack variable for the
  hypercall output [Michael Kelley]
* Remove unnecessary WARN()s [Michael Kelley]
* Define hv_current_partition_id in hv_common.c [Michael Kelley]
* Move entire hv_proc.c to drivers/hv [Michael Kelley]

Nuno Das Neves (2):
  hyperv: Move hv_current_partition_id to arch-generic code
  hyperv: Move arch/x86/hyperv/hv_proc.c to drivers/hv

 arch/x86/hyperv/Makefile                  |  2 +-
 arch/x86/hyperv/hv_init.c                 | 26 -----------------------
 arch/x86/include/asm/mshyperv.h           |  6 ------
 drivers/hv/Makefile                       |  2 +-
 drivers/hv/hv_common.c                    | 23 ++++++++++++++++++++
 {arch/x86/hyperv => drivers/hv}/hv_proc.c |  4 ----
 include/asm-generic/mshyperv.h            |  5 +++++
 7 files changed, 30 insertions(+), 38 deletions(-)
 rename {arch/x86/hyperv => drivers/hv}/hv_proc.c (98%)

-- 
2.34.1


