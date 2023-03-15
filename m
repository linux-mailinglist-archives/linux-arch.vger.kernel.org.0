Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4786BB7B1
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 16:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbjCOP0r (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Mar 2023 11:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbjCOP0q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 11:26:46 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426F17282;
        Wed, 15 Mar 2023 08:26:44 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 7FB625C0526;
        Wed, 15 Mar 2023 11:26:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 15 Mar 2023 11:26:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1678894000; x=
        1678980400; bh=1a7Z0QOweSdKPfL3+2JtnZEiWnfLAdqF+RdCisEu7wY=; b=r
        5QxaErtXFf5btxuf+LxZ0XiRnU7iYpoupZ2V+X/zgVCfoQf+zsgffilLx8NPGD2c
        Cs+kgmjK4KvqemwMlem1R8wsVaGvj0LRPvx4eErUVn/vC4iToy6n1d+PmanYaOH0
        +APhFj3eXtWF/X2LFI3rK0MseCb/RyLRJvKdVT5Dw+fLHS0rQbKqDkhXC3kjuaDg
        5/oPIWmzm7bmDhhhtgaLZ5nRCqTs6VZWxpdL8lfu8i+Zb9YatszMS2D8RmZPprUW
        UdctrgE2UaFsFWeJINIRY816ZL/fk7Pbx4t7BPt5npqRAvYu6oHrw6ovx/SYMon4
        5EEmAgvZwLc9SnZVRkTrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1678894000; x=1678980400; bh=1a7Z0QOweSdKP
        fL3+2JtnZEiWnfLAdqF+RdCisEu7wY=; b=NQ0w13sMVDzsNs1fq2E+ZJBOrmwut
        BEc4SnUed2iMQheefYZ7onWWgNjp7mBJt4FCfMourZ+8HA99tum3lC2af8VW7/oY
        SnCbvbK9Ydi/l2kfITI9GJl7Upq1k181MbIJTu08I3kgytRQ48jZXJYTL1sFdjjh
        lJgsD9hrwz47qEUYD3NgOwpSxVEdVTB6VuasOPeVhs3OWjm9VdTPr/FeXRD9jJtU
        BJ1EnsekDiRSAzvdf+o4h1E6DpypOXipYIXknn8f6WCdrglIKuLfsiyY5E3pSgQr
        CmcpYJKb8+wr9tBiFbQLZsBsbaZfn+X2NHhTsdL2q4+TcDrGmPsr1+STw==
X-ME-Sender: <xms:r-MRZBC0W0j6ZdsR59MdUj_16qZQnHMaKK1xXHan5BsCvld4SoS-Kw>
    <xme:r-MRZPgmiFms6EeUfwqgAWsXEv5WtIG9UTCrr5BPHDdwvA40Q_5zoW6bABwj30vpq
    pDCd0Gn632ePq5WU7A>
X-ME-Received: <xmr:r-MRZMm_-2WwUlLskPmKjpe8zJ96vdrHrjNqja2mom0Ls0SJDwhbEldOtJDBy-nxGs_Hrw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddvkedgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeekveegudeuheffteelfefffeehleffgefhtdej
    vdeufedtvedvjeevfeekjeeggfenucffohhmrghinhepghhithdqshgtmhdrtghomhdpgh
    hithhhuhgsrdgtohhmpdhkvghrnhgvlhdrohhrghdptddurdhorhhgpdhgihhthhhusghu
    shgvrhgtohhnthgvnhhtrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgv
X-ME-Proxy: <xmx:r-MRZLyqrvoWeGvR_IKfAjk7GP3YRUr7dxT1HrD1XuM80teHlbNo1Q>
    <xmx:r-MRZGReV1O8g6et6bnlZ2zr0aEuNfhk4hcXeElOp2iYXdfFwSxOiQ>
    <xmx:r-MRZOakFzixLAPUynMn-3kU2zkp96uQsbpwUm4opO3pmGsBipn2eQ>
    <xmx:sOMRZH_y8_3I-qvJEcGWcJgGogRCfjtg56yldqNhEUEHkwdPLKEIzQ>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Mar 2023 11:26:39 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id CC85C10C8DF; Wed, 15 Mar 2023 18:26:36 +0300 (+03)
Date:   Wed, 15 Mar 2023 18:26:36 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     kernel test robot <lkp@intel.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/10] mm, treewide: Redefine MAX_ORDER sanely
Message-ID: <20230315152636.smn34f3c6a5jzpn3@box>
References: <20230315113133.11326-11-kirill.shutemov@linux.intel.com>
 <202303152251.0kYjWIXW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202303152251.0kYjWIXW-lkp@intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 15, 2023 at 11:06:21PM +0800, kernel test robot wrote:
> Hi Kirill,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on akpm-mm/mm-everything]
> [also build test ERROR on powerpc/next powerpc/fixes linus/master v6.3-rc2 next-20230315]
> [cannot apply to davem-sparc/master]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Kirill-A-Shutemov/sparc-mm-Fix-MAX_ORDER-usage-in-tsb_grow/20230315-193254
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/20230315113133.11326-11-kirill.shutemov%40linux.intel.com
> patch subject: [PATCH 10/10] mm, treewide: Redefine MAX_ORDER sanely
> config: mips-randconfig-r015-20230313 (https://download.01.org/0day-ci/archive/20230315/202303152251.0kYjWIXW-lkp@intel.com/config)
> compiler: mips64el-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/ccefb5df94c3c6c966f6f583d60c9d9c832b7a34
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Kirill-A-Shutemov/sparc-mm-Fix-MAX_ORDER-usage-in-tsb_grow/20230315-193254
>         git checkout ccefb5df94c3c6c966f6f583d60c9d9c832b7a34
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=mips prepare
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202303152251.0kYjWIXW-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from include/linux/gfp.h:7,
>                     from include/linux/xarray.h:15,
>                     from include/linux/list_lru.h:14,
>                     from include/linux/fs.h:13,
>                     from include/linux/compat.h:17,
>                     from arch/mips/kernel/asm-offsets.c:12:
> >> include/linux/mmzone.h:1749:2: error: #error Allocator MAX_ORDER exceeds SECTION_SIZE
>     1749 | #error Allocator MAX_ORDER exceeds SECTION_SIZE
>          |  ^~~~~

It is not regression. MIPS Kconfig allows for excessively large
ARCH_FORCE_MAX_ORDER. The patch changes nothing with regarards to this.
But it changes meaning of ARCH_FORCE_MAX_ORDER and old configs are now
breaks.

Thomas, could you help with formulating more sensible upper limit for the
config option, so it won't collide with SECTION_SIZE?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
