Return-Path: <linux-arch+bounces-2560-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 467B785D715
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 12:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 692211C22804
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 11:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC3944C77;
	Wed, 21 Feb 2024 11:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oISLHJK7"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED88B45013
	for <linux-arch@vger.kernel.org>; Wed, 21 Feb 2024 11:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708515336; cv=none; b=Ovk3SS4U4mrXhc1sdO21ipksnELePfLJT5G1NrpUQNTx2LhXunejPwIH8CEnAXie2/w6+TNnWWr9wFMfFtU5KxMzwOb5WmzKxxCr3uGPkdSPABSHXipf2jQuizhsDkue6TCPEV3sIJh0BWSrfi4GyawafL5yyWFC/gDeVO5Hrc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708515336; c=relaxed/simple;
	bh=88ZOlOhZvJ8GHKF/7PJlwKBiIS2h9j1NMA8yqREFlVo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=MvY8GWRj4TDMsvaYCxW3FYKVo6TqkzPWRMM0MYhooEH6JFLpwkaPeXwKA+7LjZX8Td0vzxlLAX6oqdwbGswxes8SkPMegXu09B6wg5LVDJFP+e6ahcnHDlPr80jzJm1QCW//TxhunDr4g6hpjb48sFXijEiPvWxGV9/QPrU1vEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oISLHJK7; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-608575317f8so35417337b3.3
        for <linux-arch@vger.kernel.org>; Wed, 21 Feb 2024 03:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708515334; x=1709120134; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O65tG5WqUZlQTpaj7ICgbjyaYaKndbgYeUwNbCW39Ew=;
        b=oISLHJK7XmJcRUqHzmxAfqXb2gBOxe5PfbdKeYtjl2jbjxDibnFeRck5OF4UAZZw91
         sd9ykPDCMJYp4phdO0OmSPXgZS3AhV7J9ujgVz3Pj/wh08wj9FCq5K/JL0oDCOJYL0pO
         hDah9vcoppnZGUBRpkDg/K82mbUvkZVwsrkP4Z0lY42yprzvYgqXmzP20OxyaI2WqrpN
         Fc75f+hyUf544Dp7OTfMShO6ksbskavLzYmWIKoxxFxK8NP2sRUweVuvQIKeI/PnPR4t
         xSaQGgJoSxdphHk3aDI62ThVsnXE78OwBPi7IYpfcf9PD7k3YWxss+W65FtPJbAEu9XW
         s0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708515334; x=1709120134;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O65tG5WqUZlQTpaj7ICgbjyaYaKndbgYeUwNbCW39Ew=;
        b=eGkTG6U4CdoRgdTt6iKFk9JnfcWBIQRwEeUGzI8DrCr84S5CWSCFUsA9oszxZgYvUq
         tsf7SFeH2qk7lPsL8rQDwRbzlcYPTleUndxwHgnj+oZ1lUWcE5PTezX9B/btTXH8eqtg
         +3rCQTqM0B2ZJBNCTf/fR8Sz+y4N4v1gHCOVd7w9eYUkZZtsLxi7bM3FcgnRAZxPZ19U
         8S9CnxschTZwdITi2gEHyYq+4MnC1OWEZTZNRO7u8lPfn4MwHteuGGayb2M095c/a1jE
         hV1lB1A2dqnlhh81FEQ7OXtTKHjWsC4YlM4bjHJz+CsRaiBFj/N879rmJ+WrTQTHeHmu
         ArBw==
X-Forwarded-Encrypted: i=1; AJvYcCXKPj7ho0dIpKwZ5gcR3A3yHemRMVv62KtfZCaDcX1xsJNUHKMwct/24TWlLWFn52ffjFQ0TkHnv2xEgTZ65DApCIU3LAL1cg3ATw==
X-Gm-Message-State: AOJu0Yz36Z5vavE0fyuNCVXXSsC25a24G4A+G4kiLPdrP6SN6Bz8TUKK
	aLY9ZgKGPWZMvbLdg2YCWxVxfNka6z2Ji7j0aQ9Wso8Y42MmzxG/1ARIo/74xvgByt5EKA==
X-Google-Smtp-Source: AGHT+IEMfw2pnZEsHe4efs/j7IVfeAly51s4E6ewx4uEoOgwc23/oO3UWVwO3KXa6xJDixYGRdRA08+d
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:1001:b0:dcc:79ab:e522 with SMTP id
 w1-20020a056902100100b00dcc79abe522mr731861ybt.11.1708515333920; Wed, 21 Feb
 2024 03:35:33 -0800 (PST)
Date: Wed, 21 Feb 2024 12:35:07 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=5995; i=ardb@kernel.org;
 h=from:subject; bh=jydDC13C92VQ0hUqNP3f7HSxwdEWVwkXnRzVHgSpuGg=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIfXq/VdzPF026M1vVfik6bba+mnpbteQQ7clurXeV98+K
 LMhNvh7RykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZjIQzuGv6KX/5/IU9rWZfJk
 H09m0oMgZ6XYOX3n/0Y7LsysuHiu2IuRYVLHZpFHW/a/42NSfd6YWt03xdLO4JjK8R8pH31LhPn fcQMA
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221113506.2565718-18-ardb+git@google.com>
Subject: [PATCH v5 00/16] x86: Confine early 1:1 mapped startup code
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

This is a follow-up to [0] which implemented rigorous build time checks
to ensure that any code that is executed during early startup supports
running from the initial 1:1 mapping of memory, which is how the kernel
is entered from the decompressor or the EFI firmware.

Using PIC codegen and introducing new magic sections into generic code
would create a maintenance burden, and more experimentation is needed
there.  One issue with PIC codegen is that it still permits the compiler
to make assumptions about the runtime address of global objects (modulo
runtime relocation), which is incompatible with how the kernel is
entered, i.e., running a fully linked and relocated executable from the
wrong runtime address.

The RIP_REL_REF() macro that was introduced recently [1] is actually
more appropriate for this use case, as it hides the access from the
compiler entirely, and so the compiler can never predict its result.

To make incremental progress on this, this v5 drops the special
instrumentation for .pi.text and PIC codegen, but retains all the
cleanup work on the startup code to make it more maintainable and more
obviously correct.

In particular, this involves:
- getting rid of early accesses to global objects, either by moving them
  to the stack, deferring the access until later, or dropping the
  globals entirely;
- moving all code that runs early via the 1:1 mapping into .head.text,
  and moving code that does not out of it, so that build time checks can
  be added later to ensure that no inadvertent absolute references were
  emitted into code that does not tolerate them;
- removing fixup_pointer() and occurrences of __pa_symbol(), which rely
  on the compiler emitting absolute references, and this is not
  guaranteed. (Without -fpic, the compiler might still use RIP-relative
  references in some cases)

Changes since v4 [2]:
- incorporate Boris's tweaked version of patch #1
- split __startup64() changes into multiple patches, and align more
  closely with the original logic
- fix build for CONFIG_X86_5LEVEL=n
- add comment to clarify that CR4.PSE is always set deliberately
- add separate SME startup change to remove SME/SVE related calls from
  the non-SME/SVE boot path (this can be backported more easily further
  back than to where we need the changes for SVE guest boot)

Changes since v3:
- dropped half of the patches and added a couple of new ones
- applied feedback from Boris to patches that were retained, mostly
  related to some minor oversights on my part, and to some style issues

[0] https://lkml.kernel.org/r/20240129180502.4069817-21-ardb%2Bgit%40google.com
[1] https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=x86/sev&id=1c811d403afd73f0
[2] https://lkml.kernel.org/r/20240213124143.1484862-13-ardb%2Bgit%40google.com

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

Ard Biesheuvel (16):
  x86/startup_64: Simplify global variable accesses in GDT/IDT
    programming
  x86/startup_64: Use RIP_REL_REF() to assign phys_base
  x86/startup_64: Use RIP_REL_REF() to access early_dynamic_pgts[]
  x86/startup_64: Use RIP_REL_REF() to access __supported_pte_mask
  x86/startup_64: Use RIP_REL_REF() to access early page tables
  x86/startup_64: Use RIP_REL_REF() to access early_top_pgt[]
  x86/startup_64: Simplify CR4 handling in startup code
  x86/startup_64: Defer assignment of 5-level paging global variables
  x86/startup_64: Simplify calculation of initial page table address
  x86/startup_64: Simplify virtual switch on primary boot
  x86/sme: Avoid SME/SVE related checks on non-SME/SVE platforms
  efi/libstub: Add generic support for parsing mem_encrypt=
  x86/boot: Move mem_encrypt= parsing to the decompressor
  x86/sme: Move early SME kernel encryption handling into .head.text
  x86/sev: Move early startup code into .head.text section
  x86/startup_64: Drop global variables keeping track of LA57 state

 arch/x86/boot/compressed/misc.c                |  15 ++
 arch/x86/boot/compressed/misc.h                |   4 -
 arch/x86/boot/compressed/pgtable_64.c          |  12 --
 arch/x86/boot/compressed/sev.c                 |   3 +
 arch/x86/boot/compressed/vmlinux.lds.S         |   1 +
 arch/x86/include/asm/mem_encrypt.h             |   8 +-
 arch/x86/include/asm/pgtable_64_types.h        |  43 ++---
 arch/x86/include/asm/setup.h                   |   2 +-
 arch/x86/include/asm/sev.h                     |  10 +-
 arch/x86/include/uapi/asm/bootparam.h          |   1 +
 arch/x86/kernel/cpu/common.c                   |   2 -
 arch/x86/kernel/head64.c                       | 195 ++++++--------------
 arch/x86/kernel/head_64.S                      |  95 ++++------
 arch/x86/kernel/sev-shared.c                   |  23 +--
 arch/x86/kernel/sev.c                          |  14 +-
 arch/x86/lib/Makefile                          |  13 --
 arch/x86/mm/kasan_init_64.c                    |   3 -
 arch/x86/mm/mem_encrypt_identity.c             |  89 +++------
 drivers/firmware/efi/libstub/efi-stub-helper.c |   8 +
 drivers/firmware/efi/libstub/efistub.h         |   2 +-
 drivers/firmware/efi/libstub/x86-stub.c        |   3 +
 21 files changed, 203 insertions(+), 343 deletions(-)


base-commit: ee8ff8768735edc3e013837c4416f819543ddc17
-- 
2.44.0.rc0.258.g7320e95886-goog


