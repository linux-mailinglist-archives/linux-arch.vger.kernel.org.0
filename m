Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 854A5265470
	for <lists+linux-arch@lfdr.de>; Thu, 10 Sep 2020 23:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbgIJVmb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Sep 2020 17:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730514AbgIJNCs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 10 Sep 2020 09:02:48 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5388DC061799
        for <linux-arch@vger.kernel.org>; Thu, 10 Sep 2020 06:02:36 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id q63so5128179qkf.3
        for <linux-arch@vger.kernel.org>; Thu, 10 Sep 2020 06:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZMHVjl3+9TgVg2XMpsqEGzDzTL85oyvjl7Ly6KJECZs=;
        b=f2+BlMuUGxSPKYE1QP62oEt/bC0dGgrFO/pevuVdYEPal0FxZbbtojVdbZbQ6sqmoz
         jaJs9e7Yg3oQ36AJtmPt+bWSweDM603M+W0NfngEfLnlu8waQhxBgX6HgQdgQkAOsQvN
         Imc2Ip25I3geF80IGGT4DFhCwFFWUwFOfv4oqMhYXEEoXV/3te0bj60yPFJV8SXZ1nIN
         1cOGfWeoU7Qerilj2IP4cT0hDPg8C8eGeDjj8ADKqV0CudBo5FDoF28Zeb24SsNY1XCA
         ye3tKdEeX5uSb4xgr1Zl54/2+vf6Hqdh4TzuL59fwFBW+mdrXHCpM+fh1UX1VSvqoYEC
         Wv+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZMHVjl3+9TgVg2XMpsqEGzDzTL85oyvjl7Ly6KJECZs=;
        b=m7rft0B8Io0hBLPIZmI6EQlBahFeIZ5yq0LGxtxVTUI+d93aKjQitEn/Ftj59XLMd0
         NCNv9Iw62QEbk70HeyuiPv8LjbncvQ/3itiybOtLtoEi5HBeQQxfxCzopgafNhNppYRX
         Uzh9bv1w54rdbzHOT17poU56TSJ8PWovnHbDeZryCUy02pbJ1ymd1+soyLRoC5dU/DTw
         tJ0iL/hZLGEUTI5toDgNawlmeHN/z+tnWC0PSJ36vQxeAtsPBpGjvEnRG+Hc37xwKfjk
         0S7+pjOmXb9wcgVJT/LDjkEf/LJU8M+jLcf785oENMP/nmTvFB3LDEaHItvFnvDu4wmE
         D49Q==
X-Gm-Message-State: AOAM531InkN2Az5PmaMKYbcEwMvbc36CBTGmLdz2XOokITcKJPDyKmM6
        ZV4tWSyDu+paySS5dT/bslULog==
X-Google-Smtp-Source: ABdhPJxqOTcVzVF1zXXEOkRZLnf0cpg1VMvwjaF3fePKiOG08DrkmppE8sGHLJTo61W1PPeWEXyFQQ==
X-Received: by 2002:a05:620a:410:: with SMTP id 16mr7289645qkp.133.1599742955509;
        Thu, 10 Sep 2020 06:02:35 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id i1sm6457907qkd.58.2020.09.10.06.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 06:02:34 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kGMDh-004Ksi-Dp; Thu, 10 Sep 2020 10:02:33 -0300
Date:   Thu, 10 Sep 2020 10:02:33 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
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
Message-ID: <20200910130233.GK87483@ziepe.ca>
References: <20200907180058.64880-1-gerald.schaefer@linux.ibm.com>
 <20200907180058.64880-2-gerald.schaefer@linux.ibm.com>
 <0dbc6ec8-45ea-0853-4856-2bc1e661a5a5@intel.com>
 <20200909142904.00b72921@thinkpad>
 <aacad1b7-f121-44a5-f01d-385cb0f6351e@intel.com>
 <20200909192534.442f8984@thinkpad>
 <20200909180324.GI87483@ziepe.ca>
 <20200910093925.GB29166@oc3871087118.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910093925.GB29166@oc3871087118.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 10, 2020 at 11:39:25AM +0200, Alexander Gordeev wrote:

> As Gerald mentioned, it is very difficult to explain in a clear way.
> Hopefully, one could make sense ot of it.

I would say the page table API requires this invariant:

        pud = pud_offset(p4d, addr);
        do {
		WARN_ON(pud != pud_offset(p4d, addr);
                next = pud_addr_end(addr, end);
        } while (pud++, addr = next, addr != end);

ie pud++ is supposed to be a shortcut for 
  pud_offset(p4d, next)

While S390 does not follow this. Fixing addr_end brings it into
alignment by preventing pud++ from happening.

The only currently known side effect is that gup_fast crashes, but it
sure is an unexpected thing.

This suggests another fix, which is to say that pud++ is undefined and
pud_offset() must always be called, but I think that would cause worse
codegen on all other archs.

Jason

