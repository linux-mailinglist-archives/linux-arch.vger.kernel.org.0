Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969E767B5CF
	for <lists+linux-arch@lfdr.de>; Wed, 25 Jan 2023 16:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235615AbjAYPXd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 25 Jan 2023 10:23:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235203AbjAYPXc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 25 Jan 2023 10:23:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4AD367CF;
        Wed, 25 Jan 2023 07:23:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC56D60ACA;
        Wed, 25 Jan 2023 15:23:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2951BC433D2;
        Wed, 25 Jan 2023 15:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674660210;
        bh=n0tElQWhc562jr5djK4tbNXbksESM0fB5VT7n9Ly9wI=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=m+9tXk/DTy7ifoyPec9EcyhpTAAqJrxu4qHW6Q2bg0O6TTABR7F5ox3b4OfXin6md
         57FM+xKSno9XHmivVCSUxotkFpmge5Vt/izlLctl/58yz+Naixw6uchInoU3DKMQZ2
         I566mi60QW2bgUkCakrEs4Rnyb8JbKDeilhm7x+yZsIr6hVirawYH/rKwh10/53Qx/
         /PC9wC8iiiwJP59J+tx7q4VA6yPYCRhtWyNHXtI+EN5Yn3wYJVI059L/kbo8cCp9B4
         0okvWfIz/Mx9sD/QwKVJTzeyqaCgyLcKp4qQK7NL3VYNZ2ARBRAXoIKMO9P8galWAg
         SMd/rfHjqC30Q==
Date:   Wed, 25 Jan 2023 07:23:27 -0800
From:   Kees Cook <kees@kernel.org>
To:     David Hildenbrand <david@redhat.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>
CC:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
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
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v5_23/39=5D_mm=3A_Don=27t_allo?= =?US-ASCII?Q?w_write_GUPs_to_shadow_stack_memory?=
User-Agent: K-9 Mail for Android
In-Reply-To: <716d9e97-b08f-eb0f-101a-be6eaf36f184@redhat.com>
References: <20230119212317.8324-1-rick.p.edgecombe@intel.com> <20230119212317.8324-24-rick.p.edgecombe@intel.com> <aa973c0f-5d90-36df-01b2-db9d9182910e@redhat.com> <87fsc1il73.fsf@oldenburg.str.redhat.com> <c6dc94eb193634fa27e1715ab2978a3ce4b6c544.camel@intel.com> <fd741ac9-8214-a375-00b2-a652a7ef27ea@redhat.com> <6adfa0b5c38a9362f819fcc364e02c37d99a7f4a.camel@intel.com> <5B29D7A0-385A-41E8-AA56-EF726E6906BF@kernel.org> <19ff6ea3b96d027defb548fb6b7f89de17905a4b.camel@intel.com> <716d9e97-b08f-eb0f-101a-be6eaf36f184@redhat.com>
Message-ID: <E857CF98-EEB2-4F83-8305-0A52B463A661@kernel.org>
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

On January 25, 2023 1:29:20 AM PST, David Hildenbrand <david@redhat=2Ecom> =
wrote:
>On 25=2E01=2E23 00:41, Edgecombe, Rick P wrote:
>> On Tue, 2023-01-24 at 15:08 -0800, Kees Cook wrote:
>>>> GDB support for shadow stack is queued up for whenever the kernel
>>>> interface settles=2E I believe it just uses ptrace, and not this
>>>> proc=2E
>>>> But yea ptrace poke will still need to use FOLL_FORCE and be able
>>>> to
>>>> write through shadow stacks=2E
>>>=20
>>> I'd prefer to avoid adding more FOLL_FORCE if we can=2E If gdb can do
>>> stack manipulations through a ptrace interface then let's leave off
>>> FOLL_FORCE=2E
>>=20
>> Ptrace and /proc/self/mem both use FOLL_FORCE=2E I think ptrace will
>> always need it or something like it for debugging=2E
>>=20
>> To jog your memory, this series doesn't change what uses FOLL_FORCE=2E =
It
>> just sets the shadow stack rules to be the same as read-only memory=2E =
So
>> even though shadow stack memory is sort of writable, it's a bit more
>> locked down and FOLL_FORCE is required to write to it with GUP=2E
>>=20
>> If we just remove FOLL_FORCE from /proc/self/mem, something will
>> probably break right? How do we do this? Some sort of opt-in?
>
>I don't think removing that is an option=2E It's another debug interface =
that has been allowing such access for ever =2E=2E=2E
>
>Blocking /proc/self/mem access completely for selected processes might be=
 the better alternative=2E
>

Yeah, this would be nice=2E Kind of like being undumpable or no_new_privs=
=2E



--=20
Kees Cook
