Return-Path: <linux-arch+bounces-9253-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7BCA9E59FC
	for <lists+linux-arch@lfdr.de>; Thu,  5 Dec 2024 16:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8219628818B
	for <lists+linux-arch@lfdr.de>; Thu,  5 Dec 2024 15:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1D621D5AC;
	Thu,  5 Dec 2024 15:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYdp8o10"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E9921C9E3;
	Thu,  5 Dec 2024 15:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733413381; cv=none; b=ezIGDW6ztWzYqEC9xgHVYYIWG72SdKE3l8TlF/ZD6eCtsJGuUtAuzsbUhJnUZrcEamf9og1hRxAJFzH5LqLVvyc7HyqvGaeKgJpxvgJLFvyRlvd69MTYcKEYpm3gTRbwe+Bkuu9p9jfu6xl/Xu1SAd9ZHiqq0rWYo6T6k+6+C14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733413381; c=relaxed/simple;
	bh=ogmAtJgEaFLWhDuyZKKcCqZcT06MJkx7e0moOOTVcLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AaD6gJ73EqvERTpPO+IvRX8YwrKOXG8Rra8nekJJIMDJe2m0J69iB9awcWz0KEivDZxEshLwfSFY//uR1fYdPRQAtAVIfTCFJ/zq3MWYAlyhwr5PYEBzIezYOx8/GidtXUU0A6Q9GgODYAAjzW6lCtRBS16gw7nvpB3jdaGKzXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kYdp8o10; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-385e96a285eso648154f8f.3;
        Thu, 05 Dec 2024 07:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733413378; x=1734018178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3PpdJnIt0LB5LuubDznUPiNtcUhO58iUpeI8CzsV/cw=;
        b=kYdp8o10PdUAVd1FH7v3qN/VH6NqkwSVbMerHVWE0o0kh6lZJyyuUhyeY9wk7K9+1F
         q7JE2IOUGrkzDW2D6H8eIozpqa4dXYc0WMKfsfFzGbpZpv/lhHHorft2jphF/bDYi71c
         5n4jPiC1hH6uDb9nbMLNkgJootDmOwetEiuQlJnw3+3d5BCrpuWl5Iytz9rVUXG1aRMu
         vhoFzrsbt6ew2Z8uW4PKcxWgBLGy/J0WAB+YXkdbRVMWhXPf07+hvgLu1OqtwRsYFbBt
         EZkbgeDrL04yX6udmQszCnqY0SBde6oRr3Y/F6Uc4zZ0CyXaw4OzXSIrYQUzKYDmemPO
         1ivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733413378; x=1734018178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3PpdJnIt0LB5LuubDznUPiNtcUhO58iUpeI8CzsV/cw=;
        b=Z+72ssIV35+8u1ghwsT9skRSPEyPhjPuciHxCsS597vDJGKPjQx6dpzWI7T0g2UjNZ
         iXXNjjD00jqDA0HhnOTnhlldsWOWnufqVideZC+1/SnPeJZZRxc6/qXgThKWx6fCDdnp
         6cnbxxZwyREYBNuj9LuBtF7C+oUqxai9d4qRCYEBHFjca/8XHZ6mZAQHddtWW/egKQ3K
         qA9JAbUUrmGC1zOwAXoCsB8XO2G9Zn0UuArzxIkPQu9/iadUrT6KlrqAltKD0aznpbRm
         X5863pyd8MsRZ2mnTgKAKfnNyp2REdSWRFqe/YfrGV54e4z7SVWI2D7UZVSJFsGTJkW8
         pVHg==
X-Forwarded-Encrypted: i=1; AJvYcCUvgJ9gOL7MzNrIgfqMR/48ljkSmYoGRgB91PYmWU/OTC4xlTDspQ4XO3o7H2Z6aFw4fFHIu8dkmf+GKygB@vger.kernel.org, AJvYcCVhmeXOw0cOWIJ/HvvNNbEnY5E6muMd4RLrn0TzMxYKhkJOSNiByozuc2ro1a0byDoTrjKwAes4OejQn01C0aw=@vger.kernel.org, AJvYcCWFlj/pySuzQL1SXKbksczoiGIUi+Ej36DsDolzE2HuKnCKB3PmMBONf6YcMCe3qCVRQWtbNS+P1JpF@vger.kernel.org, AJvYcCXQk5HjcG+d2QT0uYsodqtkSnHEwz/I8YUriu2SIpbT5FHJko2y/eF0meL4E5p5j+l/R/NoBxu1@vger.kernel.org
X-Gm-Message-State: AOJu0Yy11rrsTbfbI9poITA4oXHECSlc/VM4t93JKdbEfQvA+VX8Raiu
	pfoPbDi9vNFTADJHOG2y38OLUSHu18YZi/aZSScCfR0H80IIMdC6
X-Gm-Gg: ASbGncs4dxuRA+hZRFVqxMA08TJRLcw+w89dmGTnUMC629qgs7XJH/Z1T/+frnGfHTr
	x2pm/Njku8UVszuKeo6CbxTyy6Isp5ZwDCu3AZwBkNqtJczSZ3Dusj35cYoRpHvofmxII0X372/
	i6/sINH+9bVriaEZpjwAtpQxj4ys8Ri+qdwSJSyUPMSPXMz66qDHeMJy31O0hqL61jZGxZMdNV+
	exPN6IBgUB0PiVQ3U35+PIJy+elv8kjWhL9zFqaC823/BfffoXZ2L0PL6E=
X-Google-Smtp-Source: AGHT+IHjT8E7BvyXoaNZ42se9YSKI4Pj1z26eB19khUL1Wi5cgUCpT69kmrNNvwAPzpn4fbartlnOg==
X-Received: by 2002:a5d:47cc:0:b0:382:31a1:8dc3 with SMTP id ffacd0b85a97d-38607ae5ee6mr7265481f8f.35.1733413378249;
        Thu, 05 Dec 2024 07:42:58 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da11387dsm27020185e9.30.2024.12.05.07.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 07:42:57 -0800 (PST)
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
Subject: [PATCH v2 1/6] x86/kgdb: Use IS_ERR_PCPU() macro
Date: Thu,  5 Dec 2024 16:40:51 +0100
Message-ID: <20241205154247.43444-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241205154247.43444-1-ubizjak@gmail.com>
References: <20241205154247.43444-1-ubizjak@gmail.com>
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


