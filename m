Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 726764A59FA
	for <lists+linux-arch@lfdr.de>; Tue,  1 Feb 2022 11:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236597AbiBAK1H (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Feb 2022 05:27:07 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:54086 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236655AbiBAK1B (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Feb 2022 05:27:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 735F5614C6;
        Tue,  1 Feb 2022 10:27:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48603C340FA;
        Tue,  1 Feb 2022 10:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643711209;
        bh=YpNRNg5/ihQ4PP48BMlGgoh7uAQDP7LsHHGYiX5QI0o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=g7mEjtgirOS2Zivm7Bm9R3ebuvol2S+TsbQ41/4gKPs5b7l3SaQRLA7OfWhuBfh+r
         ZsMv6Gx0LVyeoYf6Xw9b8FXf+4zN71F68WAL3NJIoc5v+3ZO3cePjYb5mxR/sqNKvw
         5W/tmf2gXB6rLPPozNKA/T7oMkoB9a2+e0N7AXblHqLEKhrp2fAjL+hpdg5FJfbGjx
         1MvghQ0dvPxKarNL6/Hk3zSGP0X647C+hEoYSiHMeJYECu/KJP1YKZ6gNCfsHUlquW
         KjB21XgD60/n2rSLeJDQgjhx27CSgJIRFvMa1IIHQqKmprAgwQIaJuOjURhfycG0ri
         OLVKaiaLRszLQ==
Received: by mail-vk1-f178.google.com with SMTP id z15so10093733vkp.13;
        Tue, 01 Feb 2022 02:26:49 -0800 (PST)
X-Gm-Message-State: AOAM533VsQzJLklKhtjvZgX7sUlDW/hAPltX5MLOGpSc7on7/lgst8j+
        FtPFmiu5GAHMQtoh9xyRexxYlfai8VEjxVCzoIE=
X-Google-Smtp-Source: ABdhPJwLhW//fixKVbaTjokrn8h3L9Q3pUBjKK03Q8LXfMtVREM4+ggbuel+/v83NuiYDPmVXHHyZJPscKX3YUkbjfo=
X-Received: by 2002:a05:6122:91d:: with SMTP id j29mr9618418vka.8.1643711208229;
 Tue, 01 Feb 2022 02:26:48 -0800 (PST)
MIME-Version: 1.0
References: <20220129121728.1079364-1-guoren@kernel.org> <20220129121728.1079364-17-guoren@kernel.org>
 <YffVZZg9GNcjgVdm@infradead.org> <CAJF2gTRXDotO1L1FMojQs6msrqvCzA782Pux8rg3AfZgA=y0ew@mail.gmail.com>
 <20220201074457.GC29119@lst.de> <CAJF2gTTc=zwD__zXwYbO8vmup5evWJtzyiAF9Pm-UVHLJRc5hQ@mail.gmail.com>
 <CAK8P3a2C7nDGQvopYzi1fe_LWyosp8t9dcBsduYK5k_s_OrCaA@mail.gmail.com>
In-Reply-To: <CAK8P3a2C7nDGQvopYzi1fe_LWyosp8t9dcBsduYK5k_s_OrCaA@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 1 Feb 2022 18:26:37 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTgTzvGfa3nGzVo4C=fe+ZCGBWp=VhTMRt1vF1O1bnS5g@mail.gmail.com>
Message-ID: <CAJF2gTTgTzvGfa3nGzVo4C=fe+ZCGBWp=VhTMRt1vF1O1bnS5g@mail.gmail.com>
Subject: Re: [PATCH V4 16/17] riscv: compat: Add COMPAT Kbuild skeletal support
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup@brainfault.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        liush <liush@allwinnertech.com>, Wei Fu <wefu@redhat.com>,
        Drew Fustini <drew@beagleboard.org>,
        Wang Junqiang <wangjunqiang@iscas.ac.cn>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Arnd & Christoph,

The UXL field controls the value of XLEN for U-mode, termed UXLEN,
which may differ from the
value of XLEN for S-mode, termed SXLEN. The encoding of UXL is the
same as that of the MXL
field of misa, shown in Table 3.1.

Here is the patch. (We needn't exception helper, because we are in
S-mode and UXL wouldn't affect.)

 arch/riscv/include/asm/elf.h       |  5 ++++-
 arch/riscv/include/asm/processor.h |  1 +
 arch/riscv/kernel/process.c        | 22 ++++++++++++++++++++++
 arch/riscv/kernel/setup.c          |  5 +++++
 4 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/elf.h b/arch/riscv/include/asm/elf.h
index 37f1cbdaa242..6baa49c4fba1 100644
--- a/arch/riscv/include/asm/elf.h
+++ b/arch/riscv/include/asm/elf.h
@@ -35,7 +35,10 @@
  */
 #define elf_check_arch(x) ((x)->e_machine == EM_RISCV)

-#define compat_elf_check_arch(x) ((x)->e_machine == EM_RISCV)
+#ifdef CONFIG_COMPAT
+#define compat_elf_check_arch compat_elf_check_arch
+extern bool compat_elf_check_arch(Elf32_Ehdr *hdr);
+#endif

 #define CORE_DUMP_USE_REGSET
 #define ELF_EXEC_PAGESIZE (PAGE_SIZE)
diff --git a/arch/riscv/include/asm/processor.h
b/arch/riscv/include/asm/processor.h
index 9544c138d9ce..8b288ac0d704 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -64,6 +64,7 @@ extern void start_thread(struct pt_regs *regs,
 #ifdef CONFIG_COMPAT
 extern void compat_start_thread(struct pt_regs *regs,
  unsigned long pc, unsigned long sp);
+extern void compat_mode_detect(void);

 #define DEFAULT_MAP_WINDOW_64 TASK_SIZE_64
 #else
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 9ebf9a95e5ea..496d09c5d384 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -101,6 +101,28 @@ void start_thread(struct pt_regs *regs, unsigned long pc,
 }

 #ifdef CONFIG_COMPAT
+static bool compat_mode_support __read_mostly = false;
+
+bool compat_elf_check_arch(Elf32_Ehdr *hdr)
+{
+ if (compat_mode_support && (hdr->e_machine == EM_RISCV))
+ return true;
+
+ return false;
+}
+
+void compat_mode_detect(void)
+{
+ unsigned long tmp = csr_read(CSR_STATUS);
+ csr_write(CSR_STATUS, (tmp & ~SR_UXL) | SR_UXL_32);
+
+ if ((csr_read(CSR_STATUS) & SR_UXL) != SR_UXL_32) {
+ csr_write(CSR_STATUS, tmp);
+ return;
+ }
+
+ csr_write(CSR_STATUS, tmp);
+ compat_mode_support = true;
+
+ pr_info("riscv: compat: 32bit U-mode applications support\n");
+}
+
 void compat_start_thread(struct pt_regs *regs, unsigned long pc,
  unsigned long sp)
 {
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index b42bfdc67482..be131219d549 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -12,6 +12,7 @@
 #include <linux/mm.h>
 #include <linux/memblock.h>
 #include <linux/sched.h>
+#include <linux/compat.h>
 #include <linux/console.h>
 #include <linux/screen_info.h>
 #include <linux/of_fdt.h>
@@ -294,6 +295,10 @@ void __init setup_arch(char **cmdline_p)
  setup_smp();
 #endif

+#ifdef CONFIG_COMPAT
+ compat_mode_detect();
+#endif
+
  riscv_fill_hwcap();
 }
On Tue, Feb 1, 2022 at 5:36 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Feb 1, 2022 at 10:13 AM Guo Ren <guoren@kernel.org> wrote:
> > On Tue, Feb 1, 2022 at 3:45 PM Christoph Hellwig <hch@lst.de> wrote:
> > > On Mon, Jan 31, 2022 at 09:50:58PM +0800, Guo Ren wrote:
> > > > On Mon, Jan 31, 2022 at 8:26 PM Christoph Hellwig <hch@infradead.org> wrote:
> > > > >
> > > > > Given that most rv64 implementations can't run in rv32 mode, what is the
> > > > > failure mode if someone tries it with the compat mode enabled?
> > > > A static linked simple hello_world could still run on a non-compat
> > > > support hardware. But most rv32 apps would meet different userspace
> > > > segment faults.
> > > >
> > > > Current code would let the machine try the rv32 apps without detecting
> > > > whether hw support or not.
> > >
> > > Hmm, we probably want some kind of check for not even offer running
> > > rv32 binaries.  I guess trying to write UXL some time during early
> > > boot and catching the resulting exception would be the way to go?
> >
> > Emm... I think it's unnecessary. Free rv32 app running won't cause
> > system problem, just as a wrong elf running. They are U-mode
> > privileged.
>
> While it's not a security issue, I think it would be helpful to get a
> user-readable error message and a machine-readable /proc/cpuinfo
> flag to see if a particular system can run rv32 binaries rather than
> relying on SIGILL to kill a process.
--
2.25.1


>
>         Arnd



--
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
