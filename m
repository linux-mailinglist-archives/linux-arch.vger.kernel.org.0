Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0FD266957
	for <lists+linux-arch@lfdr.de>; Fri, 11 Sep 2020 22:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725847AbgIKUFR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Sep 2020 16:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgIKUFO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Sep 2020 16:05:14 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D3AC061786
        for <linux-arch@vger.kernel.org>; Fri, 11 Sep 2020 13:05:14 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id x2so10145583ilm.0
        for <linux-arch@vger.kernel.org>; Fri, 11 Sep 2020 13:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lkQcTqH4VEZ3iEgT/GD9JP5N85keOg351zxTDmOcIaI=;
        b=I9voHxb8dJ7Hpr77FARBSPzOQ+MPVMwPkwF0luH+LKCeQ2lgpDwGcralZQ0FGAYrwc
         BVvqLhsKXRb6YcR4pkKP2c34FkKNgqX6pj64qFDH7oE4338e+VgL2+G3FMKW2FPuHDYW
         MOKS2lLDde3qke8PUPdIqAr1Lc/lVhX7oeWxLzC+beM8ycXu9dGfsOKsCsNwUr3jtzLk
         5mkQWm2rxczvKT5Nvh/ZTiFFTOW6UPc+/aWP2W0F+b+rADWmR1dpfaY8WBd7QI32TkZL
         3etlwSquQXvam+E6vRIK7GF1RHnaGGDJvV4v5yGgCZRyA8h08sygo6M84bfQ7xFbLqxr
         cOXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lkQcTqH4VEZ3iEgT/GD9JP5N85keOg351zxTDmOcIaI=;
        b=su6agv//v0qMiSMsf7jvqWjuy957SIiiY9q9KR1xLHCy0YszUsfSlULv8Fi7UBXADI
         57IZZHNpEXHR0yOcNIChk85ovtEow/WBr3S1/I8Dxs0ZlkcYjlrxlWkrxQHux7vS8kud
         9EXZ7LlSuAiUhmuLcWsmtm0kKCpNk/CV97u7fpGIcmqSO2KMQoq8oudKA8qsxgtQareJ
         ok1320wFa6XG8mcEI6REn3ufR0RtrAuv8fSIt9KOqqVSB0dXfR7IMBJ6z2GLTaw0rWbl
         Y3VrGmjLIrYZaHU2XaSklaK/BEXwajN9a4zUjoppnDon+xI+etYljBWxYz8mKUP60Ne+
         dG7A==
X-Gm-Message-State: AOAM53137UFKZmM4W7qBDLmRcDMN1gBTTxEkKgwcToyqx496VkRnGamt
        bdoAmijwn/yG+UwK4xAOlJVdpQ==
X-Google-Smtp-Source: ABdhPJwYA/rzSMaXI+K0i70ikIv3tpbBn8J3glPlyteqvWFcMv0jpWCYFK3IcfJC1YHXSV5pVRNS1g==
X-Received: by 2002:a92:c791:: with SMTP id c17mr3247679ilk.107.1599854713521;
        Fri, 11 Sep 2020 13:05:13 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id j62sm1648212iof.53.2020.09.11.13.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 13:05:12 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kGpIF-005AGU-JV; Fri, 11 Sep 2020 17:05:11 -0300
Date:   Fri, 11 Sep 2020 17:05:11 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [PATCH] mm/gup: fix gup_fast with dynamic page table folding
Message-ID: <20200911200511.GC1221970@ziepe.ca>
References: <20200911070939.GB1362448@hirez.programming.kicks-ass.net>
 <patch.git-2c4880212370.your-ad-here.call-01599849957-ext-4686@work.hours>
 <20200911194000.GB1221970@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200911194000.GB1221970@ziepe.ca>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 11, 2020 at 04:40:00PM -0300, Jason Gunthorpe wrote:
> These would probably be better as static inlines though, as only s390
> compiles will type check pudp like this.

Never mind, it must be a macro - still need brackets though

Jason
