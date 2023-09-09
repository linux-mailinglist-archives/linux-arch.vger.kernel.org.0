Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95289799AB6
	for <lists+linux-arch@lfdr.de>; Sat,  9 Sep 2023 22:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243583AbjIIUMJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 9 Sep 2023 16:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbjIIUMI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 9 Sep 2023 16:12:08 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81577136;
        Sat,  9 Sep 2023 13:12:04 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 97AC9320031A;
        Sat,  9 Sep 2023 16:11:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sat, 09 Sep 2023 16:12:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1694290319; x=1694376719; bh=zFPfJmkCicfpsW/Di0U8iA3BaJhU5h7wnTH
        y7qw0czU=; b=gFy0O1/wAKi4K5GDJJ9Cye9qUwU4RiR4mXj/oed9PUtpOKb5ukt
        8R5ocgXAYJwu5qk1zVqe3sIPt6qZDDkLeGwZAVp+uzsyoL0LFMTy84HPIL1aDt7Q
        8YUcwK20OGbtVZMErC9TPD1HHMPVxPd75g19DqBwzr6yb7H+LfH0MiRoQt2FOhXy
        9Y8OeEaCKnJIGekOYPr9RyfjspMu5ldVcuaADaA0IZ4lADiVvYhsO183D6SBfRKn
        q4jgCxwp7/2pzJmQqyhSQU1pGo9nwf6J5FrLYyNWgDshu+slbNmbj7sw5NdF9qyM
        eGkS30uIVBkCiCeQ/+3h382FKVM/12veeDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1694290319; x=1694376719; bh=zFPfJmkCicfpsW/Di0U8iA3BaJhU5h7wnTH
        y7qw0czU=; b=N+8j8kNhAc0RFRDzU1ddxe8A81rWMqO8xuL+fdT1WwRKlwkCFW9
        P3MOpFj5kA1YOz+ycot5Pf4r4/0YuYi1ACXlR2VUIAA4de8eFr8W76hSPJ2nwScP
        gFUVXFXfag98IE83rHDBX3Dcsi0yBdenU7f5UVnvsDB5DiAloDYEZ0ObtbXwES1X
        qmOw3swBG6OvrzxCJfTk7t+ONkC96QrzENw8X8cjFGuxIuW0faiK72AtxDgFBI8M
        BtlFz5CJxhjmV6oQEJIslkty6TKRi5RWMC7GsXHsQWzsudTOOVM8Ry1G3j4nfAEc
        3lpNoEvdvFwN5QGPtR5bSWj0/eG/KgLRyAw==
X-ME-Sender: <xms:jtH8ZJCZJr-ISXwvM97HIa0hXnp2P2UKkMLMtecNx0eRMiHRBJRqAQ>
    <xme:jtH8ZHjeHMoQi6HOYwwVd-sPvFSlLcxIP6pMw7Tq-Hph-vBy-H_p0YOYQpYqGqa4b
    ZI82bpN87SLTYnp3Q>
X-ME-Received: <xmr:jtH8ZEnhKhy-BmMkDPFWzS1SP9_OPftPmst665cn21gp7qZ34bxdaIKBhs7HjTJgLXkYGDOvWs_gkr2wqQrKIHf1X60DFZf3DR-zDfY0CKkKLjoO9TrsceEfEw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudehledgudeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuvfhfvefhjggtgfesthejredttdefjeenucfhrhhomhepufgr
    mhhuvghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqne
    cuggftrfgrthhtvghrnhepffeliefgfefhgfelueejkeefueffteeiiefhudeghfeuleff
    geefleelgeegtdffnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhl
    lhgrnhgurdhorhhg
X-ME-Proxy: <xmx:jtH8ZDzu2MaUeLfILkpT2Fe5ReUb89yNSeLMTiaMe9CTCKe5Vqqd7Q>
    <xmx:jtH8ZOQb-3PqEXEVcNnEspKrJ49RWddKXx_brPTZ-fGhzUI5LJA5Mg>
    <xmx:jtH8ZGZUEOx0kAbo479CiMdBcjTJ2-AnnGNvqsQSoUdoob2y3Li_gQ>
    <xmx:j9H8ZIDMavRXNS-pKzc9aEEwVMAG_SxqyC0PcrxrP3jF9EGl4tjF4Q>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 Sep 2023 16:11:57 -0400 (EDT)
Message-ID: <bd7f8612-e9bf-deab-450d-f0cde52cdd1b@sholland.org>
Date:   Sat, 9 Sep 2023 15:11:56 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 0/4] riscv: tlb flush improvements
Content-Language: en-US
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
References: <20230801085402.1168351-1-alexghiti@rivosinc.com>
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
From:   Samuel Holland <samuel@sholland.org>
In-Reply-To: <20230801085402.1168351-1-alexghiti@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 8/1/23 03:53, Alexandre Ghiti wrote:
> This series optimizes the tlb flushes on riscv which used to simply
> flush the whole tlb whatever the size of the range to flush or the size
> of the stride.
> 
> Patch 3 introduces a threshold that is microarchitecture specific and
> will very likely be modified by vendors, not sure though which mechanism
> we'll use to do that (dt? alternatives? vendor initialization code?).

Certainly we would want to set the threshold to zero on SiFive platforms
affected by CIP-1200, since they cannot use address-based sfence.vma at
all. At least this case could be handled in the existing errata patch
function. I don't know about other platforms.

Regards,
Samuel

> 
> Next steps would be to implement:
> - svinval extension as Mayuresh did here [1]
> - BATCHED_UNMAP_TLB_FLUSH (I'll wait for arm64 patchset to land)
> - MMU_GATHER_RCU_TABLE_FREE
> - MMU_GATHER_MERGE_VMAS
> 
> Any other idea welcome.
> 
> [1] https://lore.kernel.org/linux-riscv/20230623123849.1425805-1-mchitale@ventanamicro.com/
> 
> Changes in v3:
> - Add RB from Andrew, thanks!
> - Unwrap a few lines, as suggested by Andrew
> - Introduce defines for -1 constants used in tlbflush.c, as suggested by Andrew and Conor
> - Use huge_page_size() directly instead of using the shift, as suggested by Andrew
> - Remove misleading comments as suggested by Conor
> 
> Changes in v2:
> - Make static tlb_flush_all_threshold, we'll figure out later how to
>   override this value on a vendor basis, as suggested by Conor and Palmer
> - Fix nommu build, as reported by Conor
> 
> Alexandre Ghiti (4):
>   riscv: Improve flush_tlb()
>   riscv: Improve flush_tlb_range() for hugetlb pages
>   riscv: Make __flush_tlb_range() loop over pte instead of flushing the
>     whole tlb
>   riscv: Improve flush_tlb_kernel_range()
> 
>  arch/riscv/include/asm/tlb.h      |  8 ++-
>  arch/riscv/include/asm/tlbflush.h | 12 ++--
>  arch/riscv/mm/tlbflush.c          | 98 ++++++++++++++++++++++++++-----
>  3 files changed, 99 insertions(+), 19 deletions(-)
> 

