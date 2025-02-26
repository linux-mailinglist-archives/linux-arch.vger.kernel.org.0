Return-Path: <linux-arch+bounces-10385-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E388A46BF7
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2025 21:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D946816E754
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2025 20:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986292755F4;
	Wed, 26 Feb 2025 20:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2K3J1/n"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D552755EF;
	Wed, 26 Feb 2025 20:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740600382; cv=none; b=BTj+lvnw91HcpToy5reqUDWbrzJgQkyjGL5z9xZwHNPi2UQcw77CaRnUul6P8/HC2Z8hoZm5Mq19FzmEfxuRQU2kt59U+YOO6XPjQF/k+0J9mOya/RLVHV/3bTRmY4PdVN1S4sivwdZAPQUzbtMw2s9zcNTvv47viOch2mCa6po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740600382; c=relaxed/simple;
	bh=Qwi4KLRZHSKULvc9TsrHBSVF6BHVRfJw+F+pxfDP6Co=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AEIwJk+rIg0c5f7tfxx3UU3ogTMyFOvlXH21fcq4nY07vSB6XY/CyTRQmtJLP7Izuja81EXIM0ZeEAuEXWQfxgQL0pZ13fs+9Z+sW4rA4e4pgpMInpHmPG+19mVdpFWGXZ4abtu0i8Pt/nLy4fWnGGI6HPZX2/ScbhFXUnGai5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a2K3J1/n; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-220c665ef4cso2101085ad.3;
        Wed, 26 Feb 2025 12:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740600380; x=1741205180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PxiRq78U2jPFlTNGv1YwFWfVoPu/XyZEq9nATYTUrec=;
        b=a2K3J1/n9TFiP/Vn0Yh9R8WeEhlrGl6pp7X1irvWUuf5mZlRIXtxAifRzlocov+fDv
         R19L0zaIzpHAqnbN6LJLI/3yXMnSAf3tQQe9A67axwJwic9qoblRxP8WWCYkLAs9VBnY
         4dDdYS5Ps23rAdKmuT+WcfdIhmQ730yaQCEuvryFD7JqLfdjzh0h4Gxby141LRGPFk+h
         9cws38jSn8O0WeUGQFQ6HG3j1GsokAuLWgGF6NYK14XpDIYJScICiVdCg7vpHZgmKnwR
         g5Uv1SyegV1X3NsTHkg1dmB0UCVzSvKDnDv97sKt/MPx5j4+OYgmp8wDpAgqHiGLUlJV
         ioGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740600380; x=1741205180;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PxiRq78U2jPFlTNGv1YwFWfVoPu/XyZEq9nATYTUrec=;
        b=TRKd46C3tZ7dkylz33mJS1mDB9ZNvzgWB+zIL3mygRSNGqSSO6+vnN2NlI1LkwgxcY
         jzmYQVllam5mdvZ7mILBzj7VK/oCJtRHMfY7YEEuF5BEnLH3gbZ2binTVrwnrqmoYt66
         rgV9vIcQIpJj9KHMtEXXb5dxTQDL66ycVTzZdVuSXWNLUjBcG9/w9ef9iuZ+YbX7Uidy
         LU2Z6YDBCRfflXQhgrBU4Nzg+LmDDu2LAQadbWUFvF64QYN5XOqe7eXG2deBssxDcxCQ
         h4EM80Z5zy2LuK8iMZ4/4Bvt7o3AdWIniTODvbfraQ3tyl+hqRSmBAgkyeIE2phsk5Md
         2c5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVaUuc2+FAPyCavz83iIYmSf0i98xxJb2L7GiQ1LFEanaSiVYVzHICuDqX6/6nVWk08wz+BdwXqNAo+@vger.kernel.org, AJvYcCVrOjHO++TvpVct9yfDtgynCpk1MhDNHi9b2g+gQFM7fUMTxZFhOnvQ98RhJ+fzR3L6yz0XDNFbYwEr95lY@vger.kernel.org, AJvYcCVzPJz4cftrD12BVsvv5TImD+41VAyyKy3LWsfc+E/CGjtKDfPFwUZHhkTzKLzr5nkMFE5g5qGLqzwl@vger.kernel.org, AJvYcCXkDB7sI+A+NIRC9HPeh/z5uBLVbNTVAnVD+91kBmhmt+PmQMlzbxvwFwmO5ZuTKzPrg7m6sJn3BWlXUt5h@vger.kernel.org
X-Gm-Message-State: AOJu0Yzck9Ix9gnjxKwxb/OUPN3w19WMXUlg3xUag53jTFuTmRSH702P
	3R7RR6B5aHykn5+0EUPsYfd+82wYJnnfT6qwXznjZF2rlcQfC9r3
X-Gm-Gg: ASbGncut7YhZfa73GLroamWMmKV0iw4Al0NFzlTyo8zAgOB8d2VOeTx91df/Hr2sQXa
	8BcK+2qpXL6hj3T8AA2OzKHQqxtc/THaFqSd7mdeJCnlXrP7CT9p+2de1AVLSAza2Gkk2y9105T
	65KWUKpoYHBPXuHcCNyb+QjAt5pBU8F3xwEPFGzIh8K8gUhOT7t0bUAPybFR8hdVh4E264qWulS
	2eY5liWn17h7cqDoKSUYYEesf5FRDAZS3QHztZVEJ+038VXqqWLJtrk4hLCUBQxFCISFvn1eLOm
	nJCw1aG5N6cHs0EN0UmI7N36vyaKDiX/nfWiBc7Pa7p9J3Tvfkxk/wxecxorITdrGjlSvJzngty
	oJLi2
X-Google-Smtp-Source: AGHT+IEojOR6tAKis+U6tI9fXVSee8oQYC4xGPiGsAK0HXKfdtGTGkYXxvCYGSTLXLErMf61IT4rtg==
X-Received: by 2002:a17:903:22c4:b0:215:a05d:fb05 with SMTP id d9443c01a7336-221a00156b6mr362470725ad.32.1740600379909;
        Wed, 26 Feb 2025 12:06:19 -0800 (PST)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a81bbc7sm3959455b3a.127.2025.02.26.12.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 12:06:19 -0800 (PST)
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
Subject: [PATCH 0/7] hyperv: Introduce new way to manage hypercall args
Date: Wed, 26 Feb 2025 12:06:05 -0800
Message-Id: <20250226200612.2062-1-mhklinux@outlook.com>
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

This patch set introduces a new way to manage the use of the per-cpu
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
hypercall input and output,and ensure that the TLFS requirements are
met (max size of 1 page each for input and output, no overlap of input
and output, aligned to 8 bytes, etc.).

With this change, hypercall call sites no longer directly access
"hyperv_pcpu_input_arg" and "hyperv_pcpu_output_arg". Instead, one of
a family of new functions provides the per-cpu memory that a hypercall
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
calculates and returns how many array entries fit within the per-cpu
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
for some arguments. Several of the arguments to this new function are
expected to be compile-time constants generated by "sizeof()"
expressions. As such, most of the code in the new function is
evaluated by the compiler, with the result that the runtime code paths
are no longer than with the current open coding. An exception is the
new code generated to zero the fixed-size portion of the input area
in cases where it was not previously done.

Use of the new function typically (but not always) saves a few lines
of code at each hypercall call site. This is traded off against the
lines of code added for the new functions. With code currently
upstream, the net is an add of about 50 lines of code and comments.
However, as additional hypercall call sites are upstreamed from the
OpenHCL project[2] in support of Linux running in the Hyper-V root
partition and in VTLs other than VTL 0, the net lines of code added is
nearly zero.

A couple hypercall call sites have requirements that are not 100%
handled by the new function. These still require some manual open-
coded adjustment or open-coded batch size calculations -- see the
individual patches in this series. Suggestions on how to do better
are welcome.

The patches in the series do the following:

Patch 1: Fix a hypercall argument error discovered in one hypercall
         call site while researching this project.

Patch 2: Introduce the new family of functions for assigning hypercall
         input and output arguments.

Patch 3 to 6: Change existing hypercall call sites to use one of the new
         functions. In some cases, tweaks to the hypercall argument data
         structures are necessary, but these tweaks are making the data
         structures more consistent with the overall pattern. These
         four patches are independent of each other, and can go in any
         order. The breakup into 4 patches is for ease of review.

Patch 7: Update the name of the variable used to hold the per-cpu memory
         used for hypercall arguments. Remove code for managing the
	 per-cpu output page.

The new code compiles and runs successfully on x86 and arm64. Separate
from this patch set, for evaluation purposes I also applied the
changes to the additional hypercall call sites in the OpenHCL
project[2]. However, I don't have the hardware or Hyper-V
configurations needed to test running in the Hyper-V root partition or
in a VTL other than VTL 0. So the related hypercall call sites still
need to be tested to make sure I didn t break anything. Hopefully
someone with the necessary configurations and Hyper-V versions can
help with that testing.

For gcc 9.4.0, I've looked at the generated code for a couple of
hypercall call sites on both x86 and arm64 to ensure that it boils
down to the equivalent of the current open coding. I have not looked
at the generated code for later gcc versions or for Clang/LLVM, but
there's no reason to expect something worse as the code isn't doing
anything tricky.

This patch set is built against linux-next20250222.

[1] https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/tlfs
[2] https://github.com/microsoft/OHCL-Linux-Kernel

Michael Kelley (7):
  x86/hyperv: Fix output argument to hypercall that changes page
    visibility
  Drivers: hv: Introduce hv_hvcall_*() functions for hypercall arguments
  x86/hyperv: Use hv_hvcall_*() to set up hypercall arguments -- part 1
  x86/hyperv: Use hv_hvcall_*() to set up hypercall arguments -- part 2
  Drivers: hv: Use hv_hvcall_*() to set up hypercall arguments
  PCI: hv: Use hv_hvcall_*() to set up hypercall arguments
  Drivers: hv: Replace hyperv_pcpu_input/output_arg with hyperv_pcpu_arg

 arch/x86/hyperv/hv_apic.c           |   6 +-
 arch/x86/hyperv/hv_init.c           |  11 ++-
 arch/x86/hyperv/hv_vtl.c            |   8 +--
 arch/x86/hyperv/irqdomain.c         |  10 ++-
 arch/x86/hyperv/ivm.c               |  21 +++---
 arch/x86/hyperv/mmu.c               |  17 +----
 arch/x86/hyperv/nested.c            |  14 ++--
 drivers/hv/hv.c                     |  10 +--
 drivers/hv/hv_balloon.c             |   4 +-
 drivers/hv/hv_common.c              |  57 +++++-----------
 drivers/hv/hv_proc.c                |   8 +--
 drivers/hv/hyperv_vmbus.h           |   2 +-
 drivers/pci/controller/pci-hyperv.c |  14 ++--
 include/asm-generic/mshyperv.h      | 102 +++++++++++++++++++++++++++-
 include/hyperv/hvgdk_mini.h         |   6 +-
 15 files changed, 169 insertions(+), 121 deletions(-)

-- 
2.25.1


