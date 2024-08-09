Return-Path: <linux-arch+bounces-6135-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EAB94D730
	for <lists+linux-arch@lfdr.de>; Fri,  9 Aug 2024 21:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98D56B22DED
	for <lists+linux-arch@lfdr.de>; Fri,  9 Aug 2024 19:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D6B15FCEB;
	Fri,  9 Aug 2024 19:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="BKtJwp+j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cipjsr7o"
X-Original-To: linux-arch@vger.kernel.org
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE08155322;
	Fri,  9 Aug 2024 19:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723231508; cv=none; b=AKA9wme9FR1CZIZJfReoO7ee5fEm7920qdt8YlMNlpduWBAjGe7GVhxUzXMebavRtzKBNDAXaXzxatjjkpdZJejJGJfOrzJvV4XIduBBffriclQYigRewIdPyi2EHQyHDvjfu4Zfp+qzsELEue4Zkn8zjFHylNXr0c+/yE2ZoxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723231508; c=relaxed/simple;
	bh=uUe6W4q60TIzM6COGxfpl3s1qGv48UEeL5is+BxJTZQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WEb+g5lqJ9xZqdCYPrD7V22BYui8bc6pAu0paNUabazuEjXa0PfGTq/eRqxxFOywpDywsdOCSNwzUE/GVnujzr2t9uupF4F0kAMlmtZxhhbD7DG/tzUbgMMrJWkdj0t12VmdWFQ9xkldzR+p+YBY8TO8kiPBFybHsZc+58CNV84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=BKtJwp+j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cipjsr7o; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 3797113881AA;
	Fri,  9 Aug 2024 15:25:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 09 Aug 2024 15:25:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1723231506;
	 x=1723317906; bh=O51QGHyzhP4I5QaSt0wfYi1b+qABRQdEpVBQKmlKluc=; b=
	BKtJwp+j9RPHJvqItEhOAvnPjwmaaDw/Ig6FFJOS8DZWrCSxyJPwlTwi1zZ0tYmt
	Kidhysln2CKU/c/O5wM5Vx0t9oU+wra0/6l9h6TUk7CUFBofv0oG1DEoBdkpGSxL
	45IyZ+8jMmoX7KyO6rLk/fiAj9+Cahn3HpfEK4IJYPsOKegVLcgccRpJ1An77j4i
	rP9dQ4G1Y9R70aezIZiDBNN8QaypppoBc6IljKgvdnvgQUJMKADZOG+kZqzIxYFQ
	wbAOi15LAzrDJYX0QTIsnEhf+nk2dkBZlWwc+Nj9F8uLaEbx87K5G0PUuadsEIeH
	VMWEsqrrjRPX5oNPXMghtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723231506; x=
	1723317906; bh=O51QGHyzhP4I5QaSt0wfYi1b+qABRQdEpVBQKmlKluc=; b=c
	ipjsr7oMvvKhKDcrBmrSjrdco8pEGcKPB4CwGgx8jYoDETo9tIRCbmFqyE3t67u7
	AUFbuFSYMo2zIkD3UkhQXbAezYBU34aL/6qcMr3qVZqwDWWrpC2GIhLKmvHdJ6LD
	f6GDZy6ImoddpdCZmzvHCGr8oUaJjt/uS7G7+ViiznxZ/aPwPZ7gGSKLvH5F494N
	bVzXrLeBRWHa4fsqwG1Sz0HLdP9D6LslJdsTtYe68S/HUd+o/qQFn7Yx2CIcQWuy
	FclQde8ew8zUTivN4YfBKc1kOhJSr/R7CekZmVU6ecWcj7rtOA0h8G7eLuoTC3ar
	1DR2n1nAKGh60dG2WR+rQ==
X-ME-Sender: <xms:Em22ZrPOqnDJ95yJ8e8_SGdouXaAPib_zGyh2KW4VBV5LFjkjg8y1Q>
    <xme:Em22Zl_waH2wwTOlyNf6CoZCkwxe8XAlmmiZJPJKZQ_nMtt_VWJXFizUmHMkjT_tX
    y5e26UQB3XLAnVbXZI>
X-ME-Received: <xmr:Em22ZqQKmJ4Z4N_a21enRCnG-2SnBr8cnRg2ZOazuSafwRchELvxNM2cLtw7Kl_LdA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrleeggddufeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhi
    hgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffek
    gedugefhtdduudeghfeuveegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdr
    tghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    eprghrnhgusegrrhhnuggsrdguvgdprhgtphhtthhopehjihgrgihunhdrhigrnhhgsehf
    lhihghhorghtrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhssghoghgvnhgusegrlhhphhgrrdhf
    rhgrnhhkvghnrdguvgdprhgtphhtthhopegthhgvnhhhuhgrtggriheskhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheplhhinhhugidqmhhiphhssehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheplhhinhhugidqrghrtghhsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Em22ZvtLX2w0L0afPnMtH0Y8X1dPNOBaufCZngSxHUuyJq0hszrYwQ>
    <xmx:Em22ZjegfrTPR2iDD712TQbv8kEBZvhRyf_HB9V7kJkZrWGo11YPXw>
    <xmx:Em22Zr09doNB3baf2O728LZTw9ugPANv2ZZQKoQgSzRmOKwNhKo24Q>
    <xmx:Em22Zv-oqXf8LGw65qcyhHK6fCnZ95JbgA2s47sx9EqJmebNiZ0Ibw>
    <xmx:Em22Zizkrv7HSFStnvLSDnNN4Mc58Z1lfrFvJ3QR8uj7WR3xY_Y4Po50>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Aug 2024 15:25:05 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Fri, 09 Aug 2024 20:25:01 +0100
Subject: [PATCH 1/7] arch_numa: Provide platform numa init hook
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240809-mips-numa-v1-1-568751803bf8@flygoat.com>
References: <20240809-mips-numa-v1-0-568751803bf8@flygoat.com>
In-Reply-To: <20240809-mips-numa-v1-0-568751803bf8@flygoat.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Huacai Chen <chenhuacai@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-mips@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1532;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=uUe6W4q60TIzM6COGxfpl3s1qGv48UEeL5is+BxJTZQ=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrRtufzR4hlp8zd+/pHryf22jGm3ucPr5eGd/27t2imon
 3Bc9uKTjlIWBjEuBlkxRZYQAaW+DY0XF1x/kPUHZg4rE8gQBi5OAZiI82yGf/rh5u/XLd3rzR57
 N3NxuuP/+Njja6cFNSwJ3mVXLuPhnMbwv6yvKeTP2jCB+NbyiGK5vp96Xyd5CTUKXNjnn3qg430
 NCwA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

For some pre-devicetree systems, NUMA information may come from
platform specific way.

Provide platform numa init hook to allow platform code kick in
as last resort method to supply NUMA configuration.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 drivers/base/arch_numa.c   | 7 +++++++
 include/asm-generic/numa.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/base/arch_numa.c b/drivers/base/arch_numa.c
index 8d49893c0e94..d464baeee69a 100644
--- a/drivers/base/arch_numa.c
+++ b/drivers/base/arch_numa.c
@@ -305,6 +305,11 @@ static int __init arch_acpi_numa_init(void)
 }
 #endif
 
+int __init __weak arch_platform_numa_init(void)
+{
+	return -EOPNOTSUPP;
+}
+
 /**
  * arch_numa_init() - Initialize NUMA
  *
@@ -318,6 +323,8 @@ void __init arch_numa_init(void)
 			return;
 		if (acpi_disabled && !numa_init(of_numa_init))
 			return;
+		if (!numa_init(arch_platform_numa_init))
+			return;
 	}
 
 	numa_init(dummy_numa_init);
diff --git a/include/asm-generic/numa.h b/include/asm-generic/numa.h
index c2b046d1fd82..53a8210fde00 100644
--- a/include/asm-generic/numa.h
+++ b/include/asm-generic/numa.h
@@ -31,6 +31,7 @@ static inline const struct cpumask *cpumask_of_node(int node)
 #endif
 
 void __init arch_numa_init(void);
+int __init arch_platform_numa_init(void);
 int __init numa_add_memblk(int nodeid, u64 start, u64 end);
 void __init early_map_cpu_to_node(unsigned int cpu, int nid);
 int __init early_cpu_to_node(int cpu);

-- 
2.46.0


