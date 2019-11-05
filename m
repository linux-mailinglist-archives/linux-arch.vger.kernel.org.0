Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F892EF8B8
	for <lists+linux-arch@lfdr.de>; Tue,  5 Nov 2019 10:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388133AbfKEJ2L (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 Nov 2019 04:28:11 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40625 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387949AbfKEJ2K (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 Nov 2019 04:28:10 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iRv7W-0007IM-FB; Tue, 05 Nov 2019 10:27:26 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id F1B101C0178;
        Tue,  5 Nov 2019 10:27:25 +0100 (CET)
Date:   Tue, 05 Nov 2019 09:27:25 -0000
From:   "tip-bot2 for Kees Cook" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/build] x86/vmlinux: Use INT3 instead of NOP for linker fill bytes
Cc:     Kees Cook <keescook@chromium.org>, Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        Michal Simek <monstr@monstr.eu>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Ross Zwisler <zwisler@chromium.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Will Deacon <will@kernel.org>, "x86-ml" <x86@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191029211351.13243-30-keescook@chromium.org>
References: <20191029211351.13243-30-keescook@chromium.org>
MIME-Version: 1.0
Message-ID: <157294604562.29376.16128940015704175473.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The following commit has been merged into the x86/build branch of tip:

Commit-ID:     7705dc8557973d8ad8f10840f61d8ec805695e9e
Gitweb:        https://git.kernel.org/tip/7705dc8557973d8ad8f10840f61d8ec805695e9e
Author:        Kees Cook <keescook@chromium.org>
AuthorDate:    Tue, 29 Oct 2019 14:13:51 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 04 Nov 2019 19:10:08 +01:00

x86/vmlinux: Use INT3 instead of NOP for linker fill bytes

Instead of using 0x90 (NOP) to fill bytes between functions, which makes
it easier to sloppily target functions in function pointer overwrite
attacks, fill with 0xCC (INT3) to force a trap. Also drop the space
between "=" and the value to better match the binutils documentation

  https://sourceware.org/binutils/docs/ld/Output-Section-Fill.html#Output-Section-Fill

Example "objdump -d" before:

  ...
  ffffffff810001e0 <start_cpu0>:
  ffffffff810001e0:       48 8b 25 e1 b1 51 01    mov 0x151b1e1(%rip),%rsp        # ffffffff8251b3c8 <initial_stack>
  ffffffff810001e7:       e9 d5 fe ff ff          jmpq   ffffffff810000c1 <secondary_startup_64+0x91>
  ffffffff810001ec:       90                      nop
  ffffffff810001ed:       90                      nop
  ffffffff810001ee:       90                      nop
  ffffffff810001ef:       90                      nop

  ffffffff810001f0 <__startup_64>:
  ...

After:

  ...
  ffffffff810001e0 <start_cpu0>:
  ffffffff810001e0:       48 8b 25 41 79 53 01    mov 0x1537941(%rip),%rsp        # ffffffff82537b28 <initial_stack>
  ffffffff810001e7:       e9 d5 fe ff ff          jmpq   ffffffff810000c1 <secondary_startup_64+0x91>
  ffffffff810001ec:       cc                      int3
  ffffffff810001ed:       cc                      int3
  ffffffff810001ee:       cc                      int3
  ffffffff810001ef:       cc                      int3

  ffffffff810001f0 <__startup_64>:
  ...

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: linux-alpha@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-c6x-dev@linux-c6x.org
Cc: linux-ia64@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-s390@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Michal Simek <monstr@monstr.eu>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Ross Zwisler <zwisler@chromium.org>
Cc: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Thomas Lendacky <Thomas.Lendacky@amd.com>
Cc: Will Deacon <will@kernel.org>
Cc: x86-ml <x86@kernel.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Link: https://lkml.kernel.org/r/20191029211351.13243-30-keescook@chromium.org
---
 arch/x86/kernel/vmlinux.lds.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index b06d6e1..3a1a819 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -144,7 +144,7 @@ SECTIONS
 		*(.text.__x86.indirect_thunk)
 		__indirect_thunk_end = .;
 #endif
-	} :text = 0x9090
+	} :text =0xcccc
 
 	/* End of text section, which should occupy whole number of pages */
 	_etext = .;
