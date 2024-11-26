Return-Path: <linux-arch+bounces-9170-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 831449D9C79
	for <lists+linux-arch@lfdr.de>; Tue, 26 Nov 2024 18:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7440E16751F
	for <lists+linux-arch@lfdr.de>; Tue, 26 Nov 2024 17:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7741DFDAE;
	Tue, 26 Nov 2024 17:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZVbAqtA"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895F51DF972;
	Tue, 26 Nov 2024 17:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732641842; cv=none; b=eclcRR78fAlkP7SUJX7coIo8KDNcydH/9hnJr/JnEPFX4eUEtmP3ZAV5IiRfS5UaoaaqSptB/4oMSIgzY0GX2xus9eAv1BGziA+qtM9VEgGY82Cy8DYdrpifJYZkqeSbsYgDD12VDkrcTNeSQmvdSOmW/m/V1FYQJlIRig2fAP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732641842; c=relaxed/simple;
	bh=UP+TeyFWhapXWWZjm7znhWw8IPamZQWNemWDE3MZkrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MRJjB0WgZ5h/yZz7l5KiwYl4/j7b/3i+Qv0qygQV/IOrGOj/wwUOYEf65QWdtYtCSGYKrnsGESTHiGh2QdG3oRCS2g02eU8fdoerVn1y/5jBxvZREUnXa1NYJORFBGBZeKW0x9X9W6W/JG7VZr9SVPYng4ZAdOBk7jlHCCCET3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZVbAqtA; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aa545dc7105so450296566b.3;
        Tue, 26 Nov 2024 09:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732641839; x=1733246639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e67gnDX037AzEtGr2TTuiC3i0rrMYCYbsdiQSpuFMPc=;
        b=VZVbAqtATMGXVp6f/tdvQDr4Elu31/CEWZIN1LilyE74vMKXcafgXkWHUsoeF0LHjM
         bTxjkzUUJ3XswmjwIqF8v8ECQCejyedbFPqw6FIHaAnIH62cs/PXRZTGWxeiBty/b5rD
         BnoFho+O1fKKxB7MZm+ggGDnpcm8x6nmBXbF9S6Yxi7kG/BcaZdLNl/KQTCmGFDPGHMe
         d5TN3RjH7iWdyIq0cjuQK5U3YAcEyUi2efQqfUdotfLjOgH0D9083EwfJIsJTwyqY/91
         wNa5JazqRBEZKnc5dAUmfUqRUZPpzEibNFoltnbWkURWp6tvSJoZ3T3H4v5s6FqEWW/E
         2lfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732641839; x=1733246639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e67gnDX037AzEtGr2TTuiC3i0rrMYCYbsdiQSpuFMPc=;
        b=B2ZCt47rhcwd7VhQVTjnI2/iXykvOcdeDymVqaRudXhZ3RwVHnyu1iQWPKn8Qi1fkt
         yy0x5EwhXNFxfRdcXq/gW3+61w9UsyKFi5X9nEB0NSZU+Qg3tNT3GX/bLBHRs5YTOHwb
         O8vCXL+Wk7Ib9Tcal0WA5xXIN2xRK2zPcLh2xsbA0UU79R8lF3QDX+Pjnrajs69hUYT9
         iABnUjDbmDr7i3MNjQEPHwycTTWtBX0fSKrSuPQkL5B34GshHxhkdrKt+fQHV8dTwy+4
         bV/uia1bQVeeEuYIyHtUGm9TkXWNKYj+6tHAf7M9d9hIlmc66XNE/+PMHnXt424kY7R0
         4FkA==
X-Forwarded-Encrypted: i=1; AJvYcCU3IvcRrhIc9eO1coFKgRtOcSBhgyDfPIQah2dcW/MsIgnMmC13XYOq4gWPI1VakquRhiJcFTbO@vger.kernel.org, AJvYcCUhulyHblnh6OUUsayZy3DWBESyl+IepM5Ya9rdfB8MwkmrU52VoTWfsp/KaDWv6s+UvkrCDp3yQmTo@vger.kernel.org, AJvYcCVswgmBB5E+9++DPfFnFl4QwyBQSYjUPV4LUxFBs3HA993ijH9vCspxH3fDm5jSAfGSG4EfRTDh1HTy98YG@vger.kernel.org, AJvYcCWh1qpWHgtyJ8xDKpqjYiTt88tT8dZe4l8yeQK6djiBxpKBsp74PjmWFJrWpWxOiV95kAOBRxyHn6RFyNQv2mU=@vger.kernel.org, AJvYcCXrO7pgjNZ00WjqdGF4FEFWDDsQGceFlioU4QCDV9CE4AGhboICTkS8SnDTCbTIVuFD7XVacjnu6KOV7QEO@vger.kernel.org
X-Gm-Message-State: AOJu0YwADh2r7GPl6gNXsFwiHugngUnjNIuT18OaaD/iYou97S6LK9qX
	848DQlOpY8UEDXI8Ztm2J1cRoFdyGvYqumY2G6WAkPF8kws66FqE
X-Gm-Gg: ASbGncuCUuYlOdsLwH1gUc5EzGDPw4jI3eWALxpEA/XUjGRbnKcsk+vXOD2s3kL5rLI
	aY5194hP+mA485Xi700WgDQKAxI66ZyvwmO3hj9xbYFM3K+ToeZbrYtnH3BuXzQ3dBHy246XZVX
	wTf2wEBDYrf/IP6NI36Vvu5fFFxjKwfH518kdWFner5AL1p1uHht/zVjVFVuDXRNzYTT1vuFfBb
	BxN7DvoYD3NDd3Y3T6uaLRlhzZZiCoYyRLOyjxH8uvVl1k+fjLOuXDJ9ZU=
X-Google-Smtp-Source: AGHT+IGSX3RDD4Mjs5KZqKxckix0gq8OkR9npjFRRCctDVzzyNWShDqRqCQCbZlVg9RCDHh4i4SbvQ==
X-Received: by 2002:a17:906:1baa:b0:aa5:274b:60e9 with SMTP id a640c23a62f3a-aa5274b69ecmr1175231566b.33.1732641838563;
        Tue, 26 Nov 2024 09:23:58 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa534232086sm473832866b.42.2024.11.26.09.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 09:23:58 -0800 (PST)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-sparse@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	linux-arch@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	Nadav Amit <nadav.amit@gmail.com>,
	Brian Gerst <brgerst@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 4/6] percpu: Use TYPEOF_UNQUAL() in *_cpu_ptr() accessors
Date: Tue, 26 Nov 2024 18:21:21 +0100
Message-ID: <20241126172332.112212-5-ubizjak@gmail.com>
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

Use TYPEOF_UNQUAL() macro to declare the return type of *_cpu_ptr()
accessors in the generic named address space to avoid access to
data from pointer to non-enclosed address space type of errors.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Dennis Zhou <dennis@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Nadav Amit <nadav.amit@gmail.com>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 arch/x86/include/asm/percpu.h | 8 ++++++--
 include/linux/percpu-defs.h   | 2 +-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 666e4137b09f..27f668660abe 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -73,10 +73,14 @@
 	unsigned long tcp_ptr__ = raw_cpu_read_long(this_cpu_off);	\
 									\
 	tcp_ptr__ += (__force unsigned long)(_ptr);			\
-	(typeof(*(_ptr)) __kernel __force *)tcp_ptr__;			\
+	(TYPEOF_UNQUAL(*(_ptr)) __force __kernel *)tcp_ptr__;		\
 })
 #else
-#define arch_raw_cpu_ptr(_ptr) ({ BUILD_BUG(); (typeof(_ptr))0; })
+#define arch_raw_cpu_ptr(_ptr)						\
+({									\
+	BUILD_BUG();							\
+	(TYPEOF_UNQUAL(*(_ptr)) __force __kernel *)0;			\
+})
 #endif
 
 #define PER_CPU_VAR(var)	%__percpu_seg:(var)__percpu_rel
diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.h
index 266297b21a5d..2921ea97d242 100644
--- a/include/linux/percpu-defs.h
+++ b/include/linux/percpu-defs.h
@@ -223,7 +223,7 @@ do {									\
 #define PERCPU_PTR(__p)							\
 ({									\
 	unsigned long __pcpu_ptr = (__force unsigned long)(__p);	\
-	(typeof(*(__p)) __force __kernel *)(__pcpu_ptr);		\
+	(TYPEOF_UNQUAL(*(__p)) __force __kernel *)(__pcpu_ptr);		\
 })
 
 #ifdef CONFIG_SMP
-- 
2.42.0


