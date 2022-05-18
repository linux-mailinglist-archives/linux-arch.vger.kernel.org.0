Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB0952C0D9
	for <lists+linux-arch@lfdr.de>; Wed, 18 May 2022 19:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240255AbiERQ2x (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 May 2022 12:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240228AbiERQ2s (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 May 2022 12:28:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4012C1F7E01;
        Wed, 18 May 2022 09:28:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B5B4FB82160;
        Wed, 18 May 2022 16:28:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88DE6C385A9;
        Wed, 18 May 2022 16:28:41 +0000 (UTC)
Date:   Wed, 18 May 2022 17:28:38 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Tong Tiangen <tongtiangen@huawei.com>
Cc:     Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, wangkefeng.wang@huawei.com,
        Guohanjun <guohanjun@huawei.com>,
        Xie XiuQi <xiexiuqi@huawei.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH -next 2/2] arm64/mm: fix page table check compile error
 for CONFIG_PGTABLE_LEVELS=2
Message-ID: <YoUetqxz7Q38RLAu@arm.com>
References: <20220517074548.2227779-1-tongtiangen@huawei.com>
 <20220517074548.2227779-3-tongtiangen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517074548.2227779-3-tongtiangen@huawei.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 17, 2022 at 07:45:48AM +0000, Tong Tiangen wrote:
> If CONFIG_PGTABLE_LEVELS=2 and CONFIG_ARCH_SUPPORTS_PAGE_TABLE_CHECK=y,
> then we trigger a compile error:
> 
>   error: implicit declaration of function 'pte_user_accessible_page'
> 
> Move the definition of page table check helper out of branch
> CONFIG_PGTABLE_LEVELS > 2
> 
> Fixes: daf214c14dbe ("arm64/mm: enable ARCH_SUPPORTS_PAGE_TABLE_CHECK")
> Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>

I'd drop the fixes tag here since the patch is queued in the mm tree and
AFAIK that one doesn't have stable git commit ids. Otherwise:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

(I cc'ed Andrew and linux-mm as Andrew queued the original patches)
