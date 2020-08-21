Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3617424E392
	for <lists+linux-arch@lfdr.de>; Sat, 22 Aug 2020 00:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgHUWp7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Aug 2020 18:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbgHUWp4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Aug 2020 18:45:56 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369B9C061573;
        Fri, 21 Aug 2020 15:45:56 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id p37so1673064pgl.3;
        Fri, 21 Aug 2020 15:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=XRteHtv7uQmPq//ewuwrb7IZate8ro17vyeajkupG2I=;
        b=Aaem4Vn0bTEhViBFnc9tNsPPZfZuxBSub2f1nuc4MmLrKJfehNNHC9FP58+Q99TpoJ
         CpyvdmR758FAbXUk+bZELWHzl0ZBJJHNrJ0o1OiFr5aEhnPiK7JAYnBYHuFlc87PBxMw
         5CkKUufHHUze0EbfKk5GkR4Sze0bxy10EoqSvehwLcZJivmtaCviba+jHzYG29+4F1hR
         kqoGu7zsi8jiLTa8Ca1bap7yXXxhgWrpwIC4iek8D8rNgLuKpNWAQMCj6+Sri3WvOUGr
         ZpkrJVq6T11xVJA0tVsLBKFfIsFV+B/n1jrQ+SlwybFHe3e4OAiIp0iV880jRDPNyHar
         P9TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=XRteHtv7uQmPq//ewuwrb7IZate8ro17vyeajkupG2I=;
        b=DQJtBnpPI1P48Ull4NmznaQCNZy5Sceb6xS3F/vh8Mj9sszRpt2VFH2Fjyqv6p4bQK
         6XyY26ak/ZHlBZd9FpRI8hgbQW4YxjVsgDeyrRU6LWQIX9GgNeMk8KYP2EDNFV0puVBZ
         ebeahouDgP2fgkdsDldX8n8/mQ4WfTOSlblJBuh+v42xCL9LYaYmCNqP6YNyJkwbrjXd
         +xjZX5S/we3jKAzlL63U9RbCNIdZUaZQqOalaoL2A2zY25ZmXXqfsgS8kI0/XRAYY6m8
         Eyu4As643Sew5ZMVsJmfbmoXzBK5psevRGH7MLyoGTasEEZuNC6hj1zlry9NNraegb2y
         yyyw==
X-Gm-Message-State: AOAM5339Djuz4WEDVLDoRjgcRkuiIkvwc4zGyFz9eSSV2H+20nxA0ITl
        PxBI/EJypUbOaJeIY1L7Na0=
X-Google-Smtp-Source: ABdhPJy7krGSqdemncjBBCsDGsMdylWo6zM9qjg4SD8PzW/+V58PKpTZD+S3JHXtmZJ0AJ7MWzK3TQ==
X-Received: by 2002:a62:7acb:: with SMTP id v194mr4142526pfc.302.1598049954288;
        Fri, 21 Aug 2020 15:45:54 -0700 (PDT)
Received: from localhost (61-68-212-105.tpgi.com.au. [61.68.212.105])
        by smtp.gmail.com with ESMTPSA id w130sm3564073pfd.104.2020.08.21.15.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 15:45:53 -0700 (PDT)
Date:   Sat, 22 Aug 2020 08:45:48 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v6 05/12] mm: HUGE_VMAP arch support cleanup
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     =?iso-8859-1?q?Borislav=0A?= Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Christoph Hellwig <hch@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, Zefan Li <lizefan@huawei.com>,
        Ingo Molnar <mingo@redhat.com>,
        =?iso-8859-1?q?Thomas=0A?= Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, x86@kernel.org
References: <20200821151216.1005117-1-npiggin@gmail.com>
        <20200821151216.1005117-6-npiggin@gmail.com>
        <20200821131422.110abb1a0c0b6a9d378b0e48@linux-foundation.org>
In-Reply-To: <20200821131422.110abb1a0c0b6a9d378b0e48@linux-foundation.org>
MIME-Version: 1.0
Message-Id: <1598049779.exwra3cjwe.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Andrew Morton's message of August 22, 2020 6:14 am:
> On Sat, 22 Aug 2020 01:12:09 +1000 Nicholas Piggin <npiggin@gmail.com> wr=
ote:
>=20
>> This changes the awkward approach where architectures provide init
>> functions to determine which levels they can provide large mappings for,
>> to one where the arch is queried for each call.
>>=20
>> This removes code and indirection, and allows constant-folding of dead
>> code for unsupported levels.
>>=20
>> This also adds a prot argument to the arch query. This is unused
>> currently but could help with some architectures (e.g., some powerpc
>> processors can't map uncacheable memory with large pages).
>>=20
>> --- a/arch/arm64/include/asm/vmalloc.h
>> +++ b/arch/arm64/include/asm/vmalloc.h
>> @@ -1,4 +1,12 @@
>>  #ifndef _ASM_ARM64_VMALLOC_H
>>  #define _ASM_ARM64_VMALLOC_H
>> =20
>> +#include <asm/page.h>
>> +
>> +#ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
>> +bool arch_vmap_p4d_supported(pgprot_t prot);
>> +bool arch_vmap_pud_supported(pgprot_t prot);
>> +bool arch_vmap_pmd_supported(pgprot_t prot);
>> +#endif
>=20
> Moving these out of generic code and into multiple arch headers is
> unfortunate.  Can we leave them in include/linux/somewhere?  And remove
> the ifdefs, if so inclined - they just move the build error from
> link-time to compile-time, and such an error shouldn't occur!

Yeah this was just an intermediate step as you saw. It's a bit=20
unfortunate, but I thought it made the arch changes clearer.

Thanks,
Nick

