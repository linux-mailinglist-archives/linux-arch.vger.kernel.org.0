Return-Path: <linux-arch+bounces-11403-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E029A8A64F
	for <lists+linux-arch@lfdr.de>; Tue, 15 Apr 2025 20:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9DCE3AA545
	for <lists+linux-arch@lfdr.de>; Tue, 15 Apr 2025 18:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13499221D8E;
	Tue, 15 Apr 2025 18:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ln5wy08H"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571A919CD17;
	Tue, 15 Apr 2025 18:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744740473; cv=none; b=DgvdhssEFDG3QLyNQqiIDHZq2FPrcaCP4obbS1Kro5rS62r/CV7Ecme7bHJ0hkSukTimZgTb7GkUJvmtj/HU4r0EzPSxRKumPDlIB0WDn3qB463rjIuTJuR7HvansUOgtmuZM8f+k7DakH+RV3Rj+fzkmgIhQAphSL3kywq8S2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744740473; c=relaxed/simple;
	bh=E12Dv2lpYWaPvD1bJV2GxBmQo52NBjNVBWLixN31wCM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TZeCSgP9lkQwOy0bXPNdesoSHK7aXA5vrUPS+BzabDaOnM02T07/P0oEDQcI0k6y+AubRWRnllOXGQYoV4PcddGygH2o0Y9qHY6TK+DzU3PvXUY8WdYEp8L8wHf7kxCr7DXdPpmIhXPJ5JgUu70SJn/D36A9ZT4cG1GkBd9DJVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ln5wy08H; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-224171d6826so82970295ad.3;
        Tue, 15 Apr 2025 11:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744740470; x=1745345270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xvDGS2NFZu3dmg8r6i71jHs8hnBaXJGkkCFNiMhz6fw=;
        b=Ln5wy08HUE910xh6soNbi0ue434h3niivEj0LJ9rm5QJrUM68DzlIaNkopdbqdURme
         eYxUXBBxtwI3pcmj57nBCmZM3FPnFCk5BYgUsqXRzAhh6ypoMaiir5j0SehzZGSl2ke9
         5MUZSl5g80OplG9KU0I8h6qgvVYq/xXBrddPgntWiNgzArCegmvp6Uc6ewCxzZdb9sn6
         z3SbrXaG0xYkMYd+ImmyQ0pkx0lRORZlARDmfob3CCHK/HR89YRk1/4MrNKTKdt2DvKf
         q2kggr2g7l8MrDOuV6tsoCNfRsbkz8gb/rNhJp2dn5dQeFjTQzC8BJHAaI8wtUdn0p3R
         0HxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744740470; x=1745345270;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xvDGS2NFZu3dmg8r6i71jHs8hnBaXJGkkCFNiMhz6fw=;
        b=U3WBWSrML+fJIxRm6wnHh8YD7fNDiYLb78/QUhW3kEHuDt9Z+NrgoiTp48aKbTOKWs
         j9iihoZOYyg1hEpKqOzthQ9PLNhCJ3lpEZL3o2R4szEAVSzsTaar5XS/1w1rD62aoM1k
         aPivnqvbeNnF6yhBR8KY2h2c8owgbeQ/LJCfkH5rSMjMH0Mru02dRLhFd3/FNfgIVdRb
         MSMn2/sg+QIcN380Czg2WgJhSdZVc4+vVExUaE92P/RKHEBCi/J372Ra8c+Ah8fN8ljM
         VHO+7yR5Ol3THA95GAH84JKh23v3o9FRXzVWPmwCN0WtM7T3PpchXW4hALZmtD17EZZh
         eeFg==
X-Forwarded-Encrypted: i=1; AJvYcCU34ocYWTIURn26H9jMev2d6WEJj+3nsDx+jV4A0nLYYhx6cZ2jxwXWn4H1u1QPoVeuCoLlUHNqo7IK2hIx@vger.kernel.org, AJvYcCUiIksMKYKwsQe38oIvPW6XLFKImwU22zZbj9Li4g8k0MiYtzBFFpFJOrCsEvA/j4AC/GcKNhOvwBoCssHn@vger.kernel.org, AJvYcCV75xawSujTw/SGoR9Mg7j01nuV2P2TzguGx42dysut+4/9+Tr8XM/VhzBa0Z7vIW27x02VR3+c1cHu@vger.kernel.org, AJvYcCVZ49RTzotQtqmWIdkqvRU7uvTr5Ct2cu6+bPSUuZOGKnV7EQ6CSpmdUT4fE0qr1ulGqeXaABUvqTmX@vger.kernel.org
X-Gm-Message-State: AOJu0YwKWTLd6oU+43+HchvGRqHzty9+FnE530hxEtDusefNIEHTf5dP
	MRy8foaJKXdymTsQMEFY60bX9qLnZTDF3ODtuzu+Ll0B/EApSngD
X-Gm-Gg: ASbGncswVZRt6dY+7/MxCFhI+B6CNBHsF220v3O6eDYBw5tG8lxXczY9JBPXfT76Bm7
	23A9vDuLbUyFkTKclbKRA6Uo8K3XkQ/DeO4+ky9l0Yy+pTTEZzTZHdyoPJifX+ISJk1yZwHIMsm
	2b0zGUc/wQvhdsMer1+OSZZhcQgE8Vpn/HgMBAUftl2sG++1tG6PPGF9HZqKCJ33tQHoyy2ucvy
	ri/5FWhl5uTQBZvSGQ0gpEgjLNsh8vJxSEZigH0opgiStamA9mCnq1i/a/GYyashbYcJ8dKHYNz
	Sc4Fe4NgroboQMOs4bzSDMGi4OhuxDjY3hrkYh0HE6EFQkRNZUDD5bx+4O9ampafHktJMPCwO3o
	0iC2Tvup/riTZ69+0IdE=
X-Google-Smtp-Source: AGHT+IG+TokD7i8vItk+7QmWwNiAFv1lxx9jEciK+l5SQy/NyBGc0DV4Ti8nxJG7cYXtOTbqVh66ow==
X-Received: by 2002:a17:902:eb8a:b0:224:de2:7fd6 with SMTP id d9443c01a7336-22c319f641bmr2212275ad.25.1744740470302;
        Tue, 15 Apr 2025 11:07:50 -0700 (PDT)
Received: from localhost.localdomain (c-67-160-120-253.hsd1.wa.comcast.net. [67.160.120.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7cb52c2sm120168425ad.194.2025.04.15.11.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 11:07:49 -0700 (PDT)
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
Subject: [PATCH v3 0/7] hyperv: Introduce new way to manage hypercall args
Date: Tue, 15 Apr 2025 11:07:21 -0700
Message-Id: <20250415180728.1789-1-mhklinux@outlook.com>
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
hypercall input and output, and ensure that the TLFS requirements are
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

Patch 6 is new in v3 of the patch set. It updates the new hypercall
call sites added as part of the mshv code in the 6.15-rc1 kernel.

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

This patch set is built against linux-next20250411.

[1] https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/tlfs

Michael Kelley (7):
  Drivers: hv: Introduce hv_hvcall_*() functions for hypercall arguments
  x86/hyperv: Use hv_hvcall_*() to set up hypercall arguments -- part 1
  x86/hyperv: Use hv_hvcall_*() to set up hypercall arguments -- part 2
  Drivers: hv: Use hv_hvcall_*() to set up hypercall arguments
  PCI: hv: Use hv_hvcall_*() to set up hypercall arguments
  Drivers: hv: Use hv_hvcall_*() to set up hypercall arguments for mshv
    code
  Drivers: hv: Replace hyperv_pcpu_input/output_arg with hyperv_pcpu_arg

 arch/x86/hyperv/hv_apic.c           |  10 +--
 arch/x86/hyperv/hv_init.c           |  12 ++-
 arch/x86/hyperv/hv_vtl.c            |   9 +--
 arch/x86/hyperv/irqdomain.c         |  17 ++--
 arch/x86/hyperv/ivm.c               |  18 ++---
 arch/x86/hyperv/mmu.c               |  19 ++---
 arch/x86/hyperv/nested.c            |  14 ++--
 drivers/hv/hv.c                     |   6 +-
 drivers/hv/hv_balloon.c             |   8 +-
 drivers/hv/hv_common.c              |  57 ++++---------
 drivers/hv/hv_proc.c                |  23 +++---
 drivers/hv/mshv_common.c            |  31 +++----
 drivers/hv/mshv_root_hv_call.c      | 121 +++++++++++-----------------
 drivers/hv/mshv_root_main.c         |   5 +-
 drivers/pci/controller/pci-hyperv.c |  18 ++---
 include/asm-generic/mshyperv.h      | 106 +++++++++++++++++++++++-
 include/hyperv/hvgdk_mini.h         |   4 +-
 17 files changed, 250 insertions(+), 228 deletions(-)

-- 
2.25.1


