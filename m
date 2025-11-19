Return-Path: <linux-arch+bounces-14931-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1A2C6FD73
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 16:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3E93B4F826E
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 15:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4F736C0C3;
	Wed, 19 Nov 2025 15:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pYLbNjJI"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5F5369963
	for <linux-arch@vger.kernel.org>; Wed, 19 Nov 2025 15:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763567143; cv=none; b=Tm29hZaNF6vTB0xKEHUYNtoEI6pDyvxzV6ikELTOTe3Rz0iI6eF0TtiB/QWBmyV3+s0tI7ShQQgPbQo7ic19MF7PLGUCteDdFq2/BoSD2czAMFLWTZjqwjziz4J08OI+FV2GXP+BpOy6V8QdEEihb+EfsnlySdbNt3jnHMUBsuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763567143; c=relaxed/simple;
	bh=3D6cMAtJFcH0eGhpLiRPBCAWIwBu4/DIokVo2lKhkeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VPB7AesTnTwxTeQDAf0YXlOYLdFfYmY6oQcKCjYxc17MOi6fNwohz4BKGwZPRSez7siKKFuBDtQrRQjRrCO78p7T+jxDXJS5iIW8RDfIKKsgQegLyp6TkL0NTmoBts3/KewAgNF+7+6YE4PHEfDuhufIssd/omKpbkIGtNGjvec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pYLbNjJI; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42b3669ca3dso3464145f8f.0
        for <linux-arch@vger.kernel.org>; Wed, 19 Nov 2025 07:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763567136; x=1764171936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1EgUtWpxUoehpDvVbPcVA+GkHlZFESzHxIeFdx8HGLc=;
        b=pYLbNjJIY4xqxEIuEns8uXjvZ7F9isi/7jugo5Qj7mhP9MDL/QpwdMISZcJdNL9qP/
         y9ZVXz8oEfwgevPWLkpZcPeLF47jsOb/XLf6/K0XXuPwugKhs+phJYcFTU6ZYG5E4S/r
         o+Gp6z+r3MWbQ861Bcu8Uuld23esVOU+yE3rs15fEovLoc4dr+ngBE2HsPuDyaaBMk7k
         PRsZEYjW7PPvzzPVl2RzcO++pOHfy+eUzYEjW15SHSG2mnuw9/5gHaT85gJU5KvJyeWx
         dle+WOQC/9zPb3r7giPWeiI3kW7J2GODRp8Myf5WewGW6sR4l53Vhkhm3IGgtNkPpyaU
         tTVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763567136; x=1764171936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1EgUtWpxUoehpDvVbPcVA+GkHlZFESzHxIeFdx8HGLc=;
        b=wahSZ8qpnL9XsOEbzdSURYWVK6iPah2xV2nU6a0sXDQyzi376jUOo9p+mfCL7wP1a0
         kr2FpcBJLhbKrVZXioHjXuM19Enyr6xhqdPKEdM99T04buwo+JnN+KnM7YAcOk1/5GO5
         bgBKS+olDujZcrpcu/hNf6K6Wsyd796VYqIwB0dI57ob075sbOJMmf+pqraygN4e1pbQ
         Yojjnr+ECzyvcBU7LVQIpkH3qtzXDEG2A+GSCucPcuj6MU+whYQ9QSPgORUXPfEAZUQJ
         W8cToQvZPpWAy7KMxDwVX+ICDWP0RjNXR5kFSmkTfMrdoqCcQME9HtfnTzRVUTPrBcos
         TCpA==
X-Forwarded-Encrypted: i=1; AJvYcCVsTSN2WMWRGg6e0uprmE5dF7RYmOKE7zIbmsi4nIqjszfxTGyF4KgmD3pB34vpr9KPGyoJmVu891X4@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ+P2nhJMa+J6yLolkIPgqn0EpCtQyShjsAhodzSMtf6020hUy
	qLFe90Thpnt8MAKXjSvjPzG+dtrJANQMHsmHrziVfJynQUNXHGCO6EtBN4p5HiEXY3M=
X-Gm-Gg: ASbGnctZ3Er075wLxndSEO0lgquo34S5rXoTgMg5bIci8vYK7WSC6xGf67BCxWGYrtV
	mH6rqSXcnmNS+j3ORUtzs4kYzWMqQcUIyvaD/jEo1mQ1uKhdTO9eubKgD9Rx+MEjk8noyfEupql
	EypTuYL9QVtfDMGopXDs2RrMd9x3m8JvOkuB8s5IEiAX1qImQq8V78+zecZc6cmZ++FItfD/Qys
	OwxKAJ2rKli9Q1sj+dt++cMuK121RMFpuMHNNXaqAkMPI/jx7gfG6zPZITK65P0NXfYl8Wr9nl+
	0EKUzblB6cuR5NJcQ1Rtuy7+b8PUPkEt9bEfe7YlUlpnZlveCdi3ozcIEJxjafqWWjPaK0OWCYd
	L5bwmcoB10ll49CqlkNul0GI6Qkj5keoNKI/rizlA5/iz+pJI9exb4s5DYPgUKDeNqxmP4lSusT
	lVWZfDv8jqb+pLw/KAwyA6WDKwEp1S5Q==
X-Google-Smtp-Source: AGHT+IGKFFWZ+AqolHJ3imLY6SMDSF30b2mMpFX+Q/YU64RzAj2P3ofwp9AZZn8blv/guB2oFBfRQw==
X-Received: by 2002:a5d:5f93:0:b0:42b:43cc:982e with SMTP id ffacd0b85a97d-42b595a497fmr21650580f8f.36.1763567135863;
        Wed, 19 Nov 2025 07:45:35 -0800 (PST)
Received: from eugen-station.. ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53dea1c9sm38765632f8f.0.2025.11.19.07.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 07:45:35 -0800 (PST)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	tglx@linutronix.de,
	andersson@kernel.org,
	pmladek@suse.com,
	rdunlap@infradead.org,
	corbet@lwn.net,
	david@redhat.com,
	mhocko@suse.com
Cc: tudor.ambarus@linaro.org,
	mukesh.ojha@oss.qualcomm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	jonechou@google.com,
	rostedt@goodmis.org,
	linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-arch@vger.kernel.org,
	tony.luck@intel.com,
	kees@kernel.org,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: [PATCH 11/26] kernel/vmcore_info: Register dynamic information into meminspect
Date: Wed, 19 Nov 2025 17:44:12 +0200
Message-ID: <20251119154427.1033475-12-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251119154427.1033475-1-eugen.hristev@linaro.org>
References: <20251119154427.1033475-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Register vmcoreinfo information into inspection table.
Because the size of the info is computed after all entries are being
added, there is no point in registering the whole page, rather, call
the inspection registration once everything is in place with the right size.
A second reason is that the vmcoreinfo is added as a region inside
the ELF coreimage note, there is no point in having blank space at the end.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 kernel/vmcore_info.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/vmcore_info.c b/kernel/vmcore_info.c
index e066d31d08f8..6a9658d6ec9a 100644
--- a/kernel/vmcore_info.c
+++ b/kernel/vmcore_info.c
@@ -14,6 +14,7 @@
 #include <linux/cpuhotplug.h>
 #include <linux/memblock.h>
 #include <linux/kmemleak.h>
+#include <linux/meminspect.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -227,6 +228,9 @@ static int __init crash_save_vmcoreinfo_init(void)
 	arch_crash_save_vmcoreinfo();
 	update_vmcoreinfo_note();
 
+	meminspect_register_id_va(MEMINSPECT_ID_VMCOREINFO,
+				  (void *)vmcoreinfo_data, vmcoreinfo_size);
+
 	return 0;
 }
 
-- 
2.43.0


