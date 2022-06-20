Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52A1551EFE
	for <lists+linux-arch@lfdr.de>; Mon, 20 Jun 2022 16:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245334AbiFTOh2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Jun 2022 10:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243890AbiFTOhP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jun 2022 10:37:15 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDB55132A;
        Mon, 20 Jun 2022 06:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655733124; x=1687269124;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PUT5CK/O9Y7UPcpvAOlSgvIIEYYbeJdLfqrP84iYTYY=;
  b=j3Dxtu2zAywFiLCs9thH2bf/KFV3dhbQiNw75/iyZnlWRWeyoL6mwDST
   BbC1lNfO7yc30TVLLigTkyRC5aMo4G7byLapc+g30u+BZwwQfgPb8Txfm
   Cj6NHAvMG8NweYgT9vHtHdRFmA+DeQCOCENDqox0Qbvz4W74KxI+KPtwC
   czfdLxiel58qgo7wCcMDZQVMZsS27Z2YjWkbMwLZXHW/M7vg0GTOTE/j8
   RGTwpVPRnUDEyy5ZGX2JO3xDwSkN2bDvvHaFDKkq7gl7Fzdg+HJoeOMoY
   Pc6VRs6tIQEOil2eOJhpJ/5wXLpHlnyXdYJ6UYS9bDfYgOrO03Mgu/P1S
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="280956337"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="280956337"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 06:52:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="714632355"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga004.jf.intel.com with ESMTP; 20 Jun 2022 06:51:57 -0700
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 25KDptUA005326;
        Mon, 20 Jun 2022 14:51:55 +0100
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>, Yury Norov <yury.norov@gmail.com>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matt Turner <mattst88@gmail.com>,
        Brian Cain <bcain@quicinc.com>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Marco Elver <elver@google.com>, Borislav Petkov <bp@suse.de>,
        Tony Luck <tony.luck@intel.com>,
        "Maciej Fijalkowski" <maciej.fijalkowski@intel.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-alpha@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        kbuild-all@lists.01.org, kernel test robot <lkp@intel.com>
Subject: Re: [alobakin:bitops 3/7] block/elevator.c:222:9: sparse: sparse: cast from restricted req_flags_t
Date:   Mon, 20 Jun 2022 15:51:46 +0200
Message-Id: <20220620135146.2628908-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220617144031.2549432-1-alexandr.lobakin@intel.com>
References: <202206191726.wq70mbMK-lkp@intel.com> <20220617144031.2549432-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: kernel test robot <lkp@intel.com>
Date: Sun, 19 Jun 2022 17:20:05 +0800

Also, could someone please help me with this? I don't get what went
wrong with sparse, it's not even some new code, just moving old
stuff.

> tree:   https://github.com/alobakin/linux bitops
> head:   9bd39b17ce49d350eed93a031e0da6389067013e
> commit: 521611f961a7dda92eefa26e1afd3914c06af64e [3/7] bitops: unify non-atomic bitops prototypes across architectures
> config: mips-randconfig-s031-20220619 (https://download.01.org/0day-ci/archive/20220619/202206191726.wq70mbMK-lkp@intel.com/config)
> compiler: mips64el-linux-gcc (GCC) 11.3.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.4-30-g92122700-dirty
>         # https://github.com/alobakin/linux/commit/521611f961a7dda92eefa26e1afd3914c06af64e
>         git remote add alobakin https://github.com/alobakin/linux
>         git fetch --no-tags alobakin bitops
>         git checkout 521611f961a7dda92eefa26e1afd3914c06af64e
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=mips SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> 
> sparse warnings: (new ones prefixed by >>)
>    command-line: note: in included file:
>    builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
>    builtin:0:0: sparse: this was the original definition
>    builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
>    builtin:0:0: sparse: this was the original definition
>    builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
>    builtin:0:0: sparse: this was the original definition
>    builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
>    builtin:0:0: sparse: this was the original definition
>    block/elevator.c: note: in included file (through include/linux/bitops.h, include/linux/kernel.h):
>    include/asm-generic/bitops/generic-non-atomic.h:29:9: sparse: sparse: unreplaced symbol 'mask'
>    include/asm-generic/bitops/generic-non-atomic.h:30:9: sparse: sparse: unreplaced symbol 'p'
>    include/asm-generic/bitops/generic-non-atomic.h:32:10: sparse: sparse: unreplaced symbol 'p'
>    include/asm-generic/bitops/generic-non-atomic.h:32:16: sparse: sparse: unreplaced symbol 'mask'
>    include/asm-generic/bitops/generic-non-atomic.h:27:1: sparse: sparse: unreplaced symbol 'return'
>    include/asm-generic/bitops/generic-non-atomic.h:38:9: sparse: sparse: unreplaced symbol 'mask'
>    include/asm-generic/bitops/generic-non-atomic.h:39:9: sparse: sparse: unreplaced symbol 'p'
>    include/asm-generic/bitops/generic-non-atomic.h:41:10: sparse: sparse: unreplaced symbol 'p'
>    include/asm-generic/bitops/generic-non-atomic.h:41:16: sparse: sparse: unreplaced symbol 'mask'
>    include/asm-generic/bitops/generic-non-atomic.h:36:1: sparse: sparse: unreplaced symbol 'return'
>    include/asm-generic/bitops/generic-non-atomic.h:56:9: sparse: sparse: unreplaced symbol 'mask'
>    include/asm-generic/bitops/generic-non-atomic.h:57:9: sparse: sparse: unreplaced symbol 'p'
>    include/asm-generic/bitops/generic-non-atomic.h:59:10: sparse: sparse: unreplaced symbol 'p'
>    include/asm-generic/bitops/generic-non-atomic.h:59:15: sparse: sparse: unreplaced symbol 'mask'
>    include/asm-generic/bitops/generic-non-atomic.h:54:1: sparse: sparse: unreplaced symbol 'return'
>    include/asm-generic/bitops/generic-non-atomic.h:74:9: sparse: sparse: unreplaced symbol 'mask'
>    include/asm-generic/bitops/generic-non-atomic.h:75:9: sparse: sparse: unreplaced symbol 'p'
>    include/asm-generic/bitops/generic-non-atomic.h:76:9: sparse: sparse: unreplaced symbol 'old'
>    include/asm-generic/bitops/generic-non-atomic.h:78:10: sparse: sparse: unreplaced symbol 'p'
>    include/asm-generic/bitops/generic-non-atomic.h:78:14: sparse: sparse: unreplaced symbol 'old'
>    include/asm-generic/bitops/generic-non-atomic.h:78:20: sparse: sparse: unreplaced symbol 'mask'
>    include/asm-generic/bitops/generic-non-atomic.h:79:17: sparse: sparse: unreplaced symbol 'old'
>    include/asm-generic/bitops/generic-non-atomic.h:79:23: sparse: sparse: unreplaced symbol 'mask'
>    include/asm-generic/bitops/generic-non-atomic.h:79:9: sparse: sparse: unreplaced symbol 'return'
>    include/asm-generic/bitops/generic-non-atomic.h:72:1: sparse: sparse: unreplaced symbol 'return'
>    include/asm-generic/bitops/generic-non-atomic.h:94:9: sparse: sparse: unreplaced symbol 'mask'
>    include/asm-generic/bitops/generic-non-atomic.h:95:9: sparse: sparse: unreplaced symbol 'p'
>    include/asm-generic/bitops/generic-non-atomic.h:96:9: sparse: sparse: unreplaced symbol 'old'
>    include/asm-generic/bitops/generic-non-atomic.h:98:10: sparse: sparse: unreplaced symbol 'p'
>    include/asm-generic/bitops/generic-non-atomic.h:98:14: sparse: sparse: unreplaced symbol 'old'
>    include/asm-generic/bitops/generic-non-atomic.h:98:21: sparse: sparse: unreplaced symbol 'mask'
>    include/asm-generic/bitops/generic-non-atomic.h:99:17: sparse: sparse: unreplaced symbol 'old'
>    include/asm-generic/bitops/generic-non-atomic.h:99:23: sparse: sparse: unreplaced symbol 'mask'
>    include/asm-generic/bitops/generic-non-atomic.h:99:9: sparse: sparse: unreplaced symbol 'return'
>    include/asm-generic/bitops/generic-non-atomic.h:92:1: sparse: sparse: unreplaced symbol 'return'
>    include/asm-generic/bitops/generic-non-atomic.h:106:9: sparse: sparse: unreplaced symbol 'mask'
>    include/asm-generic/bitops/generic-non-atomic.h:107:9: sparse: sparse: unreplaced symbol 'p'
>    include/asm-generic/bitops/generic-non-atomic.h:108:9: sparse: sparse: unreplaced symbol 'old'
>    include/asm-generic/bitops/generic-non-atomic.h:110:10: sparse: sparse: unreplaced symbol 'p'
>    include/asm-generic/bitops/generic-non-atomic.h:110:14: sparse: sparse: unreplaced symbol 'old'
>    include/asm-generic/bitops/generic-non-atomic.h:110:20: sparse: sparse: unreplaced symbol 'mask'
>    include/asm-generic/bitops/generic-non-atomic.h:111:17: sparse: sparse: unreplaced symbol 'old'
>    include/asm-generic/bitops/generic-non-atomic.h:111:23: sparse: sparse: unreplaced symbol 'mask'
>    include/asm-generic/bitops/generic-non-atomic.h:111:9: sparse: sparse: unreplaced symbol 'return'
>    include/asm-generic/bitops/generic-non-atomic.h:104:1: sparse: sparse: unreplaced symbol 'return'
>    include/asm-generic/bitops/generic-non-atomic.h:127:9: sparse: sparse: unreplaced symbol 'return'
>    include/asm-generic/bitops/generic-non-atomic.h:120:1: sparse: sparse: unreplaced symbol 'return'
> >> block/elevator.c:222:9: sparse: sparse: cast from restricted req_flags_t
> 
> vim +222 block/elevator.c
> 
> 9817064b68fef7 Jens Axboe        2006-07-28  217  
> 70b3ea056f3074 Jens Axboe        2016-12-07  218  void elv_rqhash_add(struct request_queue *q, struct request *rq)
> 9817064b68fef7 Jens Axboe        2006-07-28  219  {
> b374d18a4bfce7 Jens Axboe        2008-10-31  220  	struct elevator_queue *e = q->elevator;
> 9817064b68fef7 Jens Axboe        2006-07-28  221  
> 9817064b68fef7 Jens Axboe        2006-07-28 @222  	BUG_ON(ELV_ON_HASH(rq));
> 242d98f077ac0a Sasha Levin       2012-12-17  223  	hash_add(e->hash, &rq->hash, rq_hash_key(rq));
> e806402130c9c4 Christoph Hellwig 2016-10-20  224  	rq->rq_flags |= RQF_HASHED;
> 9817064b68fef7 Jens Axboe        2006-07-28  225  }
> bd166ef183c263 Jens Axboe        2017-01-17  226  EXPORT_SYMBOL_GPL(elv_rqhash_add);
> 9817064b68fef7 Jens Axboe        2006-07-28  227  
> 
> :::::: The code at line 222 was first introduced by commit
> :::::: 9817064b68fef7e4580c6df1ea597e106b9ff88b [PATCH] elevator: move the backmerging logic into the elevator core
> 
> :::::: TO: Jens Axboe <axboe@suse.de>
> :::::: CC: Jens Axboe <axboe@nelson.home.kernel.dk>
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://01.org/lkp

Thanks,
Olek
