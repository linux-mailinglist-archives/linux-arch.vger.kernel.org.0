Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 838BC5480A7
	for <lists+linux-arch@lfdr.de>; Mon, 13 Jun 2022 09:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbiFMHfc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Mon, 13 Jun 2022 03:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiFMHfb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 13 Jun 2022 03:35:31 -0400
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E6DB46;
        Mon, 13 Jun 2022 00:35:30 -0700 (PDT)
Received: by mail-qt1-f169.google.com with SMTP id w13so2482860qts.6;
        Mon, 13 Jun 2022 00:35:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qsyvnc1KOjyjdVi81D7KKSfX66FwwQukTSl7hAx3+2E=;
        b=g3SWWSMyR08qyaU0shbaDaFzqsCySxxwyi7byJ3Y2pBYv/krD1b7zlV9iUzJDLZ/1t
         +K5c/RHttI8tEZ5vs3wufXuk7wXFyH/lYJYIypxrZ+kle5UclXkJSdNLAOS6CWacoPEY
         cfDzuQJMy8bk5jNh0yiQeLuP7FcEOTs9uZDrZRgln56YqGaAD7C4tn3RIzrea7U8QS3m
         MhGkkUvQSgo9vLeZ3laHIAahcj1XWktvwzo/tgk7KTv8YVCVBcfiI91xurayQpGZAzD6
         agrsFX+IFzMqAI7bhf5ljaxURaO8KPqLvPVsSummoDnY+/bOhz5C67njSHawnC19gkxI
         7wdQ==
X-Gm-Message-State: AOAM532dwq/NG0N/bQ0SQmC3ODehIbx5IliRUi8BOLGF1tNdTBgqcX6E
        t6ucp46IX24yc7TspGby4HsKBPaxTQYVJA==
X-Google-Smtp-Source: ABdhPJy/7gKaCflC+blYm8lrPyt8ljmL9WmIAE6eitPyuI7Yz/oCU8zrW7fy7mWewiN0XxZDh14g5g==
X-Received: by 2002:ac8:7f4d:0:b0:305:3474:56e8 with SMTP id g13-20020ac87f4d000000b00305347456e8mr3158120qtk.127.1655105729004;
        Mon, 13 Jun 2022 00:35:29 -0700 (PDT)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id w11-20020a05620a424b00b006a6a7b4e7besm6234204qko.109.2022.06.13.00.35.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jun 2022 00:35:28 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-30c2f288f13so42231487b3.7;
        Mon, 13 Jun 2022 00:35:28 -0700 (PDT)
X-Received: by 2002:a81:4811:0:b0:30c:8021:4690 with SMTP id
 v17-20020a814811000000b0030c80214690mr63372112ywa.47.1655105728002; Mon, 13
 Jun 2022 00:35:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220610113427.908751-1-alexandr.lobakin@intel.com>
In-Reply-To: <20220610113427.908751-1-alexandr.lobakin@intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 13 Jun 2022 09:35:16 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUZCaPN2B6bvmja9rDm3qCc4mYYAOSEB2W0R0pws8peqw@mail.gmail.com>
Message-ID: <CAMuHMdUZCaPN2B6bvmja9rDm3qCc4mYYAOSEB2W0R0pws8peqw@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] bitops: let optimize out non-atomic bitops on
 compile-time constants
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matt Turner <mattst88@gmail.com>,
        Brian Cain <bcain@quicinc.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Marco Elver <elver@google.com>, Borislav Petkov <bp@suse.de>,
        Tony Luck <tony.luck@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        alpha <linux-alpha@vger.kernel.org>,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Alexander,

On Fri, Jun 10, 2022 at 1:35 PM Alexander Lobakin
<alexandr.lobakin@intel.com> wrote:
> While I was working on converting some structure fields from a fixed
> type to a bitmap, I started observing code size increase not only in
> places where the code works with the converted structure fields, but
> also where the converted vars were on the stack. That said, the
> following code:
>
>         DECLARE_BITMAP(foo, BITS_PER_LONG) = { }; // -> unsigned long foo[1];
>         unsigned long bar = BIT(BAR_BIT);
>         unsigned long baz = 0;
>
>         __set_bit(FOO_BIT, foo);
>         baz |= BIT(BAZ_BIT);
>
>         BUILD_BUG_ON(!__builtin_constant_p(test_bit(FOO_BIT, foo));
>         BUILD_BUG_ON(!__builtin_constant_p(bar & BAR_BIT));
>         BUILD_BUG_ON(!__builtin_constant_p(baz & BAZ_BIT));
>
> triggers the first assertion on x86_64, which means that the
> compiler is unable to evaluate it to a compile-time initializer
> when the architecture-specific bitop is used even if it's obvious.
> I found that this is due to that many architecture-specific
> non-atomic bitop implementations use inline asm or other hacks which
> are faster or more robust when working with "real" variables (i.e.
> fields from the structures etc.), but the compilers have no clue how
> to optimize them out when called on compile-time constants.
>
> So, in order to let the compiler optimize out such cases, expand the
> test_bit() and __*_bit() definitions with a compile-time condition
> check, so that they will pick the generic C non-atomic bitop
> implementations when all of the arguments passed are compile-time
> constants, which means that the result will be a compile-time
> constant as well and the compiler will produce more efficient and
> simple code in 100% cases (no changes when there's at least one
> non-compile-time-constant argument).
> The condition itself:
>
> if (
> __builtin_constant_p(nr) &&     /* <- bit position is constant */
> __builtin_constant_p(!!addr) && /* <- compiler knows bitmap addr is
>                                       always either NULL or not */
> addr &&                         /* <- bitmap addr is not NULL */
> __builtin_constant_p(*addr)     /* <- compiler knows the value of
>                                       the target bitmap */
> )
>         /* then pick the generic C variant
> else
>         /* old code path, arch-specific
>
> I also tried __is_constexpr() as suggested by Andy, but it was
> always returning 0 ('not a constant') for the 2,3 and 4th
> conditions.
>
> The savings are architecture, compiler and compiler flags dependent,
> for example, on x86_64 -O2:
>
> GCC 12: add/remove: 78/29 grow/shrink: 332/525 up/down: 31325/-61560 (-30235)
> LLVM 13: add/remove: 79/76 grow/shrink: 184/537 up/down: 55076/-141892 (-86816)
> LLVM 14: add/remove: 10/3 grow/shrink: 93/138 up/down: 3705/-6992 (-3287)
>
> and ARM64 (courtesy of Mark[0]):
>
> GCC 11: add/remove: 92/29 grow/shrink: 933/2766 up/down: 39340/-82580 (-43240)
> LLVM 14: add/remove: 21/11 grow/shrink: 620/651 up/down: 12060/-15824 (-3764)
>
> And the following:
>
>         DECLARE_BITMAP(flags, __IP_TUNNEL_FLAG_NUM) = { };
>         __be16 flags;
>
>         __set_bit(IP_TUNNEL_CSUM_BIT, flags);
>
>         tun_flags = cpu_to_be16(*flags & U16_MAX);
>
>         if (test_bit(IP_TUNNEL_VTI_BIT, flags))
>                 tun_flags |= VTI_ISVTI;
>
>         BUILD_BUG_ON(!__builtin_constant_p(tun_flags));
>
> doesn't blow up anymore, so that we now can e.g. use fixed bitmaps
> in compile-time assertions etc.
>
> The series has been in intel-next for a while with no reported issues.
>
> From v1[1]:
> * change 'gen_' prefixes to '_generic' to disambiguate from
>   'generated' etc. (Mark);
> * define a separate 'const_' set to use in the optimization to keep
>   the generic test_bit() atomic-safe (Marco);
> * unify arch_{test,__*}_bit() as well and include them in the type
>   check;
> * add more relevant and up-to-date bloat-o-meter results, including
>   ARM64 (me, Mark);
> * pick a couple '*-by' tags (Mark, Yury).

Thanks for the update!

On m68k, using gcc version 9.4.0 (Ubuntu 9.4.0-1ubuntu1~20.04), this
blows up immediately with:

  CC      kernel/bounds.s
In file included from include/linux/bits.h:22,
                 from include/linux/ratelimit_types.h:5,
                 from include/linux/printk.h:9,
                 from include/asm-generic/bug.h:22,
                 from arch/m68k/include/asm/bug.h:32,
                 from include/linux/bug.h:5,
                 from include/linux/page-flags.h:10,
                 from kernel/bounds.c:10:
include/linux/bitops.h:72:21: error: ‘arch___set_bit’ undeclared here
(not in a function); did you mean ‘const___set_bit’?
   72 |         __same_type(arch_##name, generic_##name) && \
      |                     ^~~~~
include/linux/build_bug.h:78:56: note: in definition of macro ‘__static_assert’
   78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
      |                                                        ^~~~
include/linux/bitops.h:71:2: note: in expansion of macro ‘static_assert’
   71 |  static_assert(__same_type(const_##name, generic_##name) && \
      |  ^~~~~~~~~~~~~
include/linux/bitops.h:72:9: note: in expansion of macro ‘__same_type’
   72 |         __same_type(arch_##name, generic_##name) && \
      |         ^~~~~~~~~~~
include/linux/bitops.h:75:1: note: in expansion of macro ‘__check_bitop_pr’
   75 | __check_bitop_pr(__set_bit);
      | ^~~~~~~~~~~~~~~~
include/linux/compiler_types.h:293:27: error: expression in static
assertion is not an integer
  293 | #define __same_type(a, b)
__builtin_types_compatible_p(typeof(a), typeof(b))
      |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:78:56: note: in definition of macro ‘__static_assert’
   78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
      |                                                        ^~~~
include/linux/bitops.h:71:2: note: in expansion of macro ‘static_assert’
   71 |  static_assert(__same_type(const_##name, generic_##name) && \
      |  ^~~~~~~~~~~~~
include/linux/bitops.h:71:16: note: in expansion of macro ‘__same_type’
   71 |  static_assert(__same_type(const_##name, generic_##name) && \
      |                ^~~~~~~~~~~
include/linux/bitops.h:75:1: note: in expansion of macro ‘__check_bitop_pr’
   75 | __check_bitop_pr(__set_bit);
      | ^~~~~~~~~~~~~~~~
include/linux/bitops.h:72:21: error: ‘arch___clear_bit’ undeclared
here (not in a function); did you mean ‘const___clear_bit’?
   72 |         __same_type(arch_##name, generic_##name) && \
      |                     ^~~~~
include/linux/build_bug.h:78:56: note: in definition of macro ‘__static_assert’
   78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
      |                                                        ^~~~
include/linux/bitops.h:71:2: note: in expansion of macro ‘static_assert’
   71 |  static_assert(__same_type(const_##name, generic_##name) && \
      |  ^~~~~~~~~~~~~
include/linux/bitops.h:72:9: note: in expansion of macro ‘__same_type’
   72 |         __same_type(arch_##name, generic_##name) && \
      |         ^~~~~~~~~~~
include/linux/bitops.h:76:1: note: in expansion of macro ‘__check_bitop_pr’
   76 | __check_bitop_pr(__clear_bit);
      | ^~~~~~~~~~~~~~~~
include/linux/compiler_types.h:293:27: error: expression in static
assertion is not an integer
  293 | #define __same_type(a, b)
__builtin_types_compatible_p(typeof(a), typeof(b))
      |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:78:56: note: in definition of macro ‘__static_assert’
   78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
      |                                                        ^~~~
include/linux/bitops.h:71:2: note: in expansion of macro ‘static_assert’
   71 |  static_assert(__same_type(const_##name, generic_##name) && \
      |  ^~~~~~~~~~~~~
include/linux/bitops.h:71:16: note: in expansion of macro ‘__same_type’
   71 |  static_assert(__same_type(const_##name, generic_##name) && \
      |                ^~~~~~~~~~~
include/linux/bitops.h:76:1: note: in expansion of macro ‘__check_bitop_pr’
   76 | __check_bitop_pr(__clear_bit);
      | ^~~~~~~~~~~~~~~~
include/linux/bitops.h:72:21: error: ‘arch___change_bit’ undeclared
here (not in a function); did you mean ‘const___change_bit’?
   72 |         __same_type(arch_##name, generic_##name) && \
      |                     ^~~~~
include/linux/build_bug.h:78:56: note: in definition of macro ‘__static_assert’
   78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
      |                                                        ^~~~
include/linux/bitops.h:71:2: note: in expansion of macro ‘static_assert’
   71 |  static_assert(__same_type(const_##name, generic_##name) && \
      |  ^~~~~~~~~~~~~
include/linux/bitops.h:72:9: note: in expansion of macro ‘__same_type’
   72 |         __same_type(arch_##name, generic_##name) && \
      |         ^~~~~~~~~~~
include/linux/bitops.h:77:1: note: in expansion of macro ‘__check_bitop_pr’
   77 | __check_bitop_pr(__change_bit);
      | ^~~~~~~~~~~~~~~~
include/linux/compiler_types.h:293:27: error: expression in static
assertion is not an integer
  293 | #define __same_type(a, b)
__builtin_types_compatible_p(typeof(a), typeof(b))
      |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:78:56: note: in definition of macro ‘__static_assert’
   78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
      |                                                        ^~~~
include/linux/bitops.h:71:2: note: in expansion of macro ‘static_assert’
   71 |  static_assert(__same_type(const_##name, generic_##name) && \
      |  ^~~~~~~~~~~~~
include/linux/bitops.h:71:16: note: in expansion of macro ‘__same_type’
   71 |  static_assert(__same_type(const_##name, generic_##name) && \
      |                ^~~~~~~~~~~
include/linux/bitops.h:77:1: note: in expansion of macro ‘__check_bitop_pr’
   77 | __check_bitop_pr(__change_bit);
      | ^~~~~~~~~~~~~~~~
include/linux/bitops.h:72:21: error: ‘arch___test_and_set_bit’
undeclared here (not in a function); did you mean
‘const___test_and_set_bit’?
   72 |         __same_type(arch_##name, generic_##name) && \
      |                     ^~~~~
include/linux/build_bug.h:78:56: note: in definition of macro ‘__static_assert’
   78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
      |                                                        ^~~~
include/linux/bitops.h:71:2: note: in expansion of macro ‘static_assert’
   71 |  static_assert(__same_type(const_##name, generic_##name) && \
      |  ^~~~~~~~~~~~~
include/linux/bitops.h:72:9: note: in expansion of macro ‘__same_type’
   72 |         __same_type(arch_##name, generic_##name) && \
      |         ^~~~~~~~~~~
include/linux/bitops.h:78:1: note: in expansion of macro ‘__check_bitop_pr’
   78 | __check_bitop_pr(__test_and_set_bit);
      | ^~~~~~~~~~~~~~~~
include/linux/compiler_types.h:293:27: error: expression in static
assertion is not an integer
  293 | #define __same_type(a, b)
__builtin_types_compatible_p(typeof(a), typeof(b))
      |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:78:56: note: in definition of macro ‘__static_assert’
   78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
      |                                                        ^~~~
include/linux/bitops.h:71:2: note: in expansion of macro ‘static_assert’
   71 |  static_assert(__same_type(const_##name, generic_##name) && \
      |  ^~~~~~~~~~~~~
include/linux/bitops.h:71:16: note: in expansion of macro ‘__same_type’
   71 |  static_assert(__same_type(const_##name, generic_##name) && \
      |                ^~~~~~~~~~~
include/linux/bitops.h:78:1: note: in expansion of macro ‘__check_bitop_pr’
   78 | __check_bitop_pr(__test_and_set_bit);
      | ^~~~~~~~~~~~~~~~
include/linux/bitops.h:72:21: error: ‘arch___test_and_clear_bit’
undeclared here (not in a function); did you mean
‘const___test_and_clear_bit’?
   72 |         __same_type(arch_##name, generic_##name) && \
      |                     ^~~~~
include/linux/build_bug.h:78:56: note: in definition of macro ‘__static_assert’
   78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
      |                                                        ^~~~
include/linux/bitops.h:71:2: note: in expansion of macro ‘static_assert’
   71 |  static_assert(__same_type(const_##name, generic_##name) && \
      |  ^~~~~~~~~~~~~
include/linux/bitops.h:72:9: note: in expansion of macro ‘__same_type’
   72 |         __same_type(arch_##name, generic_##name) && \
      |         ^~~~~~~~~~~
include/linux/bitops.h:79:1: note: in expansion of macro ‘__check_bitop_pr’
   79 | __check_bitop_pr(__test_and_clear_bit);
      | ^~~~~~~~~~~~~~~~
include/linux/compiler_types.h:293:27: error: expression in static
assertion is not an integer
  293 | #define __same_type(a, b)
__builtin_types_compatible_p(typeof(a), typeof(b))
      |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:78:56: note: in definition of macro ‘__static_assert’
   78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
      |                                                        ^~~~
include/linux/bitops.h:71:2: note: in expansion of macro ‘static_assert’
   71 |  static_assert(__same_type(const_##name, generic_##name) && \
      |  ^~~~~~~~~~~~~
include/linux/bitops.h:71:16: note: in expansion of macro ‘__same_type’
   71 |  static_assert(__same_type(const_##name, generic_##name) && \
      |                ^~~~~~~~~~~
include/linux/bitops.h:79:1: note: in expansion of macro ‘__check_bitop_pr’
   79 | __check_bitop_pr(__test_and_clear_bit);
      | ^~~~~~~~~~~~~~~~
include/linux/bitops.h:72:21: error: ‘arch___test_and_change_bit’
undeclared here (not in a function); did you mean
‘const___test_and_change_bit’?
   72 |         __same_type(arch_##name, generic_##name) && \
      |                     ^~~~~
include/linux/build_bug.h:78:56: note: in definition of macro ‘__static_assert’
   78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
      |                                                        ^~~~
include/linux/bitops.h:71:2: note: in expansion of macro ‘static_assert’
   71 |  static_assert(__same_type(const_##name, generic_##name) && \
      |  ^~~~~~~~~~~~~
include/linux/bitops.h:72:9: note: in expansion of macro ‘__same_type’
   72 |         __same_type(arch_##name, generic_##name) && \
      |         ^~~~~~~~~~~
include/linux/bitops.h:80:1: note: in expansion of macro ‘__check_bitop_pr’
   80 | __check_bitop_pr(__test_and_change_bit);
      | ^~~~~~~~~~~~~~~~
include/linux/compiler_types.h:293:27: error: expression in static
assertion is not an integer
  293 | #define __same_type(a, b)
__builtin_types_compatible_p(typeof(a), typeof(b))
      |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:78:56: note: in definition of macro ‘__static_assert’
   78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
      |                                                        ^~~~
include/linux/bitops.h:71:2: note: in expansion of macro ‘static_assert’
   71 |  static_assert(__same_type(const_##name, generic_##name) && \
      |  ^~~~~~~~~~~~~
include/linux/bitops.h:71:16: note: in expansion of macro ‘__same_type’
   71 |  static_assert(__same_type(const_##name, generic_##name) && \
      |                ^~~~~~~~~~~
include/linux/bitops.h:80:1: note: in expansion of macro ‘__check_bitop_pr’
   80 | __check_bitop_pr(__test_and_change_bit);
      | ^~~~~~~~~~~~~~~~
include/linux/bitops.h:72:21: error: ‘arch_test_bit’ undeclared here
(not in a function); did you mean ‘_test_bit’?
   72 |         __same_type(arch_##name, generic_##name) && \
      |                     ^~~~~
include/linux/build_bug.h:78:56: note: in definition of macro ‘__static_assert’
   78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
      |                                                        ^~~~
include/linux/bitops.h:71:2: note: in expansion of macro ‘static_assert’
   71 |  static_assert(__same_type(const_##name, generic_##name) && \
      |  ^~~~~~~~~~~~~
include/linux/bitops.h:72:9: note: in expansion of macro ‘__same_type’
   72 |         __same_type(arch_##name, generic_##name) && \
      |         ^~~~~~~~~~~
include/linux/bitops.h:81:1: note: in expansion of macro ‘__check_bitop_pr’
   81 | __check_bitop_pr(test_bit);
      | ^~~~~~~~~~~~~~~~
include/linux/compiler_types.h:293:27: error: expression in static
assertion is not an integer
  293 | #define __same_type(a, b)
__builtin_types_compatible_p(typeof(a), typeof(b))
      |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/build_bug.h:78:56: note: in definition of macro ‘__static_assert’
   78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
      |                                                        ^~~~
include/linux/bitops.h:71:2: note: in expansion of macro ‘static_assert’
   71 |  static_assert(__same_type(const_##name, generic_##name) && \
      |  ^~~~~~~~~~~~~
include/linux/bitops.h:71:16: note: in expansion of macro ‘__same_type’
   71 |  static_assert(__same_type(const_##name, generic_##name) && \
      |                ^~~~~~~~~~~
include/linux/bitops.h:81:1: note: in expansion of macro ‘__check_bitop_pr’
   81 | __check_bitop_pr(test_bit);
      | ^~~~~~~~~~~~~~~~

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
