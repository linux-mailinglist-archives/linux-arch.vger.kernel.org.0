Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5FA1408D9
	for <lists+linux-arch@lfdr.de>; Fri, 17 Jan 2020 12:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgAQLXs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Jan 2020 06:23:48 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:51133 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbgAQLXr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Jan 2020 06:23:47 -0500
Received: from mail-qt1-f172.google.com ([209.85.160.172]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MZCX1-1j5QHY2xEn-00V6oc; Fri, 17 Jan 2020 12:23:45 +0100
Received: by mail-qt1-f172.google.com with SMTP id w47so21472012qtk.4;
        Fri, 17 Jan 2020 03:23:45 -0800 (PST)
X-Gm-Message-State: APjAAAWpDkR505DpUSrB+mwD4UiSMh6wouTVvTnUJKE/MOEe0a91APQm
        Pb5WQBHH+C/O3a/WBTA+ii9h4GkFiFLkb+GZvWw=
X-Google-Smtp-Source: APXvYqyvj+qVxj0YCsmU7P1XOliY6rtqSxryof0W+wMqmW4n2F+6uFJgm4139nMmKoUQOXfgYZ5UmpVyaFMrptCFtJ8=
X-Received: by 2002:ac8:47d3:: with SMTP id d19mr6878361qtr.142.1579260224350;
 Fri, 17 Jan 2020 03:23:44 -0800 (PST)
MIME-Version: 1.0
References: <cover.1579248206.git.michal.simek@xilinx.com> <0274919c5e3b134df19d943f99cb7e84e5135ccd.1579248206.git.michal.simek@xilinx.com>
In-Reply-To: <0274919c5e3b134df19d943f99cb7e84e5135ccd.1579248206.git.michal.simek@xilinx.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 17 Jan 2020 12:23:28 +0100
X-Gmail-Original-Message-ID: <CAK8P3a14ASj7Bq7pntaxPRomGKfAALyD6GGR-APYEdh=ja6UkQ@mail.gmail.com>
Message-ID: <CAK8P3a14ASj7Bq7pntaxPRomGKfAALyD6GGR-APYEdh=ja6UkQ@mail.gmail.com>
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
X-Provags-ID: V03:K1:iqPNv77XDTa0tcdeV36iCL4kfPwGX7DaQUkNLXyOMGI9eqV7hw2
 H7H8wvbSYKPKWAxlikAxs4SyQ4WFfIGfTkBuPuxFJAcjkRVoKvBAGMdd+0AqrQ4kYmZDv56
 NG+o9UWNcnUqnGfCH4/xpJ5H5A1z2RWo9rsTO0Do372LyosgOEHVZX37UPM+oR/3H3ZmjJ8
 Lit61zkwDJd0i4MTP7/4Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:cdafQtaYOIk=:zkk7ZvnyKm5EzeZkRU0des
 8xFhpBTVhX8NAcMqv/hFyL+BrjmrPh0+fIBEHTwIEGkx4HvtTmJmd/nd0m3mdhAyLNJCgGdt3
 zHQq2IfKyssLKH1Yf+aJNRxaL00wTSm18klJP5cO+mMv2n8mbjpgmoKy9atPR6UWlSjH546kr
 NRm/2oTKKd5WLZC7Q1gXGTw+JijjwIJ+r+g8CVz12+KPeFqgvNxPklu40Aai8drjGQwO/WLnJ
 M4xiBOwQACAV78iS0mnZ6IuPR35mSbKJVgDHlxVpSabIwgv4CildM6wTWYcSPhtrrgfsm51zC
 X38DppkbP8Ulu0LpD99CUPLs8ArVPgH6L0D3WsCgUAsDWG1weey2RBOOAulBOdpgwGIJ/aTJG
 pap0Ml9aoFI5gYwz1h7SEBrRqbAwNrK2cSlCIDjMhJh2X1JIHFXFJLXFdtYYb+DAOtlJOEMvG
 f8Pe10L0ZudN1b8VLNG83uuCAJefv391N1G6sjjiOSo0vqZRDi5UaljwHD8w4muPGhTOPMnJt
 z5zGUZhHLl8pKBCuyvSvgjR3YULaDGszzZvoyzLJ1FB1S0pfj+Gk6LlZLTecI+qaq+Sb752Mr
 W56rj7Jlw2mo1n6c8WVbyA+mPO7L4Ls2FEoTR6PoXv/BvSJoUxfp8l9i1pSLWKd6PCx3PUQ+U
 k4tBMNo9uPeYOOzuOYXNyTUv07SX2ChoeSjJYRaD10+QlbfNRNCl80o4OOet7V4sc0eSW2L/2
 y4yzX7iJQm93yFo1nFXHUAqr27x5yIwy789HxeTdtdFbU3hHrXJLXQxU6tIlLjSqrxQSkzwXf
 t3B+lU27NtDFgYsH1mQA8h0IulyXdVJCsHk3z2h0luNa6cBukEVBkGJMIxtwUz+EI7Dc6Vu61
 I0+Q378NUSEsEKgowPXw==
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

Acked-by: Arnd Bergmann <arnd@arndb.de>
