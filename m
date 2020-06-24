Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E97DD2096CC
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jun 2020 01:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389230AbgFXXEI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jun 2020 19:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389170AbgFXXEB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Jun 2020 19:04:01 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBEBC061573
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 16:04:01 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id f3so2252535pgr.2
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 16:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h/sT8/G1PH3fexewdru2F1nW3LAaUq5tRdXU1A5a8Jw=;
        b=XjWVQf0IY1W8pLoC9/4lk9Iet6zIlT2uxdwnBbKIZuPLzC788RkLO/cGVRBhoVsUFG
         jIeK2/Otf1NWD8xNzrkv/c3yIU0XmSH1h9k3azV0fehC3Ylny3rk3y5NsVDA0TWIajux
         aKiSmD0Xbfkn+BudT6myaPi0diQbnSW+D+lOWoXfQWNWbQCQEqY1h9xJTQpVJC6UW6JH
         CCe5WbcW9/oWNbiQgcJ1yMTMEZvA86M1FH2kkqf63yRdUgRY/g9q5C8GcyOQv9zBre0I
         uJ6X39fsr1uCIOrBARLubsPFbMOPblo12k9Db4vn7qjZTyWjA70546phu94a93h2dJLn
         hYzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h/sT8/G1PH3fexewdru2F1nW3LAaUq5tRdXU1A5a8Jw=;
        b=VXxKMHVWwHRxHkgiSPdL4EgqI90kzzJrnwytWkJUUsb5ctbyhMitP8pZJ+e5zSHwkI
         fhRUPKlm1NzqfyKUvk/FIYr4Vc+7GOGC9fSOjLp4jl1mrCfGLaQjI4vJKJfTClZ+U2dH
         b+Jo2hwYYEiwH5uT/RrTNpgXs6NJzX3MrxOi8NLG4z1n6rPKgMqVD5w1Xzp8ltMsW/zD
         XclJ+y0P0ghGExVUJOUG1JcgTxvDdve2c0nhM2bW8X4N4jic7xaqxc+TUCrQNwnDmtBe
         bbQOgB7UtPKnRU5UBYsoIJ9kF6RhRwS6unkPnechY+S911wHvyG7V0c69XStzdOV3k+U
         VRYA==
X-Gm-Message-State: AOAM533ZVRBxIPsP2El/t14+Wuaqjbqp7dj9QBdKnbV7J4tMAcqtTTn9
        FtkbFp/9XbMvdERfJNXsk2RK9PV7x03lNka1LUXI7Q==
X-Google-Smtp-Source: ABdhPJzndIWD/kQnBdcwHAgKBv8OBJfyRkZQGluLziZ4tmoUR0t8Q1D8vBPKFa0hfMJne/R/rkrQvBIqJG1bv11711I=
X-Received: by 2002:a63:7e55:: with SMTP id o21mr13259261pgn.263.1593039840061;
 Wed, 24 Jun 2020 16:04:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200624203200.78870-12-samitolvanen@google.com> <202006250618.DQj64eMK%lkp@intel.com>
In-Reply-To: <202006250618.DQj64eMK%lkp@intel.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 24 Jun 2020 16:03:48 -0700
Message-ID: <CAKwvOdnREuOmN_Vinn8pn6fxEpjzCM1_=9tDzbd2z884GNLFeA@mail.gmail.com>
Subject: Re: [PATCH 11/22] pci: lto: fix PREL32 relocations
To:     kernel test robot <lkp@intel.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, kbuild-all@lists.01.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 24, 2020 at 3:50 PM kernel test robot <lkp@intel.com> wrote:
>
> Hi Sami,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on 26e122e97a3d0390ebec389347f64f3730fdf48f]
>
> url:    https://github.com/0day-ci/linux/commits/Sami-Tolvanen/add-support-for-Clang-LTO/20200625-043816
> base:    26e122e97a3d0390ebec389347f64f3730fdf48f
> config: i386-alldefconfig (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-13) 9.3.0
> reproduce (this is a W=1 build):
>         # save the attached .config to linux build tree
>         make W=1 ARCH=i386

Note: W=1 ^

>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
>    In file included from arch/x86/kernel/pci-dma.c:9:
> >> include/linux/compiler-gcc.h:72:45: warning: no previous prototype for '__UNIQUE_ID_via_no_dac190' [-Wmissing-prototypes]
>       72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
>          |                                             ^~~~~~~~~~~~
>    include/linux/pci.h:1914:7: note: in definition of macro '___DECLARE_PCI_FIXUP_SECTION'
>     1914 |  void stub(struct pci_dev *dev) { hook(dev); }   \
>          |       ^~~~

Should `stub` be qualified as `static inline`? https://godbolt.org/z/cPBXxW
Or should stub be declared in this header, but implemented in a .c
file?  (I'm guessing the former, since the `hook` callback comes from
the macro).

> >> include/linux/pci.h:1928:2: note: in expansion of macro '__DECLARE_PCI_FIXUP_SECTION'
>     1928 |  __DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class, \
>          |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> >> include/linux/compiler_types.h:54:22: note: in expansion of macro '___PASTE'
>       54 | #define __PASTE(a,b) ___PASTE(a,b)
>          |                      ^~~~~~~~
> >> include/linux/compiler-gcc.h:72:29: note: in expansion of macro '__PASTE'
>       72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
>          |                             ^~~~~~~
> >> include/linux/compiler_types.h:54:22: note: in expansion of macro '___PASTE'
>       54 | #define __PASTE(a,b) ___PASTE(a,b)
>          |                      ^~~~~~~~
>    include/linux/compiler-gcc.h:72:37: note: in expansion of macro '__PASTE'
>       72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
>          |                                     ^~~~~~~
> >> include/linux/pci.h:1929:26: note: in expansion of macro '__UNIQUE_ID'
>     1929 |       class_shift, hook, __UNIQUE_ID(hook))
>          |                          ^~~~~~~~~~~
> >> include/linux/pci.h:1949:2: note: in expansion of macro 'DECLARE_PCI_FIXUP_SECTION'
>     1949 |  DECLARE_PCI_FIXUP_SECTION(.pci_fixup_final,   \
>          |  ^~~~~~~~~~~~~~~~~~~~~~~~~
> >> arch/x86/kernel/pci-dma.c:154:1: note: in expansion of macro 'DECLARE_PCI_FIXUP_CLASS_FINAL'
>      154 | DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_VIA, PCI_ANY_ID,
>          | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> --
>    In file included from arch/x86/kernel/quirks.c:6:
> >> include/linux/compiler-gcc.h:72:45: warning: no previous prototype for '__UNIQUE_ID_ich_force_enable_hpet180' [-Wmissing-prototypes]
>       72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
>          |                                             ^~~~~~~~~~~~
>    include/linux/pci.h:1914:7: note: in definition of macro '___DECLARE_PCI_FIXUP_SECTION'
>     1914 |  void stub(struct pci_dev *dev) { hook(dev); }   \
>          |       ^~~~
> >> include/linux/pci.h:1928:2: note: in expansion of macro '__DECLARE_PCI_FIXUP_SECTION'
>     1928 |  __DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class, \
>          |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> >> include/linux/compiler_types.h:54:22: note: in expansion of macro '___PASTE'
>       54 | #define __PASTE(a,b) ___PASTE(a,b)
>          |                      ^~~~~~~~
> >> include/linux/compiler-gcc.h:72:29: note: in expansion of macro '__PASTE'
>       72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
>          |                             ^~~~~~~
> >> include/linux/compiler_types.h:54:22: note: in expansion of macro '___PASTE'
>       54 | #define __PASTE(a,b) ___PASTE(a,b)
>          |                      ^~~~~~~~
>    include/linux/compiler-gcc.h:72:37: note: in expansion of macro '__PASTE'
>       72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
>          |                                     ^~~~~~~
> >> include/linux/pci.h:1929:26: note: in expansion of macro '__UNIQUE_ID'
>     1929 |       class_shift, hook, __UNIQUE_ID(hook))
>          |                          ^~~~~~~~~~~
>    include/linux/pci.h:1976:2: note: in expansion of macro 'DECLARE_PCI_FIXUP_SECTION'
>     1976 |  DECLARE_PCI_FIXUP_SECTION(.pci_fixup_header,   \
>          |  ^~~~~~~~~~~~~~~~~~~~~~~~~
> >> arch/x86/kernel/quirks.c:156:1: note: in expansion of macro 'DECLARE_PCI_FIXUP_HEADER'
>      156 | DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ESB2_0,
>          | ^~~~~~~~~~~~~~~~~~~~~~~~
> >> include/linux/compiler-gcc.h:72:45: warning: no previous prototype for '__UNIQUE_ID_ich_force_enable_hpet181' [-Wmissing-prototypes]
>       72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
>          |                                             ^~~~~~~~~~~~
>    include/linux/pci.h:1914:7: note: in definition of macro '___DECLARE_PCI_FIXUP_SECTION'
>     1914 |  void stub(struct pci_dev *dev) { hook(dev); }   \
>          |       ^~~~
> >> include/linux/pci.h:1928:2: note: in expansion of macro '__DECLARE_PCI_FIXUP_SECTION'
>     1928 |  __DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class, \
>          |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> >> include/linux/compiler_types.h:54:22: note: in expansion of macro '___PASTE'
>       54 | #define __PASTE(a,b) ___PASTE(a,b)
>          |                      ^~~~~~~~
> >> include/linux/compiler-gcc.h:72:29: note: in expansion of macro '__PASTE'
>       72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
>          |                             ^~~~~~~
> >> include/linux/compiler_types.h:54:22: note: in expansion of macro '___PASTE'
>       54 | #define __PASTE(a,b) ___PASTE(a,b)
>          |                      ^~~~~~~~
>    include/linux/compiler-gcc.h:72:37: note: in expansion of macro '__PASTE'
>       72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
>          |                                     ^~~~~~~
> >> include/linux/pci.h:1929:26: note: in expansion of macro '__UNIQUE_ID'
>     1929 |       class_shift, hook, __UNIQUE_ID(hook))
>          |                          ^~~~~~~~~~~
>    include/linux/pci.h:1976:2: note: in expansion of macro 'DECLARE_PCI_FIXUP_SECTION'
>     1976 |  DECLARE_PCI_FIXUP_SECTION(.pci_fixup_header,   \
>          |  ^~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/x86/kernel/quirks.c:158:1: note: in expansion of macro 'DECLARE_PCI_FIXUP_HEADER'
>      158 | DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_0,
>          | ^~~~~~~~~~~~~~~~~~~~~~~~
> >> include/linux/compiler-gcc.h:72:45: warning: no previous prototype for '__UNIQUE_ID_ich_force_enable_hpet182' [-Wmissing-prototypes]
>       72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
>          |                                             ^~~~~~~~~~~~
>    include/linux/pci.h:1914:7: note: in definition of macro '___DECLARE_PCI_FIXUP_SECTION'
>     1914 |  void stub(struct pci_dev *dev) { hook(dev); }   \
>          |       ^~~~
> >> include/linux/pci.h:1928:2: note: in expansion of macro '__DECLARE_PCI_FIXUP_SECTION'
>     1928 |  __DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class, \
>          |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> >> include/linux/compiler_types.h:54:22: note: in expansion of macro '___PASTE'
>       54 | #define __PASTE(a,b) ___PASTE(a,b)
>          |                      ^~~~~~~~
> >> include/linux/compiler-gcc.h:72:29: note: in expansion of macro '__PASTE'
>       72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
>          |                             ^~~~~~~
> >> include/linux/compiler_types.h:54:22: note: in expansion of macro '___PASTE'
>       54 | #define __PASTE(a,b) ___PASTE(a,b)
>          |                      ^~~~~~~~
>    include/linux/compiler-gcc.h:72:37: note: in expansion of macro '__PASTE'
>       72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
>          |                                     ^~~~~~~
> >> include/linux/pci.h:1929:26: note: in expansion of macro '__UNIQUE_ID'
>     1929 |       class_shift, hook, __UNIQUE_ID(hook))
>          |                          ^~~~~~~~~~~
>    include/linux/pci.h:1976:2: note: in expansion of macro 'DECLARE_PCI_FIXUP_SECTION'
>     1976 |  DECLARE_PCI_FIXUP_SECTION(.pci_fixup_header,   \
>          |  ^~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/x86/kernel/quirks.c:160:1: note: in expansion of macro 'DECLARE_PCI_FIXUP_HEADER'
>      160 | DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_1,
>          | ^~~~~~~~~~~~~~~~~~~~~~~~
> >> include/linux/compiler-gcc.h:72:45: warning: no previous prototype for '__UNIQUE_ID_ich_force_enable_hpet183' [-Wmissing-prototypes]
>       72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
>          |                                             ^~~~~~~~~~~~
>    include/linux/pci.h:1914:7: note: in definition of macro '___DECLARE_PCI_FIXUP_SECTION'
>     1914 |  void stub(struct pci_dev *dev) { hook(dev); }   \
>          |       ^~~~
>    include/linux/pci.h:1928:2: note: in expansion of macro '__DECLARE_PCI_FIXUP_SECTION'
>     1928 |  __DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class, \
>          |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/compiler_types.h:54:22: note: in expansion of macro '___PASTE'
>       54 | #define __PASTE(a,b) ___PASTE(a,b)
>          |                      ^~~~~~~~
>    include/linux/compiler-gcc.h:72:29: note: in expansion of macro '__PASTE'
>       72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
>          |                             ^~~~~~~
>    include/linux/compiler_types.h:54:22: note: in expansion of macro '___PASTE'
>       54 | #define __PASTE(a,b) ___PASTE(a,b)
>          |                      ^~~~~~~~
>    include/linux/compiler-gcc.h:72:37: note: in expansion of macro '__PASTE'
>       72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
>          |                                     ^~~~~~~
>    include/linux/pci.h:1929:26: note: in expansion of macro '__UNIQUE_ID'
>     1929 |       class_shift, hook, __UNIQUE_ID(hook))
>          |                          ^~~~~~~~~~~
>    include/linux/pci.h:1976:2: note: in expansion of macro 'DECLARE_PCI_FIXUP_SECTION'
>     1976 |  DECLARE_PCI_FIXUP_SECTION(.pci_fixup_header,   \
>          |  ^~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/x86/kernel/quirks.c:162:1: note: in expansion of macro 'DECLARE_PCI_FIXUP_HEADER'
>      162 | DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH7_0,
>          | ^~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/compiler-gcc.h:72:45: warning: no previous prototype for '__UNIQUE_ID_ich_force_enable_hpet184' [-Wmissing-prototypes]
>       72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
>          |                                             ^~~~~~~~~~~~
>    include/linux/pci.h:1914:7: note: in definition of macro '___DECLARE_PCI_FIXUP_SECTION'
>     1914 |  void stub(struct pci_dev *dev) { hook(dev); }   \
>          |       ^~~~
>    include/linux/pci.h:1928:2: note: in expansion of macro '__DECLARE_PCI_FIXUP_SECTION'
>     1928 |  __DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class, \
>          |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/compiler_types.h:54:22: note: in expansion of macro '___PASTE'
>       54 | #define __PASTE(a,b) ___PASTE(a,b)
>          |                      ^~~~~~~~
>    include/linux/compiler-gcc.h:72:29: note: in expansion of macro '__PASTE'
>       72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
>          |                             ^~~~~~~
>    include/linux/compiler_types.h:54:22: note: in expansion of macro '___PASTE'
>       54 | #define __PASTE(a,b) ___PASTE(a,b)
>          |                      ^~~~~~~~
>    include/linux/compiler-gcc.h:72:37: note: in expansion of macro '__PASTE'
>       72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
>          |                                     ^~~~~~~
>    include/linux/pci.h:1929:26: note: in expansion of macro '__UNIQUE_ID'
>     1929 |       class_shift, hook, __UNIQUE_ID(hook))
>          |                          ^~~~~~~~~~~
>    include/linux/pci.h:1976:2: note: in expansion of macro 'DECLARE_PCI_FIXUP_SECTION'
>     1976 |  DECLARE_PCI_FIXUP_SECTION(.pci_fixup_header,   \
>          |  ^~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/x86/kernel/quirks.c:164:1: note: in expansion of macro 'DECLARE_PCI_FIXUP_HEADER'
>      164 | DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH7_1,
>          | ^~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/compiler-gcc.h:72:45: warning: no previous prototype for '__UNIQUE_ID_ich_force_enable_hpet185' [-Wmissing-prototypes]
>       72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
>          |                                             ^~~~~~~~~~~~
>    include/linux/pci.h:1914:7: note: in definition of macro '___DECLARE_PCI_FIXUP_SECTION'
>     1914 |  void stub(struct pci_dev *dev) { hook(dev); }   \
>          |       ^~~~
>    include/linux/pci.h:1928:2: note: in expansion of macro '__DECLARE_PCI_FIXUP_SECTION'
>     1928 |  __DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class, \
>          |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/compiler_types.h:54:22: note: in expansion of macro '___PASTE'
>       54 | #define __PASTE(a,b) ___PASTE(a,b)
>          |                      ^~~~~~~~
>    include/linux/compiler-gcc.h:72:29: note: in expansion of macro '__PASTE'
>       72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
>          |                             ^~~~~~~
>    include/linux/compiler_types.h:54:22: note: in expansion of macro '___PASTE'
>       54 | #define __PASTE(a,b) ___PASTE(a,b)
>          |                      ^~~~~~~~
>    include/linux/compiler-gcc.h:72:37: note: in expansion of macro '__PASTE'
>       72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
>          |                                     ^~~~~~~
>    include/linux/pci.h:1929:26: note: in expansion of macro '__UNIQUE_ID'
>     1929 |       class_shift, hook, __UNIQUE_ID(hook))
>          |                          ^~~~~~~~~~~
>    include/linux/pci.h:1976:2: note: in expansion of macro 'DECLARE_PCI_FIXUP_SECTION'
>     1976 |  DECLARE_PCI_FIXUP_SECTION(.pci_fixup_header,   \
>          |  ^~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/x86/kernel/quirks.c:166:1: note: in expansion of macro 'DECLARE_PCI_FIXUP_HEADER'
>      166 | DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH7_31,
>          | ^~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/compiler-gcc.h:72:45: warning: no previous prototype for '__UNIQUE_ID_ich_force_enable_hpet186' [-Wmissing-prototypes]
>       72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
>          |                                             ^~~~~~~~~~~~
>    include/linux/pci.h:1914:7: note: in definition of macro '___DECLARE_PCI_FIXUP_SECTION'
>     1914 |  void stub(struct pci_dev *dev) { hook(dev); }   \
>          |       ^~~~
>    include/linux/pci.h:1928:2: note: in expansion of macro '__DECLARE_PCI_FIXUP_SECTION'
>     1928 |  __DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class, \
>          |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/compiler_types.h:54:22: note: in expansion of macro '___PASTE'
>       54 | #define __PASTE(a,b) ___PASTE(a,b)
> --
>    In file included from drivers/pci/vpd.c:8:
> >> include/linux/compiler-gcc.h:72:45: warning: no previous prototype for '__UNIQUE_ID_quirk_f0_vpd_link180' [-Wmissing-prototypes]
>       72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
>          |                                             ^~~~~~~~~~~~
>    include/linux/pci.h:1914:7: note: in definition of macro '___DECLARE_PCI_FIXUP_SECTION'
>     1914 |  void stub(struct pci_dev *dev) { hook(dev); }   \
>          |       ^~~~
> >> include/linux/pci.h:1928:2: note: in expansion of macro '__DECLARE_PCI_FIXUP_SECTION'
>     1928 |  __DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class, \
>          |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> >> include/linux/compiler_types.h:54:22: note: in expansion of macro '___PASTE'
>       54 | #define __PASTE(a,b) ___PASTE(a,b)
>          |                      ^~~~~~~~
> >> include/linux/compiler-gcc.h:72:29: note: in expansion of macro '__PASTE'
>       72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
>          |                             ^~~~~~~
> >> include/linux/compiler_types.h:54:22: note: in expansion of macro '___PASTE'
>       54 | #define __PASTE(a,b) ___PASTE(a,b)
>          |                      ^~~~~~~~
>    include/linux/compiler-gcc.h:72:37: note: in expansion of macro '__PASTE'
>       72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
>          |                                     ^~~~~~~
> >> include/linux/pci.h:1929:26: note: in expansion of macro '__UNIQUE_ID'
>     1929 |       class_shift, hook, __UNIQUE_ID(hook))
>          |                          ^~~~~~~~~~~
>    include/linux/pci.h:1941:2: note: in expansion of macro 'DECLARE_PCI_FIXUP_SECTION'
>     1941 |  DECLARE_PCI_FIXUP_SECTION(.pci_fixup_early,   \
>          |  ^~~~~~~~~~~~~~~~~~~~~~~~~
> >> drivers/pci/vpd.c:543:1: note: in expansion of macro 'DECLARE_PCI_FIXUP_CLASS_EARLY'
>      543 | DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_INTEL, PCI_ANY_ID,
>          | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >> include/linux/compiler-gcc.h:72:45: warning: no previous prototype for '__UNIQUE_ID_quirk_blacklist_vpd181' [-Wmissing-prototypes]
>       72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
>          |                                             ^~~~~~~~~~~~
>    include/linux/pci.h:1914:7: note: in definition of macro '___DECLARE_PCI_FIXUP_SECTION'
>     1914 |  void stub(struct pci_dev *dev) { hook(dev); }   \
>          |       ^~~~
> >> include/linux/pci.h:1928:2: note: in expansion of macro '__DECLARE_PCI_FIXUP_SECTION'
>     1928 |  __DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class, \
>          |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> >> include/linux/compiler_types.h:54:22: note: in expansion of macro '___PASTE'
>       54 | #define __PASTE(a,b) ___PASTE(a,b)
>          |                      ^~~~~~~~
> >> include/linux/compiler-gcc.h:72:29: note: in expansion of macro '__PASTE'
>       72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
>          |                             ^~~~~~~
> >> include/linux/compiler_types.h:54:22: note: in expansion of macro '___PASTE'
>       54 | #define __PASTE(a,b) ___PASTE(a,b)
>          |                      ^~~~~~~~
>    include/linux/compiler-gcc.h:72:37: note: in expansion of macro '__PASTE'
>       72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
>          |                                     ^~~~~~~
> >> include/linux/pci.h:1929:26: note: in expansion of macro '__UNIQUE_ID'
>     1929 |       class_shift, hook, __UNIQUE_ID(hook))
>          |                          ^~~~~~~~~~~
>    include/linux/pci.h:1979:2: note: in expansion of macro 'DECLARE_PCI_FIXUP_SECTION'
>     1979 |  DECLARE_PCI_FIXUP_SECTION(.pci_fixup_final,   \
>          |  ^~~~~~~~~~~~~~~~~~~~~~~~~
> >> drivers/pci/vpd.c:560:1: note: in expansion of macro 'DECLARE_PCI_FIXUP_FINAL'
>      560 | DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0060, quirk_blacklist_vpd);
>          | ^~~~~~~~~~~~~~~~~~~~~~~
> >> include/linux/compiler-gcc.h:72:45: warning: no previous prototype for '__UNIQUE_ID_quirk_blacklist_vpd182' [-Wmissing-prototypes]
>       72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
>          |                                             ^~~~~~~~~~~~
>    include/linux/pci.h:1914:7: note: in definition of macro '___DECLARE_PCI_FIXUP_SECTION'
>     1914 |  void stub(struct pci_dev *dev) { hook(dev); }   \
>          |       ^~~~
> >> include/linux/pci.h:1928:2: note: in expansion of macro '__DECLARE_PCI_FIXUP_SECTION'
>     1928 |  __DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class, \
>          |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> >> include/linux/compiler_types.h:54:22: note: in expansion of macro '___PASTE'
>       54 | #define __PASTE(a,b) ___PASTE(a,b)
>          |                      ^~~~~~~~
> >> include/linux/compiler-gcc.h:72:29: note: in expansion of macro '__PASTE'
>       72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
>          |                             ^~~~~~~
> >> include/linux/compiler_types.h:54:22: note: in expansion of macro '___PASTE'
>       54 | #define __PASTE(a,b) ___PASTE(a,b)
>          |                      ^~~~~~~~
>    include/linux/compiler-gcc.h:72:37: note: in expansion of macro '__PASTE'
>       72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
>          |                                     ^~~~~~~
> >> include/linux/pci.h:1929:26: note: in expansion of macro '__UNIQUE_ID'
>     1929 |       class_shift, hook, __UNIQUE_ID(hook))
>          |                          ^~~~~~~~~~~
>    include/linux/pci.h:1979:2: note: in expansion of macro 'DECLARE_PCI_FIXUP_SECTION'
>     1979 |  DECLARE_PCI_FIXUP_SECTION(.pci_fixup_final,   \
>          |  ^~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/pci/vpd.c:561:1: note: in expansion of macro 'DECLARE_PCI_FIXUP_FINAL'
>      561 | DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x007c, quirk_blacklist_vpd);
>          | ^~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/compiler-gcc.h:72:45: warning: no previous prototype for '__UNIQUE_ID_quirk_blacklist_vpd183' [-Wmissing-prototypes]
>       72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
>          |                                             ^~~~~~~~~~~~
>    include/linux/pci.h:1914:7: note: in definition of macro '___DECLARE_PCI_FIXUP_SECTION'
>     1914 |  void stub(struct pci_dev *dev) { hook(dev); }   \
>          |       ^~~~
>    include/linux/pci.h:1928:2: note: in expansion of macro '__DECLARE_PCI_FIXUP_SECTION'
>     1928 |  __DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class, \
>          |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/compiler_types.h:54:22: note: in expansion of macro '___PASTE'
>       54 | #define __PASTE(a,b) ___PASTE(a,b)
>          |                      ^~~~~~~~
>    include/linux/compiler-gcc.h:72:29: note: in expansion of macro '__PASTE'
>       72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
>          |                             ^~~~~~~
>    include/linux/compiler_types.h:54:22: note: in expansion of macro '___PASTE'
>       54 | #define __PASTE(a,b) ___PASTE(a,b)
>          |                      ^~~~~~~~
>    include/linux/compiler-gcc.h:72:37: note: in expansion of macro '__PASTE'
>       72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
>          |                                     ^~~~~~~
>    include/linux/pci.h:1929:26: note: in expansion of macro '__UNIQUE_ID'
>     1929 |       class_shift, hook, __UNIQUE_ID(hook))
>          |                          ^~~~~~~~~~~
>    include/linux/pci.h:1979:2: note: in expansion of macro 'DECLARE_PCI_FIXUP_SECTION'
>     1979 |  DECLARE_PCI_FIXUP_SECTION(.pci_fixup_final,   \
>          |  ^~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/pci/vpd.c:562:1: note: in expansion of macro 'DECLARE_PCI_FIXUP_FINAL'
>      562 | DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0413, quirk_blacklist_vpd);
>          | ^~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/compiler-gcc.h:72:45: warning: no previous prototype for '__UNIQUE_ID_quirk_blacklist_vpd184' [-Wmissing-prototypes]
>       72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
>          |                                             ^~~~~~~~~~~~
>    include/linux/pci.h:1914:7: note: in definition of macro '___DECLARE_PCI_FIXUP_SECTION'
>     1914 |  void stub(struct pci_dev *dev) { hook(dev); }   \
>          |       ^~~~
>    include/linux/pci.h:1928:2: note: in expansion of macro '__DECLARE_PCI_FIXUP_SECTION'
>     1928 |  __DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class, \
>          |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/compiler_types.h:54:22: note: in expansion of macro '___PASTE'
>       54 | #define __PASTE(a,b) ___PASTE(a,b)
>          |                      ^~~~~~~~
>    include/linux/compiler-gcc.h:72:29: note: in expansion of macro '__PASTE'
>       72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
>          |                             ^~~~~~~
>    include/linux/compiler_types.h:54:22: note: in expansion of macro '___PASTE'
>       54 | #define __PASTE(a,b) ___PASTE(a,b)
>          |                      ^~~~~~~~
>    include/linux/compiler-gcc.h:72:37: note: in expansion of macro '__PASTE'
>       72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
>          |                                     ^~~~~~~
>    include/linux/pci.h:1929:26: note: in expansion of macro '__UNIQUE_ID'
>     1929 |       class_shift, hook, __UNIQUE_ID(hook))
>          |                          ^~~~~~~~~~~
>    include/linux/pci.h:1979:2: note: in expansion of macro 'DECLARE_PCI_FIXUP_SECTION'
>     1979 |  DECLARE_PCI_FIXUP_SECTION(.pci_fixup_final,   \
>          |  ^~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/pci/vpd.c:563:1: note: in expansion of macro 'DECLARE_PCI_FIXUP_FINAL'
>      563 | DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0078, quirk_blacklist_vpd);
>          | ^~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/compiler-gcc.h:72:45: warning: no previous prototype for '__UNIQUE_ID_quirk_blacklist_vpd185' [-Wmissing-prototypes]
>       72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
>          |                                             ^~~~~~~~~~~~
>    include/linux/pci.h:1914:7: note: in definition of macro '___DECLARE_PCI_FIXUP_SECTION'
>     1914 |  void stub(struct pci_dev *dev) { hook(dev); }   \
>          |       ^~~~
>    include/linux/pci.h:1928:2: note: in expansion of macro '__DECLARE_PCI_FIXUP_SECTION'
>     1928 |  __DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class, \
>          |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/compiler_types.h:54:22: note: in expansion of macro '___PASTE'
>       54 | #define __PASTE(a,b) ___PASTE(a,b)
>          |                      ^~~~~~~~
>    include/linux/compiler-gcc.h:72:29: note: in expansion of macro '__PASTE'
>       72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
>          |                             ^~~~~~~
>    include/linux/compiler_types.h:54:22: note: in expansion of macro '___PASTE'
>       54 | #define __PASTE(a,b) ___PASTE(a,b)
>          |                      ^~~~~~~~
>    include/linux/compiler-gcc.h:72:37: note: in expansion of macro '__PASTE'
>       72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
>          |                                     ^~~~~~~
>    include/linux/pci.h:1929:26: note: in expansion of macro '__UNIQUE_ID'
>     1929 |       class_shift, hook, __UNIQUE_ID(hook))
>          |                          ^~~~~~~~~~~
>    include/linux/pci.h:1979:2: note: in expansion of macro 'DECLARE_PCI_FIXUP_SECTION'
>     1979 |  DECLARE_PCI_FIXUP_SECTION(.pci_fixup_final,   \
>          |  ^~~~~~~~~~~~~~~~~~~~~~~~~
>    drivers/pci/vpd.c:564:1: note: in expansion of macro 'DECLARE_PCI_FIXUP_FINAL'
>      564 | DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0079, quirk_blacklist_vpd);
>          | ^~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/compiler-gcc.h:72:45: warning: no previous prototype for '__UNIQUE_ID_quirk_blacklist_vpd186' [-Wmissing-prototypes]
>       72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
> ..
>
> vim +/__DECLARE_PCI_FIXUP_SECTION +1928 include/linux/pci.h
>
> ^1da177e4c3f415 Linus Torvalds 2005-04-16  1910
> c9d8b55fa019162 Ard Biesheuvel 2018-08-21  1911  #ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
> b1b820bb0420d08 Sami Tolvanen  2020-06-24  1912  #define ___DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class, \
> b1b820bb0420d08 Sami Tolvanen  2020-06-24  1913                                     class_shift, hook, stub)            \
> b1b820bb0420d08 Sami Tolvanen  2020-06-24 @1914         void stub(struct pci_dev *dev) { hook(dev); }                   \
> c9d8b55fa019162 Ard Biesheuvel 2018-08-21  1915         asm(".section " #sec ", \"a\"                           \n"     \
> c9d8b55fa019162 Ard Biesheuvel 2018-08-21  1916             ".balign    16                                      \n"     \
> c9d8b55fa019162 Ard Biesheuvel 2018-08-21  1917             ".short "   #vendor ", " #device "                  \n"     \
> c9d8b55fa019162 Ard Biesheuvel 2018-08-21  1918             ".long "    #class ", " #class_shift "              \n"     \
> b1b820bb0420d08 Sami Tolvanen  2020-06-24  1919             ".long "    #stub " - .                             \n"     \
> c9d8b55fa019162 Ard Biesheuvel 2018-08-21  1920             ".previous                                          \n");
> b1b820bb0420d08 Sami Tolvanen  2020-06-24  1921
> b1b820bb0420d08 Sami Tolvanen  2020-06-24  1922  #define __DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class,  \
> b1b820bb0420d08 Sami Tolvanen  2020-06-24  1923                                   class_shift, hook, stub)              \
> b1b820bb0420d08 Sami Tolvanen  2020-06-24  1924         ___DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class,  \
> b1b820bb0420d08 Sami Tolvanen  2020-06-24  1925                                   class_shift, hook, stub)
> c9d8b55fa019162 Ard Biesheuvel 2018-08-21  1926  #define DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class,    \
> c9d8b55fa019162 Ard Biesheuvel 2018-08-21  1927                                   class_shift, hook)                    \
> c9d8b55fa019162 Ard Biesheuvel 2018-08-21 @1928         __DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class,   \
> b1b820bb0420d08 Sami Tolvanen  2020-06-24 @1929                                   class_shift, hook, __UNIQUE_ID(hook))
> c9d8b55fa019162 Ard Biesheuvel 2018-08-21  1930  #else
> ^1da177e4c3f415 Linus Torvalds 2005-04-16  1931  /* Anonymous variables would be nice... */
> f4ca5c6a56278ca Yinghai Lu     2012-02-23  1932  #define DECLARE_PCI_FIXUP_SECTION(section, name, vendor, device, class,        \
> f4ca5c6a56278ca Yinghai Lu     2012-02-23  1933                                   class_shift, hook)                    \
> ecf61c78bd787b9 Michal Marek   2013-11-11  1934         static const struct pci_fixup __PASTE(__pci_fixup_##name,__LINE__) __used       \
> f4ca5c6a56278ca Yinghai Lu     2012-02-23  1935         __attribute__((__section__(#section), aligned((sizeof(void *)))))    \
> f4ca5c6a56278ca Yinghai Lu     2012-02-23  1936                 = { vendor, device, class, class_shift, hook };
> c9d8b55fa019162 Ard Biesheuvel 2018-08-21  1937  #endif
> f4ca5c6a56278ca Yinghai Lu     2012-02-23  1938
> f4ca5c6a56278ca Yinghai Lu     2012-02-23  1939  #define DECLARE_PCI_FIXUP_CLASS_EARLY(vendor, device, class,           \
> f4ca5c6a56278ca Yinghai Lu     2012-02-23  1940                                          class_shift, hook)             \
> f4ca5c6a56278ca Yinghai Lu     2012-02-23  1941         DECLARE_PCI_FIXUP_SECTION(.pci_fixup_early,                     \
> ecf61c78bd787b9 Michal Marek   2013-11-11  1942                 hook, vendor, device, class, class_shift, hook)
> f4ca5c6a56278ca Yinghai Lu     2012-02-23  1943  #define DECLARE_PCI_FIXUP_CLASS_HEADER(vendor, device, class,          \
> f4ca5c6a56278ca Yinghai Lu     2012-02-23  1944                                          class_shift, hook)             \
> f4ca5c6a56278ca Yinghai Lu     2012-02-23  1945         DECLARE_PCI_FIXUP_SECTION(.pci_fixup_header,                    \
> ecf61c78bd787b9 Michal Marek   2013-11-11  1946                 hook, vendor, device, class, class_shift, hook)
> f4ca5c6a56278ca Yinghai Lu     2012-02-23  1947  #define DECLARE_PCI_FIXUP_CLASS_FINAL(vendor, device, class,           \
> f4ca5c6a56278ca Yinghai Lu     2012-02-23  1948                                          class_shift, hook)             \
> f4ca5c6a56278ca Yinghai Lu     2012-02-23 @1949         DECLARE_PCI_FIXUP_SECTION(.pci_fixup_final,                     \
> ecf61c78bd787b9 Michal Marek   2013-11-11  1950                 hook, vendor, device, class, class_shift, hook)
> f4ca5c6a56278ca Yinghai Lu     2012-02-23  1951  #define DECLARE_PCI_FIXUP_CLASS_ENABLE(vendor, device, class,          \
> f4ca5c6a56278ca Yinghai Lu     2012-02-23  1952                                          class_shift, hook)             \
> f4ca5c6a56278ca Yinghai Lu     2012-02-23  1953         DECLARE_PCI_FIXUP_SECTION(.pci_fixup_enable,                    \
> ecf61c78bd787b9 Michal Marek   2013-11-11  1954                 hook, vendor, device, class, class_shift, hook)
> f4ca5c6a56278ca Yinghai Lu     2012-02-23  1955  #define DECLARE_PCI_FIXUP_CLASS_RESUME(vendor, device, class,          \
> f4ca5c6a56278ca Yinghai Lu     2012-02-23  1956                                          class_shift, hook)             \
> f4ca5c6a56278ca Yinghai Lu     2012-02-23  1957         DECLARE_PCI_FIXUP_SECTION(.pci_fixup_resume,                    \
> 0aa0f5d1084ca1c Bjorn Helgaas  2017-12-02  1958                 resume##hook, vendor, device, class, class_shift, hook)
> f4ca5c6a56278ca Yinghai Lu     2012-02-23  1959  #define DECLARE_PCI_FIXUP_CLASS_RESUME_EARLY(vendor, device, class,    \
> f4ca5c6a56278ca Yinghai Lu     2012-02-23  1960                                          class_shift, hook)             \
> f4ca5c6a56278ca Yinghai Lu     2012-02-23  1961         DECLARE_PCI_FIXUP_SECTION(.pci_fixup_resume_early,              \
> 0aa0f5d1084ca1c Bjorn Helgaas  2017-12-02  1962                 resume_early##hook, vendor, device, class, class_shift, hook)
> f4ca5c6a56278ca Yinghai Lu     2012-02-23  1963  #define DECLARE_PCI_FIXUP_CLASS_SUSPEND(vendor, device, class,         \
> f4ca5c6a56278ca Yinghai Lu     2012-02-23  1964                                          class_shift, hook)             \
> f4ca5c6a56278ca Yinghai Lu     2012-02-23  1965         DECLARE_PCI_FIXUP_SECTION(.pci_fixup_suspend,                   \
> 0aa0f5d1084ca1c Bjorn Helgaas  2017-12-02  1966                 suspend##hook, vendor, device, class, class_shift, hook)
> 7d2a01b87f1682f Andreas Noever 2014-06-03  1967  #define DECLARE_PCI_FIXUP_CLASS_SUSPEND_LATE(vendor, device, class,    \
> 7d2a01b87f1682f Andreas Noever 2014-06-03  1968                                          class_shift, hook)             \
> 7d2a01b87f1682f Andreas Noever 2014-06-03  1969         DECLARE_PCI_FIXUP_SECTION(.pci_fixup_suspend_late,              \
> 0aa0f5d1084ca1c Bjorn Helgaas  2017-12-02  1970                 suspend_late##hook, vendor, device, class, class_shift, hook)
> f4ca5c6a56278ca Yinghai Lu     2012-02-23  1971
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org



-- 
Thanks,
~Nick Desaulniers
