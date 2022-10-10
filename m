Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C761E5FA439
	for <lists+linux-arch@lfdr.de>; Mon, 10 Oct 2022 21:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiJJTaj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Oct 2022 15:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJJTai (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Oct 2022 15:30:38 -0400
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914F4402D6;
        Mon, 10 Oct 2022 12:30:34 -0700 (PDT)
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 29AJUD3V008989;
        Tue, 11 Oct 2022 04:30:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 29AJUD3V008989
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1665430213;
        bh=1w6TuZjh4cZPhVH0ezwJnT2FKBA5+a4r8Ml6K7U/ao4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Oh18wZlOWElB3yLE1YdvDnud2ipuPKF8y/aa+3CAgZrRnJIEeMUiP+jpJZGSB+ljm
         VvtY/hyqCT2Bz53nIVxI4aiBWCrKyZFwxn3M21yOEPgw/80fMBhUQ5Mks8XbtytcCd
         9ggv6HnvlT4jcx4QXj1MjLTPYLsDMWDDZ6DP9xGnNQ4LYnYog6NwCo/54goWKPIB0h
         jnck7Dzr6B12KkmT4U+DEv0kMlVHCUWbGbOujHNOB4eB4ue+G7RyikfkfGfaM8h2sW
         yf+lq6Qt0T8NlWH1V9IK0HVTXpwSWsgRfQnekh3QaRFrfiI01vC4croekCnUp4+u0Z
         Ozd0/OpujxgmQ==
X-Nifty-SrcIP: [209.85.167.182]
Received: by mail-oi1-f182.google.com with SMTP id w196so7339612oiw.8;
        Mon, 10 Oct 2022 12:30:13 -0700 (PDT)
X-Gm-Message-State: ACrzQf1sVTNggxfza4kjfwi9NNmM4AQplN7m5AEpO4fShDWP2KDyC1v9
        uuEZT6UnLoZqA5Vcbe39he1sKENeAB9FPqvMXZs=
X-Google-Smtp-Source: AMsMyM6AVz0CCOkmJV4/obYbhKP/mdI0EeZI/muZ+6mbOH62KIO2Ma5Xu/X64wdPvAEGsxix0yp/vF0GkHbr4R42hpQ=
X-Received: by 2002:aca:bbd4:0:b0:353:f167:6fd3 with SMTP id
 l203-20020acabbd4000000b00353f1676fd3mr9686854oif.287.1665430212351; Mon, 10
 Oct 2022 12:30:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220928063947.299333-3-masahiroy@kernel.org> <202210090942.a159fe4-yujie.liu@intel.com>
In-Reply-To: <202210090942.a159fe4-yujie.liu@intel.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 11 Oct 2022 04:29:36 +0900
X-Gmail-Original-Message-ID: <CAK7LNASUhDMo72eNge_GvdfbmOkpBCJA88Xw=_V69jcf+_072Q@mail.gmail.com>
Message-ID: <CAK7LNASUhDMo72eNge_GvdfbmOkpBCJA88Xw=_V69jcf+_072Q@mail.gmail.com>
Subject: Re: [kbuild] b3830bad81: System_halted
To:     kernel test robot <yujie.liu@intel.com>
Cc:     lkp@lists.01.org, lkp@intel.com, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>,
        Nicolas Pitre <npitre@baylibre.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Oct 9, 2022 at 10:21 AM kernel test robot <yujie.liu@intel.com> wrote:
>
> Greeting,
>
> FYI, we noticed the following commit (built with gcc-11):
>
> commit: b3830bad81e872632431363853c810c5f652a040 ("[PATCH v3 2/8] kbuild: rebuild .vmlinux.export.o when its prerequisite is updated")
> url: https://github.com/intel-lab-lkp/linux/commits/Masahiro-Yamada/Unify-linux-export-h-and-asm-export-h-remove-EXPORT_DATA_SYMBOL-faster-TRIM_UNUSED_KSYMS/20220928-144539
> base: https://git.kernel.org/cgit/linux/kernel/git/masahiroy/linux-kbuild.git for-next
> patch link: https://lore.kernel.org/linux-kbuild/20220928063947.299333-3-masahiroy@kernel.org
>
> in testcase: boot
>
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
>
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):


I think this is a false-positive alarm.

As I replied before [1], I know my patch set is broken.
I think 0day bot is testing the patch set I had already retracted.

I only picked up low-hanging fruits with fixes to my tree,
and did boot tests.

Please let me know if linux-next is broken.


[1] : https://lore.kernel.org/linux-kbuild/CAK7LNATcD6k+R66YFVg_mhe7-FGNc0nYaTPuORCcd34Qw3ra2g@mail.gmail.com/T/#t










>
> early console in setup code
> Probing EDD (edd=off to disable)... ok
> No EFI environment detected.
> early console in extract_kernel
> input_data: 0x0000000002e5740d
> input_len: 0x000000000099c37e
> output: 0x0000000001000000
> output_len: 0x000000000234aa00
> kernel_total_size: 0x0000000002828000
> needed_size: 0x0000000002a00000
> trampoline_32bit: 0x000000000009d000
>
> Decompressing Linux... Parsing ELF...
>
> Alignment of LOAD segment isn't multiple of 2MB
>
>  -- System haltedBUG: kernel hang in boot stage
>
>
>
> 61682ee38a ("kbuild: move modules.builtin(.modinfo) rules to Makefile.vmlinux_o")
> b3830bad81 ("kbuild: rebuild .vmlinux.export.o when its prerequisite is updated")
>
> +----------------+------------+------------+
> |                | 61682ee38a | b3830bad81 |
> +----------------+------------+------------+
> | boot_successes | 24         | 0          |
> | boot_failures  | 0          | 18         |
> | System_halted  | 0          | 18         |
> +----------------+------------+------------+
>
>
> If you fix the issue, kindly add following tag
> | Reported-by: kernel test robot <yujie.liu@intel.com>
> | Link: https://lore.kernel.org/r/202210090942.a159fe4-yujie.liu@intel.com
>
>
> To reproduce:
>
>         # build kernel
>         cd linux
>         cp config-6.0.0-rc7-00038-gb3830bad81e8 .config
>         make HOSTCC=gcc-11 CC=gcc-11 ARCH=x86_64 olddefconfig prepare modules_prepare bzImage modules
>         make HOSTCC=gcc-11 CC=gcc-11 ARCH=x86_64 INSTALL_MOD_PATH=<mod-install-dir> modules_install
>         cd <mod-install-dir>
>         find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz
>
>
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script is attached in this email
>
>         # if come across any failure that blocks the test,
>         # please remove ~/.lkp and /lkp dir to run from a clean state.
>
>
> --
> 0-DAY CI Kernel Test Service
> https://01.org/lkp



-- 
Best Regards
Masahiro Yamada
