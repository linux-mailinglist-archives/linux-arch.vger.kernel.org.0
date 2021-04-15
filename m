Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23A6E36163E
	for <lists+linux-arch@lfdr.de>; Fri, 16 Apr 2021 01:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237843AbhDOX3v (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Apr 2021 19:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236754AbhDOX3u (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Apr 2021 19:29:50 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E513C061756
        for <linux-arch@vger.kernel.org>; Thu, 15 Apr 2021 16:29:24 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id e2so8665936plh.8
        for <linux-arch@vger.kernel.org>; Thu, 15 Apr 2021 16:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=jw2PSbrXAEN39rMTtQwepRsUrzSF/PJDp6qJKD1maOQ=;
        b=Fni1JOOo4PrUzlzK7TjMF4v5KQ8JMEB8GQFvJdoCIs85gQ7hkEMknpG3xaXPhS80Fg
         xJbRmZBxuaLCaLsDL4AVpD5/12galNW2GkHBhD13nBI/qZ+kzKtFLFCZKRtePFqUO/Re
         Zz++4+ACyGOOamm7Y7acj4xF6H4JSsTKL7jUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=jw2PSbrXAEN39rMTtQwepRsUrzSF/PJDp6qJKD1maOQ=;
        b=ArjlXQ2XyP0yytzomxiEYmY614I69vCZlxSvsx2/Q6Y+NtcymSjBQ1SoSoquEemwyG
         SSY79VM33LUcu7IgDF+YB7fbsrh2ESt7LJMMnbjysW5SjNGvD24vM4LElOnil6xc8rMJ
         +0vc4/amivGLfKkOVVnuqDOCjF6JL020seZz4+Q3mOuBEfCxxxDW9hBr5KeVGszkGEEg
         m3sdLfOSizhdUFrrceO3uhDQ9od7hajwdRBSosjC4AN3eSi8TELxXXZJm35eteFs8ALM
         dkX0kZopwlz7TTUoNrUgnfwDYWhL5hR+pbpUt+SvgrK/ihQEn9FlZlhNP7ngDZiTSaM5
         jYWw==
X-Gm-Message-State: AOAM530tmIoNScpBMpcz0A8ivl4BpyI2SYRp86/nJqrKJgGchGvY3Eq3
        MbvWIFgEB+P13J8c3iV6e3zI3w==
X-Google-Smtp-Source: ABdhPJxSv6iVBSeJJdGrfMFvazb0EusrLGidlTGj83XpU/NnbzX7T+WOwAI5+RKJlavNfX48j0XS8Q==
X-Received: by 2002:a17:90a:6c88:: with SMTP id y8mr6713418pjj.38.1618529364161;
        Thu, 15 Apr 2021 16:29:24 -0700 (PDT)
Received: from localhost (2001-44b8-111e-5c00-3f8b-a64e-9a27-b872.static.ipv6.internode.on.net. [2001:44b8:111e:5c00:3f8b:a64e:9a27:b872])
        by smtp.gmail.com with ESMTPSA id nv7sm3342006pjb.18.2021.04.15.16.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 16:29:23 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Steven Price <steven.price@arm.com>, akpm@linux-foundation.org
Cc:     linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 4/5] mm: ptdump: Support hugepd table entries
In-Reply-To: <f41a177a0fd5a71db616e586a9ec5c51102c6656.1618506910.git.christophe.leroy@csgroup.eu>
References: <cover.1618506910.git.christophe.leroy@csgroup.eu> <f41a177a0fd5a71db616e586a9ec5c51102c6656.1618506910.git.christophe.leroy@csgroup.eu>
Date:   Fri, 16 Apr 2021 09:29:20 +1000
Message-ID: <87zgxzyvn3.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Christophe,

> Which hugepd, page table entries can be at any level
> and can be of any size.
>
> Add support for them.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  mm/ptdump.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/mm/ptdump.c b/mm/ptdump.c
> index 61cd16afb1c8..6efdb8c15a7d 100644
> --- a/mm/ptdump.c
> +++ b/mm/ptdump.c
> @@ -112,11 +112,24 @@ static int ptdump_pte_entry(pte_t *pte, unsigned long addr,
>  {
>  	struct ptdump_state *st = walk->private;
>  	pte_t val = ptep_get(pte);
> +	unsigned long page_size = next - addr;
> +	int level;
> +
> +	if (page_size >= PGDIR_SIZE)
> +		level = 0;
> +	else if (page_size >= P4D_SIZE)
> +		level = 1;
> +	else if (page_size >= PUD_SIZE)
> +		level = 2;
> +	else if (page_size >= PMD_SIZE)
> +		level = 3;
> +	else
> +		level = 4;
>  
>  	if (st->effective_prot)
> -		st->effective_prot(st, 4, pte_val(val));
> +		st->effective_prot(st, level, pte_val(val));
>  
> -	st->note_page(st, addr, 4, pte_val(val), PAGE_SIZE);
> +	st->note_page(st, addr, level, pte_val(val), page_size);

It seems to me that passing both level and page_size is a bit redundant,
but I guess it does reduce the impact on each arch's code?

Kind regards,
Daniel

>  
>  	return 0;
>  }
> -- 
> 2.25.0
