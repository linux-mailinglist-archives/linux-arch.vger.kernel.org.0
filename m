Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42528781A84
	for <lists+linux-arch@lfdr.de>; Sat, 19 Aug 2023 18:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233944AbjHSQZh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 19 Aug 2023 12:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233930AbjHSQZh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 19 Aug 2023 12:25:37 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4C312740
        for <linux-arch@vger.kernel.org>; Sat, 19 Aug 2023 09:25:34 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bee82fad0fso12869425ad.2
        for <linux-arch@vger.kernel.org>; Sat, 19 Aug 2023 09:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692462333; x=1693067133;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WA5JDd/9nUU2fK4W4FowJyIDo0hZC42y0ehtux77zMQ=;
        b=sNW0KUZRGeAXGHzvoScyY2/aFp2GFPkerenykd6naqGfTRHlCiSEUlqTdC1BUJezRN
         hEW4JL/mSoSrBcKPscDg1xdymSA7PqF9KvnAplbzUxMcF/5uV32/0Tl0siLCx5Lrjr3Q
         NRzKzaycNNNT/4+nCqCNfP6cm0bEakiGQQcvLIP1KlVUrf7QvBam0tmz944NWgEhx8XL
         eVMmz4DEnIPndUzyr4HcqYxuppmHXuH6CcXhpOZtnVdZGvGtj9z7cjBffkWmxNLbaors
         5OhsKj/rCnLZCJlmZZ4z9Y1HUh/zGl22Lmbw8zbNE1mxVQbOWtrX43bCQCS0JkdAs7xO
         XMfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692462333; x=1693067133;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WA5JDd/9nUU2fK4W4FowJyIDo0hZC42y0ehtux77zMQ=;
        b=GqU5PrWF+ZabWR8y+tiu1oJyvDhroLATQC9ScBMXPa74T0doQvJrbTE4+CteYJXk97
         zUntg38Js40w8ivBf090zF5o7+2wmv1+gIniKfU6qi/BYqwfRLCGa/Gcz9iayabgauw9
         nH789PeI2FaxulQofWsKhS70NzLO/7EvFvxz6Iu5Fot4utUk3w9KU+66jtpUE/M1JaYB
         4VangGODcZAZIv8lD8GlEHCvw8wLRAnB/vxCy5GwHl2x5b/fHLdqNMlyOogsMQm/CcJA
         Y+FFE7mdziu5yEuRjPi3H5sYxea6TJcB7Q0X8cGEAWU/6babRwqlxRfaCmhQR/Wiycgl
         y+Tg==
X-Gm-Message-State: AOJu0YzgfWxU0HTS/XpLnX4IRlaBiGm3LsC3gOFCuRGIS098SDb96/mV
        Rx0XKwMc+9HWfOQ4XtVWpBaJ0A==
X-Google-Smtp-Source: AGHT+IFa5xhJmHi1B7k8WN50Y4oHUGAg2Qd3sJJM1mihhQByTEWkqUDhI+rj35OMLxGgKzkE0Cpuzw==
X-Received: by 2002:a17:902:e802:b0:1bf:1acf:9c0c with SMTP id u2-20020a170902e80200b001bf1acf9c0cmr2084621plg.26.1692462333490;
        Sat, 19 Aug 2023 09:25:33 -0700 (PDT)
Received: from leoy-huanghe.lan ([156.59.96.144])
        by smtp.gmail.com with ESMTPSA id f21-20020a170902e99500b001aadd0d7364sm3855425plb.83.2023.08.19.09.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Aug 2023 09:25:32 -0700 (PDT)
Date:   Sun, 20 Aug 2023 00:25:26 +0800
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
Message-ID: <20230819162526.GA274478@leoy-huanghe.lan>
References: <214aed18-5df5-1014-b73d-a1748c0cca13@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <214aed18-5df5-1014-b73d-a1748c0cca13@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi,

On Fri, Aug 11, 2023 at 02:22:55PM +0800, Gang Li wrote:
> Add new zh translation zh_CN/memory-barrier.txt based on v6.5-rc5.
> 
> Signed-off-by: Gang Li <gang.li@linux.dev>
> ---
>   .../translations/zh_CN/memory-barriers.txt    | 2458 +++++++++++++++++
>   1 file changed, 2458 insertions(+)
>   create mode 100644 Documentation/translations/zh_CN/memory-barriers.txt
> 
> diff --git a/Documentation/translations/zh_CN/memory-barriers.txt 
> b/Documentation/translations/zh_CN/memory-barriers.txt
> new file mode 100644
> index 000000000000..caa2775cc9c6
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/memory-barriers.txt
> @@ -0,0 +1,2458 @@
> +译注：
> +本文仅为方便汉语阅读，不保证与英文版本同步;
> +若有疑问，请阅读英文版本;
> +若有翻译问题，请通知译者；
> +若想修改文档，也请先修改英文版本。
> +
> +			 ============================
> +			 	Linux 内核内存屏障
> +			 ============================
> +
> +作者：David Howells <dhowells@redhat.com>
> +    Paul E. McKenney <paulmck@linux.ibm.com>
> +    Will Deacon <will.deacon@arm.com>
> +    Peter Zijlstra <peterz@infradead.org>
> +
> +译者：李港 Gang Li <gang.li@linux.dev>
> +
> +==========
> +免责声明
> +==========
> +
> +本文档不是一个规范；它由于有意 (为了简洁) 或无意 (由于人为因素) 
> 的原因而不完整。本文档
> +旨在指导如何使用 Linux 提供的各种内存屏障，如果有疑问 
> (而且有很多)，请在邮件列表咨询。
> +一些疑问可以通过参考正式的内存一致性模型和 tools/memory-model/ 
> 下的相关文档来解决。
> +这些内存模型是维护者的集体意见，而不是准确无误的实现规范。
> +
> +再次重申，本文档不是 Linux 对硬件的规范或期望。

再次重申，本文档不是 Linux 对硬件要求的规范手册。

> +本文档的目的有两个：
> +
> + (1) 为内核屏障函数指定可以依赖的最小功能，以及

(1) 针对任何一个特定的屏障，定义其可依赖的最小功能;

> +
> + (2) 提供关于如何使用屏障的指南。

(2) 对于可用的屏障，提供如何使用的指南。

> +
> +请注意，一个架构可以为任何屏障提供超出最低要求的功能，但是，如果架构提供的功能少于最低
> +要求，则该架构是错误的。

... 一个架构可以为任何特定的屏障实现超出最低要求的功能 ...

> +
> +还要注意的是，在某些架构中，部分屏障可能是空操作。因为该架构已经保证了该内存序，使得
> +显式屏障是不必要的。

还要注意，在某些架构中，一个屏障可能是空操作。这是因为这些架构的工作
方式不再需要显式地使用屏障了。

> +
> +========
> +目录
> +========
> +
> + (*) 抽象内存访问模型。
> +
> +     - 设备操作。
> +     - CPU 的保证。
> +
> + (*) 什么是内存屏障？
> +
> +     - 内存屏障的种类。
> +     - 关于内存屏障不可假设什么？
> +     - 地址依赖屏障 (旧) 。
> +     - 控制依赖。
> +     - SMP 屏障配对。
> +     - 内存屏障序列示例。
> +     - 读屏障与预读。

s/预读/读取预测

> +     - 多拷贝原子性。
> +
> + (*) 显式内核屏障函数。
> +
> +     - 编译器屏障。
> +     - CPU 内存屏障。
> +
> + (*) 隐式内核屏障函数。
> +
> +     - 取锁函数。

锁获取函数。

> +     - 关中断函数。
> +     - 睡眠和唤醒函数。
> +     - 其他函数。
> +
> + (*) 跨CPU ACQUIRING 屏障的影响。
> +
> +     - Acquires 与 内存访问。
> +
> + (*) 哪里需要内存屏障？
> +
> +     - 处理器间交互。
> +     - 原子操作。
> +     - 访问设备。
> +     - 中断。
> +
> + (*) 内核 I/O 屏障。
> +
> + (*) 假想的最小执行顺序模型。

s/假想/预设 ?

> +
> + (*) CPU 缓存的影响。
> +
> +     - 缓存一致性。
> +     - 缓存一致性与 DMA。
> +     - 缓存一致性与 MMIO。
> +
> + (*) CPU 相关。
> +
> +     - 还有就是Alpha。
> +     - 虚拟机客户端。
> +
> + (*) 使用示例。
> +
> +     - 环形缓冲区。
> +
> + (*) 参考资料。
> +
> +============================
> +抽象内存访问模型
> +============================
> +
> +考虑以下抽象模型：
> +
> +		            :                :
> +		            :                :
> +		            :                :
> +		+-------+   :   +--------+   :   +-------+
> +		|       |   :   |        |   :   |       |
> +		|       |   :   |        |   :   |       |
> +		| CPU 1 |<----->|   内存  |<----->| CPU 2 |

Unalignment caused by extra space around "内存".

> +		|       |   :   |        |   :   |       |
> +		|       |   :   |        |   :   |       |
> +		+-------+   :   +--------+   :   +-------+
> +		    ^       :       ^        :       ^
> +		    |       :       |        :       |
> +		    |       :       |        :       |
> +		    |       :       v        :       |
> +		    |       :   +--------+   :       |
> +		    |       :   |        |   :       |
> +		    |       :   |        |   :       |
> +		    +---------->|   设备  |<----------+
> +		            :   |        |   :
> +		            :   |        |   :
> +		            :   +--------+   :
> +		            :                :
> +
> +每个 CPU 执行一个访存程序。在本文的抽象 CPU 中，访问指令的顺序非常松散，每个 

s/访问指令的顺序非常松散/访问操作可以是完全乱序的/

Here we need to take care the subtle difference between the "memory
instructions ordering" vs "memory operations ordering".


> CPU 可以

Unintended new line.

> +按照任意顺序执行访存指令，每个 CPU 

s/访存指令/访存操作/

> 都保证在本核心看来，最终执行结果与不乱序的情况相同。
> +同样，编译器也可以按照任意顺序排列指令，只要不影响程序的运行结果。
> +
> +CPU可以通过一些本地缓存来提高指令运行效率，内存操作会被缓存在当前CPU上，每个 
> CPU 都能
> +按顺序看到自己的内存操作。但每个缓存项写入到主存的顺序未知，在上图中，即每条指令的结果穿过
> +虚线的顺序未知。

Here cannot match with the original words:

"So in the above diagram, the effects of the memory operations performed by a
CPU are perceived by the rest of the system as the operations cross the
interface between the CPU and rest of the system (the dotted lines)."

在上图中，当一个CPU执行内存操作后，其结果可以被系统中其他硬件所感知,
这需要通过在CPU和系统其他模块的接口(虚线所示)之间的额外操作来完成。

> +
> +
> +例如，考虑以下内存操作序列：
> +
> +	CPU 1		CPU 2
> +	===============	===============
> +	{ A == 1; B == 2 }
> +	A = 3;		x = B;
> +	B = 4;		y = A;
> +
> +CPU 外部可能看到如下任意顺序：

CPU 外部可能看到如下任意顺序, 其排列组合共有24种情况:

> +
> +	STORE A=3,	STORE B=4,	y=LOAD A->3,	x=LOAD B->4
> +	STORE A=3,	STORE B=4,	x=LOAD B->4,	y=LOAD A->3
> +	STORE A=3,	y=LOAD A->3,	STORE B=4,	x=LOAD B->4
> +	STORE A=3,	y=LOAD A->3,	x=LOAD B->2,	STORE B=4
> +	STORE A=3,	x=LOAD B->2,	STORE B=4,	y=LOAD A->3
> +	STORE A=3,	x=LOAD B->2,	y=LOAD A->3,	STORE B=4
> +	STORE B=4,	STORE A=3,	y=LOAD A->3,	x=LOAD B->4
> +	STORE B=4, ...
> +	...
> +
> +可以得到四种不同的结果组合：
> +
> +	x == 2, y == 1
> +	x == 2, y == 3
> +	x == 4, y == 1
> +	x == 4, y == 3
> +
> +
> +此外，一个 CPU 核心向主存提交的写可能不会被另一个 CPU 核心按顺序读。

一个CPU向内存进行写操作，而另外一个CPU在执行读操作，进行读操作的CPU
感知（或者观察到）的数据顺序，有可能和写操作（Stores）的顺序是不同的。

> +
> +
> +再举一个例子，考虑这个序列：
> +
> +	CPU 1		CPU 2
> +	===============	===============
> +	{ A == 1, B == 2, C == 3, P == &A, Q == &C }
> +	B = 4;		Q = P;
> +	P = &B;		D = *Q;
> +
> +这里有一个明显的地址依赖，D 的值取决于 CPU 2 从 P 
> 读到的地址。在序列结束时，可能出现以下任何结果：
> +
> +	(Q == &A) 和 (D == 1)
> +	(Q == &B) 和 (D == 2)
> +	(Q == &B) 和 (D == 4)
> +
> +请注意，CPU 2 永远不会 将 C 的值写入 D，因为 CPU 会在读 *Q 前将 P 赋值给 
> Q。
> +
> +
> +设备操作
> +-----------------
> +
> +有些设备是通过将自己的寄存器映射到内存来控制的，访问控制寄存器的顺序非常重要。假设一个

一些设备提供了一组访存地址空间，用于访问设备的控制接口（例如寄存器），
那么访问控制寄存器的顺序非常重要。例如，我们想象一个网卡，需要通过其
地址端口寄存器 (A) 和数据端口寄存器 (D)来访问内部寄存器。

> +网卡有一组通过地址端口寄存器 (A) 和数据端口寄存器 (D) 访问的内部寄存器。
> +要读取 5 号内部寄存器，可以使用以下代码：
> +
> +	*A = 5;
> +	x = *D;
> +
> +可能有两种执行顺序：
> +
> +	STORE *A = 5, x = LOAD *D
> +	x = LOAD *D, STORE *A = 5
> +
> +其中第二个序列几乎肯定会导致故障，因为先读后写。

... 因为地址的设置是在读取寄存器之后才完成的。


I stop here in today and will continue to review this doc.

Thanks for doing this!

Leo
