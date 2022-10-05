Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49195F5379
	for <lists+linux-arch@lfdr.de>; Wed,  5 Oct 2022 13:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiJELer (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Oct 2022 07:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiJELeS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Oct 2022 07:34:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BA8760EC;
        Wed,  5 Oct 2022 04:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IfD4r/Qnubl/ZXrWJ/hqbcL8YwiA7Xmp7ErQUUoOr/8=; b=gsBoeSTnoX+6nNnHosNB3RX2Wm
        2KEAZ9IKZ6OFskIwRx4wlx1XDS5f6QKQwxVbR7IEnPXs8WAqjkYjcUmjmD7DHrI27myjjTcWSR4L0
        EQAO5RE/1ivJ/IS+G684FlDnjJeT7th1V7fEqLtmbqJYWRPwOFtMKBPaRoHUhXV4kgQAlq/yriK+4
        UJsZvNlFIXt9nSU6fX9RzUOYWIqlF67OhnS4+fd+dfHaR0cwVwcRhMSrnb0Db1/ODuryYNf7oxY0a
        lUkfz/Efv4zbhc47OmDtOlhzmhj6SttDkG3sf6YcYKhp96HsB/gw3aAUP0iQ00IPapI3xFEkiwYIK
        NLOHHI1A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1og2eB-000K0k-A8; Wed, 05 Oct 2022 11:33:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AA0493004A1;
        Wed,  5 Oct 2022 13:33:02 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 90FCA29982FC3; Wed,  5 Oct 2022 13:33:02 +0200 (CEST)
Date:   Wed, 5 Oct 2022 13:33:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
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
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com, rppt@kernel.org,
        jamorris@linux.microsoft.com, dethoma@microsoft.com,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v2 10/39] x86/mm: Introduce _PAGE_COW
Message-ID: <Yz1rbqGHOzmu8Hig@hirez.programming.kicks-ass.net>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-11-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929222936.14584-11-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 29, 2022 at 03:29:07PM -0700, Rick Edgecombe wrote:

Mucho confusion here:

> (a) (Write=0,Cow=1,Dirty=0) A modified, copy-on-write (COW) page.
> (b) (Write=0,Cow=1,Dirty=0) A R/O page that has been COW'ed. The user page
> (d) (Write=0,Cow=1,Dirty=0) A shared shadow stack PTE. When a shadow stack

are all identical cases;

> (c) (Write=0,Cow=0,Dirty=1) A shadow stack PTE.
> (e) (Write=0,Cow=0,Dirty=1) A Cow PTE created when a processor without

as are these.

