Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B57956F0A
	for <lists+linux-arch@lfdr.de>; Wed, 26 Jun 2019 18:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfFZQpT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-arch@lfdr.de>); Wed, 26 Jun 2019 12:45:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34346 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbfFZQpT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 26 Jun 2019 12:45:19 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1FD1C307D849;
        Wed, 26 Jun 2019 16:45:14 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (dhcp-192-180.str.redhat.com [10.33.192.180])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D8BCC60852;
        Wed, 26 Jun 2019 16:45:09 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-x86_64@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Carlos O'Donell <carlos@redhat.com>, X86 ML <x86@kernel.org>
Subject: Re: Detecting the availability of VSYSCALL
References: <87v9wty9v4.fsf@oldenburg2.str.redhat.com>
        <alpine.DEB.2.21.1906251824500.32342@nanos.tec.linutronix.de>
        <87lfxpy614.fsf@oldenburg2.str.redhat.com>
        <CALCETrVh1f5wJNMbMoVqY=bq-7G=uQ84BUkepf5RksA3vUopNQ@mail.gmail.com>
        <87a7e5v1d9.fsf@oldenburg2.str.redhat.com>
        <CALCETrUDt4v3=FqD+vseGTKTuG=qY+1LwRPrOrU8C7vCVbo=uA@mail.gmail.com>
        <87o92kmtp5.fsf@oldenburg2.str.redhat.com>
        <CA96B819-30A9-43D3-9FE3-2D551D35369E@amacapital.net>
        <87r27gjss3.fsf@oldenburg2.str.redhat.com>
        <534B9F63-E949-4CF5-ACAC-71381190846F@amacapital.net>
        <87a7e4jr4s.fsf@oldenburg2.str.redhat.com>
        <6CECE9DE-51AB-4A21-A257-8B85C4C94EB0@amacapital.net>
Date:   Wed, 26 Jun 2019 18:45:08 +0200
In-Reply-To: <6CECE9DE-51AB-4A21-A257-8B85C4C94EB0@amacapital.net> (Andy
        Lutomirski's message of "Wed, 26 Jun 2019 09:24:38 -0700")
Message-ID: <87sgrw1ejv.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Wed, 26 Jun 2019 16:45:19 +0000 (UTC)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

* Andy Lutomirski:

> Can’t an ELF note be done with some more or less ordinary asm such
> that any link editor will insert it correctly?

We've just been over this for the CET enablement.  ELF PT_NOTE parsing
was rejected there.

I don't think binutils ld has a way to set an ELF program header it
doesn't know anything about.

>>> Would enterprise distros consider backporting such a thing?
>> 
>> Enterprise distros aren't the problem here because they can't remove
>> vsyscall support for quite a while due to existing customer binaries.
>> For them, it would just be an additional (and welcome) hardening
>> opportunity.
>> 
>> The challenge here are container hosting platforms which have already
>> disabled vsyscall, presumably to protect the container host itself.
>> They would need to rebuild the container host userspace with the markup
>> to keep it protected, and then they could switch to a kernel which has
>> vsyscall-unless-opt-out logic.  That seems to be a bit of a stretch
>> because from their perspective, there's no problem today.
>> 
>> My guess is that it would be easier to have a personality flag.  Then
>> they could keep the host largely as-is, and would “only” need a
>> mechanism to pass through the flag from the image metadata to the actual
>> container creation.  It's still a change to the container host (and the
>> kernel change is required as well), but it would not require relinking
>> every statically linked binary.

> The problem with a personality flag is that it needs to have some kind
> of sensible behavior for setuid programs, and getting that right in a
> way that doesn’t scream “exploit me” while preserving useful
> compatibility may be tricky.

Are restrictive personality flags still a problem with user namespaces?
I think it would be fine to restrict this one to CAP_SYS_ADMIN.

Thanks,
Florian
