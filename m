Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 987B5259DB6
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 19:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgIARzg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 13:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgIARzf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Sep 2020 13:55:35 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5237FC061244;
        Tue,  1 Sep 2020 10:55:35 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id m22so2903542eje.10;
        Tue, 01 Sep 2020 10:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gLkbCiqA9XZngBe8XklWV8DgNnzi9W/HkU22nUaTiU0=;
        b=IeqW9SyidN9PGIgoVv6wrgJX1HewRYZ3jByPsTmZwtTlT+u57KD7RoLHufJB5G/Xb4
         89ailtYOG9WQJIxjOr3eDzvcWF7VXPzVJSpFUjpxi2MKBJM/AC40TnIL+thNMehlcqtl
         RYaEYmU+/S/uB8YQgVLX0lUu0+N7/pqlH2CBPCaP4xQOxisi/FsjK2K/cZj/cSFpXr03
         ekBfJydjGf0pWo0/dHyh9G412rA4V1FBPXHn+Wb16wF+QG2oPGzGtGkIm3ohMdzdKrpk
         HuH58K43iNpnVc+DzZlFDLPUPLw70uB+kMkKMG58tvCgerQLYoBT8dsZoHcAthjM4iNA
         D91g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gLkbCiqA9XZngBe8XklWV8DgNnzi9W/HkU22nUaTiU0=;
        b=JfQjPR8hrwlC/LDlQMjQCUhcXLJotomkKtYA1Unc4XsJEoxJyAOErf+YGx8g0A5y0A
         G8SOdtlp6RxQ9k6ywu0xTKZvZmRGidu69bDlOClm7ZTTewnvI4yb71hhcUAqPQiZ174y
         qBj43nD4UC/EFeLu8Y11K2kyxSobprYj5ale9bUMFiWTi0M1uhteQoeE3c5L29cE1M6c
         vzupbYMcGBHF8E6VPwkYZZEd+K5KQX/JXkjvqkEmMAjSYi5Y0UpAcqv6AautImfu5ulj
         p1PIDbld0pG7J9Pf1+q9SB6u7KzEoKHuftSBlUIkaIaGTjfhNjWGMhCXWXV0hTlsX8qc
         nt7g==
X-Gm-Message-State: AOAM533k+1/TuBZQQYIMvNIxji1UsoXLVPwduPthDFuZDZmkkbLYew22
        jSQlERzvP2c0RA3gBJ32g9TPHlYMEJWs8f1Ad8adLHItXJg=
X-Google-Smtp-Source: ABdhPJxTpsiS7Vd02sSXMWqlz5hGzG68IcsXhf5FTDWokmy6rP+D38c2bMAT+YMUQyxDr+hpkujkpd6oOdmWovKCbFQ=
X-Received: by 2002:a17:907:94c3:: with SMTP id dn3mr2553847ejc.186.1598982933931;
 Tue, 01 Sep 2020 10:55:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200901141539.1757549-1-npiggin@gmail.com> <20200901141539.1757549-24-npiggin@gmail.com>
In-Reply-To: <20200901141539.1757549-24-npiggin@gmail.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Tue, 1 Sep 2020 10:55:22 -0700
Message-ID: <CAMo8BfJAnJsWB-OpZxSMzNF0+3eiVzXChTNrJP10j3XaGUwX7g@mail.gmail.com>
Subject: Re: [PATCH v3 23/23] xtensa: use asm-generic/mmu_context.h for no-op implementations
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Linux-Arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Arnd Bergmann <arnd@arndb.de>, Chris Zankel <chris@zankel.net>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 1, 2020 at 7:17 AM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: linux-xtensa@linux-xtensa.org
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>
> Please ack or nack if you object to this being mered via
> Arnd's tree.
>
>  arch/xtensa/include/asm/mmu_context.h   | 11 +++--------
>  arch/xtensa/include/asm/nommu_context.h | 26 +------------------------
>  2 files changed, 4 insertions(+), 33 deletions(-)

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
