Return-Path: <linux-arch+bounces-10387-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE0EA46BFE
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2025 21:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 905293AD285
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2025 20:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623A82580EC;
	Wed, 26 Feb 2025 20:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KzYw7PNn"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D938275602;
	Wed, 26 Feb 2025 20:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740600385; cv=none; b=jV94JjpS53xZ2D4yynspMHv2q2tomZMvPTD1WgRllYO4FAebBsfTayOw1H7c7ZnFkwQazH9kBR2VWRI6MhQ4ihT45ZxEB5pQ+wyG2J1856xxR0XHQFeYijZPC4XPkEw0cstCocHOWM9XazYP0peLGPI7j8qV0AInufm/+BQ/oy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740600385; c=relaxed/simple;
	bh=D79O1DEyIEg4TJGa5io8k0t+2+DbP5zL8a29fjZrBNM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FkgLl7voC0JH1dJK05WSTm4kQeVHtTUurgWuGVCDhI8lpim6FjjAcZQDCxsZW/yJtVcDrM0l18wxLo6OfqKyqLFA5kkCTrlM6qe1HdwvCbIUMro2J5oMilgoDXQxksNsImR7KVRIOEzA5YsBhyLljIxdDCpDLSIxvR3fP4JwiI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KzYw7PNn; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-220c92c857aso4261405ad.0;
        Wed, 26 Feb 2025 12:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740600383; x=1741205183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eER/4O9RFncyjEvwtnVJeEu162TtYqwzXdX6/zSnIN8=;
        b=KzYw7PNna1VnLmJHKnzwuxsuw0mabmTtaK3sZDIX6Cmzls2O/lvm6QLRwDbPHXiIR3
         oEvUp6MViuy38obbDtXUg0QrDigH4Mxb6JDz3hI3sto3yQdWXImoiSZ5hdNVdZ1V3yqw
         DjtBq5EN2GHS3a/uQKVLlPwa3JhBnpb+waWuOkNBHv1meOv16yPfYqXP78S8YiQgVnSe
         OZL/0HK8ZI/2eMlQueNwaC/+8m9d2g11UlbqOJERMRL2J47Z6LhRo+3Hb5gQ1IMPJV/G
         sdwxR95vXvG8LHRq2eaXLkyNy9N5JHNl/DWXx7m2YYnjuUucFnFI+1PGAQ5yNmfxSasW
         VnRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740600383; x=1741205183;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eER/4O9RFncyjEvwtnVJeEu162TtYqwzXdX6/zSnIN8=;
        b=r0X+DUir30Pybwv/jkyAxps6QPuG7YTjiO2hbejvoB5lCKVc0Aa32OFsFLlk4VL8+q
         uINA+svxWSZ96QG5Kr3pQuqMaHLI3SeaOaIuY2I63QND2MORerQd03kmC3yujfZIJoYq
         sWGvmImJK3MFXVhRa00P7hlvcQn+U9JZn/0Lr+b2z0BsMJDSRtUU6taoLyNfI4xG4mMm
         iWjoYKs9Qdi916QTE8m534YPU7u2DWgqZbZHDOMEqHNdAd9Kfc77JT8s0guRrRyt0M1k
         lqFc/z3GbMoX2HBIO41cdvu3qAUKY/lvTdZvl7ZD3m30EHdPjzk4PcdOimd95UGnwbg4
         43QA==
X-Forwarded-Encrypted: i=1; AJvYcCUDGszSVA6+QEdW5FExQkrDUNe/xoB5bUdqYwdpksyK2N1lCvCQ5ZGKw3fgBNch+qySU/JlMzpDUSWf@vger.kernel.org, AJvYcCVnVSqTlOWqfkn0JkQO7/17zgwn4KtL6/3tQ08Y83LSs28WrWE41uANkmDmInbAt+/615i1JkXgbC3Q@vger.kernel.org, AJvYcCWIlcKYoTqYHi1PN88E9Pjvlg+OADeUnVDhxTSevSGv5CZGkDsk91x6wkmrJ+sw4PIpszDG3IPjINPsk8Yc@vger.kernel.org, AJvYcCXIqXYiFzwBg1gBVDnpytAL4aUa4M/qyZNyjJVf4gHQ3RnCzO93Vw2qJbLd0grzgKNK8DJV2JZG2uE3b93C@vger.kernel.org
X-Gm-Message-State: AOJu0YwF3Axjy3eqEVbEiFk8GTSMMyhbmJcT7r3reRW+FfRiLvAggpHa
	n7AoLtE6lAifYNSy5nb9YcF4pqJuodcy4ZwExSvJp1C1h8pMmC0E
X-Gm-Gg: ASbGnctsFiF2n4okzKVvEFxRfw00dXnZQRrq4kcFGBU37KzpmRlL4BrU0rMojYAZpxJ
	IWTXTkMbFpT4V1IpsJOzLNjsIgKHIdH7JslZEDrxopM5waNqRumkfp/IqIOHP1U6sYhOwtwyxfg
	oy3V4hYe4X0SkyO3VEBtogTvYDM9RL+mKDrS7uv/XeBfWBCNoK+8Sh7TO5alKJxg99R9qeUuzoD
	BbrjFgfbzTaCpy5us42l2brG2ln8QYLeUkMoL920sicxpdHW8l4JtazCXIFo8YDgnRmHzLQiy70
	tTSgKBR8HlHyG3ytFSwIDJIvf0yGDK0zJH8uqy90eVdWyGl/a1Td1l1Le9LkFRd9fxg2BrhrLT0
	GNlmH
X-Google-Smtp-Source: AGHT+IEJ6ItHX9/26SJE/XNGOBK9nlscjKes08hvTllBo7xuTRQKdMm6q6ZJlpNcOYLSYUR8GGZuqw==
X-Received: by 2002:a17:903:1c6:b0:221:77d:3221 with SMTP id d9443c01a7336-2234a189710mr9853825ad.8.1740600382694;
        Wed, 26 Feb 2025 12:06:22 -0800 (PST)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a81bbc7sm3959455b3a.127.2025.02.26.12.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 12:06:22 -0800 (PST)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	bhelgaas@google.com,
	arnd@arndb.de
Cc: x86@kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: [PATCH 2/7] Drivers: hv: Introduce hv_hvcall_*() functions for hypercall arguments
Date: Wed, 26 Feb 2025 12:06:07 -0800
Message-Id: <20250226200612.2062-3-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250226200612.2062-1-mhklinux@outlook.com>
References: <20250226200612.2062-1-mhklinux@outlook.com>
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

Current code allocates the "hyperv_pcpu_input_arg", and in
some configurations, the "hyperv_pcpu_output_arg". Each is a 4 KiB
page of memory allocated per-vCPU. A hypercall call site disables
interrupts, then uses this memory to set up the input parameters for
the hypercall, read the output results after hypercall execution, and
re-enable interrupts. The open coding of these steps leads to
inconsistencies, and in some cases, violation of the generic
requirements for the hypercall input and output as described in the
Hyper-V Top Level Functional Spec (TLFS)[1].

To reduce these kinds of problems, introduce a family of inline
functions to replace the open coding. The functions provide a new way
to manage the use of this per-vCPU memory that is usually the input and
output arguments to Hyper-V hypercalls. The functions encapsulate
key aspects of the usage and ensure that the TLFS requirements are
met (max size of 1 page each for input and output, no overlap of
input and output, aligned to 8 bytes, etc.). Conceptually, there
is no longer a difference between the "per-vCPU input page" and
"per-vCPU output page". Only a single per-vCPU page is allocated, and
it provides both hypercall input and output memory. All current
hypercalls can fit their input and output within that single page,
though the new code allows easy changing to two pages should a future
hypercall require a full page for each of the input and output.

The new functions always zero the fixed-size portion of the hypercall
input area so that uninitialized memory is not inadvertently passed
to the hypercall. Current open-coded hypercall call sites are
inconsistent on this point, and use of the new functions addresses
that inconsistency. The output area is not zero'ed by the new code
as it is Hyper-V's responsibility to provide legal output.

When the input or output (or both) contain an array, the new functions
calculate and return how many array entries fit within the per-cpu
memory page, which is effectively the "batch size" for the hypercall
processing multiple entries. This batch size can then be used in the
hypercall control word to specify the repetition count. This
calculation of the batch size replaces current open coding of the
batch size, which is prone to errors. Note that the array portion of
the input area is *not* zero'ed. The arrays are almost always 64-bit
GPAs or something similar, and zero'ing that much memory seems
wasteful at runtime when it will all be overwritten. The hypercall
call site is responsible for ensuring that no part of the array is
left uninitialized (just as with current code).

The new functions are realized as a single inline function that
handles the most complex case, which is a hypercall with input
and output, both of which contain arrays. Simpler cases are mapped to
this most complex case with #define wrappers that provide zero or NULL
for some arguments. Several of the arguments to this new function are
expected to be compile-time constants generated by "sizeof()"
expressions. As such, most of the code in the new function can be
evaluated by the compiler, with the result that the code paths are
no longer than with the current open coding. The one exception is
new code generated to zero the fixed-size portion of the input area
in cases where it is not currently done.

[1] https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/tlfs

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 include/asm-generic/mshyperv.h | 102 +++++++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index b13b0cda4ac8..0c8a9133cf1a 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -135,6 +135,108 @@ static inline u64 hv_do_rep_hypercall(u16 code, u16 rep_count, u16 varhead_size,
 	return status;
 }
 
+/*
+ * Hypercall input and output argument setup
+ */
+
+/* Temporary mapping to be removed at the end of the patch series */
+#define hyperv_pcpu_arg hyperv_pcpu_input_arg
+
+/*
+ * Allocate one page that is shared between input and output args, which is
+ * sufficient for all current hypercalls. If a future hypercall requires
+ * more space, change this value to "2" and everything will work.
+ */
+#define HV_HVCALL_ARG_PAGES 1
+
+/*
+ * Allocate space for hypercall input and output arguments from the
+ * pre-allocated per-cpu hyperv_pcpu_args page(s). A NULL value for the input
+ * or output indicates to allocate no space for that argument. For input and
+ * for output, specify the size of the fixed portion, and the size of an
+ * element in a variable size array. A zero value for entry_size indicates
+ * there is no array. The fixed size space for the input is zero'ed.
+ *
+ * When variable size arrays are present, the function returns the number of
+ * elements (i.e, the batch size) that fit in the available space.
+ *
+ * The four "size" arguments are expected to be constants, in which case the
+ * compiler does most of the calculations. Then the generated inline code is no
+ * larger than if open coding the access to the hyperv_pcpu_arg and doing
+ * memset() on the input.
+ */
+static inline int hv_hvcall_inout_array(
+			void *input, u32 in_size, u32 in_entry_size,
+			void *output, u32 out_size, u32 out_entry_size)
+{
+	u32 in_batch_count = 0, out_batch_count = 0, batch_count;
+	u32 in_total_size, out_total_size, offset;
+	u32 batch_space = HV_HYP_PAGE_SIZE * HV_HVCALL_ARG_PAGES;
+	void *space;
+
+	/*
+	 * If input and output have arrays, allocate half the space to input
+	 * and half to output. If only input has an array, the array can use
+	 * all the space except for the fixed size output (but not to exceed
+	 * one page), and vice versa.
+	 */
+	if (in_entry_size && out_entry_size)
+		batch_space = batch_space / 2;
+	else if (in_entry_size)
+		batch_space = min(HV_HYP_PAGE_SIZE, batch_space - out_size);
+	else if (out_entry_size)
+		batch_space = min(HV_HYP_PAGE_SIZE, batch_space - in_size);
+
+	if (in_entry_size)
+		in_batch_count = (batch_space - in_size) / in_entry_size;
+	if (out_entry_size)
+		out_batch_count = (batch_space - out_size) / out_entry_size;
+
+	/*
+	 * If input and output have arrays, use the smaller of the two batch
+	 * counts, in case they are different. If only one has an array, use
+	 * that batch count. batch_count will be zero if neither has an array.
+	 */
+	if (in_batch_count && out_batch_count)
+		batch_count = min(in_batch_count, out_batch_count);
+	else
+		batch_count = in_batch_count | out_batch_count;
+
+	in_total_size = ALIGN(in_size + (in_entry_size * batch_count), 8);
+	out_total_size = ALIGN(out_size + (out_entry_size * batch_count), 8);
+
+	space = *this_cpu_ptr(hyperv_pcpu_arg);
+	if (input) {
+		*(void **)input = space;
+		if (space)
+			/* Zero the fixed size portion, not any array portion */
+			memset(space, 0, ALIGN(in_size, 8));
+	}
+
+	if (output) {
+		if (in_total_size + out_total_size <= HV_HYP_PAGE_SIZE) {
+			offset = in_total_size;
+		} else {
+			offset = HV_HYP_PAGE_SIZE;
+			/* Need more than 1 page, but only 1 was allocated */
+			BUILD_BUG_ON(HV_HVCALL_ARG_PAGES == 1);
+		}
+		*(void **)output = space + offset;
+	}
+
+	return batch_count;
+}
+
+/* Wrappers for some of the simpler cases with only input, or with no arrays */
+#define hv_hvcall_in(input, in_size) \
+	hv_hvcall_inout_array(input, in_size, 0, NULL, 0, 0)
+
+#define hv_hvcall_inout(input, in_size, output, out_size) \
+	hv_hvcall_inout_array(input, in_size, 0, output, out_size, 0)
+
+#define hv_hvcall_in_array(input, in_size, in_entry_size) \
+	hv_hvcall_inout_array(input, in_size, in_entry_size, NULL, 0, 0)
+
 /* Generate the guest OS identifier as described in the Hyper-V TLFS */
 static inline u64 hv_generate_guest_id(u64 kernel_version)
 {
-- 
2.25.1


