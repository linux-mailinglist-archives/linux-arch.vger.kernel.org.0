Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9A83BF5FB
	for <lists+linux-arch@lfdr.de>; Thu,  8 Jul 2021 09:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbhGHHLE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Jul 2021 03:11:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31683 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229838AbhGHHLE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Jul 2021 03:11:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625728102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GEplN6PPVWnKiacZuxrNB8nQ+DkJqElBemBx73k30F4=;
        b=PRjpEoFpjqU+M6rr8YH+9vTm9C54Sd6xGtOKmfZZeXMK0cTP0VCToyAC72UA/sZViHcOOK
        v6usH9TF9Ug6vzb8RxILwQ/lMdHzzXKEAbLW3fNGBIszN+GagJSTgm2FCtt+WejhzwqcGx
        UJU3tM5sJzbBJr1t8aByAhW7S70nip4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-Fp4q-RhJNQ6weHlme5jdPQ-1; Thu, 08 Jul 2021 03:08:21 -0400
X-MC-Unique: Fp4q-RhJNQ6weHlme5jdPQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51BC58030B0;
        Thu,  8 Jul 2021 07:08:20 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-115-5.ams2.redhat.com [10.36.115.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A86EC5C1C2;
        Thu,  8 Jul 2021 07:08:18 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Thiago Macieira <thiago.macieira@intel.com>
Cc:     <hjl.tools@gmail.com>, <libc-alpha@sourceware.org>,
        <linux-api@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <x86@kernel.org>
Subject: Re: x86 CPU features detection for applications (and AMX)
References: <22261946.eFiGugXE7Z@tjmaciei-mobl1>
Date:   Thu, 08 Jul 2021 09:08:16 +0200
In-Reply-To: <22261946.eFiGugXE7Z@tjmaciei-mobl1> (Thiago Macieira's message
        of "Fri, 25 Jun 2021 16:31:06 -0700")
Message-ID: <878s2hxoyn.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

* Thiago Macieira:

> On 23 Jun 2021 17:04:27 +0200, Florian Weimer wrote:
>> We have an interface in glibc to query CPU features:
>> X86-specific Facilities
>> <https://www.gnu.org/software/libc/manual/html_node/X86.html>
>>
>> CPU_FEATURE_USABLE all preconditions for a feature are met,
>> HAS_CPU_FEATURE means it's in silicon but possibly dormant.
>> CPU_FEATURE_USABLE is supposed to look at XCR0, AT_HWCAP2 etc. before
>> enabling the relevant bit (so it cannot pass through any unknown bits).
>
> It's a nice initiative, but it doesn't help library and applications that need 
> to be either cross-platform or backwards compatible.
>
> The first problem is the cross-platformness need. Because we library and 
> application developers need to support other OSes, we'll need to deploy our 
> own CPUID-based detection. It's far better to use common code everywhere, 
> where one developer working on Linux can fix bugs in FreeBSD, macOS or Windows 
> or any of the permutations. Every platform-specific deviation adds to 
> maintenance requirements and is a source of potential latent bugs, now or in 
> the future due to refactoring. That is why doing everything in the form of 
> instructions would be far better and easier, rather than system calls.

I must say this is a rather application-specific view.  Sure, you get
consistency within the application across different targets, but for
those who work on multiple applications (but perhaps on a single
distribution/OS), things are very inconsistent.

And the reason why I started this is that CPUID-based feature detection
is dead anyway (assuming the kernel developers do not implement lazy
initialization of the AMX state).  CPUID (and ancillary data such as
XCR0) will say that AMX support is there, but it will not work unless
some (yet to decided) steps are executed by the userspace thread.

While I consider the CPUID-based model a success (and the cross-OS
consistency may have contributed to that), its days seem to be over.

> [Unless said system calls were standardised and actually
> deployed. Making this a cross-platform library that is not part of
> libc would be a major step in that direction]

That won't help with AMX, as far as I can tell.

Thanks,
Florian

