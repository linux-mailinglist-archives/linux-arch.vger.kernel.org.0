Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1893EE342
	for <lists+linux-arch@lfdr.de>; Tue, 17 Aug 2021 03:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237142AbhHQBcu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 16 Aug 2021 21:32:50 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:32092 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236915AbhHQBa7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 16 Aug 2021 21:30:59 -0400
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 17H1Tued009715;
        Tue, 17 Aug 2021 10:29:56 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 17H1Tued009715
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1629163796;
        bh=LbGTvbOV0UxUpK/R/47BhcPmPSqBe9At3aWLdFO5P2I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ImSLMyi7XPRZ3/zJh5lP7OsuezA7KfGk8m++FBIV7SX/mzDqUAUEr5Z3Kj2BGrAtP
         5Q0/7WlQID+SA9X9T1CW9SUJTXHaC2seAbSVNnRZxyOIf8jP7Iy2HvwvYE+fn+2PA1
         8J07ixK3WZkxVkxArjNG1O3qtomhzIqR/Dbchs5m9wj7lUyITTLOl1RA8vX8vqnMwl
         xonsbR8QYtCK3UqCSNE/w2dbZlHsTW6bABT9CaFD8uYR57U8J5J8hQI4IOBdP6Rb+v
         raKrtXgKVmlt7hd+N/GRlGcu3diN9rVZC5eMMss8m3q7kGjOZ0/+r7r/lRSLbskLaJ
         QEGFcvz6diiMw==
X-Nifty-SrcIP: [209.85.216.53]
Received: by mail-pj1-f53.google.com with SMTP id hv22-20020a17090ae416b0290178c579e424so3420037pjb.3;
        Mon, 16 Aug 2021 18:29:56 -0700 (PDT)
X-Gm-Message-State: AOAM533L8ptmuvQ96No7qAAQlNKBmccvXKkyTOrUJu6VOE+VXYkGc82l
        l7ycHxlBjCLITiq9Is4jEnOUkUIDrsiM3GBjXtM=
X-Google-Smtp-Source: ABdhPJwS70th4fe/EFi8v/g7x5kHegGdJb9Pd+daqZCa0CljUdT+3Zyz8EXBAINjrFXB8Os3X43SC570wAwSltEGTks=
X-Received: by 2002:a17:90a:9314:: with SMTP id p20mr879158pjo.87.1629163795716;
 Mon, 16 Aug 2021 18:29:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210802204033.466861-1-adobriyan@gmail.com>
In-Reply-To: <20210802204033.466861-1-adobriyan@gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 17 Aug 2021 10:29:19 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR2aDQT=h47MUS9ThdGp-fGo8vqYh1KpS5hOfxiJ15E_Q@mail.gmail.com>
Message-ID: <CAK7LNAR2aDQT=h47MUS9ThdGp-fGo8vqYh1KpS5hOfxiJ15E_Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] isystem: trim/fixup stdarg.h and other headers
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 3, 2021 at 5:40 AM Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> Delete/fixup few includes in anticipation of global -isystem compile
> option removal.
>
> Note: crypto/aegis128-neon-inner.c keeps <stddef.h> due to redefinition
> of uintptr_t error (one definition comes from <stddef.h>, another from
> <linux/types.h>).
>
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>


Series, applied to linux-kbuild.

-- 
Best Regards
Masahiro Yamada
