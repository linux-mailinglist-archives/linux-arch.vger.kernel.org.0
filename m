Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5007375A1
	for <lists+linux-arch@lfdr.de>; Tue, 20 Jun 2023 22:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjFTUGf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Jun 2023 16:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjFTUGe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Jun 2023 16:06:34 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C6B10D2
        for <linux-arch@vger.kernel.org>; Tue, 20 Jun 2023 13:06:09 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-763bd31d223so20531285a.3
        for <linux-arch@vger.kernel.org>; Tue, 20 Jun 2023 13:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687291567; x=1689883567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iVJbcnK9Qx/SM1RU+Yl3551W5ATUEB7oGTTKZE8N8FM=;
        b=rwNMKAQLjHWXMj1Dp3K8MeV/fwiIXhZ/S/qpMFcsYISAx5HTU8gmGlyrjDY5nwCXg0
         ObumyZnmencFoTBG2MuKmwS7PWoxOG3qZyU6cmUCpEEpDf6h3YOGyPHxqvGwOcD5+nPO
         Zn0CIo/G0O9pWATNbmjUIBA2lvW8EQnH0//qnG7uocE9cB3SxHzRTUo9dBPtKwK/1TPd
         xzSrHSYlz3WKk1Lu9Bp2/qNYIsKfhS5WUQwPdCajPCUx80xNaXC1A9tqxPbnNAPUBXDx
         I9peGylc4BtTh/KaMqxpcQNhIDeMrTYeCwBni6KwUx/Ay0JrJz3fAoPZ+XXL7L5qQ8Pr
         Q7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687291567; x=1689883567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iVJbcnK9Qx/SM1RU+Yl3551W5ATUEB7oGTTKZE8N8FM=;
        b=M1MyTMcUiYN2L/rpTZ6ro1pdM3Bd0kj1b07lLoTwrP6CcOWVjgplYqXFJfPz3Cmxzo
         pk6xK6MVNCb/yZHcVhBCg8RLme1NBwN7lrk17xJIaycPpaaZAAyRs2y3OCtV/WtTIG2p
         T+nOSFq7LVZhMb8IG78OgrXShj0BEe7Ycz7UA34rNLfotWQ7TZ7OSeiscshY4L4VWRNg
         9YJIFSEbohO24mqfNyeoawo/ZF1PSxKYsJN6rhdBPPd/GptEwj7awRqZEqWltPXhqrXE
         61bg7IfRXD4FV9+3A/dtOt+7I4lmMCal+yW5FraiFFA8jMvl8LmpNRSuG/Suhc+2neyE
         ovTw==
X-Gm-Message-State: AC+VfDwpWmoQAErv7y9i7JA6lwl2fPkdUy4YERBAd9+kYxYw6gEifsMJ
        6x3XJLe3T8NL1/xTIozZEo9Z6ew/4U4iOD0ui6U86g==
X-Google-Smtp-Source: ACHHUZ65FIq/IaDvb0FI4/OCn/SvbsTtuxojXjehAFIglf6TO/3iWJmT7NT7hypSrVfabhcA7uh75B1M6oDtjrXMfXU=
X-Received: by 2002:a05:6214:2b08:b0:5e3:d150:3168 with SMTP id
 jx8-20020a0562142b0800b005e3d1503168mr19306606qvb.18.1687291566979; Tue, 20
 Jun 2023 13:06:06 -0700 (PDT)
MIME-Version: 1.0
References: <mhng-41a06775-95dc-4747-aaab-2c5c83fd6422@palmer-ri-x1c9> <mhng-57559277-afaa-4a85-a3ad-b9be6dba737f@palmer-ri-x1c9>
In-Reply-To: <mhng-57559277-afaa-4a85-a3ad-b9be6dba737f@palmer-ri-x1c9>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 20 Jun 2023 16:05:55 -0400
Message-ID: <CAKwvOdmsgMN5oQpDLh12D0X-CfQDtHC-EtxHcBnADkhnyitMKQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] riscv: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
To:     Palmer Dabbelt <palmer@dabbelt.com>, jszhang@kernel.org
Cc:     llvm@lists.linux.dev, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Arnd Bergmann <arnd@arndb.de>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Fangrui Song <maskray@google.com>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 19, 2023 at 6:06=E2=80=AFPM Palmer Dabbelt <palmer@dabbelt.com>=
 wrote:
>
> On Thu, 15 Jun 2023 06:54:33 PDT (-0700), Palmer Dabbelt wrote:
> > On Wed, 14 Jun 2023 09:25:49 PDT (-0700), jszhang@kernel.org wrote:
> >>
> >> On Wed, Jun 14, 2023 at 07:49:17AM -0700, Palmer Dabbelt wrote:
> >>> On Tue, 23 May 2023 09:54:58 PDT (-0700), jszhang@kernel.org wrote:
> >>> > When trying to run linux with various opensource riscv core on
> >>> > resource limited FPGA platforms, for example, those FPGAs with less
> >>> > than 16MB SDRAM, I want to save mem as much as possible. One of the
> >>> > major technologies is kernel size optimizations, I found that riscv
> >>> > does not currently support HAVE_LD_DEAD_CODE_DATA_ELIMINATION, whic=
h
> >>> > passes -fdata-sections, -ffunction-sections to CFLAGS and passes th=
e
> >>> > --gc-sections flag to the linker.
> >>> >
> >>> > This not only benefits my case on FPGA but also benefits defconfigs=
.
> >>> > Here are some notable improvements from enabling this with defconfi=
gs:
> >>> >
> >>> > nommu_k210_defconfig:
> >>> >    text    data     bss     dec     hex
> >>> > 1112009  410288   59837 1582134  182436     before
> >>> >  962838  376656   51285 1390779  1538bb     after
> >>> >
> >>> > rv32_defconfig:
> >>> >    text    data     bss     dec     hex
> >>> > 8804455 2816544  290577 11911576 b5c198     before
> >>> > 8692295 2779872  288977 11761144 b375f8     after
> >>> >
> >>> > defconfig:
> >>> >    text    data     bss     dec     hex
> >>> > 9438267 3391332  485333 13314932 cb2b74     before
> >>> > 9285914 3350052  483349 13119315 c82f53     after
> >>> >
> >>> > patch1 and patch2 are clean ups.
> >>> > patch3 fixes a typo.
> >>> > patch4 finally enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION for riscv.
> >>> >
> >>> > NOTE: Zhangjin Wu firstly sent out a patch to enable dead code
> >>> > elimination for riscv several months ago, I didn't notice it until
> >>> > yesterday. Although it missed some preparations and some sections's
> >>> > keeping, he is the first person to enable this feature for riscv. T=
o
> >>> > ease merging, this series take his patch into my entire series and
> >>> > makes patch4 authored by him after getting his ack to reflect
> >>> > the above fact.
> >>> >
> >>> > Since v1:
> >>> >   - collect Reviewed-by, Tested-by tag
> >>> >   - Make patch4 authored by Zhangjin Wu, add my co-developed-by tag
> >>> >
> >>> > Jisheng Zhang (3):
> >>> >   riscv: move options to keep entries sorted
> >>> >   riscv: vmlinux-xip.lds.S: remove .alternative section
> >>> >   vmlinux.lds.h: use correct .init.data.* section name
> >>> >
> >>> > Zhangjin Wu (1):
> >>> >   riscv: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
> >>> >
> >>> >  arch/riscv/Kconfig                  |  13 +-
> >>> >  arch/riscv/kernel/vmlinux-xip.lds.S |   6 -
> >>> >  arch/riscv/kernel/vmlinux.lds.S     |   6 +-
> >>> >  include/asm-generic/vmlinux.lds.h   |   2 +-
> >>> >  4 files changed, 11 insertions(+), 16 deletions(-)
> >>>
> >>> Do you have a base commit for this?  It's not applying to 6.4-rc1 and=
 the
> >>> patchwork bot couldn't find one either.
> >>
> >> Hi Palmer,
> >>
> >> Commit 3b90b09af5be ("riscv: Fix orphan section warnings caused by
> >> kernel/pi") touches vmlinux.lds.S, so to make the merge easy, this
> >> series is based on 6.4-rc2.
> >
> > Thanks.
>
> Sorry to be so slow here, but I think this is causing LLD to hang on
> allmodconfig.  I'm still getting to the bottom of it, there's a few
> other things I have in flight still.

Confirmed with v3 on mainline (linux-next is pretty red at the moment).
https://lore.kernel.org/linux-riscv/20230517082936.37563-1-falcon@tinylab.o=
rg/

I was able to dump a backtrace of all of LLD's threads and all threads
seemed parked in a futex wait except for one thread with a more
interesting trace.

0x0000555557ea01ce in
lld::elf::LinkerScript::addOrphanSections()::$_0::operator()(lld::elf::Inpu=
tSectionBase*)
const ()
(gdb) bt
#0  0x0000555557ea01ce in
lld::elf::LinkerScript::addOrphanSections()::$_0::operator()(lld::elf::Inpu=
tSectionBase*)
const ()
#1  0x0000555557e9fc3f in lld::elf::LinkerScript::addOrphanSections() ()
#2  0x0000555557dd0ca1 in
lld::elf::LinkerDriver::link(llvm::opt::InputArgList&) ()
#3  0x0000555557dc19a8 in
lld::elf::LinkerDriver::linkerMain(llvm::ArrayRef<char const*>) ()
#4  0x0000555557dbfff9 in lld::elf::link(llvm::ArrayRef<char const*>,
llvm::raw_ostream&, llvm::raw_ostream&, bool, bool) ()
#5  0x0000555557c3ffcf in lldMain(int, char const**,
llvm::raw_ostream&, llvm::raw_ostream&, bool) ()
#6  0x0000555557c3f7aa in lld_main(int, char**, llvm::ToolContext const&) (=
)
#7  0x0000555557c41ee1 in main ()

Makes me wonder if there's some kind of loop adding orphan sections
that aren't referenced, so they're cleaned up.

Though I don't think it's a hang; IIRC dead code elimination adds a
measurable amount of time to the build.  As code is unreferenced and
removed, I think the linker is reshuffling layout and thus recomputing
relocations.

Though triple checking mainline without this patch vs mainline with
this patch, twice now I just got an error from LLD (in 2 minutes on my
system):

ld.lld: error: ./drivers/firmware/efi/libstub/lib.a(efi-stub-entry.stub.o):=
(.init.bss.screen_info_offset)
is being placed in '.init.bss.screen_info_offset'
ld.lld: error: ./drivers/firmware/efi/libstub/lib.a(efi-stub-helper.stub.o)=
:(.init.data.efi_nokaslr)
is being placed in '.init.data.efi_nokaslr'
ld.lld: error: ./drivers/firmware/efi/libstub/lib.a(efi-stub-helper.stub.o)=
:(.init.bss.efi_noinitrd)
is being placed in '.init.bss.efi_noinitrd'
ld.lld: error: ./drivers/firmware/efi/libstub/lib.a(efi-stub-helper.stub.o)=
:(.init.bss.efi_nochunk)
is being placed in '.init.bss.efi_nochunk'
ld.lld: error: ./drivers/firmware/efi/libstub/lib.a(efi-stub-helper.stub.o)=
:(.init.bss.efi_novamap)
is being placed in '.init.bss.efi_novamap'
ld.lld: error: ./drivers/firmware/efi/libstub/lib.a(efi-stub-helper.stub.o)=
:(.init.bss.efi_disable_pci_dma)
is being placed in '.init.bss.efi_disable_pci_dma'
ld.lld: error: ./drivers/firmware/efi/libstub/lib.a(file.stub.o):(.init.bss=
.efi_open_device_path.text_to_dp)
is being placed in '.init.bss.efi_open_device_path.text_to_dp'
ld.lld: error: ./drivers/firmware/efi/libstub/lib.a(gop.stub.o):(.init.bss.=
cmdline.0)
is being placed in '.init.bss.cmdline.0'
ld.lld: error: ./drivers/firmware/efi/libstub/lib.a(gop.stub.o):(.init.bss.=
cmdline.1)
is being placed in '.init.bss.cmdline.1'
ld.lld: error: ./drivers/firmware/efi/libstub/lib.a(gop.stub.o):(.init.bss.=
cmdline.2)
is being placed in '.init.bss.cmdline.2'
ld.lld: error: ./drivers/firmware/efi/libstub/lib.a(gop.stub.o):(.init.bss.=
cmdline.3)
is being placed in '.init.bss.cmdline.3'
ld.lld: error: ./drivers/firmware/efi/libstub/lib.a(gop.stub.o):(.init.bss.=
cmdline.4)
is being placed in '.init.bss.cmdline.4'
ld.lld: error: ./drivers/firmware/efi/libstub/lib.a(printk.stub.o):(.init.d=
ata.efi_loglevel)
is being placed in '.init.data.efi_loglevel'
ld.lld: error: ./drivers/firmware/efi/libstub/lib.a(riscv.stub.o):(.init.bs=
s.hartid)
is being placed in '.init.bss.hartid'
ld.lld: error: ./drivers/firmware/efi/libstub/lib.a(systable.stub.o):(.init=
.bss.efi_system_table)
is being placed in '.init.bss.efi_system_table'

is it perhaps that these sections need placement in the linker script?
 This is from the orphan section warn linker command line flag.

Does the EFI stub have one linker script, or one per arch? (Or am I
mistaken and the EFI stub is part of vmlinux)?


>
> >
> >>
> >> Thanks
>


--=20
Thanks,
~Nick Desaulniers
