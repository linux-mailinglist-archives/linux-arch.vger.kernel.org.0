Return-Path: <linux-arch+bounces-14934-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 898D1C6FDAE
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 16:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 98DA94FE308
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 15:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652092E543E;
	Wed, 19 Nov 2025 15:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FsCbIJad"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8A536C0CE
	for <linux-arch@vger.kernel.org>; Wed, 19 Nov 2025 15:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763567148; cv=none; b=ONlcB5iebeA1S+Ki8voRNmzYFz3LndYpq3vMXPRbJ2Y/cRbW4tCquY1B1FhhWRIF2y7A4HGA8RR9bd1dKKG1jvYRUNQW076vP1gxyRO5u0SYrvqandjHfvjuC2g0jT6Hf2+0oRbB/K4Tr0o3mW/nDYTB+azN5XdL2ZUdBpE9RK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763567148; c=relaxed/simple;
	bh=oxMJ7nEx298nSQNAUvIm+RfzZDeUkq7JnffHAGnHY2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HZlFCgT7A6fgLGXbvXmi0nNKn/bqAgSqkA9Z9EFJJNHqObeAQ9W+VyukRMsOvLGoMjYtRKWtQmc91O6Uk3cHu8ETKWycX18DBwfq09T2xY3JaJ9xFxUQy9/752h3eV8sSuSjyMCgZ++fXMOQ9Wj6+5iqyCnNpQPnjvo7hjhX/aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FsCbIJad; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42b3c965ca9so3588432f8f.1
        for <linux-arch@vger.kernel.org>; Wed, 19 Nov 2025 07:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763567141; x=1764171941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ERGSngcgAQCpMTKH+vT5ZfmIUQiWuwubvJ1CKsgHOkU=;
        b=FsCbIJadiUYCr6ejMirqwdULle+dFIB303mznY92UxGov8aRpXM1+QZ0YZAJZUD4WL
         dEklnlMCpvxXLYdxfYsOMAAtdJ7Y89yogdYrFJamQiRz30daYx5LMFbN32HWiJubddSV
         yKSmzvQbxm0kZ9/kKiXGX8ElkghkgmgldHj7ofdE/8tU2HEt33UbAYAY1F3di2i4/P0U
         23nzNwXa9vf8tpAXj4yyp7i95O+QXZpgrtz3n/IVl1PCKWqIBOzKJ876OYZYt+aiyuMe
         u+98CAqWIInRKYI88txn1aq/8lAHBVFah13SAXvoapuq9p6LywhU7eCXy7B7xaClvy7C
         x/IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763567141; x=1764171941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ERGSngcgAQCpMTKH+vT5ZfmIUQiWuwubvJ1CKsgHOkU=;
        b=H4IcDaRabFiPtWZmi76yzu5zYqXD4VgmpzrhwECh8dTNYj00dwsAQ6oAd0ixhWOWfp
         I7LX3l+7Ra/+wvo4Su6OziN91uZeLFPxl+ytG/WGxeJUJ6GABQ/aOpe59bdsQWqIDAcU
         Mx4UYkd7SYqQCm39CKpB4hbsFkmbxti4y0QF4mDV+v/aDRN2tSSEvlOFGpAwYInzy2yA
         JLMwjcAEIbT1SHffj/dO6Kzek+WvVisBSpZuiTqb+GQNlGJJ6aqarRubyXm7Sbo17G4y
         xMIRP7uXWJziqXjwMSD9py5OhjOnY0BgIh3zFefN510KYXz8xQsWa0F3v0Bh81AXlx8+
         uGqA==
X-Forwarded-Encrypted: i=1; AJvYcCVZWrBUUatp+EFuYUynx5Yn0Xay9/QuD46qXG1SMugPD4FZGIVKXMhuJagK7OyEN5+fk5bjEJbGU/k7@vger.kernel.org
X-Gm-Message-State: AOJu0Yyiefq/yEYOYB6UNPMuxDbT56WPncyPykLkr7IGocfhKR8hqVi2
	hqdrCqOt4auu6U96rBA+Zz/vQgNwqErdKfE5Wyxiwhk9vQmbDTdG2Z7spgdsD3x7Vac=
X-Gm-Gg: ASbGncupq+HHPr3luvljkvcVY96dLiXsRXyxwTyxDepv5Yqy5a6iKtP5HJJZPERN1ke
	meJkIUI+diM716vDusng2gE03vDTFiNulF1yQ7ytvZlztGQ1rLdKanzuZjYpWZNxqK4ftdUMIT4
	TNUbhsw2iIYhWAb+OnbWprct5Tf6sG+FR5/4CLHLbA+9S/IwZr2bC6hXzJriC6VNybbJFeb0OQ0
	cUazvT3A5U/Eb5ZOqsUMqwjmYhPLYq9Fb6tor812XGoAAz8utwNZOBEPXakg49L43iE/cX95RoS
	uOxrxjEeMGpyzveAwxHhu5Z1X/fbRuBd5sRKnyb3RR7DCZfeQstzZlqm6N+pCWbPJQBUSah9ofl
	2juUIX3Qyw3mOk/agp8AtJ5RRW1DgmZFNrJVqHL4uN/L9tNYW7qgxFLT2o3yUsJYkbD1rhQBj5c
	guuokmm0I6lCoFmx9TOQPZBMki2fqqig==
X-Google-Smtp-Source: AGHT+IGbRbXBdWPtS8s2pezZSC/ny/HyWuyG8gk1o+dQWRtSU7DtMYRlEtgHBlikDrn4myL+c90Kfw==
X-Received: by 2002:a05:6000:2410:b0:42b:3978:158e with SMTP id ffacd0b85a97d-42cb1f9e99amr2655929f8f.30.1763567141134;
        Wed, 19 Nov 2025 07:45:41 -0800 (PST)
Received: from eugen-station.. ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53dea1c9sm38765632f8f.0.2025.11.19.07.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 07:45:40 -0800 (PST)
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
Subject: [PATCH 14/26] panic: Annotate static information into meminspect
Date: Wed, 19 Nov 2025 17:44:15 +0200
Message-ID: <20251119154427.1033475-15-eugen.hristev@linaro.org>
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

Annotate vital static information into inspection table:
 - tainted_mask
 - taint_flags

Information on these variables is stored into dedicated inspection section.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 kernel/panic.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/panic.c b/kernel/panic.c
index 24cc3eec1805..e99539e18054 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -37,6 +37,7 @@
 #include <linux/context_tracking.h>
 #include <linux/seq_buf.h>
 #include <linux/sys_info.h>
+#include <linux/meminspect.h>
 #include <trace/events/error_report.h>
 #include <asm/sections.h>
 
@@ -56,6 +57,7 @@ static unsigned int __read_mostly sysctl_oops_all_cpu_backtrace;
 int panic_on_oops = IS_ENABLED(CONFIG_PANIC_ON_OOPS);
 static unsigned long tainted_mask =
 	IS_ENABLED(CONFIG_RANDSTRUCT) ? (1 << TAINT_RANDSTRUCT) : 0;
+MEMINSPECT_SIMPLE_ENTRY(tainted_mask);
 static int pause_on_oops;
 static int pause_on_oops_flag;
 static DEFINE_SPINLOCK(pause_on_oops_lock);
@@ -662,6 +664,8 @@ const struct taint_flag taint_flags[TAINT_FLAGS_COUNT] = {
 	TAINT_FLAG(FWCTL,			'J', ' ', true),
 };
 
+MEMINSPECT_SIMPLE_ENTRY(taint_flags);
+
 #undef TAINT_FLAG
 
 static void print_tainted_seq(struct seq_buf *s, bool verbose)
-- 
2.43.0


