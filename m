Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB155520C84
	for <lists+linux-arch@lfdr.de>; Tue, 10 May 2022 06:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235812AbiEJEIH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 10 May 2022 00:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbiEJEIG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 10 May 2022 00:08:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D074CD65;
        Mon,  9 May 2022 21:04:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C672FB81AE7;
        Tue, 10 May 2022 04:04:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 748DCC385A6;
        Tue, 10 May 2022 04:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652155446;
        bh=6OF+9C9FRL/t2E9bNeco9SygrOB7dQke1qTazheJwmM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=r+cD5N6bK5cMK3KiBjz/TIE0kRJfxClVYedgOaDY6iruFtbN69I0EnTrs28Odgw2B
         MPfR9kQZKLh7AzrNokC+xb2QjO4x0B/CskDab9TBGZx07zjP3Yerqr9YNFkFVMGD3p
         VJh3Vtf4VnZ1h7g0napFf0tAy+VjYNyYdsYerxPc=
Date:   Mon, 9 May 2022 21:04:04 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     mike.kravetz@oracle.com, catalin.marinas@arm.com, will@kernel.org,
        songmuchun@bytedance.com, tsbogend@alpha.franken.de,
        James.Bottomley@HansenPartnership.com, deller@gmx.de,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        ysato@users.osdn.me, dalias@libc.org, davem@davemloft.net,
        arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 0/3] Fix CONT-PTE/PMD size hugetlb issue when
 unmapping or migrating
Message-Id: <20220509210404.6a43aff15d0d6b3af0741001@linux-foundation.org>
In-Reply-To: <cover.1652147571.git.baolin.wang@linux.alibaba.com>
References: <cover.1652147571.git.baolin.wang@linux.alibaba.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 10 May 2022 11:45:57 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:

> Hi,
> 
> Now migrating a hugetlb page or unmapping a poisoned hugetlb page, we'll
> use ptep_clear_flush() and set_pte_at() to nuke the page table entry
> and remap it, and this is incorrect for CONT-PTE or CONT-PMD size hugetlb
> page,

It would be helpful to describe why it's wrong.  Something like "should
use huge_ptep_clear_flush() and huge_ptep_clear_flush() for this
purpose"?

> which will cause potential data consistent issue. This patch set
> will change to use hugetlb related APIs to fix this issue, please find
> details in each patch. Thanks.

Is a cc:stable needed here?  And are we able to identify a target for a
Fixes: tag?


