Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C130452C198
	for <lists+linux-arch@lfdr.de>; Wed, 18 May 2022 19:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240938AbiERRNt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 May 2022 13:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240928AbiERRNs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 May 2022 13:13:48 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F4013CA1F;
        Wed, 18 May 2022 10:13:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 88822CE205F;
        Wed, 18 May 2022 17:13:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C66C385A9;
        Wed, 18 May 2022 17:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652894023;
        bh=9tQumf5hmMksHJMd0ddXQO4pdkF9lxtXV2d4XMaXLMg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1oFQORUH8huv1XWXl2XhwSl42RUHMTVMSUF7MmvBgM1HLhRrMGez+Fyr6OoiM2x+s
         jnKUKKp268ix7GKNohFVUZ0gACXAWGr0IQXMoQV2FPJw+yFPDX/v3BNy3B6zB0dgBH
         uhYm1Jy8z93pfIewz5emoCFiPAMatvkJ7i8n8VIw=
Date:   Wed, 18 May 2022 10:13:42 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Tong Tiangen <tongtiangen@huawei.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, wangkefeng.wang@huawei.com,
        Guohanjun <guohanjun@huawei.com>,
        Xie XiuQi <xiexiuqi@huawei.com>, linux-mm@kvack.org
Subject: Re: [PATCH -next 2/2] arm64/mm: fix page table check compile error
 for CONFIG_PGTABLE_LEVELS=2
Message-Id: <20220518101342.b1b17ab43331f31df33780ae@linux-foundation.org>
In-Reply-To: <YoUetqxz7Q38RLAu@arm.com>
References: <20220517074548.2227779-1-tongtiangen@huawei.com>
        <20220517074548.2227779-3-tongtiangen@huawei.com>
        <YoUetqxz7Q38RLAu@arm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 18 May 2022 17:28:38 +0100 Catalin Marinas <catalin.marinas@arm.com> wrote:

> On Tue, May 17, 2022 at 07:45:48AM +0000, Tong Tiangen wrote:
> > If CONFIG_PGTABLE_LEVELS=2 and CONFIG_ARCH_SUPPORTS_PAGE_TABLE_CHECK=y,
> > then we trigger a compile error:
> > 
> >   error: implicit declaration of function 'pte_user_accessible_page'
> > 
> > Move the definition of page table check helper out of branch
> > CONFIG_PGTABLE_LEVELS > 2
> > 
> > Fixes: daf214c14dbe ("arm64/mm: enable ARCH_SUPPORTS_PAGE_TABLE_CHECK")
> > Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
> 
> I'd drop the fixes tag here since the patch is queued in the mm tree and
> AFAIK that one doesn't have stable git commit ids.

MM tree is at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Commit ID's are stable if a commit is in the mm-hotfixes-stable,
mm-stable or mm-nonmm-stable branch.

Commit ID's are unstable if a commit is still in the
mm-hotfixes-unstable, mm-unstable or mm-unnonmm-stable.

I move patches from -unstable to -stable after they're considered ready
for it.  The delay is very variable, depends on how things are coming
along with that patch(set).


