Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E5B5BD7A1
	for <lists+linux-arch@lfdr.de>; Tue, 20 Sep 2022 00:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiISWu5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Sep 2022 18:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiISWu5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Sep 2022 18:50:57 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF98402D9;
        Mon, 19 Sep 2022 15:50:56 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id go6so1161490pjb.2;
        Mon, 19 Sep 2022 15:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=P5fHiBFrzLiRzEpMOACp+d2Ohe++oGSdQyJinHVxQKw=;
        b=KiiiMI2LojE8hJ1SMEQ/0jAzCYdsjQ97aU0KdsNvKqUNa/8M3CYlVMXUXk4juhYcWj
         1o2Ce8Omhi5jtN3ZVWyx4/7QBo0mvCNTDHOcI929rXFOkUkM61UgKYS1oF/b6XkLSj7k
         IebBVJp9yNLhzsIJcKDcZHd7vg9+2h2YAiQjYAUN8b20VGFmNDrB5OAb4GP07U3dYplX
         an8S6TFOqAPSBrYMU1+uS3f/f6v4ncreeo0yjJsSrNpAB2LXQtQMWvoMBdffEdehzVQu
         aUX7DJGo03yzt0SfK6Yoi4eqmI20QdS62KfzMKee8cNZjUkcjBu0bY085SqFFhy7skFO
         pcZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=P5fHiBFrzLiRzEpMOACp+d2Ohe++oGSdQyJinHVxQKw=;
        b=l/N9fWI4AMwnAIbuS1TX63gvpZMgI2oouLkKnhmyE4ynznuXrp8E4DfKvmSXyeN/a6
         K2P7tEGa5/UeVDXaEESYqSYGZnjdhOt57cMh9ESuw2dhW3PqrfM5+mBP0Q84eSf7zuqH
         v8RCok+vRVexOLihzB3Pe0Mw7kd14S4pSujP1X8+He3T5ZS1923H6xcKgwLlbvqJx7/2
         L0LYPZJPPLePQFzrHl6FD5mcIX+m9OYUZDx6WQYS22I7m5Ewf69PSBFeNI/H057iIGZV
         19v7zeEYA9UR8tK3GX/8h/cbSWVDwTEqljl1Zd0R5dyzCYoHG1CVgEWkWq9UFQy1OWSl
         BGQA==
X-Gm-Message-State: ACrzQf2mUT1lXAQiromYL3EzMpQ/8Yn3BqoW5Sootn51CQxP5Y8E/xZC
        cTpQMnr4C4PezB+fqP/NPGK8WToAFxZ/uw==
X-Google-Smtp-Source: AMsMyM6TuzZ3f+uuMHl6hGx18A0qAX05DRr4LwZKyAx1eARUbUWRIihpuLH601mTQK6FKD16ZBFIMw==
X-Received: by 2002:a17:903:2305:b0:178:380f:5246 with SMTP id d5-20020a170903230500b00178380f5246mr1957730plh.146.1663627855660;
        Mon, 19 Sep 2022 15:50:55 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n7-20020aa79847000000b0053abb15b3d9sm21446151pfq.19.2022.09.19.15.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 15:50:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 19 Sep 2022 15:50:53 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 7/8] kbuild: use obj-y instead extra-y for objects
 placed at the head
Message-ID: <20220919225053.GA769506@roeck-us.net>
References: <20220906061313.1445810-1-masahiroy@kernel.org>
 <20220906061313.1445810-8-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906061313.1445810-8-masahiroy@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On Tue, Sep 06, 2022 at 03:13:12PM +0900, Masahiro Yamada wrote:
> The objects placed at the head of vmlinux need special treatments:
> 
>  - arch/$(SRCARCH)/Makefile adds them to head-y in order to place
>    them before other archives in the linker command line.
> 
>  - arch/$(SRCARCH)/kernel/Makefile adds them to extra-y instead of
>    obj-y to avoid them going into built-in.a.
> 
> This commit gets rid of the latter.
> 
> Create vmlinux.a to collect all the objects that are unconditionally
> linked to vmlinux. The objects listed in head-y are moved to the head
> of vmlinux.a by using 'ar m'.
> 
> With this, arch/$(SRCARCH)/kernel/Makefile can consistently use obj-y
> for builtin objects.
> 
> There is no *.o that is directly linked to vmlinux. Drop unneeded code
> in scripts/clang-tools/gen_compile_commands.py.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

The following build failure is seen when building m68k:defconfig in
next-20220919.

m68k-linux-ld: arch/m68k/kernel/setup.o: in function `setup_arch':
setup.c:(.init.text+0x2dc): undefined reference to `availmem'
m68k-linux-ld: arch/m68k/kernel/early_printk.o: in function `debug_cons_write':
early_printk.c:(.ref.text+0x28): undefined reference to `debug_cons_nputs'
m68k-linux-ld: arch/m68k/mm/init.o: in function `mem_init':
init.c:(.init.text+0x6e): undefined reference to `kernel_pg_dir'
m68k-linux-ld: init.c:(.init.text+0x10): undefined reference to `kernel_pg_dir'
m68k-linux-ld: init.c:(.init.text+0x1e): undefined reference to `kernel_pg_dir'
m68k-linux-ld: arch/m68k/mm/motorola.o: in function `cache_page':
motorola.c:(.text+0xfc): undefined reference to `m68k_supervisor_cachemode'
m68k-linux-ld: arch/m68k/mm/motorola.o: in function `mmu_page_ctor':
motorola.c:(.text+0x162): undefined reference to `m68k_pgtable_cachemode'
m68k-linux-ld: arch/m68k/mm/motorola.o: in function `paging_init':
motorola.c:(.init.text+0x3d2): undefined reference to `kernel_pg_dir'
m68k-linux-ld: motorola.c:(.init.text+0x1d8): undefined reference to `availmem'
m68k-linux-ld: motorola.c:(.init.text+0x32e): undefined reference to `m68k_supervisor_cachemode'
m68k-linux-ld: motorola.c:(.init.text+0x3a8): undefined reference to `kernel_pg_dir'
m68k-linux-ld: arch/m68k/q40/config.o: in function `q40_mem_console_write':
config.c:(.text+0x25c): undefined reference to `q40_mem_cptr'
m68k-linux-ld: config.c:(.text+0x254): undefined reference to `q40_mem_cptr'
m68k-linux-ld: arch/m68k/q40/config.o: in function `q40_debug_setup':
config.c:(.init.text+0x28): undefined reference to `q40_mem_cptr'
m68k-linux-ld: arch/m68k/mvme16x/config.o: in function `mvme16x_abort_int':
config.c:(.text+0x4): undefined reference to `mvme_bdid'
m68k-linux-ld: arch/m68k/mvme16x/config.o: in function `mvme16x_get_model':
config.c:(.text+0xc8): undefined reference to `mvme_bdid'
m68k-linux-ld: config.c:(.text+0xce): undefined reference to `mvme_bdid'
m68k-linux-ld: config.c:(.text+0xea): undefined reference to `mvme_bdid'
m68k-linux-ld: arch/m68k/mvme16x/config.o: in function `mvme16x_get_hardware_list':
config.c:(.text+0x148): undefined reference to `mvme_bdid'
m68k-linux-ld: arch/m68k/mvme16x/config.o:config.c:(.text+0x1d0): more undefined references to `mvme_bdid' follow
m68k-linux-ld: kernel/extable.o: in function `core_kernel_text':
extable.c:(.text+0x52): undefined reference to `_stext'
m68k-linux-ld: kernel/kallsyms.o: in function `is_ksym_addr':
kallsyms.c:(.text+0x31c): undefined reference to `_stext'
m68k-linux-ld: kernel/crash_core.o: in function `crash_save_vmcoreinfo_init':
crash_core.c:(.init.text+0x4d4): undefined reference to `_stext'
m68k-linux-ld: crash_core.c:(.init.text+0x4bc): undefined reference to `kernel_pg_dir'
m68k-linux-ld: mm/page_alloc.o: in function `mem_init_print_info':
page_alloc.c:(.init.text+0xff8): undefined reference to `_stext'
m68k-linux-ld: page_alloc.c:(.init.text+0x1050): undefined reference to `_stext'
m68k-linux-ld: mm/init-mm.o:(.data+0x18): undefined reference to `kernel_pg_dir'
m68k-linux-ld: mm/usercopy.o: in function `__check_object_size':
usercopy.c:(.text+0x15a): undefined reference to `_stext'

Bisect points to this patch (or its equivalent in next-20220919).

Guenter

---
# bad: [4c9ca5b1597e3222177ba2a94658f78fa5ef4f58] Add linux-next specific files for 20220919
# good: [521a547ced6477c54b4b0cc206000406c221b4d6] Linux 6.0-rc6
git bisect start 'HEAD' 'v6.0-rc6'
# bad: [8b4141305a585c4cb1147dcc164059dc3b5489e2] Merge branch 'drm-next' of git://git.freedesktop.org/git/drm/drm.git
git bisect bad 8b4141305a585c4cb1147dcc164059dc3b5489e2
# bad: [03e33baab7f2c3459bd268639af383cafe0c0a4b] Merge branch 'docs-next' of git://git.lwn.net/linux.git
git bisect bad 03e33baab7f2c3459bd268639af383cafe0c0a4b
# bad: [c1a464c761e4098899873c472b3756f557a3b73c] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git
git bisect bad c1a464c761e4098899873c472b3756f557a3b73c
# bad: [59d922adf1c023a84bd4dd4fad0442221fd6347f] Merge branch 'for-next/core' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux
git bisect bad 59d922adf1c023a84bd4dd4fad0442221fd6347f
# good: [166f57a723e13d816b09b2f27433f2c8ba2f06fe] Merge branch 'fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git
git bisect good 166f57a723e13d816b09b2f27433f2c8ba2f06fe
# bad: [aaa38e8ca1345b2369051a6213f706d5107a20ba] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
git bisect bad aaa38e8ca1345b2369051a6213f706d5107a20ba
# good: [1081fb0f6d6e68186e1088db33396b11770a0710] perf vendor events arm64: Move REMOTE_ACCESS to "memory" category
git bisect good 1081fb0f6d6e68186e1088db33396b11770a0710
# bad: [4aaa1766cf8d19becdade98bff3960c6583b8d09] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
git bisect bad 4aaa1766cf8d19becdade98bff3960c6583b8d09
# good: [a521c97e2a63490c238865763fc86942dce8d6bb] kbuild: rewrite check-local-export in sh/awk
git bisect good a521c97e2a63490c238865763fc86942dce8d6bb
# bad: [6676e2cdd7c339dc40331faccbaac1112d2c1d78] kbuild: use obj-y instead extra-y for objects placed at the head
git bisect bad 6676e2cdd7c339dc40331faccbaac1112d2c1d78
# good: [10d1d4b75525f3172c6930fb20445f669762ea95] kbuild: move core-y and drivers-y to ./Kbuild
git bisect good 10d1d4b75525f3172c6930fb20445f669762ea95
# good: [b8d366ae69fe633e697776b839ac52d3eecf07d3] kbuild: move vmlinux.o rule to the top Makefile
git bisect good b8d366ae69fe633e697776b839ac52d3eecf07d3
# good: [165b718fdd8c5a9165b4485019729c0cd8728120] kbuild: unify two modpost invocations
git bisect good 165b718fdd8c5a9165b4485019729c0cd8728120
# first bad commit: [6676e2cdd7c339dc40331faccbaac1112d2c1d78] kbuild: use obj-y instead extra-y for objects placed at the head
