Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8788F265
	for <lists+linux-arch@lfdr.de>; Thu, 15 Aug 2019 19:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732508AbfHORig (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Aug 2019 13:38:36 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45755 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728685AbfHORig (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Aug 2019 13:38:36 -0400
Received: by mail-pf1-f193.google.com with SMTP id w26so1646780pfq.12;
        Thu, 15 Aug 2019 10:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=euIwOXnK/svYHHXPSlmp88qDO1N+OcnvV3P5BXMue5g=;
        b=CS0VBL1+zvqK+8DcO7ZE7dAZAaQ0bWWAcL+P2fYvK0b43mojfJGF9QCXVLO7+RDUnA
         Xt8WdeaVCWI4lrvW5qM8iWPEyVG/P6d4KZSU0cdm+rhh2brZLielTHLuieic7j+ZemP2
         1c9mAI8yzVCYQ/rU5M4yrFGMpu0zmiLP4hDx1sqVyAFTNzzoFgvg7XHbF3fl3JsShMZF
         qtqX48eBdG/+bMjZOV3FGk3Wq4oQEJfXuNLnE9nstbVXGJREk0wUfuKECf70hIw8Jbj3
         7QUNRb7MPF1wRGV7IXxLZnV9JdU5/pqjgfx0mgYjL+T7trsepX6NIqZv7fDHWqhi1lnB
         J0Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=euIwOXnK/svYHHXPSlmp88qDO1N+OcnvV3P5BXMue5g=;
        b=g1qhhlBjen0gShI2XoqzUnGcBoA6gR2r0lEQxIIVd8uoHG6aQpttEaYMuxqgbaxqkS
         Zj+Rs7qQGLLOa8NNh4C1K+dagY3meaWXDjcaPHZ5PEK9o5sfw7Wy/TNVOH5dVJbrDNoQ
         CVdJcnewt8cP3EfPfRLyKlR1/kmYNbZndorcBKTYLkNrXQE7Cbb4J1U8cKxTzz8m2Me6
         Bejj0i2UAJr9RwXn2kA0VDYMkSxKwI5JMWU6T8mUvOSlAFEO3YSrulfcaT1nbexNKF4v
         iD3NBNsJp/uEuFwwsKPmkuU7gQHEvMXwaTkVQae4g+dfFedC2W4xUCto6aN1hY/sakcQ
         qUyg==
X-Gm-Message-State: APjAAAVuTWk39fmfpLG5TSJjKwF/0OpsrYJFNJtHaLA0FAq+e+bjQGyS
        yCEZqjAVor/xAZeBgkPpiz23MoVF
X-Google-Smtp-Source: APXvYqxYliQ8QXyA6bg2cQ8hluZ/YaCldQ4vOlvxR7/QowwAjhYBKdr+cF6WsHHPG8ro2pXGOHSURw==
X-Received: by 2002:a17:90a:bd0b:: with SMTP id y11mr3104986pjr.141.1565890715816;
        Thu, 15 Aug 2019 10:38:35 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m20sm3516107pff.79.2019.08.15.10.38.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Aug 2019 10:38:34 -0700 (PDT)
Date:   Thu, 15 Aug 2019 10:38:33 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, arnd@arndb.de,
        kirill.shutemov@linux.intel.com, mhocko@suse.com, jgg@ziepe.ca,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] asm-generic: fix variable 'p4d' set but not used
Message-ID: <20190815173833.GA29763@roeck-us.net>
References: <20190806232917.881-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806232917.881-1-cai@lca.pw>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 06, 2019 at 07:29:17PM -0400, Qian Cai wrote:
> A compiler throws a warning on an arm64 system since the
> commit 9849a5697d3d ("arch, mm: convert all architectures to use
> 5level-fixup.h"),
> 
> mm/kasan/init.c: In function 'kasan_free_p4d':
> mm/kasan/init.c:344:9: warning: variable 'p4d' set but not used
> [-Wunused-but-set-variable]
>  p4d_t *p4d;
>         ^~~
> 
> because p4d_none() in "5level-fixup.h" is compiled away while it is a
> static inline function in "pgtable-nopud.h". However, if converted
> p4d_none() to a static inline there, powerpc would be unhappy as it
> reads those in assembler language in
> "arch/powerpc/include/asm/book3s/64/pgtable.h", so it needs to skip
> assembly include for the static inline C function. While at it,
> converted a few similar functions to be consistent with the ones in
> "pgtable-nopud.h".
> 
> Signed-off-by: Qian Cai <cai@lca.pw>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

All parisc builds fail with this patch applied.

include/asm-generic/5level-fixup.h:14:18: error:
	unknown type name 'pgd_t'; did you mean 'pid_t'?

Bisect results below.

Guenter

---
# bad: [329120423947e8b36fd2f8b5cf69944405d0aece] Merge tag 'auxdisplay-for-linus-v5.3-rc5' of git://github.com/ojeda/linux
# good: [ee1c7bd33e66376067fd6306b730789ee2ae53e4] Merge tag 'tpmdd-next-20190813' of git://git.infradead.org/users/jjs/linux-tpmdd
git bisect start 'HEAD' 'ee1c7bd33e66'
# bad: [e83b009c5c366b678c7986fa6c1d38fed06c954c] Merge tag 'dma-mapping-5.3-4' of git://git.infradead.org/users/hch/dma-mapping
git bisect bad e83b009c5c366b678c7986fa6c1d38fed06c954c
# bad: [92717d429b38e4f9f934eed7e605cc42858f1839] Revert "Revert "mm, thp: consolidate THP gfp handling into alloc_hugepage_direct_gfpmask""
git bisect bad 92717d429b38e4f9f934eed7e605cc42858f1839
# good: [b997052bc3ac444a0bceab1093aff7ae71ed419e] mm/z3fold.c: fix z3fold_destroy_pool() race condition
git bisect good b997052bc3ac444a0bceab1093aff7ae71ed419e
# good: [951531691c4bcaa59f56a316e018bc2ff1ddf855] mm/usercopy: use memory range to be accessed for wraparound check
git bisect good 951531691c4bcaa59f56a316e018bc2ff1ddf855
# good: [6a2aeab59e97101b4001bac84388fc49a992f87e] seq_file: fix problem when seeking mid-record
git bisect good 6a2aeab59e97101b4001bac84388fc49a992f87e
# bad: [0cfaee2af3a04c0be5f056cebe5f804dedc59a43] include/asm-generic/5level-fixup.h: fix variable 'p4d' set but not used
git bisect bad 0cfaee2af3a04c0be5f056cebe5f804dedc59a43
# first bad commit: [0cfaee2af3a04c0be5f056cebe5f804dedc59a43] include/asm-generic/5level-fixup.h: fix variable 'p4d' set but not used
