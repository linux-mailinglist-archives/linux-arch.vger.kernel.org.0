Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD6B4126A4
	for <lists+linux-arch@lfdr.de>; Mon, 20 Sep 2021 21:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346630AbhITTRw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Sep 2021 15:17:52 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:46559 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230477AbhITTPv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 20 Sep 2021 15:15:51 -0400
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1mSOkA-001iDz-5u; Mon, 20 Sep 2021 21:14:22 +0200
Received: from pd9f7417d.dip0.t-ipconnect.de ([217.247.65.125] helo=[192.168.178.35])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1mSOk9-002NNC-VD; Mon, 20 Sep 2021 21:14:22 +0200
Message-ID: <715c52e6-9a71-6924-0643-407311ad56ba@physik.fu-berlin.de>
Date:   Mon, 20 Sep 2021 21:14:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: Linux 5.15-rc2
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-sparc <sparclinux@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-arch <linux-arch@vger.kernel.org>
References: <CAHk-=wirexiZR+VO=H3xemGKOMkh8OasmXaKXTKUmAKYCzi8AQ@mail.gmail.com>
 <20210920134424.GA346531@roeck-us.net>
 <CAHk-=wgheheFx9myQyy5osh79BAazvmvYURAtub2gQtMvLrhqQ@mail.gmail.com>
 <CAHk-=wgnSFePkt9_TxgdgFvMz6ZyofLFQLuV_Tc7MQVXYdgSng@mail.gmail.com>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
In-Reply-To: <CAHk-=wgnSFePkt9_TxgdgFvMz6ZyofLFQLuV_Tc7MQVXYdgSng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 217.247.65.125
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Linus!

On 9/20/21 19:04, Linus Torvalds wrote:
> On Mon, Sep 20, 2021 at 9:18 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> Anyway, this email ended up being a long explanation of what the code
>> _should_ do, in the hope that some enterprising kernel developer
>> decides "Oh, this sounds like an easy thing to fix". But you do need
>> to be able to test the end result at least a tiny bit.
> 
> In the meantime, the build fix is trivial: make that broken sparc
> pci_iounmap() definition depend on CONFIG_PCI being set.
> 
> But let me build a few more sparc configs (and this time do it
> properly for both 32-bit and 64-bit) before I actually commit it and
> push it out.

If you want to get feedback whether the kernel actually boots, let me know.

I could test boot on a SPARC T5 LDOM (SPARC VM logical domain).

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

