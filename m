Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0C248EAA9
	for <lists+linux-arch@lfdr.de>; Fri, 14 Jan 2022 14:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241236AbiANN2j (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Jan 2022 08:28:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:53001 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241222AbiANN2i (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 14 Jan 2022 08:28:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642166918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i7Hb3kE5ydsp6WhjzeEMuriHMwtkc9A+4GAC1LGLZ9Q=;
        b=VK09i/CajmAH+YL8HVRqIiQ+DnJNMIPmvZkR0JyRN47ohLc2K+nJfU1XZ/w2rPpqQnYgoB
        ZcozIkMhvkFxKY/IW6BzIwoAj3Fx7nt82PEa2kIFVDi8gSMQIYx6J7T3177Df8ZN1ESDpW
        ALIqyfAOLlR3ud2zKSxXE13YUEKtjWw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-443-A6VT-Y_FOmK3YvPx4rqxCA-1; Fri, 14 Jan 2022 08:28:35 -0500
X-MC-Unique: A6VT-Y_FOmK3YvPx4rqxCA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 54716760C1;
        Fri, 14 Jan 2022 13:28:31 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.192.49])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B19417AB5D;
        Fri, 14 Jan 2022 13:28:27 +0000 (UTC)
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
        "Kees Cook" <keescook@chromium.org>,
        "Andrei Vagin" <avagin@gmail.com>
Subject: Re: [PATCH v3 2/3] selftests/x86/Makefile: Support per-target
 $(LIBS) configuration
References: <3a1c8280967b491bf6917a18fbff6c9b52e8df24.1641398395.git.fweimer@redhat.com>
        <54ae0e1f8928160c1c4120263ea21c8133aa3ec4.1641398395.git.fweimer@redhat.com>
        <034075bd-aac5-9b97-6d09-02d9dd658a0b@kernel.org>
        <87lezjxpnc.fsf@oldenburg.str.redhat.com>
        <5a4f01f4-cd16-47dd-880b-dcfb7ec5daeb@www.fastmail.com>
Date:   Fri, 14 Jan 2022 14:28:25 +0100
In-Reply-To: <5a4f01f4-cd16-47dd-880b-dcfb7ec5daeb@www.fastmail.com> (Andy
        Lutomirski's message of "Thu, 13 Jan 2022 18:34:20 -0800")
Message-ID: <87wnj2tpja.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

* Andy Lutomirski:

> On Thu, Jan 13, 2022, at 2:00 PM, Florian Weimer wrote:
>> * Andy Lutomirski:
>>
>>> On 1/5/22 08:03, Florian Weimer wrote:
>>>> And avoid compiling PCHs by accident.
>>>> 
>>>
>>> The patch seems fine, but I can't make heads or tails of the
>>> $SUBJECT. Can you help me?
>>
>> What about this?
>>
>> selftests/x86/Makefile: Set linked libraries using $(LIBS)
>>
>> I guess that it's possible to use make features to set this per target
>> isn't important.
>
> I think that's actually important -- it's nice to explain to make
> dummies (e.g. me) what the purpose is is.  I assume it's so that a
> given test can override the libraries.  Also, you've conflated two
> different changes into one patch: removal of .h and addition of LIBS.

Do you want me to split this further into two commits?

  selftests/x86/Makefile: Per-target configuration of linked libraries

  Targets can set $(LIBS) to specify a different set of libraries than the
  defaults (or no libraries at all).

And:

  selftests/x86/Makefile: Do not pass header files as compiler inputs

  Filtering out .h files avoids accidentally creating a precompiled
  header.

I didn't want to game commit metrics.

Thanks,
Florian

