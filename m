Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 680BA48EADD
	for <lists+linux-arch@lfdr.de>; Fri, 14 Jan 2022 14:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241345AbiANNgo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Jan 2022 08:36:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36445 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231979AbiANNgj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 14 Jan 2022 08:36:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642167397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n+u9lImGJHsltEhgnOxi+5lKtT79IMZvETmYQxQXldM=;
        b=I2+44kpnBv601HM0Jz4TVJyCtcFza9GyWlpHbuS0IJyF+sn7n7fJgwUqKKYH/Nhg0IDvOr
        HE8DbVEJXnUz6p9PMJyFaE30qi0W4AErlLNc5QtpYjOzymAGOWK9oJgWN1oSAoWnM07TpL
        r2QsnwME3SKUSQEOS7v8GuQA0MaZFgk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-184-eQAah2ufPRiIcSj7ZNrWFg-1; Fri, 14 Jan 2022 08:36:32 -0500
X-MC-Unique: eQAah2ufPRiIcSj7ZNrWFg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 292CA1083F7A;
        Fri, 14 Jan 2022 13:36:30 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.192.49])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E985703B8;
        Fri, 14 Jan 2022 13:36:26 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     linux-arch@vger.kernel.org, Linux API <linux-api@vger.kernel.org>,
        linux-x86_64@vger.kernel.org, kernel-hardening@lists.openwall.com,
        linux-mm@kvack.org, the arch/x86 maintainers <x86@kernel.org>,
        musl@lists.openwall.com, libc-alpha@sourceware.org,
        linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Andrei Vagin <avagin@gmail.com>
Subject: Re: [PATCH v3 1/3] x86: Implement arch_prctl(ARCH_VSYSCALL_CONTROL)
 to disable vsyscall
References: <3a1c8280967b491bf6917a18fbff6c9b52e8df24.1641398395.git.fweimer@redhat.com>
        <e431fa42-26ec-8ac6-f954-e681b1e0e9a6@kernel.org>
Date:   Fri, 14 Jan 2022 14:36:24 +0100
In-Reply-To: <e431fa42-26ec-8ac6-f954-e681b1e0e9a6@kernel.org> (Andy
        Lutomirski's message of "Thu, 13 Jan 2022 13:47:26 -0800")
Message-ID: <87sftqtp5z.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

* Andy Lutomirski:

> Is there a reason you didn't just change the check earlier in the
> function to:
>
> if (vsyscall_mode == NONE || current->mm->context.vsyscall_disabled)

Andrei requested that I don't print anything if vsyscall was disabled.

The original patch used a different message for better diagnostics.

> Also, I still think the prctl should not be available if
> vsyscall=emulate.  Either we should fully implement it or we should
> not implement.  We could even do:
>
> pr_warn_once("userspace vsyscall hardening request ignored because you
> have vsyscall=emulate.  Unless you absolutely need vsyscall=emulate, 
> update your system to use vsyscall=xonly.\n");
>
> and thus encourage good behavior.

I think there is still some hardening applied even with
vsyscall=emulate.  The question is what is more important: the
additional hardening, or clean, easily described behavior of the
interface.

Maybe ARCH_VSYSCALL_CONTROL could return different values based on to
what degree it could disable vsyscall?

The pr_warn_once does not seem particularly useful.  Anyone who upgrades
glibc and still uses vsyscall=emulate will see that, with no way to
disable it.

Thanks,
Florian

