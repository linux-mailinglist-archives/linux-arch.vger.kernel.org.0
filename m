Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84F45389EED
	for <lists+linux-arch@lfdr.de>; Thu, 20 May 2021 09:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbhETHcz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 May 2021 03:32:55 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:57653 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhETHcz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 May 2021 03:32:55 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MNcYX-1m7cJr42A7-00P1wM for <linux-arch@vger.kernel.org>; Thu, 20 May
 2021 09:31:32 +0200
Received: by mail-wm1-f48.google.com with SMTP id u4-20020a05600c00c4b02901774b80945cso4741511wmm.3
        for <linux-arch@vger.kernel.org>; Thu, 20 May 2021 00:31:32 -0700 (PDT)
X-Gm-Message-State: AOAM530KuCu6CmxkStFqZ0g6yh94BTGCVSRVk/Nnyp4ueFfJD9lzXgcN
        XDrWzTIG4yhi/UNZ/zVMmE6yS6RKE2qNSIIYFKQ=
X-Google-Smtp-Source: ABdhPJwMK4sSKSKhNhXSazNTAgqOT3+lHf9vrWNGII+VSW6u+u2FdqzgQNB2A+8OPowJ2Y6jSCkxM+ptEbG61QCYBbc=
X-Received: by 2002:a1c:9895:: with SMTP id a143mr2166501wme.43.1621495892502;
 Thu, 20 May 2021 00:31:32 -0700 (PDT)
MIME-Version: 1.0
References: <202105200456.B8lcITGX-lkp@intel.com> <CAK8P3a3ytGKfRftRqC5OaGTxNfxX5-qpbXdGG9AYHcRJFMB-RA@mail.gmail.com>
 <20210520051951.GA21165@lst.de>
In-Reply-To: <20210520051951.GA21165@lst.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 20 May 2021 09:30:18 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2Mg0jHDxb9h+_9ox74gYp7v2jQFN2QOswT=VRpbPbMzA@mail.gmail.com>
Message-ID: <CAK8P3a2Mg0jHDxb9h+_9ox74gYp7v2jQFN2QOswT=VRpbPbMzA@mail.gmail.com>
Subject: Re: [asm-generic:compat-alloc-user-space-9 6/41] net/ethtool/ioctl.c:815:9:
 error: implicit declaration of function 'in_ia32_syscall'; did you mean 'in_compat_syscall'?
To:     Christoph Hellwig <hch@lst.de>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:4KCBVbS1/GNabZGtVbBtTQJev6LGj0DFMZ7eLLw35GLxcZfkGRD
 PM7uXmwncW5ZPXjwUJZOnTR8LVOIYAGEJeRQo8WkkenZBHJbYS+Eq5TxUZ+QsT4J/o3kroB
 kxFWCKjT7wJFKy1rU+9VEaHq8jRTTIIaa9At2SXrryHDF33hiMEaoP11qW5hnvzccO+dyVG
 WkQchfMrNS9mvAWeNlLRw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:l33ZBkaGLEI=:Adb07CH9kW072O4j6DipO+
 V/jtQ+/EcY5RtNjrxzaRRZZ035g8uJSvcZgdOp+j6kB8Eq/mmQ7S6KzCvFVw0ZNWmpG704GWO
 n1t7LFnLCdKArl3MqUTnPHVhTTV5O+JG07mjkmOhtOfTJ9AHXsq5NELr7+cnUru6aVLIw4oZy
 lKh3TOwU6FI5ema12tcPDwpkLcDdgyB9ITH1MT03hIypH23L1iiJ3mjRxNqgDfJz2oMORb8QS
 zdF0bPKgCj2tdjsTp2s/WxYn/4PjsU9S32ISbHYPgUXCd/cqG48U8C74/w/CDbEIRjh8S1Bnw
 x2Trtq6EsgSxLc+3VWNd5tUMNGf8eoyvS5uuPW0/EwUuBSCG4KMOCGM9TXXWDmb9pMRrerxUu
 OmA0/8A7H12uIm962Uz4RmyjhOs94wfzCp7xPO2uw+SEm18t24ohUVkXEEhMPT+duqCkjmkXG
 xk8KiMN2Xzwi7SG3heTIOfl3jnP6/Dxim2yxMRGjNnxTP/xIwjc/szcxjUrnsIsKfAKUvlieO
 4bBBjU06bFGo8XhCACto7g=
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, May 20, 2021 at 7:19 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, May 19, 2021 at 10:33:08PM +0200, Arnd Bergmann wrote:
> >  static bool ethtool_translate_compat(void)
> >  {
> > -#ifdef CONFIG_X86_64
> > +#if defined(CONFIG_X86_64) && !defined(CONFIG_UML)
> >         /* On x86, translation is needed for i386 but not x32 */
> >         return in_ia32_syscall();
> >  #else
>
> Please just use compat_need_64bit_alignment_fixup() instead.

Ah perfect, thanks for adding that interface.

       Arnd
