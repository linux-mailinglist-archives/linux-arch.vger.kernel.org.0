Return-Path: <linux-arch+bounces-12847-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1711B09AAB
	for <lists+linux-arch@lfdr.de>; Fri, 18 Jul 2025 06:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E6345A6904
	for <lists+linux-arch@lfdr.de>; Fri, 18 Jul 2025 04:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DD91DF75D;
	Fri, 18 Jul 2025 04:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCgYnM/f"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA531D54F7;
	Fri, 18 Jul 2025 04:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752814561; cv=none; b=EsSG+oIMP7LBAiuxgHBXuuUJQ9Rn2AyJELmULmQBTehkqswQEVR/0Pg+V23GJfS1mj5JxtxWgxcgwW3uX27wHr4i6FDyxSuwKLIzlpJhvphYyz6T4vEY/f3mSa41nNCccam05MLwU/wZp9yGmVtXJ1dOrC0cpbXEdhB4T0/XVls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752814561; c=relaxed/simple;
	bh=/nSmzi7ZSZH4+6XtdEnOIi7u0oPSqZBU/xgwFOgJtCs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gYmYUKGB/VEQWsruf2lwBhqXvNhJ9gREJIrJDNZEJ1+PitFl61RPzPJIh788gt5MABNzKtQBEullI43iUNaYizZkSxEMjGraYgIbnneyd62XG6qG8Lcewlw6wSqYFbubIn5iBGhahAc5vhBKzJZO37ztD7QvQIsJLVhcYH7IbAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CCgYnM/f; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3122368d7c4so1504113a91.1;
        Thu, 17 Jul 2025 21:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752814558; x=1753419358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RioRFmC4CQK8fObPILD0UjambwVuEnHzjRU9SKz6wEo=;
        b=CCgYnM/fRaEEp/+SxuFN6DpOpdi3OcrsRjlwWtXgggXULv2EWYkJ9GwfpfsNVWbAWb
         zNka9G5UXTowzN6Ett8wgs0rZSdKN/+E4wHnVE3gqggRhQ+TIxETi0JXR0IlZUezQKHP
         QIUFy3dj1rggvou2J/WUjXS/0d3Rlp6S5AJo+Le14qAN3qTu9jrVDoh6blJVw+uf5YT6
         YUOiWYUlz/TcKyRET6wKEO7mT8xinOY2AK+O36I2KAKECHm9ZMxg3hMBOhx2mu/kVwRN
         1diDiOIg5Uqf7FbVTr2ypZ2juv54ZJ+0sK07mMpHhwBFxlSMJhNEsxx8/jQCwqO6E4xI
         ULIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752814558; x=1753419358;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RioRFmC4CQK8fObPILD0UjambwVuEnHzjRU9SKz6wEo=;
        b=QNIfSiQNDIiyO0KnG5Bj1zqY7rkHAjhh+Nb9UTGspYekFioGMRStyAYLP5lSXpro9P
         O4GKWO8LUouhDSYesNkQlC6kI0G1VNgPC3pJhTwdOZFtw7YgiJGLZGKWw+aCvWdHU6p7
         ZiEO/MX7AQ3rn/40kxKklsHaAuCJmElo9YhyCi5nmh7npKnZETrJpIwozfBbWegHv717
         h9CK/W1LMaVdeKdlVJm2iQip1iI/bH9QMlReHF0c+pE9S5i2G6pZultkfRbBPOeFEB2T
         O+WbOZJdB7gQQYFQ0EkzstuGd1dvx5W54uGYGYRtYFGbJxe+Ze6epT2FvwrJzdYo+Go/
         OHTw==
X-Forwarded-Encrypted: i=1; AJvYcCV2br7KvH1TrDVgsAANk8yRj18wQ6NPzZfbDvAi2yC2C7ngVoEJB+H4kMsDe9zsMhbVuzaGapDc5AaTAUfb@vger.kernel.org, AJvYcCVGtobj+w6gNA41JGZ44KSNLcjIyZnvvjr4YE7lyuu2KcCwFhBz1+2ve3QI8gFk1nHVlh4NqZL9mBcv@vger.kernel.org, AJvYcCVHq9BGqUvVKYRfvyD318JVg+HJIp8vsEFZyWRog58cHE9uKiP8WFtXtROjdLVHAiA/4wBgGI2lkqcl@vger.kernel.org, AJvYcCXAqr7fBoGHD1k3Sg9ZmY2dERS/uNyGv+DiY89MCkem9J0/ejSZ6jv8jcspVMt66Ib+qox4ZQwSIqwBesrV@vger.kernel.org
X-Gm-Message-State: AOJu0Yye0khjrKhg5hgHJ7lwJctG2FqWI5u8pMY145mEhoTKjlI1FN/z
	gm6KJuTiF5N0/aEdeqFr3/368d682CN6Lm3NHOY1FvVHeNOjvq3khese
X-Gm-Gg: ASbGnctNPGaU6JXwZVmVAjOjvZIWEKGSN6yq1TUOsBdPXuFhkhMtYOeE+jwZrNF397q
	cJgnMuly5IVhPQbGwXDnQihBDDumPgwz2S5CKJ+AkYNPoFtdGlQs1KVsGQsyjUiHZSFzLGfLFa+
	UCNNASE7x0lAPTTlyPwXDsZLRwC7FX9Ybdalzqt6qnSMMsqZyqSiNCcY3dHMZbKARUW84cq0/LU
	hBAH0I7aaJlb1G+q5R3fhz3gZCyAOsn2QMYuhxmdP1pu+IBW5KHwAX+JnB4Di4DPdaw1JbEpFhn
	Vrg9wJiLCP6VZkFmbNQLy//G4ESsW8DGdpgTeKw+kEf6Xuiu1NEYpvikZOjNzSQrSpxdopY5lL5
	g+0GKy+MPWy1fsOqpAGbs7G0A+xlSgzIB5B4ByeZagSyLjz5ykI5ql8xYBYDdwh0yg1JSQIYGE/
	+uYQ==
X-Google-Smtp-Source: AGHT+IHVSH6/x2vlhrQxJuVcUqnGpg7+BdJ+u4LhBtRTN0p+TGZT1V18DDmHjrGDje2A72rbEMyOXA==
X-Received: by 2002:a17:90a:d44c:b0:2f8:34df:5652 with SMTP id 98e67ed59e1d1-31c9e761788mr13469858a91.21.1752814558157;
        Thu, 17 Jul 2025 21:55:58 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31cc33715b2sm476907a91.24.2025.07.17.21.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 21:55:57 -0700 (PDT)
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
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	arnd@arndb.de
Cc: x86@kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: [PATCH v4 1/7] Drivers: hv: Introduce hv_setup_*() functions for hypercall arguments
Date: Thu, 17 Jul 2025 21:55:39 -0700
Message-Id: <20250718045545.517620-2-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250718045545.517620-1-mhklinux@outlook.com>
References: <20250718045545.517620-1-mhklinux@outlook.com>
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
    Changes in v4:
    * Rename hv_hvcall_*() functions to hv_setup_*() [Easwar Hariharan]
    * Rename hv_hvcall_in_batch_size() to hv_get_input_batch_size()
      [Easwar Hariharan]
    
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
index a729b77983fa..040c4650f411 100644
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
+static inline int hv_setup_inout_array(void *input, u32 in_size, u32 in_entry_size,
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
+#define hv_setup_in(input, in_size) \
+	hv_setup_inout_array(input, in_size, 0, NULL, 0, 0)
+
+#define hv_setup_inout(input, in_size, output, out_size) \
+	hv_setup_inout_array(input, in_size, 0, output, out_size, 0)
+
+#define hv_setup_in_array(input, in_size, in_entry_size) \
+	hv_setup_inout_array(input, in_size, in_entry_size, NULL, 0, 0)
+
+#define hv_get_input_batch_size(in_size, in_entry_size) \
+	hv_setup_inout_array(NULL, in_size, in_entry_size, NULL, 0, 0)
+
 /* Generate the guest OS identifier as described in the Hyper-V TLFS */
 static inline u64 hv_generate_guest_id(u64 kernel_version)
 {
-- 
2.25.1


