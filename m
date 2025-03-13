Return-Path: <linux-arch+bounces-10696-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 449BCA5EB97
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 07:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A35973B71E5
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 06:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA451FA84F;
	Thu, 13 Mar 2025 06:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGjw6W0K"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600D52F2E;
	Thu, 13 Mar 2025 06:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741846768; cv=none; b=VGhUU6kfntWuo9bhP8XA9BDT0zyOLUgLfwAWqDpIh4UOB9fAGL55U9FTiFSywQahlA6tstzkpGtdMTuQtWZJRs+B0muCNAVEb0BaThKMGv7ffD1Xz6uWBkCNN4fa9nGozVcJPsNwtj9ko0rZ/LZbtOuQrtJXf1iQDu0V3molF+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741846768; c=relaxed/simple;
	bh=6+Op+lyCycwJhs/YJ17iT1umDzfeT7rmCXKyOJCk7ZM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lJcQ9bio+17p7meAtFI4fsOnS3h2RtbWulmJOFsOkxmkOYQnkrBtaNJ3fNkGe7kZsqJa5bgJgNgNq6ubEMsfgZq6WrbEUskTzrLQ1XvaoxfGjGf15u4kwzLKesv4SGVI4wBi9UW18p0Xxn+VWfTm08tIPaPrLpo0gdm5a4c4bTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGjw6W0K; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22409077c06so15406825ad.1;
        Wed, 12 Mar 2025 23:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741846765; x=1742451565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5AEORV8hgJxqEhMV8ZMadRplYEF+lyBFwpCTbagzejc=;
        b=bGjw6W0KG2axLriXShAQsAUiyCr18L27zMPzN2R38EDPyBbkkxRFa/2oJHKOcrHJHM
         VIVeO3ZdVs7krBJA1QGb8SWQ4NwQAG2SpokG5kflSfr2P6lTntXUA2GdsAAzNSYZNwv6
         jwy+nObxvbcLAUyxFPrywpfufFELb1DCSLHiYwq71L7F6EmAN5yQW+n0/0vPdmRiBcHH
         lDcszVyOP//Wtvo7BZHN45idQ8Km/TpvWTi9+yGbgkqbSGVUBh+xjgdJ8+3/XuJHtbfU
         qxgCCUPdXbe20FAanIHO/9OuS6M2GkKRo3clw5+JT0cpPCXmJUB2NIo5NvphIUZn8Ox9
         Dl0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741846765; x=1742451565;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5AEORV8hgJxqEhMV8ZMadRplYEF+lyBFwpCTbagzejc=;
        b=ohk+zz97jeBT1hXriY5qK7ujDqljPxEWV4TXE9+w4f4twcUyblsdQeTzCxXjFqxhEV
         Vdq1TfegHSdfq3/lUIxc4DAbmttC8nkEBgymnfKPnHKLTlSXRu30G1ZLwHBaZIRQ6n71
         SKUMCLmbfiSjWkad9Ry5N5bcOfYzNmCxcVUonpH6x2AeiR6OkD8caKhvzClakwNN1cOk
         TLlpN5fHd5hI1NB+e35++DwbkzmMzNOuQOR2qd6Fd+nxbllSCP4VRBFh/RLu11sEgOFA
         Mgc/OUVYT8zfYV9JdHcV1CzKForz0npWYDCURSe1YSllrd7Xz5jZv2LwMIFoJBhGd9t4
         hISw==
X-Forwarded-Encrypted: i=1; AJvYcCVFNT2UhNQpqef7UAvr6JgsIse8mBj0Tjza1AGAeENsSX2Z6ZU8NG9MsOW79aaFF4SaZq4W7BXcJ+mx@vger.kernel.org, AJvYcCVYtHrG1cWs9ISAz/me5gm1PF5tBlEAy0CMkS+iFGxUugmD5kvB8lZsaZRKDkVBUvnDms6MLVgRuS4MReSu@vger.kernel.org, AJvYcCXOo550haPH83YOTzqzxcX4oPFnB7QNZ5I+VFITUHzv73jPK/IOMA8QtCjCMo3sXPkwEO9AXRnFLLMwXEwc@vger.kernel.org, AJvYcCXmgRdXfnlIP7J8yj3Mj/H3bp085WsQQIgXCnOUwS55XtAFF52tuhzPz/JKu2FO5AdKttl1mcUurEr8@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyq8Hwl7rilKfABb/UqzySvUpB2MZkfdQjDPbfLhTOLzslAe1F
	MMG87W7wY3anhTjAKIlmSxeTHxIl6DPRayHzTWd6tVqbqMlN9j9c
X-Gm-Gg: ASbGnct6rudYaTQppnjDPHcHBNHA+V2zbOylEST3pU+7kLhmT/j4D3UB7OV362ozi2Q
	dQTZm4IxhmugmZSk8wmU22suYjG2BO99GCcm/iE67IAcqKZ5qMac7PgbYzJybnfDu7EgxVZphLc
	MXbIEyGKLg/e/PwooflteTn9LVD8KC/GXagGibwK7SXI5TqHaTCWUqQErzGIZWi2R6fQCYdOkdQ
	2IAasJWT4ZgWUIBKkdyrnw73ed1v7cMVwm+tphSCm72zSdEFRHWfzUmTXn/d2T6kgFpXlNpYhes
	DrtVr++LGuNOFMosa8OH5WJ/bHt+JlFRmldk4/Ajp/QBGVgAsmSanm2T/RUhptdHiLNzwbHISAx
	wV2ZVUYtL9lYr4OYrVjEKlVI=
X-Google-Smtp-Source: AGHT+IEus6VFy47YaAw3pn+3kom0RXfYbUHDNa127pXeDRAp5C/cxTv4BWeEGn3OlBfTu5QxnnHJYw==
X-Received: by 2002:a17:903:283:b0:224:194c:6942 with SMTP id d9443c01a7336-22428bded4amr397258325ad.34.1741846765523;
        Wed, 12 Mar 2025 23:19:25 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68880dfsm5856985ad.38.2025.03.12.23.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 23:19:25 -0700 (PDT)
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
Subject: [PATCH v2 0/6] hyperv: Introduce new way to manage hypercall args
Date: Wed, 12 Mar 2025 23:19:05 -0700
Message-Id: <20250313061911.2491-1-mhklinux@outlook.com>
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
upstream, the net is an add of about 60 lines of code and comments.
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

Patch 1: Introduce the new family of functions for assigning hypercall
         input and output arguments.

Patch 2 to 5: Change existing hypercall call sites to use one of the new
         functions. In some cases, tweaks to the hypercall argument data
         structures are necessary, but these tweaks are making the data
         structures more consistent with the overall pattern. These
         four patches are independent of each other, and can go in any
         order. The breakup into 4 patches is for ease of review.

Patch 6: Update the name of the variable used to hold the per-cpu memory
         used for hypercall arguments. Remove code for managing the
	 per-cpu output page.

Patch 1 from v1 of the patch set has been dropped in v2. It was a bug
fix that has already been picked up.

The new code compiles and runs successfully on x86 and arm64. Separate
from this patch set, for evaluation purposes I also applied the
changes to the additional hypercall call sites in the OpenHCL
project[2]. However, I don't have the hardware or Hyper-V
configurations needed to test running in the Hyper-V root partition or
in a VTL other than VTL 0. So the related hypercall call sites still
need to be tested to make sure I didn't break anything. Hopefully
someone with the necessary configurations and Hyper-V versions can
help with that testing.

For gcc 9.4.0, I've looked at the generated code for a couple of
hypercall call sites on both x86 and arm64 to ensure that it boils
down to the equivalent of the current open coding. I have not looked
at the generated code for later gcc versions or for Clang/LLVM, but
there's no reason to expect something worse as the code isn't doing
anything tricky.

This patch set is built against linux-next20250311.

[1] https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/tlfs
[2] https://github.com/microsoft/OHCL-Linux-Kernel

Michael Kelley (6):
  Drivers: hv: Introduce hv_hvcall_*() functions for hypercall arguments
  x86/hyperv: Use hv_hvcall_*() to set up hypercall arguments -- part 1
  x86/hyperv: Use hv_hvcall_*() to set up hypercall arguments -- part 2
  Drivers: hv: Use hv_hvcall_*() to set up hypercall arguments
  PCI: hv: Use hv_hvcall_*() to set up hypercall arguments
  Drivers: hv: Replace hyperv_pcpu_input/output_arg with hyperv_pcpu_arg

 arch/x86/hyperv/hv_apic.c           |  10 ++-
 arch/x86/hyperv/hv_init.c           |  12 ++--
 arch/x86/hyperv/hv_vtl.c            |   9 +--
 arch/x86/hyperv/irqdomain.c         |  17 +++--
 arch/x86/hyperv/ivm.c               |  18 ++---
 arch/x86/hyperv/mmu.c               |  19 ++---
 arch/x86/hyperv/nested.c            |  14 ++--
 drivers/hv/hv.c                     |  11 +--
 drivers/hv/hv_balloon.c             |   4 +-
 drivers/hv/hv_common.c              |  57 +++++----------
 drivers/hv/hv_proc.c                |   8 +--
 drivers/hv/hyperv_vmbus.h           |   2 +-
 drivers/pci/controller/pci-hyperv.c |  18 +++--
 include/asm-generic/mshyperv.h      | 103 +++++++++++++++++++++++++++-
 include/hyperv/hvgdk_mini.h         |   6 +-
 15 files changed, 184 insertions(+), 124 deletions(-)

-- 
2.25.1


