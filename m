Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1AD269FA4F
	for <lists+linux-arch@lfdr.de>; Wed, 22 Feb 2023 18:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbjBVRmQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Feb 2023 12:42:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjBVRmP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Feb 2023 12:42:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55EEE30292;
        Wed, 22 Feb 2023 09:42:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14A28B81618;
        Wed, 22 Feb 2023 17:42:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96373C433D2;
        Wed, 22 Feb 2023 17:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677087731;
        bh=0gnPSBODONoypRkzy7djZNxndwjPGPbGsJG2+MuGfBM=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=ognZxsKhokVVdbYpfsZ17l5Lof7peXR83jIqYWSpAjSMnbUBBgtKt6C/ot9roPLhp
         5ZrHi0Fni78Kz4rBcCJP5lQc+m1V9JDwgZZvXZVHkeVZylowpG/P2hnhNc4+ntX0p1
         Nj0hwjyLhWV+3EJHwEa+FpUwyO4+vA3+6Ip+7IRyc7bE2R6SUNwXNHOufBEEmCjlOX
         iscp2J58zXbJZYO2Y4n/cdtpJXo1iAdgpoJuXpeGdfMG+xv+xI6QSl2ebhWjR58pcB
         l68D5U8sGttUBKeYG3BxahwHhjfdQGpWLiYSKfyMd/D++Az3GQ1YQ3u/QDKZPTWawH
         vlRyiLSMTMlpQ==
Date:   Wed, 22 Feb 2023 09:42:09 -0800
From:   Kees Cook <kees@kernel.org>
To:     David Hildenbrand <david@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Subject: Re: [PATCH v6 14/41] x86/mm: Introduce _PAGE_SAVED_DIRTY
User-Agent: K-9 Mail for Android
In-Reply-To: <62b48389-0e61-17da-6a72-d4a16e003352@redhat.com>
References: <20230218211433.26859-1-rick.p.edgecombe@intel.com> <20230218211433.26859-15-rick.p.edgecombe@intel.com> <70681787-0d33-a9ed-7f2a-747be1490932@redhat.com> <6f19d7c7ad9f61fa8f6c9bd09d24524dbe17463f.camel@intel.com> <6e1201f5-da25-6040-8230-c84856221838@redhat.com> <273414f5-2a7c-3cc0-dc27-d07baaa5787b@intel.com> <52f001ef-a409-4f33-f28f-02e806ef305a@redhat.com> <74b91f3e-17f7-6d89-a7d1-7373101bf8b7@intel.com> <62b48389-0e61-17da-6a72-d4a16e003352@redhat.com>
Message-ID: <279E91DE-D152-4996-BBD2-BB310AD38620@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On February 22, 2023 9:27:35 AM PST, David Hildenbrand <david@redhat=2Ecom>=
 wrote:
>On 22=2E02=2E23 18:23, Dave Hansen wrote:
>> On 2/22/23 01:05, David Hildenbrand wrote:
>>> This series wasn't in -next and we're in the merge window=2E Is the pl=
an
>>> to still include it into this merge window?
>>=20
>> No way=2E  It's 6=2E4 material at the earliest=2E
>>=20
>> I'm just saying to Rick not to worry _too_ much about earlier feedback
>> from me if folks have more recent review feedback=2E
>
>Great=2E So I hope we can get this into -next soon and that we'll only ge=
t non-earth-shattering feedback so this can land in 6=2E4=2E

Yes please=2E Who's going to take it? :)


--=20
Kees Cook
