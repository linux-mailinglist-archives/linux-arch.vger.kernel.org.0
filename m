Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE214B4C74
	for <lists+linux-arch@lfdr.de>; Mon, 14 Feb 2022 11:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350222AbiBNKlu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Feb 2022 05:41:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348737AbiBNKkI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Feb 2022 05:40:08 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB2E2A9970;
        Mon, 14 Feb 2022 02:04:08 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CFBEF1396;
        Mon, 14 Feb 2022 02:03:58 -0800 (PST)
Received: from [10.163.47.15] (unknown [10.163.47.15])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E32D3F718;
        Mon, 14 Feb 2022 02:03:56 -0800 (PST)
Subject: Re: [PATCH 23/30] um/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
To:     kernel test robot <lkp@intel.com>, linux-mm@kvack.org
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arch@vger.kernel.org, Jeff Dike <jdike@addtoit.com>,
        linux-um@lists.infradead.org
References: <1644805853-21338-24-git-send-email-anshuman.khandual@arm.com>
 <202202141426.Q2fKI6yq-lkp@intel.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <4063465a-126d-9bef-5831-d8340cb9aaec@arm.com>
Date:   Mon, 14 Feb 2022 15:33:56 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <202202141426.Q2fKI6yq-lkp@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 2/14/22 12:10 PM, kernel test robot wrote:
> All errors (new ones prefixed by >>):
> 
>    arch/x86/um/mem_32.c: In function 'gate_vma_init':
>>> arch/x86/um/mem_32.c:20:26: error: '__P101' undeclared (first use in this function)
>       20 |  gate_vma.vm_page_prot = __P101;
>          |                          ^~~~~~
>    arch/x86/um/mem_32.c:20:26: note: each undeclared identifier is reported only once for each function it appears in

Also the following instance still has reference to __PXXX symbols.

arch/arm/lib/uaccess_with_memcpy.c:     user_ptr = vmap(&dst_page, 1, VM_IOREMAP, __pgprot(__P010));

Will fix both.
