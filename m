Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF7B5AC1E6
	for <lists+linux-arch@lfdr.de>; Sun,  4 Sep 2022 02:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbiIDAuc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 3 Sep 2022 20:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiIDAub (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 3 Sep 2022 20:50:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40784E843;
        Sat,  3 Sep 2022 17:50:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F38B760E0B;
        Sun,  4 Sep 2022 00:50:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5792EC433D7;
        Sun,  4 Sep 2022 00:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662252627;
        bh=ksEfQgyVJmtFnHe1G9mJ/zdS+A33wXj6d/7sIqipu3Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UGyw8kEvOD7u2JaLt9H4F+9s6PS/KXrFIqm8j2AzeHiFpNSjdORTQpZoEnbJ4v20u
         azbe7G5m/W3rxGzgpa+p/9Ogj4XcDaQBFWlXxt/3kf2sYJyLIduZ2X2rPSPHuwi68x
         JDPLjRdhjmzGoa0m0dFoQZ1R+nYgITnxHR/eLGjrtxoQeO7jWAeGNlOJRV0sR0skH7
         vDNf4BSpboYsAeMGiH/I+ZwTOOOegV10kxNbyvbOk/Bcc1vZlgday38UJITzqDQRuZ
         u7XctvT3rSgrf9jbV33igGoL0lFqW6hNhXQpLdsUZ1hJyJ1Z/26jMEyIRHe936JLJs
         MnsOOU/Z87pKg==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-11ee4649dfcso14043436fac.1;
        Sat, 03 Sep 2022 17:50:27 -0700 (PDT)
X-Gm-Message-State: ACgBeo1JsgJMOpYlyuC0WX9REdjqWHlpbN/SmoOL9AgXtt7GZQCEgWa1
        lS40euAGey6eYZAoGKm50NZX1o3BpGdScwCW3Ps=
X-Google-Smtp-Source: AA6agR4qiR/QXf3Z1El6po8BJBRz2HLjT7oOxsXfAy/JNS0LCsqub54/O+VJE3ccfzOMo6eSjT+FP6O6bNW+Gw3PQoM=
X-Received: by 2002:a05:6808:2028:b0:344:246d:2bed with SMTP id
 q40-20020a056808202800b00344246d2bedmr4637506oiw.19.1662252626504; Sat, 03
 Sep 2022 17:50:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220903163808.1954131-2-guoren@kernel.org> <202209040122.Nhovi9f6-lkp@intel.com>
In-Reply-To: <202209040122.Nhovi9f6-lkp@intel.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 4 Sep 2022 08:50:13 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSQBJLq9Mr_wZYGF4DHSWfk7WkERNCokRu0JQdybB04Hg@mail.gmail.com>
Message-ID: <CAJF2gTSQBJLq9Mr_wZYGF4DHSWfk7WkERNCokRu0JQdybB04Hg@mail.gmail.com>
Subject: Re: [PATCH 1/3] riscv: convert to generic entry
To:     kernel test robot <lkp@intel.com>
Cc:     arnd@arndb.de, palmer@rivosinc.com, tglx@linutronix.de,
        luto@kernel.org, kbuild-all@lists.01.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Huacai Chen <chenhuacai@kernel.org>
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

It would be fixed in V2

On Sun, Sep 4, 2022 at 1:49 AM kernel test robot <lkp@intel.com> wrote:
>
> Hi,
>
> I love your patch! Perhaps something to improve:
>
> [auto build test WARNING on soc/for-next]
> [also build test WARNING on linus/master v6.0-rc3 next-20220901]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/guoren-kernel-org/riscv-Add-GENERIC_ENTRY-IRQ_STACKS-support/20220904-003954
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
> config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20220904/202209040122.Nhovi9f6-lkp@intel.com/config)
> compiler: riscv64-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/8390e92d0bcc635f457df18c8c1baefc78a94e48
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review guoren-kernel-org/riscv-Add-GENERIC_ENTRY-IRQ_STACKS-support/20220904-003954
>         git checkout 8390e92d0bcc635f457df18c8c1baefc78a94e48
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/
>
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
> >> arch/riscv/kernel/signal.c:275:6: warning: no previous prototype for 'arch_do_signal_or_restart' [-Wmissing-prototypes]
>      275 | void arch_do_signal_or_restart(struct pt_regs *regs, bool has_signal)
>          |      ^~~~~~~~~~~~~~~~~~~~~~~~~
>
>
> vim +/arch_do_signal_or_restart +275 arch/riscv/kernel/signal.c
>
>    274
>  > 275  void arch_do_signal_or_restart(struct pt_regs *regs, bool has_signal)
>
> --
> 0-DAY CI Kernel Test Service
> https://01.org/lkp



-- 
Best Regards
 Guo Ren
