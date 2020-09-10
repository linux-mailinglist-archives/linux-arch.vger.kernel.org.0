Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83BD7265571
	for <lists+linux-arch@lfdr.de>; Fri, 11 Sep 2020 01:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725536AbgIJXVN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Sep 2020 19:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgIJXVK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Sep 2020 19:21:10 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E05C061756
        for <linux-arch@vger.kernel.org>; Thu, 10 Sep 2020 16:21:09 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id ef16so4237585qvb.8
        for <linux-arch@vger.kernel.org>; Thu, 10 Sep 2020 16:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fIHL0Rq33O5ozDdBNb92cfl0GBqGdNKvR/YdlpxGcAc=;
        b=ek3aEVh6EDZv0MY4CyKrIOtcGg9hcQrcK0LNTKZQKq5D36Q4OOful56d1fLsdvbySj
         gIxGsvrf3KCS0cBe2Cddj6sjM6xxgr+gzrdl7qNDkNuApsUa7CiM5w7gHpJiiyXmHOM7
         z0Fmkdon1hMn3l1idV0bhKgpCa6PUJSq4CW7y6g23Ml8DO+r/mDIQI9+zVDERUCtr5L5
         WJuVfXkINtgWDQegahH+XHGH+cQJScV2EOHwfsx92Xl2/qRCRlsZDeCmHgB5ogwUgrhe
         yUNj2pRXsNm4WiFcUh2LoLVRUAZ5EBB0j8EQP9F4uwiM1oP8TqSobCs8onyBplaZNq9X
         j4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fIHL0Rq33O5ozDdBNb92cfl0GBqGdNKvR/YdlpxGcAc=;
        b=YUi49sVAVCzLXwgPaRco52M91KUTfhtZNvEQRheUbDphukun02bPkbto2qjsEb7zrR
         iRPEgh2lcDZHOH/GmS9NzLuK6LFiLJ0+LjKI3V0YsFQuKS56h9YL+O4VApJQA/qsahHd
         6/rnrn569oiprlSLxwkovHgpR0E+Lbx9htGf7lCHyUlA0X706iRS9lR+4DTCh8G7ZqTl
         IvG94Vtfx8WXLC/t1n4BHcaLEIM03M3M5jv0IezniBxCyEBFLO4DupFTCkJ5qFUmDBt6
         E2mXls/Xd9ulXk3puensCN8+0eYh4QmtOB3oKS6E8pbvW6kQY0yv8ALdGdMqntv0W2JK
         hUkw==
X-Gm-Message-State: AOAM5308yS12/xcONvWwD7+LSCB+BC/MNfpnOik47sZLNQoppqRFOZvR
        U7TErCvBCGSDVREhfOkU5GuPQA==
X-Google-Smtp-Source: ABdhPJwWb13ftCj9Nx7W+uTucDyXl8x3WeSQXroWv7fkEgHTFAhsxe/mYAzhjXYKGK+4OJt2xnAqTg==
X-Received: by 2002:a05:6214:954:: with SMTP id dn20mr10867015qvb.122.1599780068776;
        Thu, 10 Sep 2020 16:21:08 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id m36sm289969qtd.10.2020.09.10.16.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 16:21:07 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kGVsI-004SPL-RD; Thu, 10 Sep 2020 20:21:06 -0300
Date:   Thu, 10 Sep 2020 20:21:06 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Russell King <linux@armlinux.org.uk>,
        Mike Rapoport <rppt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        linux-x86 <x86@kernel.org>,
        linux-arm <linux-arm-kernel@lists.infradead.org>,
        linux-power <linuxppc-dev@lists.ozlabs.org>,
        linux-sparc <sparclinux@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [RFC PATCH v2 1/3] mm/gup: fix gup_fast with dynamic page table
 folding
Message-ID: <20200910232106.GR87483@ziepe.ca>
References: <20200907180058.64880-1-gerald.schaefer@linux.ibm.com>
 <20200907180058.64880-2-gerald.schaefer@linux.ibm.com>
 <0dbc6ec8-45ea-0853-4856-2bc1e661a5a5@intel.com>
 <20200909142904.00b72921@thinkpad>
 <aacad1b7-f121-44a5-f01d-385cb0f6351e@intel.com>
 <20200909192534.442f8984@thinkpad>
 <20200909180324.GI87483@ziepe.ca>
 <20200910093925.GB29166@oc3871087118.ibm.com>
 <20200910130233.GK87483@ziepe.ca>
 <20200910195749.795232d1@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910195749.795232d1@thinkpad>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 10, 2020 at 07:57:49PM +0200, Gerald Schaefer wrote:
> On Thu, 10 Sep 2020 10:02:33 -0300
> Jason Gunthorpe <jgg@ziepe.ca> wrote:
> 
> > On Thu, Sep 10, 2020 at 11:39:25AM +0200, Alexander Gordeev wrote:
> > 
> > > As Gerald mentioned, it is very difficult to explain in a clear way.
> > > Hopefully, one could make sense ot of it.
> > 
> > I would say the page table API requires this invariant:
> > 
> >         pud = pud_offset(p4d, addr);
> >         do {
> > 		WARN_ON(pud != pud_offset(p4d, addr);
> >                 next = pud_addr_end(addr, end);
> >         } while (pud++, addr = next, addr != end);
> > 
> > ie pud++ is supposed to be a shortcut for 
> >   pud_offset(p4d, next)
> > 
> 
> Hmm, IIUC, all architectures with static folding will simply return
> the passed-in p4d pointer for pud_offset(p4d, addr), for 3-level
> pagetables.

It is probably moot now, but since other arch's don't crash they also
return pud_addr_end() == end so the loop only does one iteration.

ie pud == pud_offset(p4d, addr) for all iterations as the pud++ never
happens.

Which is what this addr_end patch does for s390..

Jason
