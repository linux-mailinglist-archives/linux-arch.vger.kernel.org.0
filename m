Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71AB2231FAE
	for <lists+linux-arch@lfdr.de>; Wed, 29 Jul 2020 15:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbgG2N6L (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Jul 2020 09:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbgG2N6L (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 Jul 2020 09:58:11 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18621C061794;
        Wed, 29 Jul 2020 06:58:11 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BGw9R42qNz9sRK;
        Wed, 29 Jul 2020 23:58:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1596031086;
        bh=iCz1t7QjZhj1s06NIVe6p/+LDk6tF+hvH/R0XWOWihY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=NOYwP+Xwm2xRt/wdUMLdjnreWGQuVR2HLP9GYYaws7DdhEf/xdd6IOx8OZmoGV+87
         TAi3LhkapSggo3lWSKcdyFuVT2VcVJFkpvi4yOKsaC6MYBfNETo1/KMegbqGloXCh9
         DkukUy8t8mIwQNz8orbKMrS4pjay/hzUpmPiU6gu9YzHaXhLfqHr6ofdHHYQ+D9eX7
         GK0c6BO31b5V47d+FBIkRiRQMUjlvGG3T28tSbzbA1z3LQVTNetHuZnoXA9IppCIbf
         Dh0BOKJMQRZW0C0KR8tEfEYVnEPX+8xK9H+JC30SjyEw+7tjN1GPc1npncUMBY1zQe
         Qni+7ToQjeuqg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Nicholas Piggin <npiggin@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Hillf Danton <hdanton@sina.com>, mm-commits@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Hugh Dickins <hughd@google.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux-MM <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yu Xu <xuyu@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [patch 01/15] mm/memory.c: avoid access flag update TLB flush for retried page fault
In-Reply-To: <1595974242.esf9644sf3.astroid@bobo.none>
References: <20200723211432.b31831a0df3bc2cbdae31b40@linux-foundation.org> <20200724041508.QlTbrHnfh%akpm@linux-foundation.org> <CAHk-=wguPA=pDskR-eMMjwR5LDEaMXrqbmDbrKr0u=wV1LE4rg@mail.gmail.com> <CAHk-=wh4kmU5FdT=Yy7N9wA=se=ALbrquCrOkjCMhiQnOBLvDA@mail.gmail.com> <0323de82-cfbd-8506-fa9c-a702703dd654@linux.alibaba.com> <20200727110512.GB25400@gaia> <39560818-463f-da3a-fc9e-3a4a0a082f61@linux.alibaba.com> <eb1f5cb4-7c3d-df42-f4aa-804e12df45e2@linux.alibaba.com> <CAHk-=wha6f0gF1SJg96R77h0oTuc_oO7-37wD=mYGy6TyJOwbQ@mail.gmail.com> <1595932767.wga6c4yy6a.astroid@bobo.none> <CAHk-=wgrgRqeEo-YUgec7yQNkN+_+sHBP-NtCnfktCFEuPHTDQ@mail.gmail.com> <1595974242.esf9644sf3.astroid@bobo.none>
Date:   Wed, 29 Jul 2020 23:58:02 +1000
Message-ID: <87o8ny5sph.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Nicholas Piggin <npiggin@gmail.com> writes:
> Excerpts from Linus Torvalds's message of July 29, 2020 5:02 am:
>> On Tue, Jul 28, 2020 at 3:53 AM Nicholas Piggin <npiggin@gmail.com> wrote:
>>>
>>> The quirk is a problem with coprocessor where it's supposed to
>>> invalidate the translation after a fault but it doesn't, so we can get a
>>> read-only TLB stuck after something else does a RO->RW upgrade on the
>>> TLB. Something like that IIRC.  Coprocessors have their own MMU which
>>> lives in the nest not the core, so you need a global TLB flush to
>>> invalidate that thing.
>> 
>> So I assumed, but it does seem confused.
>> 
>> Why? Because if there are stale translations on the co-processor,
>> there's no guarantee that one of the CPU's will have them and take a
>> fault.
>> 
>> So I'm not seeing why a core CPU doing spurious TLB invalidation would
>> follow from "stale TLB in the Nest".
>
> If the nest MMU access faults, it sends an interrupt to the CPU and
> the driver tries to handle the page fault for it (I think that's how
> it works).

Yeah AFAIK. I think they all end up calling copro_handle_mm_fault().

Except for NX/vas, where the model is a fault just causes the request to
be dropped and sent back to userspace to fix things up.

cheers
