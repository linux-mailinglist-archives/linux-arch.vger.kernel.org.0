Return-Path: <linux-arch+bounces-10780-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3995A609AD
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 08:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E699717FF19
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 07:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19ACB1EF0B9;
	Fri, 14 Mar 2025 07:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F/Suhrjp"
X-Original-To: linux-arch@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6B419644B
	for <linux-arch@vger.kernel.org>; Fri, 14 Mar 2025 07:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741936328; cv=none; b=buqHprgWiY+JSWwgHQSuQGqgdb0YD2D6R/amsXkuITeOkzdTIFgo+OkvOxRgpcM3dpQ4DEM5G4SZ4LT/fcS5EklyOB8q6Xuw5xkKtHJhdkSAJuRQpVAT4lGhPAvWFOdFjy4wlI6d30+kAq3TMCznfR5IiY07MshQ3OIIOSe6OWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741936328; c=relaxed/simple;
	bh=DuFjyiWTolDqt1Xg1SiJljL2G2E66XhB1UUuXipqG3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sfw/OFz7K5r+mGgM2v/fJcvjlWKq0LNcTzZS8aikifBgrQTWuCoQ0mpDPd6LyK7UCIbI6CbxiAbePQ+Kirjgsg1Vc++dUlsp1D+GHT9xc1EhPWEX/tKyqS1PXE7K4QJ38Cy0RtI+c26VohrGlrC/NbtehZJS0/gvuzHRBd7cL3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F/Suhrjp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741936325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z05efhzc4HDKYHhQuuSXKrqE4ASrrsu6R3EyuSGY2PY=;
	b=F/Suhrjpum0M2BPNowaTi2sy/SzFFLVS5O8XhTccf5+Sf4j+XwCi4alU8wsfOk6v7odV8g
	LPTcnb+tUzeKA9MBiswQauk6gFOJcrQppeCWk2nu2tvsZ+gv6p6Ix+EqYIw3jluZXSIRB7
	t2CmA3t/tyvvTujJ6nh4UBLdZQ7SqW4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-378-iV5nDZriOB2d6JIN2py53Q-1; Fri,
 14 Mar 2025 03:12:01 -0400
X-MC-Unique: iV5nDZriOB2d6JIN2py53Q-1
X-Mimecast-MFC-AGG-ID: iV5nDZriOB2d6JIN2py53Q_1741936320
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AE63D195609F;
	Fri, 14 Mar 2025 07:11:59 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.82])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8125C1801757;
	Fri, 14 Mar 2025 07:11:55 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	Thomas Huth <thuth@redhat.com>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,
	linux-openrisc@vger.kernel.org
Subject: [PATCH 22/41] openrisc: Replace __ASSEMBLY__ with __ASSEMBLER__ in uapi headers
Date: Fri, 14 Mar 2025 08:09:53 +0100
Message-ID: <20250314071013.1575167-23-thuth@redhat.com>
In-Reply-To: <20250314071013.1575167-1-thuth@redhat.com>
References: <20250314071013.1575167-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

__ASSEMBLY__ is only defined by the Makefile of the kernel, so
this is not really useful for uapi headers (unless the userspace
Makefile defines it, too). Let's switch to __ASSEMBLER__ which
gets set automatically by the compiler when compiling assembly
code.

This is a completely mechanical patch (done with a simple "sed -i"
statement).

Cc: Jonas Bonn <jonas@southpole.se>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: Stafford Horne <shorne@gmail.com>
Cc: linux-openrisc@vger.kernel.org
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 arch/openrisc/include/uapi/asm/ptrace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/openrisc/include/uapi/asm/ptrace.h b/arch/openrisc/include/uapi/asm/ptrace.h
index a77cc9915ca8f..1f12a60d5a06c 100644
--- a/arch/openrisc/include/uapi/asm/ptrace.h
+++ b/arch/openrisc/include/uapi/asm/ptrace.h
@@ -20,7 +20,7 @@
 #ifndef _UAPI__ASM_OPENRISC_PTRACE_H
 #define _UAPI__ASM_OPENRISC_PTRACE_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 /*
  * This is the layout of the regset returned by the GETREGSET ptrace call
  */
-- 
2.48.1


