Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68BCC381996
	for <lists+linux-arch@lfdr.de>; Sat, 15 May 2021 17:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbhEOPiL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 15 May 2021 11:38:11 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:37731 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232773AbhEOPiK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Sat, 15 May 2021 11:38:10 -0400
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1lhwLX-0015oL-08; Sat, 15 May 2021 17:36:55 +0200
Received: from pd9f74b7b.dip0.t-ipconnect.de ([217.247.75.123] helo=[192.168.178.23])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1lhwLW-001yNF-PF; Sat, 15 May 2021 17:36:54 +0200
Subject: Re: [PATCH v2 03/13] sh: remove unaligned access for sh4a
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210514100106.3404011-1-arnd@kernel.org>
 <20210514100106.3404011-4-arnd@kernel.org>
 <3d70eb2a-2969-197e-63e8-f3e0a6a8ddd8@physik.fu-berlin.de>
 <CAK8P3a1oO_moABCtNqLkM9ccVh9c=andfz+qiSucTCXcqJkYVA@mail.gmail.com>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <71b5d15d-7bd2-aa08-cc0a-3caccf9c66c8@physik.fu-berlin.de>
Date:   Sat, 15 May 2021 17:36:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1oO_moABCtNqLkM9ccVh9c=andfz+qiSucTCXcqJkYVA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 217.247.75.123
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Arnd!

On 5/14/21 2:22 PM, Arnd Bergmann wrote:
>> My Renesas SH4-Boards actually run an sh4a-Kernel, not an sh4-Kernel:
>>
>> root@tirpitz:~> uname -a
>> Linux tirpitz 5.11.0-rc4-00012-g10c03c5bf422 #161 PREEMPT Mon Jan 18 21:10:17 CET 2021 sh4a GNU/Linux
>> root@tirpitz:~>
>>
>> So, if this change reduces performance on sh4a, I would rather not merge it.
> 
> It only makes a difference in very specific scenarios in which unaligned
> accesses are done in a fast path, e.g. when forwarding network packet
> at a high rate on a big-endian kernel (little-endian kernels wouldn't run into
> this on IP headers). If you have a use case for this machine on which the
> you can show a performance regression, I can add a patch on top to put
> the optimized sh4a get_unaligned_le32() back. Dropping this patch
> altogether would make the series much more complex because most of
> the associated code gets removed in the end.

Hmm, okay. But why does code which sits below arch/sh have to be removed anyway?

I don't fully understand why it poses any maintenance burden/

> As I mentioned, supporting "movua" in the compiler likely has a much
> larger impact on performance, as it would also help in user space, and
> it should improve the networking case on little-endian kernels by replacing
> the four separate byte loads/shift pairs with a movua plus a byteswap.

The problem is that - at least in Debian - we use the sh4 baseline while the kernel
supports both sh4 and sh4a, so we can't use any of these instructions in userland at
the moment.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
