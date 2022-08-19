Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 522185991C9
	for <lists+linux-arch@lfdr.de>; Fri, 19 Aug 2022 02:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240546AbiHSAfP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 18 Aug 2022 20:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239622AbiHSAfP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 18 Aug 2022 20:35:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2413FD7407;
        Thu, 18 Aug 2022 17:35:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD7A960A2C;
        Fri, 19 Aug 2022 00:35:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27A1DC43144;
        Fri, 19 Aug 2022 00:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660869313;
        bh=Jj6QaMzYytoQyWIf74AXya0oZmQ9hNahkdCnnbw4nLk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ISYnhaLdHw0CetX3806/kgbLf5Ku5YvEFDUTn61y+gMIDMGKEV/wjxNoxXoBUda23
         bNyrs4AzWMqIGI6x4du1h3jVB0LfcrUj1Iog3gUa3GFmZQt8VoYxC+NXukPdrbqzdP
         Vir/Cn37g7UFzGU/di14TTTGaLsxECu2PRQSEuCofHJ5LCajkiKvdHp88Q9uBwq8td
         qS8/hdrkNsmAVodpTr/Yh2+5xc5Y1WajhyyMso2uTNSAY5aebaZ7kL9W+8cji5pWGP
         mfePQ7OeUPG8pISYVUNG2eie4/yzhS4wyqoqcOvu/zN9fuiYdwh+1Wtjcg/w9ud0YQ
         kQ8qukYpH53wg==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-11ba6e79dd1so3614415fac.12;
        Thu, 18 Aug 2022 17:35:13 -0700 (PDT)
X-Gm-Message-State: ACgBeo0PyTEfcQUZWE5OihP6dCg2hEuA0eI4AfpdtSL3VKmX2Qobpqz+
        88RUPGnpGyuGXnO97I/3wvJL4LPtYOQf/sTB53w=
X-Google-Smtp-Source: AA6agR7G9Tvye6mFaZwo5kwGfhqNYR9Y0qsd6PWGmcMkNJCGqp08gjlaI3/OWVhmguVjf2VJB/PV0gmkcC5p2OLG5X0=
X-Received: by 2002:a05:6870:8a13:b0:10e:7c08:36ba with SMTP id
 p19-20020a0568708a1300b0010e7c0836bamr5327167oaq.19.1660869312123; Thu, 18
 Aug 2022 17:35:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220816012701.561435-3-guoren@kernel.org> <202208181520.fYQOePu6-lkp@intel.com>
In-Reply-To: <202208181520.fYQOePu6-lkp@intel.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 19 Aug 2022 08:34:59 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRA-UfM17jxTn3_Mdf3Xy5Sw9EdhEsA6i6T4veyowYxrg@mail.gmail.com>
Message-ID: <CAJF2gTRA-UfM17jxTn3_Mdf3Xy5Sw9EdhEsA6i6T4veyowYxrg@mail.gmail.com>
Subject: Re: [PATCH 2/2] riscv: kexec: Implement crash_smp_send_stop with
 percpu crash_save_cpu
To:     kernel test robot <lkp@intel.com>
Cc:     xianting.tian@linux.alibaba.com, palmer@dabbelt.com,
        heiko@sntech.de, llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, liaochang1@huawei.com,
        mick@ics.forth.gr, jszhang@kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
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

Thx, It's a bug from !SMP. I would fixup it in the next version.

On Thu, Aug 18, 2022 at 3:58 PM kernel test robot <lkp@intel.com> wrote:
>
> Hi,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on linus/master]
> [also build test ERROR on v6.0-rc1 next-20220818]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/guoren-kernel-org/riscv-kexec-Support-crash_save-percpu-and-machine_kexec_mask_interrupts/20220816-144442
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
> config: riscv-randconfig-r035-20220818 (https://download.01.org/0day-ci/archive/20220818/202208181520.fYQOePu6-lkp@intel.com/config)
> compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project aed5e3bea138ce581d682158eb61c27b3cfdd6ec)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install riscv cross compiling tool for clang build
>         # apt-get install binutils-riscv64-linux-gnu
>         # https://github.com/intel-lab-lkp/linux/commit/0abdaf7e1f44634e1cee484e3cf01b7e8c851950
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review guoren-kernel-org/riscv-kexec-Support-crash_save-percpu-and-machine_kexec_mask_interrupts/20220816-144442
>         git checkout 0abdaf7e1f44634e1cee484e3cf01b7e8c851950
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/kernel/
>
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
> >> arch/riscv/kernel/machine_kexec.c:217:7: error: call to undeclared function 'smp_crash_stop_failed'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>            WARN(smp_crash_stop_failed(),
>                 ^
>    1 error generated.
>
>
> vim +/smp_crash_stop_failed +217 arch/riscv/kernel/machine_kexec.c
>
>    193
>    194  /*
>    195   * machine_kexec - Jump to the loaded kimage
>    196   *
>    197   * This function is called by kernel_kexec which is called by the
>    198   * reboot system call when the reboot cmd is LINUX_REBOOT_CMD_KEXEC,
>    199   * or by crash_kernel which is called by the kernel's arch-specific
>    200   * trap handler in case of a kernel panic. It's the final stage of
>    201   * the kexec process where the pre-loaded kimage is ready to be
>    202   * executed. We assume at this point that all other harts are
>    203   * suspended and this hart will be the new boot hart.
>    204   */
>    205  void __noreturn
>    206  machine_kexec(struct kimage *image)
>    207  {
>    208          struct kimage_arch *internal = &image->arch;
>    209          unsigned long jump_addr = (unsigned long) image->start;
>    210          unsigned long first_ind_entry = (unsigned long) &image->head;
>    211          unsigned long this_cpu_id = __smp_processor_id();
>    212          unsigned long this_hart_id = cpuid_to_hartid_map(this_cpu_id);
>    213          unsigned long fdt_addr = internal->fdt_addr;
>    214          void *control_code_buffer = page_address(image->control_code_page);
>    215          riscv_kexec_method kexec_method = NULL;
>    216
>  > 217          WARN(smp_crash_stop_failed(),
>
> --
> 0-DAY CI Kernel Test Service
> https://01.org/lkp



-- 
Best Regards
 Guo Ren
