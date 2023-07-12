Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD371750C40
	for <lists+linux-arch@lfdr.de>; Wed, 12 Jul 2023 17:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjGLPTU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Jul 2023 11:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233629AbjGLPTI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Jul 2023 11:19:08 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB4326A5;
        Wed, 12 Jul 2023 08:18:36 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id ABE1CC000B;
        Wed, 12 Jul 2023 15:18:00 +0000 (UTC)
Message-ID: <bbda29db-644d-ed9b-2894-43f4c2addb52@ghiti.fr>
Date:   Wed, 12 Jul 2023 17:18:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/4] riscv: tlb flush improvements
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Will Deacon <will@kernel.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230711075434.10936-1-alexghiti@rivosinc.com>
 <20230712-void-sniff-ca1abcbc7783@wendy>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20230712-void-sniff-ca1abcbc7783@wendy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Conor,


On 12/07/2023 09:08, Conor Dooley wrote:
> Hey Alex,
>
> On Tue, Jul 11, 2023 at 09:54:30AM +0200, Alexandre Ghiti wrote:
>> This series optimizes the tlb flushes on riscv which used to simply
>> flush the whole tlb whatever the size of the range to flush or the size
>> of the stride.
>>
>> Patch 3 introduces a threshold that is microarchitecture specific and
>> will very likely be modified by vendors, not sure though which mechanism
>> we'll use to do that (dt? alternatives? vendor initialization code?).


@Conor any idea how to achieve this?


>>
>> Next steps would be to implement:
>> - svinval extension as Mayuresh did here [1]
>> - BATCHED_UNMAP_TLB_FLUSH (I'll wait for arm64 patchset to land)
>> - MMU_GATHER_RCU_TABLE_FREE
>> - MMU_GATHER_MERGE_VMAS
>>
>> Any other idea welcome.
>>
>> [1] https://lore.kernel.org/linux-riscv/20230623123849.1425805-1-mchitale@ventanamicro.com/
>>
>> Alexandre Ghiti (4):
>>    riscv: Improve flush_tlb()
>>    riscv: Improve flush_tlb_range() for hugetlb pages
>>    riscv: Make __flush_tlb_range() loop over pte instead of flushing the
>>      whole tlb
> The whole series does not build on nommu & this one adds a build warning
> for regular builds:
> +      1 ../arch/riscv/mm/tlbflush.c:32:15: warning: symbol 'tlb_flush_all_threshold' was not declared. Should it be static?
>
> Cheers,
> Conor.


I'll fix the nommu build, sorry about that. Weird I missed this warning, 
that's an LLVM build right? That variable will need to overwritten by 
the vendors, so that should not be static (but it will depend on what 
solution we implement).


Thanks,


Alex


