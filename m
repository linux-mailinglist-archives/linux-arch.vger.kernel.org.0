Return-Path: <linux-arch+bounces-8534-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 738C79AFE71
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 11:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A27651C20B9A
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 09:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1822B1D364C;
	Fri, 25 Oct 2024 09:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="McNtDpCw"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F2F18BC0B;
	Fri, 25 Oct 2024 09:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729849272; cv=none; b=ty7QKAqiBXb7h91vsjauA0XmDJpMSE8uMw05l1uwK9uAC1mdi4+JwGBMtf0r6LtFkxTsNZBr/z65ir/hymrf4qaTVHK7xsXHl9kM0F8Mbttmiuy9wZzeP8sH+0KC+bna3HmprNOa+HrvdFVmrjU2JtBrKrkzE8OnF+86YyGN9SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729849272; c=relaxed/simple;
	bh=Hah2EZUe7CgPQAjXHt6b7wT95EAGMHPfyzvXP0UEAKw=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=j5owjbsUJMDwoJHkeMC1DBobyOHJwg+wvskMMgtE9zDa3uR3tKdGA9JLHNftVX/l72GHSyekdY6tdDXQyTNkMtmLE/NmOsJGKqrqetvF2B0l3+NQvVgFBrP7Ib9QiQHD3ZFxnAlzEdo/orrXwB9/WLmccKsA7iMS5sFn9hCigFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=McNtDpCw; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=0AEHQ3fQNKjih+WCnZnELy/0uqQ93GQb79KeQAZqpzY=; b=McNtDpCw6pjIEqx1QyIATJefZK
	jqyWF8iz8+9HX4WnJpzMD8QeilUseTQ/PQxpt024ZVD/RTbhE2tzhZ+M/+sMzWodfZvKGmRh7vTDY
	D945hn22VNwRJmsnRB3v9+4WCSKNbd4TATVzNAbtBJt9+x4jkyi5nOYLY1wNL/WNVQVfXYEuvvG2O
	hPH4rkssuZZjpoq8BUzAO3IwaAYFV0c+9uEE4NgB5vt9Opiyc99u2bFWew65H/TLWbqdFct9PK3lN
	zEzc6m0D1tLFmVcsU/VQR5xdkfd2KZ5i6yRkA2knj8/7wCTsbUcl606O1YdIYtnxPvDFZ+buX759U
	aNbpbWRg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t4GoU-000000054PN-00f2;
	Fri, 25 Oct 2024 09:40:58 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id CDA73300ABE; Fri, 25 Oct 2024 11:40:57 +0200 (CEST)
Message-Id: <20241025093944.372391936@infradead.org>
User-Agent: quilt/0.65
Date: Fri, 25 Oct 2024 11:03:48 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 mingo@redhat.com,
 dvhart@infradead.org,
 dave@stgolabs.net,
 andrealmeid@igalia.com,
 Andrew Morton <akpm@linux-foundation.org>,
 urezki@gmail.com,
 hch@infradead.org,
 lstoakes@gmail.com,
 Arnd Bergmann <arnd@arndb.de>,
 linux-api@vger.kernel.org,
 linux-mm@kvack.org,
 linux-arch@vger.kernel.org,
 malteskarupke@web.de,
 cl@linux.com,
 llong@redhat.com,
 Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/6] mm: Add vmalloc_huge_node()
References: <20241025090347.244183920@infradead.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

To enable node specific hash-tables.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/vmalloc.h |    3 +++
 mm/vmalloc.c            |    7 +++++++
 2 files changed, 10 insertions(+)

--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -177,6 +177,9 @@ void *__vmalloc_node_noprof(unsigned lon
 void *vmalloc_huge_noprof(unsigned long size, gfp_t gfp_mask) __alloc_size(1);
 #define vmalloc_huge(...)	alloc_hooks(vmalloc_huge_noprof(__VA_ARGS__))
 
+void *vmalloc_huge_node_noprof(unsigned long size, gfp_t gfp_mask, int node) __alloc_size(1);
+#define vmalloc_huge_node(...)	alloc_hooks(vmalloc_huge_node_noprof(__VA_ARGS__))
+
 extern void *__vmalloc_array_noprof(size_t n, size_t size, gfp_t flags) __alloc_size(1, 2);
 #define __vmalloc_array(...)	alloc_hooks(__vmalloc_array_noprof(__VA_ARGS__))
 
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3948,6 +3948,13 @@ void *vmalloc_huge_noprof(unsigned long
 }
 EXPORT_SYMBOL_GPL(vmalloc_huge_noprof);
 
+void *vmalloc_huge_node_noprof(unsigned long size, gfp_t gfp_mask, int node)
+{
+	return __vmalloc_node_range(size, 1, VMALLOC_START, VMALLOC_END,
+				    gfp_mask, PAGE_KERNEL, VM_ALLOW_HUGE_VMAP,
+				    node, __builtin_return_address(0));
+}
+
 /**
  * vzalloc - allocate virtually contiguous memory with zero fill
  * @size:    allocation size



