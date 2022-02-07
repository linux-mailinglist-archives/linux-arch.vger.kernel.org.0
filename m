Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9934AB8CD
	for <lists+linux-arch@lfdr.de>; Mon,  7 Feb 2022 11:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241517AbiBGKf7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Feb 2022 05:35:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352785AbiBGKWx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Feb 2022 05:22:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D8319C043181
        for <linux-arch@vger.kernel.org>; Mon,  7 Feb 2022 02:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644229372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2smJ/GlsLCD4bPAcOtXvALm5pEn5dU6rKnsOljI8KSo=;
        b=Xf7UbQquJIXbvEWSX6hyv9QGpoOj4YVDWVM0fONsNAyWJOrj+IiNGxqOpkQHhXSpy5S/hJ
        em3AZSU+b91fhfOT0mFA3X0y1SOWq68qXylB63fmskfYYUSJZjiATdt2Et6SFGK9NxAVPJ
        J5KvvYOclSAke6fP+7oPrsHch8wPkZs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-65-idtXnJI4OrGmulbvj6Mxvg-1; Mon, 07 Feb 2022 05:22:46 -0500
X-MC-Unique: idtXnJI4OrGmulbvj6Mxvg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B34A1800D50;
        Mon,  7 Feb 2022 10:22:42 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.193.205])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 23E96607B6;
        Mon,  7 Feb 2022 10:22:21 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     "'Edgecombe, Rick P'" <rick.p.edgecombe@intel.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Eranian, Stephane" <eranian@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "oleg@redhat.com" <oleg@redhat.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Dave.Martin@arm.com" <Dave.Martin@arm.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: Re: [PATCH 00/35] Shadow stacks for userspace
References: <87fsozek0j.ffs@tglx>
        <a7e59ae16e0e05579b087caf4045e42b174e2167.camel@intel.com>
        <3421da7fc8474b6db0e265b20ffd28d0@AcuMS.aculab.com>
        <CAMe9rOonepEiRyoAyTGkDMQQhuyuoP4iTZJJhKGxgnq9vv=dLQ@mail.gmail.com>
        <9f948745435c4c9273131146d50fe6f328b91a78.camel@intel.com>
        <782f27dbe6fc419a8946eeb426253e28@AcuMS.aculab.com>
Date:   Mon, 07 Feb 2022 11:22:20 +0100
In-Reply-To: <782f27dbe6fc419a8946eeb426253e28@AcuMS.aculab.com> (David
        Laight's message of "Sun, 6 Feb 2022 13:42:42 +0000")
Message-ID: <8735kvm0wz.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

* David Laight:

> Was there any 'spare' space in struct jmpbuf ?

jmp_buf in glibc looks like this:

(gdb) ptype/o jmp_buf
type = struct __jmp_buf_tag {
/*      0      |      64 */    __jmp_buf __jmpbuf;
/*     64      |       4 */    int __mask_was_saved;
/* XXX  4-byte hole      */
/*     72      |     128 */    __sigset_t __saved_mask;

                               /* total size (bytes):  200 */
                             } [1]
(gdb) ptype/o __jmp_buf
type = long [8]

The glibc ABI reserves space for 1024 signals, something that Linux is
never going to implement.  We can use that space to store a few extra
registers in __save_mask.  There is a complication because the
pthread_cancel unwinding allocates only space for the __jmpbuf member.
Fortunately, we do not need to unwind the shadow stack for thread
cancellation, so we don't need that extra space in that case.

Thanks,
Florian

