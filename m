Return-Path: <linux-arch+bounces-12087-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3704DAC1BE2
	for <lists+linux-arch@lfdr.de>; Fri, 23 May 2025 07:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E9D37A893B
	for <lists+linux-arch@lfdr.de>; Fri, 23 May 2025 05:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15B7226D18;
	Fri, 23 May 2025 05:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="0PabruU1"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F387F224B08
	for <linux-arch@vger.kernel.org>; Fri, 23 May 2025 05:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747978278; cv=none; b=d5RUniWXeNdxcxJI6j3cdfbSmFlpo7taxfDVlmgBkGNxW0JMvxUtfHSnMRZ1JiGKj5v2I5hIHu/5SDSJbOx65TXnSyYgqVrkkiurk/ujscsovB9fPjZOCTFpVPa+5SGPhotBU6yxPCVOXHAb3nBsM8LK2gqllcdzEnWaEoezLnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747978278; c=relaxed/simple;
	bh=uG4QPZVjl5gDK86VnIwXxVnXWRkca87HCRZHSL9+/F4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RM/u5RjXCJv9VgHyVUfL/lAnoBSgYTxudY8svDXUhI7Ll5stok4Xfd0PkR2vkofYqMa4MtoKKTfW9iJoAwlUsFrVWEngN62wFbGkjNbolDZkLmyBsyc12HJKIcRUeQvLRfxfpEjS8CzWGHOXu/FN66e8tQ9k/0kfVP9WX/CWv6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=0PabruU1; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-742c46611b6so7379644b3a.1
        for <linux-arch@vger.kernel.org>; Thu, 22 May 2025 22:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1747978276; x=1748583076; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7X54j1g90psIDWU5pz15Bdf5E+ehG4+aRIqU9eaNKxE=;
        b=0PabruU1pEq63JcyrIU/ZBCMwBcbYt8MmoKoYLZphhFPYTPDBk6j4eHxvi3TNKs+yn
         YnqenTl43cPKcTAodEZLwKVoAUvBQDQE8TrOqmgpcpxttghREZV/5+k7wVyOTTrTR+mr
         Hg3Nw59+Crd3t+PV4dpgz49nsyld+axHAhrtwI7CcD4dOahegJzBaeIz+tyv+J+QbwRO
         9qYGjs9lI7Y4Hn02dUP6BpN8UnA0qdk8t3hC/UFWNMdu7LTBhxqoEhazGhc6fI8tyLec
         fE0AKWvc9pGtS1IinSnI7NfNhtOycwg5Nby35IPae1JpBTaN6JZsbJHneu7cdE/+Thm2
         9H/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747978276; x=1748583076;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7X54j1g90psIDWU5pz15Bdf5E+ehG4+aRIqU9eaNKxE=;
        b=WZBNVxq59gLM8BCc4rXeO9cnTftPghR8YaJzlaDE5f1Z0lWnQHSqWJJm6CGUWUvqAs
         rl1VGjhaiqo3w2m/dpvJi36FV0es3Fa5QcFq7Ds6GXc3G8Yi0G+8FjFB/kPRPe7/BjUi
         ExJDeYagH3cH+5m+yy4fiIyV7HUhULCHuHT45VYn3MeAJLMKX8/Oo7+lbzVW2YpX+thF
         74yn1whA+eT51pFuAooG0L3zJ64LbvvDL6HtPqGwUr2M42tj+J3EckZh33bVJsW1sr16
         7p1QeSxE9j2eHam401psogagbEtXs6E1rqFgnH5Qb8bp/d7GhabvgieVy9Xf1ZKYGotq
         TQFA==
X-Forwarded-Encrypted: i=1; AJvYcCUkarfaMO9EdU5jMpOlCx3PaAfVmqB0XnXj5u/W6t9fTkbVQX9UuTSVjN7O2OKWwQeytMY3cprvU4Pp@vger.kernel.org
X-Gm-Message-State: AOJu0YwIw/MgG0P2CGAr+euxYcPu9TMoGDZ4CtqtmEYL2Jk7XJQRn7ed
	cT9Ez8HnclZQXNkKznxeNyQS0mHENkbU03NfMpnqCsM50y4jn0b2Ternkpx9wE+obfc=
X-Gm-Gg: ASbGnctCWi88LTJxq5QKiwFY7CxAyTkmluPBs6OtA7bmZTKs64dOScTizNxl0E8tlPi
	xsr1151PYm/dpm54IvkFvf63sHAZ5RE2lZVWUpXRLGtEEgWH5cP2INj/y/0WTP0/AzPATjbsZ5C
	feqnDj9A7oQRDvqJ2li1dp/kUXNLMweHeDd2mGCz3WmQqhDA5W+KSWXVnh3+MJHcsvSgfL9ZQQo
	JZ25ZqeHO9XnIllUKu78y9DPglmZDkCwCpecxlOsMEVlOay35ioRpjMSQVdLReBLbfsQ/+Xoc1O
	MjsfKF589LWir1iE8XbYxb+vs4eKFiie5IvvvaR0RxuGKm8WzGRJagIkMKRsGg==
X-Google-Smtp-Source: AGHT+IHuvJwexFOpqMWZgmqCHklA7GJFd11ULqc5C7xPX4e1BtVUWPbvc7kB7Fax2t5Kt7WHcMzvcQ==
X-Received: by 2002:a05:6a00:3492:b0:742:9bd3:cd1f with SMTP id d2e1a72fcca58-742acd728eamr36423560b3a.23.1747978276169;
        Thu, 22 May 2025 22:31:16 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a982a0a4sm12474336b3a.101.2025.05.22.22.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 22:31:15 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 22 May 2025 22:31:04 -0700
Subject: [PATCH v16 01/27] mm: VM_SHADOW_STACK definition for riscv
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250522-v5_user_cfi_series-v16-1-64f61a35eee7@rivosinc.com>
References: <20250522-v5_user_cfi_series-v16-0-64f61a35eee7@rivosinc.com>
In-Reply-To: <20250522-v5_user_cfi_series-v16-0-64f61a35eee7@rivosinc.com>
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
 Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com, 
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com, 
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
 rick.p.edgecombe@intel.com, rust-for-linux@vger.kernel.org, 
 Zong Li <zong.li@sifive.com>, David Hildenbrand <david@redhat.com>, 
 Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.13.0

VM_HIGH_ARCH_5 is used for riscv

Reviewed-by: Zong Li <zong.li@sifive.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 include/linux/mm.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index b7f13f087954..3487f28fa0bf 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -352,6 +352,13 @@ extern unsigned int kobjsize(const void *objp);
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
2.43.0


