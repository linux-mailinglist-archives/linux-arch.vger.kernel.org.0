Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51BB55209A
	for <lists+linux-arch@lfdr.de>; Mon, 20 Jun 2022 17:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243057AbiFTPX5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Jun 2022 11:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244698AbiFTPXS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jun 2022 11:23:18 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7B93A0;
        Mon, 20 Jun 2022 08:19:19 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id v1so21749417ejg.13;
        Mon, 20 Jun 2022 08:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YWN3Nb8qUtZPtBRLzgiRX4p9myMZxM2UOMateWHK0As=;
        b=byAC9nol+eee9J9WFHdI7uUDpTHNL5XRs0QLnV1qT1B97rve/lgkuaIi309k/AJTv3
         cXxv8zbwfDt57RZNkBY1jyxn3PmRyEK6ISXeh8PFlSmS6jt0CrAies37Mkx9oX3olSSS
         pHMDuYUv96GQ/HYruIKQrGqaflX8mmpl4ka1YqGMmTNCBsfTSb9kg8JRqnyXDNimOS6o
         U/ex3gxT/zjRVYJA0UOmJcE7beywnMnau1rQRkwyOHayq+sHoUW8O476yUFw9fJIZqbn
         RLsJM5sueubEqkWOLbPj8V04RMbDqHg3V1GNdBswqfY4z1dgxuusg8GLde8EnCP6+wIt
         ulfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YWN3Nb8qUtZPtBRLzgiRX4p9myMZxM2UOMateWHK0As=;
        b=gF/r/9jyJF4oww3jbLhFafbuwWvVRzZ2K+i7F6FQ6XQuDn7CTUEWxdWJudV2bBtYKF
         MQsP+XytNAP+K4qXaNqV8XrCvfMy4zjkBzvPCJTJXio9P1xKFbVbYZrZy0xf31lRUM/0
         BJdwHW075F83CRheuqu2xvjA9VJwCiXlZf5/kHf8iuQHE2d28lg6Tcu1+fGwfno6aRWt
         iKhh/UnmfcN6VA3dlIrYMfbhsoinMUlkkEa4NR9s0fO53qUoxqG5TtrEarTM3jNI97SM
         b2hV/x3yjjmH+ydU8EjHO3HF1t3ah0Mo+KhICT1zwQnDRehsYZ2pZOkZH/6aZTSOF9/z
         WEdA==
X-Gm-Message-State: AJIora9inMR/XRUzDg9gQcIlDE0qe7Q4OQUIDjy7QzK7IE/zagxQPqNd
        Onsk4Ts6c9tqTZCyZy9ELbrM6s45XqRzJZ6h5Tk=
X-Google-Smtp-Source: AGRyM1uS2190/Yx1R95D98KQZlAP7JJU20NU3gNzaby0Kw+eJ7qO7bE8z7pSkhwvy6Uy9brm1yhr38JQPT9FcTLbb14=
X-Received: by 2002:a17:906:d9d9:b0:710:f2ae:b455 with SMTP id
 qk25-20020a170906d9d900b00710f2aeb455mr22001283ejb.77.1655738357899; Mon, 20
 Jun 2022 08:19:17 -0700 (PDT)
MIME-Version: 1.0
References: <202206191726.wq70mbMK-lkp@intel.com> <20220617144031.2549432-1-alexandr.lobakin@intel.com>
 <20220620135146.2628908-1-alexandr.lobakin@intel.com>
In-Reply-To: <20220620135146.2628908-1-alexandr.lobakin@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 20 Jun 2022 17:18:40 +0200
Message-ID: <CAHp75VfQ+DLFP+Jq+m=cejwk+=h9jLOQuL6uK6OCKujg=9Lfgw@mail.gmail.com>
Subject: Re: [alobakin:bitops 3/7] block/elevator.c:222:9: sparse: sparse:
 cast from restricted req_flags_t
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Yury Norov <yury.norov@gmail.com>,
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 20, 2022 at 4:48 PM Alexander Lobakin
<alexandr.lobakin@intel.com> wrote:
>
> From: kernel test robot <lkp@intel.com>
> Date: Sun, 19 Jun 2022 17:20:05 +0800
>
> Also, could someone please help me with this? I don't get what went
> wrong with sparse, it's not even some new code, just moving old
> stuff.
>
> > tree:   https://github.com/alobakin/linux bitops
> > head:   9bd39b17ce49d350eed93a031e0da6389067013e
> > commit: 521611f961a7dda92eefa26e1afd3914c06af64e [3/7] bitops: unify non-atomic bitops prototypes across architectures
> > config: mips-randconfig-s031-20220619 (https://download.01.org/0day-ci/archive/20220619/202206191726.wq70mbMK-lkp@intel.com/config)
> > compiler: mips64el-linux-gcc (GCC) 11.3.0
> > reproduce:
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # apt-get install sparse
> >         # sparse version: v0.6.4-30-g92122700-dirty
> >         # https://github.com/alobakin/linux/commit/521611f961a7dda92eefa26e1afd3914c06af64e
> >         git remote add alobakin https://github.com/alobakin/linux
> >         git fetch --no-tags alobakin bitops
> >         git checkout 521611f961a7dda92eefa26e1afd3914c06af64e
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=mips SHELL=/bin/bash
> >
> > If you fix the issue, kindly add following tag where applicable
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> >
> > sparse warnings: (new ones prefixed by >>)
> >    command-line: note: in included file:
> >    builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
> >    builtin:0:0: sparse: this was the original definition
> >    builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
> >    builtin:0:0: sparse: this was the original definition
> >    builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
> >    builtin:0:0: sparse: this was the original definition
> >    builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
> >    builtin:0:0: sparse: this was the original definition
> >    block/elevator.c: note: in included file (through include/linux/bitops.h, include/linux/kernel.h):
> >    include/asm-generic/bitops/generic-non-atomic.h:29:9: sparse: sparse: unreplaced symbol 'mask'
> >    include/asm-generic/bitops/generic-non-atomic.h:30:9: sparse: sparse: unreplaced symbol 'p'
> >    include/asm-generic/bitops/generic-non-atomic.h:32:10: sparse: sparse: unreplaced symbol 'p'
> >    include/asm-generic/bitops/generic-non-atomic.h:32:16: sparse: sparse: unreplaced symbol 'mask'
> >    include/asm-generic/bitops/generic-non-atomic.h:27:1: sparse: sparse: unreplaced symbol 'return'
> >    include/asm-generic/bitops/generic-non-atomic.h:38:9: sparse: sparse: unreplaced symbol 'mask'
> >    include/asm-generic/bitops/generic-non-atomic.h:39:9: sparse: sparse: unreplaced symbol 'p'
> >    include/asm-generic/bitops/generic-non-atomic.h:41:10: sparse: sparse: unreplaced symbol 'p'
> >    include/asm-generic/bitops/generic-non-atomic.h:41:16: sparse: sparse: unreplaced symbol 'mask'
> >    include/asm-generic/bitops/generic-non-atomic.h:36:1: sparse: sparse: unreplaced symbol 'return'
> >    include/asm-generic/bitops/generic-non-atomic.h:56:9: sparse: sparse: unreplaced symbol 'mask'
> >    include/asm-generic/bitops/generic-non-atomic.h:57:9: sparse: sparse: unreplaced symbol 'p'
> >    include/asm-generic/bitops/generic-non-atomic.h:59:10: sparse: sparse: unreplaced symbol 'p'
> >    include/asm-generic/bitops/generic-non-atomic.h:59:15: sparse: sparse: unreplaced symbol 'mask'
> >    include/asm-generic/bitops/generic-non-atomic.h:54:1: sparse: sparse: unreplaced symbol 'return'
> >    include/asm-generic/bitops/generic-non-atomic.h:74:9: sparse: sparse: unreplaced symbol 'mask'
> >    include/asm-generic/bitops/generic-non-atomic.h:75:9: sparse: sparse: unreplaced symbol 'p'
> >    include/asm-generic/bitops/generic-non-atomic.h:76:9: sparse: sparse: unreplaced symbol 'old'
> >    include/asm-generic/bitops/generic-non-atomic.h:78:10: sparse: sparse: unreplaced symbol 'p'
> >    include/asm-generic/bitops/generic-non-atomic.h:78:14: sparse: sparse: unreplaced symbol 'old'
> >    include/asm-generic/bitops/generic-non-atomic.h:78:20: sparse: sparse: unreplaced symbol 'mask'
> >    include/asm-generic/bitops/generic-non-atomic.h:79:17: sparse: sparse: unreplaced symbol 'old'
> >    include/asm-generic/bitops/generic-non-atomic.h:79:23: sparse: sparse: unreplaced symbol 'mask'
> >    include/asm-generic/bitops/generic-non-atomic.h:79:9: sparse: sparse: unreplaced symbol 'return'
> >    include/asm-generic/bitops/generic-non-atomic.h:72:1: sparse: sparse: unreplaced symbol 'return'
> >    include/asm-generic/bitops/generic-non-atomic.h:94:9: sparse: sparse: unreplaced symbol 'mask'
> >    include/asm-generic/bitops/generic-non-atomic.h:95:9: sparse: sparse: unreplaced symbol 'p'
> >    include/asm-generic/bitops/generic-non-atomic.h:96:9: sparse: sparse: unreplaced symbol 'old'
> >    include/asm-generic/bitops/generic-non-atomic.h:98:10: sparse: sparse: unreplaced symbol 'p'
> >    include/asm-generic/bitops/generic-non-atomic.h:98:14: sparse: sparse: unreplaced symbol 'old'
> >    include/asm-generic/bitops/generic-non-atomic.h:98:21: sparse: sparse: unreplaced symbol 'mask'
> >    include/asm-generic/bitops/generic-non-atomic.h:99:17: sparse: sparse: unreplaced symbol 'old'
> >    include/asm-generic/bitops/generic-non-atomic.h:99:23: sparse: sparse: unreplaced symbol 'mask'
> >    include/asm-generic/bitops/generic-non-atomic.h:99:9: sparse: sparse: unreplaced symbol 'return'
> >    include/asm-generic/bitops/generic-non-atomic.h:92:1: sparse: sparse: unreplaced symbol 'return'
> >    include/asm-generic/bitops/generic-non-atomic.h:106:9: sparse: sparse: unreplaced symbol 'mask'
> >    include/asm-generic/bitops/generic-non-atomic.h:107:9: sparse: sparse: unreplaced symbol 'p'
> >    include/asm-generic/bitops/generic-non-atomic.h:108:9: sparse: sparse: unreplaced symbol 'old'
> >    include/asm-generic/bitops/generic-non-atomic.h:110:10: sparse: sparse: unreplaced symbol 'p'
> >    include/asm-generic/bitops/generic-non-atomic.h:110:14: sparse: sparse: unreplaced symbol 'old'
> >    include/asm-generic/bitops/generic-non-atomic.h:110:20: sparse: sparse: unreplaced symbol 'mask'
> >    include/asm-generic/bitops/generic-non-atomic.h:111:17: sparse: sparse: unreplaced symbol 'old'
> >    include/asm-generic/bitops/generic-non-atomic.h:111:23: sparse: sparse: unreplaced symbol 'mask'
> >    include/asm-generic/bitops/generic-non-atomic.h:111:9: sparse: sparse: unreplaced symbol 'return'
> >    include/asm-generic/bitops/generic-non-atomic.h:104:1: sparse: sparse: unreplaced symbol 'return'
> >    include/asm-generic/bitops/generic-non-atomic.h:127:9: sparse: sparse: unreplaced symbol 'return'
> >    include/asm-generic/bitops/generic-non-atomic.h:120:1: sparse: sparse: unreplaced symbol 'return'
> > >> block/elevator.c:222:9: sparse: sparse: cast from restricted req_flags_t
> >
> > vim +222 block/elevator.c
> >
> > 9817064b68fef7 Jens Axboe        2006-07-28  217
> > 70b3ea056f3074 Jens Axboe        2016-12-07  218  void elv_rqhash_add(struct request_queue *q, struct request *rq)
> > 9817064b68fef7 Jens Axboe        2006-07-28  219  {
> > b374d18a4bfce7 Jens Axboe        2008-10-31  220      struct elevator_queue *e = q->elevator;
> > 9817064b68fef7 Jens Axboe        2006-07-28  221
> > 9817064b68fef7 Jens Axboe        2006-07-28 @222      BUG_ON(ELV_ON_HASH(rq));
> > 242d98f077ac0a Sasha Levin       2012-12-17  223      hash_add(e->hash, &rq->hash, rq_hash_key(rq));
> > e806402130c9c4 Christoph Hellwig 2016-10-20  224      rq->rq_flags |= RQF_HASHED;
> > 9817064b68fef7 Jens Axboe        2006-07-28  225  }
> > bd166ef183c263 Jens Axboe        2017-01-17  226  EXPORT_SYMBOL_GPL(elv_rqhash_add);
> > 9817064b68fef7 Jens Axboe        2006-07-28  227

It looks like a false positive for _your_ case, but if you want to fix
here is the background.

The sparse has an ability to control custom types that should never
set bits outside of the limited range. For this the special annotation
is given, i.e. __bitwise. Since the culprit type is defined that way
it means the pure integer (signed or unsigned) that comes with pure
definition can't be used in a safe way. To solve this each of such
definitions should be converted to the very same type (req_flags_t).
See serial core where some UART flags are defined in a similar way and
how code copes with that.

-- 
With Best Regards,
Andy Shevchenko
