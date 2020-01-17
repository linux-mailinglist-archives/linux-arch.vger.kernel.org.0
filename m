Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFAB140798
	for <lists+linux-arch@lfdr.de>; Fri, 17 Jan 2020 11:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgAQKKb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Jan 2020 05:10:31 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:51849 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729211AbgAQKK3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Jan 2020 05:10:29 -0500
Received: from mail-qt1-f179.google.com ([209.85.160.179]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1Mo7if-1jPZsX3TI3-00papY; Fri, 17 Jan 2020 11:10:27 +0100
Received: by mail-qt1-f179.google.com with SMTP id w8so6929852qts.11;
        Fri, 17 Jan 2020 02:10:26 -0800 (PST)
X-Gm-Message-State: APjAAAUEDzsZQi9ARRL4u2fVW9n7pv71gxBBz7zQFldLOUe+9rwitPKI
        y2LXShZzdxt1zNksoOxbOwYUoHYVgj34QmX8Xsk=
X-Google-Smtp-Source: APXvYqwJseIcLf52SoCo+jtyEMNWCmLScJZGo/aM/tEE3YgOeqebesjzIckzh3dwWAmCE7mLdstmifhUAdg/ilxjg+0=
X-Received: by 2002:ac8:768d:: with SMTP id g13mr6672928qtr.7.1579255825449;
 Fri, 17 Jan 2020 02:10:25 -0800 (PST)
MIME-Version: 1.0
References: <cover.1579248206.git.michal.simek@xilinx.com> <0274919c5e3b134df19d943f99cb7e84e5135ccd.1579248206.git.michal.simek@xilinx.com>
In-Reply-To: <0274919c5e3b134df19d943f99cb7e84e5135ccd.1579248206.git.michal.simek@xilinx.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 17 Jan 2020 11:10:09 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3bfO9EdL6o4+yY5BCw0pc1ANYocVjyohmG34jcjLiWpA@mail.gmail.com>
Message-ID: <CAK8P3a3bfO9EdL6o4+yY5BCw0pc1ANYocVjyohmG34jcjLiWpA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] asm-generic: Make dma-contiguous.h a mandatory
 include/asm header
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>, git@xilinx.com,
        Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Paul Burton <paulburton@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-riscv@lists.infradead.org,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Guo Ren <guoren@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Wesley Terpstra <wesley@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Chris Zankel <chris@zankel.net>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Vasily Gorbik <gor@linux.ibm.com>,
        James Hogan <jhogan@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:NoA6lR5asYNCyYKhe9jWMGVyZrcIPwFSmU/9i+MCsvjD7l/q+0E
 xamkGFPsa8WqWcpoTbKLa0HTFaxvsRDU3Yg1Tjs5VjPvEa0YzXlOTtB3H+HkUQLhOK18FNM
 T7d7QrUxg40WjYU29hDjIqfDeU8vaco2MiUSREKxtCEILK7r8Ok0/re0d55j9UMA+dbmPdd
 Q5ORnP1qoOhIYkN4s6C9Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:moewDwzL1zY=:Og/pj7BHnPsRu+8o/xR4jd
 /5FTFityP5vYdrAZ8u4f+NKv6rFWAXiKCGvUNOrKPS+uozyMXVzFVn9mn0BNuk49R4sTcvGiV
 /3mU1R1HdB6XM0NufLzKsZrh0bOP0zuW69QDX6Jf3/888gGK83uWEwGF/h0j5Sq6Fq9ieEunq
 rnRa+FNRnArnru6lWAqxwFLeodgnvUTEje6C2luxM/rv31CP97nI76r/sNggx0LoD25sgb+wk
 B4fXK4r6rHxmJpsUAB4TFHFVkBQ35xEtPP1HvFhDh9jiHrI8kn86LUg/TDDRub1/uVZ7zCklw
 FDS90rkhZDfEgOXuXMmplYuydxFxZ5J5rn5dd83zA6L3Mjgy2FG6ES8eKWzao4YVmB9Wduf7P
 xT9wsLcqqiDWbnzXGf4zKotbSRmzPh5Fv++MirVf8JMCdAzbBT0boZwPJ6iWrfkU/YCcUH7pG
 WeE0UXuRO3RVbgnexVPjLzBKZyX6YPi3extl0jEV7d8yqASmv/Kl5Qf4/pnLN02wxwhhDjRSo
 LfvutuyEY11++msvCeKnQeitTSrwLo+R/VB6KHb8Ji1Zlk79m51hBudGDrxCvGbngglFlj1/5
 Aj3Kb7UwL+cXDLCuBCzC7JgcoIMS3ojk07wwIA4kF8iAyNKRU1CwXQK9oLVpyUY3ueqglKHkM
 4gWKEIE7xrnrIqcQYwa5Q3CQNWVMakSQo08oLy0UxUEp3jPx86yTFLpOurDppOZ+TUgS5z6t5
 TN+j9px/tXMV5B/LPPgcBZfaFFBxvYLBGZtBgt/V/CIQhXpE+NReitfu1neyJdDTkzpFVQzzK
 ZLa+TVfzc5R8QNK8838TmlIcv70M4a/zkgtTMAfBbxA24lD4vyG0JIDnIcKdsI+MjZabomZMp
 X8KXQN2N5yTRNHF73S3w==
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 17, 2020 at 9:03 AM Michal Simek <michal.simek@xilinx.com> wrote:
>
> dma-continuguous.h is generic for all architectures except arm32 which has
> its own version.
>
> Similar change was done for msi.h by commit a1b39bae16a6
> ("asm-generic: Make msi.h a mandatory include/asm header")
>
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>
> Changes in v2:
> - New patch suggested by Christoph

Acked-by: Arnd Bergmann <arnd@arndb.de>
