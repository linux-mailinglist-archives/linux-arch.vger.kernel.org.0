Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A0061E14F
	for <lists+linux-arch@lfdr.de>; Sun,  6 Nov 2022 10:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiKFJe1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Nov 2022 04:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiKFJe0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Nov 2022 04:34:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B735563EB
        for <linux-arch@vger.kernel.org>; Sun,  6 Nov 2022 01:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667727209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Zh55VMQOWIkhaJAfQsJ8QsFJiksbwnIoMMdZI6R95ts=;
        b=FgmhbMDwsc8SPUWtdru5VBBnHeNGxb9G7mRRQtQiuBbj2QHueEJHsnwLAWd+CJ5DY4cIEy
        rzLLj/FjoaumvyOcpQyKUoK7uaxvqZce+Cu/5K2BSs9UA0PGZjjpGpQ1w3fZVKAzNN91iI
        J4I+3uAdC6IYJXITexlNSbaavuHtjfs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-96-_TRw53ORONGgtKkEmETIFA-1; Sun, 06 Nov 2022 04:33:25 -0500
X-MC-Unique: _TRw53ORONGgtKkEmETIFA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0760238041D5;
        Sun,  6 Nov 2022 09:33:24 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.16.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E146C40C2064;
        Sun,  6 Nov 2022 09:33:11 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     "H.J. Lu" <hjl.tools@gmail.com>
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
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [RFC 37/37] fs/binfmt_elf: Block old shstk elf bit
References: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
        <20221104223604.29615-38-rick.p.edgecombe@intel.com>
        <CAMe9rOpfSccXVWmgK6E0Y0DXC=VX3PpdxXookN1Ty8soeAxrKw@mail.gmail.com>
Date:   Sun, 06 Nov 2022 10:33:10 +0100
In-Reply-To: <CAMe9rOpfSccXVWmgK6E0Y0DXC=VX3PpdxXookN1Ty8soeAxrKw@mail.gmail.com>
        (H. J. Lu's message of "Fri, 4 Nov 2022 15:56:16 -0700")
Message-ID: <87iljs4ecp.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

* H. J. Lu:

> This change doesn't make a binary CET compatible.  It just requires
> that the toolchain must be updated and all binaries have to be
> recompiled with the new toolchain to enable CET.  It doesn't solve any
> issue which can't be solved by not updating glibc.

Right, and it doesn't even address the library case (the kernel would
have to hook into mmap for that).  The kernel shouldn't do this.

Thanks,
Florian

