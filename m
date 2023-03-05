Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A92E6AB22C
	for <lists+linux-arch@lfdr.de>; Sun,  5 Mar 2023 21:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjCEU4w (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 5 Mar 2023 15:56:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjCEU4v (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 5 Mar 2023 15:56:51 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C7010A84;
        Sun,  5 Mar 2023 12:56:50 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id k10so6898555edk.13;
        Sun, 05 Mar 2023 12:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678049808;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hNEkm4zOMdJBSU8KKqreG62DLRxeXn3Xkh8biCMSrGQ=;
        b=fYF9dMtkj1YXiWLjWXVi108GaUsP78YWiLOBcqczOwcGB1KS3hFQGdzMmnPB40ydKb
         CJBU4IAcJ0MjxZbPRv/XnGoAjuT4JRbTP5/rspAGr1pVqCKhRoeHY3MISmOrijMZ/1Zu
         bzRGM/41AcDVAq0R82jvDwaNabVWUjpb24UlLxEmo/ypXHTY5dkWwNInk9ZHOiAeRtfv
         /SV5xswkUyIS+kqp65TKME9k1EuFNhsY+K7YcAsF17i/iTmekg08B/ESrHCvrUtCJFsT
         l473Q2p3EZjGHpQi0fM7RSy1MdpNqnqxaUQ0X1U1Z9yt4tvfwyH//k4NXO64wBvCP+Pa
         DoGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678049808;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hNEkm4zOMdJBSU8KKqreG62DLRxeXn3Xkh8biCMSrGQ=;
        b=BMy8OefUDuJ+vkuy5zBtOhWZ2bBpnY/mIKP1ZYfvxIN1yfcsJNKd4g+7gHaZh5nDqy
         oeSiRnDArTez763WSAewR6ROq8sanZxrQwmRJMkrNjPwrIaTIYJq/wZYm35/koIIUd6M
         nNbp+5W8e4Uird0NJMX4pt89vYUU1kfTGP5EXEnaDUgwNKGZNnRjmHwBzWZNPalQ5vIp
         ond/a5uW4YZf2wW35DEAp6/MvUs+RsCYn/6BsQLFqbtjhBIjHTVi9vA62oaO+I+e1bBm
         DmBO4i4EhJdx/2JMF16z6HaJozox7AvDlqgAiFLySQnXYlT88vsniMZGUrk4N3gtCT4v
         o4fw==
X-Gm-Message-State: AO0yUKWPjAGELqL8DZWG36RcqNF+Namo+aWBffIQyn7tF8C++kb2+0gA
        GGMDjjVdtYiC7Yaia6n+hg4+Nv5ZnzaNq8S4
X-Google-Smtp-Source: AK7set/RUb5/XHQZd/krFNbQoHv4XST5YnFdb9U8YR6v6o3hVBIJ8gVcKyFZsXQGz5Rhs9cjnpYrzA==
X-Received: by 2002:a17:906:384a:b0:8f0:143d:ee28 with SMTP id w10-20020a170906384a00b008f0143dee28mr8887420ejc.16.1678049808165;
        Sun, 05 Mar 2023 12:56:48 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id ay24-20020a170906d29800b0090953b9da51sm3615436ejb.194.2023.03.05.12.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 12:56:47 -0800 (PST)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Jun Yi <yijun@loongson.cn>
Subject: [PATCH 00/10] locking: Introduce local{,64}_try_cmpxchg
Date:   Sun,  5 Mar 2023 21:56:18 +0100
Message-Id: <20230305205628.27385-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add generic and target specific support for local{,64}_try_cmpxchg
and wire up support for all targets that use local_t infrastructure.

The patch enables x86 targets to emit special instruction for
local_try_cmpxchg and also local64_try_cmpxchg for x86_64.

The last patch changes __perf_output_begin in events/ring_buffer
to use new locking primitive and improves code from

     4b3:	48 8b 82 e8 00 00 00 	mov    0xe8(%rdx),%rax
     4ba:	48 8b b8 08 04 00 00 	mov    0x408(%rax),%rdi
     4c1:	8b 42 1c             	mov    0x1c(%rdx),%eax
     4c4:	48 8b 4a 28          	mov    0x28(%rdx),%rcx
     4c8:	85 c0                	test   %eax,%eax
     ...
     4ef:	48 89 c8             	mov    %rcx,%rax
     4f2:	48 0f b1 7a 28       	cmpxchg %rdi,0x28(%rdx)
     4f7:	48 39 c1             	cmp    %rax,%rcx
     4fa:	75 b7                	jne    4b3 <...>

to

     4b2:	48 8b 4a 28          	mov    0x28(%rdx),%rcx
     4b6:	48 8b 82 e8 00 00 00 	mov    0xe8(%rdx),%rax
     4bd:	48 8b b0 08 04 00 00 	mov    0x408(%rax),%rsi
     4c4:	8b 42 1c             	mov    0x1c(%rdx),%eax
     4c7:	85 c0                	test   %eax,%eax
     ...
     4d4:	48 89 c8             	mov    %rcx,%rax
     4d7:	48 0f b1 72 28       	cmpxchg %rsi,0x28(%rdx)
     4dc:	0f 85 d0 00 00 00    	jne    5b2 <...>
     ...
     5b2:	48 89 c1             	mov    %rax,%rcx
     5b5:	e9 fc fe ff ff       	jmp    4b6 <...>

Please note that in addition to removed compare, the load from
0x28(%rdx) gets moved out of the loop and the code is rearranged
according to likely/unlikely tags in the source.

Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Will Deacon <will@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Jun Yi <yijun@loongson.cn>

Uros Bizjak (10):
  locking/atomic: Add missing cast to try_cmpxchg() fallbacks
  locking/atomic: Add generic try_cmpxchg{,64}_local support
  locking/alpha: Wire up local_try_cmpxchg
  locking/loongarch: Wire up local_try_cmpxchg
  locking/mips: Wire up local_try_cmpxchg
  locking/powerpc: Wire up local_try_cmpxchg
  locking/x86: Wire up local_try_cmpxchg
  locking/generic: Wire up local{,64}_try_cmpxchg
  locking/x86: Enable local{,64}_try_cmpxchg
  perf/ring_buffer: use local_try_cmpxchg in __perf_output_begin

 arch/alpha/include/asm/local.h              |  2 ++
 arch/loongarch/include/asm/local.h          |  2 ++
 arch/mips/include/asm/local.h               |  2 ++
 arch/powerpc/include/asm/local.h            | 11 ++++++
 arch/x86/include/asm/cmpxchg.h              |  6 ++++
 arch/x86/include/asm/local.h                |  2 ++
 include/asm-generic/local.h                 |  1 +
 include/asm-generic/local64.h               |  2 ++
 include/linux/atomic/atomic-arch-fallback.h | 40 ++++++++++++++++-----
 include/linux/atomic/atomic-instrumented.h  | 20 ++++++++++-
 kernel/events/ring_buffer.c                 |  5 +--
 scripts/atomic/gen-atomic-fallback.sh       |  6 +++-
 scripts/atomic/gen-atomic-instrumented.sh   |  2 +-
 13 files changed, 87 insertions(+), 14 deletions(-)

-- 
2.39.2

