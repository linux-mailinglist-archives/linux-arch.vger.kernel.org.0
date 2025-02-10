Return-Path: <linux-arch+bounces-10080-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8096A2FA03
	for <lists+linux-arch@lfdr.de>; Mon, 10 Feb 2025 21:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10BCE1886A0B
	for <lists+linux-arch@lfdr.de>; Mon, 10 Feb 2025 20:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F632505B2;
	Mon, 10 Feb 2025 20:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="iC7pYDk8"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCE224E4CE
	for <linux-arch@vger.kernel.org>; Mon, 10 Feb 2025 20:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739219206; cv=none; b=hhO2ojz9tOpgVZgA9r6IWPKubLD+hOheRoB2nuWEEzXCoRCPUH2RqGkkpi3BLos0A/RTlYqQC4ynTNOrfVTD9VU3Od5ns3tMNintJa83OrtUtOw4DOUie4y8yuKKAZ12jnPGJp3ZpYFkVDG61DN57ps0KzK7gaE/1bdzZUwpSxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739219206; c=relaxed/simple;
	bh=fvZEXse498MAei+juRUqd4/R9FeoMw38NPBzNnBXz58=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HZPPgR+PtEr8oFSxhBerqZw0NoDnFcBLqoLBC7SOGRsscAbt/yE0WfL1LaFxPsCjAr65cpS8hicr5gY1jOy/pwKGqp0+Y+cyBwM3m9rSIq2E6lfP0bArpZtKrGDQSR82FSnRZjCwjYJ38K2iu0ZjoYhCJ4UOu+xxD+Mx/Vhedq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=iC7pYDk8; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21f40deb941so100108595ad.2
        for <linux-arch@vger.kernel.org>; Mon, 10 Feb 2025 12:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1739219204; x=1739824004; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ADFXc53D/cc0VutYfr8tgUjvI5cmEZUhOUtSZhfaHM=;
        b=iC7pYDk8OzVxQx34StINsJPUvclETZ51O3nqxZcnMRSSI0pS8YDMF0tl8RACTkwQG1
         EIIJa2hvUhAVSC+NK6x6cB/zpc5BIggq+ffK/Ym2uhs4ypf0q2MlPhm5MFXn7yA/Gf6F
         VdOjpYaR05YpLdXjNcCB2S9lj2E7PfIhoCe1iV2Y5NiD8xM3gPoCtzDvZUuQNKTqaDam
         5jUhVk6vThDz40Xv0p6Y+HrPqiqmlrwqbV+py7GwueSfLxT16kT77zCvYQ3bOcgXpGbL
         QvNH7BGhaCPklt4xoP9kS/jPJ3JIlgqTeRw9uXFt1GvOJXmOqXtXeDycjD8c4kPaNlhL
         HhyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739219204; x=1739824004;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ADFXc53D/cc0VutYfr8tgUjvI5cmEZUhOUtSZhfaHM=;
        b=Fmp2mDZLhWujwQOFmGIfG35vPoP2sUKDZrkBcnuiHZlF1u6OFeuSGMX99KUh+2dPwp
         xoO+8TYWJicFTvlW80bZpF99sAnoJ3XPoUHFksIw1frWxsxojlgbLIqpRruoTv4IDW9e
         lV573S9HTap/UKW3g+P/YuLmzbkkqy1jTzRarL/LZO2epo8bU3seIRbwBTqyB8ZG1pPc
         PcJ3bJ2MELiFKqLHu1x3YuGPYwjbQLhmQwyQ4pzH+CfO9mqDk5LQFp8KTG9Cj47pbUeY
         2RTPXUQmlF4IgaEdMFbYuG6zLPQkVNP56eBdqcJrEtQgVHIYt5FQZS2JCLdOUVPwrnQR
         /6hg==
X-Forwarded-Encrypted: i=1; AJvYcCXwHp2E8O15p2cchwJ1Z648Hf/xXBY+g5pdJ3vi41ydWD0tZ20Wb2O3MYLV27w3+lWXWefzfJiRM+UR@vger.kernel.org
X-Gm-Message-State: AOJu0YzNWxYHIPXqnmV4tJF0Jk23NV/zqKVqL5JyligAHGx9nCr5GoHp
	f305D1OMeMF/50xHBkipGCR5f2YgamBISVwHo9fdGK/8JMtRdT0+E2JDgEjzhz0=
X-Gm-Gg: ASbGncuRffU5mZAt9GNTyfv7cZA04oIu+K1erd7Ba8fg3FId13Zky9Ws/ZS1K8qTzmu
	8SmUMHVX3BTxofx41sF1TozRKiJtmHh8mFTiQ8EFM3G/zy58VNvUhKFfsZ0WWjLHhs4XwZJigm0
	SLIzsn+aGfsGHW9lubyk3x1GqW+MrT7CO97sZmunMV9RAhl4yfkO35YvfgVDqHHagWNFSOu+DuO
	8XDLWMg3wt8rFOi0ovzFmGOZ62tJXkVRZeya0klInsmYY8SnNTTEX6vVdc66qnFoVYhz/UfFknD
	60aZC3Fl66yqXvauCAY5fMRE7g==
X-Google-Smtp-Source: AGHT+IFznxG4IUsH1vtGUm0FvXVBvTHvmf0eQhdxQZjLsHpvXLSfCmOiU5USFlGIslppLz4th5AW+A==
X-Received: by 2002:a17:902:f114:b0:21f:75c:f7d3 with SMTP id d9443c01a7336-21f4e798104mr179051845ad.38.1739219204274;
        Mon, 10 Feb 2025 12:26:44 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3687c187sm83711555ad.168.2025.02.10.12.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 12:26:43 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 10 Feb 2025 12:26:34 -0800
Subject: [PATCH v10 01/27] mm: VM_SHADOW_STACK definition for riscv
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-v5_user_cfi_series-v10-1-163dcfa31c60@rivosinc.com>
References: <20250210-v5_user_cfi_series-v10-0-163dcfa31c60@rivosinc.com>
In-Reply-To: <20250210-v5_user_cfi_series-v10-0-163dcfa31c60@rivosinc.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>, 
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
 Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com, 
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com, 
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
 rick.p.edgecombe@intel.com, Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.14.0

VM_HIGH_ARCH_5 is used for riscv

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 include/linux/mm.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7b1068ddcbb7..1ef231cbc8fe 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -378,6 +378,13 @@ extern unsigned int kobjsize(const void *objp);
 # define VM_SHADOW_STACK	VM_HIGH_ARCH_6
 #endif
 
+#if defined(CONFIG_RISCV_USER_CFI)
+/*
+ * Following x86 and picking up the same bitpos.
+ */
+# define VM_SHADOW_STACK	VM_HIGH_ARCH_5
+#endif
+
 #ifndef VM_SHADOW_STACK
 # define VM_SHADOW_STACK	VM_NONE
 #endif

-- 
2.34.1


