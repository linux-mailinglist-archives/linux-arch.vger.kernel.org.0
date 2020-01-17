Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1D914069D
	for <lists+linux-arch@lfdr.de>; Fri, 17 Jan 2020 10:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgAQJnz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Jan 2020 04:43:55 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55209 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbgAQJny (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Jan 2020 04:43:54 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1isOAB-0004Zi-B1; Fri, 17 Jan 2020 10:43:35 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id B30BB100C19; Fri, 17 Jan 2020 10:43:34 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Christoph Hellwig <hch@lst.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Paul Burton <paulburton@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        linux-mips@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-s390@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
        x86@kernel.org, Guo Ren <guoren@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Wesley Terpstra <wesley@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra \(Intel\)" <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Chris Zankel <chris@zankel.net>,
        Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        Albert Ou <aou@eecs.berkeley.edu>,
        Vasily Gorbik <gor@linux.ibm.com>,
        James Hogan <jhogan@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH v2 1/2] asm-generic: Make dma-contiguous.h a mandatory include/asm header
In-Reply-To: <0274919c5e3b134df19d943f99cb7e84e5135ccd.1579248206.git.michal.simek@xilinx.com>
References: <cover.1579248206.git.michal.simek@xilinx.com> <0274919c5e3b134df19d943f99cb7e84e5135ccd.1579248206.git.michal.simek@xilinx.com>
Date:   Fri, 17 Jan 2020 10:43:34 +0100
Message-ID: <87y2u6cta1.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Michal Simek <michal.simek@xilinx.com> writes:

> dma-continuguous.h is generic for all architectures except arm32 which has
> its own version.
>
> Similar change was done for msi.h by commit a1b39bae16a6
> ("asm-generic: Make msi.h a mandatory include/asm header")
>
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Acked-by: Thomas Gleixner <tglx@linutronix.de>
