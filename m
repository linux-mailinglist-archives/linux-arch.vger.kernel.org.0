Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B68BC30F264
	for <lists+linux-arch@lfdr.de>; Thu,  4 Feb 2021 12:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235965AbhBDLgg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Feb 2021 06:36:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235683AbhBDL2V (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Feb 2021 06:28:21 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3523EC061573;
        Thu,  4 Feb 2021 03:27:41 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id j2so1905787pgl.0;
        Thu, 04 Feb 2021 03:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=AVPcBDEqhBj+ZdkvNQJyb4mL8zPleMQDoEgdiBoAh1c=;
        b=PjGnb6/4PtgP9jRVLqMbZ0CPDZ63a9cLblye5NvYoK32KRewNNQl7O0kLpHSOu1K1U
         DbCTPaJAFWPympHAS0SX5mRDQwO0UqptBf+xpv3UHBMIFv+suoSiRPX2MYFYtsmo154Z
         APGWFeYjIRnIu75gBP8iAeJPNnrfO6tfIUp2LJbv2nLV15q6xW8gz3rQahm9vm0vnu9e
         J0jq7i3g8tY8xCbvmeTiXVNskKT7bMYs4IuTZ2EYFnR5BPn2+sXU8WEozasmLNMeA55Z
         5JugoOH2YfVHJMMBaFw2jtplCZPWdnXCk93RnGfHb3kE7wjpODIVj9D++RaFNKuc6Sr2
         FTNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=AVPcBDEqhBj+ZdkvNQJyb4mL8zPleMQDoEgdiBoAh1c=;
        b=KHT/ZBcZuM0fhAHkYO3f4BigKfMwWA7BEhjEOyQP612IjXuHY8EHidTNg15MV8JOxe
         tQ9wONE+b4bdAlvE9OpCq/iAdIFzGDPl+zIBgtSvzr5K3ZnJ2AuQ6ugdVes/KdfEouZq
         gGZxRDZEDL67BaYcXE0g/zYXY1FdF3Ph7+QCs8nC5y7RGhHN1Un6LZdSBJe4930xtefy
         wyJ4HGbtKiqtzd5EnPkc5H8CdeCJ+PGf7S1/6FyhwhyNQ/GHDr7tFF0h0XZmIStItCUi
         xCWDw7boO1LyVvTgDJpPwYnAD1/PpAooaEJYKGM2gELpu29/3FlpoJ6ib4w3MB8V/qxO
         zUZA==
X-Gm-Message-State: AOAM530m4KMQeM8efQyP7SNlqJ1NqiGYhoXpGy3qdulASG4zp0pVgSk5
        WcI4+y5HwtERngVVzq/pN/c=
X-Google-Smtp-Source: ABdhPJwlVsXEcTxuAbN8SYea8wHGiN0UVg9yeSiT3jonSYGOAxSCXe9g5u87CZ/f94De5Kycwbw2RQ==
X-Received: by 2002:a62:b410:0:b029:1a4:7868:7e4e with SMTP id h16-20020a62b4100000b02901a478687e4emr8103392pfn.62.1612438060844;
        Thu, 04 Feb 2021 03:27:40 -0800 (PST)
Received: from localhost (60-242-11-44.static.tpgi.com.au. [60.242.11.44])
        by smtp.gmail.com with ESMTPSA id x17sm488633pfq.132.2021.02.04.03.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 03:27:40 -0800 (PST)
Date:   Thu, 04 Feb 2021 21:27:34 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] MIPS: make userspace mapping young by default
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>, ambrosehua@gmail.com,
        Huacai Chen <chenhc@lemote.com>,
        Gao Juxin <gaojuxin@loongson.cn>,
        Huang Pei <huangpei@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-arch@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, Li Xuefeng <lixuefeng@loongson.cn>,
        Bibo Mao <maobibo@loongson.cn>,
        Paul Burton <paulburton@kernel.org>,
        Yang Tiezhu <yangtiezhu@loongson.cn>,
        Fuxin Zhang <zhangfx@lemote.com>
References: <20210204013942.8398-1-huangpei@loongson.cn>
        <1612409285.q4gi3x2bhk.astroid@bobo.none>
        <20210204103459.GA10558@alpha.franken.de>
In-Reply-To: <20210204103459.GA10558@alpha.franken.de>
MIME-Version: 1.0
Message-Id: <1612437994.rfmweyhtiy.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Thomas Bogendoerfer's message of February 4, 2021 8:34 pm:
> On Thu, Feb 04, 2021 at 01:29:26PM +1000, Nicholas Piggin wrote:
>> Excerpts from Huang Pei's message of February 4, 2021 11:39 am:
>> > MIPS page fault path(except huge page) takes 3 exceptions (1 TLB Miss
>> > + 2 TLB Invalid), butthe second TLB Invalid exception is just
>> > triggered by __update_tlb from do_page_fault writing tlb without
>> > _PAGE_VALID set. With this patch, user space mapping prot is made
>> > young by default (with both _PAGE_VALID and _PAGE_YOUNG set),
>> > and it only take 1 TLB Miss + 1 TLB Invalid exception
>> >=20
>> > Remove pte_sw_mkyoung without polluting MM code and make page fault
>> > delay of MIPS on par with other architecture
>> >=20
>> > Signed-off-by: Huang Pei <huangpei@loongson.cn>
>>=20
>> Could we merge this? For the core code,
>=20
> sure, but IMHO I should only merge the MIPS part, correct ?

You could ack it for MIPS and Andrew could take it through his tree=20
would avoid dependencies.

Thanks,
Nick
