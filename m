Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2246A82FEB
	for <lists+linux-arch@lfdr.de>; Tue,  6 Aug 2019 12:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfHFKpT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Aug 2019 06:45:19 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45908 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730068AbfHFKpT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Aug 2019 06:45:19 -0400
Received: by mail-ed1-f68.google.com with SMTP id x19so75941568eda.12
        for <linux-arch@vger.kernel.org>; Tue, 06 Aug 2019 03:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mLxh1xnnQMfeNrHf0aYqKYeviGu5yN55vYMo0/wqLZk=;
        b=dCNqxHY8plIDmYXpsy08QCX+iLvxPKZniVm+ncSZ3Buz54doFAW+0MiXkxSfa6aZ8N
         jTXJVTUqheLEyn7aW+R/fuDvBVdUs6Xh1fwu7j26vjbyzEwKEDlhCUidQu4KmRqzZOVa
         oDhQ+hqdK6ua5BH0xjQgzzSY2YytIfxpQZbUbhHRfBt+5myVtlvcOTS0tg2Us6YrayDX
         spYFcJQpsTWAHLAWlWQ4c+a7j4DzTav2yKnrSBmM6urDLun3EPrbW9LTSp94TCS/Nqy6
         yUFovGgvKMukOtEtX/dZWO89MRVjVrn4dfNeI+KJg31PeTSFYAKqz3WMNOK0C1qeIyJD
         lgzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mLxh1xnnQMfeNrHf0aYqKYeviGu5yN55vYMo0/wqLZk=;
        b=rTR91j5sB7Qtv4oGNcd0Q6VettRO6v8QjS+6RcN+QQopJQYgBJnOoenmyIHotKsT1g
         H615eKv8OHZkn27189QbWG42ofbKlud7T2x3weMNGNGWuVeWU6Hl1jhqnP71+VOMF3aK
         W5EoH4B0w9klhtaKYNanNbsMxUj2FkWwbvvyMZTtKdCJoxOx2xWnl8U5VOu+H8CmywZS
         WORfSp2wD3h1o1igh9n7D3tyOfhu8QdJ4gJaX5tPrMwMdSM+XmomTs2KIfd9Zz9bvdgJ
         Nv/8evFItaF/K1/abJQYXj2ECxPMFf5BF0ydA9RwWDx1dtnCVDZ7Btgbk9F2ZYmyDuL+
         dVpw==
X-Gm-Message-State: APjAAAWaELYbxqnC1O6w6N/HUI7NrC8pPVlxat0pt6X4+cw43NikuxRY
        k1nQZ382X6iCQZGA+tGh82iQVPchgIo=
X-Google-Smtp-Source: APXvYqz/KhBA+ZSNGOJbjZoeKD/ak+4bM/swWsBeb0rTxPioOaajmtlsxRIAU93xegZHr6XtYLs1kQ==
X-Received: by 2002:a17:906:340e:: with SMTP id c14mr2544571ejb.170.1565088317410;
        Tue, 06 Aug 2019 03:45:17 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id e43sm20620511ede.62.2019.08.06.03.45.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 03:45:16 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 3AED71003C7; Tue,  6 Aug 2019 13:45:16 +0300 (+03)
Date:   Tue, 6 Aug 2019 13:45:16 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, arnd@arndb.de,
        kirill.shutemov@linux.intel.com, mhocko@suse.com,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] asm-generic: fix variable 'p4d' set but not used
Message-ID: <20190806104516.yvioe2t4w2vwvs64@box>
References: <1564774882-22926-1-git-send-email-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564774882-22926-1-git-send-email-cai@lca.pw>
User-Agent: NeoMutt/20180716
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

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
