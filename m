Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27099781EDB
	for <lists+linux-arch@lfdr.de>; Sun, 20 Aug 2023 18:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbjHTQuu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 20 Aug 2023 12:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbjHTQut (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 20 Aug 2023 12:50:49 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1A83AA7
        for <linux-arch@vger.kernel.org>; Sun, 20 Aug 2023 09:50:35 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bf5c314a57so2094685ad.1
        for <linux-arch@vger.kernel.org>; Sun, 20 Aug 2023 09:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692550235; x=1693155035;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YySIB6bHnj1TTlbpovExKJqsscTyuBkTOIaRibCGtfQ=;
        b=lWzoc6AnNwwXxjr4mhbgPkXAUPHHWU/5N5CGL0BW52mvpeKzyNsEOnpr27IIHOuD9x
         +oTNmIsE+GnDMtqNYyXrmTPKigezgIPQinL5aW5T20OvAOkIkb2m5CO6MaroCiZS4oGE
         WRmsk00tQg8dSfEBK3Qk4zqabDJlCIs29gxVIaHfGKTjM1JZ1TATaqBDQNuQde9IXXN0
         ir9b85NFYkc16P/r5NtV0qpUwkw6enNjTgzYHjI4Iab/H23M1i5H5ZByk8Q6Swl4MHkK
         brG7NZs8qZpWt5fjm2VftQgKEFrBFI3JklcTmgBy9SvUf0ppg+nDbr4PmCXxBDe/bxe7
         GlAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692550235; x=1693155035;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YySIB6bHnj1TTlbpovExKJqsscTyuBkTOIaRibCGtfQ=;
        b=a3ceUD8Yn6YC2Ljort3ym99aPmgV2P//i59RelClgh+Trk7KhvYRml4VimjioHXpJk
         SFATqFz/7QWjWUnMkh+R0JOnikw4V7rVuu/APzh6sjbkhOSLX84oHvwVKIR4xRE1U2Hw
         BkXoX6KeTBuyeOt3XY8ZSqvjIpX87Cgs2l53emtq5SWQg7co2U6ZDYKh7g8s/nJCMZN2
         8HifzaNU6LPsahFKBqyPwTjd1K80IRhtXro57pr9QPkHAFcNQu2VIfuzyKPLEXiuYWLP
         f83zn/Sj6m9TNYdvGxtxNQ+Rl191OiUE9x6z98VoulZuaxBU+NMND2qCG30FLNQq5Erg
         K81A==
X-Gm-Message-State: AOJu0YzLmnNAXw6poLaYce1SMTUIZaDsm/0es6aCgx3i2MZrvZ0qHktM
        c36C+JDr7XExNC4LB8wGDMQZXA==
X-Google-Smtp-Source: AGHT+IGCkBHmPiCjw6m5Swlzthn8D4+HlZYI4kimHO8y1t8N/tmtHmrQXe3JzOsF2zGEqUcfhEItrw==
X-Received: by 2002:a17:902:8c85:b0:1bf:13a7:d3ef with SMTP id t5-20020a1709028c8500b001bf13a7d3efmr2364614plo.66.1692550234686;
        Sun, 20 Aug 2023 09:50:34 -0700 (PDT)
Received: from leoy-huanghe.lan ([94.177.131.100])
        by smtp.gmail.com with ESMTPSA id c15-20020a170903234f00b001ae0152d280sm5300473plh.193.2023.08.20.09.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 09:50:33 -0700 (PDT)
Date:   Mon, 21 Aug 2023 00:50:19 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Gang Li <gang.li@linux.dev>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1] docs/zh_CN: add zh_CN translation for
 memory-barriers.txt
Message-ID: <20230820165019.GA1606648@leoy-huanghe.lan>
References: <214aed18-5df5-1014-b73d-a1748c0cca13@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <214aed18-5df5-1014-b73d-a1748c0cca13@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 11, 2023 at 02:22:55PM +0800, Gang Li wrote:

[...]

> +CPU 的保证
> +----------
> +
> +如果我们使用了编译器屏障 READ_ONCE 和 
> WRITE_ONCE，那就可以避免编译器对代码进行优化，
> +此时生成的汇编指令跟代码是一样的，CPU 
> 应当对这些汇编指令提供一些最基本的保证：

I prefer to translate the orginal text but you can add extra
explanation with explict mark, something like:

一个 CPU 应当提供一些最基本的保证 (译者注1):

  ....

译者注1: 软件使用编译器屏障READ_ONCE()和WRITE_ONCE(), 以避免在编译阶段对代码
进行内存访问的优化，在排除编译器影响之后，CPU需要提供基本保证。

> +
> + (*) 在任何给定的 CPU 上，相互依赖的内存访问应当按顺序进行，

s/按顺序进行/按程序顺序进行

> +     这意味着对于：
> +
> +	Q = READ_ONCE(P); D = READ_ONCE(*Q);
> +
> +     CPU 将发出以下内存操作：
> +
> +	Q = LOAD P, D = LOAD *Q
> +
> +     并始终按照该顺序。然而，在 DEC Alpha 上，READ_ONCE() 还
> +     发出一个内存屏障指令，以便 DEC Alpha CPU 将发出以下内存操作：
> +
> +	Q = LOAD P, MEMORY_BARRIER, D = LOAD *Q, MEMORY_BARRIER
> +
> +     无论是在 DEC Alpha 还是其他平台，READ_ONCE() 还可以防止编译器优化。
> +
> + (*) 对同一地址或重叠地址的读写操作应当是有序的：

在特定的CPU上，针对读写的重叠访问，操作应当顺序化:

> +
> +	a = READ_ONCE(*X); WRITE_ONCE(*X, b);
> +
> +     CPU 应当进行以下顺序的内存操作：
> +
> +	a = LOAD *X, STORE *X = b
> +
> +     而对于：
> +
> +	WRITE_ONCE(*X, c); d = READ_ONCE(*X);
> +
> +     CPU 应当执行：
> +
> +	STORE *X = c, d = LOAD *X
> +
> +     (CPU 应当按照代码执行，不能自行优化) 。

This is not same with the original text.  Should be:

        (当访问的地址空间重叠时候，将其称之为读写的重叠访问)。


> +
> +如果不使用编译器屏障，编译器可能进行如下优化：

For "And there are a number of things that _must_ or _must_not_ be
assumed:"

下面是几个必能（must)和必不能(must not)的假设：

> +
> + (*) 没有 READ_ONCE() 和 WRITE_ONCE() 
> 这两个编译器屏障，编译器可以在确保单线程安全
> +     的情况下进行各种优化，这些优化在 COMPILER BARRIER 部分有介绍。

(*) 当程序没有被 READ_ONCE() 和 WRITE_ONCE() 保护时，必不能假设编译器会
按照你所想的方式去访问内存。若没有使用这些保护，编译器可以做各种
"有创造性"的优化，这些优化在 COMPILER BARRIER 部分有介绍。

> +
> + (*) 编译器会使读写乱序：

(*) 必不能假设相互没有关联的读和写操作会按照程序顺序去执行。这意味着下
面的例子：

> +
> +	X = *A; Y = *B; *D = Z;
> +
> +     我们可能会得到以下任意序列：
> +
> +	X = LOAD *A,  Y = LOAD *B,  STORE *D = Z
> +	X = LOAD *A,  STORE *D = Z, Y = LOAD *B
> +	Y = LOAD *B,  X = LOAD *A,  STORE *D = Z
> +	Y = LOAD *B,  STORE *D = Z, X = LOAD *A
> +	STORE *D = Z, X = LOAD *A,  Y = LOAD *B
> +	STORE *D = Z, Y = LOAD *B,  X = LOAD *A
> +
> + (*) 对相同地址的访问可能会合并或丢弃。这意味着对于：

(*) 必能假设，重叠访问是可能合并或丢弃的。这意味着对于：

> +
> +	X = *A; Y = *(A + 4);
> +
> +     我们可能会得到以下任意序列：
> +
> +	X = LOAD *A; Y = LOAD *(A + 4);
> +	Y = LOAD *(A + 4); X = LOAD *A;
> +	{X, Y} = LOAD {*A, *(A + 4) };
> +
> +     对于：
> +
> +	*A = X; *(A + 4) = Y;
> +
> +     我们可能会得到以下任意序列：
> +
> +	STORE *A = X; STORE *(A + 4) = Y;
> +	STORE *(A + 4) = Y; STORE *A = X;
> +	STORE {*A, *(A + 4) } = {X, Y};
> +
> +上述内容不适用于如下情况：

CPU 的保证不适用于如下情况：

> +
> + (*) 不适用于位域，因为编译器通常会生成使用非原子性的 读-修改-写 
> 序列修改这些位域的代码。
> +     不要尝试使用位域来同步并行算法。
> +
> + (*) 
> 给定位域中的所有字段必须由一个锁保护。如果给定位域中的两个字段受不同锁保护，编译器的
> +     非原子性读-修改-写序列可能会导致更新一个字段时破坏相邻字段的值。
> +
> + (*) 这些保证仅适用于正确对齐且大小正确的标量变量。"正确大小" 

s/大小正确/正确大小

> 目前意味着变量的大小与
> +     "char"、"short"、"int" 和 "long" 相同。"正确对齐" 
> 指的是自然对齐，因此对于
> +     "char" 没有约束，"short" 需要两字节对齐，"int" 需要四字节对齐，对于 32 
> 位和 64
> +     位系统上的 "long" 分别需要四字节或八字节对齐。请注意，这些保证已引入 C11 
> 标准，
> +     因此在使用较旧的编译器 (例如 gcc 4.6) 时要小心。包含此保证的标准部分
> +     是第 3.14 节，它将 "memory location" 定义如下：
> +
> +     	内存位置
> +		是标量类型的对象，或者是所有宽度非零的相邻位域的最大序列
> +
> +		注意1：两个执行线程可以更新和访问单独的内存位置，而不会相互干扰。

s/单独的/各自的

> +
> +		注意2：位域和相邻的非位域成员位于单独的内存位置。对于两个相邻位域，如

s/单独的/各自的

> +		果其中一个位域在嵌套结构中，而另一个没有，或者两个位域之间隔着一个零
> +		长度的位域，或者他们被一个非位域成员分隔，那这两个位域也位于单独的内存

s/单独的/各自的

> +		位置。如果在两个位域之间所有的成员也都是位域，那么无论两个位域间插入
> +		多少位域，都认为是一个内存地址，同时更新这两个位域是不安全的。

如果在同一个数据结构里面，两个位域之间所有的成员也都是位域，那么无论两个位
域间插入多少位域，同时更新这两个位域是不安全的。

应该删掉“都认为是一个内存地址“，在原文中并没有这样的表达。

> +
> +
> +=========================
> +什么是内存屏障？
> +=========================
> +
> +如上所述，独立的内存操作在 CPU 外看起来是随机执行的，这对 CPU 之间的交互和 I/O 

如上所述，为了高效的执行，相互独立的内存操作是可随机顺序执行的，但是也会在 CPU 之间
的交互和 I/O 访问时造成问题。

> 可能会
> +造成问题。我们需要一种方法来限制编译器和 CPU 的乱序。

s/一种/一些

> +
> +内存屏障就是这样的干预手段。它们使得屏障两侧的内存操作不能跨越屏障。

屏障强加给前后的内存操作，使其部分顺序化。

也可以考虑加上"并且在系统里能感知到顺序化".

> +
> +这种强制排序很重要，因为系统中的 CPU 和其他设备可以使用各种技巧来提高性能，
> +包括重排序、延迟执行、组合内存操作、预读、分支预测以及各种类型的缓存。内存屏

s/预读/预测读取/

预读比较容易和readahead产生歧义.

> +障用于覆盖或抑制这些技巧，使代码能够合理地控制多个 CPU 

s/覆盖/规避

> 和/或设备之间的交互。

从而在CPU之间和/或设备之间, 代码能够正常地控制交互。

> +
> +
> +内存屏障的种类
> +---------------------------
> +
> +内存屏障主要有四种基本类型：
> +
> + (1) 写(store 或 write)屏障。
> +
> + 
> 写内存屏障保证，在系统的其他组件看来，所有屏障前的写操作都在该屏障后的写操作执行前完成。
> +
> +     写屏障仅对写进行排序；不要求对读(LOAD)排序。


排序更多的是"sorted".

写屏障仅对写部分顺序化；不要求对读(LOAD)产生影响。


> +
> + 
> 写屏障前的写操作不会被乱序到写屏障之后，写屏障之后的写操作不会被乱序到写屏障前。

"A CPU can be viewed as committing a sequence of store operations to the
memory system as time progresses.  All stores _before_ a write barrier
will occur _before_ all the stores after the write barrier."

从时间推移的角度，可以看作一个CPU给内存系统提交了一序列的写操作。从
而，写屏障之前的写操作会先完成，写屏障之后的写操作会后完成。

> +
> +     [!] 请注意，写屏障通常应与读屏障或地址依赖屏障配对；请参阅 "SMP 屏障配对" 
> 子节。

Thanks,
Leo
