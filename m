Return-Path: <linux-arch+bounces-9306-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 563749E87D8
	for <lists+linux-arch@lfdr.de>; Sun,  8 Dec 2024 21:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FD261883E71
	for <lists+linux-arch@lfdr.de>; Sun,  8 Dec 2024 20:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C7619343B;
	Sun,  8 Dec 2024 20:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdACvJPY"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD4F12FF69;
	Sun,  8 Dec 2024 20:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733690847; cv=none; b=mA3v/59xdIxR9sTYi154/4l7ZHbrtdbrgOyXtUGWP814KHYotrNRp4Mu74AC39+LheIJB4hUVH1Hdu0gUI7YDuD5MJ0nAEHchzdodT95uMQGPH0ZvJxDquCb/qoiPqiGPrmo0ETFjP8hpuBSXt3H/ENXUAMrWuLcKhSoFsr6mq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733690847; c=relaxed/simple;
	bh=ogmAtJgEaFLWhDuyZKKcCqZcT06MJkx7e0moOOTVcLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hZreUS22CVf0ya74MwhMfjpz87lFMbtGZJKzns7v184PLW466g1wNwtw/65KKM4GZdzopUxJr/VdqZeQ9CrWzD1Bg/BSpP3aKCBcklQHUIoft1Mw2iuBrhZNqlbT/MV5/OY6nxOblzDxyarblbmFrbmYmE2pkw8PvHMBTqmGg6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gdACvJPY; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-434f7f6179aso2702725e9.0;
        Sun, 08 Dec 2024 12:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733690844; x=1734295644; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3PpdJnIt0LB5LuubDznUPiNtcUhO58iUpeI8CzsV/cw=;
        b=gdACvJPYhdI/HOhtK2q11nJoO8fsIwdTNEET6yGxtRsv1pVq8QF/jjEvuBBxGUygMe
         ZFKWZ9QNCYNEXyIr0K3h8WSAFwbkY2m/dmrCqdfRzLbJgA1EiFnZWtRssB6JICPiK+fk
         G+3Zy7JthkMteJ+NYa36XbZIwn02TiIwyor1fAg0tegK4oWsUdciI+LA7tGqDf+9Cnbm
         NJlQ+zWK5D68vMcevDjpf9lTSV4IV1gxRFlWWckVFfnSvt9YXX1NNKgWlZlBQThUc6ou
         0N1W5qS6r7Xg+y4Ow20b4b57h+aOQr9QrJ/foQ6+AMUhZ5HSabUychdf4Ou5FB4e2RcM
         xd2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733690844; x=1734295644;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3PpdJnIt0LB5LuubDznUPiNtcUhO58iUpeI8CzsV/cw=;
        b=aIMn9buBOBIYww8atJdeF+8kaJ+loBcWj5OplNO5H0mVXcs+/hrbheJx3XzbzVo7k7
         GGE6vW488TKgkAWVgDaAhqrqThnLmX8LKB3putp2+UnuZRz+VI9GoXgz7Io/nTxVzFof
         gMRP2+YtBjrfL0DHYeGBzUrVtUEh5arIutcLUl2oKPiFY37oQLBvLa0S+WWjCiDkOMaR
         bsR7aIrQY11mhf5TtXwADBpSfXjPWy/5355+L4VnmRIaz96/rF0vvyd5BDTEiiTE599q
         fZPcztQ1daNSGzCWogTWyEau1/kU1sqRjiUBx1yhzbYoUy2wTuzlsv3sh4HhKH+boSjm
         3CcA==
X-Forwarded-Encrypted: i=1; AJvYcCUckjdXzTmfZLHdN+bP9RWk/kCNoBDMrwsPD/eb6QKp6rl4oYnAL0zeBV9uX7vo3fE21q2Patkv/O72@vger.kernel.org, AJvYcCUpCQcL/pdbElNAxN9JQb0HK+CU70sIsfzM+93YX9LbTzUeiGUM8sIKPrjvmfFF9pMH6jV43z9dykyp1NB0@vger.kernel.org, AJvYcCWM7ahMLVF8/k2iNpAs5WgpYYuJi+uBQfoWKM2uUecajZ3/G3zXYZU5JZ5EddFL+CuOzDAXeyag@vger.kernel.org, AJvYcCWv4eUhcg6A+DkZ/dhgaW8Qnjkm4ejJa552FlcBDukFyD1apjnCQ3+4/pvGQKjNUuGpgSKCKQXFsogh0lren9A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd/uzvtfSDpoL7vXZYXEFy9KBzg+svHstZ74P06DrxbWgT9xSG
	DjcoWjytIVm9fJFGNk/9A+x9N7R/UWod3bdNOBOn7JTigUTMEIE/
X-Gm-Gg: ASbGncsBxp6Adm3WqomviKrpbgNjDrKLBJF6z3pPP9Sm/a1vHyUoG9b01gRyvOHbGNo
	UmZ0FOmP2NDVtgCoEi1qP6YXb5RD6WAPBPhzO5KmBoLvaDtADwFRdkui+6yjThLSjP9Nw8gX9cE
	Oivbv3Om3ogjNU0gbNmE3gLu6qDJPCBrdTnXedJ//rTEoOLgxmB0OLR+HaCbqfRJyCL9+OD01SX
	83jnS9fERcJ9gF2Ka5ucn+3C3Z6xU4/DeFsY1NpbM8YE/jp4dqKPgiQNt8=
X-Google-Smtp-Source: AGHT+IFdmj+6mXpKaatS+ZSrn1/J5DGo/OtucbepOlqgugKcinRIN8pfplGhkw0ngoIgy0n14MnuWA==
X-Received: by 2002:a05:6000:1a86:b0:385:fc97:9c76 with SMTP id ffacd0b85a97d-3862b33d72bmr8784844f8f.3.1733690844014;
        Sun, 08 Dec 2024 12:47:24 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861f59cc6fsm10874975f8f.34.2024.12.08.12.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 12:47:23 -0800 (PST)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	linux-arch@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Nadav Amit <nadav.amit@gmail.com>,
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
	Brian Gerst <brgerst@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v3 1/6] x86/kgdb: Use IS_ERR_PCPU() macro
Date: Sun,  8 Dec 2024 21:45:16 +0100
Message-ID: <20241208204708.3742696-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241208204708.3742696-1-ubizjak@gmail.com>
References: <20241208204708.3742696-1-ubizjak@gmail.com>
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
Acked-by: Nadav Amit <nadav.amit@gmail.com>
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


