Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8809A83415
	for <lists+linux-arch@lfdr.de>; Tue,  6 Aug 2019 16:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732893AbfHFOjG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Aug 2019 10:39:06 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37596 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731166AbfHFOjG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Aug 2019 10:39:06 -0400
Received: by mail-qt1-f194.google.com with SMTP id y26so84763700qto.4
        for <linux-arch@vger.kernel.org>; Tue, 06 Aug 2019 07:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R5CPIS4mmyxALTwu292eKFtIXYTqe3SCg3BcaBK423k=;
        b=XTjnnHi8z+SYvy9zIZcrSsQ/4Y2tZDIGwuTiAd3On/3Qyk2jJKpY9TJZwKkhDIEj3+
         MGHtt3rEv401lGpVq5xL0CKheYAiDCONwdtltzljbu1GSNGjaTUSRBGuj6fMXfPd7xx9
         AvWLguAEFAriYfUuE/os0GFuvFNJgqJH9P1XG2mJ+YwX0AZhkzMufVj8RERsoxhYeF6L
         xRIbWAbvwo4On/nNeR5bWsE7X6QGURzO6ky4zV3wi1UlvTjZErwMLSfQ7U9cov+5JWeV
         kG6leE1orrap1pWD6YdXGVpsb3smabaJfOBSV25ApiXrIfZ6NUpp239eLF46tRKUjS0M
         cRZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R5CPIS4mmyxALTwu292eKFtIXYTqe3SCg3BcaBK423k=;
        b=UmKF2EhN5mpY3TVujPwt05I4LEgrh5V2+zLMXqDQq9/ArT2EYJaoW8gCjyEHo1VorM
         zGX9jjuAq5kbKPz5aZkpZS+8GPzA9JljC567gXVrj9dtNjI/7Lxz++3ZIOOj7QhugRAc
         ifvxx+3iDa6+PFCBXNyNEKmow63ngCyv4Vb3EMcFgjTBrN8iKFQ9/FqfAf3HLFZdnBQ/
         eeNx+E71ScgoGbdlL4eNpiFceOeDl9TtqiHABBjAedbMJQmHIjJg70lPy078OI+3DrFI
         9FD5qe3yqqmGysSbiRufUR8QTKrzj5ouIDbpk0Yn9ztS6HXt6URBbjhv5kPlLPivTXrX
         WYng==
X-Gm-Message-State: APjAAAXiqL8fbqVFbRWNKCQqWaMKgOBKJ9KWqZPvdCHTlcQFQZz0sVGa
        KBp4lkkrqjEwFyijQUGnzm00U5jNwuo=
X-Google-Smtp-Source: APXvYqxb9K01d3+TG7ks63JaVg+hAktf2Hz+U/53HsIRu0RYyLZKlOzhu0DzA2UWt4gOEDGxB6xX5A==
X-Received: by 2002:a0c:e001:: with SMTP id j1mr3394954qvk.110.1565102345637;
        Tue, 06 Aug 2019 07:39:05 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id d71sm500507qkg.70.2019.08.06.07.39.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Aug 2019 07:39:05 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hv0cC-0005jc-Oe; Tue, 06 Aug 2019 11:39:04 -0300
Date:   Tue, 6 Aug 2019 11:39:04 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, arnd@arndb.de,
        kirill.shutemov@linux.intel.com, mhocko@suse.com,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] asm-generic: fix variable 'p4d' set but not used
Message-ID: <20190806143904.GE11627@ziepe.ca>
References: <1564774882-22926-1-git-send-email-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564774882-22926-1-git-send-email-cai@lca.pw>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 02, 2019 at 03:41:22PM -0400, Qian Cai wrote:
> GCC throws a warning on an arm64 system since the commit 9849a5697d3d
> ("arch, mm: convert all architectures to use 5level-fixup.h"),
> 
> mm/kasan/init.c: In function 'kasan_free_p4d':
> mm/kasan/init.c:344:9: warning: variable 'p4d' set but not used
> [-Wunused-but-set-variable]
>   p4d_t *p4d;
>          ^~~
> 
> because p4d_none() in "5level-fixup.h" is compiled away while it is a
> static inline function in "pgtable-nopud.h". However, if converted
> p4d_none() to a static inline there, powerpc would be unhappy as it
> reads those in assembler language in
> "arch/powerpc/include/asm/book3s/64/pgtable.h",
> 
> ./include/asm-generic/5level-fixup.h: Assembler messages:
> ./include/asm-generic/5level-fixup.h:20: Error: unrecognized opcode:
> `static'
> ./include/asm-generic/5level-fixup.h:21: Error: junk at end of line,
> first unrecognized character is `{'
> ./include/asm-generic/5level-fixup.h:22: Error: unrecognized opcode:
> `return'
> ./include/asm-generic/5level-fixup.h:23: Error: junk at end of line,
> first unrecognized character is `}'
> ./include/asm-generic/5level-fixup.h:25: Error: unrecognized opcode:
> `static'
> ./include/asm-generic/5level-fixup.h:26: Error: junk at end of line,
> first unrecognized character is `{'
> ./include/asm-generic/5level-fixup.h:27: Error: unrecognized opcode:
> `return'
> ./include/asm-generic/5level-fixup.h:28: Error: junk at end of line,
> first unrecognized character is `}'
> ./include/asm-generic/5level-fixup.h:30: Error: unrecognized opcode:
> `static'
> ./include/asm-generic/5level-fixup.h:31: Error: junk at end of line,
> first unrecognized character is `{'
> ./include/asm-generic/5level-fixup.h:32: Error: unrecognized opcode:
> `return'
> ./include/asm-generic/5level-fixup.h:33: Error: junk at end of line,
> first unrecognized character is `}'
> make[2]: *** [scripts/Makefile.build:375:
> arch/powerpc/kvm/book3s_hv_rmhandlers.o] Error 1
> 
> Fix it by reference the variable in the macro instead.
> 
> Signed-off-by: Qian Cai <cai@lca.pw>
>  include/asm-generic/5level-fixup.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/asm-generic/5level-fixup.h b/include/asm-generic/5level-fixup.h
> index bb6cb347018c..2c3e14c924b6 100644
> +++ b/include/asm-generic/5level-fixup.h
> @@ -19,7 +19,7 @@
>  
>  #define p4d_alloc(mm, pgd, address)	(pgd)
>  #define p4d_offset(pgd, start)		(pgd)
> -#define p4d_none(p4d)			0
> +#define p4d_none(p4d)			((void)p4d, 0)

Yuk, how about a static inline instead?

Jason
