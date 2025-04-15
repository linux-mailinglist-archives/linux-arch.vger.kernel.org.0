Return-Path: <linux-arch+bounces-11404-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B00ADA8A652
	for <lists+linux-arch@lfdr.de>; Tue, 15 Apr 2025 20:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06F293B099B
	for <lists+linux-arch@lfdr.de>; Tue, 15 Apr 2025 18:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69315224AFC;
	Tue, 15 Apr 2025 18:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5NXeHbe"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FDC220694;
	Tue, 15 Apr 2025 18:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744740474; cv=none; b=j96YruBIlMkeIGwBqf8w6DFS2wCa08ai3ZH9Z2cqQgMyKJZrxCPohIn7DhF4kApTw1VW2hw9xJVYulMR/oUe0b9YagKYcGrLkOZv1yw4BG/MUa80Evn/XhXc0Jd0PotKsBsdLndp7tTu1pu+XlUbtIoi9XWmpyvRbGwIUiY0t4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744740474; c=relaxed/simple;
	bh=MIdo8wWB+nWkjRShAhT6PWpG1r+kClw3NkgN2Yk49h8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P6jNr/o/zVga459xCuhKiTSQ2PHu1q7FNbTVzJjewl870d/SA50bigdqZqqL4lYTsHJYgpKTf1+320RhOWJ7ZY6kClhP+m1Wh6sh33d+TwaELr/Vdaznq3CIrTDvg8udQ/cA+hAX9GIu7cpFhgZqvsQGs+7DH20p2LVeNl1j0XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J5NXeHbe; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22548a28d0cso85250015ad.3;
        Tue, 15 Apr 2025 11:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744740472; x=1745345272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T2Uucqf74/AJpdwAAeV0TOpvsswe9NobdikB/z3wisY=;
        b=J5NXeHbe+RJFpNZQ87l8Q7O1BEk5zTAo1UMQEUDjYIGibrJmAK5X69dRx8pfQYEGzH
         7kNJ45eHu/D1kKyr8r/cmkGN1QVSks245Sfn/i0JSr62PrOUiIl0+CfYBeFuIvw9xl2a
         g6lFRFBJnbBiK9ZEhZnyJ0jlQgtV62jH3se8FvAtEGDEmzUw9oMF1SCn/i3dD30mryve
         wVugf9cv1/8Xl8bCEbKxgw2zshO1xEGjLyfHwf9g6cMu/EFIrTo9CcLXRzqQg0swrvr6
         x4YyOyI9OgjNOK7Tt8viWu5xyRb8dQZjM/cwO3BO03+toU4aYkjRDHgFFHFlL1NbYwpf
         OeWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744740472; x=1745345272;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T2Uucqf74/AJpdwAAeV0TOpvsswe9NobdikB/z3wisY=;
        b=HSg6UjWIVGQePqePTyHhJ+yOZsPtrthtNjDHoKvRBxD6K5nXJ1g1Jd48cG9eQzrNX1
         5H8pQsAnjiIteqE7dwzL/7Cey/bGCcUWFiZZYXkzU31usC/Qnpb+BBWlFBzDJRuA/kWR
         fm97VPnim9NcyptkcCzVb0n0XmQw8EXP3ISYx/dsaGE82YQBGwUOA0wSkMRC+r3s8uiI
         eySB/hVPmdemvqkfJxl8EmkXXy4a1SzfUI4svyzKubiktbFUUCHPWIExANl0Rs2NqxJO
         07VJmkNH0ZZNr3a8Cw0Y69Lv0ShFH6KM23Q6GDLwbhuNTBg34YgaI1ldcypOPSNP46dV
         lRVA==
X-Forwarded-Encrypted: i=1; AJvYcCUEEbXbswWNTjnCwriVNCQ9TQVe6TvtH2wpZgxY7fd5c2cC+NPAEKM+pPIIqJ4JgvAKgJpZPLPGEFR9@vger.kernel.org, AJvYcCUN9F6fOnk5Ovdtu1jZRKr+PY3QxNA5JN8Y+MzPeR5lnEe6BYizdkPgr4IoAejYGYH31boSn6sxvtVHzPKH@vger.kernel.org, AJvYcCWkR8XyHs5n020YGcz0KRwRQCYF1yfbF/0r55KbxUPpw8Xgsgmz+CHj7VgwNkl5D3IvxlVZ8+1+hFMZEndT@vger.kernel.org, AJvYcCXZgIp5VpjyIKU1+YyEnSJNzGbqspYDltW3nbtBKkt/OHBFDtDJ9e2/PrVWuHKXpGDkNF7oos+Ra3Tb@vger.kernel.org
X-Gm-Message-State: AOJu0YwOhQTdzBC2VwFuThDAPXFMTHEE67zBuGSWu6NUOaF5vAoNqe+V
	9eh6uBx8UWUaxi0C3mqEfF/dlYTBUJQSleqHB1Ts97j21oSny3tX
X-Gm-Gg: ASbGnctosq85L7fyNh7EDr+n7HaZUublB3ZHxBYIgRSbyDVimJ7oj/6QkI/zw6yXjkH
	2Ma/I4qH+oOrKv5GBXVaepeY9G0FLJ+kKnvTPloZ5CaGjZ9Kl7oC9ArWqR31gZNO+j0Hb7yttjM
	vyxlNcSpuyO0U9Ic2cNE39z+5FvzqKnNDWJ8KVE1JcFFC4pfKX3qazh9w2BiGzMXyWZQjA6gJgo
	ClJhigY3V3RT+SmEmBYQ3JfWGPH5sF/G1vB2FhGGL5AddF2qXaSooOcHwoZ33QzCLkd3LEi2iEr
	VAKUU7rA+lLZl7NtSOaN+zFn6hsjTD7Lmz+iTYEYaRLdmkyYPzdVQlSlCNchh1j+i/kuTepmgSQ
	XNLGQFzAymn+n1fLNgh0=
X-Google-Smtp-Source: AGHT+IF1/vheVTcuheGVrtTM6KH6ZS2IPTooMAcnPogcoQNfL/JE08+57t9/OXv09JX2K7B0vU7WTw==
X-Received: by 2002:a17:903:2a8f:b0:21d:dfae:300c with SMTP id d9443c01a7336-22c318a9320mr1903625ad.3.1744740471578;
        Tue, 15 Apr 2025 11:07:51 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7cb52c2sm120168425ad.194.2025.04.15.11.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 11:07:51 -0700 (PDT)
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
Subject: [PATCH v3 1/7] Drivers: hv: Introduce hv_hvcall_*() functions for hypercall arguments
Date: Tue, 15 Apr 2025 11:07:22 -0700
Message-Id: <20250415180728.1789-2-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250415180728.1789-1-mhklinux@outlook.com>
References: <20250415180728.1789-1-mhklinux@outlook.com>
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
calculate and return how many array entries fit within the per-vCPU
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
for some arguments. Several of the arguments to this new function
must be compile-time constants generated by "sizeof()"
expressions. As such, most of the code in the new function can be
evaluated by the compiler, with the result that the code paths are
no longer than with the current open coding. The one exception is
new code generated to zero the fixed-size portion of the input area
in cases where it is not currently done.

[1] https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/tlfs

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---

Notes:
    Changes in v3:
    * Added wrapper #define hv_hvcall_in_batch_size() to get the batch size
      without setting up hypercall input/output parameters. This call can be
      used when the batch size is needed for validation checks or memory
      allocations prior to disabling interrupts.
    
    Changes in v2:
    * Added comment that hv_hvcall_inout_array() should always be called with
      interrupts disabled because it is returning pointers to per-cpu memory
      [Nuno Das Neves]

 include/asm-generic/mshyperv.h | 106 +++++++++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index ccccb1cbf7df..504c44b1ab9e 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -151,6 +151,112 @@ static inline u64 hv_do_rep_hypercall(u16 code, u16 rep_count, u16 varhead_size,
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
+ * The four "size" arguments must be constants so the compiler can do most of
+ * the calculations. Then the generated inline code is no larger than if open
+ * coding the access to the hyperv_pcpu_arg and doing memset() on the input.
+ *
+ * This function must be called with interrupts disabled so the thread is not
+ * rescheduled onto another vCPU while accessing the per-cpu args page.
+ */
+static inline int hv_hvcall_inout_array(void *input, u32 in_size, u32 in_entry_size,
+					void *output, u32 out_size, u32 out_entry_size)
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
+#define hv_hvcall_in_batch_size(in_size, in_entry_size) \
+	hv_hvcall_inout_array(NULL, in_size, in_entry_size, NULL, 0, 0)
+
 /* Generate the guest OS identifier as described in the Hyper-V TLFS */
 static inline u64 hv_generate_guest_id(u64 kernel_version)
 {
-- 
2.25.1


