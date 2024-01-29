Return-Path: <linux-arch+bounces-1777-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C237841199
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 19:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60CE41C21C64
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jan 2024 18:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261FD3F9DC;
	Mon, 29 Jan 2024 18:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u+u97NKp"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFC73F9CE
	for <linux-arch@vger.kernel.org>; Mon, 29 Jan 2024 18:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706551531; cv=none; b=uyz0BSjE0rtZDd5Z/15S8q5uASWakWHBknbcS0W/TtUUAlzxzxZdCCVqQzMEzKuKqfVAJPLRF05Gk6JDc8WfCj76cQM6yHdpJt8PMa8yx7nb7vRbJeNz4Qty6I/Hzd4xLDJJf2ZTri1pOTs86YlxwCT3EVB+tdwFC1hRl6r0HOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706551531; c=relaxed/simple;
	bh=YdhZ66KOErP/puxhjIeE2xj8p2TmW0k7m++j4/SciGY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tqNmDIKEoT4EYK3wxnpsfaVPbp+IHsoQGICQPkLZ/iwoKjcscAqwnUM/9EIkRbUEcPbGgfAR4OPJx2h5b/wElDur+7ULrwkW9tVjAgXMHHhdTo7O3p4vlPTkId2Z1mYaLFNWMvz2mdDRficafba7eYuQ056j/1dcCDxxNsGkMbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u+u97NKp; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc22f3426aeso5716627276.1
        for <linux-arch@vger.kernel.org>; Mon, 29 Jan 2024 10:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706551528; x=1707156328; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0dgHDmyiuf24yKbMsV5rC/PIHquqMJzNMfIw3GnnTIc=;
        b=u+u97NKp6UC4HnYs6s2q0nQfUi8jWB4uOaoeESTWWQHvNDyPc6lSQpF7s8niY15gVf
         UbGwEgk4FUZlVVWVlk878dJiMjYOdslph8C12B0DCfKIqnZ8NdDInhAfQ1vKRJgsZej+
         Auo0bBNnyX2hHqdw/8Q9EhhxgPCEhB/4nEKqmmomglkLSzzdqYO8gEQBzTulTv9xx/bp
         Q0RDUpdDmM9FhV4oEBqAqqAP4QiB4yUSZJyYfZuBT6i/QT5UYI5DUQxG6vPtKbnnGTH1
         SM6lFm/C2/XHift2BahCUAMpnpypPof57eSzhpxCYoELt2n5xi9STbsdE0lP94gumbR6
         GQzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706551528; x=1707156328;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0dgHDmyiuf24yKbMsV5rC/PIHquqMJzNMfIw3GnnTIc=;
        b=LJvzRgE14Z6ALaGiA/BTfjazGGm0MaYOKAJuU9tiupVP1WuFTQRrxHPCZRO5wvYydw
         jJ0N7ZmC3N2x9j00PE461dK4eX/Vftbxd34ez/efgK+PQD//WVWR1lXJAYCORrLHivtS
         oQK/gmfjGmkd/Z1RyZv3V/eL80TU21owEXsk+cyYxCS8ug/FwsvoUTXWjSH0vp+U6t5d
         SpsSfb97siXiiBZ7Ug6+BlvW01uR/HCNo38lVWSNaoBhh19XqHqAGoXJ0Fvcu20ojkOt
         nCb6jNEZKJqc9rgIsu9jZVW0KpyGQBToh5q5UHS8d7PiTWaJFNnBVspRVvo4GPMkz57n
         qW0Q==
X-Gm-Message-State: AOJu0Yx7ezr04HwNDrvnS/RXeaHqqG1+DoFaz7qgDyqmfAPKhQxWTO21
	Z74f/LlDwdDFs7Z5KxLKp6L7m3eLWdWptuC2CqreyT3ZGfKygVdR+TL4D/Nmvla2xeO7iQ==
X-Google-Smtp-Source: AGHT+IGaATphYw3isIigM+VeGOYOeH4enRg6wjibBlkhiC3PQiWztkmu11zGrZOwDGivx7JkOKdoPSL7
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a25:8908:0:b0:dc3:696e:ffae with SMTP id
 e8-20020a258908000000b00dc3696effaemr1936135ybl.3.1706551528335; Mon, 29 Jan
 2024 10:05:28 -0800 (PST)
Date: Mon, 29 Jan 2024 19:05:03 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=6464; i=ardb@kernel.org;
 h=from:subject; bh=3TIgd8JH8leGyvCOvibsMg9R6VNfjDFus1JZk+AZ7Zs=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIXX7i/N3XHfs68hwrlq/xO1Tou0aE1lPb6fL/mVP5vzJ8
 VrOzTy/o5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEwk/jgjw78vwX51p59YF/JM
 799+tWSLWe/KJNc+hdU6mQxtRa+70hj+R0w3TQm7uXryiQkLjjyfIio1Y/+lf93qm3/8mDH76nd eZz4A
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240129180502.4069817-21-ardb+git@google.com>
Subject: [PATCH v3 00/19] x86: Confine early 1:1 mapped startup code
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Dionna Glaze <dionnaglaze@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Justin Stitt <justinstitt@google.com>, 
	Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, linux-arch@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

This is a follow-up to my RFC [0] that proposed to build the entire core
kernel with -fPIC, to reduce the likelihood that code that runs
extremely early from the 1:1 mapping of memory will misbehave.

This is needed to address reports that SEV boot on Clang built kernels
is broken, due to the fact that this early code attempts to access
virtual kernel address that are not mapped yet. Kevin has suggested some
workarounds to this [1] but this is really something that requires a
more rigorous approach, rather than addressing a couple of symptoms of
the underlying defect.

As it turns out, the use of fPIE for the entire kernel is neither
necessary nor sufficient, and has its own set of problems, including the
fact that the PIE small C code model uses FS rather than GS for the
per-CPU register, and only recent GCC and Clang versions permit this to
be overridden on the command line.

But the real problem is that even position independent code is not
guaranteed to execute correctly at any offset unless all statically
initialized pointer variables use the same translation as the code.

So instead, this v2 and later proposes another solution, taking the
following approach:
- clean up and refactor the startup code so that the primary startup
  code executes from the 1:1 mapping but nothing else;
- define a new text section type .pi.text and enforce that it can only
  call into other .pi.text sections;
- (tbd) require that objects containing .pi.text sections are built with
  -fPIC, and disallow any absolute references from such objects.

The latter point is not implemented yet in this v3, but this could be
done rather straight-forwardly. (The EFI stub already does something
similar across all architectures)

Changes since v2: [2]
- move command line parsing out of early startup code entirely
- fix LTO and instrumentation related build warnings reported by Nathan
- omit PTI related PGD/P4D setters when creating the early page tables,
  instead of pulling that code into the 'early' set

[0] https://lkml.kernel.org/r/20240122090851.851120-7-ardb%2Bgit%40google.com
[1] https://lore.kernel.org/all/20240111223650.3502633-1-kevinloughlin@google.com/T/#u
[2] https://lkml.kernel.org/r/20240125112818.2016733-19-ardb%2Bgit%40google.com

Cc: Kevin Loughlin <kevinloughlin@google.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Dionna Glaze <dionnaglaze@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Justin Stitt <justinstitt@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: llvm@lists.linux.dev

Ard Biesheuvel (19):
  efi/libstub: Add generic support for parsing mem_encrypt=
  x86/boot: Move mem_encrypt= parsing to the decompressor
  x86/startup_64: Drop long return to initial_code pointer
  x86/startup_64: Simplify calculation of initial page table address
  x86/startup_64: Simplify CR4 handling in startup code
  x86/startup_64: Drop global variables keeping track of LA57 state
  x86/startup_64: Simplify virtual switch on primary boot
  x86/head64: Replace pointer fixups with PIE codegen
  x86/head64: Simplify GDT/IDT initialization code
  asm-generic: Add special .pi.text section for position independent
    code
  x86: Move return_thunk to __pitext section
  x86/head64: Move early startup code into __pitext
  modpost: Warn about calls from __pitext into other text sections
  x86/coco: Make cc_set_mask() static inline
  x86/sev: Make all code reachable from 1:1 mapping __pitext
  x86/sev: Avoid WARN() in early code
  x86/sev: Use PIC codegen for early SEV startup code
  x86/sev: Drop inline asm LEA instructions for RIP-relative references
  x86/startup_64: Don't bother setting up GS before the kernel is mapped

 arch/x86/Makefile                              |   8 +
 arch/x86/boot/compressed/Makefile              |   2 +-
 arch/x86/boot/compressed/misc.c                |  22 +++
 arch/x86/boot/compressed/pgtable_64.c          |   2 -
 arch/x86/boot/compressed/sev.c                 |   6 +
 arch/x86/coco/core.c                           |   7 +-
 arch/x86/include/asm/coco.h                    |   8 +-
 arch/x86/include/asm/desc.h                    |   3 +-
 arch/x86/include/asm/init.h                    |   2 -
 arch/x86/include/asm/mem_encrypt.h             |   8 +-
 arch/x86/include/asm/pgtable_64.h              |  12 +-
 arch/x86/include/asm/pgtable_64_types.h        |  15 +-
 arch/x86/include/asm/setup.h                   |   4 +-
 arch/x86/include/asm/sev.h                     |   6 +-
 arch/x86/include/uapi/asm/bootparam.h          |   2 +
 arch/x86/kernel/Makefile                       |   7 +
 arch/x86/kernel/cpu/common.c                   |   2 -
 arch/x86/kernel/head64.c                       | 206 +++++++-------------
 arch/x86/kernel/head_64.S                      | 156 +++++----------
 arch/x86/kernel/sev-shared.c                   |  54 +++--
 arch/x86/kernel/sev.c                          |  27 ++-
 arch/x86/kernel/vmlinux.lds.S                  |   3 +-
 arch/x86/lib/Makefile                          |  13 --
 arch/x86/lib/memcpy_64.S                       |   3 +-
 arch/x86/lib/memset_64.S                       |   3 +-
 arch/x86/lib/retpoline.S                       |   2 +-
 arch/x86/mm/Makefile                           |   2 +-
 arch/x86/mm/kasan_init_64.c                    |   3 -
 arch/x86/mm/mem_encrypt_boot.S                 |   3 +-
 arch/x86/mm/mem_encrypt_identity.c             |  98 +++-------
 drivers/firmware/efi/libstub/efi-stub-helper.c |   8 +
 drivers/firmware/efi/libstub/efistub.h         |   2 +-
 drivers/firmware/efi/libstub/x86-stub.c        |   6 +
 include/asm-generic/vmlinux.lds.h              |   3 +
 include/linux/init.h                           |  12 ++
 scripts/mod/modpost.c                          |  11 +-
 tools/objtool/check.c                          |  26 +--
 37 files changed, 319 insertions(+), 438 deletions(-)


base-commit: aa8eff72842021f52600392b245fb82d113afa8a
-- 
2.43.0.429.g432eaa2c6b-goog


