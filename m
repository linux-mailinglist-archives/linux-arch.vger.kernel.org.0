Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2390F5F9D27
	for <lists+linux-arch@lfdr.de>; Mon, 10 Oct 2022 12:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbiJJK4n (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 10 Oct 2022 06:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiJJK4l (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 10 Oct 2022 06:56:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FF112AE6
        for <linux-arch@vger.kernel.org>; Mon, 10 Oct 2022 03:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665399399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uZluJ2tPl3X9nnw7yPiBnqn8JoOI7ryP6/Lgd98YHyQ=;
        b=F5e6267+Ewk1MMdTwneFLBlINOSHWxwobxShNwrJiC8jWYYZhIH+aaaIU6EKh30PSG5tuo
        uD9EW+0LZvufFU24gpYr23lDDBLI2SxF93PnlaL5Qh/ZuB3Q++PNU4MI4buh6eBBqw5DYQ
        3E3+Ulq8HTaK1s0Hlt4/RZrq5aQjYYc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-374-vgbsTadzOzilND0_5f5URw-1; Mon, 10 Oct 2022 06:56:33 -0400
X-MC-Unique: vgbsTadzOzilND0_5f5URw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CB8D5101AA66;
        Mon, 10 Oct 2022 10:56:31 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.192.124])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E37D9492B07;
        Mon, 10 Oct 2022 10:56:23 +0000 (UTC)
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
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com, rppt@kernel.org,
        jamorris@linux.microsoft.com, dethoma@microsoft.com
Subject: Re: [PATCH v2 23/39] x86: Introduce userspace API for CET enabling
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
        <20220929222936.14584-24-rick.p.edgecombe@intel.com>
Date:   Mon, 10 Oct 2022 12:56:22 +0200
In-Reply-To: <20220929222936.14584-24-rick.p.edgecombe@intel.com> (Rick
        Edgecombe's message of "Thu, 29 Sep 2022 15:29:20 -0700")
Message-ID: <87v8os0wx5.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

* Rick Edgecombe:

> +	/* Only support enabling/disabling one feature at a time. */
> +	if (hweight_long(features) > 1)
> +		return -EINVAL;

This means we'll soon need three extra system calls for x86-64 process
start: SHSTK, IBT, and switching off vsyscall emulation.  (The latter
does not need any special CPU support.)

Maybe we can do something else instead to make the strace output a
little bit cleaner?

Thanks,
Florian

