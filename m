Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62D6C677972
	for <lists+linux-arch@lfdr.de>; Mon, 23 Jan 2023 11:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjAWKqD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 23 Jan 2023 05:46:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjAWKqC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 23 Jan 2023 05:46:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A8B12F04
        for <linux-arch@vger.kernel.org>; Mon, 23 Jan 2023 02:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674470717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lQYrnwFUsQDqjmZGkPEbqFd0u/uKqN3ucpVdTalmvp0=;
        b=VNRu5anfz9+2AUtkWHc0H+JC+HOXlpkExZHLNUspic8PPd60rdlfZEQjhcvN8g02wUHknb
        H5IVo2dOcLpiHkGNPNXqKWtXE87ndnsUl8CpMgTt/DfR2b22ZNi9cODoq4cZtPNBv30EIF
        hp9hHPNApph0Jp3wRMf3n7qykRudWyE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-14-z2gzx7qvMwO7rvRXUnnpYw-1; Mon, 23 Jan 2023 05:45:13 -0500
X-MC-Unique: z2gzx7qvMwO7rvRXUnnpYw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DEA7629ABA00;
        Mon, 23 Jan 2023 10:45:11 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.16.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 22BF74014EBE;
        Mon, 23 Jan 2023 10:45:06 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     David Hildenbrand <david@redhat.com>
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
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com
Subject: Re: [PATCH v5 23/39] mm: Don't allow write GUPs to shadow stack memory
References: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
        <20230119212317.8324-24-rick.p.edgecombe@intel.com>
        <aa973c0f-5d90-36df-01b2-db9d9182910e@redhat.com>
Date:   Mon, 23 Jan 2023 11:45:04 +0100
In-Reply-To: <aa973c0f-5d90-36df-01b2-db9d9182910e@redhat.com> (David
        Hildenbrand's message of "Mon, 23 Jan 2023 10:10:04 +0100")
Message-ID: <87fsc1il73.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

* David Hildenbrand:

> On 19.01.23 22:23, Rick Edgecombe wrote:
>> The x86 Control-flow Enforcement Technology (CET) feature includes a new
>> type of memory called shadow stack. This shadow stack memory has some
>> unusual properties, which requires some core mm changes to function
>> properly.
>> Shadow stack memory is writable only in very specific, controlled
>> ways.
>> However, since it is writable, the kernel treats it as such. As a result
>> there remain many ways for userspace to trigger the kernel to write to
>> shadow stack's via get_user_pages(, FOLL_WRITE) operations. To make this a
>> little less exposed, block writable GUPs for shadow stack VMAs.
>> Still allow FOLL_FORCE to write through shadow stack protections, as
>> it
>> does for read-only protections.
>
> So an app can simply modify the shadow stack itself by writing to
> /proc/self/mem ?
>
> Is that really intended? Looks like security hole to me at first
> sight, but maybe I am missing something important.

Isn't it possible to overwrite GOT pointers using the same vector?
So I think it's merely reflecting the status quo.

Thanks,
Florian

