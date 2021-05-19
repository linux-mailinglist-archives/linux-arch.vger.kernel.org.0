Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CED4F3897F6
	for <lists+linux-arch@lfdr.de>; Wed, 19 May 2021 22:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbhESUfn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 May 2021 16:35:43 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:36429 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbhESUfn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 May 2021 16:35:43 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MBSJT-1lc0eI3w5f-00D0OO for <linux-arch@vger.kernel.org>; Wed, 19 May 2021
 22:34:21 +0200
Received: by mail-wr1-f45.google.com with SMTP id i17so15333363wrq.11
        for <linux-arch@vger.kernel.org>; Wed, 19 May 2021 13:34:21 -0700 (PDT)
X-Gm-Message-State: AOAM532otBaoFT2Wwvug1VCd68XBGP5zdWL6lZGq6UkmRUwrTUNuKj5Z
        BIs17xE2/b6CEfOZ9K34H+xNtNTlKubNY8V0bNU=
X-Google-Smtp-Source: ABdhPJxKltx50Zvy+MIsIL06MrQxEpZZ3JV6OtMJCikQWxvcWILHKoC7DoWeqPSe4mP4f1g4lEAi3etj0nrwVyK0D8g=
X-Received: by 2002:adf:e589:: with SMTP id l9mr739542wrm.361.1621456461691;
 Wed, 19 May 2021 13:34:21 -0700 (PDT)
MIME-Version: 1.0
References: <202105200456.B8lcITGX-lkp@intel.com>
In-Reply-To: <202105200456.B8lcITGX-lkp@intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 19 May 2021 22:33:08 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3ytGKfRftRqC5OaGTxNfxX5-qpbXdGG9AYHcRJFMB-RA@mail.gmail.com>
Message-ID: <CAK8P3a3ytGKfRftRqC5OaGTxNfxX5-qpbXdGG9AYHcRJFMB-RA@mail.gmail.com>
Subject: Re: [asm-generic:compat-alloc-user-space-9 6/41] net/ethtool/ioctl.c:815:9:
 error: implicit declaration of function 'in_ia32_syscall'; did you mean 'in_compat_syscall'?
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-arch <linux-arch@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:3BAVSGr6N3VyPjIsgLcZqnzz+0NI2Rl9AG3xyRsytq/DGgFHphf
 I65n1VvmoymLvrw3HEsNDqKmj7xjBlnQCiMh1ohAONJpJSsjPUxB5Wj33KavSjc+bu7arF/
 /N3vJCHCRTWLYrttV+vgL3ccBLn0Tg9D6nxhD7bnpDbkjCIC3qa9yVDbyGXR3hZDsq42Mnw
 9hxVsd3Mignqgx6FatS8Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ipk2dCz4KF0=:GSYlt56C8rIqgxheEb7zBQ
 j5fwXnqUPU54oQylv56aC6AYNfUrgyav5Rb/ORyHwrQzfokbA+Nhm52qcLDTjRulKRKcoAolB
 hEAF0VXr0B3wvcPaz7lvMuJHYi24zk9dUAuUHzrLYpGn8VCZfiTn94mruJWKFtzsHF9wfvqvT
 cIm2G4r3cZ3SlQ8zvuMiBfGBUAMYix9lOzsqfMxh5XVz+4VIACCG9TbxUBb7yeK96cC9I1mZn
 Vw1je3oX3Dz9ghW4siPqdeIjenDQh5J1n8lGoOyzTMttCKyURtOyP0siTumeuGbc9p6Ub1WHY
 S5ZV2LgarHtx49cG/pSKw/T+TMjTTV0CNS0wcc1qIxEKSzYuqXy/8s/3uYPicyVqbZY3HqRbT
 NxEt8050g4Z8m/eG4GfUfRsXuyIeNF1iGtax/6azAgKFWDmzfvu9zPTBgYnnWpp6JG6gxXuB3
 7J7AE0yDihtoqI6+SHQErH0ddPmg8mL42yjiz+IyH8nFC5PZ00keU+T29prsUqm+FFV9fo+Ff
 OynR7/P7uB4xn4aSiJrNCrjnJbF1yAIBR+B0xh9bqjKxttK2tvuf/Kqo8bwSnhHYwS3Q1QqQD
 Q3EM+2tff26du5xEF/IW4aokdjJpDjzMxlOpE3JixmWSFxZMTit6lZg5I7sQN/L/BIqaVq6Xw
 dJAg=
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 19, 2021 at 10:08 PM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git compat-alloc-user-space-9
> head:   c20b182ddc8032c63c381bf868f99222bab89537
> commit: 5cbe995d81d1ea310babe2c123bf1a40dff25e46 [6/41] ethtool: improve compat ioctl handling
> config: um-allmodconfig (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce (this is a W=1 build):
>         # https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git/commit/?id=5cbe995d81d1ea310babe2c123bf1a40dff25e46
>         git remote add asm-generic https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
>         git fetch --no-tags asm-generic compat-alloc-user-space-9
>         git checkout 5cbe995d81d1ea310babe2c123bf1a40dff25e46
>         # save the attached .config to linux build tree
>         make W=1 ARCH=um
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    net/ethtool/ioctl.c: In function 'ethtool_translate_compat':
> >> net/ethtool/ioctl.c:815:9: error: implicit declaration of function 'in_ia32_syscall'; did you mean 'in_compat_syscall'? [-Werror=implicit-function-declaration]
>      815 |  return in_ia32_syscall();
>          |         ^~~~~~~~~~~~~~~
>          |         in_compat_syscall
>    cc1: some warnings being treated as errors
>
>
> vim +815 net/ethtool/ioctl.c
>
>    810
>    811  static bool ethtool_translate_compat(void)
>    812  {
>    813  #ifdef CONFIG_X86_64
>    814          /* On x86, translation is needed for i386 but not x32 */
>  > 815          return in_ia32_syscall();
>    816  #else
>    817          BUILD_BUG_ON(sizeof(struct compat_ethtool_rxnfc) !=
>    818                       sizeof(struct ethtool_rxnfc));
>    819  #endif

I never noticed that uml sets CONFIG_X86_64, but that makes sense.
Changing the check to

--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -810,7 +810,7 @@ static noinline_for_stack int
ethtool_get_sset_info(struct net_device *dev,

 static bool ethtool_translate_compat(void)
 {
-#ifdef CONFIG_X86_64
+#if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
        /* On x86, translation is needed for i386 but not x32 */
        return in_ia32_syscall();
 #else


         Arnd
