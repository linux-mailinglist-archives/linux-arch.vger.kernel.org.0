Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 738D738981E
	for <lists+linux-arch@lfdr.de>; Wed, 19 May 2021 22:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbhESUmG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 May 2021 16:42:06 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:37649 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbhESUmF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 May 2021 16:42:05 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MrhLw-1l4qnQ352y-00ni9K for <linux-arch@vger.kernel.org>; Wed, 19 May 2021
 22:40:44 +0200
Received: by mail-wm1-f54.google.com with SMTP id o127so7943340wmo.4
        for <linux-arch@vger.kernel.org>; Wed, 19 May 2021 13:40:44 -0700 (PDT)
X-Gm-Message-State: AOAM5301WDZ1wltdCp4pt81PeA0FjG6k1D0W5s+/ss3QRL2XKUnfQN1E
        u+FN3FcWYkA1x5PT/XGriwoZYtpCK2PkQ2WzGD0=
X-Google-Smtp-Source: ABdhPJw5+tP5f89y3XWHPecVz8dOpwihKp7ERsX8zUHZBgn+F0np0JNxgK/+bcrR/38HRFnFoCtgHQZD1TQasW+/qUU=
X-Received: by 2002:a7b:c849:: with SMTP id c9mr928187wml.84.1621456844477;
 Wed, 19 May 2021 13:40:44 -0700 (PDT)
MIME-Version: 1.0
References: <202105200456.B8lcITGX-lkp@intel.com> <CAK8P3a3ytGKfRftRqC5OaGTxNfxX5-qpbXdGG9AYHcRJFMB-RA@mail.gmail.com>
In-Reply-To: <CAK8P3a3ytGKfRftRqC5OaGTxNfxX5-qpbXdGG9AYHcRJFMB-RA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 19 May 2021 22:39:31 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0ajoE-8SjeAxmWgpMB0nnaM-zw5tCn+-yCQRHEVLsPfg@mail.gmail.com>
Message-ID: <CAK8P3a0ajoE-8SjeAxmWgpMB0nnaM-zw5tCn+-yCQRHEVLsPfg@mail.gmail.com>
Subject: Re: [asm-generic:compat-alloc-user-space-9 6/41] net/ethtool/ioctl.c:815:9:
 error: implicit declaration of function 'in_ia32_syscall'; did you mean 'in_compat_syscall'?
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-arch <linux-arch@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:aOL8ZFcF70jHZfr5Uxv6fGmXTK53QBtF7lj7Tm4/sqIckR7b9Uj
 2MyyFesCAotl3GZAyEZSq7lSd892vhLj5guWi5hibX20JsWIyG2PcTL76Kt14B+38cvR4rJ
 EcA0UAwR/v6un/JtHJftwJcsSDy46ME8KakP663cOeDM8gBzFyvVoHqcy5eER5hcoYMeJhE
 SiuaCZOHvfYgpfI54S43w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6RREONZek/A=:LrBt7epWLp8wQLwca6qBM1
 kuOG/Mg+43vOSpAEuiEHJ7PJYhOBxJ1soIqbNpXN43cwwqNl1Wt+EKekvGGzzYOcGIQteuabF
 t5TPowyduZZ5iD2C+38jyaUKZCj5Hh+J6Y82u4wcdbBBtMQA8qobycN/tXZdypB2We2cLrf0+
 tge3epIPOeVwSWzWxYj7w2yglaVmLc8H1Z+BmR3w6hk7aqnFMav1hz5icjvlkUZhm7RuH0Nmn
 pcBtBpbCMkqLeyLrq6q7f75RFzHvqfgDrIUbKdZO8Gvl9gB+yjdyxx9+aP5qtZiVjWjINJoc+
 P/rI+WKHil0tux7FD7UoDRLJ/y732wGuH2exKJB5HotYFlShg23/si0nC7gDDgBU0Fsxx4GQ3
 ee9kurpQ7nxnPmQ15ohq9g+r2LdIRFUc6dyG9c0Z7c+ruDnwpMQE8TAI5Oim21Rp/yO4SILCU
 JazYqI8pnPRLznh8f0ukMSLla16G8rX8v1Tm8/guE+r+1Z9rSXx8wyHOIVpcg21MlZO0tkmbM
 ZgJJnFmH1TbSxAfGnwf7OyhBVgl9zA2mvkp3i5iwamAWlG9NoJxkIOUe3c5586t/YZ3ASjBGf
 A/VUppanmZD2mti9VcH7SxkbPwdwpforCVANSp2pLvfRACPjIHdWCruRhtvHdr6yzygsV7aCA
 r8+w=
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 19, 2021 at 10:33 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> --- a/net/ethtool/ioctl.c
> +++ b/net/ethtool/ioctl.c
> @@ -810,7 +810,7 @@ static noinline_for_stack int
> ethtool_get_sset_info(struct net_device *dev,
>
>  static bool ethtool_translate_compat(void)
>  {
> -#ifdef CONFIG_X86_64
> +#if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
>         /* On x86, translation is needed for i386 but not x32 */
>         return in_ia32_syscall();
>  #else

No, that wouldn't work either, as that triggers the BUILD_BUG_ON() for UML.

This is getting rather ugly but hopefully covers all cases:

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index dd09e6aceae1..c323bbfa97b3 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -811,8 +811,10 @@ static noinline_for_stack int
ethtool_get_sset_info(struct net_device *dev,
 static bool ethtool_translate_compat(void)
 {
 #ifdef CONFIG_X86_64
+#ifdef CONFIG_COMPAT
        /* On x86, translation is needed for i386 but not x32 */
        return in_ia32_syscall();
+#endif
 #else
        BUILD_BUG_ON(sizeof(struct compat_ethtool_rxnfc) !=
                     sizeof(struct ethtool_rxnfc));

       Arnd
