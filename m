Return-Path: <linux-arch+bounces-9416-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6922D9F57C5
	for <lists+linux-arch@lfdr.de>; Tue, 17 Dec 2024 21:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F5047A4CC3
	for <lists+linux-arch@lfdr.de>; Tue, 17 Dec 2024 20:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EC51F9ED6;
	Tue, 17 Dec 2024 20:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="remxbLmQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379F71F943F;
	Tue, 17 Dec 2024 20:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734467406; cv=none; b=UCYePpQ/RbnkGOolBRzU5oZI9oZ9qJ58YgLOYYOSp3e1Q3Xzvxx56IAZkA2M5WD3rIeN6IQueMHpNnb8gOUcQtEv8+R2hBurtOZUgfMo8XxwFAaf2tTEvMS5UAp5IdQMP1SfZTi2gaB2V0jSlgOvJxeRUUAMjb2efG4es6cC5Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734467406; c=relaxed/simple;
	bh=Z80w1HgxIV3UI8galudFVxy177YA6OE8rE6J+pDqEOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hnRmVMlq5ek/56xCL0q3Vq577Iog9mi1F+1TRezcYF05JlzXkBjAA6or3oJUT/QooWUVygWwLC/V7zpv5nG6VKolDWMDYZMkzuUnprCasmfkaLtyMJGNedpRhhWai5LK8ZQibeKlnUXujuj9mBTJTraStSQFZ3Hr1YbSleUAoi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=remxbLmQ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=V7D68RzS3aDMea5rHMJVmyfJ9DYfvHvk9VNugqZY76I=;
	t=1734467405; x=1735677005; b=remxbLmQOOPXhoOQXNEnIKkIogH5ZUImZecEy6V4R9NyNKL
	UGWey/DE8fq7O5/X3nkt/xHoRPKleY98SW77skHZozrUcDjq5Qc4uMZdFjkyUbSGP/sDtj85D+cte
	n3HGfbM9/G0GLLy8OhMRz9BH9pl4NY7NuHixjafoLSBcaWxWj2zDPAjBK2wMwqABdioWpJEef9aU1
	QK+T0k4TwsENU8Y05gp+oKg36ebn3Vr8eou2K2L6fl8Zjf/BRxt+Zu6xn35N53GAiVjHbIO2dJX4a
	jfAL86MSeOPq/qVq0185bsU0G7qFZciFjElUv6V+aJXY2grt0QXKso2eAGwVa7Pw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1tNeCf-00000002NwX-1yDZ;
	Tue, 17 Dec 2024 21:30:01 +0100
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-arch@vger.kernel.org,
	linux-um@lists.infradead.org,
	x86@kernel.org,
	briannorris@chromium.org
Cc: linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 1/3] vmlinux.lds.h: remove entry to place init_task onto init_stack
Date: Tue, 17 Dec 2024 21:27:43 +0100
Message-ID: <20241217202745.1402932-2-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241217202745.1402932-1-benjamin@sipsolutions.net>
References: <20241217202745.1402932-1-benjamin@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

Since commit 0eb5085c3874 ("arch: remove ARCH_TASK_STRUCT_ON_STACK")
there is no option that would allow placing task_struct on the stack.
Remove the unused linker script entry.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 include/asm-generic/vmlinux.lds.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 54504013c749..8cd631a95084 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -404,7 +404,6 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 	__start_init_stack = .;						\
 	init_thread_union = .;						\
 	init_stack = .;							\
-	KEEP(*(.data..init_task))					\
 	KEEP(*(.data..init_thread_info))				\
 	. = __start_init_stack + THREAD_SIZE;				\
 	__end_init_stack = .;
-- 
2.47.1


