Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 114934A3E65
	for <lists+linux-arch@lfdr.de>; Mon, 31 Jan 2022 08:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240625AbiAaH5R (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Jan 2022 02:57:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21805 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236789AbiAaH5R (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 31 Jan 2022 02:57:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643615836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UKRrxpA5zhfSZiQGv/yx2cUoAnXjZEXW1GA6k9oFz4w=;
        b=B6+oBc4812BIE+foOlFAs2qiSso6ht4kFUpYJOG2/UjanQ43I0iHvGA41qkeIKnGY65QtG
        T5T34UBYLg5vJscMMwQUZWR0ujysPD53OQQGRTLUI2m3LhNf6By98mnVfK6clSpVPaYS87
        Q8ZjMr2l3P2aWPgd8S5NvWylCbLZSr8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-216-gCx-9PGnMD2a71SWny4wNg-1; Mon, 31 Jan 2022 02:57:13 -0500
X-MC-Unique: gCx-9PGnMD2a71SWny4wNg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 25AD946863;
        Mon, 31 Jan 2022 07:57:09 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.193.205])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F63C5F936;
        Mon, 31 Jan 2022 07:56:47 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
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
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com
Subject: Re: [PATCH 34/35] x86/cet/shstk: Support wrss for userspace
In-Reply-To: <20220130211838.8382-35-rick.p.edgecombe@intel.com> (Rick
        Edgecombe's message of "Sun, 30 Jan 2022 13:18:37 -0800")
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
        <20220130211838.8382-35-rick.p.edgecombe@intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
Date:   Mon, 31 Jan 2022 08:56:45 +0100
Message-ID: <87wnig8hj6.fsf@oldenburg.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

* Rick Edgecombe:

> For the current shadow stack implementation, shadow stacks contents cannot
> be arbitrarily provisioned with data. This property helps apps protect
> themselves better, but also restricts any potential apps that may want to
> do exotic things at the expense of a little security.
>
> The x86 shadow stack feature introduces a new instruction, wrss, which
> can be enabled to write directly to shadow stack permissioned memory from
> userspace. Allow it to get enabled via the prctl interface.

Why can't this be turned on unconditionally?

Thanks,
Florian

