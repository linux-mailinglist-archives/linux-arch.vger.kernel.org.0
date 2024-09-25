Return-Path: <linux-arch+bounces-7398-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7289E986239
	for <lists+linux-arch@lfdr.de>; Wed, 25 Sep 2024 17:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7ED51F28B23
	for <lists+linux-arch@lfdr.de>; Wed, 25 Sep 2024 15:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFAE4965B;
	Wed, 25 Sep 2024 15:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HBWrXLE+"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799C53B295
	for <linux-arch@vger.kernel.org>; Wed, 25 Sep 2024 15:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727276513; cv=none; b=LQ/euDO4cRrkLip92KXervoLTlUpJwrthnbzWf2gL5f8oV1OPkXSCc6/QJShDnoQ1jhmRRttbyQ0A/TrcrQL9l9JMv4rt+/6cg8q+OghZqfBsLampC5HK/vjpZqE7PkfavjLUNv49PEyFbWNS8QG7kzAYUR+9pPxChbfCLEjXJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727276513; c=relaxed/simple;
	bh=GyK5LYy4hT2Mza2Xl9rezrZ2kXob9EVtau0/Aicjkyk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=eXZtcrZHMQKKJ9CPZ5+CzI5DScUZ1R1q7G6QwrKeoG85AkjSdYpz+7rQlTmriIU/HnPuFSTciSA7OJIA0IMgXJayHetUps5pS7OtHW13uLGVjoWkxvlpWbUQ7kwsMv67DIEzqZSJljS0wLykO8yXQjiDqF2yO6fkUoGdfO63r90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HBWrXLE+; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e24a0daf98eso1853215276.1
        for <linux-arch@vger.kernel.org>; Wed, 25 Sep 2024 08:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727276509; x=1727881309; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6z7k17OsGZKMVFB80yPIaoy18RpZ7zGlccSFIk096uA=;
        b=HBWrXLE+RxrFNPpG2yxPXm0QKtrpPQwtZYwyUTWmsAgybBjgE+ZkiheCe+wEK2qhIC
         d/OwUrHaR7BnsDQ13NmYMQ/T/Wxi2ngNY5h8VPXXWaJHhYbetQqkeu8aq1hjPTj5c9PW
         F12qtXfhVCgQvbKpGGLwXP3lVR+FS4RxBTRCl4juHGkPeUJSzdGXWNveVg8EvVuJ4N0b
         n4j2jj9BHczdrpbNCNb7o8/n3xibw3CH9qigfds7ZpiBeSfkGorPGe2XFwqB9V8/L7xS
         WpgVQZn1xoY3UU0VM6Rs1+gNKrmFDLnP0OE/Gjp0Wlkz6a4YqIRuRZD34s3EH2vnC4ok
         KCnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727276509; x=1727881309;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6z7k17OsGZKMVFB80yPIaoy18RpZ7zGlccSFIk096uA=;
        b=HhmVRLpB9f5276TF8aJXloR/H1LE5eC/s296mq6HDx7g58HM/i33xbV1v8qQJ9qE44
         kerM+TyINeixdm0m8XGhi66aBg1swaZlkowWzr0yWnTyEbmZjD6Xm3pv6RuHkUESNpQV
         aj5OoTUtyzIjXLZLXqOhUKGJxqVkU24qdcGl+2Jsp72Lku5eQd9cv5czlNa64s4YN8Ma
         /9WkfwA9WyfEXNRJ/EsF/hwlmbrUlDiq72X8vOapV+1usAZHIxueFkvxGXR2y72T2E3E
         f/XZ0U6oS+0JgpWxEuEq0LNFMA/vKusdtjsxi4M5f0pStcWkHbwZVFV8osDIxb6QI0z+
         kbNw==
X-Forwarded-Encrypted: i=1; AJvYcCVMD6mYHmhi7sBCCyknt8ilGh3H7QCQJTo7V9HeUzW1UPZfYt18y71HOYvXMwMY95qkOxcLan+9Kf0G@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5s/slB8oYaq3yEWQN9QqtFie8rnufysteIjl6krEd7BAKWlo9
	e1tHbgGoChxNgZA6rG4bLF7GCtQSr7fuedG3besAqs61efnY9PfjcDjCoSrBgcY3+44y0g==
X-Google-Smtp-Source: AGHT+IGRJUFrs1DoPRrR5c+MJEZ6tG0DheITTu8FPFLiXZOk+NGplm3eXqMcHGaqBYVKwyJOtED+Rs3U
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a25:d695:0:b0:e24:9ec4:7297 with SMTP id
 3f1490d57ef6-e24da58666emr14424276.11.1727276509248; Wed, 25 Sep 2024
 08:01:49 -0700 (PDT)
Date: Wed, 25 Sep 2024 17:01:00 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=9188; i=ardb@kernel.org;
 h=from:subject; bh=vMX7ogGZLEc8VPljv97RuDVJFn/JAzUBXeH6mBcebRA=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIe2L6pr9k37ZPn8uK8IvcW92T9PETT9Xrz4h19DckCOrf
 uS7om11RykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZiIeBIjQ8cjt/vNFnlpcQoK
 wSbqqaeUo8XjLsnZ2/zNu6XorPO9luG/9+LkrdV5d/tnvdg2VzHvwaxNexRvHney2v1TP02udn4 IIwA=
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Message-ID: <20240925150059.3955569-30-ardb+git@google.com>
Subject: [RFC PATCH 00/28] x86: Rely on toolchain for relocatable code
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Uros Bizjak <ubizjak@gmail.com>, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Juergen Gross <jgross@suse.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Masahiro Yamada <masahiroy@kernel.org>, Kees Cook <kees@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Keith Packard <keithp@keithp.com>, 
	Justin Stitt <justinstitt@google.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-doc@vger.kernel.org, 
	linux-pm@vger.kernel.org, kvm@vger.kernel.org, xen-devel@lists.xenproject.org, 
	linux-efi@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-sparse@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The x86_64 port has a number of historical quirks that result in a
reliance on toolchain features that are either poorly specified or
basically implementation details of the toolchain:

- the 'kernel' C model implemented by the compiler is intended for
  position dependent code residing in the 'negative' 2 GiB of the
  virtual address space, but is used to create a position independent
  executable (for virtual KASLR);

- the 'kernel' C model has other properties that are not written down
  anywhere, and may therefore deviate between compilers and versions,
  which now includes the Rust compilers too (e.g., use %gs not %fs for
  per-CPU references); 

- the relocation format used to perform the PIE relocation at boot is
  complicated and non-standard, as it deals with 3 types of
  displacements, including 32-bit negative displacements for
  RIP-relative per-CPU references that are not subject to relocation
  fixups (as they are places in a separate, disjoint address space);

- the relocation table is generated from static relocation metadata
  taken from the ELF input objects into the linker, and these describe
  the input not the output - relaxations or other linker tweaks may
  result in a mismatch between the two, and GNU ld and LLD display
  different behavior here;

- this disjoint per-CPU address space requires elaborate hacks in the
  linker script and the startup code;

- some of the startup code executes from a 1:1 mapping of memory, where
  RIP-relative references are mandatory, whereas RIP-relative per-CPU
  variable references can only work correctly from the kernel virtual
  mapping (as they need to wrap around from the negative 2 GiB space
  into the 0x0 based per-CPU region);

The reason for this odd situation wrt per-CPU variable addressing is the
fact that we rely on the user-space TLS arrangement for per-task stack
cookies, and this was implemented using a fixed offset of 40 bytes from
%GS. If we bump the minimum GCC version to 8.1, we can switch to symbol
based stack cookie references, allowing the same arrangement to be
adopted as on other architectures, i.e., where the CPU register carries
the per-CPU offset, and UP or boot-time per-CPU references point into
the per-CPU load area directly (using an offset of 0x0).

With that out of the way, we can untangle this whole thing, and replace
the bespoke tooling and relocation formats with ordinary, linker
generated relocation tables, using the RELR format that reduces the
memory footprint of the relocation table by 20x. The compilers can
efficiently generate position independent code these days, without
unnecessary indirections via the Global Object Table (GOT) except for a
handful of special cases (see the KVM patch for an example where a
GOT-based indirection is the best choice for pushing the absolute
address of a symbol onto the stack in a position independent manner when
there are no free GPRs)

It also brings us much closer to the ordinary PIE relocation model used
for most of user space, which is therefore much better supported and
less likely to create problems as we increase the range of compilers and
linkers that need to be supported.

Tested on GCC 8 - 14 and Clang 15 - 17, using EFI and bare metal boot
using a variety of entry points (decompressor, EFI stub, XenPV, PVH)
 
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Uros Bizjak <ubizjak@gmail.com>
Cc: Dennis Zhou <dennis@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Kees Cook <kees@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Keith Packard <keithp@keithp.com>
Cc: Justin Stitt <justinstitt@google.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Kan Liang  <kan.liang@linux.intel.com>
Cc: linux-doc@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: kvm@vger.kernel.org
Cc: xen-devel@lists.xenproject.org
Cc: linux-efi@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: linux-sparse@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org
Cc: llvm@lists.linux.dev

Ard Biesheuvel (28):
  x86/pvh: Call C code via the kernel virtual mapping
  Documentation: Bump minimum GCC version to 8.1
  x86/tools: Use mmap() to simplify relocs host tool
  x86/boot: Permit GOTPCREL relocations for x86_64 builds
  x86: Define the stack protector guard symbol explicitly
  x86/percpu: Get rid of absolute per-CPU variable placement
  scripts/kallsyms: Avoid 0x0 as the relative base
  scripts/kallsyms: Remove support for absolute per-CPU variables
  x86/tools: Remove special relocation handling for per-CPU variables
  x86/xen: Avoid relocatable quantities in Xen ELF notes
  x86/pvh: Avoid absolute symbol references in .head.text
  x86/pm-trace: Use RIP-relative accesses for .tracedata
  x86/kvm: Use RIP-relative addressing
  x86/rethook: Use RIP-relative reference for return address
  x86/sync_core: Use RIP-relative addressing
  x86/entry_64: Use RIP-relative addressing
  x86/hibernate: Prefer RIP-relative accesses
  x86/boot/64: Determine VA/PA offset before entering C code
  x86/boot/64: Avoid intentional absolute symbol references in
    .head.text
  x64/acpi: Use PIC-compatible references in wakeup_64.S
  x86/head: Use PIC-compatible symbol references in startup code
  asm-generic: Treat PIC .data.rel.ro sections as .rodata
  tools/objtool: Mark generated sections as writable
  tools/objtool: Treat indirect ftrace calls as direct calls
  x86: Use PIE codegen for the core kernel
  x86/boot: Implement support for ELF RELA/RELR relocations
  x86/kernel: Switch to PIE linking for the core kernel
  x86/tools: Drop x86_64 support from 'relocs' tool

 Documentation/admin-guide/README.rst    |   2 +-
 Documentation/arch/x86/zero-page.rst    |   3 +-
 Documentation/process/changes.rst       |   2 +-
 arch/x86/Kconfig                        |   3 +-
 arch/x86/Makefile                       |  22 +-
 arch/x86/boot/Makefile                  |   1 +
 arch/x86/boot/compressed/Makefile       |   2 +-
 arch/x86/boot/compressed/misc.c         |  16 +-
 arch/x86/entry/calling.h                |   9 +-
 arch/x86/entry/entry_64.S               |  12 +-
 arch/x86/entry/vdso/Makefile            |   1 +
 arch/x86/include/asm/desc.h             |   1 -
 arch/x86/include/asm/init.h             |   2 +-
 arch/x86/include/asm/percpu.h           |  22 -
 arch/x86/include/asm/pm-trace.h         |   4 +-
 arch/x86/include/asm/processor.h        |  14 +-
 arch/x86/include/asm/setup.h            |   3 +-
 arch/x86/include/asm/stackprotector.h   |   4 -
 arch/x86/include/asm/sync_core.h        |   3 +-
 arch/x86/include/uapi/asm/bootparam.h   |   2 +-
 arch/x86/kernel/acpi/wakeup_64.S        |  11 +-
 arch/x86/kernel/head64.c                |  76 +++-
 arch/x86/kernel/head_64.S               |  40 +-
 arch/x86/kernel/irq_64.c                |   1 -
 arch/x86/kernel/kvm.c                   |   8 +-
 arch/x86/kernel/relocate_kernel_64.S    |   6 +-
 arch/x86/kernel/rethook.c               |   3 +-
 arch/x86/kernel/setup_percpu.c          |   9 +-
 arch/x86/kernel/vmlinux.lds.S           |  75 ++--
 arch/x86/platform/pvh/head.S            |  57 ++-
 arch/x86/power/hibernate_asm_64.S       |   4 +-
 arch/x86/realmode/rm/Makefile           |   1 +
 arch/x86/tools/Makefile                 |   2 +-
 arch/x86/tools/relocs.c                 | 425 +++-----------------
 arch/x86/tools/relocs.h                 |  11 +-
 arch/x86/tools/relocs_64.c              |  18 -
 arch/x86/tools/relocs_common.c          |  11 +-
 arch/x86/xen/xen-head.S                 |  16 +-
 drivers/base/power/trace.c              |   6 +-
 drivers/firmware/efi/libstub/x86-stub.c |   2 +
 include/asm-generic/vmlinux.lds.h       |  10 +-
 include/linux/compiler.h                |   2 +-
 init/Kconfig                            |   5 -
 kernel/kallsyms.c                       |  12 +-
 scripts/kallsyms.c                      |  53 +--
 scripts/link-vmlinux.sh                 |   4 -
 tools/objtool/check.c                   |  43 +-
 tools/objtool/elf.c                     |   2 +-
 tools/objtool/include/objtool/special.h |   2 +-
 tools/perf/util/annotate.c              |   4 +-
 50 files changed, 380 insertions(+), 667 deletions(-)
 delete mode 100644 arch/x86/tools/relocs_64.c

-- 
2.46.0.792.g87dc391469-goog


