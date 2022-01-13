Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1DBC48DFFA
	for <lists+linux-arch@lfdr.de>; Thu, 13 Jan 2022 22:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbiAMV5b (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Jan 2022 16:57:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:47259 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229534AbiAMV5a (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 13 Jan 2022 16:57:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642111050;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TMX/kWIlUA1AE1kmxxn6oC9JgTpebsg3ohbjH9GEsvI=;
        b=Pzzp/ruRU7iKZbOx1eaGwMakGi+EswA1NlTeCsjrEnAjJErFmfUCdH8QrkkUF4MOM0nsFk
        5rVikFRoswC++s8on2sDD3ioJZRpY3lfXVdu5XwL9CUAtmIBAD0n3l6ZQaHpNh+UGhDvai
        AEGaNk8F6hScToBj9/7ODWtqEHHv8pI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-49-L8FNEgkdMraDDmpSMaBG_A-1; Thu, 13 Jan 2022 16:57:28 -0500
X-MC-Unique: L8FNEgkdMraDDmpSMaBG_A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62A1F1853028;
        Thu, 13 Jan 2022 21:57:26 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.192.49])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 013154698C;
        Thu, 13 Jan 2022 21:57:22 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     linux-arch@vger.kernel.org, Linux API <linux-api@vger.kernel.org>,
        linux-x86_64@vger.kernel.org, kernel-hardening@lists.openwall.com,
        linux-mm@kvack.org, the arch/x86 maintainers <x86@kernel.org>,
        musl@lists.openwall.com, libc-alpha@sourceware.org,
        linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Andrei Vagin <avagin@gmail.com>
Subject: Re: [PATCH v3 3/3] x86: Add test for arch_prctl(ARCH_VSYSCALL_CONTROL)
References: <3a1c8280967b491bf6917a18fbff6c9b52e8df24.1641398395.git.fweimer@redhat.com>
        <54ae0e1f8928160c1c4120263ea21c8133aa3ec4.1641398395.git.fweimer@redhat.com>
        <564ba9d6b8f88d139be556d039aadb4b8e078eba.1641398395.git.fweimer@redhat.com>
        <4db8cff9-8bf8-0c45-6956-4b1b19b53b2f@kernel.org>
Date:   Thu, 13 Jan 2022 22:57:20 +0100
In-Reply-To: <4db8cff9-8bf8-0c45-6956-4b1b19b53b2f@kernel.org> (Andy
        Lutomirski's message of "Thu, 13 Jan 2022 13:31:04 -0800")
Message-ID: <87pmovxprz.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

* Andy Lutomirski:

> On 1/5/22 08:03, Florian Weimer wrote:
>> Signed-off-by: Florian Weimer <fweimer@redhat.com>
>
> This seems like a respectable test case, but why does it work so hard
> to avoid using libc?

Back when this was still a true lockout and not a toggle, it was
necessary to bypass the startup code, so that the test still works once
the (g)libc startup starts activating the lockout.  The /proc mounting
is there to support running as init in a VM (which makes development so
much easier).

I could ditch the /proc mounting, perform some limited data gathering in
a pre-_start routine, undo a potential lockout before the tests, and
then use libc functions for the actual test.  It would probably be a bit
less code (printf is nice), but I'd probably have to use direct system
calls for the early data gathering anyway, so those parts would still be
there.

Thanks,
Florian

