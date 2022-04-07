Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A0A4F780E
	for <lists+linux-arch@lfdr.de>; Thu,  7 Apr 2022 09:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242196AbiDGHtU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 7 Apr 2022 03:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241153AbiDGHtT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 Apr 2022 03:49:19 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F88102428;
        Thu,  7 Apr 2022 00:47:17 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1ncMrC-002Ka1-JA; Thu, 07 Apr 2022 09:47:06 +0200
Received: from p57bd9828.dip0.t-ipconnect.de ([87.189.152.40] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1ncMrC-002YIr-CA; Thu, 07 Apr 2022 09:47:06 +0200
Message-ID: <04c0374f-0044-c84d-1820-d743a4061906@physik.fu-berlin.de>
Date:   Thu, 7 Apr 2022 09:47:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PULL] remove arch/h8300
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>, Rob Landley <rob@landley.net>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>, Max Filippov <jcmvbkbc@gmail.com>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Rich Felker <dalias@libc.org>
References: <Yib9F5SqKda/nH9c@infradead.org>
 <CAK8P3a1dUVsZzhAe81usLSkvH29zHgiV9fhEkWdq7_W+nQBWbg@mail.gmail.com>
 <YkmWh2tss8nXKqc5@infradead.org>
 <CAK8P3a0QdFOJbM72geYTWOKumeKPSCVD8Nje5pBpZWazX0GEnQ@mail.gmail.com>
 <CAMuHMdWcg+171ggdVC4gwbQ=RUf+cYrX3o9uSpDxo-XXEJ5Qgw@mail.gmail.com>
 <c3e7ee64-68fc-ed53-4a90-9f9296583d7c@landley.net>
 <CAK8P3a14b6djqPw8Dea5uW2PPEABbe0pNXV5EX0529oDrW1ZAg@mail.gmail.com>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
In-Reply-To: <CAK8P3a14b6djqPw8Dea5uW2PPEABbe0pNXV5EX0529oDrW1ZAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.152.40
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 4/7/22 09:17, Arnd Bergmann wrote:
> On Wed, Apr 6, 2022 at 11:25 PM Rob Landley <rob@landley.net> wrote:
> 
>> I'm interested in H8300 because it's a tiny architecture (under 6k lines total,
>> in 93 files) and thus a good way to see what a minimal Linux port looks like. If
>> somebody would like to suggest a different one for that...
> 
> Anything that is maintained is usually a better example, and it helps when the
> code is not old enough to have accumulated a lot of historic baggage.

But if it's not a lot of code, would it really accumulate a lot of cruft?

If the code just works as is and doesn't need much attention to keep it working
why not keep it? As long as the code doesn't break anything else what's the
problem with keeping it?

FWIW, the H8 backend in GCC was just recently modernized and improved and converted
to MODE_CC.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

