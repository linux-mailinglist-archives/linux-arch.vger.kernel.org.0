Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 688D11FD198
	for <lists+linux-arch@lfdr.de>; Wed, 17 Jun 2020 18:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbgFQQK4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 Jun 2020 12:10:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55657 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726329AbgFQQK4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 Jun 2020 12:10:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592410254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pwPndLdm35gmxUTd/yGdLqQ8FsjkAPP7/6FDJCdV2mM=;
        b=FIlQShFUpHaVXIsePnoHC1W1OkcqaZqCtukZ4mqpuf7wwU4hEHqFZaneFC4Hr8zS0aOvXq
        28aAw31xUOtmFiOT1i39WZznxjCXAs5hqoZw2OHmljcrSEGvOuX6DAQ+QDXUtrv4lOP8J2
        Ss5p50Cfhoc1G9Ci4HohIrTKsh8ynoo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-Da5MlrpWOdWb721-iuZEUw-1; Wed, 17 Jun 2020 12:10:52 -0400
X-MC-Unique: Da5MlrpWOdWb721-iuZEUw-1
Received: by mail-qk1-f197.google.com with SMTP id v197so2179434qkb.16
        for <linux-arch@vger.kernel.org>; Wed, 17 Jun 2020 09:10:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pwPndLdm35gmxUTd/yGdLqQ8FsjkAPP7/6FDJCdV2mM=;
        b=ffmM5MJ1JWJ7XMMmhonTLJ0OWCYkv9eZH/9nJ61otitFJEx6dMVnAbq/WaNumfJFA6
         FPxxXKIVaO6rcrDEfiYDQwTms8xWdfiw3npCJMASCOerTnv+zSVpsdnyyp0rNZow/ra7
         Ftr5YFwn4ZTV6oh0BzSjNhcYDGZoiG8RTcXnhMpjD5BGXa5Fao1uSIqvg9VMjnIP7+cU
         /MsYPgZ0qje09iaWh+81Mn4aDjzXc/z4dYAjfO9MztfEPFsP734xui3VBRyjhcX3IsbT
         05aAJqhVcy8B1EPVEd0pc4Oc2LnSClJ9hrbSyId3jmfprRkLgeR58954Ax4YkXd1Nq/1
         ZABQ==
X-Gm-Message-State: AOAM530x0HTM2BgUMlu6I+BjFVUohv/jvSe2HXzyHQjnGeBOb6wMf+a4
        8uQtCPC9+3bxwp1AqqYBqwGM2m/P0iXNWac6JfcoYp+aUsbwMtJhL0SDiuT1aIg6NtzqVROVzk0
        KFTF949B+HPWhf152bEf4Sg==
X-Received: by 2002:ac8:fb4:: with SMTP id b49mr27502906qtk.323.1592410252034;
        Wed, 17 Jun 2020 09:10:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxHPvRTdazh3ByXAbV1+DQb3IK/Hxo+xAXMp5hAEJHzAOp6L2Jx/mkBgpOD51Mg4XUcXd/11g==
X-Received: by 2002:ac8:fb4:: with SMTP id b49mr27502878qtk.323.1592410251778;
        Wed, 17 Jun 2020 09:10:51 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id b4sm265252qka.133.2020.06.17.09.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 09:10:51 -0700 (PDT)
Date:   Wed, 17 Jun 2020 12:10:49 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Will Deacon <will@kernel.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        openrisc@lists.librecores.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 00/25] mm: Page fault accounting cleanups
Message-ID: <20200617161049.GE76766@xz-x1>
References: <20200615221607.7764-1-peterx@redhat.com>
 <CAHk-=wiTjaXHu+uxMi0xCZQOm4KVr0MucECAK=Zm4p4YZZ1XEg@mail.gmail.com>
 <87imfqecjx.fsf@mpe.ellerman.id.au>
 <20200617080405.GA3208@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200617080405.GA3208@willie-the-truck>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 17, 2020 at 09:04:06AM +0100, Will Deacon wrote:
> On Wed, Jun 17, 2020 at 10:55:14AM +1000, Michael Ellerman wrote:
> > Linus Torvalds <torvalds@linux-foundation.org> writes:
> > > On Mon, Jun 15, 2020 at 3:16 PM Peter Xu <peterx@redhat.com> wrote:
> > >> This series tries to address all of them by introducing mm_fault_accounting()
> > >> first, so that we move all the page fault accounting into the common code base,
> > >> then call it properly from arch pf handlers just like handle_mm_fault().
> > >
> > > Hmm.
> > >
> > > So having looked at this a bit more, I'd actually like to go even
> > > further, and just get rid of the per-architecture code _entirely_.
> > 
> > <snip>
> > 
> > > One detail worth noting: I do wonder if we should put the
> > >
> > >     perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, addr);
> > >
> > > just in the arch code at the top of the fault handling, and consider
> > > it entirely unrelated to the major/minor fault handling. The
> > > major/minor faults fundamnetally are about successes. But the plain
> > > PERF_COUNT_SW_PAGE_FAULTS could be about things that fail, including
> > > things that never even get to this point at all.
> > 
> > Yeah I think we should keep it in the arch code at roughly the top.
> 
> I agree. It's a nice idea to consolidate the code, but I don't see that
> it's really possible for PERF_COUNT_SW_PAGE_FAULTS without significantly
> changing the semantics (and a potentially less useful way. Of course,
> moving more of do_page_fault() out of the arch code would be great, but
> that's a much bigger effort.
> 
> > If it's moved to the end you could have a process spinning taking bad
> > page faults (and fixing them up), and see no sign of it from the perf
> > page fault counters.
> 
> The current arm64 behaviour is that we record PERF_COUNT_SW_PAGE_FAULTS
> if _all_ of the following are true:
> 
>   1. The fault isn't handled by kprobes
>   2. The pagefault handler is enabled
>   3. We have an mm (current->mm)
>   4. The fault isn't an unexpected kernel fault on a user address (we oops
>      and kill the task in this case)
> 
> Which loosely corresponds to "we took a fault on a user address that it
> looks like we can handle".
> 
> That said, I'm happy to tweak this if it brings us into line with other
> architectures.

I see.  I'll keep the semantics for PERF_COUNT_SW_PAGE_FAULTS in the next
version.  Thanks for all the comments!

-- 
Peter Xu

