Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1B5488486
	for <lists+linux-arch@lfdr.de>; Sat,  8 Jan 2022 17:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbiAHQ0t (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 8 Jan 2022 11:26:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiAHQ0t (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 Jan 2022 11:26:49 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64A6C06173F;
        Sat,  8 Jan 2022 08:26:48 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id c126-20020a1c9a84000000b00346f9ebee43so4606534wme.4;
        Sat, 08 Jan 2022 08:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=u1H+4M8YW/2Pf02D9Owq7XFEu0//KRJ4dZR9M7ZqmXM=;
        b=lbVUVnGHfcTzJBF2F548kPdl9MhJVD6uLhE7qCGEUhQNDeRx5WTGn1nVPEFO9KvAbC
         gXSGDWF9BB76AMshlf8OB+C9S14M39+Li9rUSxfhTaQ7hY0MWFwI9lM5qBnSnIZ1QaIX
         62uBFYE2NopfBbgsnJTMWiw38/FtKfcqz6kv2mRa6akyggaKbpvhasE+/Abl4izU1NBc
         chqgfMyZByAAdMjPq50JGBpaHB6hCLHepMW0IV1nYOwrE7yMFa4xLSYxKJVTA3N5XPQE
         7tVaM331Y5Vhgsl8T31q7c+asit+oYoO4sPO6yLkmAgAS45bop160hs+2CQdWiHFQrmS
         759A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=u1H+4M8YW/2Pf02D9Owq7XFEu0//KRJ4dZR9M7ZqmXM=;
        b=4LqTtCUuuDNlLVzw6rHScJTKAIanx4ABkEOuD4wvp1YShuqLE8NlGuYU1PjMMVsRBT
         bdKj946A2qA5yp2ZQqWNkjgR2gBlGwuXQdP9hiuKWEa5IO6ufVDgPEtuMV4GmoQjxgY3
         zYfTbXEi/XrlNVJvehXQ2cG+A5gaieOSjpQiuRlqZqqe/tmTG0xIIR2KeUT7dt5rI/a3
         8pX17Dde4iMmQJNd0R7gzt4jLovTXJPJynsmkn/ypJ3chTs9E/G17uPR2r+JPtCOxSPg
         nYQIhQDVOjb0JHdxae2XlYKaK8M3wmAcX/gqxUaDYzdjjK8e8Zmkm8V4CuvkKuhKZ4sw
         NW+Q==
X-Gm-Message-State: AOAM5309cyVxYPqBaIT8kka+MbdLnJdHNcCeGVFMovrKO+pDqs/P79Lf
        bCJi0Zv3BAN11caIWOuMzjdDNNItogg=
X-Google-Smtp-Source: ABdhPJzRjZ2b9JHMj0IW5N3QTRZ/Stk2xBRhG48hW6YwIExuDVyO2N7PkihIu9GmMRiiP2RasfynxQ==
X-Received: by 2002:a05:600c:198f:: with SMTP id t15mr14978271wmq.154.1641659207291;
        Sat, 08 Jan 2022 08:26:47 -0800 (PST)
Received: from gmail.com (84-236-113-171.pool.digikabel.hu. [84.236.113.171])
        by smtp.gmail.com with ESMTPSA id m17sm1984931wmq.31.2022.01.08.08.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 08:26:46 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 8 Jan 2022 17:26:45 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [ANNOUNCE] "Fast Kernel Headers" Tree -v2
Message-ID: <Ydm7ReZWQPrbIugn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


I'm pleased to announce -v2 of the "Fast Kernel Headers" tree, which is a 
comprehensive rework of the Linux kernel's header hierarchy & header 
dependencies, with the dual goals of:

 - speeding up the kernel build (both absolute and incremental build times)

 - decoupling subsystem type & API definitions from each other

The fast-headers tree consists of over 25 sub-trees internally, spanning 
over 2,300 commits, which can be found at:

   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git master

   # HEAD: 391ce485ced0 headers/deps: Introduce the CONFIG_FAST_HEADERS=y config option

Changes in -v2:

 - Port to v5.16-rc8

 - Clang/LLVM support (with the help of Nathan Chancellor):

   On my 'reference distro config' the build speedup under Clang is around +88%
   in elapsed time and +77% in CPU time used:

     #
     # v5.16-rc8
     #
     Performance counter stats for 'make -j96 vmlinux LLVM=1' (3 runs):

      18,490,451.51 msec cpu-clock          # 54.740 CPUs utilized   ( +-  0.04% )

      337.788 +- 0.834 seconds time elapsed  ( +-  0.25% )

     #
     # -fast-headers-v2
     #
     Performance counter stats for 'make -j96 vmlinux LLVM=1' (3 runs):

      10,443,670.86 msec cpu-clock          # 58.093 CPUs utilized   ( +-  0.00% )

      179.773 +- 0.829 seconds time elapsed  ( +-  0.46% )

 - Unify the duplicated 'struct task_struct_per_task' into a single definition,
   which should address the definition ugliness reported by Greg Kroah-Hartman.

 - Fix bugs reported by Nathan Chancellor:

    - cacheline attribute definition bug
    - build bug with GCC plugins
    - fix off-tree build

 - Header optimizations that speed up the RDMA (infiniband) subsystem build 
   by about +9% over -v1 and +41% over the vanilla kernel:

     $ perf stat --repeat 3 -e instructions,cycles,cpu-clock --sync --pre "find . -name '*.o' | xargs rm" m-rdma >/dev/null
     ...

     # v5.16-rc8:

          643,570.38 msec cpu-clock                 #   52.253 CPUs utilized            ( +-  0.06% )

               12.316 +- 0.183 seconds time elapsed  ( +-  1.49% )

     # -fast-headers-v1:
          446,243.49 msec cpu-clock                 #   47.106 CPUs utilized            ( +-  0.06% )

                9.4731 +- 0.0666 seconds time elapsed  ( +-  0.70% )

     # -fast-headers-v2:
          400,650.32 msec cpu-clock                 #   45.888 CPUs utilized            ( +-  0.02% )

                8.7310 +- 0.0162 seconds time elapsed  ( +-  0.19% )

  - Another round of <linux/sched.h> header footprint reductions: the 
    header is now used in only ~36% of .c files, down from 99% in the 
    mainline kernel and 68% in -v1.

  - Various bisectability improvements & other fixes & optimizations.

Thanks,

	Ingo
