Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED3E6BB80D
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 16:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbjCOPiL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Mar 2023 11:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbjCOPiK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 11:38:10 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88862298C0;
        Wed, 15 Mar 2023 08:38:03 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 003AC5C0526;
        Wed, 15 Mar 2023 11:38:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 15 Mar 2023 11:38:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1678894682; x=
        1678981082; bh=1WqZaUC1BX2jDHLQT1f8EPKFG28amlSPpC4LzmJo0xw=; b=B
        8mDvLt4m06diWCXnmFzG8qHso0n6hCAnFLzB3jmFnhT9crLjB/lUso0oQlr9dOIw
        MAUCb97fdvmi+JrVFEm+CVtIcnr21eVi7SlebOJRzGnXmti3ZY+WNRP0u6FjfLl3
        nnSID1TbuLU/hRS7hFs+47lPSz2x7aLfg3bqYpzJko6VDLZytzsrwSdfyLW3Ya/o
        vDqq9i/Wn4mrEAJ9pzmOP1+wJ/U0QViA3CvbzavspioYwjITcEfd82po5Fuiuv5N
        C9Hzl+dpFvC1qenHchdZ4ElTrHNEKdFn784m4xA/R1GU6Xx5eGtU+8Aj1JPF0A8n
        8PqCU7Kr4uXVgLL2hgOVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1678894682; x=1678981082; bh=1WqZaUC1BX2jD
        HLQT1f8EPKFG28amlSPpC4LzmJo0xw=; b=l0lZ75eJIewsD9UND+Wf7ktKL1tqB
        XIeEM1Gdraiu+l3BRCGdZ31MKP+wt3/xUX+HsfjDqQME0xsxx7OUC+PYizmmW+Hc
        fG5nRabgkQtJm36yfKHDKVzD240zu68qgtveVVtL0rfuC3HhdOAODGfNFkfqsuxC
        yk9y8Vp/a62FW9sJtUObOzfUgGXz5tdNsqBKl+UTmOHEflJC3v/vyWsMAMfEcMAR
        /l2aacM4q9266ccuRXut1B8JELm5OCiTsPrgUHaZKk67ufzD7lXVfRXr7XTmQL6o
        wY4KyU5oU5goTiwbxhlBNAJo0Ctk5nOe7LAx3qBXEBEJ7cDvFjS6tLZ7g==
X-ME-Sender: <xms:WuYRZMCmgxK6g9V07jemgEixzcuM8j99YCkjKLlJna7of5Ii6ylKFg>
    <xme:WuYRZOib1KpdkvVueJ_Lb2qSH3J77-9Fc0QdZF6XvePqUecH_wdjZBwVWG8KzI-9b
    -TITkF_m_WmrzrP9WU>
X-ME-Received: <xmr:WuYRZPkp2aF9fB6vs5P9OTxoD6zikuAt6TdIMIapMSsf4_fFdh5g1uBqbljrz_qD2HFX8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddvkedgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeekveegudeuheffteelfefffeehleffgefhtdej
    vdeufedtvedvjeevfeekjeeggfenucffohhmrghinhepghhithdqshgtmhdrtghomhdpgh
    hithhhuhgsrdgtohhmpdhkvghrnhgvlhdrohhrghdptddurdhorhhgpdhgihhthhhusghu
    shgvrhgtohhnthgvnhhtrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:WuYRZCwBnOlO7sexhEmWJZXAc07g828xy3iR7HM3BKZTt7JkaF0UTQ>
    <xmx:WuYRZBTMTRlkCXgiHZjczi9pxWL4QtpO8uL6ojSrrrWfY0Ukx-nG2g>
    <xmx:WuYRZNZ40KbZBF9RRNWswm3sRFKuSaVgsq2UwHgWGO_7JXbQmuQb4g>
    <xmx:WuYRZO_Eo62fW7IgzBAD-fvYvCEyBhrC1Mf9xhUAHV3lV2xPiPGZDw>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Mar 2023 11:38:02 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 520A610C8DF; Wed, 15 Mar 2023 18:38:00 +0300 (+03)
Date:   Wed, 15 Mar 2023 18:38:00 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     kernel test robot <lkp@intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/10] mm, treewide: Redefine MAX_ORDER sanely
Message-ID: <20230315153800.32wib3n5rickolvh@box>
References: <20230315113133.11326-11-kirill.shutemov@linux.intel.com>
 <202303152343.D93IbJmn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202303152343.D93IbJmn-lkp@intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 15, 2023 at 11:26:51PM +0800, kernel test robot wrote:
> Hi Kirill,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on akpm-mm/mm-everything]
> [also build test WARNING on powerpc/next powerpc/fixes linus/master v6.3-rc2 next-20230315]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Kirill-A-Shutemov/sparc-mm-Fix-MAX_ORDER-usage-in-tsb_grow/20230315-193254
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/20230315113133.11326-11-kirill.shutemov%40linux.intel.com
> patch subject: [PATCH 10/10] mm, treewide: Redefine MAX_ORDER sanely
> config: arm-randconfig-r033-20230313 (https://download.01.org/0day-ci/archive/20230315/202303152343.D93IbJmn-lkp@intel.com/config)
> compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm cross compiling tool for clang build
>         # apt-get install binutils-arm-linux-gnueabi
>         # https://github.com/intel-lab-lkp/linux/commit/ccefb5df94c3c6c966f6f583d60c9d9c832b7a34
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Kirill-A-Shutemov/sparc-mm-Fix-MAX_ORDER-usage-in-tsb_grow/20230315-193254
>         git checkout ccefb5df94c3c6c966f6f583d60c9d9c832b7a34
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202303152343.D93IbJmn-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> mm/memblock.c:2046:11: warning: comparison of distinct pointer types ('typeof (11) *' (aka 'int *') and 'typeof (__ffs(start)) *' (aka 'unsigned long *')) [-Wcompare-distinct-pointer-types]
>                    order = min(MAX_ORDER, __ffs(start));

The fixup:

diff --git a/mm/memblock.c b/mm/memblock.c
index 338b8cb0793e..7911224b1ed3 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2043,7 +2043,7 @@ static void __init __free_pages_memory(unsigned long start, unsigned long end)
 	int order;
 
 	while (start < end) {
-		order = min(MAX_ORDER, __ffs(start));
+		order = min_t(int, MAX_ORDER, __ffs(start));
 
 		while (start + (1UL << order) > end)
 			order--;
-- 
  Kiryl Shutsemau / Kirill A. Shutemov
