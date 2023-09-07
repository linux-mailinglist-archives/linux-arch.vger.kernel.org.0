Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7FB979753C
	for <lists+linux-arch@lfdr.de>; Thu,  7 Sep 2023 17:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234772AbjIGPq4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 7 Sep 2023 11:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244599AbjIGP3J (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 7 Sep 2023 11:29:09 -0400
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162EEE7F;
        Thu,  7 Sep 2023 08:28:38 -0700 (PDT)
Received: from relay2-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::222])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id CA594C1BA0;
        Thu,  7 Sep 2023 13:48:19 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1B6A040026;
        Thu,  7 Sep 2023 13:47:52 +0000 (UTC)
Message-ID: <4c4bb7ec-9ad8-6b6a-cea0-a4c779db6ac3@ghiti.fr>
Date:   Thu, 7 Sep 2023 15:47:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3 4/4] riscv: Improve flush_tlb_kernel_range()
Content-Language: en-US
To:     Nadav Amit <nadav.amit@gmail.com>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Will Deacon <will@kernel.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux-arch@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>, linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>
References: <20230801085402.1168351-1-alexghiti@rivosinc.com>
 <20230801085402.1168351-5-alexghiti@rivosinc.com>
 <CA+V-a8t56xDqMTQfoKcsvPF8errkTMydaDz5V6nejLvVfJrW3g@mail.gmail.com>
 <C92430BE-4DA3-487B-BFD2-58EE4A93396F@gmail.com>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <C92430BE-4DA3-487B-BFD2-58EE4A93396F@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Nadav,

On 06/09/2023 22:22, Nadav Amit wrote:
>
>> On Sep 6, 2023, at 4:48 AM, Lad, Prabhakar <prabhakar.csengg@gmail.com> wrote:
>>
>> Hi Alexandre,
>>
>> On Tue, Aug 1, 2023 at 9:58 AM Alexandre Ghiti <alexghiti@rivosinc.com> wrote:
>>> This function used to simply flush the whole tlb of all harts, be more
>>> subtile and try to only flush the range.
>>>
>>> The problem is that we can only use PAGE_SIZE as stride since we don't know
>>> the size of the underlying mapping and then this function will be improved
>>> only if the size of the region to flush is < threshold * PAGE_SIZE.
>>>
>>> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>>> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
>>> ---
>>> arch/riscv/include/asm/tlbflush.h | 11 +++++-----
>>> arch/riscv/mm/tlbflush.c          | 34 +++++++++++++++++++++++--------
>>> 2 files changed, 31 insertions(+), 14 deletions(-)
>>>
>> After applying this patch, I am seeing module load issues on RZ/Five
>> (complete log [0]). I am testing defconfig + [1] (rz/five related
>> configs).
>>
>> Any pointers on what could be an issue here?
> None of my business, but looking at your code, it seems that you do not memory
> barrier before reading mm_cpumask() in __flush_tlb_range(). I believe you
> would want to synchronize __flush_tlb_range with switch_mm() similarly to the
> way it is done in x86.
>

Noted, I'll take a look at that, thanks for the advice!

Alex

