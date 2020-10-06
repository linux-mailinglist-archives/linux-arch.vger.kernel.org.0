Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B899285187
	for <lists+linux-arch@lfdr.de>; Tue,  6 Oct 2020 20:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbgJFSVR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Oct 2020 14:21:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33262 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726766AbgJFSVO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Oct 2020 14:21:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602008472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vLEPMopDgwBeHhoD6xTsXdWXnyecjzlObkKeapKxZb8=;
        b=eHiaDzJaVsMiz82SCK6dcdxPawvH54nFGwmFXNaMANM0DCWJxc6WqFVuZLTrqTmr3WT3Hx
        Txv7rs9e01U19hh1R1r5ZIE6zM1lxZ652Bi6pDVc/oATeXNxqI0UewP6EhGFxsDlN4lkpu
        a8nkGzh12N0ksjo4HShRJtNtyjRpouc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-461-alcayjT3P7G1iHsDj3bAkg-1; Tue, 06 Oct 2020 14:21:08 -0400
X-MC-Unique: alcayjT3P7G1iHsDj3bAkg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 777FF64088;
        Tue,  6 Oct 2020 18:21:05 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-113-154.ams2.redhat.com [10.36.113.154])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E2F4F60BFA;
        Tue,  6 Oct 2020 18:21:01 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Dave Martin via Libc-alpha <libc-alpha@sourceware.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Len Brown <len.brown@intel.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC PATCH 0/4] x86: Improve Minimum Alternate Stack Size
References: <20200929205746.6763-1-chang.seok.bae@intel.com>
        <20201005134534.GT6642@arm.com>
        <CAMe9rOpZm43aDG3UJeaioU32zSYdTxQ=ZyZuSS4u0zjbs9RoKw@mail.gmail.com>
        <20201006092532.GU6642@arm.com>
        <CAMe9rOq_nKa6xjHju3kVZephTiO+jEW3PqxgAhU9+RdLTo-jgg@mail.gmail.com>
        <20201006152553.GY6642@arm.com>
        <7663eff0-6c94-f6bf-f3e2-93ede50e75ed@intel.com>
        <20201006170020.GB6642@arm.com>
Date:   Tue, 06 Oct 2020 20:21:00 +0200
In-Reply-To: <20201006170020.GB6642@arm.com> (Dave Martin via Libc-alpha's
        message of "Tue, 6 Oct 2020 18:00:21 +0100")
Message-ID: <87362rp65v.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

* Dave Martin via Libc-alpha:

> On Tue, Oct 06, 2020 at 08:33:47AM -0700, Dave Hansen wrote:
>> On 10/6/20 8:25 AM, Dave Martin wrote:
>> > Or are people reporting real stack overruns on x86 today?
>> 
>> We have real overruns.  We have ~2800 bytes of XSAVE (regisiter) state
>> mostly from AVX-512, and a 2048 byte MINSIGSTKSZ.
>
> Right.  Out of interest, do you believe that's a direct consequence of
> the larger kernel-generated signal frame, or does the expansion of
> userspace stack frames play a role too?

I must say that I do not quite understand this question.

32 64-*byte* registers simply need 2048 bytes of storage space worst
case, there is really no way around that.

> In practice software just assumes SIGSTKSZ and then ignores the problem
> until / unless an actual stack overflow is seen.
>
> There's probably a lot of software out there whose stack is
> theoretically too small even without AVX-512 etc. in the mix, especially
> when considering the possibility of nested signals...

That is certainly true.  We have seen problems with ntpd, which
requested a 16 KiB stack, at a time when there were various deductions
from the stack size, and since the glibc dynamic loader also uses XSAVE,
ntpd exceeded the remaining stack space.  But in this case, we just
fudged the stack size computation in pthread_create and made it less
likely that the dynamic loader was activated, which largely worked
around this particular problem.  For MINSIGSTKSZ, we just don't have
this option because it's simply too small in the first place.

I don't immediately recall a bug due to SIGSTKSZ being too small.  The
test cases I wrote for this were all artificial, to raise awareness of
this issue (applications treating these as recommended values, rather
than minimum value to avoid immediately sigaltstack/phtread_create
failures, same issue with PTHREAD_STACK_MIN).

Thanks,
Florian
-- 
Red Hat GmbH, https://de.redhat.com/ , Registered seat: Grasbrunn,
Commercial register: Amtsgericht Muenchen, HRB 153243,
Managing Directors: Charles Cachera, Brian Klemm, Laurie Krebs, Michael O'Neill

