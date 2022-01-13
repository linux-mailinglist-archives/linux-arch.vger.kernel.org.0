Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF1E548E003
	for <lists+linux-arch@lfdr.de>; Thu, 13 Jan 2022 23:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236759AbiAMWAX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Jan 2022 17:00:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59091 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235088AbiAMWAT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 13 Jan 2022 17:00:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642111219;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iYMosw5qYefWLA9YPdhAGhJH1W9UqqKjH99qcPpNMYc=;
        b=Bd5JEtqrVKAJ3QWw6xlmhPhWQxqioUUqnMkBGLiegRESBzrG5jfBRsj3nO+jbpwpk9XmiI
        s+SvUPQU4jktFomdsLNrSf41qzHY9PnARj2iVckLTpRknnxnVDaohy1NMizEBSgjYVGjQt
        2U2y6zIJrRI+4kT3YBREpM7FfKT1pgI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-56-w9wVhzADN9q-FApepbjLOg-1; Thu, 13 Jan 2022 17:00:14 -0500
X-MC-Unique: w9wVhzADN9q-FApepbjLOg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 305738042E0;
        Thu, 13 Jan 2022 22:00:12 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.192.49])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1ABD35BE37;
        Thu, 13 Jan 2022 22:00:08 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     linux-arch@vger.kernel.org, Linux API <linux-api@vger.kernel.org>,
        linux-x86_64@vger.kernel.org, kernel-hardening@lists.openwall.com,
        linux-mm@kvack.org, the arch/x86 maintainers <x86@kernel.org>,
        musl@lists.openwall.com, libc-alpha@sourceware.org,
        linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Andrei Vagin <avagin@gmail.com>
Subject: Re: [PATCH v3 2/3] selftests/x86/Makefile: Support per-target
 $(LIBS) configuration
References: <3a1c8280967b491bf6917a18fbff6c9b52e8df24.1641398395.git.fweimer@redhat.com>
        <54ae0e1f8928160c1c4120263ea21c8133aa3ec4.1641398395.git.fweimer@redhat.com>
        <034075bd-aac5-9b97-6d09-02d9dd658a0b@kernel.org>
Date:   Thu, 13 Jan 2022 23:00:07 +0100
In-Reply-To: <034075bd-aac5-9b97-6d09-02d9dd658a0b@kernel.org> (Andy
        Lutomirski's message of "Thu, 13 Jan 2022 13:31:58 -0800")
Message-ID: <87lezjxpnc.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

* Andy Lutomirski:

> On 1/5/22 08:03, Florian Weimer wrote:
>> And avoid compiling PCHs by accident.
>> 
>
> The patch seems fine, but I can't make heads or tails of the
> $SUBJECT. Can you help me?

What about this?

selftests/x86/Makefile: Set linked libraries using $(LIBS)

I guess that it's possible to use make features to set this per target
isn't important.

Thanks,
Florian

>> Signed-off-by: Florian Weimer <fweimer@redhat.com>
>> ---
>> v3: Patch split out.
>>   tools/testing/selftests/x86/Makefile | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>> diff --git a/tools/testing/selftests/x86/Makefile
>> b/tools/testing/selftests/x86/Makefile
>> index 8a1f62ab3c8e..0993d12f2c38 100644
>> --- a/tools/testing/selftests/x86/Makefile
>> +++ b/tools/testing/selftests/x86/Makefile
>> @@ -72,10 +72,12 @@ all_64: $(BINARIES_64)
>>   EXTRA_CLEAN := $(BINARIES_32) $(BINARIES_64)
>>     $(BINARIES_32): $(OUTPUT)/%_32: %.c helpers.h
>> -	$(CC) -m32 -o $@ $(CFLAGS) $(EXTRA_CFLAGS) $^ -lrt -ldl -lm
>> +	$(CC) -m32 -o $@ $(CFLAGS) $(EXTRA_CFLAGS) $(filter-out %.h, $^) \
>> +		$(or $(LIBS), -lrt -ldl -lm)
>>     $(BINARIES_64): $(OUTPUT)/%_64: %.c helpers.h
>> -	$(CC) -m64 -o $@ $(CFLAGS) $(EXTRA_CFLAGS) $^ -lrt -ldl
>> +	$(CC) -m64 -o $@ $(CFLAGS) $(EXTRA_CFLAGS) $(filter-out %.h, $^) \
>> +		$(or $(LIBS), -lrt -ldl -lm)
>>     # x86_64 users should be encouraged to install 32-bit libraries
>>   ifeq ($(CAN_BUILD_I386)$(CAN_BUILD_X86_64),01)

