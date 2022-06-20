Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8DB65520E4
	for <lists+linux-arch@lfdr.de>; Mon, 20 Jun 2022 17:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240728AbiFTP3A (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Jun 2022 11:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243889AbiFTP2W (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jun 2022 11:28:22 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527D3CD8;
        Mon, 20 Jun 2022 08:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655738883; x=1687274883;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Z7q7xtuOU4GkNKNky8lxCljPlrJivkK5wKNhOZIUxpA=;
  b=OFQ5hiapOrUBBEUHdNN3rI9pzaEJLE/yQYM0iXallO+zz643s6mUygBc
   D6W4kI087DC7cIL8BFZ7jOISoBULMndK55nnHVeK0ZT/4yGDswFyRE3by
   0vf3kJvWQBYrA12SS+Yc+oMZFDDchtPmrDXQph6WyQzBoiFk9FTNO3INW
   b/VKiExNiSa920pMDaASKO8x/0zBxNaZ5D5A5MSl+8GwC9t8wJoQONo2j
   ngFnZVUb5KjK8u6f9f/3x7umUn/wbmEKz7kNwOITQ2xkCkEYjhV7/xNUv
   nw2kvAC34fkl2acSo0XcV3gqBbMflKrj+D9+20Ig9AkgW2YL44uvh2Olj
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="305359536"
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="305359536"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 08:28:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="614430674"
Received: from irvmail001.ir.intel.com ([10.43.11.63])
  by orsmga008.jf.intel.com with ESMTP; 20 Jun 2022 08:27:52 -0700
Received: from newjersey.igk.intel.com (newjersey.igk.intel.com [10.102.20.203])
        by irvmail001.ir.intel.com (8.14.3/8.13.6/MailSET/Hub) with ESMTP id 25KFRoXw029454;
        Mon, 20 Jun 2022 16:27:50 +0100
From:   Alexander Lobakin <alexandr.lobakin@intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matt Turner <mattst88@gmail.com>,
        Brian Cain <bcain@quicinc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Marco Elver <elver@google.com>, Borislav Petkov <bp@suse.de>,
        Tony Luck <tony.luck@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-alpha@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux-SH <linux-sh@vger.kernel.org>,
        Sparc kernel list <sparclinux@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kbuild-all@lists.01.org, kernel test robot <lkp@intel.com>
Subject: Re: [alobakin:bitops 3/7] block/elevator.c:222:9: sparse: sparse: cast from restricted req_flags_t
Date:   Mon, 20 Jun 2022 17:27:39 +0200
Message-Id: <20220620152739.2631490-1-alexandr.lobakin@intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <CAHp75VfQ+DLFP+Jq+m=cejwk+=h9jLOQuL6uK6OCKujg=9Lfgw@mail.gmail.com>
References: <202206191726.wq70mbMK-lkp@intel.com> <20220617144031.2549432-1-alexandr.lobakin@intel.com> <20220620135146.2628908-1-alexandr.lobakin@intel.com> <CAHp75VfQ+DLFP+Jq+m=cejwk+=h9jLOQuL6uK6OCKujg=9Lfgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 20 Jun 2022 17:18:40 +0200

> On Mon, Jun 20, 2022 at 4:48 PM Alexander Lobakin
> <alexandr.lobakin@intel.com> wrote:
> >
> > From: kernel test robot <lkp@intel.com>
> > Date: Sun, 19 Jun 2022 17:20:05 +0800
> >
> > Also, could someone please help me with this? I don't get what went
> > wrong with sparse, it's not even some new code, just moving old
> > stuff.
> >
> > > tree:   https://github.com/alobakin/linux bitops
> > > head:   9bd39b17ce49d350eed93a031e0da6389067013e
> > > commit: 521611f961a7dda92eefa26e1afd3914c06af64e [3/7] bitops: unify non-atomic bitops prototypes across architectures
> > > config: mips-randconfig-s031-20220619 (https://download.01.org/0day-ci/archive/20220619/202206191726.wq70mbMK-lkp@intel.com/config)
> > > compiler: mips64el-linux-gcc (GCC) 11.3.0
> > > reproduce:
> > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         # apt-get install sparse
> > >         # sparse version: v0.6.4-30-g92122700-dirty
> > >         # https://github.com/alobakin/linux/commit/521611f961a7dda92eefa26e1afd3914c06af64e
> > >         git remote add alobakin https://github.com/alobakin/linux
> > >         git fetch --no-tags alobakin bitops
> > >         git checkout 521611f961a7dda92eefa26e1afd3914c06af64e
> > >         # save the config file
> > >         mkdir build_dir && cp config build_dir/.config
> > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=mips SHELL=/bin/bash
> > >
> > > If you fix the issue, kindly add following tag where applicable
> > > Reported-by: kernel test robot <lkp@intel.com>
> > >
> > >
> > > sparse warnings: (new ones prefixed by >>)
> > >    command-line: note: in included file:
> > >    builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
> > >    builtin:0:0: sparse: this was the original definition
> > >    builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
> > >    builtin:0:0: sparse: this was the original definition
> > >    builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
> > >    builtin:0:0: sparse: this was the original definition
> > >    builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
> > >    builtin:0:0: sparse: this was the original definition
> > >    block/elevator.c: note: in included file (through include/linux/bitops.h, include/linux/kernel.h):
> > >    include/asm-generic/bitops/generic-non-atomic.h:29:9: sparse: sparse: unreplaced symbol 'mask'
> > >    include/asm-generic/bitops/generic-non-atomic.h:30:9: sparse: sparse: unreplaced symbol 'p'
> > >    include/asm-generic/bitops/generic-non-atomic.h:32:10: sparse: sparse: unreplaced symbol 'p'
> > >    include/asm-generic/bitops/generic-non-atomic.h:32:16: sparse: sparse: unreplaced symbol 'mask'
> > >    include/asm-generic/bitops/generic-non-atomic.h:27:1: sparse: sparse: unreplaced symbol 'return'
> > >    include/asm-generic/bitops/generic-non-atomic.h:38:9: sparse: sparse: unreplaced symbol 'mask'
> > >    include/asm-generic/bitops/generic-non-atomic.h:39:9: sparse: sparse: unreplaced symbol 'p'
> > >    include/asm-generic/bitops/generic-non-atomic.h:41:10: sparse: sparse: unreplaced symbol 'p'
> > >    include/asm-generic/bitops/generic-non-atomic.h:41:16: sparse: sparse: unreplaced symbol 'mask'
> > >    include/asm-generic/bitops/generic-non-atomic.h:36:1: sparse: sparse: unreplaced symbol 'return'
> > >    include/asm-generic/bitops/generic-non-atomic.h:56:9: sparse: sparse: unreplaced symbol 'mask'
> > >    include/asm-generic/bitops/generic-non-atomic.h:57:9: sparse: sparse: unreplaced symbol 'p'
> > >    include/asm-generic/bitops/generic-non-atomic.h:59:10: sparse: sparse: unreplaced symbol 'p'
> > >    include/asm-generic/bitops/generic-non-atomic.h:59:15: sparse: sparse: unreplaced symbol 'mask'
> > >    include/asm-generic/bitops/generic-non-atomic.h:54:1: sparse: sparse: unreplaced symbol 'return'
> > >    include/asm-generic/bitops/generic-non-atomic.h:74:9: sparse: sparse: unreplaced symbol 'mask'
> > >    include/asm-generic/bitops/generic-non-atomic.h:75:9: sparse: sparse: unreplaced symbol 'p'
> > >    include/asm-generic/bitops/generic-non-atomic.h:76:9: sparse: sparse: unreplaced symbol 'old'
> > >    include/asm-generic/bitops/generic-non-atomic.h:78:10: sparse: sparse: unreplaced symbol 'p'
> > >    include/asm-generic/bitops/generic-non-atomic.h:78:14: sparse: sparse: unreplaced symbol 'old'
> > >    include/asm-generic/bitops/generic-non-atomic.h:78:20: sparse: sparse: unreplaced symbol 'mask'
> > >    include/asm-generic/bitops/generic-non-atomic.h:79:17: sparse: sparse: unreplaced symbol 'old'
> > >    include/asm-generic/bitops/generic-non-atomic.h:79:23: sparse: sparse: unreplaced symbol 'mask'
> > >    include/asm-generic/bitops/generic-non-atomic.h:79:9: sparse: sparse: unreplaced symbol 'return'
> > >    include/asm-generic/bitops/generic-non-atomic.h:72:1: sparse: sparse: unreplaced symbol 'return'
> > >    include/asm-generic/bitops/generic-non-atomic.h:94:9: sparse: sparse: unreplaced symbol 'mask'
> > >    include/asm-generic/bitops/generic-non-atomic.h:95:9: sparse: sparse: unreplaced symbol 'p'
> > >    include/asm-generic/bitops/generic-non-atomic.h:96:9: sparse: sparse: unreplaced symbol 'old'
> > >    include/asm-generic/bitops/generic-non-atomic.h:98:10: sparse: sparse: unreplaced symbol 'p'
> > >    include/asm-generic/bitops/generic-non-atomic.h:98:14: sparse: sparse: unreplaced symbol 'old'
> > >    include/asm-generic/bitops/generic-non-atomic.h:98:21: sparse: sparse: unreplaced symbol 'mask'
> > >    include/asm-generic/bitops/generic-non-atomic.h:99:17: sparse: sparse: unreplaced symbol 'old'
> > >    include/asm-generic/bitops/generic-non-atomic.h:99:23: sparse: sparse: unreplaced symbol 'mask'
> > >    include/asm-generic/bitops/generic-non-atomic.h:99:9: sparse: sparse: unreplaced symbol 'return'
> > >    include/asm-generic/bitops/generic-non-atomic.h:92:1: sparse: sparse: unreplaced symbol 'return'
> > >    include/asm-generic/bitops/generic-non-atomic.h:106:9: sparse: sparse: unreplaced symbol 'mask'
> > >    include/asm-generic/bitops/generic-non-atomic.h:107:9: sparse: sparse: unreplaced symbol 'p'
> > >    include/asm-generic/bitops/generic-non-atomic.h:108:9: sparse: sparse: unreplaced symbol 'old'
> > >    include/asm-generic/bitops/generic-non-atomic.h:110:10: sparse: sparse: unreplaced symbol 'p'
> > >    include/asm-generic/bitops/generic-non-atomic.h:110:14: sparse: sparse: unreplaced symbol 'old'
> > >    include/asm-generic/bitops/generic-non-atomic.h:110:20: sparse: sparse: unreplaced symbol 'mask'
> > >    include/asm-generic/bitops/generic-non-atomic.h:111:17: sparse: sparse: unreplaced symbol 'old'
> > >    include/asm-generic/bitops/generic-non-atomic.h:111:23: sparse: sparse: unreplaced symbol 'mask'
> > >    include/asm-generic/bitops/generic-non-atomic.h:111:9: sparse: sparse: unreplaced symbol 'return'
> > >    include/asm-generic/bitops/generic-non-atomic.h:104:1: sparse: sparse: unreplaced symbol 'return'
> > >    include/asm-generic/bitops/generic-non-atomic.h:127:9: sparse: sparse: unreplaced symbol 'return'
> > >    include/asm-generic/bitops/generic-non-atomic.h:120:1: sparse: sparse: unreplaced symbol 'return'
> > > >> block/elevator.c:222:9: sparse: sparse: cast from restricted req_flags_t
> > >
> > > vim +222 block/elevator.c
> > >
> > > 9817064b68fef7 Jens Axboe        2006-07-28  217
> > > 70b3ea056f3074 Jens Axboe        2016-12-07  218  void elv_rqhash_add(struct request_queue *q, struct request *rq)
> > > 9817064b68fef7 Jens Axboe        2006-07-28  219  {
> > > b374d18a4bfce7 Jens Axboe        2008-10-31  220      struct elevator_queue *e = q->elevator;
> > > 9817064b68fef7 Jens Axboe        2006-07-28  221
> > > 9817064b68fef7 Jens Axboe        2006-07-28 @222      BUG_ON(ELV_ON_HASH(rq));
> > > 242d98f077ac0a Sasha Levin       2012-12-17  223      hash_add(e->hash, &rq->hash, rq_hash_key(rq));
> > > e806402130c9c4 Christoph Hellwig 2016-10-20  224      rq->rq_flags |= RQF_HASHED;
> > > 9817064b68fef7 Jens Axboe        2006-07-28  225  }
> > > bd166ef183c263 Jens Axboe        2017-01-17  226  EXPORT_SYMBOL_GPL(elv_rqhash_add);
> > > 9817064b68fef7 Jens Axboe        2006-07-28  227
> 
> It looks like a false positive for _your_ case, but if you want to fix
> here is the background.
> 
> The sparse has an ability to control custom types that should never
> set bits outside of the limited range. For this the special annotation
> is given, i.e. __bitwise. Since the culprit type is defined that way
> it means the pure integer (signed or unsigned) that comes with pure
> definition can't be used in a safe way. To solve this each of such
> definitions should be converted to the very same type (req_flags_t).
> See serial core where some UART flags are defined in a similar way and
> how code copes with that.

Ah, I haven't looked at the req_flags_t definition and didn't know
it uses bitwise annotation. So it's a local blk layer problem (not
casting from/to bitwise), not a generic header issue. Thanks for
the hint!

> 
> -- 
> With Best Regards,
> Andy Shevchenko

Thanks,
Olek
