Return-Path: <linux-arch+bounces-12846-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 252FCB09AA8
	for <lists+linux-arch@lfdr.de>; Fri, 18 Jul 2025 06:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B60073B050D
	for <lists+linux-arch@lfdr.de>; Fri, 18 Jul 2025 04:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7481DAC95;
	Fri, 18 Jul 2025 04:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWHKnzs0"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A263214;
	Fri, 18 Jul 2025 04:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752814559; cv=none; b=OHLj62tKAnrfEWx60vJAONQW/yBCeDobZBj4O0FGToQ+EnH8dgcWrkTnu34ziKP5o+btKcjq6zgXhj3pDCQdQyzmK2kY3HqZ9IZlbJzsgy5oaoPgVfe39ldGajTb0TTphyR96rFHTB6OBM4babD8N/ypeRgibjcA7gu/FjrRFr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752814559; c=relaxed/simple;
	bh=+M1YEdqc2bUEljIJqbbhSN5U7iaJrkcsuuurGz5qnrI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Rv717tHzJPU1DV+xPTAcw2yYCEk1OG6rRMVqi7GgI9hGb4vF5ctBB7ZH3JkL29R+tOyqAHYaUNx7hDd5rr809JlusHmz6CcYd+0moaeXO7InIOsq0JtHSoGTDgVg47ZjCGppAMI18EI0YOUqPkl4B6xg/arGQbmQSeIu+XBjyng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWHKnzs0; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-748f5a4a423so1202438b3a.1;
        Thu, 17 Jul 2025 21:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752814557; x=1753419357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QrS0GKdVGrBy9Az98cf+bs7724OsqNyugXSKnqPU2zs=;
        b=NWHKnzs0C4aq5kYt/fLhJcDolPIGjZGlMmXKuj2tle8ZSnM3OTBqJVAjAsJnyE4RXC
         CEYXOypsys+IV1HGnTnd3SO6rnHQzHDtQF9hhUt4QC6f4RXBeVo9TAV4CqsQSUzN4Orw
         0z+BsD0RouABJvNOBmTxUFIlloudlmEpoIu3hsur8gyalKy8IHIgqzNEWFtFpY4QwHrg
         pLAHMFbDIB/Kge76W7TT0gts870lZkqbKsmRVdsvOjnZN01g83zx7sZTYOgzoTDkd2sb
         InK86D0xtqUUDsbWNaSOiFzSqV00IdgKwQPW9WZQSeFSasqxZS5gl9MMQT7hIFHC95m6
         PD1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752814557; x=1753419357;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QrS0GKdVGrBy9Az98cf+bs7724OsqNyugXSKnqPU2zs=;
        b=jZIkvfyQxCmpiYsB1QIVNt1cv7MZooaFXviPxV/88Fze3xzsgbWbaWJ7YrOyvRh42b
         ibjoKxHFapqXuJgY6OcY+/8bUSaI6ECuV0soIlVEaeHbS0/t3B2AV9LDwKu8ahwsD9tk
         s5qdodRAICBX+OouDK4uRfSXFuH1021ZiKc9vwgQX5Erd4NA5mig8rOs8pAlaJvJwksl
         AjuANWDYWQiPF4Cd1oUFUNZTXiMumfNBpbcKvsHPdRT//ogEVF0QDrkXsP5ZGevwbLg/
         c8XKWJwxw2g9s2I/vMJCxrbmeXpphasRcbUkM6IpidkKXKkvCcEFQNWaRcJVE2tPgbyO
         5tuQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1rCUU1KxvEz7BOhY2ywmeTwBEhwCGUdTjbsaCCMQddsZlf6Q66c85mGFHitOZqECiTCHYyRyd7aJo@vger.kernel.org, AJvYcCX+CNONM7iuHYLmjqY7Ch1S2PqJr0BuE5nYrKl9bZBc9e+l1yvxOmCYANL4wDlO5+QNIWL+2u5iNeTs@vger.kernel.org, AJvYcCXGLRQYQ3aefYAqF/LOaEdHsSBCnAmG9bDXUGfTJEh05b+wbe17CsJo9et4/+XuF6bWFnW0vDNRmvlGdbs5@vger.kernel.org, AJvYcCXX4mjmXZjKpdX6s8AyHIiIysN3Zq9c3toHo3QYhmg//CeBF9M1m23tG1RkU8wCt69qlRdmEjZU+dANbx7Z@vger.kernel.org
X-Gm-Message-State: AOJu0YyPiAeoi0F+7cctMewEjwSxSB5cPgDhIVLSJY4PrJBQSpHkvYti
	/+ktqygJvORAjv/0dtYYpeIuIL05NgpcAEbhbhML3RVeSi9i7g/Lv+mf
X-Gm-Gg: ASbGncsRAxnN0IiD5U+1oQjBfzqgJ82gVLrLLDBxH+roBbIS9hI7Zv2DZCg1W5tZRAj
	eossQuhmaqCsYi+TWDakxDt2O6fMCz0yBUvgei+3BYwrueCJwcik44XO5Yy8Vr0CroZ43fhQ9jN
	4h/yp1l6UTX6g4QF+jWGBoUNvrqZAmFViH5WoAPOmfZR5TVIF0BAd/AyFNOuE4UE5sWT1n2Wu2s
	Eq8quBL6PAanAMS7l+zfeswvPSG1aIvbj6jvbgbicuc6av3FnF0IYfGpOkcYca27YGn+onXbSmy
	dagy3SVMJl0oR1jRSFhpCVGGdFkIzrBN3AHan/2dIOD6bdcd6HJkfdSjIUV4F0ARKKPp6p03RaG
	wniomG2EZU/A9tGaKfn+5r3mwXHNc8YhO3JwDp9p3V9FnadjbWN8kTWmw1zHtkiMxydIGjTUS95
	Q4Cg==
X-Google-Smtp-Source: AGHT+IH7mTgR9t1Gn12elVnzlwHROsR3tjuQb0mAVMYdCS6KAtXhU2VNqDnYXRJg5yDgK62cVyVaLg==
X-Received: by 2002:a05:6a20:7483:b0:215:e818:9fe3 with SMTP id adf61e73a8af0-23813c6cbe3mr15503294637.27.1752814556806;
        Thu, 17 Jul 2025 21:55:56 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31cc33715b2sm476907a91.24.2025.07.17.21.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 21:55:56 -0700 (PDT)
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
Subject: [PATCH v4 0/7] hyperv: Introduce new way to manage hypercall args
Date: Thu, 17 Jul 2025 21:55:38 -0700
Message-Id: <20250718045545.517620-1-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

This patch set introduces a new way to manage the use of the per-vCPU
memory that is usually the input and output arguments to Hyper-V
hypercalls. Current code allocates the "hyperv_pcpu_input_arg", and in
some configurations, the "hyperv_pcpu_output_arg". Each is a 4 KiB
page of memory allocated per-vCPU. A hypercall call site disables
interrupts, then uses this memory to set up the input parameters for
the hypercall, read the output results after hypercall execution, and
re-enable interrupts. The open coding of these steps has led to
inconsistencies, and in some cases, violation of the generic
requirements for the hypercall input and output as described in the
Hyper-V Top Level Functional Spec (TLFS)[1]. This patch set introduces
a new family of inline functions to replace the open coding. The new
functions encapsulate key aspects of the use of per-vCPU memory for
hypercall input and output, and ensure that the TLFS requirements are
met (max size of 1 page each for input and output, no overlap of input
and output, aligned to 8 bytes, etc.).

With this change, hypercall call sites no longer directly access
"hyperv_pcpu_input_arg" and "hyperv_pcpu_output_arg". Instead, one of
a family of new functions provides the per-vCPU memory that a hypercall
call site uses to set up hypercall input and output areas.
Conceptually, there is no longer a difference between the "per-vCPU
input page" and "per-vCPU output page". Only a single per-vCPU page is
allocated, and it is used to provide both hypercall input and output.
All current hypercalls can fit their input and output within that single
page, though the new code allows easy changing to two pages should a
future hypercall require a full page for each of the input and output.

The new functions always zero the fixed-size portion of the hypercall
input area (but not any array portion -- see below) so that
uninitialized memory isn't inadvertently passed to the hypercall.
Current open-coded hypercall call sites are inconsistent on this point,
and use of the new functions addresses that inconsistency. The output
area is not zero'ed by the new code as it is Hyper-V's responsibility
to provide legal output.

When the input or output (or both) contain an array, the new code
calculates and returns how many array entries fit within the per-vCPU
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

The new family of functions is realized as a single inline function
that handles the most complex case, which is a hypercall with input
and output, both of which contain arrays. Simpler cases are mapped to
this most complex case with #define wrappers that provide zero or NULL
for some arguments. Several of the arguments to this new function
must be compile-time constants generated by "sizeof()" expressions.
As such, most of the code in the new function is evaluated by the
compiler, with the result that the runtime code paths are no longer
than with the current open coding. An exception is the new code
generated to zero the fixed-size portion of the input area in cases
where it was not previously done.

Use of the new function typically (but not always) saves a few lines
of code at each hypercall call site. This is traded off against the
lines of code added for the new functions. With code currently
upstream, the net is an add of about 20 lines of code and comments.

A couple hypercall call sites have requirements that are not 100%
handled by the new function. These still require some manual open-
coded adjustment or open-coded batch size calculations -- see the
individual patches in this series. Suggestions on how to do better
are welcome.

The patches in the series do the following:

Patch 1: Introduce the new family of functions for assigning hypercall
         input and output arguments.

Patch 2 to 6: Change existing hypercall call sites to use one of the new
         functions. In some cases, tweaks to the hypercall argument data
         structures are necessary, but these tweaks are making the data
         structures more consistent with the overall pattern. These
         5 patches are independent of each other, and can go in any
         order. The breakup into 5 patches is for ease of review.

Patch 7: Update the name of the variable used to hold the per-vCPU memory
         used for hypercall arguments. Remove code for managing the
         per-vCPU output page.

The new code compiles and runs successfully on x86 and arm64. However,
basic smoke tests cover only a limited number of hypercall call sites
that have been modified. I don't have the hardware or Hyper-V
configurations needed to test running in the Hyper-V root partition
or running in a VTL other than VTL 0. The related hypercall call sites
still need to be tested to make sure I didn't break anything. Hopefully
someone with the necessary configurations and Hyper-V versions can
help with that testing.

For gcc 9.4.0, I've looked at the generated code for a couple of
hypercall call sites on both x86 and arm64 to ensure that it boils
down to the equivalent of the current open coding. I have not looked
at the generated code for later gcc versions or for Clang/LLVM, but
there's no reason to expect something worse as the code isn't doing
anything tricky.

This patch set is built against linux-next20250716.

[1] https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/tlfs

Michael Kelley (7):
  Drivers: hv: Introduce hv_setup_*() functions for hypercall arguments
  x86/hyperv: Use hv_setup_*() to set up hypercall arguments -- part 1
  x86/hyperv: Use hv_setup_*() to set up hypercall arguments -- part 2
  Drivers: hv: Use hv_setup_*() to set up hypercall arguments
  PCI: hv: Use hv_setup_*() to set up hypercall arguments
  Drivers: hv: Use hv_setup_*() to set up hypercall arguments for mshv
    code
  Drivers: hv: Replace hyperv_pcpu_input/output_arg with hyperv_pcpu_arg

 arch/x86/hyperv/hv_apic.c           |  10 +--
 arch/x86/hyperv/hv_init.c           |  12 ++-
 arch/x86/hyperv/hv_vtl.c            |   3 +-
 arch/x86/hyperv/irqdomain.c         |  17 ++--
 arch/x86/hyperv/ivm.c               |  18 ++---
 arch/x86/hyperv/mmu.c               |  19 ++---
 arch/x86/hyperv/nested.c            |  14 ++--
 drivers/hv/hv.c                     |   6 +-
 drivers/hv/hv_balloon.c             |   8 +-
 drivers/hv/hv_common.c              |  64 +++++----------
 drivers/hv/hv_proc.c                |  23 +++---
 drivers/hv/hyperv_vmbus.h           |   2 +-
 drivers/hv/mshv_common.c            |  31 +++----
 drivers/hv/mshv_root_hv_call.c      | 121 +++++++++++-----------------
 drivers/hv/mshv_root_main.c         |   5 +-
 drivers/pci/controller/pci-hyperv.c |  18 ++---
 include/asm-generic/mshyperv.h      | 106 +++++++++++++++++++++++-
 include/hyperv/hvgdk_mini.h         |   4 +-
 18 files changed, 251 insertions(+), 230 deletions(-)

-- 
2.25.1


