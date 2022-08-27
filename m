Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37CE25A3646
	for <lists+linux-arch@lfdr.de>; Sat, 27 Aug 2022 11:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233283AbiH0JWF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 27 Aug 2022 05:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbiH0JV5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 27 Aug 2022 05:21:57 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9861A10559;
        Sat, 27 Aug 2022 02:21:55 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id u5so4358021wrt.11;
        Sat, 27 Aug 2022 02:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc;
        bh=owsLDmoBOckRw335Xg3NmUtrVOPZquu8Z7W7wU8himM=;
        b=QBFCkSAYXBIp/LTs2NfufxKBNWjCvpQ4CwVDoSoLc8jEG5ZLkaIebcJQNqCXplIj32
         whBZmz/vmdnz0NxJiWDuR40A9FcvcG0xTXDDG+1tWr4JreEo9BCNyx/UWJllmQSxaqMK
         A6aGKugjwZqd7ZLx64MxhI7K6HsvQXlk4EitQqV3XFyLMEd4xmeX9mJgUCIhZkGxBMJn
         OE3gixD8E56tEKKbwmcwkSI3mUH1aHEhmghHB/gykWezpzbbjWBsouwoRWcxN7PCFr22
         slZVPL5PpFJfakUFSMWU9PIcRz2FxfuKFYQ+UGM0xIVrDMfXPpr7kp9kMmPFyZybn2jw
         JEyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=owsLDmoBOckRw335Xg3NmUtrVOPZquu8Z7W7wU8himM=;
        b=kjyD+ofY6nyP3MkcLHqNEuUgGJiJTufWXmDq/dQdSD/mlg+5gzriPa2HVsaJrU7AU5
         SO2OBc67WgSxpYD+zvIx8eNCec3IAzvGa3wWzAUQzGOy6+/2s4q14RhLdfB0xFMn8AHF
         2QGwK80JBcQHaXyaK5hPfVpXsYMg3uy3LHp2UyJyT1oCjHil9LJMLaHpPBoo4Fcah3JN
         w/phGcC193yU++bH9kNEA8M30usA8R1xPybnAerDkFOVyc6Wc+OEmObE5ql/zDaDF6Rs
         LX4IPuGobinK6krhzwHKLh5/Ak1ftAPSNWnl5jE8wke1J8EPeaR9niJMZuKV3hNBpWAN
         eEfg==
X-Gm-Message-State: ACgBeo32VtE0fdDGyIj7LHyLtOZvpA2Khk8RHDyfB/l9bU/ptJwNY52W
        UZDP+SOGsrYRWFzcvis8dlZtV5I01Sw=
X-Google-Smtp-Source: AA6agR7QPzCSPP0v7i7p+cguczsVI8yaVXlvXjJ0WfcG2DrIdC/C/liD2aRZl+lO3DVs+wlmdQ1B6A==
X-Received: by 2002:adf:e310:0:b0:226:d19c:de22 with SMTP id b16-20020adfe310000000b00226d19cde22mr1173409wrj.314.1661592114172;
        Sat, 27 Aug 2022 02:21:54 -0700 (PDT)
Received: from debian (host-78-150-37-98.as13285.net. [78.150.37.98])
        by smtp.gmail.com with ESMTPSA id c66-20020a1c3545000000b003a4efb794d7sm2434629wma.36.2022.08.27.02.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 02:21:53 -0700 (PDT)
Date:   Sat, 27 Aug 2022 10:21:51 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Mikulas Patocka <mpatocka@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: mainline build failure due to 8238b4579866 ("wait_on_bit: add an
 acquire memory barrier")
Message-ID: <YwniL0M7Rxz8lua+@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi All,

The latest mainline kernel branch fails to build alpha and s390 allmodconfig.

alpha error is:

In file included from ./include/linux/thread_info.h:27,
                 from ./include/asm-generic/current.h:5,
                 from ./arch/alpha/include/generated/asm/current.h:1,
                 from ./include/linux/sched.h:12,
                 from arch/alpha/kernel/asm-offsets.c:10:
./include/linux/wait_bit.h: In function 'wait_on_bit':
./include/asm-generic/bitops/non-instrumented-non-atomic.h:15:33: error: implicit declaration of function 'arch_test_bit_acquire'; did you mean '_test_bit_acquire'? [-Werror=implicit-function-declaration]
   15 | #define _test_bit_acquire       arch_test_bit_acquire
      |                                 ^~~~~~~~~~~~~~~~~~~~~
./include/linux/bitops.h:53:32: note: in definition of macro 'bitop'
   53 |          const##op(nr, addr) : op(nr, addr))
      |                                ^~
./include/linux/bitops.h:62:47: note: in expansion of macro '_test_bit_acquire'
   62 | #define test_bit_acquire(nr, addr)      bitop(_test_bit_acquire, nr, addr)
      |                                               ^~~~~~~~~~~~~~~~~
./include/linux/wait_bit.h:74:14: note: in expansion of macro 'test_bit_acquire'
   74 |         if (!test_bit_acquire(bit, word))
      |              ^~~~~~~~~~~~~~~~

s390 error is:

In file included from ./arch/s390/include/asm/bitops.h:211,
                 from ./include/linux/bitops.h:68,
                 from ./include/linux/log2.h:12,
                 from kernel/bounds.c:13:
./include/asm-generic/bitops/instrumented-non-atomic.h: In function '_test_bit_acquire':
./include/asm-generic/bitops/instrumented-non-atomic.h:154:16: error: implicit declaration of function 'arch_test_bit_acquire'; did you mean '_test_bit_acquire'? [-Werror=implicit-function-declaration]
  154 |         return arch_test_bit_acquire(nr, addr);
      |                ^~~~~~~~~~~~~~~~~~~~~
      |                _test_bit_acquire


git bisect pointed to 8238b4579866 ("wait_on_bit: add an acquire memory barrier").
And, reverting that commit has fixed the build failure.

I will be happy to test any patch or provide any extra log if needed.

--
Regards
Sudip
