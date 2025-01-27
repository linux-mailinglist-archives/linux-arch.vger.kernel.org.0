Return-Path: <linux-arch+bounces-9922-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27824A1DA37
	for <lists+linux-arch@lfdr.de>; Mon, 27 Jan 2025 17:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD4411887E49
	for <lists+linux-arch@lfdr.de>; Mon, 27 Jan 2025 16:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D87189F39;
	Mon, 27 Jan 2025 16:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lM1bHG28"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBA8152196;
	Mon, 27 Jan 2025 16:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737994050; cv=none; b=FF++BuJQv7gJPz9FMcwjvCO1w0KOcDeWQFj78B47wtekxQZ9jenToUpHDIcGlNzDHEOwtWCV2xdE1sRzR6dWBnshjF8FS4tNjtGD5GCGeF/MjZvdg1dewlCkFH9Adeu80nK69t3R9lf8lWWnp1HmD+vyYPvzKQTJQ/JxmZ93oZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737994050; c=relaxed/simple;
	bh=+VGH5bX+jj74i1xSHIJiswrHg7DNc9rM+fwUyXLk4tk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rzi4HkFJEPGF46t129CNdsBqx8/ohJlkVrwtgSLL0Jqri1bqOl3FrCKvxLg56moA4/UqEv3imyqDiLnHbgw6QzRpMZvgm17PJaA+uTTwBA2a0Y9oUDPPcUKQYqdiQqTdijasWSGLv8T4+4VZC4zGBAZ6dqLa47RjgHKuWhE7N8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lM1bHG28; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aaee0b309adso643346566b.3;
        Mon, 27 Jan 2025 08:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737994047; x=1738598847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eOGOr4s5yiF+IlrjEXheryEMyHp3uedGamtyEKhbkyY=;
        b=lM1bHG28xi/xMZ+yrBWOGEHfNZ240yiyLeWvEvq1WCkmLBO3PAbEh7nibp770oeqlX
         TFyLqW3izveOVT9scfBhWeccJdRmH+9E55tkYasPaReVqTxf/NsZbi9JEYhpv6a9890U
         e5hphrvo7oKf2FkI3pLBsWdRkKv52nR6kKLH2TbBeiZE59NLVOsw4wOg9xDQv5nQcYG+
         INBh8q3Uq/5DhdKOoXPT4kzVLvryNDQ4oEsIA1Sbghc0ThTkEZ+o4dVdK9r3UZoP6+xv
         zWwvR106LW5GY0LCYpslm5ktF1P42TDdmhZ2OYFG2uBU2tQDU6p4zd2lJkdzpFFfOeua
         Sgtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737994047; x=1738598847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eOGOr4s5yiF+IlrjEXheryEMyHp3uedGamtyEKhbkyY=;
        b=xFSmdbxDIg6IsAqXsEF2C9CUM+WIm5rat3mIZf6HPANPaLU+uwuZB0oCqlsNdA5iZk
         ZdBakXcc11xTVCL8ZyudHSNb8MTdM2RgwPqYl3gsd+Ul0+H3B+CFQ+C8AHPTfkQ6Gklk
         Cw0RNLJF9eFaO9ax4PUWriCDWdntiFo2ULqx6j26qMEvjN6jE92xzagYIO5wI5YuwqQB
         tdoStQlYtGaW5VsNK4hvHilkdPzDO+O7pXE0rPgFYeNG+Ekx8FZsS3cESC6xxED107EM
         6fyZowMqeJORE9l3a5zjzfl0IOw0/0+CMr2aNBo7dbF6Y/xWjLUAS5DmwvJWD3apyzV3
         P1fQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8DZ50G7JA4LfIJq4fkFohaGGa+0T0c3GvoxvIVO+sCuoNdnJifJQlAyWO9zamgfBNJW35bg0G@vger.kernel.org, AJvYcCUp3TxbyNnGldj/ZXg1qgrzADqolDm68xv6lQ9L0ENAdIc8JefQCncLJGQvxDRNww1DC/hCNL+NbP1FeQFJGEY=@vger.kernel.org, AJvYcCVBgMUVu5qxGX4f/73B+740NggSvu04MZdrcZ9F/1vt8e0VEDn0QM0NFyUaJU65MGDylNDPiNWXDrb9c3+E@vger.kernel.org, AJvYcCXF7KfX2A0dDr/7n+xnjp/GgLU19eJPrBTj6J9FxyFpGu//Cgskug/MT2bBhr9bZ3pyEczwPsKhYTHo@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5eoIyADNlbXBV+n0L8/WwDJREPuVro8Vw/Xxvr8in2cASkIZY
	r3xPVKGlWCv61FnZVQWuj9ioOFMOmIUi3YQ0XJsjEDO2YQ6b5hSc
X-Gm-Gg: ASbGnctc1HQ27ZBL80SH8jWsjlVb5XIcq+oSbNUDQ5c2SnZG70aTo7VE+NkTCQ4Y2mV
	NK5FYx/U8hmptesZAJybxl+Ch6t1ScFXi5RjBB+HOiG2RU2wZ7jGYZeiRKFynuoFHUgBCBFaA7m
	i5zepBikqd9bZeBb+nYUAwZMhIG0J2YSPAf6GrLHqMpMJFdxjjCugSZCXzt9R2KsDYb6qoP4WmY
	yE2yQeyO4RBSe+/ePNoSRvz8smEwAQ640IsSAhjCq9jhj1FCXYM9o4Csq9rNwfg863HXGGJy1Px
	j0I/O7HKI9vs1A==
X-Google-Smtp-Source: AGHT+IERCLQXnCU+YIaBBJp+oaHBkoRX9ZwnjjcfabyvezHHAG9ec22+X9u8D1546w+n0uGxAoPHpg==
X-Received: by 2002:a17:906:2cc4:b0:ab3:a3b4:f91c with SMTP id a640c23a62f3a-ab3a3b4f9b3mr3132086166b.34.1737994046774;
        Mon, 27 Jan 2025 08:07:26 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab675e8b01asm592643866b.84.2025.01.27.08.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 08:07:26 -0800 (PST)
From: Uros Bizjak <ubizjak@gmail.com>
To: x86@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-bcachefs@vger.kernel.org,
	linux-arch@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Nadav Amit <nadav.amit@gmail.com>,
	Christoph Lameter <cl@linux.com>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Brian Gerst <brgerst@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v4 4/6] percpu: Use TYPEOF_UNQUAL() in *_cpu_ptr() accessors
Date: Mon, 27 Jan 2025 17:05:08 +0100
Message-ID: <20250127160709.80604-5-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20250127160709.80604-1-ubizjak@gmail.com>
References: <20250127160709.80604-1-ubizjak@gmail.com>
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
Acked-by: Nadav Amit <nadav.amit@gmail.com>
Acked-by: Christoph Lameter <cl@linux.com>
Cc: Dennis Zhou <dennis@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
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
index 79b9402404f1..a7cf954ea99d 100644
--- a/include/linux/percpu-defs.h
+++ b/include/linux/percpu-defs.h
@@ -221,7 +221,7 @@ do {									\
 } while (0)
 
 #define PERCPU_PTR(__p)							\
-	(typeof(*(__p)) __force __kernel *)((__force unsigned long)(__p))
+	(TYPEOF_UNQUAL(*(__p)) __force __kernel *)((__force unsigned long)(__p))
 
 #ifdef CONFIG_SMP
 
-- 
2.42.0


