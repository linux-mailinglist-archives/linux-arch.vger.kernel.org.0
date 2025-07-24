Return-Path: <linux-arch+bounces-12916-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A58B10C55
	for <lists+linux-arch@lfdr.de>; Thu, 24 Jul 2025 15:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82F2C188A763
	for <lists+linux-arch@lfdr.de>; Thu, 24 Jul 2025 13:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DEDF2E5B3F;
	Thu, 24 Jul 2025 13:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hL+cbu6y"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7EE2D8760
	for <linux-arch@vger.kernel.org>; Thu, 24 Jul 2025 13:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365396; cv=none; b=Vfm4n+v2Rsi7TQgpUO9WOvaNa4zq0ZDuzunQ8J/cvZnu0OR07nBqpP9knhBaZ1qbvuL4c5boCCbQw1dRgE5TB1VeiErXGDeqxD96twUKXo17WFzkAwmIqPVqKhVZXYHxfUMgweHjSiNweXijUoWN3mGWolomSxD09X5Q1f3nj8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365396; c=relaxed/simple;
	bh=YrGjiFMH/zlkC3aj1afXt5OiVcA/uj0LuVvyhAgKIeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yyun/6lz4HueimOoi9miGYq55hTqr9PGx2Hgzinlg2jZhklVogFI8J73CnUyHPKIrDecX20fmrmfcwddH1HGBinvDy3e4Lcd+2zzIE1YDUYQ+DYsPE1HL5LGR01Lqq+wQ4+aY0HJrNDvc/i8l+nw6FOT6y7nl7sfKaCEvgWW6PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hL+cbu6y; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4561607166aso7021905e9.2
        for <linux-arch@vger.kernel.org>; Thu, 24 Jul 2025 06:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753365391; x=1753970191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cFMrD7tjY0571sMCF+ur1VmM8eA36pvQygKXmIz05uw=;
        b=hL+cbu6yP6EjGyJww08MbKFjb+YHPqZ7YRN2X+iaJQSFXXSoejFtRUQUISGeGk3bnT
         l4Mf3gBSOeQVUcf3zkL0cuXVrR7T6m6I5BZmiqKv0e63ju/1voNOkmgIC5khxZFfZqcp
         6kMDmBdL5IZuYb0WxFzgvRnu3IMyj+HXD2LjI44tjwIJoOS/cZ8FclMf9WupAvrKNtza
         Mlx4V53ttJVOdBW+tWvRS2uZhgZ0UsJpdg+juC7/+pzmSFpUq2azjNcvDQmjqA0NuGng
         w7rYBsSgNtZJISnIcSBRNSMSguYIQCYYRDLA25r1LhK5sR2dkhetmsbw9M++vwI5m0vi
         syMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753365391; x=1753970191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cFMrD7tjY0571sMCF+ur1VmM8eA36pvQygKXmIz05uw=;
        b=bzgwn9g1JsvK+EZetRbj/7XRWLupv4/I4xH6HeX28oKD9Z7OBSIKA2pBymCt4GBS/J
         eoEV+9r02WaX6rANJWWKbe+K78hq1MJpNxLIrQVde7lkqscIvwEoHYdqGzhaC3la+Iri
         mzR/Oc3l4TzKkF4IAOUugvpXm9sTNSZB4A9u5Id0bojbstjZbVks1EYnefD8pZI50KbU
         2cBau8RpZnSQtnAtlYHoEJokll/8+pmqkkOWx41XcaSTgSs3yn1TtedUX8kYni29l6fN
         s64piGLragGL1/FauVsYFuHUX0C9lMbevzu/YjwcoqhQWJ+CPPjw9G8Df5qq3ya8R3K5
         2jwg==
X-Forwarded-Encrypted: i=1; AJvYcCU06/Q58Yh1ZUgaIr0uT23u1DyjfhXMcTZb8ShB/8hE0hZHo2FiKvPkhF7OzV8UrrxRDN3Z4EHbwzc+@vger.kernel.org
X-Gm-Message-State: AOJu0YwIq7/xVKOl6evB2BusVOwPWq4pT2Kz5tkaJJrRtmmw0hioN0Zj
	4B13eMKqf/N3SF02eY1nJAjJrjY41ZQXR/KvieV1KNRmSImj6ZcGQzJfCyKbNr8cIyk=
X-Gm-Gg: ASbGncs5FhM2DXBqhItP1FLq+jbdv/7XtM7+2DirUqBjuPRjeo54NBx5IXc+ixrJ3/7
	1BzVcl8+7F68Z37HmveILYAoIId8GSd10ks/djilcqVKAGNT9DWucGB78NmV6A9ijHvOTfCCsx4
	84KbLNg99+8mHzd24hTS5gLBqQpIXx0kqpJfL5U5NFHQ+flUoeqJEImmIJQk4OYztuffDYtaRJZ
	zu2zKFS6hPX0Vn2TcbQYn51256oJtvFeX7MkvO8LXEPZxDtgbq0UVi6n9u23u95WOP0TPKcGsjQ
	0z5mA9mEyJm23vGmPCAYiYP++2GyDwPProrA8ze4o4CcpSZn9kvvIkgPzUAdOxOc9uR4yfmQym+
	W1i0CoN2shqLaFdkJI12hRY4Mi25apsBC03tlKD5d++PzVHD1+pD8yQWnLHVE6t0T0cWvpPdM0u
	EXIhqk5NMObx37yNmVbZBPhP4=
X-Google-Smtp-Source: AGHT+IHYV/rdyT8foqBo51VlSPNSFrqLVd1yTjWzm4T+7ubMqxXGaXLoYsD4QdIBTbjTZBYyuCKPkw==
X-Received: by 2002:a05:600c:3f07:b0:456:1d61:b0f2 with SMTP id 5b1f17b1804b1-45868d80dd4mr72372095e9.30.1753365391122;
        Thu, 24 Jul 2025 06:56:31 -0700 (PDT)
Received: from eugen-station.. (cpc148880-bexl9-2-0-cust354.2-3.cable.virginm.net. [82.11.253.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054e37dsm20889375e9.14.2025.07.24.06.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:56:30 -0700 (PDT)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	tglx@linutronix.de,
	andersson@kernel.org,
	pmladek@suse.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	eugen.hristev@linaro.org,
	corbet@lwn.net,
	mojha@qti.qualcomm.com,
	rostedt@goodmis.org,
	jonechou@google.com,
	tudor.ambarus@linaro.org
Subject: [RFC][PATCH v2 10/29] panic: Annotate static information into Kmemdump
Date: Thu, 24 Jul 2025 16:54:53 +0300
Message-ID: <20250724135512.518487-11-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250724135512.518487-1-eugen.hristev@linaro.org>
References: <20250724135512.518487-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Annotate vital static information into kmemdump:
 - tainted_mask
 - taint_flags

Information on these variables is stored into dedicated kmemdump section.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 kernel/panic.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/panic.c b/kernel/panic.c
index ccee04378d2e..fb561a2fdb59 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -39,6 +39,7 @@
 #include <linux/sys_info.h>
 #include <trace/events/error_report.h>
 #include <asm/sections.h>
+#include <linux/kmemdump.h>
 
 #define PANIC_TIMER_STEP 100
 #define PANIC_BLINK_SPD 18
@@ -56,6 +57,7 @@ static unsigned int __read_mostly sysctl_oops_all_cpu_backtrace;
 int panic_on_oops = CONFIG_PANIC_ON_OOPS_VALUE;
 static unsigned long tainted_mask =
 	IS_ENABLED(CONFIG_RANDSTRUCT) ? (1 << TAINT_RANDSTRUCT) : 0;
+KMEMDUMP_VAR_CORE(tainted_mask, sizeof(tainted_mask));
 static int pause_on_oops;
 static int pause_on_oops_flag;
 static DEFINE_SPINLOCK(pause_on_oops_lock);
@@ -601,6 +603,8 @@ const struct taint_flag taint_flags[TAINT_FLAGS_COUNT] = {
 	TAINT_FLAG(FWCTL,			'J', ' ', true),
 };
 
+KMEMDUMP_VAR_CORE(taint_flags, sizeof(taint_flags));
+
 #undef TAINT_FLAG
 
 static void print_tainted_seq(struct seq_buf *s, bool verbose)
-- 
2.43.0


