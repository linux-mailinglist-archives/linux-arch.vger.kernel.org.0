Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76FC72E329
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jun 2023 14:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242368AbjFMMiW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Jun 2023 08:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242206AbjFMMiV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Jun 2023 08:38:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D85E1734
        for <linux-arch@vger.kernel.org>; Tue, 13 Jun 2023 05:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686659854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+b1T4bP+M0GcWXoHUW/q06urYQjMJ7X0Y1cHVDwah1s=;
        b=iU5l5P3mQrs21f/coiRrildbjcLeSBoc8kChpUlDImVN+OGleMVLc3AlR9mFGL3kS8isjs
        cWK3Tk3UczAXeNdEZwMPp/roT76JyB9QReUzka0fpkPOtyUe4Ef6WsMUpTsEzSTAlTNF/d
        3bVM1EWFtCX0169+KJ+4y3nNmd31x14=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-505-NQoKV6qBNHuOgzR9uwg-rw-1; Tue, 13 Jun 2023 08:37:31 -0400
X-MC-Unique: NQoKV6qBNHuOgzR9uwg-rw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A8B3185A5BA;
        Tue, 13 Jun 2023 12:37:27 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.16.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 652C41121315;
        Tue, 13 Jun 2023 12:37:20 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
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
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com,
        david@redhat.com, debug@rivosinc.com, szabolcs.nagy@arm.com,
        torvalds@linux-foundation.org, Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>
Subject: Re: [PATCH v9 23/42] Documentation/x86: Add CET shadow stack
 description
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
        <20230613001108.3040476-24-rick.p.edgecombe@intel.com>
        <0b7cae2a-ae5b-40d8-9ae7-10aea5a57fd6@sirena.org.uk>
Date:   Tue, 13 Jun 2023 14:37:18 +0200
In-Reply-To: <0b7cae2a-ae5b-40d8-9ae7-10aea5a57fd6@sirena.org.uk> (Mark
        Brown's message of "Tue, 13 Jun 2023 12:55:48 +0100")
Message-ID: <87y1knh729.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

* Mark Brown:

> On Mon, Jun 12, 2023 at 05:10:49PM -0700, Rick Edgecombe wrote:
>
>> +Enabling arch_prctl()'s
>> +=======================
>> +
>> +Elf features should be enabled by the loader using the below arch_prctl's. They
>> +are only supported in 64 bit user applications. These operate on the features
>> +on a per-thread basis. The enablement status is inherited on clone, so if the
>> +feature is enabled on the first thread, it will propagate to all the thread's
>> +in an app.
>
> I appreciate it's very late in the development of this series but given
> that there are very similar features on both arm64 and riscv would it
> make sense to make these just regular prctl()s, arch_prctl() isn't used
> on other architectures and it'd reduce the amount of arch specific work
> that userspace needs to do if the interface is shared.

Has the Arm feature been fully disclosed?

I would expect the integration with stack switching and unwinding
differs between architectures even if the core mechanism is similar.
It's probably tempting to handle shadow stack placement differently,
too.

Thanks,
Florian

