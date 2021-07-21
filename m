Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B832D3D1665
	for <lists+linux-arch@lfdr.de>; Wed, 21 Jul 2021 20:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239206AbhGURsO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Jul 2021 13:48:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30681 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239157AbhGURsN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Jul 2021 13:48:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626892128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TkdTO/UxdGxI+/KgnvL1pZPS4iHaPv/sef/gzkTwrYg=;
        b=HT+8xbUv57kJvwKY0CsNo1OHm/siAwiwaBZrOaOobV/mp4SMgtbv7B8ZOE2FNBX0UknQxb
        ZIqpT3sDOyJee94JHW0t+DDplnJd+R4qZPmS1rWDpKfpkwx6Lo6zSKtfook9Gq0J9NgAlK
        7h8ZjdHC/xS861dbmdcaCBcW8fCVNoE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-OZJ_IJG8M8idZr9-uoubBQ-1; Wed, 21 Jul 2021 14:28:46 -0400
X-MC-Unique: OZJ_IJG8M8idZr9-uoubBQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0404BC7401;
        Wed, 21 Jul 2021 18:28:42 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-113-201.ams2.redhat.com [10.36.113.201])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D3AE4610AF;
        Wed, 21 Jul 2021 18:28:25 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     John Allen <john.allen@amd.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>
Subject: Re: [PATCH v27 24/31] x86/cet/shstk: Handle thread shadow stack
References: <20210521221211.29077-1-yu-cheng.yu@intel.com>
        <20210521221211.29077-25-yu-cheng.yu@intel.com>
        <YPhkIHJ0guc4UNoO@AUS-LX-JohALLEN.amd.com>
Date:   Wed, 21 Jul 2021 20:28:23 +0200
In-Reply-To: <YPhkIHJ0guc4UNoO@AUS-LX-JohALLEN.amd.com> (John Allen's message
        of "Wed, 21 Jul 2021 13:14:56 -0500")
Message-ID: <87h7gnldx4.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

* John Allen:

> At the very least, it would seem that on some systems, it isn't valid to
> rely on the stack_size passed from clone3, though I'm unsure what the
> correct behavior should be here. If the passed stack_size =3D=3D 0 and sp=
 =3D=3D
> 0, is this a case where we want to alloc a shadow stack for this thread
> with some capped size? Alternatively, is this a case that isn't valid to
> alloc a shadow stack and we should simply return 0 instead of -EINVAL?
>
> I'm running Fedora 34 which satisfies the required versions of gcc,
> binutils, and glibc.

Fedora 34 doesn't use clone3 yet.  You can upgrade to a rawhide build,
e.g. glibc-2.33.9000-46.fc35:

  <https://koji.fedoraproject.org/koji/buildinfo?buildID=3D1782678>

It's currently not in main rawhide because the Firefox sandbox breaks
clone3.  The =E2=80=9Cfix=E2=80=9D is that clone3 will fail with ENOSYS und=
er the
sandbox.

I expect that container runtimes turn clone3 into clone in the same way
(via ENOSYS), at least for the medium term.  So it would make sense to
allocate some sort of shadow stack for clone as well, if that's possible
to implement in some way.

Thanks,
Florian

