Return-Path: <linux-arch+bounces-9167-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DE29D9C71
	for <lists+linux-arch@lfdr.de>; Tue, 26 Nov 2024 18:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5480C285A4A
	for <lists+linux-arch@lfdr.de>; Tue, 26 Nov 2024 17:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261BD1DDA35;
	Tue, 26 Nov 2024 17:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qpr+o188"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE921DAC90;
	Tue, 26 Nov 2024 17:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732641838; cv=none; b=MM9Dk1bvWTKCKLsKkaJyCiSyGDt7qKsAYsz1olPLmRSFj0AVKI+8vCiNO1rgrEoZjebiHECN5u1m1nmwL14P6wK/VA5WR3kuzFnIniFdVEnBeO9DZPnfXEzOUkcyWOZGSiv664owSZbccOO+2m7RS3YpB82Uab44Xe5JPJzwdxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732641838; c=relaxed/simple;
	bh=iEt60t+44TZTZTJPgClb2mTSiitDuQ4tBir6K4CL7PQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pP53xeL0mAwS5csxN+Gdh8euOqvpxyZAuhx6OFrRc29TqFWdbNGfDgUVNaIw0zJ/OT3AT4LsCIxX3VePvsLHkf4lw/iLnBiSJ5vCayDTRamOgmnFlIAgq+Gs+OS89XLBK65clKKHs0uoa8Jsd+Hyd/+VvMXSBsVukkYGczNpTPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qpr+o188; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53dee064f00so1089237e87.3;
        Tue, 26 Nov 2024 09:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732641834; x=1733246634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n5NofcZHiN/mPTufbVMAYbTQYvMqATiuy7cs+7+mqOw=;
        b=Qpr+o1881aKO8nsDqOD//3NCeRNCf/vgj2y1jsdgHzkxF0VBhOEwX7GXwfJeZGeXSZ
         n6CkEYd6WZLRmkQTJCDTXB6EvjvH3Kg1H4K40tixAjZxfeK2L1osJMSgAgfJAZdpZcG+
         1Y8mqfH17LUcMAiJAsyHhjlr/swKEPXhGRbyE4KQQKbodnZzJYt5+Q0h2g+NXl3qdLqC
         JtslcTYFIbWKoXipcCccwOVxU/TLbZXjmuMz1W8/wnIivYZSsQ5R89b9llXHYuc5vv2g
         d/RG0P1T/uVmu4bglg3h0+k7OhHd4nYqwldPnIN+6owcA/jYuSPHaISC0Jm3yGKbaJ6t
         05qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732641834; x=1733246634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n5NofcZHiN/mPTufbVMAYbTQYvMqATiuy7cs+7+mqOw=;
        b=na/lG/iy55aqgKIzbj05zpgT7PjC32cnDsVFB7DRN0GZKMNA+PV/ju9pYCXvCvakKi
         3F257kKm0BA6ufjLB4Em9lZ4F9rmDhAY2BggZi1gqbP/0iB2BpkqQ4bzae40cJNpsAP1
         7cvoeqPvXTD2CEsidW+4bD9CWklWMsT9sRlnE6/wwlNFgBZxERhPg+d7VpmF4GLJ/5dC
         op8LlLTQ3/7cORdrat4SpkXT96tREsoqEXm9tzMsyb7n/fH0CXBVgKvkKdEyAVKM6YSf
         ePfR8swaD2AM1x/krH8kUbX9la+szoRRJ1z5fzPVGqmtH2M9hx/N2bAGr/HgZhY8D9ZP
         BVDQ==
X-Forwarded-Encrypted: i=1; AJvYcCU02yndtHQ8DonEywqXuzT+bWdcq0tFjPXsgV9Hmk6C8sOmzAq23nclIyxY2uz43NHMFMAI9rCC@vger.kernel.org, AJvYcCUdDeFDh4QMMFoITOaxc+JtUdTfWXrYaNVLXgaiPT2oPWUlQQ5jBIDS45KK4qMOEm2GzkWeuWuR2ckpFrPN@vger.kernel.org, AJvYcCVslzznk44jEnicaZZhlMLHz1wKCo04ojMAjafHJ6UsOVuG3dlsq+VvAbXn8YgjsAXpXOl+HsyZ7MS2DCVNMTk=@vger.kernel.org, AJvYcCWzKrvV+p19ybX3xrOiCYO6mtPH2aRHVux72ibs8KXglNjxykqvmHh0d+RloECHu3nHntQj4p2A7r3W@vger.kernel.org, AJvYcCXfT308PTSlz+8B03+8+AvSZavnYp7UouFnVtwBavZePJaZBs2OZtGNCktLxcF0asUad5kqPd2hcCY4Ew0X@vger.kernel.org
X-Gm-Message-State: AOJu0YxYz85qwUZj1HPyQb/PBgbkUz7RaIgljIEdlrouWU9qF5RF1GT+
	JGqmH5uoi3iZsX1EuM3Rw2CfJ9tVgsefa56SReVrKj81d7FjkDyH
X-Gm-Gg: ASbGnctHlqZrGst/lGVw8DZrKzBT/1pzZhUuvJv+YRFZRKV/kbNcHKXexPY46lphbpD
	gvwE4Mm68boe9y/6KehFM5MVKZvJYHjl/4FbO3uWiMcMuXi2ygBfHLRQeZ3ziymr3AxDuooouTo
	Objp0Mg1H6z+RlevWbAq/lV70obw+V7RVirVdzW2e5hoyoYyLalJ0KtjrcRFVQoqDXCEMMXImc7
	xmTtxmOsazyToLGFfz5UEe3xOHvquAHs2gwSrCT+ZTmy3BaqjtnNNCordI=
X-Google-Smtp-Source: AGHT+IFIkpku7uKl9KKAwOvhvPeOWflgDevT092ovp6tlkSzp8pl+CUkXBrRACuxkb0yqjHw9Xdg0g==
X-Received: by 2002:a05:6512:3ba2:b0:53d:a012:efe3 with SMTP id 2adb3069b0e04-53dd35a4ccemr9018215e87.11.1732641834066;
        Tue, 26 Nov 2024 09:23:54 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa534232086sm473832866b.42.2024.11.26.09.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 09:23:53 -0800 (PST)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-sparse@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	linux-arch@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	Nadav Amit <nadav.amit@gmail.com>,
	Brian Gerst <brgerst@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 1/6] x86/kgdb: Use IS_ERR_PCPU() macro
Date: Tue, 26 Nov 2024 18:21:18 +0100
Message-ID: <20241126172332.112212-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241126172332.112212-1-ubizjak@gmail.com>
References: <20241126172332.112212-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use IS_ERR_PCPU() when checking the error pointer in the percpu
address space. This macro adds intermediate cast to unsigned long
when switching named address spaces.

The patch will avoid future build errors due to pointer address space
mismatch with enabled strict percpu address space checks.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Dennis Zhou <dennis@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Nadav Amit <nadav.amit@gmail.com>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 arch/x86/kernel/kgdb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kgdb.c b/arch/x86/kernel/kgdb.c
index 9c9faa1634fb..102641fd2172 100644
--- a/arch/x86/kernel/kgdb.c
+++ b/arch/x86/kernel/kgdb.c
@@ -655,7 +655,7 @@ void kgdb_arch_late(void)
 		if (breakinfo[i].pev)
 			continue;
 		breakinfo[i].pev = register_wide_hw_breakpoint(&attr, NULL, NULL);
-		if (IS_ERR((void * __force)breakinfo[i].pev)) {
+		if (IS_ERR_PCPU(breakinfo[i].pev)) {
 			printk(KERN_ERR "kgdb: Could not allocate hw"
 			       "breakpoints\nDisabling the kernel debugger\n");
 			breakinfo[i].pev = NULL;
-- 
2.42.0


