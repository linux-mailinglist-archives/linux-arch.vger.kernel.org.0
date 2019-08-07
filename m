Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E077684605
	for <lists+linux-arch@lfdr.de>; Wed,  7 Aug 2019 09:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387404AbfHGHap (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Aug 2019 03:30:45 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46207 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387403AbfHGHao (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Aug 2019 03:30:44 -0400
Received: by mail-qt1-f193.google.com with SMTP id h21so87307633qtn.13;
        Wed, 07 Aug 2019 00:30:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QI/I+LIQsvc4f1HJIy3PO112y7pvO/6WR4rKXxmi7/o=;
        b=N1YTjREkwPwv3UhxzNgeVmWNtuxEvV+r/RQ7mH5W+62GF+aO1TbPdmtn19/Q7bzaaI
         917WbtdOQqgD+kazGfaTEK3JuRr+eHRlK3431yjTUvlRXFPi8H4spXE1MWSkT/U5alDF
         Sl6NEhVqzCq4MPJF4yY7Yu9qm07ziRsrC3gRoP6D8zB1C8n7buDU6r0UVdGOsiL8B1gE
         Xmzs14qUERai4nDtAF2aFfnqIZe/+ZTtgRpViGsvziQbrf4Z/oNPyCgmwKoiXpSJFO+T
         3v08ppPRcU75rHg7/EFlLRzFWr9FUJiuoLKxuCJ8lo69v2l7BnGvixo1yzwftd40JVq+
         JGnw==
X-Gm-Message-State: APjAAAWQJUTFZi4+VKecpcISK1ZCYk/uZ1o88w15aa7nDivseAXXBGcs
        oW4RdqI4BiS11OGUaOmnweUlAvPXmRTtKc/8N5zkW4Jx
X-Google-Smtp-Source: APXvYqyraFOC5I7agXnUMaIP2SQ2U9Dh7sSaovC+LdeLBhDNbzPybgOWl0piLVtNs5lFOv5CH0Q85Hq+//qGKdglhiY=
X-Received: by 2002:aed:3363:: with SMTP id u90mr6742936qtd.7.1565163043476;
 Wed, 07 Aug 2019 00:30:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190806232917.881-1-cai@lca.pw>
In-Reply-To: <20190806232917.881-1-cai@lca.pw>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 7 Aug 2019 09:30:26 +0200
Message-ID: <CAK8P3a12VZHvX+rTDYenONwjBDbBvi2cT-FaqBcTpHbX8Gz4Bg@mail.gmail.com>
Subject: Re: [PATCH v2] asm-generic: fix variable 'p4d' set but not used
To:     Qian Cai <cai@lca.pw>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Aug 7, 2019 at 1:29 AM Qian Cai <cai@lca.pw> wrote:
>
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

Acked-by: Arnd Bergmann <arnd@arndb.de>
