Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 500A94BBCF0
	for <lists+linux-arch@lfdr.de>; Fri, 18 Feb 2022 17:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbiBRQDP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Feb 2022 11:03:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233766AbiBRQDP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Feb 2022 11:03:15 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF66488A2
        for <linux-arch@vger.kernel.org>; Fri, 18 Feb 2022 08:02:57 -0800 (PST)
Received: from mail-wm1-f51.google.com ([209.85.128.51]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MLhwM-1nccbX1mlc-00Hhlh for <linux-arch@vger.kernel.org>; Fri, 18 Feb
 2022 17:02:55 +0100
Received: by mail-wm1-f51.google.com with SMTP id bg21-20020a05600c3c9500b0035283e7a012so6768346wmb.0
        for <linux-arch@vger.kernel.org>; Fri, 18 Feb 2022 08:02:55 -0800 (PST)
X-Gm-Message-State: AOAM531MEVHS6tckun35Py8CrcMR7WzRkFyhPC2mCsSWoDi83Q3zx2l/
        b+DbFWMER3BOq7KU6T9WDeGxjbjZOk1yKdaJA4I=
X-Google-Smtp-Source: ABdhPJyTn8nYwhnulN5cUK7fj/zvCPmFQnvDDynZq0jB+RTyFCg/kf815QfeKumv1movRZhTmRNkPR7cBdcSsPn3a9U=
X-Received: by 2002:a05:600c:1d27:b0:37c:74bb:2b4d with SMTP id
 l39-20020a05600c1d2700b0037c74bb2b4dmr11220609wms.82.1645200175107; Fri, 18
 Feb 2022 08:02:55 -0800 (PST)
MIME-Version: 1.0
References: <202202172154.lJ3Z0yXe-lkp@intel.com>
In-Reply-To: <202202172154.lJ3Z0yXe-lkp@intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 18 Feb 2022 17:02:38 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3AV4rpPdFsaz=PTe=LGNDUo1H5i2g35kr56T_pZrjewg@mail.gmail.com>
Message-ID: <CAK8P3a3AV4rpPdFsaz=PTe=LGNDUo1H5i2g35kr56T_pZrjewg@mail.gmail.com>
Subject: Re: [arnd-asm-generic:master 19/26] arch/sparc/include/uapi/asm/posix_types.h:14:
 Error: Unknown opcode: `typedef'
To:     kernel test robot <lkp@intel.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>, kbuild-all@lists.01.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:o05F8RJUIio8LWN9ZML2z+eKXqtobH+iRhYlVOMuYUQ+1nGgBTO
 9Bn6iFCV6EI2Z6BXgTNAyY+yOmGcs/xc1CF577jubEre742KnC1Q08vHdGNN6dWapIlq2R2
 bGoHrAsR+0VOW5U5DpF4OGLWd1YadpH2t7FmCH3vPxlk76zFxSTPyAi/34fMFAZlxoUN45a
 WrX+GqR5WVeZBcwtJT65A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bjLTu5QXNeU=:9UKSRhE+NiZxAVPXPk/vpI
 HZkccVlQ6cQCWjt4FPAk5RSbpP2xa/pvok2V0tGNC8fMBOCCdt7qGKsdkQE8+BxMziLnfNq+X
 tuAhRGv3PBA/gbgA6G5bzww0siI8rg/VZPlXI23OhXQKpppLZe4M6JRrbqUyH7qq1xq5mbD0M
 bfdvEha1xvuJKbsC++eQ0FuV99o9wVFLwHfk7IriafWEWjPwco9dts5Jx1+MBEb67phsUt4u/
 yGzTNXOXsaxMh2NliuGJ6/+QPttvMQVwiJxu5/oGrYr/OfagWkP4ndGTIsgHy/n+RjkdeY89U
 9NHgKTSjB1zC9JrbIrb4M57RXVTLvJt2kN5LUcq6le58f8ErnuzlJKI23TmcdWvTuTmNhVwpT
 u7c7JTLlHuhpMQBhEMLB93XnTnuToWHxsGQrM68n75XFkOq3SiA8gXIjlTnAzS1FYYRdeyWYB
 kuQICzG3vDiH9ZzQS1TVo+XaNCOSzT08420PPBfNHcA2XFnN9ljxWEGzIbO8PTFRrJ0DmYZNU
 Q5jBoF8Uv3W91NOxYvKLhoZLG0Mws3+Zb+KobUOai0YYWhfs19ldLGfjd5Qr2VXi0btwPlEWM
 rfVw4f87fejQWSvl1RHIEuJ0ltE8yOtrZNgc3EN902mMGdG3MqYDwvcXB+Vby+AZ+wnXZwLYz
 74BGE4a5jJgClkMZQqrIvbs+Vjbi8u8kYas8k9hmMgl9I1LO+/7/IfbcjH+gmedsm8/4=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 17, 2022 at 2:15 PM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git master
> head:   3f2b41135db9099b8d216fffeede5c2cb38ed277
> commit: 72113d0a7d90d950c7c9a87ab905bffb6bc5752d [19/26] signal.h: add linux/signal.h and asm/signal.h to UAPI compile-test coverage
> config: sparc64-randconfig-r036-20220217 (https://download.01.org/0day-ci/archive/20220217/202202172154.lJ3Z0yXe-lkp@intel.com/config)
> compiler: sparc64-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git/commit/?id=72113d0a7d90d950c7c9a87ab905bffb6bc5752d
>         git remote add arnd-asm-generic https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
>         git fetch --no-tags arnd-asm-generic master
>         git checkout 72113d0a7d90d950c7c9a87ab905bffb6bc5752d
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sparc64 SHELL=/bin/bash
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>

Thanks for the report, I added a fixup now:



commit be92e1ded1d17d68444a793fb07c118ab98b28b5
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Fri Feb 18 16:59:04 2022 +0100

    sparc64: fix building assembly files

    linux/posix_types.h must not be included in assembler files,
    so move the #include statement down into the appropriate
    ifdef section.

    Fixes: 72113d0a7d90 ("signal.h: add linux/signal.h and
asm/signal.h to UAPI compile-test coverage")
    Reported-by: kernel test robot <lkp@intel.com>
    Link: https://lore.kernel.org/linux-arch/202202172154.lJ3Z0yXe-lkp@intel.com/
    Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/sparc/include/uapi/asm/signal.h
b/arch/sparc/include/uapi/asm/signal.h
index d395af9b46d2..b61382924725 100644
--- a/arch/sparc/include/uapi/asm/signal.h
+++ b/arch/sparc/include/uapi/asm/signal.h
@@ -2,7 +2,6 @@
 #ifndef _UAPI__SPARC_SIGNAL_H
 #define _UAPI__SPARC_SIGNAL_H

-#include <asm/posix_types.h>
 #include <asm/sigcontext.h>
 #include <linux/compiler.h>

@@ -152,6 +151,7 @@ struct sigstack {


 #include <asm-generic/signal-defs.h>
+#include <asm/posix_types.h>

 #ifndef __KERNEL__
 struct __new_sigaction {
