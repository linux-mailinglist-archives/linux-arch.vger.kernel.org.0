Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4451D1B728F
	for <lists+linux-arch@lfdr.de>; Fri, 24 Apr 2020 13:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgDXLA5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 Apr 2020 07:00:57 -0400
Received: from foss.arm.com ([217.140.110.172]:59820 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbgDXLA5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 24 Apr 2020 07:00:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3BF01FB;
        Fri, 24 Apr 2020 04:00:55 -0700 (PDT)
Received: from [10.57.33.170] (unknown [10.57.33.170])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 385363F6CF;
        Fri, 24 Apr 2020 04:00:53 -0700 (PDT)
Subject: Re: [PATCH v4 05/11] arm64: csum: Disable KASAN for do_csum()
To:     David Laight <David.Laight@ACULAB.COM>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kernel-team@android.com" <kernel-team@android.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
References: <20200421151537.19241-1-will@kernel.org>
 <20200421151537.19241-6-will@kernel.org>
 <20200422094951.GA54428@lakrids.cambridge.arm.com>
 <20200422104138.GA30265@willie-the-truck>
 <6efa0cc1-bd3e-b9b6-4e69-7ac05e6efe35@arm.com>
 <db86e9fa88754d59ac5f8d3f4fe0f9a3@AcuMS.aculab.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <a4ddb547-ea46-d79d-3088-a97b9a033997@arm.com>
Date:   Fri, 24 Apr 2020 12:00:52 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <db86e9fa88754d59ac5f8d3f4fe0f9a3@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2020-04-24 10:41 am, David Laight wrote:
> From: Robin Murphy
>> Sent: 22 April 2020 12:02
> ..
>> Sure - I have a nagging feeling that it could still do better WRT
>> pipelining the loads anyway, so I'm happy to come back and reconsider
>> the local codegen later. It certainly doesn't deserve to stand in the
>> way of cross-arch rework.
> 
> How fast does that loop actually run?

I've not characterised it in detail, but faster than any of the other 
attempts so far ;)

> To my mind it seems to do a lot of operations on each 64bit value.
> I'd have thought that a loop based on:
> 	sum64 = *ptr;
> 	sum64_high = *ptr++ >> 32;
> and then fixing up the result would be faster.
> 
> The x86-64 code is also bad!
> On intel cpu prior to haswell a simple:
> 	sum_64 += *ptr32++;
> is faster than the current code.
> (Although you can do a lot better even on ivy bridge.)

The aim here is to minimise load bandwidth - most Arm cores can slurp 16 
bytes from L1 in a single load as quickly as any smaller amount, so 
nibbling away in little 32-bit chunks would result in up to 4x more load 
cycles. Yes, the C code looks ridiculous, but the other trick is that 
most of those operations don't actually exist. Since a __uint128_t is 
really backed by any two 64-bit GPRs - or if you're careful, one 64-bit 
GPR and the carry flag - all those shifts and rotations are in fact 
resolved by register allocation, so what we end up with is a very neat 
loop of essentially just loads and 64-bit accumulation:

...
  138:   a94030c3        ldp     x3, x12, [x6]
  13c:   a9412cc8        ldp     x8, x11, [x6, #16]
  140:   a94228c4        ldp     x4, x10, [x6, #32]
  144:   a94324c7        ldp     x7, x9, [x6, #48]
  148:   ab03018d        adds    x13, x12, x3
  14c:   510100a5        sub     w5, w5, #0x40
  150:   9a0c0063        adc     x3, x3, x12
  154:   ab08016c        adds    x12, x11, x8
  158:   9a0b0108        adc     x8, x8, x11
  15c:   ab04014b        adds    x11, x10, x4
  160:   9a0a0084        adc     x4, x4, x10
  164:   ab07012a        adds    x10, x9, x7
  168:   9a0900e7        adc     x7, x7, x9
  16c:   ab080069        adds    x9, x3, x8
  170:   9a080063        adc     x3, x3, x8
  174:   ab070088        adds    x8, x4, x7
  178:   9a070084        adc     x4, x4, x7
  17c:   910100c6        add     x6, x6, #0x40
  180:   ab040067        adds    x7, x3, x4
  184:   9a040063        adc     x3, x3, x4
  188:   ab010064        adds    x4, x3, x1
  18c:   9a030023        adc     x3, x1, x3
  190:   710100bf        cmp     w5, #0x40
  194:   aa0303e1        mov     x1, x3
  198:   54fffd0c        b.gt    138 <do_csum+0xd8>
...

Instruction-wise, that's about as good as it can get short of 
maintaining multiple accumulators and moving the pairwise folding out of 
the loop. The main thing that I think is still left on the table is that 
the load-to-use distances are pretty short and there's clearly scope to 
spread out and amortise the load cycles better, which stands to benefit 
both big and little cores.

Robin.
