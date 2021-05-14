Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85B5338074B
	for <lists+linux-arch@lfdr.de>; Fri, 14 May 2021 12:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbhENKfv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 May 2021 06:35:51 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:49671 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232200AbhENKfr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 14 May 2021 06:35:47 -0400
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1lhV9N-003KKt-2u; Fri, 14 May 2021 12:34:33 +0200
Received: from dynamic-089-012-149-178.89.12.pool.telefonica.de ([89.12.149.178] helo=[192.168.1.10])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1lhV9M-002u9m-Rx; Fri, 14 May 2021 12:34:33 +0200
Subject: Re: [PATCH v2 03/13] sh: remove unaligned access for sh4a
To:     Arnd Bergmann <arnd@kernel.org>, linux-arch@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210514100106.3404011-1-arnd@kernel.org>
 <20210514100106.3404011-4-arnd@kernel.org>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <3d70eb2a-2969-197e-63e8-f3e0a6a8ddd8@physik.fu-berlin.de>
Date:   Fri, 14 May 2021 12:34:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210514100106.3404011-4-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 89.12.149.178
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Arnd!

On 5/14/21 12:00 PM, Arnd Bergmann wrote:
> Unlike every other architecture, sh4a uses an inline asm implementation
> for get_unaligned(). I have shown that this produces better object
> code than the asm-generic version. However, there are very few users of
> arch/sh/ overall, and most of those seem to use sh4 rather than sh4a CPU
> cores, so it seems not worth keeping the complexity in the architecture
> independent code.

My Renesas SH4-Boards actually run an sh4a-Kernel, not an sh4-Kernel:

root@tirpitz:~> uname -a
Linux tirpitz 5.11.0-rc4-00012-g10c03c5bf422 #161 PREEMPT Mon Jan 18 21:10:17 CET 2021 sh4a GNU/Linux
root@tirpitz:~>

So, if this change reduces performance on sh4a, I would rather not merge it.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
