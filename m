Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2392D40B9
	for <lists+linux-arch@lfdr.de>; Wed,  9 Dec 2020 12:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730180AbgLILLZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Dec 2020 06:11:25 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:51103 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729951AbgLILLZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Dec 2020 06:11:25 -0500
Received: from [192.168.1.155] ([77.2.91.93]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MulyX-1jwv380R1P-00rlHc; Wed, 09 Dec 2020 12:08:53 +0100
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org, linux-usb@vger.kernel.org,
        stern@rowland.harvard.edu
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: RFC: arch: shall we have generic readl_be()/writel_be()/... or
 in_be32()/out_be32() ?
Message-ID: <da9cb964-18a7-bff1-1249-b0df24daa05e@metux.net>
Date:   Wed, 9 Dec 2020 12:08:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:NeeEluc1dgyWIOb+oZp0crg/UcTSy3+6IkLzN1fzggvaaZpoByf
 PplFI1sHeZu9TPPYijNtxBaxj4PF7RgT+GMnS0muoGxvXdOzKA11/MGckZltQCLMs7LOKgm
 ucURQrXZDt3QuyHne6aFS1AunvGiqIj9mXg2y7w6B+DzDDGektuLu5X8yTfU0o31WbB4pJK
 0ZyQUbIx/8DIAHCXgVcWA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:14Aufr6ugO4=:SPFyjCMRZJ4zAE5q2tFCue
 Dz+MdUnk+HWTWiGUMyqipNa8nW3R/kvCY3/XamWinP8k9FeWZ4PmGke7s0A8cIz3PvRvqSZom
 QLtvzoc+jVPFK4DO9C+Cq0bcgAdNFtadXwtMjWp/OqIbtM1Q+flNemjYDXE5+Vy6RhllQqBQ2
 6eKqGZyNU6U7n4MQww8m38aRMTCPsmW2PR/w4rY0tBY0KdVTyTT8Rm3++JQKn7a0M+Jj/TnR9
 NVADLycZ1gZsHACwJZED5gijvFvGs1YPSv4TUrhdoo7YhUXt40TUysNENBSEdFQWi67DvGbMB
 Bx1KHZEe6j13bGSuyOb850xxGEgTD8Dl8ilCRI0xvr5PjppqE6tIeJja1hQOAvvWiDTIeJCY9
 NDJo3UOIPSYiJV2Boo93FV3bG+eU+JVuApy8MIF/h9s+UE8YyyeuTXrSA6gso
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello folks,


while trying to make some more drivers compile-test'able, i've
discovered some arch specific calls in here, eg.:


In file included from
/home/nekrad/src/apu2-dev/pkg/kernel.apu2.git/drivers/usb/host/ehci-spear.c:23:
/home/nekrad/src/apu2-dev/pkg/kernel.apu2.git/drivers/usb/host/ehci.h:
In function 'ehci_readl':
/home/nekrad/src/apu2-dev/pkg/kernel.apu2.git/drivers/usb/host/ehci.h:743:3:
error: implicit declaration of function 'readl_be'; did you mean
'readsb'? [-Werror=implicit-function-declaration]
  743 |   readl_be(regs) :
      |   ^~~~~~~~
      |   readsb
/home/nekrad/src/apu2-dev/pkg/kernel.apu2.git/drivers/usb/host/ehci.h:
In function 'ehci_writel':
/home/nekrad/src/apu2-dev/pkg/kernel.apu2.git/drivers/usb/host/ehci.h:767:3:
error: implicit declaration of function 'writel_be'; did you mean
'writesb'? [-Werror=implicit-function-declaration]
  767 |   writel_be(val, regs) :
      |   ^~~~~~~~~
      |   writesb
In file included from
/home/nekrad/src/apu2-dev/pkg/kernel.apu2.git/drivers/usb/host/ehci-hcd.c:97:
/home/nekrad/src/apu2-dev/pkg/kernel.apu2.git/drivers/usb/host/ehci.h:
In function 'ehci_readl':
/home/nekrad/src/apu2-dev/pkg/kernel.apu2.git/drivers/usb/host/ehci.h:743:3:
error: implicit declaration of function 'readl_be'; did you mean
'readsb'? [-Werror=implicit-function-declaration]
  743 |   readl_be(regs) :
      |   ^~~~~~~~
      |   readsb
/home/nekrad/src/apu2-dev/pkg/kernel.apu2.git/drivers/usb/host/ehci.h:
In function 'ehci_writel':
/home/nekrad/src/apu2-dev/pkg/kernel.apu2.git/drivers/usb/host/ehci.h:767:3:
error: implicit declaration of function 'writel_be'; did you mean
'writesb'? [-Werror=implicit-function-declaration]
  767 |   writel_be(val, regs) :
      |   ^~~~~~~~~
      |   writesb


It seems that only few archs (microblaze, ppc, sparc) define them.

Also drivers/usb/host/ehci.h defines them, but only for one particular
arch/subarch.

IIRC, these funcs are for accessing hw registers that are in BEs, so
BE cpus can do direct access, while LE cpus need to do a conversion.

OTOH, we also have in_be32() / out_be32. They seem to do quite the same
thing, referenced much more often, but also just defined on a few archs.


I believe we should have generic functions, that all archs implement
(possibly doing automatic conversion, if necessary), which are used
by everybody else.

What's your oppionion on that ?


thanks,

--mtx

-- 
---
Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schlüssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
