Return-Path: <linux-arch+bounces-10697-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F0BA5EB9C
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 07:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F643174CC2
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 06:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E1E1FBCA9;
	Thu, 13 Mar 2025 06:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/orWJA8"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AAE1581E0;
	Thu, 13 Mar 2025 06:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741846769; cv=none; b=OuphhdmdaFoMKO0q1z777yOmcMe6rYF0NVNGaFZEzEuNuIpD45/k6Z/YQUIO4moodyGtB0VVN57arbyxm1k9VJ2I/q8AwfQp9fKLFUSKwka32bku7eZqn3kBpXbGBf4c8lB019IHyWUbmbBWwguFleRFJPi+Nx3htTNwVefNpL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741846769; c=relaxed/simple;
	bh=XSyAkO4twTo9IZqS1Bu+JLzxWClBEdmJveCI8GP9Ux4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EoqotXse4wJ5EEl8FiYk3liokKZ6tbMVmjb3qoJ/e41/zjp4MQ9fpYkbeoLbgiMbMr4lRO2egtzKP6hn/9Ml/EvXuzeo5TFWX2oNhQrPhtyVwYhF37b5Isz2MKSnPvdRyP9wuNJtbpN8DjDY/guM+oY+kfx7T+nvOkT3ytRVgsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m/orWJA8; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2fe9759e5c1so1117216a91.0;
        Wed, 12 Mar 2025 23:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741846767; x=1742451567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1Byx2CnzFrqBVJ2qAPjeuNBafe/kCjDnEFkW40jwLzk=;
        b=m/orWJA8skJlsXR2xoyw9GzCDIOLWWlpuHtgf4OhD+x4eKBJY8XV4hbjgCw8cRhb3W
         /47nkuXfKkxhedCynso/cbAjeStePBLBOPXf+g1PzvT6rd9kIpX0B6YXgvjjGnTF9Oan
         P+NLnwGxYooaZIdWqhog3U3W5XUDq8l1ZZJ1stcCB4tXF2rY6p/M7LxsYWDD+BdUqmAw
         AVem/9hCj4giDNkfPVM7J1TXDP2YyTAefEQiLuQGbiY5bqVOkGOtx3uYaLZ1HZVQ9Dqn
         CXmtVy78QawgNsFS2c4F2gVwtayOChPockXcwd+jZcJPzVSVrxZpV244xIxgm0mREbET
         Yodw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741846767; x=1742451567;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Byx2CnzFrqBVJ2qAPjeuNBafe/kCjDnEFkW40jwLzk=;
        b=WHqYJRCGpWIaT+sYCeyFEaOvnHjfeJZdXdukEAy3RCyZ7UGwPrSIgougapBP6MfqL9
         nqY++g9PmhsD60Z7+M8BvEE8TPoVbTleH7p6NIZDETgft12oNdcIQ9aHbctvzG4gPAr5
         cPWoneHNah4cHfEG4Jd3i+Q0DT+d4Yv1kbXzOdiPlaf859/wcrXW+4KNFboPzjLSt9Rs
         qrpS1102qTVrGtSPDE3BpAI6PCayCt/Qk+FL+nbPt5XunHIF+nW/L3Y8YKySaITqqf57
         pcpctJzF8U3t7nWWKvkMCLIAFJZzJyAVbo5PIUsVRC6CXI2k3aiWcyfxlMfS2cG2VV3C
         HsnA==
X-Forwarded-Encrypted: i=1; AJvYcCVHylqTLtdUXwnU2I3Tfl+4H76WI1Csr757JuIhn0+voybRHWimRyhuP2gmScm3gzZ2jOSU/6m/gIKL@vger.kernel.org, AJvYcCVkcgwJVRXi3qJ7ANCXvpHJ2TTSDQfpwzWaXVzUCjzYbRYwoaNnA8Ka9fHzW7pgoQhwMp/6l9Yu1mFV@vger.kernel.org, AJvYcCVt7sLBni44ZNDBRDbzmBD5FtYwRJHNqnR3gpgFCbBNzPwlvQZEC/JfpjAlwgAImB//Zor69EliADMllS4L@vger.kernel.org, AJvYcCX5laVOr+Ul8T9oXxnNRMh18kHMlpy+Iy1jzmeEWZF7m+kB2RerfpZGBka+c8Vp03uvDKIvRVZmlw4jqtH6@vger.kernel.org
X-Gm-Message-State: AOJu0YytoIKBXr5ZVUpf4gehcWJUYkG0Kgp0x9OGaM9YXoZYhbPKHNr6
	nJK6NMs9tsMudrmzfKQZmvoZvvkmExe2R6UjkZJK9wKjW144GWm3
X-Gm-Gg: ASbGnctZQSvHYfTMBQRhT9sYUTDfAyW+FF3kVbeyX2RZxx23B00gCshyt52G37E4QYT
	8UnKZ2acljhe90DGK/eSdy8gqBuUZMTq+UI9R1pLUc8OQfuUgthE0BcGSaIG25/X8F3RpzOEvtK
	NS1/eUjLKUIrA1dKRqBMfW0KRXpmjxDDQ3XJDq5oZqPY0zNdlEl4F79o/SRgRFMdHO7cMBqFLjK
	Xuxt1QP3OB4kBdU94dvYNi/baJ7+EoNFPTGcKwgfyexpK46XYKwc6EEeMjTKXkxzlN2PcFH7ifA
	+hwcrTgQyHHnPjraviAxbWqhKHqEnDIqAV/osTrkG8SLnKLWPKrfMV9MDrzNLNS4guJxOm025dA
	UqM4QilEl8u0j1kAYM5mzwX7y/WE9Fiq65A==
X-Google-Smtp-Source: AGHT+IF/3JN2QdSkwNktsQBwiziRRmD9A0XgfQDo9Z9D84tlJ9BsGNr95AcTum+g7gcQX99Ng7ysbw==
X-Received: by 2002:a17:90b:2f46:b0:2fa:157e:c790 with SMTP id 98e67ed59e1d1-300ff0aa1cdmr12880995a91.5.1741846766937;
        Wed, 12 Mar 2025 23:19:26 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68880dfsm5856985ad.38.2025.03.12.23.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 23:19:26 -0700 (PDT)
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
Subject: [PATCH v2 1/6] Drivers: hv: Introduce hv_hvcall_*() functions for hypercall arguments
Date: Wed, 12 Mar 2025 23:19:06 -0700
Message-Id: <20250313061911.2491-2-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250313061911.2491-1-mhklinux@outlook.com>
References: <20250313061911.2491-1-mhklinux@outlook.com>
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
    Changes in v2:
    * Added comment that hv_hvcall_inout_array() should always be called with
      interrupts disabled because it is returning pointers to per-cpu memory
      [Nuno Das Neves]

 include/asm-generic/mshyperv.h | 103 +++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index b13b0cda4ac8..01e8763edc2c 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -135,6 +135,109 @@ static inline u64 hv_do_rep_hypercall(u16 code, u16 rep_count, u16 varhead_size,
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
 /* Generate the guest OS identifier as described in the Hyper-V TLFS */
 static inline u64 hv_generate_guest_id(u64 kernel_version)
 {
-- 
2.25.1


