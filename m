Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C208B4C4955
	for <lists+linux-arch@lfdr.de>; Fri, 25 Feb 2022 16:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242111AbiBYPnK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 25 Feb 2022 10:43:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242275AbiBYPmz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 25 Feb 2022 10:42:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C2021D081;
        Fri, 25 Feb 2022 07:42:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34DFC61967;
        Fri, 25 Feb 2022 15:42:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E9C3C340F8;
        Fri, 25 Feb 2022 15:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645803741;
        bh=LTpyZW67H6AqS8NEkTYiulq7m69rWSy25aC9ZjGcrfA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KugaL8/34dsoYm1tYvWbo/jnp2V/mihze12aGgHWldgnQcFk7VV5ERWqdLZURe40j
         6RIpMyNWI68JZ/6NbQTjVrkTVgLkzbeO1f5k06U83kTYvDS4fjqNlHstgtjJnF2Jwc
         9wLVZtMQwg/0V5AoxEvVGRrAole6BkzW087caapwAXdhEQ/E7MYSv6pBkfwvpLEQZe
         tKj6lMuGEyxlOg9pwrFRfd7mgvQGb9v3DuOA2TDAwCB3pe34gjxn+XGEbAp8CZvLbE
         Lfv6OMXNBXdaHYu8VaV5J+/JzmPEIdrEEcy/x8M+U5BszRjA9VvbpDWw9i5in0ZFrS
         CdpnQ5GePyMbA==
Received: by mail-vs1-f49.google.com with SMTP id y4so5878988vsd.11;
        Fri, 25 Feb 2022 07:42:21 -0800 (PST)
X-Gm-Message-State: AOAM530UPdWhUcBA/8mpZrhslaO3KXEcJc/EJjcKwi46rVuLkQ4xuZAs
        xNF6gyO33MYGdkYFHqENKHVMfqHKv8AIfAtjpMk=
X-Google-Smtp-Source: ABdhPJzkkZzRIcTVnaKqfYtdNhKQA/tUKntASaj7B1Yk2uWOXdsLiKYE8wFNLhZCqckzP5h22WOoM706CycXuYVo0dw=
X-Received: by 2002:a05:6102:806:b0:31e:2206:f1c with SMTP id
 g6-20020a056102080600b0031e22060f1cmr3498723vsb.59.1645803740502; Fri, 25 Feb
 2022 07:42:20 -0800 (PST)
MIME-Version: 1.0
References: <20220224085410.399351-1-guoren@kernel.org> <20220224085410.399351-17-guoren@kernel.org>
 <CAK8P3a13_VBpTidoF_pUdV5g0MFqpSe17rgw=XUv69CCFCN0_g@mail.gmail.com>
In-Reply-To: <CAK8P3a13_VBpTidoF_pUdV5g0MFqpSe17rgw=XUv69CCFCN0_g@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 25 Feb 2022 23:42:09 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTu5=XwDUwNq=PfnzVRj-jPHH+0cOGhhLr_dFED1H24_g@mail.gmail.com>
Message-ID: <CAJF2gTTu5=XwDUwNq=PfnzVRj-jPHH+0cOGhhLr_dFED1H24_g@mail.gmail.com>
Subject: Re: [PATCH V6 16/20] riscv: compat: vdso: Add rv32 VDSO base code implementation
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup@brainfault.org>,
        gregkh <gregkh@linuxfoundation.org>,
        liush <liush@allwinnertech.com>, Wei Fu <wefu@redhat.com>,
        Drew Fustini <drew@beagleboard.org>,
        Wang Junqiang <wangjunqiang@iscas.ac.cn>,
        Christoph Hellwig <hch@lst.de>,
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
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Arnd & Palmer,

Here is the new modified compat_vdso/Makefile, please have a look,
first. Then I would update it to v7:
===========================================
# SPDX-License-Identifier: GPL-2.0-only
#
# Makefile for compat_vdso
#

# Symbols present in the compat_vdso
compat_vdso-syms  = rt_sigreturn
compat_vdso-syms += getcpu
compat_vdso-syms += flush_icache

ifdef CROSS_COMPILE_COMPAT
        COMPAT_CC := $(CROSS_COMPILE_COMPAT)gcc
        COMPAT_LD := $(CROSS_COMPILE_COMPAT)ld
else
        COMPAT_CC := $(CC)
        COMPAT_LD := $(LD)
endif

COMPAT_CC_FLAGS := -march=rv32g -mabi=ilp32
COMPAT_LD_FLAGS := -melf32lriscv

# Files to link into the compat_vdso
obj-compat_vdso = $(patsubst %, %.o, $(compat_vdso-syms)) note.o

# Build rules
targets := $(obj-compat_vdso) compat_vdso.so compat_vdso.so.dbg compat_vdso.lds
obj-compat_vdso := $(addprefix $(obj)/, $(obj-compat_vdso))

obj-y += compat_vdso.o
CPPFLAGS_compat_vdso.lds += -P -C -U$(ARCH)

# Disable profiling and instrumentation for VDSO code
GCOV_PROFILE := n
KCOV_INSTRUMENT := n
KASAN_SANITIZE := n
UBSAN_SANITIZE := n

# Force dependency
$(obj)/compat_vdso.o: $(obj)/compat_vdso.so

# link rule for the .so file, .lds has to be first
$(obj)/compat_vdso.so.dbg: $(obj)/compat_vdso.lds $(obj-compat_vdso) FORCE
        $(call if_changed,compat_vdsold)
LDFLAGS_compat_vdso.so.dbg = -shared -S -soname=linux-compat_vdso.so.1 \
        --build-id=sha1 --hash-style=both --eh-frame-hdr

$(obj-compat_vdso): %.o: %.S FORCE
        $(call if_changed_dep,compat_vdsoas)

# strip rule for the .so file
$(obj)/%.so: OBJCOPYFLAGS := -S
$(obj)/%.so: $(obj)/%.so.dbg FORCE
        $(call if_changed,objcopy)

# Generate VDSO offsets using helper script
gen-compat_vdsosym := $(srctree)/$(src)/gen_compat_vdso_offsets.sh
quiet_cmd_compat_vdsosym = VDSOSYM $@
        cmd_compat_vdsosym = $(NM) $< | $(gen-compat_vdsosym) |
LC_ALL=C sort > $@

include/generated/compat_vdso-offsets.h: $(obj)/compat_vdso.so.dbg FORCE
        $(call if_changed,compat_vdsosym)

# actual build commands
# The DSO images are built using a special linker script
# Make sure only to export the intended __compat_vdso_xxx symbol offsets.
quiet_cmd_compat_vdsold = VDSOLD  $@
      cmd_compat_vdsold = $(COMPAT_LD) $(ld_flags) $(COMPAT_LD_FLAGS)
-T $(filter-out FORCE,$^) -o $@.tmp && \
                   $(OBJCOPY) $(patsubst %, -G __compat_vdso_%,
$(compat_vdso-syms)) $@.tmp $@ && \
                   rm $@.tmp

# actual build commands
quiet_cmd_compat_vdsoas = VDSOAS $@
      cmd_compat_vdsoas = $(COMPAT_CC) $(a_flags) $(COMPAT_CC_FLAGS) -c -o $@ $<

# install commands for the unstripped file
quiet_cmd_compat_vdso_install = INSTALL $@
      cmd_compat_vdso_install = cp $(obj)/$@.dbg $(MODLIB)/compat_vdso/$@

compat_vdso.so: $(obj)/compat_vdso.so.dbg
        @mkdir -p $(MODLIB)/compat_vdso
        $(call cmd,compat_vdso_install)

compat_vdso_install: compat_vdso.so
===========================================

Here is the make V=1 output:

make -f /home/guoren/source/kernel/riscv-linux/scripts/Makefile.build
obj=arch/riscv/kernel/vdso include/generated/vdso-offsets.h
make -f /home/guoren/source/kernel/riscv-linux/scripts/Makefile.build
obj=arch/riscv/kernel/compat_vdso
include/generated/compat_vdso-offsets.h
  riscv64-unknown-linux-gnu-gcc -E
-Wp,-MMD,arch/riscv/kernel/compat_vdso/.compat_vdso.lds.d  -nostdinc
-I/home/guoren/source/kernel/riscv-linux/arch/riscv/include
-I./arch/riscv/include/generated
-I/home/guoren/source/kernel/riscv-linux/include -I./include
-I/home/guoren/source/kernel/riscv-linux/arch/riscv/include/uapi
-I./arch/riscv/include/generated/uapi
-I/home/guoren/source/kernel/riscv-linux/include/uapi -I./includ
e/generated/uapi -include
/home/guoren/source/kernel/riscv-linux/include/linux/compiler-version.h
-include /home/guoren/source/kernel/riscv-linux/include/linux/kconfig.h
-D__KERNEL__ -fmacro-prefix-map=/home/guoren/source/kernel/riscv-linux/=
   -P -C -Uriscv -I
/home/guoren/source/kernel/riscv-linux/arch/riscv/kernel/compat_vdso
-I ./arch/riscv/kernel/compat_vdso -P -Uriscv -D__ASSEMBLY__
-DLINKER_SCRIPT -o arch/riscv/ke
rnel/compat_vdso/compat_vdso.lds
/home/guoren/source/kernel/riscv-linux/arch/riscv/kernel/compat_vdso/compat_vdso.lds.S
  riscv64-unknown-linux-gnu-gcc
-Wp,-MMD,arch/riscv/kernel/compat_vdso/.rt_sigreturn.o.d  -nostdinc
-I/home/guoren/source/kernel/riscv-linux/arch/riscv/include
-I./arch/riscv/include/generated
-I/home/guoren/source/kernel/riscv-linux/include -I./include
-I/home/guoren/source/kernel/riscv-linux/arch/riscv/include/uapi
-I./arch/riscv/include/generated/uapi
-I/home/guoren/source/kernel/riscv-linux/include/uapi -I./include/ge
nerated/uapi -include
/home/guoren/source/kernel/riscv-linux/include/linux/compiler-version.h
-include /home/guoren/source/kernel/riscv-linux/include/linux/kconfig.h
-D__KERNEL__ -fmacro-prefix-map=/home/guoren/source/kernel/riscv-linux/=
-D__ASSEMBLY__ -fno-PIE -mabi=lp64 -march=rv64imafdc -I
/home/guoren/source/kernel/riscv-linux/arch/riscv/kernel/compat_vdso
-I ./arch/riscv/kernel/compat_vdso    -march=rv32g -mabi=ilp3
2 -c -o arch/riscv/kernel/compat_vdso/rt_sigreturn.o
/home/guoren/source/kernel/riscv-linux/arch/riscv/kernel/compat_vdso/rt_sigreturn.S
  riscv64-unknown-linux-gnu-gcc
-Wp,-MMD,arch/riscv/kernel/compat_vdso/.getcpu.o.d  -nostdinc
-I/home/guoren/source/kernel/riscv-linux/arch/riscv/include
-I./arch/riscv/include/generated
-I/home/guoren/source/kernel/riscv-linux/include -I./include
-I/home/guoren/source/kernel/riscv-linux/arch/riscv/include/uapi
-I./arch/riscv/include/generated/uapi
-I/home/guoren/source/kernel/riscv-linux/include/uapi
-I./include/generate
d/uapi -include
/home/guoren/source/kernel/riscv-linux/include/linux/compiler-version.h
-include /home/guoren/source/kernel/riscv-linux/include/linux/kconfig.h
-D__KERNEL__ -fmacro-prefix-map=/home/guoren/source/kernel/riscv-linux/=
-D__ASSEMBLY__ -fno-PIE -mabi=lp64 -march=rv64imafdc -I
/home/guoren/source/kernel/riscv-linux/arch/riscv/kernel/compat_vdso
-I ./arch/riscv/kernel/compat_vdso    -march=rv32g -mabi=ilp32 -c -
o arch/riscv/kernel/compat_vdso/getcpu.o
/home/guoren/source/kernel/riscv-linux/arch/riscv/kernel/compat_vdso/getcpu.S
  riscv64-unknown-linux-gnu-gcc
-Wp,-MMD,arch/riscv/kernel/compat_vdso/.flush_icache.o.d  -nostdinc
-I/home/guoren/source/kernel/riscv-linux/arch/riscv/include
-I./arch/riscv/include/generated
-I/home/guoren/source/kernel/riscv-linux/include -I./include
-I/home/guoren/source/kernel/riscv-linux/arch/riscv/include/uapi
-I./arch/riscv/include/generated/uapi
-I/home/guoren/source/kernel/riscv-linux/include/uapi -I./include/ge
nerated/uapi -include
/home/guoren/source/kernel/riscv-linux/include/linux/compiler-version.h
-include /home/guoren/source/kernel/riscv-linux/include/linux/kconfig.h
-D__KERNEL__ -fmacro-prefix-map=/home/guoren/source/kernel/riscv-linux/=
-D__ASSEMBLY__ -fno-PIE -mabi=lp64 -march=rv64imafdc -I
/home/guoren/source/kernel/riscv-linux/arch/riscv/kernel/compat_vdso
-I ./arch/riscv/kernel/compat_vdso    -march=rv32g -mabi=ilp3
2 -c -o arch/riscv/kernel/compat_vdso/flush_icache.o
/home/guoren/source/kernel/riscv-linux/arch/riscv/kernel/compat_vdso/flush_icache.S
  riscv64-unknown-linux-gnu-gcc
-Wp,-MMD,arch/riscv/kernel/compat_vdso/.note.o.d  -nostdinc
-I/home/guoren/source/kernel/riscv-linux/arch/riscv/include
-I./arch/riscv/include/generated
-I/home/guoren/source/kernel/riscv-linux/include -I./include
-I/home/guoren/source/kernel/riscv-linux/arch/riscv/include/uapi
-I./arch/riscv/include/generated/uapi
-I/home/guoren/source/kernel/riscv-linux/include/uapi
-I./include/generated/
uapi -include /home/guoren/source/kernel/riscv-linux/include/linux/compiler-version.h
-include /home/guoren/source/kernel/riscv-linux/include/linux/kconfig.h
-D__KERNEL__ -fmacro-prefix-map=/home/guoren/source/kernel/riscv-linux/=
-D__ASSEMBLY__ -fno-PIE -mabi=lp64 -march=rv64imafdc -I
/home/guoren/source/kernel/riscv-linux/arch/riscv/kernel/compat_vdso
-I ./arch/riscv/kernel/compat_vdso    -march=rv32g -mabi=ilp32 -c -o
arch/riscv/kernel/compat_vdso/note.o
/home/guoren/source/kernel/riscv-linux/arch/riscv/kernel/compat_vdso/note.S
  riscv64-unknown-linux-gnu-ld  -melf64lriscv   -shared -S
-soname=linux-compat_vdso.so.1 --build-id=sha1 --hash-style=both
--eh-frame-hdr -melf32lriscv -T
arch/riscv/kernel/compat_vdso/compat_vdso.lds
arch/riscv/kernel/compat_vdso/rt_sigreturn.o
arch/riscv/kernel/compat_vdso/getcpu.o
arch/riscv/kernel/compat_vdso/flush_icache.o
arch/riscv/kernel/compat_vdso/note.o -o
arch/riscv/kernel/compat_vdso/compat_vdso.so.dbg.tmp &
& riscv64-unknown-linux-gnu-objcopy  -G __compat_vdso_rt_sigreturn  -G
__compat_vdso_getcpu  -G __compat_vdso_flush_icache
arch/riscv/kernel/compat_vdso/compat_vdso.so.dbg.tmp
arch/riscv/kernel/compat_vdso/compat_vdso.so.dbg && rm
arch/riscv/kernel/compat_vdso/compat_vdso.so.dbg.tmp
  riscv64-unknown-linux-gnu-nm
arch/riscv/kernel/compat_vdso/compat_vdso.so.dbg |
/home/guoren/source/kernel/riscv-linux/arch/riscv/kernel/compat_vdso/gen_compat_vdso_offsets.sh
| LC_ALL=C sort > include/generated/compat_vdso-offsets.h


On Thu, Feb 24, 2022 at 6:13 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Feb 24, 2022 at 9:54 AM <guoren@kernel.org> wrote:
> >
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > There is no vgettimeofday supported in rv32 that makes simple to
> > generate rv32 vdso code which only needs riscv64 compiler. Other
> > architectures need change compiler or -m (machine parameter) to
> > support vdso32 compiling. If rv32 support vgettimeofday (which
> > cause C compile) in future, we would add CROSS_COMPILE to support
> > that makes more requirement on compiler enviornment.
>
> I think it's just a bug that rv32 doesn't have the vdso version of the
> time syscalls. Fixing that is of course independent of the compat support,
> but I think you need that anyway, and it would be better to start
> out by building the compat vdso with the correct
> architecture level.
>
> At least this should be a lot easier than on arch/arm64 because you
> can assume that an rv64 compiler is able to also build rv32 output.
>
>         Arnd



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
