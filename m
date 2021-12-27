Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88D3B4802E1
	for <lists+linux-arch@lfdr.de>; Mon, 27 Dec 2021 18:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbhL0Rkw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Dec 2021 12:40:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53006 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230338AbhL0Rkv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 27 Dec 2021 12:40:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640626851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YAHdEgA4vBfChhqcXFr18t3cp4WP7TtGCi10QnGN9O0=;
        b=GUas0yw6GFfw8OeL62q1eucxiwNMdorPJzKLuvgroxDdoh8TytFtMwDDcLs9WfRAKevfpI
        CSAl2Cu2UHfURezSsnYXZiANYERVfD556HJYcz9JoNIMDkge75CLfuyychdqjAcJx1Et9H
        SAGh7j+bKXEJe7Ye4xRlvdGWgg51+Cc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-664-N8MuQBfBMpGw50_ypxFLLA-1; Mon, 27 Dec 2021 12:40:45 -0500
X-MC-Unique: N8MuQBfBMpGw50_ypxFLLA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 121B0801B2F;
        Mon, 27 Dec 2021 17:40:44 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.192.44])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5800D8CB24;
        Mon, 27 Dec 2021 17:40:40 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Andrei Vagin <avagin@gmail.com>
Cc:     Andy Lutomirski <luto@kernel.org>, linux-arch@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        linux-x86_64@vger.kernel.org, kernel-hardening@lists.openwall.com,
        linux-mm@kvack.org, "the arch/x86 maintainers" <x86@kernel.org>,
        musl@lists.openwall.com, libc-alpha@sourceware.org,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2] x86: Implement arch_prctl(ARCH_VSYSCALL_CONTROL) to
 disable vsyscall
References: <878rwkidtf.fsf@oldenburg.str.redhat.com>
        <CANaxB-xpQr1mUUvWK5a53q49VK_HvR4Pws_NGKGa8-jihxkc_A@mail.gmail.com>
Date:   Mon, 27 Dec 2021 18:40:38 +0100
In-Reply-To: <CANaxB-xpQr1mUUvWK5a53q49VK_HvR4Pws_NGKGa8-jihxkc_A@mail.gmail.com>
        (Andrei Vagin's message of "Mon, 27 Dec 2021 08:49:38 -0800")
Message-ID: <87o8520wvd.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

* Andrei Vagin:

>> diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
>> index fd2ee9408e91..8eb3bcf2cedf 100644
>> --- a/arch/x86/entry/vsyscall/vsyscall_64.c
>> +++ b/arch/x86/entry/vsyscall/vsyscall_64.c
>> @@ -174,6 +174,12 @@ bool emulate_vsyscall(unsigned long error_code,
>>
>>         tsk = current;
>>
>> +       if (tsk->mm->context.vsyscall_disabled) {
>> +               warn_bad_vsyscall(KERN_WARNING, regs,
>> +                                 "vsyscall after lockout (exploit attempt?)");
>
> I don't think that we need this warning message. If we disable
> vsyscall, its address range is not differ from other addresses around
> and has to be handled the same way. For example, gVisor or any other
> sandbox engines may want to emulate vsyscall, but the kernel log will
> be full of such messages.

But with vsyscall=none, such messages are already printed.  That's why I
added the warning for the lockout case as well.

>> diff --git a/tools/testing/selftests/x86/vsyscall_control.c b/tools/testing/selftests/x86/vsyscall_control.c
>> new file mode 100644
>> index 000000000000..ee966f936c89
>> --- /dev/null
>> +++ b/tools/testing/selftests/x86/vsyscall_control.c
>
> I would move the test in a separate patch...

I can do that if it simplifies matters.

Thanks,
Florian

