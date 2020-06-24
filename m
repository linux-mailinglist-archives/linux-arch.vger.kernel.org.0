Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA4A5209694
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jun 2020 00:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgFXWvH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 24 Jun 2020 18:51:07 -0400
Received: from mga09.intel.com ([134.134.136.24]:1047 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728697AbgFXWvB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 24 Jun 2020 18:51:01 -0400
IronPort-SDR: kpuR8QQ6dOxHhr7tfAPWO4mxvfXtc4Gun48UgDbkUR/itta46ENBVNZJ54aIAO9YZwoyA3BIFH
 eK3k3S++LyWw==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="146160046"
X-IronPort-AV: E=Sophos;i="5.75,276,1589266800"; 
   d="gz'50?scan'50,208,50";a="146160046"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2020 15:50:43 -0700
IronPort-SDR: guWFvbLs4yg1H64Ee8XKxT+jONgpTdJojjD/N/XerbaRpNpcvv/J7FNX5hYPRh3JESLMOWCznN
 W9qfA7vqPgCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,276,1589266800"; 
   d="gz'50?scan'50,208,50";a="354281356"
Received: from lkp-server01.sh.intel.com (HELO 538b5e3c8319) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 24 Jun 2020 15:50:39 -0700
Received: from kbuild by 538b5e3c8319 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1joEE3-0001B8-82; Wed, 24 Jun 2020 22:50:39 +0000
Date:   Thu, 25 Jun 2020 06:49:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>
Cc:     kbuild-all@lists.01.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 11/22] pci: lto: fix PREL32 relocations
Message-ID: <202006250618.DQj64eMK%lkp@intel.com>
References: <20200624203200.78870-12-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
In-Reply-To: <20200624203200.78870-12-samitolvanen@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Sami,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on 26e122e97a3d0390ebec389347f64f3730fdf48f]

url:    https://github.com/0day-ci/linux/commits/Sami-Tolvanen/add-support-for-Clang-LTO/20200625-043816
base:    26e122e97a3d0390ebec389347f64f3730fdf48f
config: i386-alldefconfig (attached as .config)
compiler: gcc-9 (Debian 9.3.0-13) 9.3.0
reproduce (this is a W=1 build):
        # save the attached .config to linux build tree
        make W=1 ARCH=i386 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from arch/x86/kernel/pci-dma.c:9:
>> include/linux/compiler-gcc.h:72:45: warning: no previous prototype for '__UNIQUE_ID_via_no_dac190' [-Wmissing-prototypes]
      72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                             ^~~~~~~~~~~~
   include/linux/pci.h:1914:7: note: in definition of macro '___DECLARE_PCI_FIXUP_SECTION'
    1914 |  void stub(struct pci_dev *dev) { hook(dev); }   \
         |       ^~~~
>> include/linux/pci.h:1928:2: note: in expansion of macro '__DECLARE_PCI_FIXUP_SECTION'
    1928 |  __DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class, \
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/compiler_types.h:54:22: note: in expansion of macro '___PASTE'
      54 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
>> include/linux/compiler-gcc.h:72:29: note: in expansion of macro '__PASTE'
      72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                             ^~~~~~~
>> include/linux/compiler_types.h:54:22: note: in expansion of macro '___PASTE'
      54 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/compiler-gcc.h:72:37: note: in expansion of macro '__PASTE'
      72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                     ^~~~~~~
>> include/linux/pci.h:1929:26: note: in expansion of macro '__UNIQUE_ID'
    1929 |       class_shift, hook, __UNIQUE_ID(hook))
         |                          ^~~~~~~~~~~
>> include/linux/pci.h:1949:2: note: in expansion of macro 'DECLARE_PCI_FIXUP_SECTION'
    1949 |  DECLARE_PCI_FIXUP_SECTION(.pci_fixup_final,   \
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/x86/kernel/pci-dma.c:154:1: note: in expansion of macro 'DECLARE_PCI_FIXUP_CLASS_FINAL'
     154 | DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_VIA, PCI_ANY_ID,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from arch/x86/kernel/quirks.c:6:
>> include/linux/compiler-gcc.h:72:45: warning: no previous prototype for '__UNIQUE_ID_ich_force_enable_hpet180' [-Wmissing-prototypes]
      72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                             ^~~~~~~~~~~~
   include/linux/pci.h:1914:7: note: in definition of macro '___DECLARE_PCI_FIXUP_SECTION'
    1914 |  void stub(struct pci_dev *dev) { hook(dev); }   \
         |       ^~~~
>> include/linux/pci.h:1928:2: note: in expansion of macro '__DECLARE_PCI_FIXUP_SECTION'
    1928 |  __DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class, \
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/compiler_types.h:54:22: note: in expansion of macro '___PASTE'
      54 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
>> include/linux/compiler-gcc.h:72:29: note: in expansion of macro '__PASTE'
      72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                             ^~~~~~~
>> include/linux/compiler_types.h:54:22: note: in expansion of macro '___PASTE'
      54 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/compiler-gcc.h:72:37: note: in expansion of macro '__PASTE'
      72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                     ^~~~~~~
>> include/linux/pci.h:1929:26: note: in expansion of macro '__UNIQUE_ID'
    1929 |       class_shift, hook, __UNIQUE_ID(hook))
         |                          ^~~~~~~~~~~
   include/linux/pci.h:1976:2: note: in expansion of macro 'DECLARE_PCI_FIXUP_SECTION'
    1976 |  DECLARE_PCI_FIXUP_SECTION(.pci_fixup_header,   \
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/x86/kernel/quirks.c:156:1: note: in expansion of macro 'DECLARE_PCI_FIXUP_HEADER'
     156 | DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ESB2_0,
         | ^~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/compiler-gcc.h:72:45: warning: no previous prototype for '__UNIQUE_ID_ich_force_enable_hpet181' [-Wmissing-prototypes]
      72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                             ^~~~~~~~~~~~
   include/linux/pci.h:1914:7: note: in definition of macro '___DECLARE_PCI_FIXUP_SECTION'
    1914 |  void stub(struct pci_dev *dev) { hook(dev); }   \
         |       ^~~~
>> include/linux/pci.h:1928:2: note: in expansion of macro '__DECLARE_PCI_FIXUP_SECTION'
    1928 |  __DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class, \
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/compiler_types.h:54:22: note: in expansion of macro '___PASTE'
      54 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
>> include/linux/compiler-gcc.h:72:29: note: in expansion of macro '__PASTE'
      72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                             ^~~~~~~
>> include/linux/compiler_types.h:54:22: note: in expansion of macro '___PASTE'
      54 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/compiler-gcc.h:72:37: note: in expansion of macro '__PASTE'
      72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                     ^~~~~~~
>> include/linux/pci.h:1929:26: note: in expansion of macro '__UNIQUE_ID'
    1929 |       class_shift, hook, __UNIQUE_ID(hook))
         |                          ^~~~~~~~~~~
   include/linux/pci.h:1976:2: note: in expansion of macro 'DECLARE_PCI_FIXUP_SECTION'
    1976 |  DECLARE_PCI_FIXUP_SECTION(.pci_fixup_header,   \
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/quirks.c:158:1: note: in expansion of macro 'DECLARE_PCI_FIXUP_HEADER'
     158 | DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_0,
         | ^~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/compiler-gcc.h:72:45: warning: no previous prototype for '__UNIQUE_ID_ich_force_enable_hpet182' [-Wmissing-prototypes]
      72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                             ^~~~~~~~~~~~
   include/linux/pci.h:1914:7: note: in definition of macro '___DECLARE_PCI_FIXUP_SECTION'
    1914 |  void stub(struct pci_dev *dev) { hook(dev); }   \
         |       ^~~~
>> include/linux/pci.h:1928:2: note: in expansion of macro '__DECLARE_PCI_FIXUP_SECTION'
    1928 |  __DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class, \
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/compiler_types.h:54:22: note: in expansion of macro '___PASTE'
      54 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
>> include/linux/compiler-gcc.h:72:29: note: in expansion of macro '__PASTE'
      72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                             ^~~~~~~
>> include/linux/compiler_types.h:54:22: note: in expansion of macro '___PASTE'
      54 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/compiler-gcc.h:72:37: note: in expansion of macro '__PASTE'
      72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                     ^~~~~~~
>> include/linux/pci.h:1929:26: note: in expansion of macro '__UNIQUE_ID'
    1929 |       class_shift, hook, __UNIQUE_ID(hook))
         |                          ^~~~~~~~~~~
   include/linux/pci.h:1976:2: note: in expansion of macro 'DECLARE_PCI_FIXUP_SECTION'
    1976 |  DECLARE_PCI_FIXUP_SECTION(.pci_fixup_header,   \
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/quirks.c:160:1: note: in expansion of macro 'DECLARE_PCI_FIXUP_HEADER'
     160 | DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_1,
         | ^~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/compiler-gcc.h:72:45: warning: no previous prototype for '__UNIQUE_ID_ich_force_enable_hpet183' [-Wmissing-prototypes]
      72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                             ^~~~~~~~~~~~
   include/linux/pci.h:1914:7: note: in definition of macro '___DECLARE_PCI_FIXUP_SECTION'
    1914 |  void stub(struct pci_dev *dev) { hook(dev); }   \
         |       ^~~~
   include/linux/pci.h:1928:2: note: in expansion of macro '__DECLARE_PCI_FIXUP_SECTION'
    1928 |  __DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class, \
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:54:22: note: in expansion of macro '___PASTE'
      54 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/compiler-gcc.h:72:29: note: in expansion of macro '__PASTE'
      72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                             ^~~~~~~
   include/linux/compiler_types.h:54:22: note: in expansion of macro '___PASTE'
      54 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/compiler-gcc.h:72:37: note: in expansion of macro '__PASTE'
      72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                     ^~~~~~~
   include/linux/pci.h:1929:26: note: in expansion of macro '__UNIQUE_ID'
    1929 |       class_shift, hook, __UNIQUE_ID(hook))
         |                          ^~~~~~~~~~~
   include/linux/pci.h:1976:2: note: in expansion of macro 'DECLARE_PCI_FIXUP_SECTION'
    1976 |  DECLARE_PCI_FIXUP_SECTION(.pci_fixup_header,   \
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/quirks.c:162:1: note: in expansion of macro 'DECLARE_PCI_FIXUP_HEADER'
     162 | DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH7_0,
         | ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler-gcc.h:72:45: warning: no previous prototype for '__UNIQUE_ID_ich_force_enable_hpet184' [-Wmissing-prototypes]
      72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                             ^~~~~~~~~~~~
   include/linux/pci.h:1914:7: note: in definition of macro '___DECLARE_PCI_FIXUP_SECTION'
    1914 |  void stub(struct pci_dev *dev) { hook(dev); }   \
         |       ^~~~
   include/linux/pci.h:1928:2: note: in expansion of macro '__DECLARE_PCI_FIXUP_SECTION'
    1928 |  __DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class, \
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:54:22: note: in expansion of macro '___PASTE'
      54 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/compiler-gcc.h:72:29: note: in expansion of macro '__PASTE'
      72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                             ^~~~~~~
   include/linux/compiler_types.h:54:22: note: in expansion of macro '___PASTE'
      54 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/compiler-gcc.h:72:37: note: in expansion of macro '__PASTE'
      72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                     ^~~~~~~
   include/linux/pci.h:1929:26: note: in expansion of macro '__UNIQUE_ID'
    1929 |       class_shift, hook, __UNIQUE_ID(hook))
         |                          ^~~~~~~~~~~
   include/linux/pci.h:1976:2: note: in expansion of macro 'DECLARE_PCI_FIXUP_SECTION'
    1976 |  DECLARE_PCI_FIXUP_SECTION(.pci_fixup_header,   \
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/quirks.c:164:1: note: in expansion of macro 'DECLARE_PCI_FIXUP_HEADER'
     164 | DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH7_1,
         | ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler-gcc.h:72:45: warning: no previous prototype for '__UNIQUE_ID_ich_force_enable_hpet185' [-Wmissing-prototypes]
      72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                             ^~~~~~~~~~~~
   include/linux/pci.h:1914:7: note: in definition of macro '___DECLARE_PCI_FIXUP_SECTION'
    1914 |  void stub(struct pci_dev *dev) { hook(dev); }   \
         |       ^~~~
   include/linux/pci.h:1928:2: note: in expansion of macro '__DECLARE_PCI_FIXUP_SECTION'
    1928 |  __DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class, \
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:54:22: note: in expansion of macro '___PASTE'
      54 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/compiler-gcc.h:72:29: note: in expansion of macro '__PASTE'
      72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                             ^~~~~~~
   include/linux/compiler_types.h:54:22: note: in expansion of macro '___PASTE'
      54 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/compiler-gcc.h:72:37: note: in expansion of macro '__PASTE'
      72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                     ^~~~~~~
   include/linux/pci.h:1929:26: note: in expansion of macro '__UNIQUE_ID'
    1929 |       class_shift, hook, __UNIQUE_ID(hook))
         |                          ^~~~~~~~~~~
   include/linux/pci.h:1976:2: note: in expansion of macro 'DECLARE_PCI_FIXUP_SECTION'
    1976 |  DECLARE_PCI_FIXUP_SECTION(.pci_fixup_header,   \
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/kernel/quirks.c:166:1: note: in expansion of macro 'DECLARE_PCI_FIXUP_HEADER'
     166 | DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH7_31,
         | ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler-gcc.h:72:45: warning: no previous prototype for '__UNIQUE_ID_ich_force_enable_hpet186' [-Wmissing-prototypes]
      72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                             ^~~~~~~~~~~~
   include/linux/pci.h:1914:7: note: in definition of macro '___DECLARE_PCI_FIXUP_SECTION'
    1914 |  void stub(struct pci_dev *dev) { hook(dev); }   \
         |       ^~~~
   include/linux/pci.h:1928:2: note: in expansion of macro '__DECLARE_PCI_FIXUP_SECTION'
    1928 |  __DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class, \
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:54:22: note: in expansion of macro '___PASTE'
      54 | #define __PASTE(a,b) ___PASTE(a,b)
--
   In file included from drivers/pci/vpd.c:8:
>> include/linux/compiler-gcc.h:72:45: warning: no previous prototype for '__UNIQUE_ID_quirk_f0_vpd_link180' [-Wmissing-prototypes]
      72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                             ^~~~~~~~~~~~
   include/linux/pci.h:1914:7: note: in definition of macro '___DECLARE_PCI_FIXUP_SECTION'
    1914 |  void stub(struct pci_dev *dev) { hook(dev); }   \
         |       ^~~~
>> include/linux/pci.h:1928:2: note: in expansion of macro '__DECLARE_PCI_FIXUP_SECTION'
    1928 |  __DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class, \
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/compiler_types.h:54:22: note: in expansion of macro '___PASTE'
      54 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
>> include/linux/compiler-gcc.h:72:29: note: in expansion of macro '__PASTE'
      72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                             ^~~~~~~
>> include/linux/compiler_types.h:54:22: note: in expansion of macro '___PASTE'
      54 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/compiler-gcc.h:72:37: note: in expansion of macro '__PASTE'
      72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                     ^~~~~~~
>> include/linux/pci.h:1929:26: note: in expansion of macro '__UNIQUE_ID'
    1929 |       class_shift, hook, __UNIQUE_ID(hook))
         |                          ^~~~~~~~~~~
   include/linux/pci.h:1941:2: note: in expansion of macro 'DECLARE_PCI_FIXUP_SECTION'
    1941 |  DECLARE_PCI_FIXUP_SECTION(.pci_fixup_early,   \
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/pci/vpd.c:543:1: note: in expansion of macro 'DECLARE_PCI_FIXUP_CLASS_EARLY'
     543 | DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_INTEL, PCI_ANY_ID,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/compiler-gcc.h:72:45: warning: no previous prototype for '__UNIQUE_ID_quirk_blacklist_vpd181' [-Wmissing-prototypes]
      72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                             ^~~~~~~~~~~~
   include/linux/pci.h:1914:7: note: in definition of macro '___DECLARE_PCI_FIXUP_SECTION'
    1914 |  void stub(struct pci_dev *dev) { hook(dev); }   \
         |       ^~~~
>> include/linux/pci.h:1928:2: note: in expansion of macro '__DECLARE_PCI_FIXUP_SECTION'
    1928 |  __DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class, \
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/compiler_types.h:54:22: note: in expansion of macro '___PASTE'
      54 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
>> include/linux/compiler-gcc.h:72:29: note: in expansion of macro '__PASTE'
      72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                             ^~~~~~~
>> include/linux/compiler_types.h:54:22: note: in expansion of macro '___PASTE'
      54 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/compiler-gcc.h:72:37: note: in expansion of macro '__PASTE'
      72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                     ^~~~~~~
>> include/linux/pci.h:1929:26: note: in expansion of macro '__UNIQUE_ID'
    1929 |       class_shift, hook, __UNIQUE_ID(hook))
         |                          ^~~~~~~~~~~
   include/linux/pci.h:1979:2: note: in expansion of macro 'DECLARE_PCI_FIXUP_SECTION'
    1979 |  DECLARE_PCI_FIXUP_SECTION(.pci_fixup_final,   \
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/pci/vpd.c:560:1: note: in expansion of macro 'DECLARE_PCI_FIXUP_FINAL'
     560 | DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0060, quirk_blacklist_vpd);
         | ^~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/compiler-gcc.h:72:45: warning: no previous prototype for '__UNIQUE_ID_quirk_blacklist_vpd182' [-Wmissing-prototypes]
      72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                             ^~~~~~~~~~~~
   include/linux/pci.h:1914:7: note: in definition of macro '___DECLARE_PCI_FIXUP_SECTION'
    1914 |  void stub(struct pci_dev *dev) { hook(dev); }   \
         |       ^~~~
>> include/linux/pci.h:1928:2: note: in expansion of macro '__DECLARE_PCI_FIXUP_SECTION'
    1928 |  __DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class, \
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/compiler_types.h:54:22: note: in expansion of macro '___PASTE'
      54 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
>> include/linux/compiler-gcc.h:72:29: note: in expansion of macro '__PASTE'
      72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                             ^~~~~~~
>> include/linux/compiler_types.h:54:22: note: in expansion of macro '___PASTE'
      54 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/compiler-gcc.h:72:37: note: in expansion of macro '__PASTE'
      72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                     ^~~~~~~
>> include/linux/pci.h:1929:26: note: in expansion of macro '__UNIQUE_ID'
    1929 |       class_shift, hook, __UNIQUE_ID(hook))
         |                          ^~~~~~~~~~~
   include/linux/pci.h:1979:2: note: in expansion of macro 'DECLARE_PCI_FIXUP_SECTION'
    1979 |  DECLARE_PCI_FIXUP_SECTION(.pci_fixup_final,   \
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pci/vpd.c:561:1: note: in expansion of macro 'DECLARE_PCI_FIXUP_FINAL'
     561 | DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x007c, quirk_blacklist_vpd);
         | ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler-gcc.h:72:45: warning: no previous prototype for '__UNIQUE_ID_quirk_blacklist_vpd183' [-Wmissing-prototypes]
      72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                             ^~~~~~~~~~~~
   include/linux/pci.h:1914:7: note: in definition of macro '___DECLARE_PCI_FIXUP_SECTION'
    1914 |  void stub(struct pci_dev *dev) { hook(dev); }   \
         |       ^~~~
   include/linux/pci.h:1928:2: note: in expansion of macro '__DECLARE_PCI_FIXUP_SECTION'
    1928 |  __DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class, \
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:54:22: note: in expansion of macro '___PASTE'
      54 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/compiler-gcc.h:72:29: note: in expansion of macro '__PASTE'
      72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                             ^~~~~~~
   include/linux/compiler_types.h:54:22: note: in expansion of macro '___PASTE'
      54 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/compiler-gcc.h:72:37: note: in expansion of macro '__PASTE'
      72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                     ^~~~~~~
   include/linux/pci.h:1929:26: note: in expansion of macro '__UNIQUE_ID'
    1929 |       class_shift, hook, __UNIQUE_ID(hook))
         |                          ^~~~~~~~~~~
   include/linux/pci.h:1979:2: note: in expansion of macro 'DECLARE_PCI_FIXUP_SECTION'
    1979 |  DECLARE_PCI_FIXUP_SECTION(.pci_fixup_final,   \
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pci/vpd.c:562:1: note: in expansion of macro 'DECLARE_PCI_FIXUP_FINAL'
     562 | DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0413, quirk_blacklist_vpd);
         | ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler-gcc.h:72:45: warning: no previous prototype for '__UNIQUE_ID_quirk_blacklist_vpd184' [-Wmissing-prototypes]
      72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                             ^~~~~~~~~~~~
   include/linux/pci.h:1914:7: note: in definition of macro '___DECLARE_PCI_FIXUP_SECTION'
    1914 |  void stub(struct pci_dev *dev) { hook(dev); }   \
         |       ^~~~
   include/linux/pci.h:1928:2: note: in expansion of macro '__DECLARE_PCI_FIXUP_SECTION'
    1928 |  __DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class, \
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:54:22: note: in expansion of macro '___PASTE'
      54 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/compiler-gcc.h:72:29: note: in expansion of macro '__PASTE'
      72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                             ^~~~~~~
   include/linux/compiler_types.h:54:22: note: in expansion of macro '___PASTE'
      54 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/compiler-gcc.h:72:37: note: in expansion of macro '__PASTE'
      72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                     ^~~~~~~
   include/linux/pci.h:1929:26: note: in expansion of macro '__UNIQUE_ID'
    1929 |       class_shift, hook, __UNIQUE_ID(hook))
         |                          ^~~~~~~~~~~
   include/linux/pci.h:1979:2: note: in expansion of macro 'DECLARE_PCI_FIXUP_SECTION'
    1979 |  DECLARE_PCI_FIXUP_SECTION(.pci_fixup_final,   \
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pci/vpd.c:563:1: note: in expansion of macro 'DECLARE_PCI_FIXUP_FINAL'
     563 | DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0078, quirk_blacklist_vpd);
         | ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler-gcc.h:72:45: warning: no previous prototype for '__UNIQUE_ID_quirk_blacklist_vpd185' [-Wmissing-prototypes]
      72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                             ^~~~~~~~~~~~
   include/linux/pci.h:1914:7: note: in definition of macro '___DECLARE_PCI_FIXUP_SECTION'
    1914 |  void stub(struct pci_dev *dev) { hook(dev); }   \
         |       ^~~~
   include/linux/pci.h:1928:2: note: in expansion of macro '__DECLARE_PCI_FIXUP_SECTION'
    1928 |  __DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class, \
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:54:22: note: in expansion of macro '___PASTE'
      54 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/compiler-gcc.h:72:29: note: in expansion of macro '__PASTE'
      72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                             ^~~~~~~
   include/linux/compiler_types.h:54:22: note: in expansion of macro '___PASTE'
      54 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^~~~~~~~
   include/linux/compiler-gcc.h:72:37: note: in expansion of macro '__PASTE'
      72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
         |                                     ^~~~~~~
   include/linux/pci.h:1929:26: note: in expansion of macro '__UNIQUE_ID'
    1929 |       class_shift, hook, __UNIQUE_ID(hook))
         |                          ^~~~~~~~~~~
   include/linux/pci.h:1979:2: note: in expansion of macro 'DECLARE_PCI_FIXUP_SECTION'
    1979 |  DECLARE_PCI_FIXUP_SECTION(.pci_fixup_final,   \
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/pci/vpd.c:564:1: note: in expansion of macro 'DECLARE_PCI_FIXUP_FINAL'
     564 | DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0079, quirk_blacklist_vpd);
         | ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler-gcc.h:72:45: warning: no previous prototype for '__UNIQUE_ID_quirk_blacklist_vpd186' [-Wmissing-prototypes]
      72 | #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
..

vim +/__DECLARE_PCI_FIXUP_SECTION +1928 include/linux/pci.h

^1da177e4c3f415 Linus Torvalds 2005-04-16  1910  
c9d8b55fa019162 Ard Biesheuvel 2018-08-21  1911  #ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
b1b820bb0420d08 Sami Tolvanen  2020-06-24  1912  #define ___DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class,	\
b1b820bb0420d08 Sami Tolvanen  2020-06-24  1913  				    class_shift, hook, stub)		\
b1b820bb0420d08 Sami Tolvanen  2020-06-24 @1914  	void stub(struct pci_dev *dev) { hook(dev); }			\
c9d8b55fa019162 Ard Biesheuvel 2018-08-21  1915  	asm(".section "	#sec ", \"a\"				\n"	\
c9d8b55fa019162 Ard Biesheuvel 2018-08-21  1916  	    ".balign	16					\n"	\
c9d8b55fa019162 Ard Biesheuvel 2018-08-21  1917  	    ".short "	#vendor ", " #device "			\n"	\
c9d8b55fa019162 Ard Biesheuvel 2018-08-21  1918  	    ".long "	#class ", " #class_shift "		\n"	\
b1b820bb0420d08 Sami Tolvanen  2020-06-24  1919  	    ".long "	#stub " - .				\n"	\
c9d8b55fa019162 Ard Biesheuvel 2018-08-21  1920  	    ".previous						\n");
b1b820bb0420d08 Sami Tolvanen  2020-06-24  1921  
b1b820bb0420d08 Sami Tolvanen  2020-06-24  1922  #define __DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class,	\
b1b820bb0420d08 Sami Tolvanen  2020-06-24  1923  				  class_shift, hook, stub)		\
b1b820bb0420d08 Sami Tolvanen  2020-06-24  1924  	___DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class,	\
b1b820bb0420d08 Sami Tolvanen  2020-06-24  1925  				  class_shift, hook, stub)
c9d8b55fa019162 Ard Biesheuvel 2018-08-21  1926  #define DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class,	\
c9d8b55fa019162 Ard Biesheuvel 2018-08-21  1927  				  class_shift, hook)			\
c9d8b55fa019162 Ard Biesheuvel 2018-08-21 @1928  	__DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class,	\
b1b820bb0420d08 Sami Tolvanen  2020-06-24 @1929  				  class_shift, hook, __UNIQUE_ID(hook))
c9d8b55fa019162 Ard Biesheuvel 2018-08-21  1930  #else
^1da177e4c3f415 Linus Torvalds 2005-04-16  1931  /* Anonymous variables would be nice... */
f4ca5c6a56278ca Yinghai Lu     2012-02-23  1932  #define DECLARE_PCI_FIXUP_SECTION(section, name, vendor, device, class,	\
f4ca5c6a56278ca Yinghai Lu     2012-02-23  1933  				  class_shift, hook)			\
ecf61c78bd787b9 Michal Marek   2013-11-11  1934  	static const struct pci_fixup __PASTE(__pci_fixup_##name,__LINE__) __used	\
f4ca5c6a56278ca Yinghai Lu     2012-02-23  1935  	__attribute__((__section__(#section), aligned((sizeof(void *)))))    \
f4ca5c6a56278ca Yinghai Lu     2012-02-23  1936  		= { vendor, device, class, class_shift, hook };
c9d8b55fa019162 Ard Biesheuvel 2018-08-21  1937  #endif
f4ca5c6a56278ca Yinghai Lu     2012-02-23  1938  
f4ca5c6a56278ca Yinghai Lu     2012-02-23  1939  #define DECLARE_PCI_FIXUP_CLASS_EARLY(vendor, device, class,		\
f4ca5c6a56278ca Yinghai Lu     2012-02-23  1940  					 class_shift, hook)		\
f4ca5c6a56278ca Yinghai Lu     2012-02-23  1941  	DECLARE_PCI_FIXUP_SECTION(.pci_fixup_early,			\
ecf61c78bd787b9 Michal Marek   2013-11-11  1942  		hook, vendor, device, class, class_shift, hook)
f4ca5c6a56278ca Yinghai Lu     2012-02-23  1943  #define DECLARE_PCI_FIXUP_CLASS_HEADER(vendor, device, class,		\
f4ca5c6a56278ca Yinghai Lu     2012-02-23  1944  					 class_shift, hook)		\
f4ca5c6a56278ca Yinghai Lu     2012-02-23  1945  	DECLARE_PCI_FIXUP_SECTION(.pci_fixup_header,			\
ecf61c78bd787b9 Michal Marek   2013-11-11  1946  		hook, vendor, device, class, class_shift, hook)
f4ca5c6a56278ca Yinghai Lu     2012-02-23  1947  #define DECLARE_PCI_FIXUP_CLASS_FINAL(vendor, device, class,		\
f4ca5c6a56278ca Yinghai Lu     2012-02-23  1948  					 class_shift, hook)		\
f4ca5c6a56278ca Yinghai Lu     2012-02-23 @1949  	DECLARE_PCI_FIXUP_SECTION(.pci_fixup_final,			\
ecf61c78bd787b9 Michal Marek   2013-11-11  1950  		hook, vendor, device, class, class_shift, hook)
f4ca5c6a56278ca Yinghai Lu     2012-02-23  1951  #define DECLARE_PCI_FIXUP_CLASS_ENABLE(vendor, device, class,		\
f4ca5c6a56278ca Yinghai Lu     2012-02-23  1952  					 class_shift, hook)		\
f4ca5c6a56278ca Yinghai Lu     2012-02-23  1953  	DECLARE_PCI_FIXUP_SECTION(.pci_fixup_enable,			\
ecf61c78bd787b9 Michal Marek   2013-11-11  1954  		hook, vendor, device, class, class_shift, hook)
f4ca5c6a56278ca Yinghai Lu     2012-02-23  1955  #define DECLARE_PCI_FIXUP_CLASS_RESUME(vendor, device, class,		\
f4ca5c6a56278ca Yinghai Lu     2012-02-23  1956  					 class_shift, hook)		\
f4ca5c6a56278ca Yinghai Lu     2012-02-23  1957  	DECLARE_PCI_FIXUP_SECTION(.pci_fixup_resume,			\
0aa0f5d1084ca1c Bjorn Helgaas  2017-12-02  1958  		resume##hook, vendor, device, class, class_shift, hook)
f4ca5c6a56278ca Yinghai Lu     2012-02-23  1959  #define DECLARE_PCI_FIXUP_CLASS_RESUME_EARLY(vendor, device, class,	\
f4ca5c6a56278ca Yinghai Lu     2012-02-23  1960  					 class_shift, hook)		\
f4ca5c6a56278ca Yinghai Lu     2012-02-23  1961  	DECLARE_PCI_FIXUP_SECTION(.pci_fixup_resume_early,		\
0aa0f5d1084ca1c Bjorn Helgaas  2017-12-02  1962  		resume_early##hook, vendor, device, class, class_shift, hook)
f4ca5c6a56278ca Yinghai Lu     2012-02-23  1963  #define DECLARE_PCI_FIXUP_CLASS_SUSPEND(vendor, device, class,		\
f4ca5c6a56278ca Yinghai Lu     2012-02-23  1964  					 class_shift, hook)		\
f4ca5c6a56278ca Yinghai Lu     2012-02-23  1965  	DECLARE_PCI_FIXUP_SECTION(.pci_fixup_suspend,			\
0aa0f5d1084ca1c Bjorn Helgaas  2017-12-02  1966  		suspend##hook, vendor, device, class, class_shift, hook)
7d2a01b87f1682f Andreas Noever 2014-06-03  1967  #define DECLARE_PCI_FIXUP_CLASS_SUSPEND_LATE(vendor, device, class,	\
7d2a01b87f1682f Andreas Noever 2014-06-03  1968  					 class_shift, hook)		\
7d2a01b87f1682f Andreas Noever 2014-06-03  1969  	DECLARE_PCI_FIXUP_SECTION(.pci_fixup_suspend_late,		\
0aa0f5d1084ca1c Bjorn Helgaas  2017-12-02  1970  		suspend_late##hook, vendor, device, class, class_shift, hook)
f4ca5c6a56278ca Yinghai Lu     2012-02-23  1971  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--mP3DRpeJDSE+ciuQ
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICKXO814AAy5jb25maWcAjFxLc9y2st7nV0w5m2SRHL2vXbe0AEFwBhmSoAFwHtqwZHns
ozqy5KtHEv/72w2QQ4DTmJwsHA268W50f91o8Oeffp6xt9enb7ev93e3Dw8/Zl93j7vn29fd
59mX+4fd/85yNauVnYlc2t+Bubx/fPv7X/fn769ml7+///3kt+e7s9ly9/y4e5jxp8cv91/f
oPb90+NPP//EVV3Iecd5txLaSFV3Vmzs9buvd3e/fZj9ku8+3d8+zj78fg7NnJ7/6v96F1ST
pptzfv1jKJqPTV1/ODk/ORkIZb4vPzu/OHH/7dspWT3fk0+C5hfMdMxU3VxZNXYSEGRdylqM
JKk/dmull2NJ1soyt7ISnWVZKTqjtB2pdqEFy6GZQsE/wGKwKqzMz7O5W+aH2cvu9e37uFaZ
VktRd7BUpmqCjmtpO1GvOqZhsrKS9vr8DFoZhqyqRkLvVhg7u3+ZPT69YsP71VGclcMCvHtH
FXesDdfATaszrLQB/4KtRLcUuhZlN7+RwfBCSgaUM5pU3lSMpmxuUjVUinAxEuIx7VclHFC4
KlMGHNYx+ubmeG11nHxB7EguCtaW1u1rsMJD8UIZW7NKXL/75fHpcffrnsGsWTRFszUr2XBy
AI0yctNVH1vRCpJhzSxfdAf0Qaa0MqarRKX0tmPWMr4YV7w1opRZOBLWgoIgmnGbxjR05Dhg
wCB05XAK4EDNXt4+vfx4ed19G0/BXNRCS+7OW6NVFhzBkGQWah2Kh86h1MAidVoYUed0LaTp
FbMo9ZXKJ8e7UJqLvD+5sp6PVNMwbQQyuXnvHj/Pnr5MZjDqHMWXRrXQll/mXAUtueUIWZwY
/KAqr1gpc2ZFVzJjO77lJbEWTv+sxqWdkF17YiVqa44Suwp0FMv/aI0l+CplurbBsQybZ++/
7Z5fqP1b3HQN1FK55KGM1AopMi9peXRkkrKQ8wXum5upNjFPvxEHoxkG02ghqsZC806Vj+ej
L1+psq0t01v6FHkuQrKH+lxB9WFNeNP+y96+/Gf2CsOZ3cLQXl5vX19mt3d3T2+Pr/ePX8dV
spIvO6jQMe7a8NK27xml0e3sSCZHmJkcDwkXcFyB1ZJMaHqMZdbQkzSSXNP/YjZu1pq3M3Mo
BjDkbQe0cFbwsxMbkA5qSY1nDquboX4/pLir/cld+j+Cs7zcb5OKhFAuF3CyJ1K0t4ho+gpQ
LLKw12cn41bL2i7BHhZiwnN6Him6tjY9DuAL0CLucA2iYe7+vfv89rB7nn3Z3b6+Pe9eXHE/
L4IaqYs1q22XoSqBdtu6Yk1ny6wrytYEepnPtWobE84XNDhPCE657CuQZE/yMznG0Miclqqe
rvOEee3pBZyjG6GPseRiJTmtNHoOkNSk7A/jFLo43knWzgmhQEMMuh/OV2D/QFvWJhRVOKd1
tO5gIjUUUYpD5lHlWthJXVhyvmwUCB1qPas0PXcvZIjc0rsIVqEwMDfQVhx0N72TWpRsS4wU
JQTW3tknHZhT95tV0LA3UwGE0fkEG0LBBBJCSYwEoSAEgI6uJr8vwvXJlEK9i39TyIV3qoEd
kTcCzbnbeKUrVvNI/0/ZDPxB6SQwqzawqv6cy/z0KoAGjgf0GheNwxWwOlxM6jTcNEsYTcks
DicA200RjiupHSedVoAUJUpZMI65sBVo+u4AC3gxOCguFqzOQ0jhQaM3s0Gp03/T311dydBl
CLSvKAvYHx02nJw9A1BVtNGoWvATJz/h1ATNNyqanJzXrCzy+DzqsMAhnLDALEAxBpBMBgIn
VdfqCPuxfCVhmP36BSsDjWRMaxnuwhJZtlV0ooeyDv5PbO2e7FYDj6OVq0haQUiG7skjjILg
nIciJ9p3JgS92nG80FrNJ5sE+PZjJIpVJvJcUC16kYY+uz2ydOasDwU0u+cvT8/fbh/vdjPx
5+4RQAMDQ8cRNgBMGzFC3MS+Z6eMPRFm1q0qmLfiJEj5L3scOlxVvjuP2yIxN2Wb+Z4Diwqu
NQPL65z+UauWLKN0BTQQNscyWHA9F4NjN23C2b5SArLXcA5VRWvwiBG9HIDktB43i7YoAH00
DPp0K8bAeCRwrSpkeYAp+zWNoxPDhDbvr7rzQJHD79AmGKtb7tRfLjg4VsGRUK1tWts5NQwO
7+7hy/nZbxhECoMRS7BSnWmbJoqhAKDiS6dPD2lVFcBFJ+MVAiNdg82R3qG5fn+MzjbXp1c0
w7Dx/9BOxBY1t/c5Devy0NwNhEjOfKtsO9iKrsj5YRU4/jLT6A/maLIn1fGAoz+B+mND0cCH
BwAra+GMHcEBIgFHomvmIB7BOrsxGWE9ivI+C/jHIYQBIDKQnNaApjR6rIu2Xib4nJSSbH48
MhO69n46mCUjs3I6ZNOaBvz8FNlhZrd0rOwWLRjHMjtowYmUGRQODMmdmxRb68IRgc4owFwK
psstx3BCaFKauXcFSlA3YDLOAniCS20YbgMKN6614HBQBx3aPD/d7V5enp5nrz++e78rcBn6
Zm7Ane3lajz/VUNoJTy2hWC21cKD2bDKXJV5Ic2CqKeFBTsrY68ZG/MyBpBHU7YMOcTGwr7g
Xo/2PmqC6jZiAICB0bPG0L4FsrBqbP+YiyCVKboqk8mGdM7Pz043ibns976PhRVMlq0+WJTz
M/DYJT1aD9RVJUEFAm6G843YPvZ5hqO2heMBYAMA6bwVYSSmYZqtpI6MyFCWdF6WYO4m7fjo
U9NiHAYksbQ9mBobXdHbsu/sSFRiyjp4wKM7evH+ymzI9pFEEy6PEKyhw59IqypqU6srZ7dG
TtAhgKQrSUvISD5Op633QL2gqcvExJb/kyh/T5dz3RpFi38ligKOhqpp6lrWfCEbnhhITz6n
AUcFlibR7lwABJhvTo9QuzIhCHyr5Sa53ivJ+HlHh/QdMbF2iHUTtQAm0dvndJU3vgn14A5y
jbPx5tXHhS5DlvI0TUN024AF8D6/aQMDgmSQ7riAV82GL+ZXF9NitYpLALPIqq2csi5YJcvt
9VVIdxoDvNbKBDhNMlBjaCu6yOdF/lW1ObAig0WDLkBLep19WAx6+rBwsZ2r+rCYw2lhrT4k
AAKsTSUsixDoQL1ZMLWRQXuLRng9FTSVh+5q7TCIQeANKCQTc6h9ShPxJuGANCD6KQEKIuHB
+TdJ4an4gR2BIgwxlmLOOB2Sdrav5hKdmCq2eR4+BJ7Qt6fH+9en5yjuHLhcvZlt64mzfsCh
WVMeo3MMLsfh9YDHWWq1ngb5emcjMd54wn49QApjUxBwnF5l4S2KgyGmAXw2cVkADzQl/iNi
WGIVHM+MDlXK98s0ehAYjoJ+2oaK9lWSa8Wje6Z90f7EjJpoT4I1o3XVngMglNc+BUsgHydP
hnYAeyAn6V5qhXcugHgoiOIpF9FtRV94dUHDAThGqijAhbg++ZufxBf0fdUJQikA2UEpnD5G
AH93F5cmixIA9QDY8JIvEF5ZoiyVAwbDK7ZWXJ/EU2lsekWdpgaPTxkMn+jWhfwSQukvG/HW
YH19dbEXAKsDvYS/0B2QFpyyZHk/073iOUmw4dJgCMlppAMthWMCf3WyXmCEDPgrqAfQTuUT
sg9OxIfIVKyJSwAhTUq8arBm47YABWCq7KYcNJYgODHoTfKKQhJbYQRHRz0S2Jvu9OSEEu+b
7uzyZMJ6HrNOWqGbuYZmwnyAjaCRKtfMLLq8JZ23ZrE1Etx+dBU1np7T+PCAr49RnvgQ+A3D
wDbGE+NNcS64qxUGeIdeWCnnNfRy5juJMkwAFaxyQy87r3IXVwBVSPmEsGey2HZlboMY9GgA
jvi7kSD2R6A/1wtlm9LFULzZe/pr9zwDM3L7dfdt9/jq2mG8kbOn75iQFPjOfdwgCDL1gYT+
LipWbPswBLU9VWdKISLJgjIUT1dOO1JVt2ZL4a75yTYnraWcOyDxMvKu1h+9ne0c5ncIoVcB
qaDw3rvFlQrO/cGvwQI7UTOg0NSybSaKogLNafuUD6zShDEsVwK7b0Fr+0E6zGCCsN6YTYK8
btpz0kv2bTVcdxPJ94TpjvjBgNkszCEOCXm0WHVqJbSWuQijSnFLgvuxFdTuOQ42nXfGLNia
7bS0tTZEwa6wYPVBj5bRZtqvE8hRaiAO/WsBYmHMpJ8+Z0DpEbzRZJkfrPCeSK6yr8bmc7BC
0wB0NKsFQDBWToTIJd/5SeNhb5u5Zvl0AFMaITnpBWs4yoiib4v9silwQ0Cf0dDJC1lGx3oc
cZG+M/Hy0YjgeMXl/bVa3CASyO7yxhYUtt6rCInXnLARMmFch/nC36Q8O8RQ7X2pMaZV0ANi
TYQZh6yYWfG8+7+33ePdj9nL3e2Dd0hG89GLaSoLhai9b1h+ftgFyabQUiywQ0k3V6uuZHke
zyMiV6JuafsWclmRMIIh0xBZI+XAk4YoXGgL9zMKnA8HfQ7Tpgbr+Y92zy1V9vYyFMx+gRMw
273e/f5ruAl4LOYKcS0tSo5cVf7nEZZcasHJjClHZnWgBrEIe4xLfAtx2dBxAOT9xQr61+GG
QnEiCIuohiSpMpFDCXCIDlHVwl5entDBrblQpGEAJ7iOciYdjt6aIiP3NbFhfjPvH2+ff8zE
t7eH2wm26ZGac3rHtg74Y91jFeoJqTyod10U98/f/rp93s3y5/s//ZXtCLJzSr0VUldrdD4A
n0XeQV5JmUe3u5X0GQlEK47GWd1V4IogpKxVjage7GJZZiyOJhfrjhfzw7aC6w01L8V+aER/
2PRwgTPM3e6+Pt/Ovgwr8NmtQJitlWAYyAdrF632chX4Uhglb0HMbhzCDKwcGMHV5vL0LCoy
C3ba1XJadnZ5NS21DWvNPlVzuM+9fb779/3r7g6x9W+fd99hvKgxDgCyG6fyd8SBKh1K0EQd
WoSlvxsj9+EP8G5A+WaC1ofQ24hY29p5IZjaxBFLHDqrLj/dyrrL+oTosCGptMDbWeIKczm9
vfOleNFFEVRDl/fNYJZ+QWX6FOBHu2tLAJKIn+o/BI9317FF6TNjnrRrcQHwekJEVYe4RM5b
1RKZvAZW2Fkfn7tM3e4CykY3rE/aOmQwYgiaJIheMXfVwaL7kfvnDj4PoFsvpHU5C8StrOny
bc1Q51iXruRqTPjOzzJpMWjQTbcRn2aAR9k/XZjuDmAdODt17i9XexnqjUTE55NdyI3DZxbJ
iot1l8FEfYLehFbJDcjtSDZuOBMmlxoIQtfqGrQbbEmUPjTNrCHkBJNA0Ht0WYv+7tjVoBoh
+h/SanS/RBh6oPZzPLTHqWHCUs9WVW0H2B8Afg/V0bMmyZgQTLH0cufPiU+97e8+poPplUUv
dhhrnHD09fyDlwQtV20igUA2vPOp/8MTGmIx+gBTn0ARBBYS5UFN3IIS5GVCPEgNGOx7nz4Q
kYfk9qHXRN1JJVgxFWa5lVZNGhqHuZYWrHEvMO4SeypVRL769HAoFL7wNijSerULXcKKY6pG
vI3jbiAN20Czp6cjBaUwxIcFh2MVeOFAajFugdYDsxO1oPxORxmCZ9Qwo/yhCYPYgL4ilW9c
630sgKrZDprThqmFvMQMD0Q8gFzygIBxfyPnfczq/IDAJsZmjwhRn+IOUcrdggmxw6Mlvd6E
QpMkTav7RSarU6RxWcFBLc/PhmBmrNT3Rh8sE2XZw9zGTtRcb5v9c4w5V6vfPt2+7D7P/uPT
BL8/P325f4juw/YNIHc3QJxJjPJYS9F88I0ihiVln9I9yaj7BwS2j+DCimHaa3jKXG6owUzI
IPjvxTqEYf1Ku4dMoPISkaOeq62PcQwW9lgLRvP9G8JEburAmfAaezKKqRaJfJ+eB3Oz1mBk
jQHtMmbmd7JyQUwqaboG0YFjsa0yFSXu9vrAgtE5CGZmfdbK/idAFG4wPPgxzqUZEuQzE12G
BcWlzMgJjan1Vsy1tPRV78CFyV70LrlHHH3w3VkpOg6EbOuMjni56WF+UsPo/UMG/xR2OF+T
YJKPv98+v96jFM/sj++7yF+EgVnpgVW+wjx8yn2sTK7MyDouMnpoYfEY+Zj0GO5K9RGjBvFO
ucC6f3eoxgc3gdsDlaTyyVo56OP48W9AXG6z2PUZCFlBh7Di/vYBDL+mpgHDigcRLKt/XRjT
nWnw9GM0su4aREukKofEuPbkasCHB8CFJrSyez+au0m4C400i15TDKh40cXHsHvJmgYPNstz
1ASdO9yUuRlS17tMFPg/BLPxW86A1903wWSh8RCCjXc9TiTE37u7t9fbTw879/B95lISXgPh
yGRdVBYhQiCaZRFnTrhBIZ7ev+VFSNG/OAuk0bdluJZNdPHRE0DDUSkj2HoP1veilRq3m1S1
+/b0/GNWjcHBw7uwY3flwyV8xeqWRYkK4w28p1HxIF85bq1zqVK+XqBxx+bwLiIEbt4xw9ev
8zaqUAKaaayTXZd4czGuEuAdvlcWex00x+OCEk3nLFZyridBmAxwbCiAPvtRdVkbP+4wVJrE
IAAO/Pmntbm+vjj5cEWfsnR6aUwhVTQFn4kxRfnXy+iekYMP4q//yQ4KcBUsRlsS1790zPWm
mdwHj5SspQ3ajTl869GThkiHC9cNcZ5IDefD4wcMoixTL2ZhAVziWPI9LEgaaJaaLyqmyau1
Qbk0Vnhfg0VgMX3sxo3YY9R69/rX0/N/AEgGhzMQW74U5GuwWgZQGn+BOol21JXlktGLAL4G
nWxR6Mrp01TcGzwB6q2g9FMa96LxL9Q4MzTsAIYBDXRatXQ6NDA1dfghDPe7yxe8mXSGxZiI
RQtoz6CZpuk4L9nIY8Q5anZRtVRKsefobFvXcT4XWCrQR2opE3FRX3Fl6bs0pBaKvpHqaWO3
dAe4LR2jE7odDRB0migbVKaJ3R6nGxaiwE2KLG+G4rj5Nm/SAuo4NFv/AwdSYV8wlkFjaOwd
/pwfw557Ht5mofEZdPhAv3539/bp/u5d3HqVXxryJSrs7FUspqurXtbR5aWfIzsm/zLVwPHp
8oR/hrO/Ora1V0f39orY3HgMlWzopHBHnchsSDLSHswayrorTa29I9c5IB6HDey2EQe1vaQd
GSpqmqbsv8KTOAmO0a1+mm7E/Kor1//Un2MD60DfGvptbsrjDVUNyE7qaONXhjB4ODVABzzN
YutiOmDMqiZl8IDZByBp9645QgT1kvPEOCV+HSChcHXiowA29bkawIpkeXmW6CHTMidBjg8a
o2ow0euovohsbFWyunt/cnb6kSTngteCNmNlyelHBcyyMpE1fHZJN8UaOljQLFSq+6tSrZvE
GwwphMA5XdKPT3A90l93yDn1wjWv8UbDKPxu1PW3YDNg+5hz7+kL9kbUK7OWltPqamXwKzQJ
NAbjBHd1mbYDVZMwfv7LCnSXi0RetFsVN9Jc0JNBjvIc/BeDejzF9VHbdAc1n35xZQDS/lsU
yNNomUgzGXl4yYyRlFZ1xnODnsq2i1/LZx8jhIIPy/+IP90UwtLZ6+7ldZKt40a3tADHyWDH
Qc0JIUS6wX6wSrM8NeWEhCciWqyAueuUoim6JacctrXU4Aub+EscxRxP0OnB8uwJj7vd55fZ
69Ps0w7miX74Z/TBZ2AcHEMQXepL0PFA7wHf+278S9wg03YtoZRWqcVSkvlEuB8fmqmq+0B8
0iRYUJn4GIpoFl0qaFkXiU+NGTA+qa86IYwsaBplHwdFg6+C0RsNLrrxlZTwn18Y/VJwijF0
RGV22IUF93PQH9Pbml7wBzcs3/15fxdmu0TMMjYlYpJkFPJGYcfpjy5XFZPx116g2IUl4KwS
bSKVmaaKmvl/yq6ku3FcV/8Vr+7pXvTt2M7gLO6ClmSbZU0RJQ+10Uknriqfm4pznOTc7n//
AFIDKQFyvUVXxwQ4iCMIAh90CoUq0NC0SaCC9tAD5rChDuKXmFsgFZYRrsT0Oa5tuBQlMyLl
oZDZutsrA/NXm3DmBXVEIQm1QriUK8PGbrkyofdspMG2y9MEvdnqKqt38nZDM+bpSOzryiHt
6fT6cT69IOTTczPpqqn4fvz+ukUDImT0TvCH+nx7O50/bCOkITaj/Tv9BeUeX5B8YIsZ4DI7
3ePzAV2zNLltNEKt9cq6zNvo7ukeaHoneH1+Ox1fP7oGikHsa8MK8uRxMjZFvf/v+PH0g+5v
d0Jtq5M/73pqWOXzpdmFeSJjoJZEKjunXGuhdXyq9p9R0tcEFQa2ZBWEKbndgSCSR+miA6Ni
0soIX+SJTHAUxb4InUd/uJnqmhp7Po0G+p+uXeDLCQb73G6Ui61+bbRV7MEuz0RTDqJEtft2
zW0MUfpfRXBSL4QtU31a9K3wqpY22jv9iIjPao4+vekyBILwM7lh2lMxBJuMuWgaBsRirYoB
iRlNH+j7ELIJ/aBRMWvjsgHtp0bfKPKEAcZE8qYIEfRiLkOZy6D/Dt2fZ42J8LM+Bp2JF63Q
U4FGXbSzWEJEAqe6x0HPLGPukTen10yyILqj63BirHS6jiRVErVn22pFrVPUwwY3aSWWQYNn
lJ5PH6en04sNWRSnrntM9UpLvQDHRRjiD1p6rZgW/NMukvFYVcqH7pHpdLKjhcOauej4bPYY
wiRh7tMVg5/Nh9sTX6CrHQ1SUNMzQbfQ87MkwouF528YdxcQnFHYQ9FuuIoLTcyU243mxrOJ
AueA7H430kkRFwhlVzSu7zx2oeZUPr4/UcsMNqJoj8+w9F1+HqHdI6MeEDEHYJDLRaT3OZIa
xF6YKHTpRzdV6TE72iotQcpmxKIV1F/Q9wXFDbV9kvdQq1s9CQJUwQ3JXzCek+kmFbFkvCon
3YVvnnkD2DcjR3ap+0JTyvupt7slh7KT1apqfje+6nVyZUn+9+P7SL6+f5w/f2pQsvcfcCQ9
jz7Oj6/vWM7o5fh6GD3DpDi+4Z+umfn/O7fOLl4+DufH0SJdCstI/fS/VzwJRz9PaIcw+g1d
ao7nA1Qw8RxHEONwEjEeRw21ZJZDy5DvaI6NkSs2ESEay9ePw8soglH91+h8eNFI9MRobZKU
PZSGirDG21vRUxof30FI8NCo1mMwSJAlQ29kjmMl5iIWpaCBdZ09wLWidN3Z4Gevh9AUqcps
9Uy95NBOKUocd4tMSB8hvLvIyVYWspVURc5mTPcNvfXmIluixorbihaFoqyKUIc5Gk/vr0e/
gTx32MJ/v1PzAYTMABU4dNkVsYwTtaenzFA11rcJD2Z3gu7aWlijRNE4yA0YVQfitTIUaY+V
JPY5hb0+C0gKfsay4G4XwYP2JRl4vM0DZkuGT9twYD4yZUmbHUdBgZQReuew+gufFkOWjLof
2qeYYwC+C/5SCaOBygu6gZBebvTIaKh7JveGkzXiMOJcKrPua4G51h9hHz/+9YnbkTK3SGFZ
gzq30vqK/4tZLJUXmunm7syD25wPm9nUSxz7gA2cjwEtTeb7dJWQDu9WecIXKdyU7SKrJA1W
sJCkv5VdwDJwl0SQj6ckDpudKRQe2q3pcATtHhZKLyFvhk7WPEg6ztUBJz8gM1xec3XpIyLx
1bYZckjONgw/Z+PxmBVeU5w1U+YxKfLL3ZK8F9oVwvKPcyno1mQenY5zJnHUBiIPuTetkPZ5
RAK9fpDC9fCloS6yJHP0riYFbiCzGQm6YWWeZ4nwOzN+fk2/hM29CHcrxjw23tGd4XFTJ5fL
JJ6yhdFLziAjdGVWOyN1i3U/2Os4w89jSktt5cEMHVhs2GcpraqTaSNtnDKbtApCpaGU214y
SWVOT5yGTPdXQ6YHriVvKB2B3TKQ2Jx2dRc+kUWbCjrzz9uVCKNOn9kxaadlFei7m6UxoQkl
ZV9j56oeL9qKwgmtT1BF7HeV8/3ygqgINbx2O02CycW2B18RBpAcdONjS5JWhdjaSAcWSc4m
N7sdTeqiYgU0Ug8mX3X5rphLyZK+okL6hrHD2XFZuhtxS7lma6d3ii/RhcGKRLYJXHjOaBNx
z6RqvaTrV+v95EJFUIuIE2deROHuuuw+8ra0G16YB6raDpIX2wvtkV7mToK1ms1uxpCXNqdZ
q6+z2XXvQkaXnFSTuckN3353Pb1wHumcKojoCR3tMweHAH+Pr5gBWQQijC9UF4u8qqzdMkwS
LY+q2XQ2uXAqwp8YmMcRgtSEmU6bHWNEbBeXJXES0as/dtsuQYIJ0Fwc5L4IHxi6R26/hNn0
/srdMifryyMcb6QvnX3bRHXqCF79jMnaaTHqtrilDmWRNspWacZ0F75yKWPXRWslNLgBWfA+
wOeJhbwgfKdBrNBRkez4hzBZuqGXHkIx3TGq44eQlWSgzF0Qlxz5gTSmtBtSoB4lcoSwB0iA
Q4ixncuii5Mi851Py26vri/M+ixAad45RGdw2WfM2pCUJ/SSyGbj2/tLlcFoC0UOTIZmThlJ
UiKC89t5qlZ40HSvC0TOwHZktwlJCNcw+M8R8BRjxAHpiLHhXbr2KRm6CFXKu59cTceXcjkr
AH7eM2AsQBrfXxhQFSlnDgSp9MZcecB7Px4zUjcSry/tmirxYM/E2JVkN+f6YHA+L49ggv/C
0BWxuy+k6T4KGDc8nB7M446HZmAxcy7I4kIj9nGSwvXDkTG3XrkLl51V2s+bB6sidzZNk3Ih
l5sDYcpAXEBTVsUYy+YdLVO/zI2748PPMkP8GPpkA+oGnY07jpf9Yrfya8exwaSU2xtuwjUM
00t3VPPAYRdePXmIneS3yIonDKGvOZ6F7zN6aZmmvLOBmnfRLFtxBoTOIZR9GD3ObCxNmdhU
nbuP1nytTu8ff7wfnw+jQs1rFazmOhyeK9s6pNRWhuL58e3jcO5rwrdmm7J+tYqryJwGFC13
9ErwcwhNLl/dcPKIW2hk+0nYJEtNQVDrWytB6oBtd0kZbNOuNZLKGeetNJMqcm2EiULbmwhF
DEDgYvs0E679nUNrjmaKqCRNsH2w7fSc4f+69+0T2SZplVkQ63u+eSHURpyj7RHtMH/r26z+
jsae74fD6ONHzUXYE205fXm0Qy0fvWiLLzJXRTngK0SZO7a3TOWTm+TGkb/gZ5l2TBKql7e3
zw/2YUnGaWH1uv5ZLhbonNg1mjU0tDrmjKMNh3H6XEfMvDRMkcgzuesy6QYX74fzC6LdHTHE
07fHzoN6lT9BAIDBdnxJ9sMMweYSvbNDWP3J2ZWanOtgP0+EHVuvToFNYz139McNJVyvGfuG
hiUOtjnzOtHwoFE+XtHp2dawVYLpBaY82YqtoN+sWq4ivtjyXd5h6Y9m21n6Z5mqCZFUijBV
VPp871PJeGeC/6cpRQQZSaS59MgCvb02SyMLlQuEh19TNO2jWoNItedsQ8fYGvjOQR/HbdMC
PAmYG5pVW1J4qzUZo7llWiBCUvdtpSVvIv33QE0qyCQjvhoGkHDDQLdlgGnuRTf3d0zIFM2x
UXCbFcwDtGlJPWIlSguDix/d7GiNqmHRTmWME6thwO9RXhYwyrJq7komVE0WyWvafGT1eH7W
xhvyz2SE+7HjuJ/ZQQsJe7gOh/5ZytnV9aSbCP92LecMwctnE+9uzNysNAuIPzA3iGllyCAU
mvXZyZaJ7UCh1etbp+BuzWoSdaCtu8VkHltGoVlI0lJEQf8lpnqTpcaktTwhjlBzJv14PD8+
oaDamn7Vd5vcgtvb2IHAzaO2ce4Pu7hIm7xmoNIaEOxa/tta3K00klsEBJ/oWiTUfRXL3f2s
TPO91YAKEJxLrAJjT24avINQO3mi7Soa9Nbyljqcj48vlgxljaAIbWxOlzAzKP39RCvarfaj
dXrN5jMmoM6UqUnj25ubK7gjCkiKGb80m3+BMjcFFWAz9YbLaYztKWITgp3IaEqclYXIcgv6
wqZmiMEWBQ0L2e46UNuFlvtbWMZcX/n8Qm7akk9mM0rdbTOFDka5TYlkM1vi0+sfmAaF6Gmj
b4eEPVCVHT8+lDmlxq44XPwWK5FaLxX5C2OIWZHx3Ja0GWfFoTwv3jGXYsMBQzcPMl8wVikV
V7VNfskF2gTxO2HLeokNdd4Xi8oYDaIhZym/aQN5oTCu36U6NJeMF2Gwu8Sq0q41VG2/5u4s
vYxxEhv/B8aaKi6XzEDHydeEe4ZBi++cwfOq4pjCbXjogzR0WNe2sRYl0kiWJmozGT5w20Zr
ae/+daLB7JUJE9enYevoFlqCE8qrTdbR3ChCRymHwp/0uDi3SbxnVFPRlvdNm91Nb/8ulylz
lMdw4nSJFQm62cATtVrPYLPm7OfjDWfMrDEqev4ibZFdyQpjk9G6OREvTXAhPU70DPLgv5Sx
9Q5CHW+R0xqGe85iti+d2J9npk5WoEtmSqOROEwIw2Jcdvp34olH7daYTLXLZre4p8z+w0wf
lTJrdcV4YaduJC/jCJKno6eX09N/qfYDsRzfzGZlr/9tlVKlIkWNBQvfYOmWHp+fNbodbGG6
4vd/81Xivk32YL/ZVhEy7sZwbUVgWDOcPndLm/IYX1KxYcIHaCrGwyK9cWo/1DTcO0+wVjof
B8dmWm2jDvCXLwYCZGj/K55cxW0pfTW5m9G3IIeF7pmaZf4wueNeYb0VGkijnnU3u7+aEp/Z
+zKdUPktoUFDb97Fjx9w9FHqSRWAbJOpUsxlXiyLjF7VPS5ab9mwqekdd1OsOHY6vo3GMc8Y
ZLCadz1De7hhlvHVRZ6FiMY3q4EhbtoW+WiRkC3po7thQwWGijgJqO6JNOBitFcsfgBygmKi
xtZM8mYN7WKca+oPvBvPrm5oGyabZzZZ0Eq8trIb7gm14kCx+GKHy3xGB2CtGWCGj++HWcyx
PtwY5LmeDJcT556JMiQV543YsHr57e1seIIjz90dDd7S8KRedMes8ZpHSXVzcz9cDr5MX99F
9IbiMs2nF7oTnzvh5L44dMB3O7tlwqfUPPm4g4dBsMwm02GW7Wx6O7lbDc9awxS4XMbBCcPb
DG1rOszT5SWfr6/GY+qRtg1N1Z4UJskAVKLKkLI2r5kCkN+WQYyaEGwFRjGABS/2ZaRa8Oaa
ubex1wQEaNXQ+HkmyeCiNWONU4aBh1QepOVWqoAq0WZcCJkZGHX6ZCSymKABKRdvtM7Cl04w
DrYXGeYgFut/Ltb5i81DC9heQD/L+QyEr/NPRyVlaXLRt02PqRcKDj1NM6nEK/1c1bXScxhY
p9dXuwtVIgtVTiPlDZbVa70O1cEXRneCJf4JBEdKKElMqTkZNk8pyqZ87kWCZJ938ESN3+zn
y8fx2+frk0Z8rnSsRH9FC7/0YH+d0vsrkiO8m9Db3Cr3NMyHR58EmNv04kMhQH6HCwp/9wxT
r5TMQwfSFPcI0lSCKjG9mf0KH+us2LClkVfOd/TlE7m+iPgrhhLn7IuRZw2HSMggxmPX5rfc
aYTkzPemE8YWC+kq4qJqifkOxJMBm2LMvVceF+ceyLkEYWo6vdlhWHXhMy9myPgQ7WY09iGS
N7vZzQ25dAbnqHVbDpa4AzESSeYNfCUaWpQeulgZ3OABLoLDQI2cH99+HJ/eqYusWFLeCJul
KEU2t94ZTIIGsFrqqOe3bRlINDgqcPDRE8nP+kECBaTZbvH11mYlGwCS8+PPw+ivz2/fDufq
dd1Z/0w4NTKbgb14fPrvy/H7j4/Rv0ah5/ctINpF6/kGcm3IEAojdoT6HY5nrdEzhms2VZ9e
308v2sf77eXxn2o29e0zsNc94oVnKeAvOIwWGm48MTHUKEWVhh/wuk8UTjL8PyyiWP1ndkXT
s2Sr/jO5sRRLF1rfwJJ056R1diRF7Pdmy0r6/T5YuWHm4Gdz9VZ5FsRLxvMOGLnnyGJFIj5h
0RXiSvOO9XZ4QnUzZug9ZiG/uO6+rOtULyMhhTUN75q9DEUWkHjr+nODcC3tCEWQhuvQjuhl
0iT82nfL9pJiKehdCcmRQCh9+n6ss+uNh2laayXh5IGeXyZxJhmzAmQJIrjB0lcFTQ6Djk7Z
Jn5dB73PXAbRXDJKf01fZPS9XBPDJJMJo55HBqiQN3DQDHv+W7cizBmAFiRvZLBVCWePr5u3
z3qyrcMg0emP6S2Z96bbFzHnRCWg5lsZr0jTXNMTMQZqyTtqK6CEHn870/QgTjb02WEm4lJ6
vC2KYQnRN2WAvl/A/kwZaCM5C8zEdJeN8QCCvbSTnKDFZX+eaVji4bkQM9DfSEP/bFqZj9RU
xCjFw2zkJ3Ia5CLcx7S8pRlgG8CTh6XjW2aGE46f72nGQlYiWQk59BlD5mWajpq0kHsx0xws
pkFFDUJ8WOOwbaS2S0vDgRWdce8HuN7Q6gcuDPwaUZHI8i/JfrCKXA5Md9gRFKdP1PQVvrsY
QFqWqcAzrkwVfbFBjp2MI74RX0GaG/wENLL1hpacUbuUHFqQPtzClH6hIk/XxiTHEgYakxW4
iiYrBGaUeR5i5CI4mqzljHQi8jwmF2HaQzyzyE30h5Xnd7IyOYxth7FZBSZts9DBfMT09Mc/
78cn+Mjw8R8apTBOUl3gzgvkhuyngXLcj1wKf8m8QyIEO33AYMZMWxfxWM4RoxuP4BhnDe3i
YAt7PoMZbiJxSg1nRwsfEv6N5VzElKwWwLSsYxiBCFxY9xhNamdBfQHLvdLYu1gJkTe+vp2N
Z2XHEgZpWtCnLzqoath0gbUMHEgk5sWCivmh0QAxCB1XJOQzwRR19FC6Syq2VSCYFdWp3+ru
YudLBTs/XXDBeYticBweFgfJMtER1l0/HZ3M6S7qXBFXqZ9S8uYG3R36delUDufBUA0WjNks
KmO2vibq+HQ+vZ++fYxW/7wdzn9sRt8/D+8fFCDqJda2ejhH+s/z9YTIQd4hDfMwhDiMVI64
vGULO2QtHdjKtszxJbwgW/m0YI20BhGb5lCFGubwPX8uOIxM/frFBpvX9GxOP0tWmZMuCEir
AqgcKQYMd5cpCC4adB4fJOnzKNU7D/1KuUqHvx3x+rJ8+IVz5ffWZrOfobpO318QinWAB+Z4
mNBXV8Owmef056kiW6A1UpolUzjtcs5foBLQygfGChjhsGDrLec5gVDe41pxn6xnqhcxoO0G
HeXulleGooyUiwyDKHAXKNMhcrDPMy5akdHpoyjnGXTTATbUs7IqvIqliKWOrzNUm1ewG6PF
US1/YnfAduDB51jzo3ocNrmSOeK9VZZEQVMqg9RaoUUMVW6i24aW6wP8qBBInWibNSMCD2MI
M9sAOkILB1NIu/S2dbDB3s7saUsXdfo8O28Dbf0q8zTyyNRpVbDJu6n6Z+mGTQTOeeg3nK2S
i6rV6iwhw3lC6XhkgoGwW/nDQYLWxFH6+P1govsR0N2XWDVvdvh5+ji8nU9PlESJ0MQ5AlvS
BlhEZlPo28/372R5aaTqY5su0clprXBU83UR/IxiDdr2m/rn/ePwc5S8jrwfx7ffR+94H/jW
ABk3crT4+XL6Dsnq5FGAahTZ5IMCEWSNydanGtXx+fT4/HT6yeUj6cY0Z5f+uTgfDu8gpx9G
D6ezfOAKucSqeY//jnZcAT2aJj58Pr5A09i2k3R7vLwy78N37jAk8t+9Mmtxxbgub7yCnBtU
5uYC+EuzoK1Kx0fYLLKANsQOdriPcxeVJGPuGZyVaU5faREYmBPq0m3/DQTRf5/gyyhRskez
moVQI2xF2uauNrkKCaPMdLWHLeOvd9259nDVmOLIQJU896JyncQC74UTlgttHNOdKCezOEKT
SwbL1+bC8lguc/QFvXtmbfHofI2VVT/aM76mkQt6ZrrlcNbBVDGgwc/T6/HjdKbGZYjNGgRG
EIYvve7VLF6fz6fjs/MwF/tZImk795rdkpAZfRyiUfdn3WqLgMJP6ONMeVIwAT3MMHRfVGqN
TL9ISzxHXGJShgsYbweZMAZVoYxYS3nUyQ7Jato/qaswa2JrOF67VeQD2H7NtLKECl/HHSi3
CbrsakWFc+UUofRFHpQLNRSeG3ajCbBwtOkA7ZqjZYGE6qBehv6FJ+140nKh2JbO84HqYhkO
ZF1M+JxA6czn5utRbnIjXtRpJoZ7mZBmU6hb0bKdjK1YlRG6guQ60q5Lt1tCB0C3OTZBN5x7
QzPqGutxtZsgTYI2ZHIqFgOanociYaCY0dVuodgZYshst6MXLUMzwbr3HXIVLubpR+dBXhFh
hZuAMZrbsPt/wNXjTwT/x6XWrrR2Savk/vb2imtV4S96pLoeumyjiEvUnwuR/xns8F+4bTO1
mwD1TN0byMuv0gFinBNDUO9CQy0zZ9T74fP5pCN/93YmFOpLd3XopHX3amoT0YQmt3x/dKIO
qQw3MQmro1ect5KhnwXUG6DJjGp9Hek6F3lhefitgyxe2B5/e2X/7AWzMZFs0v+r7Fqa28aR
8F9x5bRblZmK/Br7kANEUhIjvgySlu0LS3E0jirxoyR5Ntlfv+gGQRFEN6Q9zDhCfwQBEGg0
Gv3Iy/hOcVpGzYCYOwh2Tqtt6mlUJeMJxRXU1ohn40jYt6D6D/+ViG/QVQkOr8BNtP7C6k4u
RTaN+PUnQg9twtMiZFAcdcY/qEhwv8Nyd09bx57m8KRAipQhlTe1KGfcWvPsT2kMWa85tpV6
el/wtJvs7txLveSp0vfSAszSGZnnvrxlGZ1nuKXL0g2naX2O7PloiPiU/fv2dPD7zIojgyXD
ldgnnvczhEIJmz9ewxva8k/meQUI9knYqFq/8zAje96CgOMomTXMBh0N4xLNrCEfNXEnqCDU
vdIUnTkLcKjseUWC2DD8CUNhvVArtnqsr85kEQx/N1MlTPaGsC31ZHWE5I3ktw/iiVUV/EaG
TEZuQKpOkxVnZRRAghg9wBZfBNQiEnN1lMV8lnSbAFUXYDjE0x2G3Sdif50XYykTmLujg3la
AQY5DANC4IH25aHg2TC7Dq8LZhEm/bmXlF0Sxw/r7evV1cX1H6NeljQAqAZEuAGfn9F2tRbo
r6NAjA+LBbq6oPX9AxD9CQago153RMOvGJ+gAYjmIwPQMQ2/pI0lBiAmvbINOmYILmmb4wHo
+jDo+uyImq6P+cDXTEICG3R+RJuumIA+AFKCPcz9hk4cZlUzOj2m2QrFTwJRBjHjvN9rC/+8
QfAjYxD89DGIw2PCTxyD4L+1QfBLyyD4D9iNx+HOjA73ZsR3Z57HVw2TucaQ6QthIEO8VSVr
MXe5BhFESRUzsY47SFZFtWQUvQYkc1HFh152L+OEi8xlQFPBBu/qIDJiDOgMIg4gWBgTxcJg
sjqmFWHW8B3qVFXLeczs9YCpqwm9iusshuVJ7Ilx3ixu+hdqlqatDRL0+L5Z7373zGW6U6Qd
uRZ+NzK6qSOTQZqWvCFCppKBM4zBJ+NsysjTWt8ThbwUoQhNOINwetrylosWpMSouFLQNCpR
KV/JmNFMGqyXSIoXeJc6EzKMMtVkUCMFeXGPslwgBqd3B0argSALxuQe7uck4/GAHpEBVpOq
L+zJUKs9CfdDIXoyb1Kmnz/ATSokqvv4e/m8/Ajp6t7WLx+3y79Xqp71t48Q6fEJJsLHr29/
f9BzY77avKx+nnxfbr6tXvrJ5dsrwXT1/Lr5fbJ+We/Wy5/r/y6B2g/EGFfQhWAOAWHs7GtA
yjM9fF3zGdWfAU/UamWxxiyIbpIh8z3ah7YZrIdOYobZmn9+blVqm99vu9eTR0jq/Lo5+b76
+dZP2avBqntTUcTqGar41C2PREgWutByHsTFLJIswX0EDhJkoQuV2ZRoHVvzvCgIOCQVdot1
lgK33W35qXWW0qS6JCe9/WB31IS4E72TQIuaTkanV2mdOO+FqEJkIdUS/ENvBqbXdTVTnM0H
GWbl1OrG968/149//Fj9PnnEqfUEfju/+1pS821KWiXdkkPmsKipUXCILkN//YrB3EanFxej
a6cP4n33ffWyWz9iXsjoBTsC7nr/We++n4jt9vVxjaRwuVs6ayUIUuc7TLHMacJMbT7i9FOR
J/ejs0+03NOtnmlcqk/vw5TRzdDmdzgqM6GY0K3T4zHapzy/frP18qadY+88CCaUVbMhVpLq
eUWqIEwrx8QjiaRt2FpyPnTqs8nFgT7cMRH8DGOI7heS0UyZDwT2oFXNRN9ve1aWxODPltvv
3dgPxknJUy6r04VOFw508XYQCb7NOPi02u6oby6Ds2HIJQqhL3kP4g4C1BdKFFvzfqM7XoWk
EeNEzKNT70TQEO/HVu2pRp/CmMoXZtZzuwc504xYyQMuH567W0Z4QdSVxmq1gv0mI/sbNpqG
B9gCIBityB5xekGfEfeIs1NvHeVMUAk+9lT1BneTn4mLEbVBKQKT7q2lp35ypUSscc7oQNvt
aypH196JuShU45wlE6zfvttGg4ZDl0RHVGnDOHD1EFl8eB2JrB7H3okrZMAkwTNzH9IG+ZdQ
IMByk/FV6jBl5d2sAOCdTiHjatWSJ/jXy5Bn4kF4BZhSJKXwT1mz//r3VMarqqPLgrO/tiFN
WUanzQUTNaCb194vWEXeD1Mt8kPft4UM29E6kj+/bVbbrT78uN9skoiKPt+ZPfqB1om05Ktz
73JLHrx9V+SZlxM+lJXrBS6XL99en0+y9+evq402hzWnO3eBlZBnRjKuhmYY5HiKfiM+0JcY
fMojsKdjDs29I0GjzlCe25EB0JyLjgIf6EuHg7OZOx300fDn+utmqY6im9f33fqFEFKSeNwy
P6JcsSRKmFOkI3ZigOlFehBFSvMuLmTaaTZuSCjyEH0ekS85Rk7fN5mW6100szXOFtaFllmD
t00hQjaEZw+GEVcPgWbxJGv+ur5gAg7ugQGTCa0HuRGVOrRdXV/8CrzL1GADNt3cEHjJJMRl
Xs5k66RefyRUNeAwshST6I5zBurhRIq595rpHQ0V5X2aRqD6Q70huFq6S3O12YFVszqFbjHf
0Xb99LLEhN+P31ePkIzGdheEu3xYcRB4pOwUmqTm6Zi6sfLEZQx75alA0zhi5o9jJZuBB2DP
i8NYESuxLQuK+2Yi89RYuBGQJMoYKiTAqau4f4NqSJM4C9X/JESfjSvbekeGjIwNjutRk9UQ
aZs6sWp1rkjc1xVBDM4bonBJg+LOWXgiwCMRAgIUSdzvHSJ0xopU7VJZXnWR/nsTLFCLVG07
zPQLRpzcETTuaccix1XdUBFZ8dw2aMMZZBtJJkPVkA1I4iAa318Rj2oKJwYgRMgFL4UAYszc
YSgqcw8b8HJzQN+LKb7tPSAH9IFMx0D2j9ED7AkQ1lzbmJkXPgDzAE2knUdGCUVk+d1Dm0va
+g3OoE4ZWr0XLjYWl+dOoZApVVbN1BJxCJC9ya13HHzpf/m2lBmNfd+a6UM/u3SPMFaEU5KS
PKSCJNw9MPicKT93l3H/xqRj3ZAHUi3O20iNihT9kDpqgWNY9WERmBI1FkOA8rDf8EydQZoS
HbYh7MnUTkAHpSDDcbGPy2mi29rr2k2PY2UJmNZYlxryBnNzEZXlGPhkqvYQeb8XWfBOyYzL
bVjm7mhNowqiWOeTsD8q/Weas1OGgEkq+hZZkxyOU0OnfCy9+jW6HBSBEXMJIYB6WGNuGswX
ou+AWCruoT9G7+4KtkpyyXZ7prMV2tdOZkPG0rfN+mX3A2N8f3tebZ/cC0u162SVDvFu29Ji
Mdgh0fcIbYitBJKt30ZdXM7Pf7GImzqOqn1ykFRNdrCNcGo437cCQrebpmDAUpLThfeZgGgK
vCWahXB8YTvBJR3nalNoIikVvB91DB9T/ylRYpy3oUHbr8GOcHfKXf9c/bFbP7cSzRahj7p8
Q8Vb0G9TXJnKEhBleF+TYvR7CM7fm39SNbpZCJl9Hn06PbcnVaH4RQpd5LwzRIgVCybFxCyC
IJUlGOBVglytutmlmvlKXABT4xQCc/Zm+4CCLW3yLLkfdgGTkNkeB7pyzJvd2vipw6QT/b+L
8nbkoFsOru0CCldf35+e4JYzftnuNu/Pq5d+misM9QQyruwlOe4Vdlet+kN9/vRrRKF0ag26
BpNHBIwGsiD6/OGDMw7sXTuymvk0tGKCwG/igU4WrMelyJSwk8WVOo8C/7biyACVHOejRs6e
HtrkdbiywC7d+Bu3d9FdZbagr/gF5ggqOY8XXSEAcRuiBW2oJl9kjF4DyWoOQmAzRqWh3yLz
UFSCkya64dXgxZ07nxeUG1En1FdgLeo+lI+/RAGXAyqpxwbGhE8ABFraclOo/VCYSFPM3fcb
imdgtPlCDeydboTiXGGLirJQM7LDQwiZQqcYRMNt1S3NtoYPHvGSWFa1HWrbIrCcT/vpot2F
+/Asns6YNDf7MccBAV+mSZIv3DosMrUlB9iNuYDVvI8GaZgAFmMdqHGyTT/2y8156ww8fZ2r
PMCf5K9v248nyevjj/c3zWJny5enwdk8U3NZsf2c9n2z6OCfWEf7iOSaiKJcXani/QTKJxXo
pepCtbJSy4GJXQs2RcfgNLGZQWCRSpT03F7ckLGmOzrm7tBvI9mlf8y0XZnarb69/8SQsHv+
Z60ax/wci50VvTfNIaocfmMY4XkUFQN2pxUvcFm/Z+3/2r6tXzD9y8eT5/fd6tdK/WO1e/zz
zz//vW8qOjti3VMUZ10nhkJCwKjWqZE+9kId0C8fBwYdRhXdMTc87QwmwnMMIIcrWSw0SDHQ
fFEIJnJr26pFGTFylgZg15z9yYKYAGFt2kSiAhhY1NG3ZwX6hfgqNe0rcJpwjxRmane98x48
/o+p0Jc+FcvBTGP0q0EKVGPR1Blcf6kZrhUXnuGb6y2QYUo/tDTybblbnoAY8gjaRELABt2k
T4Q4QC99kgG6x8YDNd7+VIPbc4PCgzqLyJpw4LV4BtOl4VsDqcYvq5Tw6PrByqCmZSoJMXvU
nsJPDkAcnEEIYj8yUKObkjqhmTgsVvuc1XfTyv6SkPrtQxpOeCUjgvqbbioou7LgfhCWyUi7
mLOhm7LuwR/360md6cMMgiRHnUpRzGiMOZFOkOolNou4moEipDwCFsYSdjI4tw/hLSzFQAOq
PlBFDyDgbgtrEZF4DBtWErQP6lp67rHqCYbVT/h5AbtAHEYYGXN0dn2O+iWQoGixUaSQ7Mgv
w0FIiSZu/cWiXge1gTORZi/ObZqzdn5dXVL7sR5OJR1NEjEt3ZkCwfBahQEqMvpBpjCNbKvZ
sOIF9MqbcDylL8IsFAbgDBlzrHZ/T8aTpKaDC8NHhXiGw+m+15mqboB6MoSFwauS47xNKfPp
7urTYHgNgbFu6BA1r+PpMGAUTSvCC+HTAOFAwCU5FQtB9xGP1oUVo1HHRYPNmFV51tkizmBw
XOVFy9vs+dPX1lWr7Q62UhADg9d/Vpvl06rPnOc1txbMDgPKqlyqNfNFq1dIsNZIkBj77KCO
CEF+287svpreZO+Fjw/LfBjLUsu+cNtXclkgEJLGGcYA5RHs8+M9T1az0LMTjcEey0NHBXee
5BDLjUXhR7yFzLfeytTOqfYjnq7FuMtzRrDqd3wW3cGB3zMyWjes/RloycLgyoCxBEHAXCEq
JoSNTkAInIW+o0O61lt76WpuMmlZEFHXw+BBfeod3mfwdOoQbCMkmLg4J/7BgHNWMEiNQy4o
EMz0OZfyVPc+Z4I6Iv025VVTenBABmE9YPQ7Ct/ngav3Geje1YZGMwS4n1btbMZKEpqlQtKH
I6xtEstUCemegdRBOjz94dl6O2HRYYf1aNKTNs09M0Zt24FQE9f7EjgzMezUVMICFI09F3mZ
ueNEo+9n/gfLnhJ16gABAA==

--mP3DRpeJDSE+ciuQ--
