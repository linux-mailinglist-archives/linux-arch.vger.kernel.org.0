Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C142477B89
	for <lists+linux-arch@lfdr.de>; Thu, 16 Dec 2021 19:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236122AbhLPSbb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Dec 2021 13:31:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34651 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231243AbhLPSba (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 16 Dec 2021 13:31:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639679489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n1bFBT5IB/gpnuuiEdK1jZq3mJoWjFnaUGhMpk4YpP0=;
        b=hvRZRBQn7vNF5TuFtEIVaTeygl09sHfIlhtrsR2G6vK04OxIc2JTduR7ha6JuE9Gk+Q+ta
        0zK1PZss1p1bsbWb7Vn8dbOH4iaoUxk2gvq3pvOZHfmq0Zgl8wjE78SNGzvLVFaEBscdJ+
        ABQH7U5F/K923TP8XFad+1bugGvD+yI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-80-EqnyuIOYP4Ku2VG9jSpmOA-1; Thu, 16 Dec 2021 13:31:26 -0500
X-MC-Unique: EqnyuIOYP4Ku2VG9jSpmOA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B26D4801B0C;
        Thu, 16 Dec 2021 18:31:24 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.17.223])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 509D7E2C6;
        Thu, 16 Dec 2021 18:31:21 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     "Andy Lutomirski" <luto@kernel.org>
Cc:     linux-arch@vger.kernel.org,
        "Linux API" <linux-api@vger.kernel.org>,
        linux-x86_64@vger.kernel.org, kernel-hardening@lists.openwall.com,
        linux-mm@kvack.org, "the arch/x86 maintainers" <x86@kernel.org>,
        musl@lists.openwall.com,
        "Dave Hansen via Libc-alpha" <libc-alpha@sourceware.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Kees Cook" <keescook@chromium.org>
Subject: Re: [PATCH] x86: Implement arch_prctl(ARCH_VSYSCALL_LOCKOUT) to
 disable vsyscall
References: <87h7bzjaer.fsf@oldenburg.str.redhat.com>
        <4728eeae-8f1b-4541-b05a-4a0f35a459f7@www.fastmail.com>
        <87lf1ais27.fsf@oldenburg.str.redhat.com>
        <9641b76e-9ae0-4c26-97b6-76ecde34f0ef@www.fastmail.com>
        <878rxaik09.fsf@oldenburg.str.redhat.com>
        <3b5fb404-7228-48d6-a290-9dd1d6095325@www.fastmail.com>
Date:   Thu, 16 Dec 2021 19:31:19 +0100
In-Reply-To: <3b5fb404-7228-48d6-a290-9dd1d6095325@www.fastmail.com> (Andy
        Lutomirski's message of "Sat, 27 Nov 2021 20:45:23 -0800")
Message-ID: <87czlwieq0.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

* Andy Lutomirski:

> This could possibly be much more generic: have a mask of legacy
> features to disable and a separate mask of lock bits.

Is that really necessary?  Adding additional ARCH_* constants does not
seem to be particularly onerous and helps with detection of kernel
support.

>> I can turn this into a toggle, and we could probably default our builds
>> to vsyscalls=xonly.  Given the userspace ABI impact, we'd still have to
>> upstream the toggle.  Do you see a chance of a patch a long these lines
>> going in at all, given that it's an incomplete solution for
>> vsyscall=emulate?
>
> There is basically no reason for anyone to use vsyscall=emulate any
> more.  I'm aware of exactly one use case, and it's quite bizarre and
> involves instrumenting an outdated binary with an outdated
> instrumentation tool.  If either one is recent (last few years),
> vsyscall=xonly is fine.

Yeah, we plan to stick to vsyscall=xonly.  This means that the toggle is
easier to implement, of course.

>> Hmm.  But only for vsyscall=xonly, right?  With vsyscall=emulate,
>> reading at those addresses will still succeed.
>
> IMO if vsyscall is disabled for a process, reads and executes should
> both fail.  This is trivial in xonly mode.

Right, I'll document this as a glitch for now.

I've got a v2 (with the toggle rather than pure lockout) and will sent
it out shortly.

Thanks,
Florian

