Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9BA95F4AD0
	for <lists+linux-arch@lfdr.de>; Tue,  4 Oct 2022 23:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiJDVSV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Oct 2022 17:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiJDVSU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Oct 2022 17:18:20 -0400
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246BB6C132;
        Tue,  4 Oct 2022 14:18:19 -0700 (PDT)
Received: from [127.0.0.1] ([73.223.250.219])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 294LHHxZ3325613
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Tue, 4 Oct 2022 14:17:17 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 294LHHxZ3325613
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2022090501; t=1664918239;
        bh=Vx1nbJDXugclF731sRbrQEcjxkzuaubNMsHMS4URoHI=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=dhUu/6ZXMIc8FIAyThPLbVUZdO4NbsGJjuf7qLd37O59A4XZGrSm5yorV2E9jpSsD
         ozGIb8jIlXpZ1mTnhOLvB+yDI6on7HlL5oedRGNry47uWxQqaChcgTDHOUefjvnGsG
         M+SE4PnrRBLb3pnaXlYlpWQEeTa2jWr0qXoc00djv02rycW8snRivSSLrjo4OUl9+e
         jQjy5Wo/BV60tqA3PsVboSbaG8alzyA7+xGF1/fnNbzcX0UkMy1siJ/AUa+tHLQgz9
         0GkT8RyAPQA7gjUBB0NGktebfh2xRBriU3nScCtmhS0mcLpo1WkJOrrfSCgUkeOPw0
         1iHBIa3zYL0wA==
Date:   Tue, 04 Oct 2022 14:17:14 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Nathan Chancellor <nathan@kernel.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
CC:     "keescook@chromium.org" <keescook@chromium.org>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "babu.moger@amd.com" <babu.moger@amd.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
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
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "gustavoars@kernel.org" <gustavoars@kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_33/39=5D_x86/cpufeature?= =?US-ASCII?Q?s=3A_Limit_shadow_stack_to_Intel_CPUs?=
User-Agent: K-9 Mail for Android
In-Reply-To: <YzycjLUVh/WhPtKa@dev-arch.thelio-3990X>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com> <20220929222936.14584-34-rick.p.edgecombe@intel.com> <202210031656.23FAA3195@keescook> <559f937f-cab4-d408-6d95-fc85b4809aa9@intel.com> <202210032147.ED1310CEA8@keescook> <YzxViiyfMRKrmoMY@dev-arch.thelio-3990X> <ae5fea4b-8c33-c523-9d6d-3f27a9ae03d0@amd.com> <9e9396e207529af53b4755cce9d1744c0691e8b2.camel@intel.com> <YzycjLUVh/WhPtKa@dev-arch.thelio-3990X>
Message-ID: <73904829-0BAC-41BA-BFD7-025B1645F698@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On October 4, 2022 1:50:20 PM PDT, Nathan Chancellor <nathan@kernel=2Eorg> =
wrote:
>On Tue, Oct 04, 2022 at 08:34:54PM +0000, Edgecombe, Rick P wrote:
>> On Tue, 2022-10-04 at 14:43 -0500, John Allen wrote:
>> > On 10/4/22 10:47 AM, Nathan Chancellor wrote:
>> > > Hi Kees,
>> > >=20
>> > > On Mon, Oct 03, 2022 at 09:54:26PM -0700, Kees Cook wrote:
>> > > > On Mon, Oct 03, 2022 at 05:09:04PM -0700, Dave Hansen wrote:
>> > > > > On 10/3/22 16:57, Kees Cook wrote:
>> > > > > > On Thu, Sep 29, 2022 at 03:29:30PM -0700, Rick Edgecombe
>> > > > > > wrote:
>> > > > > > > Shadow stack is supported on newer AMD processors, but the
>> > > > > > > kernel
>> > > > > > > implementation has not been tested on them=2E Prevent basic
>> > > > > > > issues from
>> > > > > > > showing up for normal users by disabling shadow stack on
>> > > > > > > all CPUs except
>> > > > > > > Intel until it has been tested=2E At which point the
>> > > > > > > limitation should be
>> > > > > > > removed=2E
>> > > > > > >=20
>> > > > > > > Signed-off-by: Rick Edgecombe <rick=2Ep=2Eedgecombe@intel=
=2Ecom>
>> > > > > >=20
>> > > > > > So running the selftests on an AMD system is sufficient to
>> > > > > > drop this
>> > > > > > patch?
>> > > > >=20
>> > > > > Yes, that's enough=2E
>> > > > >=20
>> > > > > I _thought_ the AMD folks provided some tested-by's at some
>> > > > > point in the
>> > > > > past=2E  But, maybe I'm confusing this for one of the other
>> > > > > shared
>> > > > > features=2E  Either way, I'm sure no tested-by's were dropped o=
n
>> > > > > purpose=2E
>> > > > >=20
>> > > > > I'm sure Rick is eager to trim down his series and this would
>> > > > > be a great
>> > > > > patch to drop=2E  Does anyone want to make that easy for Rick?
>> > > > >=20
>> > > > > <hint> <hint>
>> > > >=20
>> > > > Hey Gustavo, Nathan, or Nick! I know y'all have some fancy AMD
>> > > > testing
>> > > > rigs=2E Got a moment to spin up this series and run the selftests=
?
>> > > > :)
>> > >=20
>> > > I do have access to a system with an EPYC 7513, which does have
>> > > Shadow
>> > > Stack support (I can see 'shstk' in the "Flags" section of lscpu
>> > > with
>> > > this series)=2E As far as I understand it, AMD only added Shadow
>> > > Stack
>> > > with Zen 3; my regular AMD test system is Zen 2 (probably should
>> > > look at
>> > > procurring a Zen 3 or Zen 4 one at some point)=2E
>> > >=20
>> > > I applied this series on top of 6=2E0 and reverted this change then
>> > > booted
>> > > it on that system=2E After building the selftest (which did require
>> > > 'make headers_install' and a small addition to make it build beyond
>> > > that, see below), I ran it and this was the result=2E I am not sure
>> > > if
>> > > that is expected or not but the other results seem promising for
>> > > dropping this patch=2E
>> > >=20
>> > >    $ =2E/test_shadow_stack_64
>> > >    [INFO]  new_ssp =3D 7f8a36c9fff8, *new_ssp =3D 7f8a36ca0001
>> > >    [INFO]  changing ssp from 7f8a374a0ff0 to 7f8a36c9fff8
>> > >    [INFO]  ssp is now 7f8a36ca0000
>> > >    [OK]    Shadow stack pivot
>> > >    [OK]    Shadow stack faults
>> > >    [INFO]  Corrupting shadow stack
>> > >    [INFO]  Generated shadow stack violation successfully
>> > >    [OK]    Shadow stack violation test
>> > >    [INFO]  Gup read -> shstk access success
>> > >    [INFO]  Gup write -> shstk access success
>> > >    [INFO]  Violation from normal write
>> > >    [INFO]  Gup read -> write access success
>> > >    [INFO]  Violation from normal write
>> > >    [INFO]  Gup write -> write access success
>> > >    [INFO]  Cow gup write -> write access success
>> > >    [OK]    Shadow gup test
>> > >    [INFO]  Violation from shstk access
>> > >    [OK]    mprotect() test
>> > >    [OK]    Userfaultfd test
>> > >    [FAIL]  Alt shadow stack test
>> >=20
>> > The selftest is looking OK on my system (Dell PowerEdge R6515 w/ EPYC
>> > 7713)=2E I also just pulled a fresh 6=2E0 kernel and applied the seri=
es
>> > including the fix Nathan mentions below=2E
>> >=20
>> > $ tools/testing/selftests/x86/test_shadow_stack_64
>> > [INFO]  new_ssp =3D 7f30cccc5ff8, *new_ssp =3D 7f30cccc6001
>> > [INFO]  changing ssp from 7f30cd4c6ff0 to 7f30cccc5ff8
>> > [INFO]  ssp is now 7f30cccc6000
>> > [OK]    Shadow stack pivot
>> > [OK]    Shadow stack faults
>> > [INFO]  Corrupting shadow stack
>> > [INFO]  Generated shadow stack violation successfully
>> > [OK]    Shadow stack violation test
>> > [INFO]  Gup read -> shstk access success
>> > [INFO]  Gup write -> shstk access success
>> > [INFO]  Violation from normal write
>> > [INFO]  Gup read -> write access success
>> > [INFO]  Violation from normal write
>> > [INFO]  Gup write -> write access success
>> > [INFO]  Cow gup write -> write access success
>> > [OK]    Shadow gup test
>> > [INFO]  Violation from shstk access
>> > [OK]    mprotect() test
>> > [OK]    Userfaultfd test
>> > [OK]    Alt shadow stack test=2E
>>=20
>> Thanks for the testing=2E Based on the test, I wonder if this could be =
a
>> SW bug=2E Nathan, could I send you a tweaked test with some more debug
>> information?
>
>Yes, more than happy to help you look into this further!
>
>> John, are we sure AMD and Intel systems behave the same with respect to
>> CPUs not creating Dirty=3D1,Write=3D0 PTEs in rare situations? Or any o=
ther
>> CET related differences we should hash out? Otherwise I'll drop the
>> patch for the next version=2E (and assuming the issue Nathan hit doesn'=
t
>> turn up anything HW related)=2E

I have to admit to being a bit confused here=2E=2E=2E in general, we trust=
 CPUID bits unless they are *known* to be wrong, in which case we blacklist=
 them=2E

If AMD advertises the feature but it doesn't work or they didn't validate =
it, that would be a (serious!) bug on their part that we can address by bla=
cklisting, but they should also fix with a microcode/BIOS patch=2E

What am I missing?
