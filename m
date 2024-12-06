Return-Path: <linux-arch+bounces-9292-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7879E9E7B9A
	for <lists+linux-arch@lfdr.de>; Fri,  6 Dec 2024 23:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4900A1887241
	for <lists+linux-arch@lfdr.de>; Fri,  6 Dec 2024 22:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227B019ABC6;
	Fri,  6 Dec 2024 22:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="H/npKA8R"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B010422C6C0;
	Fri,  6 Dec 2024 22:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733523739; cv=none; b=UjNZIZnJ9wUmW8sDNQoWoRMrTJvUsuk9e/BMprEikd7uaAqqwAW/sMQn09YPWgfSIqTsV2HEN/8EBgKUr5hZuzOFBxMdX9TwS26qgt6RHCNLTu4aSHPXoTgp6TMm5p0rILNjAFXYGb/nfpKuC/sCBzf96FPVjZ4roFHzR0CIVP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733523739; c=relaxed/simple;
	bh=y3T/ZExCsSbWQsd4ybXZbB2mzKRbXZ5yYWRziY1x6LA=;
	h=From:To:Cc:Subject:Date:Message-Id; b=scU86iq8grfKjqYDvV5/T7vr3UxKGyGzIdFb8UJ4iC17Fs0LSeC2mJu2DfEUL5HwHQKWboJRIjiV92xRXsNDjlEgnTZ/IA9BCjK/dO8SjQ4D+dLMiLQkqrP702/UUYBwohCWZyvJx7pCFjUl3kaVUcKRUsJm6ocGobd+yq++/w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=H/npKA8R; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1F73B20ACD7B;
	Fri,  6 Dec 2024 14:22:17 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1F73B20ACD7B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1733523737;
	bh=1xuq5MaOVXzbbaRlB1GdkyoZlSh1Oy8sKqF7zlVU32A=;
	h=From:To:Cc:Subject:Date:From;
	b=H/npKA8Rnh47xTBuMa+7BCp4sE2qXydsl8gaqrpBn92P5i6aocUMlsuCaYEs5RQvd
	 3CmReQkLH6fWI9+iBIa/YVtntG1IwD2BAz/ZtUPwWjKUioRxJoL/apEkGWz8oGQJd6
	 rDWOJcfhoixugN4fgn+ehTaiVqjg7X/ZGzyQDMu8=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	mhklinux@outlook.com,
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
Subject: [PATCH 0/2] hyperv: Move some features to common code
Date: Fri,  6 Dec 2024 14:21:45 -0800
Message-Id: <1733523707-15954-1-git-send-email-nunodasneves@linux.microsoft.com>
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
them to hv_common.c.

Signed-off-by: Nuno Das Neves <nudasnev@microsoft.com>

Nuno Das Neves (2):
  hyperv: Move hv_current_partition_id to arch-generic code
  hyperv: Move create_vp and deposit_pages hvcalls to hv_common.c

 arch/arm64/hyperv/mshyperv.c    |   3 +
 arch/x86/hyperv/hv_init.c       |  25 +----
 arch/x86/hyperv/hv_proc.c       | 144 ---------------------------
 arch/x86/include/asm/mshyperv.h |   4 -
 drivers/hv/hv_common.c          | 168 ++++++++++++++++++++++++++++++++
 include/asm-generic/mshyperv.h  |   4 +
 6 files changed, 176 insertions(+), 172 deletions(-)

-- 
2.34.1


