Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3F267A6AA
	for <lists+linux-arch@lfdr.de>; Wed, 25 Jan 2023 00:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbjAXXIu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Jan 2023 18:08:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233847AbjAXXIt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 24 Jan 2023 18:08:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A37D4E539;
        Tue, 24 Jan 2023 15:08:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F2C9613F8;
        Tue, 24 Jan 2023 23:08:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7A68C4339C;
        Tue, 24 Jan 2023 23:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674601724;
        bh=IbzbzQ0xciaiyYsjPaDasMlvV/iw0I2Bm7dIPBgXPh4=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=lW2Y9CMKwr0f3yBu3MAd11Y5GvI43oUYGwDPlHRFMECuZCbsz3KktpI/NvoqIbzmx
         42scFkq0oP3vRnCrL+HmfDa1e6VYFRYrtPRnQOe+Jb0l7WQD5I4igTnWErA71a3hq8
         Fhx1d6rxikZEEs88/8ovvCp3FiSfFRmZ3a/CY/CVe/FFnB+SO4LrXQq/qoX7HnjZE2
         Neq0VWJcLFsRvTjRK4fk6vrtyBRXCW/LNRByQPL/iEtK4HtzJ9DtW0Yzyr3t8kZbzM
         W3WPrWB6VDYEUh3KIIp4iKpfAMXV9KHld8741QQMENK1ZX8GxktYhq5GOzq/fP3tAh
         yOGBEHjAEx6Og==
Date:   Tue, 24 Jan 2023 15:08:40 -0800
From:   Kees Cook <kees@kernel.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "david@redhat.com" <david@redhat.com>
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
        "pavel@ucw.cz" <pavel@ucw.cz>, "rppt@kernel.org" <rppt@kernel.org>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v5_23/39=5D_mm=3A_Don=27t_allo?= =?US-ASCII?Q?w_write_GUPs_to_shadow_stack_memory?=
User-Agent: K-9 Mail for Android
In-Reply-To: <6adfa0b5c38a9362f819fcc364e02c37d99a7f4a.camel@intel.com>
References: <20230119212317.8324-1-rick.p.edgecombe@intel.com> <20230119212317.8324-24-rick.p.edgecombe@intel.com> <aa973c0f-5d90-36df-01b2-db9d9182910e@redhat.com> <87fsc1il73.fsf@oldenburg.str.redhat.com> <c6dc94eb193634fa27e1715ab2978a3ce4b6c544.camel@intel.com> <fd741ac9-8214-a375-00b2-a652a7ef27ea@redhat.com> <6adfa0b5c38a9362f819fcc364e02c37d99a7f4a.camel@intel.com>
Message-ID: <5B29D7A0-385A-41E8-AA56-EF726E6906BF@kernel.org>
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

On January 24, 2023 10:42:28 AM PST, "Edgecombe, Rick P" <rick=2Ep=2Eedgeco=
mbe@intel=2Ecom> wrote:
>Ping Cristina regarding GDB=2E
>
>Ping Kees regarding /proc/self/mem=2E
>
>On Tue, 2023-01-24 at 17:26 +0100, David Hildenbrand wrote:
>> > > Isn't it possible to overwrite GOT pointers using the same
>> > > vector?
>> > > So I think it's merely reflecting the status quo=2E
>> >=20
>> > There was some debate on this=2E /proc/self/mem can currently write
>> > through read-only memory which protects executable code=2E So should
>> > shadow stack get separate rules? Is ROP a worry when you can
>> > overwrite
>> > executable code?
>> >=20
>>=20
>> The question is, if there is reasonable debugging reason to keep it=2E
>> I=20
>> assume if a debugger would adjust the ordinary stack, it would have
>> to=20
>> adjust the shadow stack as well (oh my =2E=2E=2E)=2E So it sounds reaso=
nable
>> to=20
>> have it in theory at least =2E=2E=2E not sure when debugger would suppo=
rt=20
>> that, but maybe they already do=2E
>
>GDB support for shadow stack is queued up for whenever the kernel
>interface settles=2E I believe it just uses ptrace, and not this proc=2E
>But yea ptrace poke will still need to use FOLL_FORCE and be able to
>write through shadow stacks=2E

I'd prefer to avoid adding more FOLL_FORCE if we can=2E If gdb can do stac=
k manipulations through a ptrace interface then let's leave off FOLL_FORCE=
=2E

-Kees

>
>>=20
>> > The consensus seemed to lean towards not making special rules for
>> > this
>> > case, and there was some discussion that /proc/self/mem should
>> > maybe be
>> > hardened generally=2E
>>=20
>> I agree with that=2E It's a debugging mechanism that a process can
>> abuse=20
>> to do nasty stuff to its memory that it maybe shouldn't be able to do
>> =2E=2E=2E
>
>Ok=2E


--=20
Kees Cook
